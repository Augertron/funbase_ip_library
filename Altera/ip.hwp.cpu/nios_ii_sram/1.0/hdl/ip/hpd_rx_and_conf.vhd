-------------------------------------------------------------------------------
-- Title      : HIBI PE DMA - rx and configuration
-- Project    : 
-------------------------------------------------------------------------------
-- File       : hpd_rx_and_conf.vhd
-- Author     : kulmala3
-- Created    : 2012-01-10
-- Last update: 2012-03-02
-- Description: 
--
-- Currently there's no double-registers in config - the user
-- must take care when configuring the device. (datas can go to
-- wrong address etc, if configured while still receiving data from
-- source)
--
-- Needs 2 clock cycles to propagate the IRQ (ack->irq down-> irq req)
-------------------------------------------------------------------------------
-- Copyright (c) 2005 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 22.03.2005  1.0      AK      Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

entity hpd_rx_and_conf is

  generic (

    n_stream_chans_g : integer := 4;    -- how many streaming channels
    n_packet_chans_g : integer := 4;
    n_chans_bits_g   : integer := 2;    -- how many bits to represent n_chans
                                        -- and n_streams
                                        -- eg 2 for 4, 3 for 5, basically
                                        -- log2(n_packet_chans_g)

    data_width_g       : integer := 1;
    addr_width_g       : integer := 1;   -- the memory addr width
    hibi_addr_cmp_hi_g : integer := 1;   -- the highest bit used for comparing
    hibi_addr_cmp_lo_g : integer := 1;   -- the lowest bit
    words_width_g      : integer := 1);  -- in bits, maximum amount of data
  -- supposes that words is always in 32 bit words!
  -- (due to Nios II 32-bitness)

  port (
    clk                   : in  std_logic;
    rst_n                 : in  std_logic;
    -- avalon master (rx) if
    avalon_addr_out       : out std_logic_vector(addr_width_g-1 downto 0);
    avalon_we_out         : out std_logic;
    avalon_be_out         : out std_logic_vector(data_width_g/8-1 downto 0);
    avalon_writedata_out  : out std_logic_vector(data_width_g-1 downto 0);
    avalon_waitrequest_in : in  std_logic;
    -- hibi if
    hibi_data_in          : in  std_logic_vector(data_width_g-1 downto 0);
    hibi_av_in            : in  std_logic;
    hibi_empty_in         : in  std_logic;
    hibi_comm_in          : in  std_logic_vector(4 downto 0);
    hibi_re_out           : out std_logic;

    --avalon slave if (config)
    --conf_bits_c bits for each channel
    avalon_cfg_addr_in         : in  std_logic_vector(n_chans_bits_g+4-1 downto 0);
    avalon_cfg_writedata_in    : in  std_logic_vector(addr_width_g-1 downto 0);
    avalon_cfg_we_in           : in  std_logic;
    avalon_cfg_readdata_out    : out std_logic_vector(addr_width_g-1 downto 0);
    avalon_cfg_re_in           : in  std_logic;
    avalon_cfg_cs_in           : in  std_logic;
    avalon_cfg_waitrequest_out : out std_logic;

    rx_irq_out : out std_logic;

    -- to/from tx
    tx_start_out      : out std_logic;
    tx_comm_out       : out std_logic_vector(4 downto 0);
    tx_mem_addr_out   : out std_logic_vector(addr_width_g-1 downto 0);
    tx_hibi_addr_out  : out std_logic_vector(addr_width_g-1 downto 0);
    tx_words_out      : out std_logic_vector(words_width_g-1 downto 0);
    tx_status_done_in : in  std_logic

    );

end hpd_rx_and_conf;

architecture rtl of hpd_rx_and_conf is

  -- NOTE!! Also have to change to interface!! avalon_cfg_addr_in !!!
  constant conf_bits_c    : integer := 4;  -- number of configuration bits in
                                           -- CPU side address
  constant control_bits_c : integer := 2;  -- how many bits in ctrl reg
  constant status_bits_c  : integer := 2;  -- how many bits in ctrl reg
  constant addr_offset_c  : integer := data_width_g/8;
  constant be_width_c     : integer := data_width_g/8;

  constant total_channels_c : integer := n_stream_chans_g + n_packet_chans_g;

  constant hibi_addr_width_c : integer := addr_width_g;

  type chan_addr_array is array (total_channels_c-1 downto 0)
    of std_logic_vector(addr_width_g-1 downto 0);
  type chan_be_array is array (total_channels_c-1 downto 0)
    of std_logic_vector(be_width_c-1 downto 0);
  type chan_words_array is array (total_channels_c-1 downto 0)
    of std_logic_vector(words_width_g-1 downto 0);
  type rx_words_array is array (total_channels_c-1 downto 0)
    of std_logic_vector(words_width_g-1 downto 0);

  -- registers the CPU will set
  signal mem_addr_r     : chan_addr_array;
  signal sender_addr_r  : chan_addr_array;
  signal irq_words_r    : chan_words_array;
  signal rx_words       : rx_words_array;
  signal read_ack_r     : std_logic_vector(n_stream_chans_g-1 downto 0);
  signal control_r      : std_logic_vector(control_bits_c-1 downto 0);
  signal tx_mem_addr_r  : std_logic_vector(addr_width_g-1 downto 0);
  signal tx_hibi_addr_r : std_logic_vector(hibi_addr_width_c-1 downto 0);
  signal tx_words_r     : std_logic_vector(words_width_g-1 downto 0);
  signal tx_comm_r      : std_logic_vector(4 downto 0);

  -- cpu sets, hpd clears
  signal init_chan_r : std_logic_vector(total_channels_c-1 downto 0);

  signal irq_chan_r : std_logic_vector(total_channels_c-1 downto 0);
  signal irq_type_r : std_logic;        -- 0: rx ready, 1: unknown rx

  -- cpu can read
  -- tells where the next data is stored
  signal current_mem_addr_r : chan_addr_array;
  signal current_be_r       : chan_be_array;
  signal avalon_be          : std_logic_vector(be_width_c-1 downto 0);

  signal status_r : std_logic_vector(status_bits_c-1 downto 0);


  -- counter of how many datas gotten (irq nullifies)
  signal irq_counter_r : chan_words_array;
  signal irq_r         : std_logic;
  signal irq_given_r   : std_logic_vector(total_channels_c-1 downto 0);
  signal irq_reset_r   : std_logic;     -- irq was reseted last cycle

  signal was_high_r : std_logic;

  signal hibi_re   : std_logic;
  signal avalon_we : std_logic;

  signal unknown_rx       : std_logic;  -- high when not expecting this rx
  signal unknown_rx_irq_r : std_logic;
  signal unknown_rx_r     : std_logic;

  -- high when tx is overriding previous one
  -- (user didn't poll if previous tx is still in progress)
  signal tx_illegal        : std_logic;
  signal tx_illegal_r      : std_logic;
  signal ignore_tx_write   : std_logic;
  signal ignored_last_tx_r : std_logic;

  -- calc_chan signals
  signal avalon_addr           : std_logic_vector(addr_width_g-1 downto 0);
  signal curr_chan_avalon_we_r : std_logic;  -- 0 if no channel found

  signal avalon_wes  : std_logic_vector(total_channels_c-1 downto 0);
  signal matches     : std_logic_vector(total_channels_c-1 downto 0);
  signal matches_cmb : std_logic_vector(total_channels_c-1 downto 0);
  signal irq_ack_r   : std_logic_vector(total_channels_c-1 downto 0);

  type chan_addr_switched is array (addr_width_g-1 downto 0)
    of std_logic_vector(total_channels_c-1 downto 0);
  type chan_be_switched is array (be_width_c-1 downto 0)
    of std_logic_vector(total_channels_c-1 downto 0);

  signal avalon_addr_temp : chan_addr_switched;
  signal avalon_be_temp   : chan_be_switched;


  signal avalon_cfg_waitrequest_out_r : std_logic;
  signal avalon_cfg_waitrequest_out_s : std_logic;

  signal cfg_write : std_logic;
  signal cfg_reg   : integer range (2**conf_bits_c)-1 downto 0;

  -- high when tx conf registers (8-11) are being written
  signal cfg_tx_reg_used : std_logic;

  
begin  -- rtl


  -----------------------------------------------------------------------------
  -- Handle waitrequest for config interface
  -----------------------------------------------------------------------------

  avalon_cfg_waitrequest_out <= avalon_cfg_waitrequest_out_s;

  cfg_write <= avalon_cfg_we_in and avalon_cfg_cs_in;

  avalon_cfg_waitrequest_out_s <= ((not avalon_cfg_waitrequest_out_r)
                                   and avalon_cfg_re_in
                                   and avalon_cfg_cs_in);

  wait_p : process (clk, rst_n)
  begin  -- process wait_p
    if rst_n = '0' then                 -- asynchronous reset (active low)
      avalon_cfg_waitrequest_out_r <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      avalon_cfg_waitrequest_out_r <= avalon_cfg_waitrequest_out_s;
    end if;
  end process wait_p;

  -----------------------------------------------------------------------------
  -- Handle txs, dismiss tx if previous one is still in progress
  -----------------------------------------------------------------------------

  cfg_reg <= conv_integer(avalon_cfg_addr_in(conf_bits_c-1 downto 0));

  cfg_tx_p : process (cfg_reg)
  begin  -- process cfg_tx_p
    case cfg_reg is
      when 8 | 9 | 10 | 11 => cfg_tx_reg_used <= '1';
      when others          => cfg_tx_reg_used <= '0';
    end case;
  end process cfg_tx_p;

  tx_illegal <= (not tx_status_done_in) and cfg_tx_reg_used and cfg_write;

  tx_illegal_p : process (clk, rst_n)
  begin  -- process tx_illegal_p
    if rst_n = '0' then                 -- asynchronous reset (active low)
      tx_illegal_r <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if tx_illegal_r = '0' then
        tx_illegal_r <= tx_illegal;
      elsif tx_illegal_r = '1' and cfg_reg = 4 and cfg_tx_reg_used = '1'
        and cfg_write = '1'
      then
        tx_illegal_r <= '0';
      elsif cfg_reg = 7 and cfg_write = '1'
        and avalon_cfg_writedata_in(data_width_g-2) = '1'
      then
        tx_illegal_r <= '0';
      else
        tx_illegal_r <= '1';
      end if;
    end if;
  end process tx_illegal_p;

  ignore_tx_write <= tx_illegal or tx_illegal_r;

  -----------------------------------------------------------------------------
  -- Rest of the stuff
  -----------------------------------------------------------------------------

  avalon_we     <= hibi_empty_in nor hibi_av_in;
  avalon_we_out <= avalon_we and curr_chan_avalon_we_r;

  hibi_re <= (not avalon_waitrequest_in or hibi_av_in)  -- three first were just anded
             and (avalon_we or hibi_empty_in or hibi_av_in)
             and (curr_chan_avalon_we_r or hibi_empty_in)
             and not (unknown_rx or unknown_rx_irq_r);

  unknown_rx <= (not or_reduce(matches_cmb) and
                 (hibi_av_in and not hibi_empty_in));

  hibi_re_out          <= hibi_re and not unknown_rx;
  avalon_writedata_out <= hibi_data_in;

  avalon_addr_out <= avalon_addr;
  avalon_be_out   <= avalon_be;


  stream_channels : for i in 0 to n_stream_chans_g-1 generate
    
    rx_stream : entity work.hpd_rx_stream
      generic map (
        data_width_g      => data_width_g,
        hibi_addr_width_g => hibi_addr_width_c,
        addr_width_g      => addr_width_g,
        words_width_g     => words_width_g,
        addr_cmp_lo_g     => hibi_addr_cmp_lo_g,
        addr_cmp_hi_g     => hibi_addr_cmp_hi_g)
      port map (
        clk                => clk,
        rst_n              => rst_n,
        avalon_addr_in     => mem_addr_r(i),
        hibi_addr_in       => sender_addr_r(i),
        irq_words_in       => irq_words_r(i),
        hibi_data_in       => hibi_data_in(hibi_addr_width_c-1 downto 0),
        hibi_av_in         => hibi_av_in,
        hibi_empty_in      => hibi_empty_in,
        init_in            => init_chan_r(i),
        irq_ack_in         => irq_ack_r(i),
        avalon_waitreq_in  => avalon_waitrequest_in,
        avalon_we_in       => avalon_we,
        avalon_addr_out    => current_mem_addr_r(i),
        avalon_we_out      => avalon_wes(i),
        avalon_be_out      => current_be_r(i),
        addr_match_out     => matches(i),
        addr_match_cmb_out => matches_cmb(i),
        irq_out            => irq_chan_r(i),
        words_out          => rx_words(i),
        read_ack_in        => read_ack_r(i)
        );

  end generate stream_channels;

  packet_channels : for i in n_stream_chans_g to n_stream_chans_g + n_packet_chans_g - 1 generate
    
    rx_packet : entity work.hpd_rx_packet
      generic map (
        data_width_g      => data_width_g,
        hibi_addr_width_g => hibi_addr_width_c,
        addr_width_g      => addr_width_g,
        words_width_g     => words_width_g,
        addr_cmp_lo_g     => hibi_addr_cmp_lo_g,
        addr_cmp_hi_g     => hibi_addr_cmp_hi_g)
      port map (
        clk                => clk,
        rst_n              => rst_n,
        avalon_addr_in     => mem_addr_r(i),
        hibi_addr_in       => sender_addr_r(i),
        irq_words_in       => irq_words_r(i),
        hibi_data_in       => hibi_data_in(hibi_addr_width_c-1 downto 0),
        hibi_av_in         => hibi_av_in,
        hibi_empty_in      => hibi_empty_in,
        init_in            => init_chan_r(i),
        irq_ack_in         => irq_ack_r(i),
        avalon_waitreq_in  => avalon_waitrequest_in,
        avalon_we_in       => avalon_we,
        avalon_addr_out    => current_mem_addr_r(i),
        avalon_we_out      => avalon_wes(i),
        avalon_be_out      => current_be_r(i),
        addr_match_out     => matches(i),
        addr_match_cmb_out => matches_cmb(i),
        irq_out            => irq_chan_r(i),
        words_out          => rx_words(i)
        );

  end generate packet_channels;




  curr_chan_avalon_we_r <= or_reduce(avalon_wes and matches);


  ava_temp : for i in 0 to total_channels_c-1 generate
    j : for j in 0 to addr_width_g-1 generate
      avalon_addr_temp(j)(i) <= current_mem_addr_r(i)(j);
    end generate j;

    k : for k in 0 to be_width_c-1 generate
      avalon_be_temp(k)(i) <= current_be_r(i)(k);
    end generate k;
  end generate ava_temp;


  avalon_address : for i in 0 to addr_width_g-1 generate
    avalon_addr(i) <= or_reduce(avalon_addr_temp(i) and matches);
  end generate avalon_address;


  be : for i in 0 to be_width_c-1 generate
    avalon_be(i) <= or_reduce(avalon_be_temp(i) and matches);
  end generate be;


  cpu_side : process (clk, rst_n)
    variable legal_write : std_logic;
    variable legal_read  : std_logic;
    variable n_chan      : integer range total_channels_c-1 downto 0;
    variable n_dest      : integer range (2**conf_bits_c)-1 downto 0;
  begin  -- process cpu
    if rst_n = '0' then                 -- asynchronous reset (active low)
      for i in total_channels_c-1 downto 0 loop
        mem_addr_r(i)    <= (others => '0');
        sender_addr_r(i) <= (others => '0');
        irq_words_r(i)   <= (others => '1');
      end loop;  -- i
      avalon_cfg_readdata_out <= (others => '0');
      init_chan_r             <= (others => '0');
      control_r               <= (others => '0');
      -- status for only rx signals..
      status_r(1)             <= '0';
      tx_mem_addr_r           <= (others => '0');
      tx_comm_r               <= (others => '0');
      tx_words_r              <= (others => '0');
      rx_irq_out              <= '0';
      irq_reset_r             <= '0';
      unknown_rx_irq_r        <= '0';
      unknown_rx_r            <= '0';
      ignored_last_tx_r       <= '0';
      read_ack_r              <= (others => '0');
      
    elsif clk'event and clk = '1' then  -- rising clock edge

      read_ack_r   <= (others => '0');
      unknown_rx_r <= unknown_rx;

      if unknown_rx = '1' and unknown_rx_r = '0' then
        unknown_rx_irq_r <= '1';
      end if;


      -- set the IRQ. may be changed below if some IRQ
      -- is cleared and others are pending.
      if unknown_rx_irq_r = '1' or ignored_last_tx_r = '1' or
        (irq_chan_r /= 0 and irq_reset_r = '0') then
        -- irq ena bit...
        rx_irq_out <= control_r(1);
      end if;

      irq_reset_r <= '0';               -- default

      control_r(0) <= '0';
      -- nullifies the tx start after CPU has set it
      -- otherwise CPU can't keep up with HPD with small transfers

      irq_ack_r <= (others => '0');

      legal_write := avalon_cfg_cs_in and avalon_cfg_we_in;
      legal_read  := avalon_cfg_cs_in and avalon_cfg_re_in;
      n_chan      := conv_integer(avalon_cfg_addr_in(n_chans_bits_g+conf_bits_c-1 downto conf_bits_c));
      n_dest      := conv_integer(avalon_cfg_addr_in(conf_bits_c-1 downto 0));

      if legal_write = '1' then

        case n_dest is

          when 0 =>                     -- init channel
            init_chan_r <= avalon_cfg_writedata_in(total_channels_c-1 downto 0);
            
          when 1 =>                     -- control
            if ignore_tx_write = '0' then
              control_r <= avalon_cfg_writedata_in(control_bits_c-1 downto 0);
            end if;

            -- remember wether a tx gets lost or not
            if ignore_tx_write = '1' then
              ignored_last_tx_r <= '1';
            else
              ignored_last_tx_r <= ignored_last_tx_r;
            end if;

          when 2 =>                     -- irq status

            -- goes down so that generates an edge
            -- when many interrupts are pending.              
            rx_irq_out  <= '0';
            irq_reset_r <= '1';

            irq_ack_r <= avalon_cfg_writedata_in(total_channels_c-1 downto 0);

            if avalon_cfg_writedata_in(data_width_g-1) = '1' then
              unknown_rx_irq_r <= '0';
            end if;

            if avalon_cfg_writedata_in(data_width_g-2) = '1' then
              ignored_last_tx_r <= '0';
            end if;
            
          when 3 =>                     -- tx mem addr
            if avalon_cfg_waitrequest_out_s = '0' and ignore_tx_write = '0' then
              tx_mem_addr_r <= avalon_cfg_writedata_in;
            end if;
            
          when 4 =>                     -- tx words
            if avalon_cfg_waitrequest_out_s = '0' and ignore_tx_write = '0' then
              tx_words_r <= avalon_cfg_writedata_in(words_width_g-1 downto 0);
            end if;

          when 5 =>                     -- tx command
            if avalon_cfg_waitrequest_out_s = '0' and ignore_tx_write = '0' then
              tx_comm_r <= avalon_cfg_writedata_in(4 downto 0);
            end if;
            
          when 6 =>                     -- tx hibi addr
            if avalon_cfg_waitrequest_out_s = '0' and ignore_tx_write = '0' then
              tx_hibi_addr_r <= avalon_cfg_writedata_in;
            end if;
            
          when 8 =>                     -- mem_addr
            mem_addr_r(n_chan) <= avalon_cfg_writedata_in;
            
          when 9 =>                     -- irq_words
            irq_words_r(n_chan) <=
              avalon_cfg_writedata_in(words_width_g-1 downto 0);
            -- if channel is streaming acknowledge the read
            if (n_chan < n_stream_chans_g) then
              read_ack_r(n_chan) <= '1';
            end if;
            
          when 10 =>                     -- sender addr
            sender_addr_r(n_chan) <= avalon_cfg_writedata_in;
            

          when others =>

            -- do nothing

        end case;
      end if;


      if legal_read = '1' then
        case n_dest is
          
          when 0 =>                     -- initialize

          when 1 =>                     -- control
            avalon_cfg_readdata_out(15 downto control_bits_c) <=
              (others => '0');
            avalon_cfg_readdata_out(control_bits_c-1 downto 0)  <= control_r;
            avalon_cfg_readdata_out(31 downto status_bits_c+15) <=
              (others => '0');
            avalon_cfg_readdata_out(status_bits_c+15 downto 16) <= status_r;
            
          when 2 =>                     -- irq status
            avalon_cfg_readdata_out(addr_width_g-1) <=
              unknown_rx_irq_r;
            avalon_cfg_readdata_out(addr_width_g-2) <=
              ignored_last_tx_r;
            avalon_cfg_readdata_out(total_channels_c-1 downto 0) <=
              irq_chan_r;
            avalon_cfg_readdata_out(addr_width_g-3 downto total_channels_c) <=
              (others => '0');

          when 7 =>
            avalon_cfg_readdata_out(31 downto 0) <= hibi_data_in;
            
          when 8 =>                     -- rx mem addr
            avalon_cfg_readdata_out <= mem_addr_r(n_chan);
            
          when 9 =>                     -- rx words
            avalon_cfg_readdata_out(addr_width_g-1 downto words_width_g) <=
              (others => '0');
            avalon_cfg_readdata_out(words_width_g-1 downto 0) <=
              irq_words_r(n_chan);

          when 10 =>                     -- rx hibi addr
            avalon_cfg_readdata_out <= sender_addr_r(n_chan);
            
          when others =>
            -- do nothing;
        end case;
      end if;


      if init_chan_r /= conv_std_logic_vector(0, total_channels_c) then
        init_chan_r <= (others => '0');
      end if;

    end if;
  end process cpu_side;




-- tx signals
-- done bit, start tx 
  status_r(0)      <= tx_status_done_in;
  tx_words_out     <= tx_words_r;
  tx_mem_addr_out  <= tx_mem_addr_r;
  tx_comm_out      <= tx_comm_r;
  tx_hibi_addr_out <= tx_hibi_addr_r;

  tx_start : process (clk, rst_n)

  begin  -- process sel_tx_start
    if rst_n = '0' then                 -- asynchronous reset (active low)
      was_high_r   <= '0';
      tx_start_out <= '0';
      
    elsif clk'event and clk = '1' then  -- rising clock edge
      if control_r(0) = '1' then
        if was_high_r = '0' then
          was_high_r   <= '1';
          tx_start_out <= '1';
        else
          was_high_r   <= '1';
          tx_start_out <= '0';
        end if;
      else
        was_high_r   <= '0';
        tx_start_out <= '0';
      end if;
    end if;
  end process tx_start;

end rtl;

