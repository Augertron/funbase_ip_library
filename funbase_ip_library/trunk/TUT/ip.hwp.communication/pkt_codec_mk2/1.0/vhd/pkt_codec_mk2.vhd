-------------------------------------------------------------------------------
-- Title      : Packet Codec MK2
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkt_codec_mk2.vhd
-- Author     : Lasse Lehtonen
-- Company    : 
-- Created    : 2011-01-12
-- Last update: 2011-10-24
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description:
--
-- Generics
-- 
-- address_mode_g 0 : IP gives raw network address
-- address_mode_g 1 : IP gives integer ID numbers as target address
-- address_mode_g 2 : IP gives memory mapped addresses
--
-- clock_mode_g 0 : Use one clock for both ip and the net
--                  (clk_ip must be same as clk_net)
-- clock_mode_g 1 : Use two asynchronous clocks
--
-- noc_type_g 0 : ase_noc
-- noc_type_g 1 : ase_mesh1
--
-------------------------------------------------------------------------------
-- Copyright (c) 2011 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2011-01-12  1.0      ase     Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.ase_noc_pkg.all;
use work.ase_mesh1_pkg.all;

entity pkt_codec_mk2 is
  
  generic (
    my_id_g        : natural;
    data_width_g   : positive;
    cmd_width_g    : positive;
    agents_g       : positive;
    cols_g         : positive;
    rows_g         : positive;
    agent_ports_g  : positive;
    addr_flit_en_g : natural;
    address_mode_g : natural;
    clock_mode_g   : natural;
    rip_addr_g     : natural;
    noc_type_g     : natural);

  port (
    clk_ip  : in std_logic;
    clk_net : in std_logic;
    rst_n   : in std_logic;

    -- IP read interface 
    ip_cmd_out  : out std_logic_vector(cmd_width_g-1 downto 0);
    ip_data_out : out std_logic_vector(data_width_g-1 downto 0);
    ip_stall_in : in  std_logic;

    -- IP write interface
    ip_cmd_in    : in  std_logic_vector(cmd_width_g-1 downto 0);
    ip_data_in   : in  std_logic_vector(data_width_g-1 downto 0);
    ip_stall_out : out std_logic;

    -- NoC write interface
    net_cmd_out  : out std_logic_vector(cmd_width_g-1 downto 0);
    net_data_out : out std_logic_vector(data_width_g-1 downto 0);
    net_stall_in : in  std_logic;

    -- NoC read interface
    net_cmd_in    : in  std_logic_vector(cmd_width_g-1 downto 0);
    net_data_in   : in  std_logic_vector(data_width_g-1 downto 0);
    net_stall_out : out std_logic
    );

end entity pkt_codec_mk2;



architecture rtl of pkt_codec_mk2 is

  -----------------------------------------------------------------------------
  -- SIGNALS
  -----------------------------------------------------------------------------

  -- from ip to net path
  -- cdc -> at
  signal net_cmd_from_cdc  : std_logic_vector(cmd_width_g-1 downto 0);
  signal net_data_from_cdc : std_logic_vector(data_width_g-1 downto 0);
  signal net_stall_to_cdc  : std_logic;
  -- at -> ag
  signal net_cmd_from_at   : std_logic_vector(cmd_width_g-1 downto 0);
  signal net_data_from_at  : std_logic_vector(data_width_g-1 downto 0);
  signal net_stall_to_at   : std_logic;
  signal orig_addr_from_at : std_logic_vector(data_width_g-1 downto 0);

  -- from net to ip path
  -- ar -> cdc
  signal ip_cmd_from_ar  : std_logic_vector(cmd_width_g-1 downto 0);
  signal ip_data_from_ar : std_logic_vector(data_width_g-1 downto 0);
  signal ip_stall_to_ar  : std_logic;

  
-------------------------------------------------------------------------------
begin  -- architecture rtl
-------------------------------------------------------------------------------

  
  -----------------------------------------------------------------------------
  -- CLOCK DOMAIN CROSSING
  -----------------------------------------------------------------------------

  cdc_1 : entity work.cdc
    generic map (
      cmd_width_g  => cmd_width_g,
      data_width_g => data_width_g,
      clock_mode_g => clock_mode_g)
    port map (
      clk_ip        => clk_ip,
      clk_net       => clk_net,
      rst_n         => rst_n,
      ip_cmd_out    => ip_cmd_out,
      ip_data_out   => ip_data_out,
      ip_stall_in   => ip_stall_in,
      ip_cmd_in     => ip_cmd_in,
      ip_data_in    => ip_data_in,
      ip_stall_out  => ip_stall_out,
      net_cmd_out   => net_cmd_from_cdc,
      net_data_out  => net_data_from_cdc,
      net_stall_in  => net_stall_to_cdc,
      net_cmd_in    => ip_cmd_from_ar,
      net_data_in   => ip_data_from_ar,
      net_stall_out => ip_stall_to_ar);

  -----------------------------------------------------------------------------
  -- ADDRESS TRANSLATION (only from IP to NET)
  -----------------------------------------------------------------------------

  addr_translation_1 : entity work.addr_translation
    generic map (
      my_id_g        => my_id_g,
      cmd_width_g    => cmd_width_g,
      data_width_g   => data_width_g,
      address_mode_g => address_mode_g,
      cols_g         => cols_g,
      rows_g         => rows_g,
      agents_g       => agents_g,
      agent_ports_g  => agent_ports_g,
      addr_flit_en_g => addr_flit_en_g,
      noc_type_g     => noc_type_g)
    port map (
      clk           => clk_net,
      rst_n         => rst_n,
      ip_cmd_in     => net_cmd_from_cdc,
      ip_data_in    => net_data_from_cdc,
      ip_stall_out  => net_stall_to_cdc,
      net_cmd_out   => net_cmd_from_at,
      net_data_out  => net_data_from_at,
      net_stall_in  => net_stall_to_at,
      orig_addr_out => orig_addr_from_at);


  -----------------------------------------------------------------------------
  -- ADDRESS GENERATOR (only from IP to NET)
  -----------------------------------------------------------------------------
  
  addr_gen_1 : entity work.addr_gen
    generic map (
      cmd_width_g    => cmd_width_g,
      data_width_g   => data_width_g,
      addr_flit_en_g => addr_flit_en_g)
    port map (
      clk          => clk_net,
      rst_n        => rst_n,
      ip_cmd_in    => net_cmd_from_at,
      ip_data_in   => net_data_from_at,
      ip_stall_out => net_stall_to_at,
      orig_addr_in => orig_addr_from_at,
      net_cmd_out  => net_cmd_out,
      net_data_out => net_data_out,
      net_stall_in => net_stall_in
      );


  -----------------------------------------------------------------------------
  -- ADDRESS RIPPER / REPLACER (only from NET to IP)
  -----------------------------------------------------------------------------
  
  addr_rip_1 : entity work.addr_rip
    generic map (
      cmd_width_g    => cmd_width_g,
      data_width_g   => data_width_g,
      addr_flit_en_g => addr_flit_en_g,
      rip_addr_g     => rip_addr_g)
    port map (
      clk           => clk_net,
      rst_n         => rst_n,
      net_cmd_in    => net_cmd_in,
      net_data_in   => net_data_in,
      net_stall_out => net_stall_out,
      ip_cmd_out    => ip_cmd_from_ar,
      ip_data_out   => ip_data_from_ar,
      ip_stall_in   => ip_stall_to_ar);

end architecture rtl;
