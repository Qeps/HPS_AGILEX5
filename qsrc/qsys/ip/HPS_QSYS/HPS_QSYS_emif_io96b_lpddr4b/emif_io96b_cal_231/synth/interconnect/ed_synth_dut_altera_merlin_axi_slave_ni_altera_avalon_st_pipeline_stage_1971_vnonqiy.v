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
module ed_synth_dut_altera_merlin_axi_slave_ni_altera_avalon_st_pipeline_stage_1971_vnonqiy #(
		parameter SYMBOLS_PER_BEAT = 1,
		parameter BITS_PER_SYMBOL  = 124,
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
		input  wire [123:0] in_data,           
		input  wire         out_ready,         
		output wire         out_valid,         
		output wire         out_startofpacket, 
		output wire         out_endofpacket,   
		output wire [123:0] out_data           
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
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1ZuevuwgEQevDXqTcmVxi3KKzi9kX+5zqevvo+Fe6Uz4HL/P7hdTMj8adJcMvaj6MUyqM3AypjrP0cGoeYGIYF9PIvuRy1VuLqg44p1RbG3zRUAEnHxjd3gDnDL55fWX5e+MSsc3m/GCRNZnEH38WC+TbhajKjk5mFBDc8/d9P2sLfXsrWlkBJ1lGQUMjYgx5S+JmbpMKgAr3Zgd2yFPOY2iHVDi+cG+BGiHqDcRxSABEyMCtD4pC+T03OHhB1Ay12dSY2r85RLvWgmV6AJZ2FShzybkKqGYFRMqWKxxn8u3+O36V/wsX+EG4IskMW35vOPvhtO/xsfC+RTuMzNMqQS4FQsvQN7UD0uVxgghnjBqbrCxUqe5P/ENy/AAfC7aH6UnlrDcfaL2/luqz6sNMtUuUWc5IfSD5G9gDqdOYHUpImWYqNOa+727NPcT7AV+tQFyr2ZPlIAP59p62Pfkuk0dzOvSWLfpykC5u+VoM0+Ot3O1JHooUEbqpYVnAP0VvL6ocFP8rtqNOQ4CEdfT0krWfoRRM/Vz3Vx6yv8SDaw4dFB+40jcK5ZtyJ6y2y+A6+RGS2qqn6e9zgW/pMQRxR1C4ZqYh93YQtw7iOmwzmYUla2nQS/9VmT7o5lm1I0iSs+lwPJwk9WDNX5uJhSb/GHH3T0f3wbzr6UpOteGg1U1377W3Kjin4C/oWvt+5SVwdweiewpK3y/fyOBXubinopReRE3898nZ5DXZPnvEp6wm81crxkY9COa6bZ7YR8PyyTLGdTF48tqqmZ21LVtsKT"
`endif