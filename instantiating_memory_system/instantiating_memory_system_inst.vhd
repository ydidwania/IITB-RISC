	component instantiating_memory_system is
		port (
			system_0_onchip_memory_0_clk1_clk         : in  std_logic                     := 'X';             -- clk
			system_0_onchip_memory_0_reset1_reset     : in  std_logic                     := 'X';             -- reset
			system_0_onchip_memory_0_reset1_reset_req : in  std_logic                     := 'X';             -- reset_req
			system_0_onchip_memory_0_s1_address       : in  std_logic_vector(15 downto 0) := (others => 'X'); -- address
			system_0_onchip_memory_0_s1_clken         : in  std_logic                     := 'X';             -- clken
			system_0_onchip_memory_0_s1_chipselect    : in  std_logic                     := 'X';             -- chipselect
			system_0_onchip_memory_0_s1_write         : in  std_logic                     := 'X';             -- write
			system_0_onchip_memory_0_s1_readdata      : out std_logic_vector(15 downto 0);                    -- readdata
			system_0_onchip_memory_0_s1_writedata     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			system_0_onchip_memory_0_s1_byteenable    : in  std_logic_vector(1 downto 0)  := (others => 'X')  -- byteenable
		);
	end component instantiating_memory_system;

	u0 : component instantiating_memory_system
		port map (
			system_0_onchip_memory_0_clk1_clk         => CONNECTED_TO_system_0_onchip_memory_0_clk1_clk,         --   system_0_onchip_memory_0_clk1.clk
			system_0_onchip_memory_0_reset1_reset     => CONNECTED_TO_system_0_onchip_memory_0_reset1_reset,     -- system_0_onchip_memory_0_reset1.reset
			system_0_onchip_memory_0_reset1_reset_req => CONNECTED_TO_system_0_onchip_memory_0_reset1_reset_req, --                                .reset_req
			system_0_onchip_memory_0_s1_address       => CONNECTED_TO_system_0_onchip_memory_0_s1_address,       --     system_0_onchip_memory_0_s1.address
			system_0_onchip_memory_0_s1_clken         => CONNECTED_TO_system_0_onchip_memory_0_s1_clken,         --                                .clken
			system_0_onchip_memory_0_s1_chipselect    => CONNECTED_TO_system_0_onchip_memory_0_s1_chipselect,    --                                .chipselect
			system_0_onchip_memory_0_s1_write         => CONNECTED_TO_system_0_onchip_memory_0_s1_write,         --                                .write
			system_0_onchip_memory_0_s1_readdata      => CONNECTED_TO_system_0_onchip_memory_0_s1_readdata,      --                                .readdata
			system_0_onchip_memory_0_s1_writedata     => CONNECTED_TO_system_0_onchip_memory_0_s1_writedata,     --                                .writedata
			system_0_onchip_memory_0_s1_byteenable    => CONNECTED_TO_system_0_onchip_memory_0_s1_byteenable     --                                .byteenable
		);

