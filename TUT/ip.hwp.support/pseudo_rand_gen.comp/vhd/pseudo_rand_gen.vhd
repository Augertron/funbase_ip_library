-------------------------------------------------------------------------------
-- Title      : Pseudo random number generator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pseudo_rand_gen.vhd
-- Author     : jua
-- Last update: 30.07.2010
--
--
-------------------------------------------------------------------------------
-- Copyright (c) 2010
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 30.07.2010    0.1     jua      created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pseudo_rand_gen is
  generic (
--    RAND_WIDTH : integer := 8;
--    RAND_PORTS : integer := 1;
    RAND_START_0 : unsigned(3 downto 0) := x"0";
    RAND_START_1 : unsigned(3 downto 0) := x"0" );
  port (
    clk   : in std_logic;
    rst_n : in std_logic;
    
    req_next_rand_in	: in  std_logic_vector(1 downto 0);
		rand_port_0_out : out std_logic_vector(RAND_WIDTH-1 downto 0);
    rand_port_1_out : out std_logic_vector(RAND_WIDTH-1 downto 0) );

end pseudo_rand_gen;

architecture rtl of pseudo_rand_gen is
  
  type rand_table_t is array (0 to 15) of unsigned(3 downto 0);
  constant rand_table : rand_table_t := (
    x"4", x"7", x"1", x"0", x"F", x"9", x"2", x"6", x"A", x"3", x"E", x"C", x"B", x"5", x"D", x"8" );
  
--  type rand_array_t is array (0 to RAND_PORTS-1) of unsigned(7 downto 0);
--  signal rand_array : rand_array_t;
  
  
  signal req_next_rand : unsigned(1 downto 0);
  
  
  type rand_port_t is array (0 to 1) of unsigned(3 downto 0);
  signal rand_port : rand_port_t;
  
  
  type rand_table_addr_t is array (0 to 1) of unsigned(3 downto 0);
  type rand_table_addr_i_t is array (0 to 1) of integer;
  
  signal rand_table_addr_r : rand_table_addr_t;
  signal rand_table_addr_i : rand_table_addr_i_t;
  
begin
  
  req_next_rand <= unsigned(req_next_rand_in);
  rand_port_0_out <= std_logic_vector(rand_port(0));
  rand_port_1_out <= std_logic_vector(rand_port(1));
  
  gen_0 : for i in 0 to 1 generate
    rand_table_addr_i(i) <= to_integer(rand_table_addr_r(i)); 
  end generate;
    
  
  
  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      
      rand_table_addr_r(0) <= RAND_START_0;
      rand_table_addr_r(1) <= RAND_START_1;
      
    elsif (clk'event and clk = '1') then
      
      if (req_next_rand(0) = '1') then
        rand_port(0) <= rand_table(rand_table_addr_i(0));
        rand_table_addr_r(0) <= rand_table(rand_table_addr_i(0));
      end if;
      
      if (req_next_rand(1) = '1') then
        rand_port(1) <= rand_table(rand_table_addr_i(1));
        rand_table_addr_r(1) <= rand_table(rand_table_addr_i(1));
      end if;
      
    end if;
  end process;
  
  
  

end rtl;
