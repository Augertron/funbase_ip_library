-------------------------------------------------------------------------------
-- Title      : HIBI Transmitter
-- Project    : Nocbench, Funbase
-------------------------------------------------------------------------------
-- File       : transmitter.vhd
-- Authors    : Erno Salminen
-- Company    : Tampere University of Technology
-- Created    :
-- Last update: 2011-11-28
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: Transmitter block just instantiates tx control and
--              configuration memory
-- 
--
-------------------------------------------------------------------------------
-- Copyright (c) 2010 Tampere University of Technology
--
-- 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2002-07-23  1.0      ege     Created
-------------------------------------------------------------------------------
-- Funbase IP library Copyright (C) 2011 TUT Department of Computer Systems
--
-- This file is part of HIBI
--
-- This source file may be used and distributed without
-- restriction provided that this copyright statement is not
-- removed from the file and that any derivative work contains
-- the original copyright notice and the associated disclaimer.
--
-- This source file is free software; you can redistribute it
-- and/or modify it under the terms of the GNU Lesser General
-- Public License as published by the Free Software Foundation;
-- either version 2.1 of the License, or (at your option) any
-- later version.
--
-- This source is distributed in the hope that it will be
-- useful, but WITHOUT ANY WARRANTY; without even the implied
-- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
-- PURPOSE.  See the GNU Lesser General Public License for more
-- details.
--
-- You should have received a copy of the GNU Lesser General
-- Public License along with this source; if not, download it
-- from http://www.opencores.org/lgpl.shtml
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity transmitter is

  generic (
    id_g            : integer;
    addr_g          : integer;
    id_width_g      : integer;
    data_width_g    : integer;
    addr_width_g    : integer;
    comm_width_g    : integer;
    counter_width_g : integer;

    cfg_addr_width_g : integer;
    prior_g          : integer;
    inv_addr_en_g    : integer;
    max_send_g       : integer;
    arb_type_g       : integer;

    n_agents_g       : integer;
    n_cfg_pages_g    : integer;
    n_time_slots_g   : integer;
    keep_slot_g      : integer;
    n_extra_params_g : integer;
    cfg_we_g         : integer;
    cfg_re_g         : integer;
    separate_addr_g  : integer;
    debug_width_g    : integer := 0
    );
  port (
    clk   : in std_logic;
    rst_n : in std_logic;

    -- from bus
    lock_in : in std_logic;
    full_in : in std_logic;

    -- from rx
    cfg_data_in     : in std_logic_vector
    (data_width_g-1-(separate_addr_g*addr_width_g) downto 0);
    cfg_addr_in     : in std_logic_vector(cfg_addr_width_g -1 downto 0);
    cfg_ret_addr_in : in std_logic_vector(addr_width_g -1 downto 0);
    cfg_re_in       : in std_logic;
    cfg_we_in       : in std_logic;

    -- from fifo
    av_in    : in std_logic;
    data_in  : in std_logic_vector(data_width_g-1 downto 0);
    comm_in  : in std_logic_vector(comm_width_g-1 downto 0);
    empty_in : in std_logic;
    one_d_in : in std_logic;

    -- to bus
    av_out   : out std_logic;
    data_out : out std_logic_vector(data_width_g-1 downto 0);
    comm_out : out std_logic_vector(comm_width_g-1 downto 0);
    lock_out : out std_logic;

    -- to rx
    cfg_rd_rdy_out : out std_logic;

    -- to fifo
    re_out : out std_logic

    -- synthesis translate_off
    -- pragma sythesis_off
    -- pragma translate_off
    ;

    debug_out : out std_logic_vector(debug_width_g-1 downto 0);
    debug_in  : in  std_logic_vector(debug_width_g-1 downto 0)
    -- pragma translate_on
    -- pragma synthesis_on
    -- synthesis translate_on      

    );
end transmitter;


-- **********
-- 19.08.2004
-- These must be connected from cfg_mem to tx_ctrl!
--  signal Power_Mode_cm_tx        : std_logic_vector( 1 downto 0);
--  signal Competition_Type_cm_tx  : std_logic_vector( 1 downto 0); 
-- **********




architecture structural of transmitter is


  signal curr_slot_ends_cm_tx   : std_logic;
  signal curr_slot_own_cm_tx    : std_logic;
  signal next_slot_starts_cm_tx : std_logic;
  signal next_slot_own_cm_tx    : std_logic;

  signal n_agents_cm_tx : std_logic_vector(id_width_g-1 downto 0);
  signal max_send_cm_tx : std_logic_vector(counter_width_g-1 downto 0);
  signal prior_cm_tx    : std_logic_vector(id_width_g-1 downto 0);
  signal data_cm_tx     : std_logic_vector
    (data_width_g-1-(separate_addr_g*addr_width_g) downto 0);

  -- These must be connected to tx_ctrl!
  signal pwr_mode_cm_tx : std_logic_vector(1 downto 0);
  signal arb_type_cm_tx : std_logic_vector(1 downto 0);


  component tx_control
    generic (
      counter_width_g : integer;
      id_width_g      : integer;
      data_width_g    : integer;
      addr_width_g    : integer;
      comm_width_g    : integer;
      n_agents_g      : integer;
      cfg_re_g        : integer;
      keep_slot_g     : integer;
      separate_addr_g : integer
      );
    port (
      clk                 : in  std_logic;
      rst_n               : in  std_logic;
      lock_in             : in  std_logic;
      full_in             : in  std_logic;
      cfg_ret_addr_in     : in  std_logic_vector(addr_width_g-1 downto 0);
      cfg_data_in         : in  std_logic_vector
      (data_width_g-1-(separate_addr_g*addr_width_g) downto 0);
      cfg_re_in           : in  std_logic;
      curr_slot_own_in    : in  std_logic;
      curr_slot_ends_in   : in  std_logic;
      next_slot_own_in    : in  std_logic;
      next_slot_starts_in : in  std_logic;
      max_send_in         : in  std_logic_vector(counter_width_g-1 downto 0);
      n_agents_in         : in  std_logic_vector(id_width_g-1 downto 0);
      prior_in            : in  std_logic_vector(id_width_g-1 downto 0);
      -- *********************************************************
      -- new ports: Power_Mode and Competition_Type must be added!
      -- *********************************************************
      arb_type_in         : in  std_logic_vector(1 downto 0);
      av_in               : in  std_logic;
      data_in             : in  std_logic_vector(data_width_g-1 downto 0);
      comm_in             : in  std_logic_vector(comm_width_g-1 downto 0);
      one_d_in            : in  std_logic;
      empty_in            : in  std_logic;
      av_out              : out std_logic;
      data_out            : out std_logic_vector(data_width_g-1 downto 0);
      comm_out            : out std_logic_vector(comm_width_g-1 downto 0);
      lock_out            : out std_logic;
      cfg_rd_rdy_out      : out std_logic;
      re_out              : out std_logic
      );
  end component;  --tx_control;

  component cfg_mem
    generic (
      id_width_g       : integer := 4;
      id_g             : integer := 5;
      data_width_g     : integer := 16;
      counter_width_g  : integer := 8;
      arb_type_g       : integer := 0;
      cfg_addr_width_g : integer := 7;
      inv_addr_en_g    : integer := 0;   -- not used?
      addr_g           : integer := 46;
      prior_g          : integer := 2;
      max_send_g       : integer := 50;
      n_agents_g       : integer := 4;
      n_cfg_pages_g    : integer := 1;
      n_time_slots_g   : integer := 0;
      cfg_re_g         : integer := 0;
      cfg_we_g         : integer := 0
      );
    port (
      clk   : in std_logic;
      rst_n : in std_logic;

      addr_in              : in  std_logic_vector(cfg_addr_width_g -1 downto 0);
      data_in              : in  std_logic_vector(data_width_g-1 downto 0);
      re_in                : in  std_logic;
      we_in                : in  std_logic;
      curr_slot_ends_out   : out std_logic;
      curr_slot_own_out    : out std_logic;
      next_slot_starts_out : out std_logic;
      next_slot_own_out    : out std_logic;
      dbg_out              : out integer range 0 to 100;  -- For debug
      data_out             : out std_logic_vector(data_width_g-1 downto 0);
      arb_type_out         : out std_logic_vector(1 downto 0);
      n_agents_out         : out std_logic_vector(id_width_g-1 downto 0);
      max_send_out         : out std_logic_vector(counter_width_g-1 downto 0);
      prior_out            : out std_logic_vector(id_width_g-1 downto 0);
      pwr_mode_out         : out std_logic_vector(1 downto 0)
      );
  end component;  --cfg_mem;



begin  -- structural

  -- Design compiler ei ymm�rr� alempaa esittely�
  tx_c : tx_control
    -- tx_c : entity work.tx_control
    generic map(
      counter_width_g => counter_width_g,  --19.05
      id_width_g      => id_width_g,
      data_width_g    => data_width_g,
      addr_width_g    => addr_width_g,
      comm_width_g    => comm_width_g,
      n_agents_g      => n_agents_g,       -- 2009-04-08
      cfg_re_g        => cfg_re_g,
      keep_slot_g     => keep_slot_g,
      separate_addr_g => separate_addr_g
      )
    port map(
      clk   => clk,
      rst_n => rst_n,

      lock_in         => lock_in,
      full_in         => full_in,
      cfg_data_in     => data_cm_tx,
      cfg_ret_addr_in => cfg_ret_addr_in,
      cfg_re_in       => cfg_re_in,

      curr_slot_own_in    => curr_slot_own_cm_tx,
      curr_slot_ends_in   => curr_slot_ends_cm_tx,
      next_slot_own_in    => next_slot_own_cm_tx,
      next_slot_starts_in => next_slot_starts_cm_tx,
      max_send_in         => max_send_cm_tx,
      prior_in            => prior_cm_tx,
      n_agents_in         => n_agents_cm_tx,
      arb_type_in         => arb_type_cm_tx,

      av_in    => av_in,
      data_in  => data_in,
      comm_in  => comm_in,
      empty_in => empty_in,
      one_d_in => one_d_in,

      data_out       => data_out,
      comm_out       => comm_out,
      av_out         => av_out,
      lock_out       => lock_out,
      cfg_rd_rdy_out => cfg_rd_rdy_out,

      re_out => re_out
      );


  -- Design compiler ei ymm�rr� alempaa esittely�
  cm : cfg_mem
    --cm : entity work.cfg_mem
    generic map(
      counter_width_g => counter_width_g,
      id_g            => id_g,
      id_width_g      => id_width_g,

      data_width_g => data_width_g-(separate_addr_g*addr_width_g),

      cfg_addr_width_g => cfg_addr_width_g,  --16.12.05

      addr_g        => addr_g,
      prior_g       => prior_g,
      inv_addr_en_g => inv_addr_en_g,
      max_send_g    => max_send_g,
      arb_type_g    => arb_type_g,

      n_agents_g     => n_agents_g,
      n_cfg_pages_g  => n_cfg_pages_g,
      n_time_slots_g => n_time_slots_g,
      cfg_re_g       => cfg_re_g,
      cfg_we_g       => cfg_we_g
      )
    port map(
      clk   => clk,
      rst_n => rst_n,

      re_in    => cfg_re_in,
      we_in    => cfg_we_in,
      data_in  => cfg_data_in,
      addr_in  => cfg_addr_in,
      data_out => data_cm_tx,

      curr_slot_ends_out   => curr_slot_ends_cm_tx,
      curr_slot_own_out    => curr_slot_own_cm_tx,
      next_slot_starts_out => next_slot_starts_cm_tx,
      next_slot_own_out    => next_slot_own_cm_tx,

      arb_type_out => arb_type_cm_tx,
      n_agents_out => n_agents_cm_tx,
      max_send_out => max_send_cm_tx,
      prior_out    => prior_cm_tx,
      pwr_mode_out => pwr_mode_cm_tx

      );


end structural;
