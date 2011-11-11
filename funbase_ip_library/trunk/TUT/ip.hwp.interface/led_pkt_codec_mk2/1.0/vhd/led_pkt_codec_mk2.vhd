-------------------------------------------------------------------------------
-- Title      : Led blinker for ase_mesh1
-- Project    : 
-------------------------------------------------------------------------------
-- File       : led_pkt_codec_mk2.vhd
-- Author     : Lasse Lehtonen
-- Company    : 
-- Created    : 2011-11-09
-- Last update: 2011-11-09
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2011 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2011-11-09  1.0      lehton87        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity led_pkt_codec_mk2 is
  
  port (
    clk       : in  std_logic;
    rst_n     : in  std_logic;
    cmd_in    : in  std_logic_vector(1 downto 0);
    data_in   : in  std_logic_vector(31 downto 0);
    stall_out : out std_logic;
    cmd_out   : out std_logic_vector(1 downto 0);
    data_out  : out std_logic_vector(31 downto 0);
    stall_in  : in  std_logic;
    led_out   : out std_logic);

end led_pkt_codec_mk2;


architecture rtl of led_pkt_codec_mk2 is

  signal led_r : std_logic;
  
begin  -- rtl

  data_out  <= (others => '0');
  cmd_out   <= (others => '0');
  stall_out <= '0';
  led_out   <= led_r;

  main_p : process (clk, rst_n)
  begin  -- process main_p
    if rst_n = '0' then                 -- asynchronous reset (active low)

      led_r <= '1';
      
    elsif clk'event and clk = '1' then  -- rising clock edge

      if cmd_in = "00" then
        -- no data coming in
      elsif cmd_in = "01" then
        -- address coming in
      elsif cmd_in = "10" then
        -- data coming in
        led_r <= not led_r;
      else
        -- not defined
      end if;
      
    end if;
  end process main_p;

  

end rtl;