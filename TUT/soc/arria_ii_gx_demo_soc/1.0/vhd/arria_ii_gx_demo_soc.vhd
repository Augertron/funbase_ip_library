-- ****************************************************
-- ** File: arria_ii_gx_demo_soc.vhd
-- ** Date: 09.11.2011 10:33:18
-- ** Description: 
-- **
-- ** This file was generated by Kactus2 vhdl generator
-- **
-- ****************************************************

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

library picture_manip;
use picture_manip.all;
library pciture_manip;
use pciture_manip.all;
library hibi_mem_dma;
use hibi_mem_dma.all;
library alt_ddr2_a2;
use alt_ddr2_a2.all;
library pcie_to_hibi_4x;
use pcie_to_hibi_4x.all;
library hibi;
use hibi.all;

entity arria_ii_gx_demo_soc is

	port (
		clkin_bot_p : in std_logic;
		mem_addr : out std_logic_vector(13 downto 0);
		mem_ba : out std_logic_vector(2 downto 0);
		mem_cas_n : out std_logic;
		mem_cke : out std_logic;
		mem_clk : inout std_logic_vector(1 downto 0);
		mem_clk_n : inout std_logic_vector(1 downto 0);
		mem_cs_n : out std_logic;
		mem_dm : out std_logic_vector(7 downto 0);
		mem_dq : inout std_logic_vector(63 downto 0);
		mem_dqs : inout std_logic_vector(7 downto 0);
		mem_dqsn : inout std_logic_vector(7 downto 0);
		mem_odt : out std_logic;
		mem_ras_n : out std_logic;
		mem_we_n : out std_logic;
		pcie_refclk_p : in std_logic;
		pcie_rx_p : in std_logic_vector(3 downto 0);
		pcie_tx_p : out std_logic_vector(3 downto 0);
		soft_reset_n : in std_logic;
		user_pb_0 : in std_logic);

end arria_ii_gx_demo_soc;

architecture structural of arria_ii_gx_demo_soc is

	signal a2_ddr2_dimm_1GB_1_local_address_hibi_mem_dma_1_mem_addr_out : std_logic_vector(24 downto 0);
	signal a2_ddr2_dimm_1GB_1_local_be_hibi_mem_dma_1_mem_be_out : std_logic_vector(3 downto 0);
	signal a2_ddr2_dimm_1GB_1_local_burstbegin_hibi_mem_dma_1_mem_burst_begin_out : std_logic;
	signal a2_ddr2_dimm_1GB_1_local_init_done_hibi_mem_dma_1_mem_init_done_in : std_logic;
	signal a2_ddr2_dimm_1GB_1_local_rdata_hibi_mem_dma_1_mem_rdata_in : std_logic_vector(31 downto 0);
	signal a2_ddr2_dimm_1GB_1_local_rdata_valid_hibi_mem_dma_1_mem_rdata_valid_in : std_logic;
	signal a2_ddr2_dimm_1GB_1_local_read_req_hibi_mem_dma_1_mem_rd_req_out : std_logic;
	signal a2_ddr2_dimm_1GB_1_local_ready_hibi_mem_dma_1_mem_ready_in : std_logic;
	signal a2_ddr2_dimm_1GB_1_local_size_hibi_mem_dma_1_mem_burst_size_out : std_logic_vector(2 downto 0);
	signal a2_ddr2_dimm_1GB_1_local_wdata_hibi_mem_dma_1_mem_wdata_out : std_logic_vector(31 downto 0);
	signal a2_ddr2_dimm_1GB_1_local_write_req_hibi_mem_dma_1_mem_wr_req_out : std_logic;
	signal a2_ddr2_dimm_1GB_1_phy_clk_picture_manip_1_sys_iClk : std_logic;
	signal hibi_segment_small_1_agent_addr_out_17_hibi_mem_dma_1_hibi_addr_in : std_logic_vector(31 downto 0);
	signal hibi_segment_small_1_agent_addr_in_17_hibi_mem_dma_1_hibi_addr_out : std_logic_vector(31 downto 0);
	signal hibi_segment_small_1_agent_comm_out_17_hibi_mem_dma_1_hibi_comm_in : std_logic_vector(2 downto 0);
	signal hibi_segment_small_1_agent_comm_in_17_hibi_mem_dma_1_hibi_comm_out : std_logic_vector(2 downto 0);
	signal hibi_segment_small_1_agent_data_out_17_hibi_mem_dma_1_hibi_data_in : std_logic_vector(31 downto 0);
	signal hibi_segment_small_1_agent_data_in_17_hibi_mem_dma_1_hibi_data_out : std_logic_vector(31 downto 0);
	signal hibi_segment_small_1_agent_empty_out_17_hibi_mem_dma_1_hibi_empty_in : std_logic;
	signal hibi_segment_small_1_agent_full_out_17_hibi_mem_dma_1_hibi_full_in : std_logic;
	signal hibi_segment_small_1_agent_msg_addr_in_17_hibi_mem_dma_1_hibi_msg_addr_out : std_logic_vector(31 downto 0);
	signal hibi_segment_small_1_agent_msg_comm_out_17_hibi_mem_dma_1_hibi_msg_comm_in : std_logic_vector(2 downto 0);
	signal hibi_segment_small_1_agent_msg_comm_in_17_hibi_mem_dma_1_hibi_msg_comm_out : std_logic_vector(2 downto 0);
	signal hibi_segment_small_1_agent_msg_data_out_17_hibi_mem_dma_1_hibi_msg_data_in : std_logic_vector(31 downto 0);
	signal hibi_segment_small_1_agent_msg_data_in_17_hibi_mem_dma_1_hibi_msg_data_out : std_logic_vector(31 downto 0);
	signal hibi_segment_small_1_agent_msg_empty_out_17_hibi_mem_dma_1_hibi_msg_empty_in : std_logic;
	signal hibi_segment_small_1_agent_msg_full_out_17_hibi_mem_dma_1_hibi_msg_full_in : std_logic;
	signal hibi_segment_small_1_agent_msg_re_in_17_hibi_mem_dma_1_hibi_msg_re_out : std_logic;
	signal hibi_segment_small_1_agent_msg_we_in_17_hibi_mem_dma_1_hibi_msg_we_out : std_logic;
	signal hibi_segment_small_1_agent_re_in_17_hibi_mem_dma_1_hibi_re_out : std_logic;
	signal hibi_segment_small_1_agent_we_in_17_hibi_mem_dma_1_hibi_we_out : std_logic;
	signal hibi_segment_small_1_agent_av_in_1_pcie_to_hibi_4x_1_hibi_av_out : std_logic;
	signal hibi_segment_small_1_agent_av_in_2_picture_manip_1_hibi_oAv : std_logic;
	signal hibi_segment_small_1_agent_av_out_1_pcie_to_hibi_4x_1_hibi_av_in : std_logic;
	signal hibi_segment_small_1_agent_av_out_2_picture_manip_1_hibi_iAv : std_logic;
	signal hibi_segment_small_1_agent_comm_in_1_pcie_to_hibi_4x_1_hibi_comm_out : std_logic_vector(2 downto 0);
	signal hibi_segment_small_1_agent_comm_in_2_picture_manip_1_hibi_oComm : std_logic_vector(2 downto 0);
	signal hibi_segment_small_1_agent_comm_out_1_pcie_to_hibi_4x_1_hibi_comm_in : std_logic_vector(2 downto 0);
	signal hibi_segment_small_1_agent_comm_out_2_picture_manip_1_hibi_iComm : std_logic_vector(2 downto 0);
	signal hibi_segment_small_1_agent_data_in_1_pcie_to_hibi_4x_1_hibi_data_out : std_logic_vector(31 downto 0);
	signal hibi_segment_small_1_agent_data_in_2_picture_manip_1_hibi_oData : std_logic_vector(31 downto 0);
	signal hibi_segment_small_1_agent_data_out_1_pcie_to_hibi_4x_1_hibi_data_in : std_logic_vector(31 downto 0);
	signal hibi_segment_small_1_agent_data_out_2_picture_manip_1_hibi_iData : std_logic_vector(31 downto 0);
	signal hibi_segment_small_1_agent_empty_out_1_pcie_to_hibi_4x_1_hibi_empty_in : std_logic;
	signal hibi_segment_small_1_agent_empty_out_2_picture_manip_1_hibi_iEmpty : std_logic;
	signal hibi_segment_small_1_agent_full_out_1_pcie_to_hibi_4x_1_hibi_full_in : std_logic;
	signal hibi_segment_small_1_agent_full_out_2_picture_manip_1_hibi_iFull : std_logic;
	signal hibi_segment_small_1_agent_one_d_out_1_pcie_to_hibi_4x_1_hibi_one_d_in : std_logic;
	signal hibi_segment_small_1_agent_one_d_out_2_picture_manip_1_hibi_iOne_d_left : std_logic;
	signal hibi_segment_small_1_agent_one_p_out_1_pcie_to_hibi_4x_1_hibi_one_p_in : std_logic;
	signal hibi_segment_small_1_agent_one_p_out_2_picture_manip_1_hibi_iOne_p_left : std_logic;
	signal hibi_segment_small_1_agent_re_in_1_pcie_to_hibi_4x_1_hibi_re_out : std_logic;
	signal hibi_segment_small_1_agent_re_in_2_picture_manip_1_hibi_Ore : std_logic;
	signal hibi_segment_small_1_agent_we_in_1_pcie_to_hibi_4x_1_hibi_we_out : std_logic;
	signal hibi_segment_small_1_agent_we_in_2_picture_manip_1_hibi_oWe : std_logic;

	-- Altera ddr2 memory controller
	component a2_ddr2_dimm_1GB
		port (
			global_reset_n : in std_logic;
			local_address : in std_logic_vector(24 downto 0);
			local_be : in std_logic_vector(31 downto 0);
			local_burstbegin : in std_logic;
			local_init_done : out std_logic;
			local_rdata : out std_logic_vector(255 downto 0);
			local_rdata_valid : out std_logic;
			local_read_req : in std_logic;
			local_ready : out std_logic;
			local_size : in std_logic_vector(2 downto 0);
			local_wdata : in std_logic_vector(255 downto 0);
			local_write_req : in std_logic;
			mem_addr : out std_logic_vector(13 downto 0);
			mem_ba : out std_logic_vector(2 downto 0);
			mem_cas_n : out std_logic;
			mem_cke : out std_logic;
			mem_clk : inout std_logic_vector(1 downto 0);
			mem_clk_n : inout std_logic_vector(1 downto 0);
			mem_cs_n : out std_logic;
			mem_dm : out std_logic_vector(7 downto 0);
			mem_dq : inout std_logic_vector(63 downto 0);
			mem_dqs : inout std_logic_vector(7 downto 0);
			mem_dqsn : inout std_logic_vector(7 downto 0);
			mem_odt : out std_logic;
			mem_ras_n : out std_logic;
			mem_we_n : out std_logic;
			phy_clk : out std_logic;
			pll_ref_clk : in std_logic;
			soft_reset_n : in std_logic);
	end component;

	-- HIBI memory DMA access IP.
	component hibi_mem_dma
		generic (
			BURST_SIZE_WIDTH : integer := 1;
			HIBI_COM_WIDTH : integer := 3;
			HIBI_DATA_WIDTH : integer := 32;
			MEM_ADDR_WIDTH : integer := 22;
			MEM_BE_WIDTH : integer := 4;
			MEM_DATA_WIDTH : integer := 32);
		port (
			clk : in std_logic;
			hibi_addr_in : in std_logic_vector(31 downto 0);
			hibi_addr_out : out std_logic_vector(31 downto 0);
			hibi_comm_in : in std_logic_vector(2 downto 0);
			hibi_comm_out : out std_logic_vector(2 downto 0);
			hibi_data_in : in std_logic_vector(31 downto 0);
			hibi_data_out : out std_logic_vector(31 downto 0);
			hibi_empty_in : in std_logic;
			hibi_full_in : in std_logic;
			hibi_msg_addr_out : out std_logic_vector(31 downto 0);
			hibi_msg_comm_in : in std_logic_vector(2 downto 0);
			hibi_msg_comm_out : out std_logic_vector(2 downto 0);
			hibi_msg_data_in : in std_logic_vector(31 downto 0);
			hibi_msg_data_out : out std_logic_vector(31 downto 0);
			hibi_msg_empty_in : in std_logic;
			hibi_msg_full_in : in std_logic;
			hibi_msg_re_out : out std_logic;
			hibi_msg_we_out : out std_logic;
			hibi_re_out : out std_logic;
			hibi_we_out : out std_logic;
			mem_addr_out : out std_logic_vector(24 downto 0);
			mem_be_out : out std_logic_vector(3 downto 0);
			mem_burst_begin_out : out std_logic;
			mem_burst_size_out : out std_logic_vector(2 downto 0);
			mem_init_done_in : in std_logic;
			mem_rd_req_out : out std_logic;
			mem_rdata_in : in std_logic_vector(31 downto 0);
			mem_rdata_valid_in : in std_logic;
			mem_ready_in : in std_logic;
			mem_wdata_out : out std_logic_vector(31 downto 0);
			mem_wr_req_out : out std_logic;
			rst_n : in std_logic);
	end component;

	-- HIBI segment block including two r4_wrapper and one r3_wrapper interfaces.
	component hibi_segment_small
		port (
			agent_addr_in_17 : in std_logic_vector(31 downto 0);
			agent_addr_out_17 : out std_logic_vector(31 downto 0);
			agent_av_in_1 : in std_logic;
			agent_av_in_2 : in std_logic;
			agent_av_out_1 : out std_logic;
			agent_av_out_2 : out std_logic;
			agent_comm_in_1 : in std_logic_vector(2 downto 0);
			agent_comm_in_17 : in std_logic_vector(2 downto 0);
			agent_comm_in_2 : in std_logic_vector(2 downto 0);
			agent_comm_out_1 : out std_logic_vector(2 downto 0);
			agent_comm_out_17 : out std_logic_vector(2 downto 0);
			agent_comm_out_2 : out std_logic_vector(2 downto 0);
			agent_data_in_1 : in std_logic_vector(31 downto 0);
			agent_data_in_17 : in std_logic_vector(31 downto 0);
			agent_data_in_2 : in std_logic_vector(31 downto 0);
			agent_data_out_1 : out std_logic_vector(31 downto 0);
			agent_data_out_17 : out std_logic_vector(31 downto 0);
			agent_data_out_2 : out std_logic_vector(31 downto 0);
			agent_empty_out_1 : out std_logic;
			agent_empty_out_17 : out std_logic;
			agent_empty_out_2 : out std_logic;
			agent_full_out_1 : out std_logic;
			agent_full_out_17 : out std_logic;
			agent_full_out_2 : out std_logic;
			agent_msg_addr_in_17 : in std_logic_vector(31 downto 0);
			agent_msg_comm_in_17 : in std_logic_vector(2 downto 0);
			agent_msg_comm_out_17 : out std_logic_vector(2 downto 0);
			agent_msg_data_in_17 : in std_logic_vector(31 downto 0);
			agent_msg_data_out_17 : out std_logic_vector(31 downto 0);
			agent_msg_empty_out_17 : out std_logic;
			agent_msg_full_out_17 : out std_logic;
			agent_msg_re_in_17 : in std_logic;
			agent_msg_we_in_17 : in std_logic;
			agent_one_d_out_1 : out std_logic;
			agent_one_d_out_2 : out std_logic;
			agent_one_p_out_1 : out std_logic;
			agent_one_p_out_2 : out std_logic;
			agent_re_in_1 : in std_logic;
			agent_re_in_17 : in std_logic;
			agent_re_in_2 : in std_logic;
			agent_we_in_1 : in std_logic;
			agent_we_in_17 : in std_logic;
			agent_we_in_2 : in std_logic;
			clk : in std_logic;
			rst_n : in std_logic);
	end component;

	-- Adapter to connect HIBI based FPGA subsystem to PCIe bus.
	component pcie_to_hibi_4x
		generic (
			HIBI_DATA_WIDTH : integer := 32);
		port (
			clk : in std_logic;
			hibi_av_in : in std_logic;
			hibi_av_out : out std_logic;
			hibi_comm_in : in std_logic_vector(2 downto 0);
			hibi_comm_out : out std_logic_vector(2 downto 0);
			hibi_data_in : in std_logic_vector(31 downto 0);
			hibi_data_out : out std_logic_vector(31 downto 0);
			hibi_empty_in : in std_logic;
			hibi_full_in : in std_logic;
			hibi_one_d_in : in std_logic;
			hibi_one_p_in : in std_logic;
			hibi_re_out : out std_logic;
			hibi_we_out : out std_logic;
			pcie_ref_clk : in std_logic;
			pcie_rst_n : in std_logic;
			pcie_rx : in std_logic_vector(3 downto 0);
			pcie_tx : out std_logic_vector(3 downto 0);
			rst_n : in std_logic);
	end component;

	-- Simple picture manipulator IP  to rotate 8-bit grayscale picture 90 degrees clockwise.
	component picture_manip
		port (
			hibi_Ore : out std_logic;
			hibi_iAv : in std_logic;
			hibi_iComm : in std_logic_vector(2 downto 0);
			hibi_iData : in std_logic_vector(31 downto 0);
			hibi_iEmpty : in std_logic;
			hibi_iFull : in std_logic;
			hibi_iOne_d_left : in std_logic;
			hibi_iOne_p_left : in std_logic;
			hibi_oAv : out std_logic;
			hibi_oComm : out std_logic_vector(2 downto 0);
			hibi_oData : out std_logic_vector(31 downto 0);
			hibi_oWe : out std_logic;
			sys_iClk : in std_logic;
			sys_iReset_n : in std_logic);
	end component;



begin


	a2_ddr2_dimm_1GB_1 : a2_ddr2_dimm_1GB
		port map (
			local_rdata(31 downto 0) => a2_ddr2_dimm_1GB_1_local_rdata_hibi_mem_dma_1_mem_rdata_in(31 downto 0),
			local_rdata_valid => a2_ddr2_dimm_1GB_1_local_rdata_valid_hibi_mem_dma_1_mem_rdata_valid_in,
			global_reset_n => user_pb_0,
			mem_addr => mem_addr,
			mem_ba => mem_ba,
			mem_cas_n => mem_cas_n,
			local_wdata(31 downto 0) => a2_ddr2_dimm_1GB_1_local_wdata_hibi_mem_dma_1_mem_wdata_out(31 downto 0),
			local_write_req => a2_ddr2_dimm_1GB_1_local_write_req_hibi_mem_dma_1_mem_wr_req_out,
			mem_cs_n => mem_cs_n,
			mem_dm => mem_dm,
			mem_dq => mem_dq,
			mem_dqs => mem_dqs,
			mem_dqsn => mem_dqsn,
			local_read_req => a2_ddr2_dimm_1GB_1_local_read_req_hibi_mem_dma_1_mem_rd_req_out,
			local_ready => a2_ddr2_dimm_1GB_1_local_ready_hibi_mem_dma_1_mem_ready_in,
			local_size(2 downto 0) => a2_ddr2_dimm_1GB_1_local_size_hibi_mem_dma_1_mem_burst_size_out(2 downto 0),
			mem_odt => mem_odt,
			mem_ras_n => mem_ras_n,
			mem_we_n => mem_we_n,
			local_address(24 downto 0) => a2_ddr2_dimm_1GB_1_local_address_hibi_mem_dma_1_mem_addr_out(24 downto 0),
			mem_cke => mem_cke,
			mem_clk => mem_clk,
			mem_clk_n => mem_clk_n,
			local_be(3 downto 0) => a2_ddr2_dimm_1GB_1_local_be_hibi_mem_dma_1_mem_be_out(3 downto 0),
			local_burstbegin => a2_ddr2_dimm_1GB_1_local_burstbegin_hibi_mem_dma_1_mem_burst_begin_out,
			local_init_done => a2_ddr2_dimm_1GB_1_local_init_done_hibi_mem_dma_1_mem_init_done_in,
			pll_ref_clk => clkin_bot_p,
			soft_reset_n => soft_reset_n,
			phy_clk => a2_ddr2_dimm_1GB_1_phy_clk_picture_manip_1_sys_iClk);

	hibi_mem_dma_1 : hibi_mem_dma
		generic map (
			BURST_SIZE_WIDTH => 3,
			HIBI_DATA_WIDTH => 32,
			MEM_ADDR_WIDTH => 25,
			MEM_BE_WIDTH => 4)
		port map (
			rst_n => user_pb_0,
			mem_wr_req_out => a2_ddr2_dimm_1GB_1_local_write_req_hibi_mem_dma_1_mem_wr_req_out,
			hibi_comm_out => hibi_segment_small_1_agent_comm_in_17_hibi_mem_dma_1_hibi_comm_out,
			hibi_data_in => hibi_segment_small_1_agent_data_out_17_hibi_mem_dma_1_hibi_data_in,
			mem_burst_size_out(2 downto 0) => a2_ddr2_dimm_1GB_1_local_size_hibi_mem_dma_1_mem_burst_size_out(2 downto 0),
			mem_init_done_in => a2_ddr2_dimm_1GB_1_local_init_done_hibi_mem_dma_1_mem_init_done_in,
			hibi_msg_comm_out => hibi_segment_small_1_agent_msg_comm_in_17_hibi_mem_dma_1_hibi_msg_comm_out,
			hibi_msg_data_in => hibi_segment_small_1_agent_msg_data_out_17_hibi_mem_dma_1_hibi_msg_data_in,
			hibi_full_in => hibi_segment_small_1_agent_full_out_17_hibi_mem_dma_1_hibi_full_in,
			hibi_msg_addr_out => hibi_segment_small_1_agent_msg_addr_in_17_hibi_mem_dma_1_hibi_msg_addr_out,
			hibi_msg_comm_in => hibi_segment_small_1_agent_msg_comm_out_17_hibi_mem_dma_1_hibi_msg_comm_in,
			hibi_re_out => hibi_segment_small_1_agent_re_in_17_hibi_mem_dma_1_hibi_re_out,
			hibi_we_out => hibi_segment_small_1_agent_we_in_17_hibi_mem_dma_1_hibi_we_out,
			mem_rd_req_out => a2_ddr2_dimm_1GB_1_local_read_req_hibi_mem_dma_1_mem_rd_req_out,
			mem_rdata_in(31 downto 0) => a2_ddr2_dimm_1GB_1_local_rdata_hibi_mem_dma_1_mem_rdata_in(31 downto 0),
			mem_rdata_valid_in => a2_ddr2_dimm_1GB_1_local_rdata_valid_hibi_mem_dma_1_mem_rdata_valid_in,
			mem_addr_out(24 downto 0) => a2_ddr2_dimm_1GB_1_local_address_hibi_mem_dma_1_mem_addr_out(24 downto 0),
			mem_be_out(3 downto 0) => a2_ddr2_dimm_1GB_1_local_be_hibi_mem_dma_1_mem_be_out(3 downto 0),
			mem_burst_begin_out => a2_ddr2_dimm_1GB_1_local_burstbegin_hibi_mem_dma_1_mem_burst_begin_out,
			hibi_msg_data_out => hibi_segment_small_1_agent_msg_data_in_17_hibi_mem_dma_1_hibi_msg_data_out,
			hibi_msg_empty_in => hibi_segment_small_1_agent_msg_empty_out_17_hibi_mem_dma_1_hibi_msg_empty_in,
			mem_ready_in => a2_ddr2_dimm_1GB_1_local_ready_hibi_mem_dma_1_mem_ready_in,
			mem_wdata_out(31 downto 0) => a2_ddr2_dimm_1GB_1_local_wdata_hibi_mem_dma_1_mem_wdata_out(31 downto 0),
			hibi_addr_in(31 downto 0) => hibi_segment_small_1_agent_addr_out_17_hibi_mem_dma_1_hibi_addr_in(31 downto 0),
			hibi_addr_out => hibi_segment_small_1_agent_addr_in_17_hibi_mem_dma_1_hibi_addr_out,
			hibi_comm_in => hibi_segment_small_1_agent_comm_out_17_hibi_mem_dma_1_hibi_comm_in,
			hibi_data_out => hibi_segment_small_1_agent_data_in_17_hibi_mem_dma_1_hibi_data_out,
			hibi_empty_in => hibi_segment_small_1_agent_empty_out_17_hibi_mem_dma_1_hibi_empty_in,
			hibi_msg_full_in => hibi_segment_small_1_agent_msg_full_out_17_hibi_mem_dma_1_hibi_msg_full_in,
			hibi_msg_re_out => hibi_segment_small_1_agent_msg_re_in_17_hibi_mem_dma_1_hibi_msg_re_out,
			hibi_msg_we_out => hibi_segment_small_1_agent_msg_we_in_17_hibi_mem_dma_1_hibi_msg_we_out,
			clk => a2_ddr2_dimm_1GB_1_phy_clk_picture_manip_1_sys_iClk);

	hibi_segment_small_1 : hibi_segment_small
		port map (
			rst_n => user_pb_0,
			agent_data_in_17 => hibi_segment_small_1_agent_data_in_17_hibi_mem_dma_1_hibi_data_out,
			agent_msg_full_out_17 => hibi_segment_small_1_agent_msg_full_out_17_hibi_mem_dma_1_hibi_msg_full_in,
			agent_data_in_2 => hibi_segment_small_1_agent_data_in_2_picture_manip_1_hibi_oData,
			agent_addr_in_17 => hibi_segment_small_1_agent_addr_in_17_hibi_mem_dma_1_hibi_addr_out,
			agent_comm_in_2 => hibi_segment_small_1_agent_comm_in_2_picture_manip_1_hibi_oComm,
			agent_comm_out_1 => hibi_segment_small_1_agent_comm_out_1_pcie_to_hibi_4x_1_hibi_comm_in,
			agent_comm_out_17 => hibi_segment_small_1_agent_comm_out_17_hibi_mem_dma_1_hibi_comm_in,
			agent_msg_re_in_17 => hibi_segment_small_1_agent_msg_re_in_17_hibi_mem_dma_1_hibi_msg_re_out,
			agent_av_in_2 => hibi_segment_small_1_agent_av_in_2_picture_manip_1_hibi_oAv,
			agent_av_out_1 => hibi_segment_small_1_agent_av_out_1_pcie_to_hibi_4x_1_hibi_av_in,
			agent_av_out_2 => hibi_segment_small_1_agent_av_out_2_picture_manip_1_hibi_iAv,
			agent_msg_comm_in_17 => hibi_segment_small_1_agent_msg_comm_in_17_hibi_mem_dma_1_hibi_msg_comm_out,
			agent_msg_comm_out_17 => hibi_segment_small_1_agent_msg_comm_out_17_hibi_mem_dma_1_hibi_msg_comm_in,
			agent_msg_data_in_17 => hibi_segment_small_1_agent_msg_data_in_17_hibi_mem_dma_1_hibi_msg_data_out,
			agent_comm_in_1 => hibi_segment_small_1_agent_comm_in_1_pcie_to_hibi_4x_1_hibi_comm_out,
			agent_comm_in_17 => hibi_segment_small_1_agent_comm_in_17_hibi_mem_dma_1_hibi_comm_out,
			agent_msg_data_out_17 => hibi_segment_small_1_agent_msg_data_out_17_hibi_mem_dma_1_hibi_msg_data_in,
			agent_msg_empty_out_17 => hibi_segment_small_1_agent_msg_empty_out_17_hibi_mem_dma_1_hibi_msg_empty_in,
			agent_one_p_out_1 => hibi_segment_small_1_agent_one_p_out_1_pcie_to_hibi_4x_1_hibi_one_p_in,
			agent_one_p_out_2 => hibi_segment_small_1_agent_one_p_out_2_picture_manip_1_hibi_iOne_p_left,
			agent_we_in_1 => hibi_segment_small_1_agent_we_in_1_pcie_to_hibi_4x_1_hibi_we_out,
			agent_we_in_17 => hibi_segment_small_1_agent_we_in_17_hibi_mem_dma_1_hibi_we_out,
			agent_msg_we_in_17 => hibi_segment_small_1_agent_msg_we_in_17_hibi_mem_dma_1_hibi_msg_we_out,
			agent_one_d_out_1 => hibi_segment_small_1_agent_one_d_out_1_pcie_to_hibi_4x_1_hibi_one_d_in,
			agent_one_d_out_2 => hibi_segment_small_1_agent_one_d_out_2_picture_manip_1_hibi_iOne_d_left,
			agent_we_in_2 => hibi_segment_small_1_agent_we_in_2_picture_manip_1_hibi_oWe,
			clk => a2_ddr2_dimm_1GB_1_phy_clk_picture_manip_1_sys_iClk,
			agent_full_out_2 => hibi_segment_small_1_agent_full_out_2_picture_manip_1_hibi_iFull,
			agent_msg_addr_in_17 => hibi_segment_small_1_agent_msg_addr_in_17_hibi_mem_dma_1_hibi_msg_addr_out,
			agent_comm_out_2 => hibi_segment_small_1_agent_comm_out_2_picture_manip_1_hibi_iComm,
			agent_data_in_1 => hibi_segment_small_1_agent_data_in_1_pcie_to_hibi_4x_1_hibi_data_out,
			agent_re_in_1 => hibi_segment_small_1_agent_re_in_1_pcie_to_hibi_4x_1_hibi_re_out,
			agent_re_in_17 => hibi_segment_small_1_agent_re_in_17_hibi_mem_dma_1_hibi_re_out,
			agent_re_in_2 => hibi_segment_small_1_agent_re_in_2_picture_manip_1_hibi_Ore,
			agent_empty_out_2 => hibi_segment_small_1_agent_empty_out_2_picture_manip_1_hibi_iEmpty,
			agent_full_out_1 => hibi_segment_small_1_agent_full_out_1_pcie_to_hibi_4x_1_hibi_full_in,
			agent_full_out_17 => hibi_segment_small_1_agent_full_out_17_hibi_mem_dma_1_hibi_full_in,
			agent_empty_out_1 => hibi_segment_small_1_agent_empty_out_1_pcie_to_hibi_4x_1_hibi_empty_in,
			agent_empty_out_17 => hibi_segment_small_1_agent_empty_out_17_hibi_mem_dma_1_hibi_empty_in,
			agent_addr_out_17 => hibi_segment_small_1_agent_addr_out_17_hibi_mem_dma_1_hibi_addr_in,
			agent_av_in_1 => hibi_segment_small_1_agent_av_in_1_pcie_to_hibi_4x_1_hibi_av_out,
			agent_data_out_1 => hibi_segment_small_1_agent_data_out_1_pcie_to_hibi_4x_1_hibi_data_in,
			agent_data_out_17 => hibi_segment_small_1_agent_data_out_17_hibi_mem_dma_1_hibi_data_in,
			agent_data_out_2 => hibi_segment_small_1_agent_data_out_2_picture_manip_1_hibi_iData);

	pcie_to_hibi_4x_1 : pcie_to_hibi_4x
		port map (
			pcie_ref_clk => pcie_refclk_p,
			pcie_rst_n => user_pb_0,
			pcie_rx(3 downto 0) => pcie_rx_p(3 downto 0),
			hibi_av_in => hibi_segment_small_1_agent_av_out_1_pcie_to_hibi_4x_1_hibi_av_in,
			hibi_av_out => hibi_segment_small_1_agent_av_in_1_pcie_to_hibi_4x_1_hibi_av_out,
			hibi_full_in => hibi_segment_small_1_agent_full_out_1_pcie_to_hibi_4x_1_hibi_full_in,
			hibi_one_d_in => hibi_segment_small_1_agent_one_d_out_1_pcie_to_hibi_4x_1_hibi_one_d_in,
			hibi_one_p_in => hibi_segment_small_1_agent_one_p_out_1_pcie_to_hibi_4x_1_hibi_one_p_in,
			hibi_comm_in => hibi_segment_small_1_agent_comm_out_1_pcie_to_hibi_4x_1_hibi_comm_in,
			hibi_comm_out => hibi_segment_small_1_agent_comm_in_1_pcie_to_hibi_4x_1_hibi_comm_out,
			hibi_data_in => hibi_segment_small_1_agent_data_out_1_pcie_to_hibi_4x_1_hibi_data_in,
			hibi_re_out => hibi_segment_small_1_agent_re_in_1_pcie_to_hibi_4x_1_hibi_re_out,
			hibi_we_out => hibi_segment_small_1_agent_we_in_1_pcie_to_hibi_4x_1_hibi_we_out,
			clk => a2_ddr2_dimm_1GB_1_phy_clk_picture_manip_1_sys_iClk,
			hibi_data_out => hibi_segment_small_1_agent_data_in_1_pcie_to_hibi_4x_1_hibi_data_out,
			hibi_empty_in => hibi_segment_small_1_agent_empty_out_1_pcie_to_hibi_4x_1_hibi_empty_in,
			pcie_tx(3 downto 0) => pcie_tx_p(3 downto 0),
			rst_n => user_pb_0);

	picture_manip_1 : picture_manip
		port map (
			hibi_iFull => hibi_segment_small_1_agent_full_out_2_picture_manip_1_hibi_iFull,
			hibi_iOne_d_left => hibi_segment_small_1_agent_one_d_out_2_picture_manip_1_hibi_iOne_d_left,
			hibi_iComm(2 downto 0) => hibi_segment_small_1_agent_comm_out_2_picture_manip_1_hibi_iComm(2 downto 0),
			hibi_iData(31 downto 0) => hibi_segment_small_1_agent_data_out_2_picture_manip_1_hibi_iData(31 downto 0),
			hibi_iEmpty => hibi_segment_small_1_agent_empty_out_2_picture_manip_1_hibi_iEmpty,
			hibi_oData(31 downto 0) => hibi_segment_small_1_agent_data_in_2_picture_manip_1_hibi_oData(31 downto 0),
			hibi_oWe => hibi_segment_small_1_agent_we_in_2_picture_manip_1_hibi_oWe,
			sys_iClk => a2_ddr2_dimm_1GB_1_phy_clk_picture_manip_1_sys_iClk,
			hibi_iOne_p_left => hibi_segment_small_1_agent_one_p_out_2_picture_manip_1_hibi_iOne_p_left,
			hibi_oAv => hibi_segment_small_1_agent_av_in_2_picture_manip_1_hibi_oAv,
			hibi_oComm(2 downto 0) => hibi_segment_small_1_agent_comm_in_2_picture_manip_1_hibi_oComm(2 downto 0),
			sys_iReset_n => user_pb_0,
			hibi_Ore => hibi_segment_small_1_agent_re_in_2_picture_manip_1_hibi_Ore,
			hibi_iAv => hibi_segment_small_1_agent_av_out_2_picture_manip_1_hibi_iAv);

end structural;

