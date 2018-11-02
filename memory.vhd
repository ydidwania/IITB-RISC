
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

type ram_type is array (0 to 63) of std_logic_vector(0 to 15);
--signal RAM: ram_type:= (X"3007", X"3205", X"0050",others => X"0000");
signal RAM : ram_type :=
(
	 0  =>   "0011000000000000",  --lhi
	 1  =>   "0011001000000000",
	 2  =>   "0011010000000001",
	 3  =>   "0011011000000010",
	 4  =>   "0011100000000011",
	 5  =>   "0011101000000100",
	 6  =>   "0011110000000101", --lhi

	 7  =>   "0000010011010001", --r2=r2+r3 if z
	 8  =>   "0000000001000000", --r0=r1+r0
	 9  =>   "0000010011010001", --r2=r2+r3 if z
	10  =>   "0000100101100000", --r4=r4+r5
	11  =>   "0001110110000111", --r6=r6+000111
	12  =>   "0010110111110001", --R6=R6 NAND R7 IF Z
	13  =>   "0000000001000000", --r0=r1+r0
	14  =>   "0010110111110001", --R6=R6 NAND R7 IF Z
	15  =>   "0010011100011000", --r3=r3 nand r4


	16  =>   "0010011000011000",-- r3=r3 nand r0
	17  =>   "0000101110101010",--r5=r5+r6 if C
	18  =>   "0000011100100000",--r4=r3+r4
	19  =>   "0000101110101010",--r5=r5+r6 if C
	20  =>   "0010101110101010",--r5 = r5 nand r6 if c
	21  =>   "0000011100100000",--r4=r3+r4
	22  =>   "0010101110101010",--r5 = r5 nand r6 if c
	23  =>   "0010000001001000",--r1=r1 nand r0
	24  =>   "0010011001011000",--r3= r3 nand r1
	25  =>   "0011000000000001",-- lhi r0= 1
	26  =>   "0011001000000010",-- lhi r1 = 2
	27  =>   "0011010000000010",-- lhi r2= 2
	28  =>   "1100000001000010",-- beq r0,r1,2
	29  =>   "1100001010000001",-- beq r1,r2,1
	30  =>   "0011100000000000",-- lhi r4,0
	31  =>   "0011100111111111",-- lhi r4,111111111
	others => X"0000"

) ;

signal short_address : std_logic_vector(0 to 5);

begin
	short_address <= Mem_addr(10 to 15);
	Synch_RAM: process(clk)
	begin
		if rising_edge (clk) then
			if Mem_we='1' then
				RAM(to_integer(unsigned(short_address))) <= Mem_di ;
			end if;	
		end if;
		
		--if Mem_re='1' then
		--	Mem_do <=	RAM(to_integer(unsigned(short_address)));
		--end if;
	end process;
	Mem_do <=	RAM(to_integer(unsigned(short_address)));
end comb;
