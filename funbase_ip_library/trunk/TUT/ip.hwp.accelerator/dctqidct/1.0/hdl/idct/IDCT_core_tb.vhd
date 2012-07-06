------------------------------------------------------------------------------
-- Author        : Timo Alho
-- e-mail        : timo.a.alho@tut.fi
-- Date          : 11.08.2004 13:20:37
-- File          : IDCT_core_tb.vhd
-- Design        : VHDL Entity for idct.IDCT_core_tb.symbol
-- Generated by Mentor Graphics' HDL Designer 2003.1 (Build 399)
------------------------------------------------------------------------------


ENTITY IDCT_core_tb IS
-- Declarations

END IDCT_core_tb ;

------------------------------------------------------------------------------
-- Author        : Timo Alho
-- e-mail        : timo.a.alho@tut.fi
-- Date          : 11.08.2004 13:20:38
-- File          : IDCT_core_tb.vhd
-- Design        : VHDL Architecture for idct.IDCT_core_tb.symbol
-- Generated by Mentor Graphics' HDL Designer 2003.1 (Build 399)
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
LIBRARY idct;
USE idct.IDCT_pkg.all;


ARCHITECTURE struct OF IDCT_core_tb IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL clk              : std_logic;
   SIGNAL data_in          : std_logic_vector(IDCT_inputw_co-1 DOWNTO 0);
   SIGNAL data_out         : std_logic_vector(IDCT_resultw_co-1 DOWNTO 0);
   SIGNAL next_block_ready : std_logic;
   SIGNAL ready_for_rx     : std_logic;
   SIGNAL rst_n            : std_logic;
   SIGNAL wr_new_data      : std_logic;
   SIGNAL wr_out           : std_logic;


   -- Component Declarations
   COMPONENT IDCT_core
   PORT (
      clk              : IN     std_logic ;
      rst_n            : IN     std_logic ;
      -- input data bus
      data_in          : IN     std_logic_vector (IDCT_inputw_co-1 DOWNTO 0);
      -- input status ('1' if block is capable of receiving column/row)
      ready_for_rx     : OUT    std_logic ;
      -- write signal for input data
      wr_new_data      : IN     std_logic ;
      -- output data bus
      data_out         : OUT    std_logic_vector (IDCT_resultw_co-1 DOWNTO 0);
      -- output status (set to '1', if next block is cabaple of receiving column/row)
      next_block_ready : IN     std_logic ;
      -- write signal for output data
      wr_out           : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT IDCT_core_tester
   PORT (
      data_out         : IN     std_logic_vector (IDCT_resultw_co-1 DOWNTO 0);
      ready_for_rx     : IN     std_logic ;
      wr_out           : IN     std_logic ;
      clk              : OUT    std_logic ;
      data_in          : OUT    std_logic_vector (IDCT_inputw_co-1 DOWNTO 0);
      next_block_ready : OUT    std_logic ;
      rst_n            : OUT    std_logic ;
      wr_new_data      : OUT    std_logic 
   );
   END COMPONENT;


BEGIN

   -- Instance port mappings.
   DUT : IDCT_core
      PORT MAP (
         clk              => clk,
         data_in          => data_in,
         next_block_ready => next_block_ready,
         rst_n            => rst_n,
         wr_new_data      => wr_new_data,
         data_out         => data_out,
         ready_for_rx     => ready_for_rx,
         wr_out           => wr_out
      );
   tester : IDCT_core_tester
      PORT MAP (
         data_out         => data_out,
         ready_for_rx     => ready_for_rx,
         wr_out           => wr_out,
         clk              => clk,
         data_in          => data_in,
         next_block_ready => next_block_ready,
         rst_n            => rst_n,
         wr_new_data      => wr_new_data
      );

END struct;
