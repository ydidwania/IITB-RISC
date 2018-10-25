library ieee;
use ieee.std_logic_1164.all;

entity reg_16bit is
	port (
		d: in std_logic_vector(0 to 15);
        clk, enable : in std_logic;
		q: out std_logic_vector(0 to 15)
	);
end entity;
architecture behave of reg_16bit is
	begin
		process(clk)
			begin
				if(rising_edge(clk) and enable='1') then
					q<=d;
			end if;
		end process;
end behave;