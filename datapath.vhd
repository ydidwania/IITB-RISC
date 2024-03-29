library ieee;	
use ieee.std_logic_1164.all;

entity datapath is
generic(
		zero16 : std_logic_vector := "0000000000000000";
		one16 : std_logic_vector := "0000000000000001"
	);
	port(ctrl_word 		            : in std_logic_vector(0 to 28);
	     clk, reset					   : in std_logic;
	     carry,zero,alu_zero,f0,f1   : out std_logic;
	     instr 		           			: out std_logic_vector(0 to 15)
	);
end entity;

architecture behave of datapath is

--signals corresponding to control word
-------------------------------------------------------------------------------------------------------------
signal PC_E,Mem_RD,Mem_wr,IR_E,PE_RST,RF_WR,t1,t2,a,c,d,g,k, PC_enable : std_logic;
signal ALU_sel,b,f,h,i					    : std_logic_vector(0 to 1);
signal e,j						    : std_logic_vector(0 to 2);
-------------------------------------------------------------------------------------------------------------

--signals for connecting components
-------------------------------------------------------------------------------------------------------------
signal PC_in,t1_in,t2_in,ALU_a,ALU_b,D3		    : std_logic_vector(0 to 15);
signal PC_out,IR_out,t1_out,t2_out,ALU_out,D1,D2,R7	    : std_logic_vector(0 to 15);
signal Z9_out,SE9_out,SE6_out,Mem_addr,Mem_di,PC_R7,mkc,Mem_do	    : std_logic_vector(0 to 15);
signal a_select						    : std_logic_vector(0 to 1);
signal PE_out,A1,A2,A3					    : std_logic_vector(0 to 2);
signal m						    : std_logic;
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
	     clk,enable, reset     : in std_logic;
	     q 		    : out std_logic_vector(0 to 15));
end component;

component alu is
	port(alu_a,alu_b	: in std_logic_vector(0 to 15);
	     sel		: in std_logic_vector(0 to 1);
		  reset, rf_wr, clk:  in std_logic;
	     alu_out 		: out std_logic_vector(0 to 15);
	     carry,zero,a_zero  : out std_logic);
end component;

component priority_encoder is
	port (
		ir	: in std_logic_vector (0 to 7);
		clk,rst : in std_logic;
		Z	: inout std_logic_vector(0 to 2);
		F1,F0	: out std_logic
	);
end component;

component reg_file is
	port (
		a1,a2,a3	: in std_logic_vector (0 to 2);
		d3		: in std_logic_vector (0 to 15);
		wr_en,clk, reset	: in std_logic;
		d1,d2,R7	: out std_logic_vector(0 to 15)
	);
end component;

component mux3bit2to1 is
	port(in_1,in_2       : in std_logic_vector(0 to 2);
		sel 	     : in std_logic;
		mux_out	     : out std_logic_vector(0 to 2));
end component;

component mux3bit6to1 is
	port(in_1,in_2,in_3,in_4,in_5,in_6 : in std_logic_vector(0 to 2);
		sel 	                   : in std_logic_vector(0 to 2);
		mux_out	                   : out std_logic_vector(0 to 2));
end component;

component memory is
	port(
	    Mem_di, Mem_addr   : in std_logic_vector(0 to 15);
	    clk, Mem_we, Mem_re	: in std_logic;
	    Mem_do: out std_logic_vector(0 to 15)
	);
end component;
--Insert components corresponding to memory

begin

PC_E 	  <= ctrl_word(0);
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

process(A3, PC_R7, R7, PC_out, k)
begin
	if(A3 = "111") then
		m <= '1';
	else
		m <= '0';
	end if;
	
	if k='1' then
		PC_R7 <= R7;
	else
		PC_R7 <= PC_out;
	end if;
end process;

process(a_select, D3, t2_out, ALU_out)
begin
	if a_select(1) = '1' then
		PC_in <= D3;
	elsif a_select(0) = '1' then
		PC_in <= t2_out;
	else
		PC_in <= ALU_out;
	end if;
end process; 

a_select(0) <= a;
a_select(1) <= (m and not(PC_E) and RF_WR);
PC_Enable    <= PC_E or (m and RF_WR);


--Components other than MUX
-------------------------------------------------------------------------------------------------------------
ProgC : reg_16bit 	 port map(d => PC_in, clk => clk, reset=>reset, enable => PC_Enable, q => PC_out); 			-- PC register
IntsR : reg_16bit 	 port map(d => Mem_do, clk => clk, reset=>reset, enable => IR_E, q => IR_out); 			-- IR register
Temp1 : reg_16bit 	 port map(d => t1_in, clk => clk, reset=>reset, enable => t1, q => t1_out); 				-- t1 register
Temp2 : reg_16bit 	 port map(d => t2_in, clk => clk, reset=>reset, enable => t2, q => t2_out); 				-- t2 register
AritLU: ALU       	 port map(alu_a => ALU_a, alu_b => ALU_b, sel => ALU_sel, rf_wr=>RF_WR, reset=>reset, clk=>clk, alu_out => ALU_out,
				  carry => carry, zero => zero, a_zero => alu_zero); 				-- ALU
mem0_60: memory port map(Mem_di=>Mem_di, Mem_addr=>Mem_addr, Mem_we=>Mem_WR, Mem_re=>Mem_RD,clk=>clk,Mem_do=>Mem_do);
--insert port mappings for memory and MUXes which use their signals
Zero7 : z9	  	 port map(z9_in => IR_out(7 to 15), z9_out => Z9_out); 
SignE6: se6       	 port map(se6_in => IR_out(10 to 15), se6_out => SE6_out);
SignE9: se9       	 port map(se9_in => IR_out(7 to 15), se9_out => SE9_out);
PE    : priority_encoder port map(ir => IR_out(8 to 15), clk => clk, rst => PE_RST, Z => PE_out, F1 => f1,
				  F0 => f0);									--Priority encoder
RF    : reg_file 	 port map(a1 => A1, a2 => A2, a3 => A3, d3 => D3, wr_en => RF_WR, clk => clk, reset=>reset,
				  d1 => D1, d2 => D2, R7 => R7);
-------------------------------------------------------------------------------------------------------------
-- Direct assignments
A1 <= IR_out(4 to 6);
instr <= IR_out;
--mkc <= (k and R7) or (not k and PC_out);
-------------------------------------------------------------------------------------------------------------

--Multiplexors
-------------------------------------------------------------------------------------------------------------
--mux_a : mux4to1     port map(in_1 => ALU_out, in_2 => D3, in_3 => t2_out, in_4 => D3,
--			     sel => a_select, mux_out => PC_in); -- if a_select(1) then D3  else if a then t2_out else alu_out
mux_b : mux4to1     port map(in_1 => PC_out, in_2 => t2_out, in_3 => t1_out, in_4 => zero16,
			     sel => b, mux_out => Mem_addr);
mux_c : mux2to1     port map(in_1 => t2_out, in_2 => t1_out, sel => c, mux_out => Mem_di);
mux_d : mux3bit2to1 port map(in_1 => PE_out, in_2 => IR_out(7 to 9), sel => d, mux_out => A2);
mux_e : mux3bit6to1 port map(in_1 => PE_out, in_2 => IR_out(4 to 6), in_3 => IR_out(7 to 9),
			     in_4 => IR_out(10 to 12), in_5 => "111", in_6 => "000", 
				 sel => e, mux_out => A3);
--mux_k:  mux2to1     port map(in_1 => PC_out, in_2 => R7, sel => k, mux_out => PC_R7);

D3_mux: mux4to1     port map(in_1 => PC_R7, in_2 => Z9_out, in_3 => t2_out, in_4 => t1_out,
			     sel => f, mux_out => D3);
T1_mux: mux2to1     port map(in_1 => D1, in_2 => ALU_out, sel => g, mux_out => t1_in);
T2_mux: mux4to1     port map(in_1 => Mem_do, in_2 => D2, in_3 => ALU_out, in_4 => zero16,
			     sel => h, mux_out => t2_in);
A_mux : mux4to1     port map(in_1 => PC_R7, in_2 => t1_out, in_3 => SE6_out, in_4 => t2_out,
			     sel => i, mux_out => ALU_a);
B_mux : mux6to1     port map(in_1 => t1_out, in_2 => t2_out, in_3 => SE6_out, in_4 => SE9_out,
		             in_5 => zero16, in_6 => one16, sel => j, mux_out => ALU_b);
-------------------------------------------------------------------------------------------------------------
end behave;

