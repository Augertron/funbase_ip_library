-------------------------------------------------------------------------------
-- Title      : Pseudo random number generator r2
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pseudo_rand_gen_r2.vhd
-- Author     : jua
-- Last update: 30.06.2010
--
--
-------------------------------------------------------------------------------
-- Copyright (c) 2010
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 30.06.2010    0.1     jua      created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pseudo_rand_gen_r2 is
  generic (
--    RAND_WIDTH : integer := 8;
--    RAND_PORTS : integer := 1;
    RAND_START_0 : unsigned(3 downto 0) := x"0";
    RAND_START_1 : unsigned(3 downto 0) := x"0" );
  port (
    clk   : in std_logic;
    rst_n : in std_logic;
    
--    req_next_rand_in	: in  std_logic;
		rand_out : out std_logic_vector(3 downto 0) );

end pseudo_rand_gen_r2;

architecture rtl of pseudo_rand_gen_r2 is
  
  type rand_table_t is array (0 to 15) of unsigned(3 downto 0);
  constant rand_table : rand_table_t := (
    x"4", x"7", x"1", x"0", x"F", x"9", x"2", x"6", x"A", x"3", x"E", x"C", x"B", x"5", x"D", x"8" );
  
  type rand_port_t is array (0 to 1) of unsigned(3 downto 0);
  signal rand_r : unsigned(3 downto 0);
  
  
  type rand_table_addr_t is array (0 to 1) of unsigned(3 downto 0);
  type rand_table_addr_i_t is array (0 to 1) of integer;
  
  signal rand_table_addr_0_r : unsigned(3 downto 0);
  signal rand_table_addr_1_r : unsigned(3 downto 0);
  
--  signal rand_table_addr_0_i : integer;
--  signal rand_table_addr_1_i : integer;
  
begin
  
  rand_out <= std_logic_vector(rand_r);
  
--  rand_table_addr_0_i <= to_integer(rand_table_addr_0_r); 
  
  
  
  
  
--  rand_table_addr_1_i <= to_integer(rand_table_addr_1_r);
  
  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      
      rand_table_addr_0_r <= RAND_START_0;
      rand_table_addr_1_r <= RAND_START_1;
      
    elsif (clk'event and clk = '1') then
      rand_r <= rand_table(to_integer(rand_table_addr_0_r xor rand_table_addr_1_r));
      
      rand_table_addr_0_r <= rand_table(to_integer(rand_table_addr_0_r xor rand_table_addr_1_r));
      
      rand_table_addr_1_r <= rand_table_addr_1_r + 1;
      
    end if;
  end process;
  
  
end rtl;
