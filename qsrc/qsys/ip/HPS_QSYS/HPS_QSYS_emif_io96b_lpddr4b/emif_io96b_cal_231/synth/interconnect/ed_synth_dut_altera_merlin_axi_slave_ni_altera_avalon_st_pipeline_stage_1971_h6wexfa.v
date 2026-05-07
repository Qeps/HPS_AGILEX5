// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.




`timescale 1 ps / 1 ps
module ed_synth_dut_altera_merlin_axi_slave_ni_altera_avalon_st_pipeline_stage_1971_h6wexfa #(
		parameter SYMBOLS_PER_BEAT = 1,
		parameter BITS_PER_SYMBOL  = 4,
		parameter USE_PACKETS      = 0,
		parameter USE_EMPTY        = 0,
		parameter EMPTY_WIDTH      = 0,
		parameter CHANNEL_WIDTH    = 0,
		parameter PACKET_WIDTH     = 0,
		parameter ERROR_WIDTH      = 0,
		parameter PIPELINE_READY   = 0,
		parameter SYNC_RESET       = 0
	) (
		input  wire       clk,       
		input  wire       reset,     
		output wire       in_ready,  
		input  wire       in_valid,  
		input  wire [3:0] in_data,   
		input  wire       out_ready, 
		output wire       out_valid, 
		output wire [3:0] out_data   
	);

	ed_synth_dut_altera_avalon_st_pipeline_stage_1930_bv2ucky #(
		.SYMBOLS_PER_BEAT (SYMBOLS_PER_BEAT),
		.BITS_PER_SYMBOL  (BITS_PER_SYMBOL),
		.USE_PACKETS      (USE_PACKETS),
		.USE_EMPTY        (USE_EMPTY),
		.EMPTY_WIDTH      (EMPTY_WIDTH),
		.CHANNEL_WIDTH    (CHANNEL_WIDTH),
		.PACKET_WIDTH     (PACKET_WIDTH),
		.ERROR_WIDTH      (ERROR_WIDTH),
		.PIPELINE_READY   (PIPELINE_READY),
		.SYNC_RESET       (SYNC_RESET)
	) my_altera_avalon_st_pipeline_stage_wr (
		.clk               (clk),       
		.reset             (reset),     
		.in_ready          (in_ready),  
		.in_valid          (in_valid),  
		.in_data           (in_data),   
		.out_ready         (out_ready), 
		.out_valid         (out_valid), 
		.out_data          (out_data),  
		.in_startofpacket  (1'b0),      
		.in_endofpacket    (1'b0),      
		.out_startofpacket (),          
		.out_endofpacket   (),          
		.in_empty          (1'b0),      
		.out_empty         (),          
		.out_error         (),          
		.in_error          (1'b0),      
		.out_channel       (),          
		.in_channel        (1'b0)       
	);

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1aocBXfeBAkvGaDoT076D6ZR4vzj89wqvoW60PKmeZLpk0pG2o6Kwp2R3EGx9Wd58U/o/NwZT8aW5Gt/+4h0Aoz6Gg+66hetU2e9Wt3WNTM1kpM4197rcgIvd9DPowDJPoXIeSVfTzBRDqr6FXIrWdoUhiFNq25MyTbcOE1kvTjAzPDjNcP9rDVR6H2Ceo4lFP288iMxTSIGiVGAWrtVZsBgVrdRD2HsfrfBF99InMG4SX8nQ71UwOEV/t0bD+5PjK/YMFMmm0R+M/jjucDq87ld+KoYPOg8cJYHwYIoTi1aglF2r7GRE9YVqBR0MlibkDB4Yi53Jm8Hr58odaEGGIu/OoetnO8rF9eJ02mGiOjSHB5NU3HsVdsQ8WGQEATlvxbbxgkURXg+f6I2jSuEM2O7We/+4gqOC0qqxQ6rzVXWANjb5gMGnzPmxDSB1SpzxXbncDZ3FSaFli6yx0aWrJFG3E+m/5AXPSu3MyqVK6otTYnlas3wJtnsdL+cY1LYlc2hEL7P2EnYizs2JYxWCs6YsJOgf/Gb378HCRZy4jMGkyiXs6M1oaJMedHkzdLGZqMluu4PDAfDWw7bGOA2kJrdgMXJOSvAHPrXgLOnPsLkCg1SEkIPj9w93SXtabXGFR63nCg/Kx+qdc4sqm6DWnp01DkkYGB2Kd2TRhLwJgF1j0wwVll5Y0jCDCNnQ9lulNShuqH8o2XnXjua/WeXaC/TXX65pZlEQn4zWH/3fw8pFbASOB4NAI/IhHe4qHspUuwFKYWF3QKbq7B7NqDZGKT"
`endif