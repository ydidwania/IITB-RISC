
module memory_system (
	onchip_memory_0_clk1_clk,
	onchip_memory_0_reset1_reset,
	onchip_memory_0_reset1_reset_req,
	onchip_memory_0_s1_address,
	onchip_memory_0_s1_clken,
	onchip_memory_0_s1_chipselect,
	onchip_memory_0_s1_write,
	onchip_memory_0_s1_readdata,
	onchip_memory_0_s1_writedata);	

	input		onchip_memory_0_clk1_clk;
	input		onchip_memory_0_reset1_reset;
	input		onchip_memory_0_reset1_reset_req;
	input	[9:0]	onchip_memory_0_s1_address;
	input		onchip_memory_0_s1_clken;
	input		onchip_memory_0_s1_chipselect;
	input		onchip_memory_0_s1_write;
	output	[7:0]	onchip_memory_0_s1_readdata;
	input	[7:0]	onchip_memory_0_s1_writedata;
endmodule
