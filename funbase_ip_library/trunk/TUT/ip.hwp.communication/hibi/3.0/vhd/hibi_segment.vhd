-- ***************************************************
-- File: hibi_segment.vhd
-- Creation date: 02.07.2012
-- Creation time: 15:39:00
-- Description: 
-- Created by: matilail
-- This file was generated with Kactus2 vhdl generator.
-- ***************************************************
library IEEE;
library hibi;
library work;
use hibi.all;
use work.all;
use IEEE.std_logic_1164.all;

entity hibi_segment is

	generic (
		hibi_addr_0_g : integer := 16#01000000#; -- HIBI address for interface 0
		hibi_addr_1_g : integer := 16#03000000#; -- HIBI address for interface 1
		hibi_addr_2_g : integer := 16#05000000#; -- HIBI address for interface 2
		hibi_addr_3_g : integer := 16#07000000# -- HIBI address for interface 3
	);

	port (

		-- Interface: clocks_0
		-- Clock inputs  interface for hibi wrapper_3
		agent_clk : in std_logic;
		agent_sync_clk : in std_logic;
		bus_clk : in std_logic;
		bus_sync_clk : in std_logic;

		-- Interface: clocks_1
		-- Clock inputs  interface for hibi wrapper_3
		agent_clk_1 : in std_logic;
		agent_sync_clk_1 : in std_logic;
		bus_clk_1 : in std_logic;
		bus_sync_clk_1 : in std_logic;

		-- Interface: clocks_2
		-- Clock inputs  interface for hibi wrapper_3
		agent_clk_2 : in std_logic;
		agent_sync_clk_2 : in std_logic;
		bus_clk_2 : in std_logic;
		bus_sync_clk_2 : in std_logic;

		-- Interface: clocks_3
		-- Clock inputs  interface for hibi wrapper_3
		agent_clk_3 : in std_logic;
		agent_sync_clk_3 : in std_logic;
		bus_clk_3 : in std_logic;
		bus_sync_clk_3 : in std_logic;

		-- Interface: ip_mMaster_0
		-- HIBI ip mirrored master agent interface 0 (r4 wrapper)
		agent_av_in : in std_logic;
		agent_comm_in : in std_logic_vector(4 downto 0);
		agent_data_in : in std_logic_vector(31 downto 0);
		agent_re_in : in std_logic;
		agent_we_in : in std_logic;

		-- Interface: ip_mMaster_1
		-- HIBI ip mirrored master agent interface 1 (r4 wrapper)
		agent_av_in_1 : in std_logic;
		agent_comm_in_1 : in std_logic_vector(4 downto 0);
		agent_data_in_1 : in std_logic_vector(31 downto 0);
		agent_re_in_1 : in std_logic;
		agent_we_in_1 : in std_logic;

		-- Interface: ip_mMaster_2
		-- HIBI ip mirrored master agent interface 2 (r4 wrapper)
		agent_av_in_2 : in std_logic;
		agent_comm_in_2 : in std_logic_vector(4 downto 0);
		agent_data_in_2 : in std_logic_vector(31 downto 0);
		agent_re_in_2 : in std_logic;
		agent_we_in_2 : in std_logic;

		-- Interface: ip_mMaster_3
		-- HIBI ip mirrored master agent interface 3 (r4 wrapper)
		agent_av_in_3 : in std_logic;
		agent_comm_in_3 : in std_logic_vector(4 downto 0);
		agent_data_in_3 : in std_logic_vector(31 downto 0);
		agent_re_in_3 : in std_logic;
		agent_we_in_3 : in std_logic;

		-- Interface: ip_mSlave_0
		-- HIBI ip mirrored slave agent interface 0 (r4 wrapper)
		agent_av_out : out std_logic;
		agent_comm_out : out std_logic_vector(4 downto 0);
		agent_data_out : out std_logic_vector(31 downto 0);
		agent_empty_out : out std_logic;
		agent_full_out : out std_logic;
		agent_one_d_out : out std_logic;
		agent_one_p_out : out std_logic;

		-- Interface: ip_mSlave_1
		-- HIBI ip mirrored slave agent interface 1  (r4 wrapper)
		agent_av_out_1 : out std_logic;
		agent_comm_out_1 : out std_logic_vector(4 downto 0);
		agent_data_out_1 : out std_logic_vector(31 downto 0);
		agent_empty_out_1 : out std_logic;
		agent_full_out_1 : out std_logic;
		agent_one_d_out_1 : out std_logic;
		agent_one_p_out_1 : out std_logic;

		-- Interface: ip_mSlave_2
		-- HIBI ip mirrored slave agent interface 2 (r4 wrapper)
		agent_av_out_2 : out std_logic;
		agent_comm_out_2 : out std_logic_vector(4 downto 0);
		agent_data_out_2 : out std_logic_vector(31 downto 0);
		agent_empty_out_2 : out std_logic;
		agent_full_out_2 : out std_logic;
		agent_one_d_out_2 : out std_logic;
		agent_one_p_out_2 : out std_logic;

		-- Interface: ip_mSlave_3
		-- HIBI ip mirrored slave agent interface_3 (r4 wrapper)
		agent_av_out_3 : out std_logic;
		agent_comm_out_3 : out std_logic_vector(4 downto 0);
		agent_data_out_3 : out std_logic_vector(31 downto 0);
		agent_empty_out_3 : out std_logic;
		agent_full_out_3 : out std_logic;
		agent_one_d_out_3 : out std_logic;
		agent_one_p_out_3 : out std_logic;

		-- Interface: rst_n
		-- Active low reset interface.
		rst_n : in std_logic
	);

end hibi_segment;


architecture structural of hibi_segment is

	signal hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveAV : std_logic;
	signal hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1AV : std_logic;
	signal hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveAV : std_logic;
	signal hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3AV : std_logic;
	signal hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterAV : std_logic;
	signal hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveCOMM : std_logic_vector(4 downto 0);
	signal hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1COMM : std_logic_vector(4 downto 0);
	signal hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveCOMM : std_logic_vector(4 downto 0);
	signal hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3COMM : std_logic_vector(4 downto 0);
	signal hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterCOMM : std_logic_vector(4 downto 0);
	signal hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveDATA : std_logic_vector(31 downto 0);
	signal hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1DATA : std_logic_vector(31 downto 0);
	signal hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveDATA : std_logic_vector(31 downto 0);
	signal hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3DATA : std_logic_vector(31 downto 0);
	signal hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterDATA : std_logic_vector(31 downto 0);
	signal hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveFULL : std_logic;
	signal hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1FULL : std_logic;
	signal hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveFULL : std_logic;
	signal hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3FULL : std_logic;
	signal hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterFULL : std_logic;
	signal hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveLOCK : std_logic;
	signal hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1LOCK : std_logic;
	signal hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveLOCK : std_logic;
	signal hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3LOCK : std_logic;
	signal hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterLOCK : std_logic;

	component hibi_orbus_small
		generic (
			comm_width_g : integer := 5; -- HIBI command width
			data_width_g : integer := 32 -- HIBI data width

		);
		port (

			-- Interface: master
			-- HIBI bus <---> wrapper master interface
			bus_av_out : out std_logic;
			bus_comm_out : out std_logic_vector(4 downto 0);
			bus_data_out : out std_logic_vector(31 downto 0);
			bus_full_out : out std_logic;
			bus_lock_out : out std_logic;

			-- Interface: slave_0
			-- HIBI bus <---> wrapper slave interface
			bus_av_0_in : in std_logic;
			bus_comm_0_in : in std_logic_vector(4 downto 0);
			bus_data_0_in : in std_logic_vector(31 downto 0);
			bus_full_0_in : in std_logic;
			bus_lock_0_in : in std_logic;

			-- Interface: slave_1
			-- HIBI bus <---> wrapper slave interface
			bus_av_1_in : in std_logic;
			bus_comm_1_in : in std_logic_vector(4 downto 0);
			bus_data_1_in : in std_logic_vector(31 downto 0);
			bus_full_1_in : in std_logic;
			bus_lock_1_in : in std_logic;

			-- Interface: slave_2
			-- HIBI bus <---> wrapper slave interface
			bus_av_2_in : in std_logic;
			bus_comm_2_in : in std_logic_vector(4 downto 0);
			bus_data_2_in : in std_logic_vector(31 downto 0);
			bus_full_2_in : in std_logic;
			bus_lock_2_in : in std_logic;

			-- Interface: slave_3
			-- HIBI bus <---> wrapper slave interface
			bus_av_3_in : in std_logic;
			bus_comm_3_in : in std_logic_vector(4 downto 0);
			bus_data_3_in : in std_logic_vector(31 downto 0);
			bus_full_3_in : in std_logic;
			bus_lock_3_in : in std_logic

		);
	end component;

	-- HIBI bus wrapper, interface revision 4 
	component hibi_wrapper_r4
		generic (
			addr_g : integer := 46; -- addressing settings: unique for each wrapper
			addr_limit_g : integer := 0; -- Upper address boundary
			addr_width_g : integer := 32; -- HIBI address width
			arb_type_g : integer := 0; -- Arbitration type 0 round-robin, 1 priority, 2 combined, 3 DAA. Ensure that all wrappers in a segment agree on arb_type
			cfg_re_g : integer := 0; --  enable reading config
			cfg_we_g : integer := 0; -- enable writing config
			comm_width_g : integer := 5; -- HIBI communication width (HIBI v.2=3, v.3 = 5 bits)
			counter_width_g : integer := 7; -- greater than or equal (n_agents, max_send...) 
			data_width_g : integer := 32; -- HIBI data width (less than or equal)
			debug_width_g : integer := 0; -- For special monitors
			fifo_sel_g : integer := 0; -- fifo_sel: 0 synch multiclk, 1 basic GALS,  2 Gray FIFO (depth=2^n!), 3 mixed clock pausible ( use 0 for synchronous systems)
			id_g : integer := 5; --  used instead of addr in recfg
			id_max_g : integer := 0; -- Only for bridges+cfg, zero for others!
			id_min_g : integer := 0; -- Only for bridges+cfg, zero for others!
			id_width_g : integer := 4; -- gte(log2(id_g))
			inv_addr_en_g : integer := 0; -- Only for bridges
			keep_slot_g : integer := 0; -- for TDMA
			max_send_g : integer := 50; -- in words. Max_send can be wrapper-specific.
			n_agents_g : integer := 4; -- Number of agents within one segment. Ensure that all wrappers in a segment agree on n_agents
			n_cfg_pages_g : integer := 0; -- Having multiple pages allows fast reconfig. Note that cfg memory initialization is done with separate package if you have many time slots or configuration pages
			n_extra_params_g : integer := 0; -- app-specific registers
			n_time_slots_g : integer := 0; -- TDMA is enabled by setting n_time_slots > 0
			prior_g : integer := 2; -- lte n_agents
			rel_agent_freq_g : integer := 1; -- Synch_multiclk FIFOs must know the ratio of frequencies
			rel_bus_freq_g : integer := 1; -- Synch_multiclk FIFOs must know the ratio of frequencies
			rx_fifo_depth_g : integer := 5; -- All FIFO depths are given in words. Allowed values 0,2,3... words.
			rx_msg_fifo_depth_g : integer := 5; -- All FIFO depths are given in words. Allowed values 0,2,3... words.Prefix msg refers to hi-prior data
			separate_addr_g : integer := 0; -- Transmits addr in parallel with data
			tx_fifo_depth_g : integer := 5; -- All FIFO depths are given in words. Allowed values 0,2,3... words.
			tx_msg_fifo_depth_g : integer := 5 -- All FIFO depths are given in words. Allowed values 0,2,3... words.Prefix msg refers to hi-prior data

		);
		port (

			-- Interface: bus_mMaster
			-- HIBI bus interface
			bus_av_in : in std_logic;
			bus_comm_in : in std_logic_vector(4 downto 0);
			bus_data_in : in std_logic_vector(31 downto 0);
			bus_full_in : in std_logic;
			bus_lock_in : in std_logic;

			-- Interface: bus_mSlave
			bus_av_out : out std_logic;
			bus_comm_out : out std_logic_vector(4 downto 0);
			bus_data_out : out std_logic_vector(31 downto 0);
			bus_full_out : out std_logic;
			bus_lock_out : out std_logic;

			-- Interface: clocks
			-- HIBI clock input
			agent_clk : in std_logic;
			agent_sync_clk : in std_logic;
			bus_clk : in std_logic;
			bus_sync_clk : in std_logic;

			-- Interface: ip_mMaster
			-- HIBI IP  mirrored master interface revision 4.
			agent_av_in : in std_logic;
			agent_comm_in : in std_logic_vector(4 downto 0);
			agent_data_in : in std_logic_vector(31 downto 0);
			agent_re_in : in std_logic;
			agent_we_in : in std_logic;

			-- Interface: ip_mSlave
			-- HIBI IP  mirrored slave interface revision 4.
			agent_av_out : out std_logic;
			agent_comm_out : out std_logic_vector(4 downto 0);
			agent_data_out : out std_logic_vector(31 downto 0);
			agent_empty_out : out std_logic;
			agent_full_out : out std_logic;
			agent_one_d_out : out std_logic;
			agent_one_p_out : out std_logic;

			-- These ports are not in any interface
			debug_in : in std_logic_vector(0 downto 0);
			-- debug_out : out std_logic_vector(0 downto 0);

			-- Interface: rst_n
			rst_n : in std_logic

		);
	end component;

	-- You can write vhdl code after this tag and it is saved through the generator.
	-- ##KACTUS2_BLACK_BOX_DECLARATIONS_BEGIN##
	-- ##KACTUS2_BLACK_BOX_DECLARATIONS_END##
	-- Stop writing your code after this tag.


begin

	-- You can write vhdl code after this tag and it is saved through the generator.
	-- ##KACTUS2_BLACK_BOX_ASSIGNMENTS_BEGIN##
	-- ##KACTUS2_BLACK_BOX_ASSIGNMENTS_END##
	-- Stop writing your code after this tag.

	hibi_orbus_0 : hibi_orbus_small
		port map (
			bus_av_0_in => hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveAV,
			bus_av_1_in => hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1AV,
			bus_av_2_in => hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveAV,
			bus_av_3_in => hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3AV,
			bus_av_out => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterAV,
			bus_comm_0_in(4 downto 0) => hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveCOMM(4 downto 0),
			bus_comm_1_in(4 downto 0) => hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1COMM(4 downto 0),
			bus_comm_2_in(4 downto 0) => hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveCOMM(4 downto 0),
			bus_comm_3_in(4 downto 0) => hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3COMM(4 downto 0),
			bus_comm_out(4 downto 0) => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterCOMM(4 downto 0),
			bus_data_0_in(31 downto 0) => hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveDATA(31 downto 0),
			bus_data_1_in(31 downto 0) => hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1DATA(31 downto 0),
			bus_data_2_in(31 downto 0) => hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveDATA(31 downto 0),
			bus_data_3_in(31 downto 0) => hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3DATA(31 downto 0),
			bus_data_out(31 downto 0) => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterDATA(31 downto 0),
			bus_full_0_in => hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveFULL,
			bus_full_1_in => hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1FULL,
			bus_full_2_in => hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveFULL,
			bus_full_3_in => hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3FULL,
			bus_full_out => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterFULL,
			bus_lock_0_in => hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveLOCK,
			bus_lock_1_in => hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1LOCK,
			bus_lock_2_in => hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveLOCK,
			bus_lock_3_in => hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3LOCK,
			bus_lock_out => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterLOCK
		);

	hibi_wrapper_r4_0 : hibi_wrapper_r4
		generic map (
			addr_g => hibi_addr_0_g
		)
		port map (
			agent_av_in => agent_av_in,
			agent_av_out => agent_av_out,
			agent_clk => agent_clk,
			agent_comm_in(4 downto 0) => agent_comm_in(4 downto 0),
			agent_comm_out(4 downto 0) => agent_comm_out(4 downto 0),
			agent_data_in(31 downto 0) => agent_data_in(31 downto 0),
			agent_data_out(31 downto 0) => agent_data_out(31 downto 0),
			agent_empty_out => agent_empty_out,
			agent_full_out => agent_full_out,
			agent_one_d_out => agent_one_d_out,
			agent_one_p_out => agent_one_p_out,
			agent_re_in => agent_re_in,
			agent_sync_clk => agent_sync_clk,
			agent_we_in => agent_we_in,
			bus_av_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterAV,
			bus_av_out => hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveAV,
			bus_clk => bus_clk,
			bus_comm_in(4 downto 0) => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterCOMM(4 downto 0),
			bus_comm_out(4 downto 0) => hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveCOMM(4 downto 0),
			bus_data_in(31 downto 0) => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterDATA(31 downto 0),
			bus_data_out(31 downto 0) => hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveDATA(31 downto 0),
			bus_full_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterFULL,
			bus_full_out => hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveFULL,
			bus_lock_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterLOCK,
			bus_lock_out => hibi_orbus_0_slave_0_to_hibi_wrapper_r4_0_bus_mSlaveLOCK,
			bus_sync_clk => bus_sync_clk,
			debug_in => (others => '0'),
			rst_n => rst_n
		);

	hibi_wrapper_r4_1 : hibi_wrapper_r4
		generic map (
			addr_g => hibi_addr_1_g
		)
		port map (
			agent_av_in => agent_av_in_1,
			agent_av_out => agent_av_out_1,
			agent_clk => agent_clk_1,
			agent_comm_in(4 downto 0) => agent_comm_in_1(4 downto 0),
			agent_comm_out(4 downto 0) => agent_comm_out_1(4 downto 0),
			agent_data_in(31 downto 0) => agent_data_in_1(31 downto 0),
			agent_data_out(31 downto 0) => agent_data_out_1(31 downto 0),
			agent_empty_out => agent_empty_out_1,
			agent_full_out => agent_full_out_1,
			agent_one_d_out => agent_one_d_out_1,
			agent_one_p_out => agent_one_p_out_1,
			agent_re_in => agent_re_in_1,
			agent_sync_clk => agent_sync_clk_1,
			agent_we_in => agent_we_in_1,
			bus_av_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterAV,
			bus_av_out => hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1AV,
			bus_clk => bus_clk_1,
			bus_comm_in(4 downto 0) => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterCOMM(4 downto 0),
			bus_comm_out(4 downto 0) => hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1COMM(4 downto 0),
			bus_data_in(31 downto 0) => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterDATA(31 downto 0),
			bus_data_out(31 downto 0) => hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1DATA(31 downto 0),
			bus_full_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterFULL,
			bus_full_out => hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1FULL,
			bus_lock_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterLOCK,
			bus_lock_out => hibi_wrapper_r4_1_bus_mSlave_to_hibi_orbus_0_slave_1LOCK,
			bus_sync_clk => bus_sync_clk_1,
			debug_in => (others => '0'),
			rst_n => rst_n
		);

	hibi_wrapper_r4_2 : hibi_wrapper_r4
		generic map (
			addr_g => hibi_addr_2_g
		)
		port map (
			agent_av_in => agent_av_in_2,
			agent_av_out => agent_av_out_2,
			agent_clk => agent_clk_2,
			agent_comm_in(4 downto 0) => agent_comm_in_2(4 downto 0),
			agent_comm_out(4 downto 0) => agent_comm_out_2(4 downto 0),
			agent_data_in(31 downto 0) => agent_data_in_2(31 downto 0),
			agent_data_out(31 downto 0) => agent_data_out_2(31 downto 0),
			agent_empty_out => agent_empty_out_2,
			agent_full_out => agent_full_out_2,
			agent_one_d_out => agent_one_d_out_2,
			agent_one_p_out => agent_one_p_out_2,
			agent_re_in => agent_re_in_2,
			agent_sync_clk => agent_sync_clk_2,
			agent_we_in => agent_we_in_2,
			bus_av_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterAV,
			bus_av_out => hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveAV,
			bus_clk => bus_clk_2,
			bus_comm_in(4 downto 0) => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterCOMM(4 downto 0),
			bus_comm_out(4 downto 0) => hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveCOMM(4 downto 0),
			bus_data_in(31 downto 0) => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterDATA(31 downto 0),
			bus_data_out(31 downto 0) => hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveDATA(31 downto 0),
			bus_full_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterFULL,
			bus_full_out => hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveFULL,
			bus_lock_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterLOCK,
			bus_lock_out => hibi_orbus_0_slave_2_to_hibi_wrapper_r4_2_bus_mSlaveLOCK,
			bus_sync_clk => bus_sync_clk_2,
			debug_in => (others => '0'),
			rst_n => rst_n
		);

	hibi_wrapper_r4_3 : hibi_wrapper_r4
		generic map (
			addr_g => hibi_addr_3_g
		)
		port map (
			agent_av_in => agent_av_in_3,
			agent_av_out => agent_av_out_3,
			agent_clk => agent_clk_3,
			agent_comm_in(4 downto 0) => agent_comm_in_3(4 downto 0),
			agent_comm_out(4 downto 0) => agent_comm_out_3(4 downto 0),
			agent_data_in(31 downto 0) => agent_data_in_3(31 downto 0),
			agent_data_out(31 downto 0) => agent_data_out_3(31 downto 0),
			agent_empty_out => agent_empty_out_3,
			agent_full_out => agent_full_out_3,
			agent_one_d_out => agent_one_d_out_3,
			agent_one_p_out => agent_one_p_out_3,
			agent_re_in => agent_re_in_3,
			agent_sync_clk => agent_sync_clk_3,
			agent_we_in => agent_we_in_3,
			bus_av_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterAV,
			bus_av_out => hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3AV,
			bus_clk => bus_clk_3,
			bus_comm_in(4 downto 0) => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterCOMM(4 downto 0),
			bus_comm_out(4 downto 0) => hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3COMM(4 downto 0),
			bus_data_in(31 downto 0) => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterDATA(31 downto 0),
			bus_data_out(31 downto 0) => hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3DATA(31 downto 0),
			bus_full_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterFULL,
			bus_full_out => hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3FULL,
			bus_lock_in => hibi_orbus_0_master_to_hibi_wrapper_r4_0_bus_mMasterLOCK,
			bus_lock_out => hibi_wrapper_r4_3_bus_mSlave_to_hibi_orbus_0_slave_3LOCK,
			bus_sync_clk => bus_sync_clk_3,
			debug_in => (others => '0'),
			rst_n => rst_n
		);

end structural;

