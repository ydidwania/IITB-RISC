library ieee;	
use ieee.std_logic_1164.all;

entity z7 is
	port(
		z7_in  : in std_logic_vector(0 to 6);
		z7_out : out std_logic_vector(0 to 15)
	);
end entity;

architecture behave of z7 is
begin
	process(z7_in)
	begin
		z7_out <= z7_in & "000000000";
	end process;
end behave;
