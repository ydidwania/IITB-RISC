
library ieee;	
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity memory is
	port(
	    Mem_di, Mem_addr   : in std_logic_vector(0 to 15);
	    clk, Mem_we, Mem_re	: in std_logic;
	    Mem_do: out std_logic_vector(0 to 15)
	);
end entity;

architecture comb of memory is

type mem_array is array (0 to 60) of std_logic_vector(0 to 15);
signal RAM: mem_array:= (X"3007", X"3205", X"0050",others => X"0000");

begin
	Synch_RAM: process(clk)
	begin
		if rising_edge (clk) then
			if Mem_we='1' then
				RAM(to_integer(unsigned(Mem_addr))) <= Mem_di ;
			end if;	
		end if;
		
		--if Mem_re='1' then
		--	Mem_do <=	RAM(to_integer(unsigned(Mem_addr)));
		--end if;
	end process;
	Mem_do <=	RAM(to_integer(unsigned(Mem_addr)));
end comb;
