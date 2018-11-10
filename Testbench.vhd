library ieee;
use ieee.numeric_std.all; 
use ieee.std_logic_1164.all;
library std;
use std.textio.all;



entity Testbench is
end entity;
architecture Behave of Testbench is
	component main is
		port(
			clk, reset			   : in std_logic
		);
	end component;

  signal clk,reset,W: std_logic := '0';

  function to_std_logic(x: bit) return std_logic is
      variable ret_val: std_logic;
  begin  
      if (x = '1') then
        ret_val := '1';
      else 
        ret_val := '0';
      end if;
      return(ret_val);
  end to_std_logic;

  function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin  
      ret_val := lx;
      return(ret_val);
  end to_string;

begin
  process 
    variable err_flag : boolean := false;
--    File INFILE: text open read_mode is "D:\VHDL\Projects\StringRecognizer\tracefile2.txt";
--    FILE OUTFILE: text  open write_mode is "D:\VHDL\Projects\StringRecognizer\OUTPUTS.txt";

    ---------------------------------------------------
    -- edit the next two lines to customize
    variable input_vector: std_logic_vector ( 1 downto 0) := "10";
	 variable tmp_input : std_logic_vector (1 downto 0);
    variable output_vector: bit;
	 variable tmp: bit := '1';
	 variable only1 : std_logic_vector(1 downto 0) := "01";
    ----------------------------------------------------
    variable INPUT_LINE: Line;
    variable OUTPUT_LINE: Line;
    variable LINE_COUNT: integer := 0;
	 
    
  begin
   
    while (true) loop

          --------------------------------------
          -- from input-vector to DUT inputs
		if tmp='1' then
			reset <= (input_vector(1));
		else
			reset <= '0';
		end if;
		clk <= (input_vector(0));
          --------------------------------------


	  -- let circuit respond.
      wait for 5 ns;
		tmp_input := std_logic_vector(unsigned(input_vector) + unsigned(only1));
		input_vector := tmp_input;
		if input_vector = "00"  then
			tmp := '0';
		end if;
		
          --------------------------------------
	  -- check outputs.
--	  if (W /= to_std_logic(output_vector)) then
--             
--             err_flag := true;
--          end if;
--			 
--             write(OUTPUT_LINE, to_bit(w));
--             writeline(OUTFILE, OUTPUT_LINE);
          --------------------------------------
    end loop;

    assert (err_flag) report "SUCCESS, all tests passed." severity note;
    assert (not err_flag) report "FAILURE, some tests failed." severity error;

  wait;
  end process;

  dut: main 
     port map(clk => clk,
				  reset => reset
				  --clk_50 => cant produce this  clock hence commented
		);

end Behave;