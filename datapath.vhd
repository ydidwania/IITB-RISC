library ieee;	
use ieee.std_logic_1164.all;

entity datapath is
generic(
		zero16 : std_logic_vector := "0000000000000000";
		one16 : std_logic_vector := "0000000000000001"
	);
	port(
		ctrl_word 		           : in std_logic_vector(0 to 28);
	    clk			   : in std_logic;
	    carry,zero,alu_zero,f0,f1     : out std_logic;
		instr 		           : out std_logic_vector(0 to 15)
	);
end entity;

architecture behave of datapath is

--signals corresponding to control word
-------------------------------------------------------------------------------------------------------------
signal PC_E,Mem_RD,Mem_WR,IR_E,PE_RST,RF_WR,t1,t2,a,c,d,g,k : std_logic;
signal ALU_sel,b,f,h,i					    : std_logic_vector(0 to 1);
signal e,j						    : std_logic_vector(0 to 2);
-------------------------------------------------------------------------------------------------------------

--signals for connecting components
-------------------------------------------------------------------------------------------------------------
signal PC_in,IR_in,t1_in,t2_in,ALU_a,ALU_b,D3		    : std_logic_vector(0 to 15);
signal PC_out,IR_out,t1_out,t2_out,ALU_out,D1,D2,R7	    : std_logic_vector(0 to 15);
signal Z9_out,SE9_out,SE6_out,Mem_A,Mem_B,PC_R7,Mem_out	    : std_logic_vector(0 to 15);
-------------------------------------------------------------------------------------------------------------

component z9 is
	port(z9_in  : in std_logic_vector(0 to 8);
	     z9_out : out std_logic_vector(0 to 15));
end component;

component se9 is
	port(se9_in  : in std_logic_vector(0 to 8);
	     se9_out : out std_logic_vector(0 to 15));
end component;

component se6 is
	port(se6_in  : in std_logic_vector(0 to 5);
	     se6_out : out std_logic_vector(0 to 15));
end component;

component mux6to1 is
	port(in_1,in_2,in_3,in_4,in_5,in_6 : in std_logic_vector(0 to 15);
	     sel 	                   : in std_logic_vector(0 to 2);
	     mux_out	                   : out std_logic_vector(0 to 15));
end component;

component mux4to1 is
	port(in_1,in_2,in_3,in_4 : in std_logic_vector(0 to 15);
	     sel 	         : in std_logic_vector(0 to 1);
	     mux_out	         : out std_logic_vector(0 to 15));
end component;

component mux2to1 is
	port(in_1,in_2       : in std_logic_vector(0 to 15);
	     sel 	     : in std_logic;
	     mux_out	     : out std_logic_vector(0 to 15));
end component;

component reg_16bit is
	port(d 		    : in std_logic_vector(0 to 15);
	     clk,enable     : in std_logic;
	     q 		    : out std_logic_vector(0 to 15));
end component;

component alu is
	port(alu_a,alu_b	: in std_logic_vector(0 to 15);
	     sel		: in std_logic_vector(0 to 1);
	     alu_out 		: out std_logic_vector(0 to 15);
	     carry,zero,a_zero  : out std_logic);
end component;

--Insert components corresponding to memory,RF,PE

begin

PC_E    <= ctrl_word(0);
Mem_RD  <= ctrl_word(1);
Mem_WR  <= ctrl_word(2);
IR_E    <= ctrl_word(3);
PE_RST  <= ctrl_word(4);
RF_WR   <= ctrl_word(5);
t1      <= ctrl_word(6);
t2      <= ctrl_word(7);
ALU_sel <= ctrl_word(8 to 9);
a 	<= ctrl_word(10);
b 	<= ctrl_word(11 to 12);
c 	<= ctrl_word(13);
d 	<= ctrl_word(14);
e 	<= ctrl_word(15 to 17);
f 	<= ctrl_word(18 to 19);
g 	<= ctrl_word(20);
h 	<= ctrl_word(21 to 22);
i 	<= ctrl_word(23 to 24);
j 	<= ctrl_word(25 to 27);
k 	<= ctrl_word(28);

--Components other than MUX
-------------------------------------------------------------------------------------------------------------
ProgC : reg_16bit port map(d => PC_in, clk => clk, enable => PC_E, q => PC_out); -- PC register
IntsR : reg_16bit port map(d => IR_in, clk => clk, enable => IR_E, q => IR_out); -- IR register
Temp1 : reg_16bit port map(d => t1_in, clk => clk, enable => t1, q => t1_out); -- t1 register
Temp2 : reg_16bit port map(d => t2_in, clk => clk, enable => t2, q => t2_out); -- t2 register
AritLU: ALU       port map(alu_a => ALU_a, alu_b => ALU_b, sel => ALU_sel, alu_out => ALU_out,
						carry => carry, zero => zero, a_zero => alu_zero); -- ALU unit
--insert port mappings for memory, PE, RF, and MUXes which use their signals
Zero7 : z9	       port map(z9_in => IR_out(7 to 15), z9_out => Z9_out); 
SignE6: se6       port map(se6_in => IR_out(10 to 15), se6_out => SE6_out);
SignE9: se9       port map(se9_in => IR_out(7 to 15), se9_out => SE9_out);
-------------------------------------------------------------------------------------------------------------

--Multiplexors
-------------------------------------------------------------------------------------------------------------
mux_b : mux4to1 port map(in_1 => PC_out, in_2 => t2_out, in_3 => t1_out, in_4 => zero16,
			 sel => b, mux_out => Mem_A);
mux_c : mux2to1 port map(in_1 => t2_out, in_2 => t1_out, sel => c, mux_out => Mem_B);
mux_k:  mux2to1 port map(in_1 => PC_out, in_2 => R7, sel => k, mux_out => PC_R7);
D3_mux: mux4to1 port map(in_1 => PC_R7, in_2 => Z9_out, in_3 => t2_out, in_4 => t1_out,
			 sel => f, mux_out => D3);
T1_mux: mux2to1 port map(in_1 => D1, in_2 => ALU_out, sel => g, mux_out => t1_in);
T2_mux: mux4to1 port map(in_1 => Mem_out, in_2 => D2, in_3 => ALU_out, in_4 => zero16,
			 sel => h, mux_out => t2_in);
A_mux : mux4to1 port map(in_1 => PC_R7, in_2 => t1_out, in_3 => SE6_out, in_4 => t2_out,
			 sel => i, mux_out => ALU_a);
B_mux : mux6to1 port map(in_1 => t1_out, in_2 => t2_out, in_3 => SE6_out, in_4 => SE9_out,
		     in_5 => zero16, in_6 => one16, sel => j,
		         mux_out => ALU_b);
-------------------------------------------------------------------------------------------------------------
end behave;
