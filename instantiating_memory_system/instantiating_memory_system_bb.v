
module instantiating_memory_system (
	system_0_onchip_memory_0_clk1_clk,
	system_0_onchip_memory_0_reset1_reset,
	system_0_onchip_memory_0_reset1_reset_req,
	system_0_onchip_memory_0_s1_address,
	system_0_onchip_memory_0_s1_clken,
	system_0_onchip_memory_0_s1_chipselect,
	system_0_onchip_memory_0_s1_write,
	system_0_onchip_memory_0_s1_readdata,
	system_0_onchip_memory_0_s1_writedata,
	system_0_onchip_memory_0_s1_byteenable);	

	input		system_0_onchip_memory_0_clk1_clk;
	input		system_0_onchip_memory_0_reset1_reset;
	input		system_0_onchip_memory_0_reset1_reset_req;
	input	[15:0]	system_0_onchip_memory_0_s1_address;
	input		system_0_onchip_memory_0_s1_clken;
	input		system_0_onchip_memory_0_s1_chipselect;
	input		system_0_onchip_memory_0_s1_write;
	output	[15:0]	system_0_onchip_memory_0_s1_readdata;
	input	[15:0]	system_0_onchip_memory_0_s1_writedata;
	input	[1:0]	system_0_onchip_memory_0_s1_byteenable;
endmodule
