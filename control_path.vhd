library std;
use std .standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity control_path is
	port (
		opcode: in std_logic_vector (0 to 15);
		current_state: in std_logic_vector(0 to 4);
		C,Z,alu_z,F0,F1: in std_logic;
		control_word: out std_logic_vector (0 to 29);
		next_state: out std_logic_vector ( 0 to  4)
	);
end entity;
architecture behave of control_path is

	signal dec1,dec2,dec3,dec4,dec5,dec6,dec7 : std_logic_vector(0 to 4);
	signal s1: std_logic;
	signal alu_op : std_logic_vector(0 to 1);
	
	component mux_state is
		port (
			inp0, inp1: in std_logic_vector(0 to 4);
			s : in std_logic;
			z : out std_logic_vector(0 to 4)
		);
	end component;

begin


d2: mux_state port map(inp0=>"01010", inp1=>"01000",s=>s1, z=>dec2);  -- if s1==1, d2=s10 else d2=s8;
d3: mux_state port map(inp0=>"00001", inp1=>"01100",s=>alu_z, z=>dec3);
d4: mux_state port map(inp0=>"10000", inp1=>"00001",s=>F0, z=>dec4);
d5: mux_state port map(inp0=>"10000", inp1=>"00001",s=>F1, z=>dec5);
d6: mux_state port map(inp0=>"10010", inp1=>"00001",s=>F0, z=>dec6);
d7: mux_state port map(inp0=>"10010", inp1=>"00001",s=>F1, z=>dec7);


-----------------------------------------------
-- PLEASE NOTE THAT OPCODE(0) refers to the first bit(MSB)
-- in the intstruction encoding provided.
-- The compiler will have to provide reversed encoding
-- of the instruction for this to work
------------------------------------------------
	-- s1=1 if opcode=SW, else s1=0 if opcode=LW
	process(opcode)
		variable f_1,f_0 : boolean;
	begin
			if (opcode(0 to 3)="0101") then --SW
				s1<='1';
			else
				s1<='0';
			end if;
			
			if opcode(0 to 3)="0000" or opcode(0 to 3)="0010" then --ADD/NAND
				f_1 := opcode(14)='1';
				f_0 := opcode(15)='1';
				if (not f_1 and not f_0) or (f_1 and not f_0 and C='1') or (not f_1 and f_0 and Z='1') then
					dec1<="00011"; --S3 if 1
				else
					dec1<="00001"; --S1 if 0
				end if;
			elsif opcode(0 to 3)="0001" then --ADI
				dec1<="00100";
			elsif opcode(0 to 3)="0011" then --LHI
				dec1<="00110";
			elsif opcode(0 to 2)="010" then --LW/SW
				dec1<="00111";
			elsif opcode(0 to 3)="1100" then --BEQ
				dec1<="01011";
			elsif opcode(0 to 3)="1000" then --JAL 
				dec1<="01101";
			elsif opcode(0 to 3)="1001" then --JLR 
				dec1<="01110";
			elsif opcode(0 to 3)="0110" then --LM
				dec1<="01111";
			elsif opcode(0 to 3)="0101" then --SM
				dec1<="10001";
			else   -- move to state1 and fetch next instruction.
				dec1<="00001";
			end if;
			
			if opcode(0 to 3)="0000" then
				alu_op<="00";
			else
				alu_op<="10";
			end if;
	end process;


	process(current_state,dec1,dec2,dec3,dec4,dec5,dec6,dec7,alu_op)
	begin
		case(current_state) is 
			when "00001" => control_word<="110100000100000001000000000101"; next_state<="00010";
			when "00010" => control_word<="000010110000000010000000000000"; next_state<=dec1;
			when "00011" => control_word<="00000010" & alu_op & "00000000000010001001"; next_state<="10011";
			when "00100" => control_word<="000000100100000000000010010101"; next_state<="00101";
			when "00101" => control_word<="000001000000000000101100000000"; next_state<="00001";
			when "00110" => control_word<="000001000000000000010100000000"; next_state<="00001";
			when "00111" => control_word<="000000010100000000000001010001"; next_state<=dec2;
			when "01000" => control_word<="010000010000010000000000000000"; next_state<="01001";
			when "01001" => control_word<="000001000000000000011000011100"; next_state<="00001";
			when "01010" => control_word<="001000000000010100000000000000"; next_state<="00001";
			when "01011" => control_word<="000000001100000000000000001001"; next_state<=dec3;
			when "01100" => control_word<="100000000000000000000000000010"; next_state<="00001";
			when "01101" => control_word<="100001000100000000010000000011"; next_state<="00001";
			when "01110" => control_word<="100001000001000000010000000000"; next_state<="00001";
			when "01111" => control_word<="010010110100000000000010001101"; next_state<=dec4;
			when "10000" => control_word<="010001110100100000001010001101"; next_state<=dec5;
			when "10001" => control_word<="000000010000000000000000100000"; next_state<=dec6;
			when "10010" => control_word<="001000110100100010000010101101"; next_state<=dec7;
			when "10011" => control_word<="000001000000000000111100000000"; next_state<="00001";
			when others => control_word<="000000000000000000000000000000"; next_state<="00001";
		end case;
	------------------------------
	end process;

end behave;
