------------------------------------------------------------------------------
-- Author        : Timo Alho
-- e-mail        : timo.a.alho@tut.fi
-- Date          : 11.08.2004 13:28:17
-- File          : dctQidct_core.vhd
-- Design        : VHDL Entity for dctQidct.dctQidct_core.symbol
-- Generated by Mentor Graphics' HDL Designer 2003.1 (Build 399)
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY dct;
USE dct.DCT_pkg.all;
LIBRARY idct;
USE idct.IDCT_pkg.all;
LIBRARY quantizer;
USE quantizer.Quantizer_pkg.all;
LIBRARY common_da;

ENTITY dctQidct_core IS
   PORT( 
      QP_in                 : IN     std_logic_vector (4 DOWNTO 0);
      chroma_in             : IN     std_logic;
      clk                   : IN     std_logic;
      -- input data bus
      data_dct_in           : IN     std_logic_vector (DCT_inputw_co-1 DOWNTO 0);
      -- idct output status (set to '1', if next block is cabaple of receiving column/row)
      idct_ready4column_in  : IN     std_logic;
      intra_in              : IN     std_logic;
      loadQP_in             : IN     std_logic;
      -- quantizer output status (set to '1', if next block is cabaple of receiving column/row)
      quant_ready4column_in : IN     std_logic;
      rst_n                 : IN     std_logic;
      -- write signal for input data
      wr_dct_in             : IN     std_logic;
      -- output data bus (idct)
      data_idct_out         : OUT    std_logic_vector (IDCT_resultw_co-1 DOWNTO 0);
      -- output data bus (quantizer)
      data_quant_out        : OUT    std_logic_vector (QUANT_resultw_co-1 DOWNTO 0);
      -- input status ('1' if block is capable of receiving column/row)
      dct_ready4column_out  : OUT    std_logic;
      -- write signal for output data (idct)
      wr_idct_out           : OUT    std_logic;
      -- write signal for output data (quantizer)
      wr_quant_out          : OUT    std_logic
   );

-- Declarations

END dctQidct_core ;

------------------------------------------------------------------------------
-- Author        : Timo Alho
-- e-mail        : timo.a.alho@tut.fi
-- Date          : 11.08.2004 13:28:18
-- File          : dctQidct_core.vhd
-- Design        : VHDL Architecture for dctQidct.dctQidct_core.symbol
-- Generated by Mentor Graphics' HDL Designer 2003.1 (Build 399)
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY dct;
USE dct.DCT_pkg.all;
LIBRARY idct;
USE idct.IDCT_pkg.all;
LIBRARY quantizer;
USE quantizer.Quantizer_pkg.all;
LIBRARY common_da;


ARCHITECTURE struct OF dctQidct_core IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL DC_dct_to_quant        : std_logic;
   SIGNAL buffer_ready           : std_logic;
   SIGNAL data_dct_to_quant      : std_logic_vector(DCT_resultw_co-1 DOWNTO 0);
   SIGNAL data_fifo_to_idct      : std_logic_vector(IDCT_inputw_co-1 DOWNTO 0);
   SIGNAL data_quant_to_idctfifo : std_logic_vector(IQUANT_resultw_co-1 DOWNTO 0);
   SIGNAL ready_idct_to_fifo     : std_logic;
   SIGNAL ready_to_dct           : std_logic;
   SIGNAL wr_dct_to_quant        : std_logic;
   SIGNAL wr_fifo_to_idct        : std_logic;
   SIGNAL wr_quant_to_idctfifo   : std_logic;


   -- Component Declarations
   COMPONENT DCT_core
   PORT (
      clk              : IN     std_logic ;
      -- input data bus
      data_in          : IN     std_logic_vector (DCT_inputw_co-1 DOWNTO 0);
      -- output status. (set to '1' if output block is capable of receiving column/row)
      next_block_ready : IN     std_logic ;
      rst_n            : IN     std_logic ;
      -- write signal for input data
      wr_new_data      : IN     std_logic ;
      -- DC coefficient ('1' when DC coefficient is in output bus)
      DC               : OUT    std_logic ;
      -- output data bus
      data_out         : OUT    std_logic_vector (DCT_resultw_co-1 DOWNTO 0);
      -- input data status. ('1' if block is capable of receiving column/row)
      ready_for_rx     : OUT    std_logic ;
      -- write signal for output data
      wr_out           : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT IDCT_fifo
   GENERIC (
      dataw_g      : integer := 0;
      fifo_depth_g : integer := 0
   );
   PORT (
      clk              : IN     std_logic ;
      rst_n            : IN     std_logic ;
      -- input data bus
      data_in          : IN     std_logic_vector (dataw_g-1 DOWNTO 0);
      -- input status ('1' if block is capable of receiving 8 datawords)
      ready8           : OUT    std_logic ;
      -- write signal for input data
      wr_in            : IN     std_logic ;
      -- output data bus
      data_out         : OUT    std_logic_vector (dataw_g-1 DOWNTO 0);
      -- output status (set to '1', if next block is capable of receiving 8 datawords)
      next_block_ready : IN     std_logic ;
      -- write signal for output data
      wr_out           : OUT    std_logic 
   );
   END COMPONENT;
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
   COMPONENT IQuant
   GENERIC (
      qmulw_g : integer := 16
   );
   PORT (
      clk       : IN     std_logic ;
      rst_n     : IN     std_logic ;
      --'1' if input data is to be quantized
      --as DC -coefficient
      dc        : IN     std_logic ;
      --when active, loads new QP+intra+chroma into quantizer
      loadQP    : IN     std_logic ;
      --as intra -coefficient
      intra     : IN     std_logic ;
      --'1' if input data is to be quantized as a chrominance block
      chroma    : IN     std_logic ;
      -- Quantizer parameter
      qp        : IN     std_logic_vector (4 DOWNTO 0);
      --write in
      wr_in     : IN     std_logic ;
      --input coefficient
      coeff_in  : IN     std_logic_vector (QUANT_inputw_co-1 DOWNTO 0);
      --quantized coefficient
      rcoeff    : OUT    std_logic_vector (IQUANT_resultw_co-1 DOWNTO 0);
      --inverse quantized coefficient
      qcoeff    : OUT    std_logic_vector (QUANT_resultw_co-1 DOWNTO 0);
      --quantized coefficient write out
      q_wr_out  : OUT    std_logic ;
      --inverse quantized coefficient write out
      iq_wr_out : OUT    std_logic 
   );
   END COMPONENT;


BEGIN

   -- ModuleWare code(v1.0) for instance 'I5' of 'and'
   ready_to_dct <= quant_ready4column_in AND buffer_ready;

   -- Instance port mappings.
   dct : DCT_core
      PORT MAP (
         clk              => clk,
         data_in          => data_dct_in,
         next_block_ready => ready_to_dct,
         rst_n            => rst_n,
         wr_new_data      => wr_dct_in,
         DC               => DC_dct_to_quant,
         data_out         => data_dct_to_quant,
         ready_for_rx     => dct_ready4column_out,
         wr_out           => wr_dct_to_quant
      );
   idct_input_fifo : IDCT_fifo
      GENERIC MAP (
         dataw_g      => IDCT_inputw_co,
         fifo_depth_g => 5
      )
      PORT MAP (
         clk              => clk,
         data_in          => data_quant_to_idctfifo,
         next_block_ready => ready_idct_to_fifo,
         rst_n            => rst_n,
         wr_in            => wr_quant_to_idctfifo,
         data_out         => data_fifo_to_idct,
         ready8           => buffer_ready,
         wr_out           => wr_fifo_to_idct
      );
   idct : IDCT_core
      PORT MAP (
         clk              => clk,
         data_in          => data_fifo_to_idct,
         next_block_ready => idct_ready4column_in,
         rst_n            => rst_n,
         wr_new_data      => wr_fifo_to_idct,
         data_out         => data_idct_out,
         ready_for_rx     => ready_idct_to_fifo,
         wr_out           => wr_idct_out
      );
   quantizer : IQuant
      GENERIC MAP (
         qmulw_g => 16
      )
      PORT MAP (
         clk       => clk,
         rst_n     => rst_n,
         dc        => DC_dct_to_quant,
         loadQP    => loadQP_in,
         intra     => intra_in,
         chroma    => chroma_in,
         qp        => QP_in,
         wr_in     => wr_dct_to_quant,
         coeff_in  => data_dct_to_quant,
         rcoeff    => data_quant_to_idctfifo,
         qcoeff    => data_quant_out,
         q_wr_out  => wr_quant_out,
         iq_wr_out => wr_quant_to_idctfifo
      );

END struct;