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
module ed_synth_dut_altera_merlin_burst_adapter_altera_avalon_st_pipeline_stage_1931_glj62si #(
		parameter SYMBOLS_PER_BEAT = 1,
		parameter BITS_PER_SYMBOL  = 188,
		parameter USE_PACKETS      = 1,
		parameter USE_EMPTY        = 0,
		parameter EMPTY_WIDTH      = 0,
		parameter CHANNEL_WIDTH    = 2,
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
		input  wire [1:0]   in_channel,        
		input  wire         out_ready,         
		output wire         out_valid,         
		output wire         out_startofpacket, 
		output wire         out_endofpacket,   
		output wire [187:0] out_data,          
		output wire [1:0]   out_channel        
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
	) my_altera_avalon_st_pipeline_stage (
		.clk               (clk),               
		.reset             (reset),             
		.in_ready          (in_ready),          
		.in_valid          (in_valid),          
		.in_startofpacket  (in_startofpacket),  
		.in_endofpacket    (in_endofpacket),    
		.in_data           (in_data),           
		.in_channel        (in_channel),        
		.out_ready         (out_ready),         
		.out_valid         (out_valid),         
		.out_startofpacket (out_startofpacket), 
		.out_endofpacket   (out_endofpacket),   
		.out_data          (out_data),          
		.out_channel       (out_channel),       
		.in_empty          (1'b0),              
		.out_empty         (),                  
		.out_error         (),                  
		.in_error          (1'b0)               
	);

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1auwX6xQK5iErjAPSZ/bNoZo3yKRgGMKhQXI7UIOU9ML80Uo3PHnO9KT5gRU4mO/st6DajwxrN1R+2r9Zpo1QyKRdHaetLOzq9v+vDNJsxhd3ZAuFH0hT5Z0rH0tZmGaRPAbvWch7Cd6ujt2SNVD7Mm+tbofyiQ/8zXe/vL/WzfQW7Wua6KHgcM+swIROHqxDPK9XFQuk2zJKpptaBLfd+P2CNROYQoN7X+SnXTPozJ0YGUPUKwQomNYdxk+bDjUMHJYFi/TEtUTVw7K2BR1siwolv3c7qAhiwM+fSVXCtVr2BTJ4nIKm4YCsi29t1D/xy2a7WFcxs7b9lYzcPbeNZWe3ib6PEXM3hRXew/1IVpxO0/eAnG2UzBbV73bNSrONNOWRu2G0cdqsjc4QL1O65PYPTK2LrVboNXtSv40/M3o+T53oUoYkDy3C8o4Dt9AcHtgii8yOf2QqFk4+B5q6R3DwZe3n8n3/U/H4z6MJem2WKHGBoGB3TlQ1ZKijPagjKia1d7ADf5HeLar+XntDytIHCdeoJ9Ae9YsDCUHBEyhnmKqrNDACJNYScqcLnHFNwhE1iXAw86zTQ8NUv0efCbSpLRJhCKmmrCgpvYGxSSwnkvlHBLr0XC8dDXoXba4IO4JQ7nYzYYLoKlNGOwAlmSC74b8fGnEmfaffWRNgnXK7Gjf3r5NzNrjIL2vmOgJY6B8fsYRTnm4KwuuZcZfGpb9mT8ybf9IAHx30Z82gO47m1V4S2li20g4ZtMeD7TLoK2+PtGZrYAg4jg7QAMFOXi"
`endif