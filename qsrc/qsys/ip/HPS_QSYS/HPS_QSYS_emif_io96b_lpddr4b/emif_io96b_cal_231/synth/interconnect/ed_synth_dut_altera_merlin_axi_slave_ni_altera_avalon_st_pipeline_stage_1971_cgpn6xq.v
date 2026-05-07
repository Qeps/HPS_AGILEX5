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
module ed_synth_dut_altera_merlin_axi_slave_ni_altera_avalon_st_pipeline_stage_1971_cgpn6xq #(
		parameter SYMBOLS_PER_BEAT = 1,
		parameter BITS_PER_SYMBOL  = 188,
		parameter USE_PACKETS      = 1,
		parameter USE_EMPTY        = 0,
		parameter EMPTY_WIDTH      = 0,
		parameter CHANNEL_WIDTH    = 0,
		parameter PACKET_WIDTH     = 2,
		parameter ERROR_WIDTH      = 0,
		parameter PIPELINE_READY   = 1,
		parameter SYNC_RESET       = 0
	) (
		input  wire         clk,               
		input  wire         reset,             
		output wire         in_ready,          
		input  wire         in_valid,          
		input  wire         in_startofpacket,  
		input  wire         in_endofpacket,    
		input  wire [187:0] in_data,           
		input  wire         out_ready,         
		output wire         out_valid,         
		output wire         out_startofpacket, 
		output wire         out_endofpacket,   
		output wire [187:0] out_data           
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
	) my_altera_avalon_st_pipeline_stage_rp (
		.clk               (clk),               
		.reset             (reset),             
		.in_ready          (in_ready),          
		.in_valid          (in_valid),          
		.in_startofpacket  (in_startofpacket),  
		.in_endofpacket    (in_endofpacket),    
		.in_data           (in_data),           
		.out_ready         (out_ready),         
		.out_valid         (out_valid),         
		.out_startofpacket (out_startofpacket), 
		.out_endofpacket   (out_endofpacket),   
		.out_data          (out_data),          
		.in_empty          (1'b0),              
		.out_empty         (),                  
		.out_error         (),                  
		.in_error          (1'b0),              
		.out_channel       (),                  
		.in_channel        (1'b0)               
	);

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1adhEICNNX+X0+RX62oG1vNcaQoRwv4o3GzntP0ULvW2k1ZgFLH0yhuWp483CncsesGyGz0f7Q7dzDPUnaOT8tPpPDYXpoa6Eo1KvXobCnU+MYfKUpM8C1jAqEJXUeqeCGl8oW85FF29IaJXVknNQ1fnxHp8vQ7xal7tL0i3qIvviId+d/nHJT6HOo4nzGR6yoFhUNMf3W83deNGzeokVxHPE3wQDAZ+PlYCxeGp0NX6TZJ8rQZBAsaJiIuqKncd1sUpKqFfD3kqbkJPyDfyXfhQSRzEaMLHwFS35QQM5oQnAhJcR233qYm1fu2+/HfM02OUZhHlHtrwpApfyt8wE9ECfyC+dH2wy35o4ltjITsYZxfM1gjDdxsZgCpHOe84so7DNVJ+79PbDlaHSRU/m/8AvouURAJNH9NQ33hyed5qgyHFPu5992o5N0B4GDc0jVMtNiuZyHBYSyeHSPgu7C0TNNryl64j0yXYNHt5fyPmPNxOlv1Jt6G5x/J/wkgeG1BZaqFpVq9kv1QjRXKurF+tbM0jPvFg/UqGfbC0sJ7LBR4mSWeBHhXz9btGOoBgMsTAN8oeIFvuK9fZEzXJ8AL7AcsiLTgW96HDkn8YBVVp29cEoViUlmbDr2AJ/78PKJSNXLhUm4Z3EbkTXPkPA02Hz4Nzk/ZFYRftyjy9bvXOQg5h8Z7TTIlsRyIKpmzFlldX6exvlm17XF/VDhTsw6BMoK88zSpyhTGgXR3GBzZ9Yazt/pNlqUJO0jg4t5o6+vxtEygqdoFl5YIF82ALI00"
`endif