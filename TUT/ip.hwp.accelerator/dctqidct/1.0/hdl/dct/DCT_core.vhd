------------------------------------------------------------------------------
-- Author        : Timo Alho
-- e-mail        : timo.a.alho@tut.fi
-- Date          : 11.08.2004 13:28:12
-- File          : DCT_core.vhd
-- Design        : VHDL Entity for dct.DCT_core.symbol
-- Generated by Mentor Graphics' HDL Designer 2003.1 (Build 399)
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY dct;
USE dct.DCT_pkg.all;
LIBRARY common_da;

ENTITY DCT_core IS
   PORT( 
      clk              : IN     std_logic;
      -- input data bus
      data_in          : IN     std_logic_vector (DCT_inputw_co-1 DOWNTO 0);
      -- output status. (set to '1' if output block is capable of receiving column/row)
      next_block_ready : IN     std_logic;
      rst_n            : IN     std_logic;
      -- write signal for input data
      wr_new_data      : IN     std_logic;
      -- DC coefficient ('1' when DC coefficient is in output bus)
      DC               : OUT    std_logic;
      -- output data bus
      data_out         : OUT    std_logic_vector (DCT_resultw_co-1 DOWNTO 0);
      -- input data status. ('1' if block is capable of receiving column/row)
      ready_for_rx     : OUT    std_logic;
      -- write signal for output data
      wr_out           : OUT    std_logic
   );

-- Declarations

END DCT_core ;

------------------------------------------------------------------------------
-- Author        : Timo Alho
-- e-mail        : timo.a.alho@tut.fi
-- Date          : 11.08.2004 13:28:13
-- File          : DCT_core.vhd
-- Design        : VHDL Architecture for dct.DCT_core.symbol
-- Generated by Mentor Graphics' HDL Designer 2003.1 (Build 399)
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY dct;
USE dct.DCT_pkg.all;
LIBRARY common_da;


ARCHITECTURE struct OF DCT_core IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL data_dct_to_shifter : std_logic_vector(8*DCT_dataw_co-1 DOWNTO 0);
   SIGNAL data_out_int        : std_logic_vector(DCT_resultw_co-1 DOWNTO 0);
   SIGNAL data_to_dct         : std_logic_vector(8*DCT_dataw_co-1 DOWNTO 0);
   SIGNAL dct_output_int      : std_logic_vector(DCT_dataw_co-1 DOWNTO 0);
   SIGNAL dct_ram_out         : std_logic_vector(DCT_dataw_co-1 DOWNTO 0);
   SIGNAL load_dct_input      : std_logic;
   SIGNAL load_dct_output     : std_logic;
   SIGNAL out_clk_en          : std_logic;
   SIGNAL rdaddr              : std_logic_vector(5 DOWNTO 0);
   SIGNAL scaled_input        : std_logic_vector(DCT_dataw_co-1 DOWNTO 0);
   SIGNAL sel_input           : std_logic;
   SIGNAL ser_input_to_dct    : std_logic_vector(DCT_dataw_co-1 DOWNTO 0);
   SIGNAL start_dct           : std_logic;
   SIGNAL stop_dct            : std_logic;
   SIGNAL we                  : std_logic;
   SIGNAL wraddr              : std_logic_vector(5 DOWNTO 0);


   -- Component Declarations
   COMPONENT Column_to_elements
   GENERIC (
      dataw_g : integer := 18
   );
   PORT (
      clk       : IN     std_logic ;
      --enable shifting:
      --if '1' one value is shifted to output
      clk_en    : IN     std_logic ;
      --parallel input (8 * (dataw_g-1 downto 0))
      column_in : IN     std_logic_vector (8*dataw_g-1 DOWNTO 0);
      --if '1' parallel input is loaded into shiftregister
      load      : IN     std_logic ;
      rst_n     : IN     std_logic ;
      --serial output
      d_out     : OUT    std_logic_vector (dataw_g-1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT DPRAM
   GENERIC (
      dataw_g : integer := 18;
      addrw_g : integer := 5
   );
   PORT (
      clk     : IN     std_logic ;
      d_in    : IN     std_logic_vector (dataw_g-1 DOWNTO 0); --input data
      rdaddr  : IN     std_logic_vector (addrw_g-1 DOWNTO 0); --read address
      we      : IN     std_logic ;                            -- write enable
      wraddr  : IN     std_logic_vector (addrw_g-1 DOWNTO 0); --write address
      ram_out : OUT    std_logic_vector (dataw_g-1 DOWNTO 0)  --output data
   );
   END COMPONENT;
   COMPONENT Elements_to_column
   GENERIC (
      dataw_g : integer := 18
   );
   PORT (
      clk        : IN     std_logic ;
      --serial input
      d_in       : IN     std_logic_vector (dataw_g-1 DOWNTO 0);
      --'1' serial input is loaded into shiftregister
      load       : IN     std_logic ;
      rst_n      : IN     std_logic ;
      --parallel output
      column_out : OUT    std_logic_vector (8*dataw_g-1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT FlipFlop
   GENERIC (
      dataw_g : INTEGER := 16
   );
   PORT (
      clk   : IN     std_logic ;
      d_in  : IN     std_logic_vector (dataw_g-1 DOWNTO 0);
      rst_n : IN     std_logic ;
      d_out : OUT    std_logic_vector (dataw_g-1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT Mux2to1
   GENERIC (
      dataw_g : integer := 16
   );
   PORT (
      in0     : IN     std_logic_vector (dataw_g-1 DOWNTO 0);
      in1     : IN     std_logic_vector (dataw_g-1 DOWNTO 0);
      sel     : IN     std_logic ;
      mux_out : OUT    std_logic_vector (dataw_g-1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT DCT1D_DA
   PORT (
      clk            : IN     std_logic ;
      dct_input_data : IN     std_logic_vector (8*DCT_dataw_co-1 DOWNTO 0);
      last_bit       : IN     std_logic ;
      rst_n          : IN     std_logic ;
      start          : IN     std_logic ;
      dct1d_out      : OUT    std_logic_vector (8*DCT_dataw_co-1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT DCT_control
   PORT (
      clk              : IN     std_logic ;
      next_block_ready : IN     std_logic ;
      rst_n            : IN     std_logic ;
      wr_new_data      : IN     std_logic ;
      DC               : OUT    std_logic ;
      load_dct_input   : OUT    std_logic ;
      load_dct_output  : OUT    std_logic ;
      out_clk_en       : OUT    std_logic ;
      rdaddr           : OUT    std_logic_vector (5 DOWNTO 0);
      ready_for_rx     : OUT    std_logic ;
      sel_input        : OUT    std_logic ;
      start_dct        : OUT    std_logic ;
      stop_dct         : OUT    std_logic ;
      we               : OUT    std_logic ;
      wr_out           : OUT    std_logic ;
      wraddr           : OUT    std_logic_vector (5 DOWNTO 0)
   );
   END COMPONENT;


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 scale_input
   -- scale_input 1
   scaled_input <= conv_std_logic_vector(signed(data_in), DCT_dataw_co);

   -- HDL Embedded Text Block 2 round_and_scale_output
   -- scale_output 2                                        
   scale_output : PROCESS(dct_output_int)
     CONSTANT scale_co : integer := DCT_dataw_co - DCT_resultw_co - 1;
     VARIABLE temp : signed(DCT_dataw_co-1 downto 0);
     VARIABLE temp2 : signed(DCT_resultw_co DOWNTO 0);
   
   BEGIN
     temp := signed(dct_output_int);
     --scale!
     temp := SHR(temp, conv_unsigned(scale_co, 4));
     temp2 := temp(DCT_resultw_co DOWNTO 0);
     --round!
     temp2 := temp2 + conv_signed(1, DCT_resultw_co+1);
   
     --result is scaled down, rounded and multiplied by 2
     data_out_int <= conv_std_logic_vector(temp2(DCT_resultw_co DOWNTO 1), DCT_resultw_co);
   END process scale_output;


   -- Instance port mappings.
   c2e : Column_to_elements
      GENERIC MAP (
         dataw_g => DCT_dataw_co
      )
      PORT MAP (
         clk       => clk,
         clk_en    => out_clk_en,
         column_in => data_dct_to_shifter,
         load      => load_dct_output,
         rst_n     => rst_n,
         d_out     => dct_output_int
      );
   tr_ram : DPRAM
      GENERIC MAP (
         dataw_g => DCT_dataw_co,
         addrw_g => 6
      )
      PORT MAP (
         clk     => clk,
         d_in    => dct_output_int,
         rdaddr  => rdaddr,
         we      => we,
         wraddr  => wraddr,
         ram_out => dct_ram_out
      );
   e2c : Elements_to_column
      GENERIC MAP (
         dataw_g => DCT_dataw_co
      )
      PORT MAP (
         clk        => clk,
         d_in       => ser_input_to_dct,
         load       => load_dct_input,
         rst_n      => rst_n,
         column_out => data_to_dct
      );
   outputreg : FlipFlop
      GENERIC MAP (
         dataw_g => DCT_resultw_co
      )
      PORT MAP (
         clk   => clk,
         d_in  => data_out_int,
         rst_n => rst_n,
         d_out => data_out
      );
   inputmux : Mux2to1
      GENERIC MAP (
         dataw_g => DCT_dataw_co
      )
      PORT MAP (
         in0     => dct_ram_out,
         in1     => scaled_input,
         sel     => sel_input,
         mux_out => ser_input_to_dct
      );
   dct_8point : DCT1D_DA
      PORT MAP (
         clk            => clk,
         dct_input_data => data_to_dct,
         last_bit       => stop_dct,
         rst_n          => rst_n,
         start          => start_dct,
         dct1d_out      => data_dct_to_shifter
      );
   control : DCT_control
      PORT MAP (
         clk              => clk,
         next_block_ready => next_block_ready,
         rst_n            => rst_n,
         wr_new_data      => wr_new_data,
         DC               => DC,
         load_dct_input   => load_dct_input,
         load_dct_output  => load_dct_output,
         out_clk_en       => out_clk_en,
         rdaddr           => rdaddr,
         ready_for_rx     => ready_for_rx,
         sel_input        => sel_input,
         start_dct        => start_dct,
         stop_dct         => stop_dct,
         we               => we,
         wr_out           => wr_out,
         wraddr           => wraddr
      );

END struct;
