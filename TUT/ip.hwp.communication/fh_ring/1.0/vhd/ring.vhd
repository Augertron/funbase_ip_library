-------------------------------------------------
-- file:        ring.vhd
-- Designer:    Jussi Nieminen, 11.02.2009,
--   		modification of Erno Salminen's Octagon
-- Description: An n-node Ring network
-- 
-- 
-- Modified :
-- 11.02.2009	Forked from the Octacon ver. 04 
-- 
--
-- 
-------------------------------------------------

-------------------------------------------------------------------------------
-- Copyright (c) 2011 Tampere University of Technology
-------------------------------------------------------------------------------
--  This file is part of Transaction Generator.
--
--  Transaction Generator is free software: you can redistribute it and/or
--  modify it under the terms of the Lesser GNU General Public License as
--  published by the Free Software Foundation, either version 3 of the License,
--  or (at your option) any later version.
--
--  Transaction Generator is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  Lesser GNU General Public License for more details.
--
--  You should have received a copy of the Lesser GNU General Public License
--  along with Transaction Generator.  If not, see
--  <http://www.gnu.org/licenses/>.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity ring is

  generic (
    nbr_of_routers_g   :     integer := 8;
    diag_en_g          :     integer := 0;
    data_width_g       :     integer := 32;
    stfwd_en_g         :     integer;
    pkt_len_g          :     integer;
    len_flit_en_g      :     integer := 0;
    oaddr_flit_en_g    :     integer := 0;
    fifo_depth_g       :     integer;
    net_freq_g         :     integer;
    ip_freq_g          :     integer
    );
  port (
    clk_net            : in  std_logic;
    clk_ip             : in  std_logic;
    rst_n              : in  std_logic;
    tx_data_in         : in  std_logic_vector( nbr_of_routers_g * data_width_g-1 downto 0 );
    tx_we_in           : in  std_logic_vector ( nbr_of_routers_g - 1 downto 0 );
    tx_empty_out       : out std_logic_vector ( nbr_of_routers_g - 1 downto 0 );
    tx_full_out        : out std_logic_vector ( nbr_of_routers_g - 1 downto 0 );

    rx_data_out  : out  std_logic_vector( nbr_of_routers_g*data_width_g-1 downto 0 );
    rx_re_in     : in  std_logic_vector (nbr_of_routers_g-1 downto 0);
    rx_empty_out : out std_logic_vector (nbr_of_routers_g-1 downto 0);
    rx_full_out  : out std_logic_vector (nbr_of_routers_g-1 downto 0)
    );

end ring;


architecture structural of ring is


  type data_arr_type is array (nbr_of_routers_g-1 downto 0) of std_logic_vector (data_width_g-1 downto 0);
  
  signal fwd_data  : data_arr_type;
  signal fwd_re    : std_logic_vector (nbr_of_routers_g-1 downto 0);
  signal fwd_empty : std_logic_vector (nbr_of_routers_g-1 downto 0);
  signal fwd_full  : std_logic_vector (nbr_of_routers_g-1 downto 0);

  signal diag_data  : data_arr_type;
  signal diag_re    : std_logic_vector (nbr_of_routers_g-1 downto 0);
  signal diag_empty : std_logic_vector (nbr_of_routers_g-1 downto 0);
  signal diag_full  : std_logic_vector (nbr_of_routers_g-1 downto 0);

  signal rev_data  : data_arr_type;
  signal rev_re    : std_logic_vector (nbr_of_routers_g-1 downto 0);
  signal rev_empty : std_logic_vector (nbr_of_routers_g-1 downto 0);
  signal rev_full  : std_logic_vector (nbr_of_routers_g-1 downto 0);

  signal tx_data_dbg        : data_arr_type;
  signal rx_data_arr        : data_arr_type;

  component  ring_router

    generic (
      nbr_of_routers_g   :    integer := 8;
      data_width_g       :    integer := 0;
      dateline_en_g      :    integer := 0;
      stfwd_en_g         :    integer;
      pkt_len_g          :    integer;
      len_flit_en_g      :    integer := 0;
      oaddr_flit_en_g    :    integer := 0;
      fifo_depth_g       :    integer;
      router_id_g        :    integer := 0;
      diag_en_g          :    integer := 1;
      net_freq_g         :    integer;
      ip_freq_g          :    integer
      );
    port (
      clk_net            : in std_logic;
      clk_ip             : in std_logic;
      rst_n              : in std_logic;

      data_fwd_in  : in  std_logic_vector ( data_width_g-1 downto 0);
      re_fwd_out   : out std_logic;
      empty_fwd_in : in  std_logic;
      full_fwd_in  : in  std_logic;

      data_rev_in  : in  std_logic_vector ( data_width_g-1 downto 0);
      re_rev_out   : out std_logic;
      empty_rev_in : in  std_logic;
      full_rev_in  : in  std_logic;

      data_diag_in  : in  std_logic_vector ( data_width_g-1 downto 0);
      re_diag_out   : out std_logic;
      empty_diag_in : in  std_logic;
      full_diag_in  : in  std_logic;

      data_ip_tx_in   : in  std_logic_vector ( data_width_g-1 downto 0);
      we_ip_tx_in     : in  std_logic;
      empty_ip_tx_out : out std_logic;
      full_ip_tx_out  : out std_logic;

      data_fwd_out  : out std_logic_vector ( data_width_g-1 downto 0);
      re_fwd_in     : in  std_logic;
      empty_fwd_out : out std_logic;
      full_fwd_out  : out std_logic;

      data_rev_out  : out std_logic_vector ( data_width_g-1 downto 0);
      re_rev_in     : in  std_logic;
      empty_rev_out : out std_logic;
      full_rev_out  : out std_logic;

      data_diag_out  : out std_logic_vector ( data_width_g-1 downto 0);
      re_diag_in     : in  std_logic;
      empty_diag_out : out std_logic;
      full_diag_out  : out std_logic;

      data_ip_rx_out  : out std_logic_vector ( data_width_g-1 downto 0);
      re_ip_rx_in     : in  std_logic;
      full_ip_rx_out  : out std_logic;
      empty_ip_rx_out : out std_logic
      );

  end component; --ring_router;
  
begin  -- structural

  map_dbg_arr : for i in 0 to nbr_of_routers_g-1 generate
    tx_data_dbg (i)        <= tx_data_in ((i+1)*data_width_g-1 downto i*data_width_g);

    rx_data_out ((i+1)*data_width_g-1 downto i*data_width_g)        <= rx_data_arr (i);

    
  end generate map_dbg_arr;
  

  -- data defines which index is used
  -- r  port         signal
  -- ---------------------
  -- 0: data_out  => data(0)
  -- 0: re_in     => re(0)
  -- 0: empty_out => empty(0)
  -- 1: data_in   => data(0)
  -- 1: re_out    => re(0)
  -- 1: empty_in  => empty(0)
  
  map_routers : for r in 1 to nbr_of_routers_g-1 generate
    router    : ring_router
      generic map (
        nbr_of_routers_g   => nbr_of_routers_g,
        data_width_g       => data_width_g,
        dateline_en_g      => 0,
        stfwd_en_g         => stfwd_en_g,
        pkt_len_g          => pkt_len_g,
        len_flit_en_g      => len_flit_en_g,
        oaddr_flit_en_g    => oaddr_flit_en_g,
        fifo_depth_g       => fifo_depth_g,
        router_id_g        => r,
        diag_en_g          => diag_en_g,
        net_freq_g         => net_freq_g,
        ip_freq_g          => ip_freq_g
        )
      port map (
        clk_net            => clk_net,
        clk_ip             => clk_ip,
        rst_n              => rst_n,

        data_ip_tx_in   => tx_data_in   ( (r+1)*data_width_g-1 downto r*data_width_g ),
        we_ip_tx_in     => tx_we_in     (r),
        full_ip_tx_out  => tx_full_out  (r),
        empty_ip_tx_out => tx_empty_out (r),

        data_fwd_in  => fwd_data  (r-1),
        re_fwd_out   => fwd_re    (r-1),
        empty_fwd_in => fwd_empty (r-1),
        full_fwd_in  => fwd_full  (r-1),

        data_fwd_out  => fwd_data  (r),
        re_fwd_in     => fwd_re    (r), 
        empty_fwd_out => fwd_empty (r),
        full_fwd_out  => fwd_full  (r),

        data_rev_in  => rev_data  ( (r+1) mod nbr_of_routers_g ),
        re_rev_out   => rev_re    ( (r+1) mod nbr_of_routers_g ),
        empty_rev_in => rev_empty ( (r+1) mod nbr_of_routers_g ),
        full_rev_in  => rev_full  ( (r+1) mod nbr_of_routers_g ),

        data_rev_out  => rev_data  (r),
        re_rev_in     => rev_re    (r), 
        empty_rev_out => rev_empty (r),
        full_rev_out  => rev_full  (r),

        --FIXME, this only works with rings of size 2*k, k E N
        data_diag_in  => diag_data  (( r - nbr_of_routers_g / 2 ) mod nbr_of_routers_g),
        re_diag_out   => diag_re    (( r - nbr_of_routers_g / 2 ) mod nbr_of_routers_g),
        empty_diag_in => diag_empty (( r - nbr_of_routers_g / 2 ) mod nbr_of_routers_g),
        full_diag_in  => diag_full  (( r - nbr_of_routers_g / 2 ) mod nbr_of_routers_g),

        data_diag_out  => diag_data  (r),
        re_diag_in     => diag_re    (r),
        empty_diag_out => diag_empty (r),
        full_diag_out  => diag_full  (r),
        
        data_ip_rx_out  => rx_data_arr (r),
        re_ip_rx_in     => rx_re_in     (r),
        full_ip_rx_out  => rx_full_out  (r),
        empty_ip_rx_out => rx_empty_out (r)
        );

  end generate map_routers;
  

  first_router : ring_router
      generic map (
        nbr_of_routers_g   => nbr_of_routers_g,
        data_width_g       => data_width_g,
        dateline_en_g      => 1,
        pkt_len_g          => pkt_len_g,
        len_flit_en_g      => len_flit_en_g,
        oaddr_flit_en_g    => oaddr_flit_en_g,
        stfwd_en_g         => stfwd_en_g,
        fifo_depth_g       => fifo_depth_g,
        router_id_g        => 0,
        diag_en_g          => diag_en_g,
        net_freq_g         => net_freq_g,
        ip_freq_g          => ip_freq_g
        )
      port map (
        clk_net            => clk_net,
        clk_ip             => clk_ip,
        rst_n              => rst_n,

        data_ip_tx_in   => tx_data_in   ( data_width_g-1 downto 0 ),
        we_ip_tx_in     => tx_we_in     (0),
        full_ip_tx_out  => tx_full_out  (0),
        empty_ip_tx_out => tx_empty_out (0),

        data_fwd_in  => fwd_data  ( nbr_of_routers_g - 1 ),
        re_fwd_out   => fwd_re    ( nbr_of_routers_g - 1 ), 
        empty_fwd_in => fwd_empty ( nbr_of_routers_g - 1 ),
        full_fwd_in  => fwd_full  ( nbr_of_routers_g - 1 ),

        data_fwd_out  => fwd_data  (0),
        re_fwd_in     => fwd_re    (0),
        empty_fwd_out => fwd_empty (0),
        full_fwd_out  => fwd_full  (0),

        data_rev_in  => rev_data  (1),
        re_rev_out   => rev_re    (1), 
        empty_rev_in => rev_empty (1),
        full_rev_in  => rev_full  (1),

        data_rev_out  => rev_data  (0),
        re_rev_in     => rev_re    (0),
        empty_rev_out => rev_empty (0),
        full_rev_out  => rev_full  (0),

        data_diag_in  => diag_data  ( nbr_of_routers_g / 2 ),
        re_diag_out   => diag_re    ( nbr_of_routers_g / 2 ),
        empty_diag_in => diag_empty ( nbr_of_routers_g / 2 ),
        full_diag_in  => diag_full  ( nbr_of_routers_g / 2 ),

        data_diag_out  => diag_data  (0),
        re_diag_in     => diag_re    (0),
        empty_diag_out => diag_empty (0),
        full_diag_out  => diag_full  (0),

        
        data_ip_rx_out  => rx_data_arr (0),
        re_ip_rx_in     => rx_re_in     (0),
        full_ip_rx_out  => rx_full_out  (0),
        empty_ip_rx_out => rx_empty_out (0)
        );
  

end structural;
