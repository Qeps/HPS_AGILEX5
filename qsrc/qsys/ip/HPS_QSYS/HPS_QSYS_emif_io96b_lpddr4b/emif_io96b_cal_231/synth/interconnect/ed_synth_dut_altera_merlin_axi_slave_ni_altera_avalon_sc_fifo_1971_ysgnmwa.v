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
module ed_synth_dut_altera_merlin_axi_slave_ni_altera_avalon_sc_fifo_1971_ysgnmwa #(
		parameter SYMBOLS_PER_BEAT    = 1,
		parameter BITS_PER_SYMBOL     = 189,
		parameter FIFO_DEPTH          = 1,
		parameter CHANNEL_WIDTH       = 0,
		parameter ERROR_WIDTH         = 0,
		parameter USE_PACKETS         = 0,
		parameter USE_FILL_LEVEL      = 0,
		parameter EMPTY_LATENCY       = 1,
		parameter USE_MEMORY_BLOCKS   = 0,
		parameter USE_STORE_FORWARD   = 0,
		parameter USE_ALMOST_FULL_IF  = 0,
		parameter USE_ALMOST_EMPTY_IF = 0,
		parameter EMPTY_WIDTH         = 1,
		parameter SYNC_RESET          = 0
	) (
		input  wire         clk,       
		input  wire         reset,     
		input  wire [188:0] in_data,   
		input  wire         in_valid,  
		output wire         in_ready,  
		output wire [188:0] out_data,  
		output wire         out_valid, 
		input  wire         out_ready  
	);

	generate
		if (EMPTY_WIDTH != 1)
		begin
		// synthesis translate_off
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
		//  synthesis translate_on
			instantiated_with_wrong_parameters_error_see_comment_above
					empty_width_check ( .error(1'b1) );
		end
		if (SYNC_RESET != 0)
		begin
		//  synthesis translate_off
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
		//  synthesis translate_on
			instantiated_with_wrong_parameters_error_see_comment_above
					sync_reset_check ( .error(1'b1) );
		end
	endgenerate

	ed_synth_dut_altera_avalon_sc_fifo_1931_fzgstwy #(
		.SYMBOLS_PER_BEAT    (SYMBOLS_PER_BEAT),
		.BITS_PER_SYMBOL     (BITS_PER_SYMBOL),
		.FIFO_DEPTH          (FIFO_DEPTH),
		.CHANNEL_WIDTH       (CHANNEL_WIDTH),
		.ERROR_WIDTH         (ERROR_WIDTH),
		.USE_PACKETS         (USE_PACKETS),
		.USE_FILL_LEVEL      (USE_FILL_LEVEL),
		.EMPTY_LATENCY       (EMPTY_LATENCY),
		.USE_MEMORY_BLOCKS   (USE_MEMORY_BLOCKS),
		.USE_STORE_FORWARD   (USE_STORE_FORWARD),
		.USE_ALMOST_FULL_IF  (USE_ALMOST_FULL_IF),
		.USE_ALMOST_EMPTY_IF (USE_ALMOST_EMPTY_IF),
		.EMPTY_WIDTH         (1),
		.SYNC_RESET          (0)
	) my_altera_avalon_sc_fifo_wr (
		.clk               (clk),                                  
		.reset             (reset),                                
		.in_data           (in_data),                              
		.in_valid          (in_valid),                             
		.in_ready          (in_ready),                             
		.out_data          (out_data),                             
		.out_valid         (out_valid),                            
		.out_ready         (out_ready),                            
		.csr_address       (2'b00),                                
		.csr_read          (1'b0),                                 
		.csr_write         (1'b0),                                 
		.csr_readdata      (),                                     
		.csr_writedata     (32'b00000000000000000000000000000000), 
		.almost_full_data  (),                                     
		.almost_empty_data (),                                     
		.in_startofpacket  (1'b0),                                 
		.in_endofpacket    (1'b0),                                 
		.out_startofpacket (),                                     
		.out_endofpacket   (),                                     
		.in_empty          (1'b0),                                 
		.out_empty         (),                                     
		.in_error          (1'b0),                                 
		.out_error         (),                                     
		.in_channel        (1'b0),                                 
		.out_channel       ()                                      
	);

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1a+9vT9U5K5c04eIqO00uJKe6ATQSWGrL1Y9y3EoUup5QcKayPUhP97HlqxNyyCQHCJ3CRTUnzMs/Rxyi00KKbnBkySKFX+wWReqNZtPcAzNwmwMol9d8xqvjWLuuKJlU2jjvnZ3gyWQMVKOM8bqY8GOPCX+HbWoN4JwsKjrxGbXeSr3EsOFoKzdtN/H97Jh9yu5lb2c2haxBgriIK97bzTMvffxe684Z0hxvArQR/pk0KL55iD+PJcSZLF1KAQv0qEq4EXB2+42gkmq5emOauE2NcONWFIg+bzZtHHRMCjYzS0yKRoA+Pw9GhtILGCsmHSnwdaapyivvZFwy782UV4062ZZVGFNGM0xnGK0tGine2blwMF2Z7dqMZQhckc0v+rvtfSiMYq5cpTiJF8/Uj3LgTel7r/WClRvHes3C0EUcya7uwHkeG9VuBpcbM2dqLKV1JaxuUsjs9Zcuwtj1UvddgjlYHdBQgxC6fy7sSwwnalsL58mYgPjiJ4zOJyOoK68CQlMJ05Mo1ZPepfBOHXtwGbKBLrf7LTYrI9/ncrPCmJ/PXVK/uXzA6cS6jeCBrpxUITWaOV3otndrk29CQ9AjA2WSCbamN8Wi+tyyRTAmWL9UR8LSI9I9x21CttRAl2Op00TkzMF+wcME1ihV0NzKeJ/nUTK4OpFAQm0QRiCV9Hzr4SVv2hLD6no/wXGyiRJPFAlPGng6hAw2uYicvxkhikV9RGkBoZdpkHRnuu1MUIRtJ7Yzmgu5IBlUjXBaJzKKumK66PXNBPjSQVTV2F"
`endif