library ieee;
use ieee.std_logic_1164.all;

entity mux_state is
	port (
		inp0, inp1: in std_logic_vector(4 downto 0);
		s : in std_logic;
		z : out std_logic_vector(4 downto 0)
	);
end entity;
architecture behave of mux_state is
	begin
		process(inp0,inp1,s)
			begin
				if(s='1') then
					z <= inp1;
				else 
						z <= inp0;
			end if;
		end process;
end behave;