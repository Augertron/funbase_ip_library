-- ****************************************************
-- ** File: altera_de_II_demo.vhd
-- ** Date: 27.10.2011 15:33:01
-- ** Description: 
-- **
-- ** This file was generated by Kactus2 vhdl generator
-- **
-- ****************************************************

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

entity altera_de_II_demo is

	port (
		clk : in std_logic;
		port_out : out std_logic;
		rst_n : in std_logic;
		toggle_in : in std_logic);

end altera_de_II_demo;

architecture structural of altera_de_II_demo is

	signal port_blinker_1_ena_in_sig_gen_1_ena_out : std_logic;
	signal port_blinker_1_val_in_sig_gen_1_sig_out : std_logic_vector(31 downto 0);

	component port_blinker
		generic (
			SIGNAL_WIDTH : integer := 32);
		port (
			clk : in std_logic;
			ena_in : in std_logic;
			port_out : out std_logic;
			rst_n : in std_logic;
			val_in : in std_logic_vector(31 downto 0));
	end component;

	component sig_gen
		generic (
			SIGNAL_VAL : integer := 100000000;
			SIGNAL_WIDTH : integer := 32);
		port (
			clk : in std_logic;
			ena_out : out std_logic;
			rst_n : in std_logic;
			sig_out : out std_logic_vector(31 downto 0);
			toggle_in : in std_logic);
	end component;



begin


	port_blinker_1 : port_blinker
		port map (
			rst_n => rst_n,
			val_in(31 downto 0) => port_blinker_1_val_in_sig_gen_1_sig_out(31 downto 0),
			port_out => port_out,
			ena_in => port_blinker_1_ena_in_sig_gen_1_ena_out,
			clk => clk);

	sig_gen_1 : sig_gen
		port map (
			sig_out(31 downto 0) => port_blinker_1_val_in_sig_gen_1_sig_out(31 downto 0),
			ena_out => port_blinker_1_ena_in_sig_gen_1_ena_out,
			clk => clk,
			toggle_in => toggle_in,
			rst_n => rst_n);

end structural;
