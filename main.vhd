library ieee;	
use ieee.std_logic_1164.all;

entity main is
	port(
	   clk, reset, clk_50  			   : in std_logic
		--clk_50 					: in std_logic
	);
end entity;

architecture behave of main is

component datapath is
	port(ctrl_word 		           : in std_logic_vector(0 to 28);
	     clk, reset			   : in std_logic;
	     carry,zero,alu_zero,f0,f1     : out std_logic;
	     instr 		           : out std_logic_vector(0 to 15)
	);
end component;

component control_path is
	port (
		opcode: in std_logic_vector (0 to 15);
		C,Z,alu_z,F0,F1, clk, reset: in std_logic;
		control_word: out std_logic_vector (0 to 28)
	);
end component;

signal control_word : std_logic_vector(0 to 28);
signal C,Z,alu_z,F0,F1: std_logic;
signal instruction: std_logic_vector(0 to 15);

begin

	ctrl_path: control_path port map(opcode=>instruction, clk=>clk, reset=>reset, control_word=>control_word, C=>C, Z=>Z, alu_z=>alu_z, F0=>F0, F1=>F1);
		
	dat_path: datapath port map(ctrl_word=> control_word, clk=>clk, reset=>reset, carry=>C, zero=>Z, 
										alu_zero=>alu_z, f0=>F0, f1=>F1, instr => instruction);
									
									
--	state_change: process(clk)
--	begin 
--		if (rising_edge(clk)) then
--			current_state<=next_state;
--		end if;
--	end process state_change;
 end behave;