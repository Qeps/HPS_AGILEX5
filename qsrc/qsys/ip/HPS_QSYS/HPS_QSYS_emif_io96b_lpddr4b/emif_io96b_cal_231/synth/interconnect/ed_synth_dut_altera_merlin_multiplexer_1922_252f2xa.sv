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








// altera message_off 13448

`timescale 1 ns / 1 ns



module ed_synth_dut_altera_merlin_multiplexer_1922_252f2xa
(
    input                       sink0_valid,
    input [440-1   : 0]  sink0_data,
    input [2-1: 0]  sink0_channel,
    input                       sink0_startofpacket,
    input                       sink0_endofpacket,
    output                      sink0_ready,


    output reg                  src_valid,
    output [440-1    : 0] src_data,
    output [2-1 : 0] src_channel,
    output                      src_startofpacket,
    output                      src_endofpacket,
    input                       src_ready,

    input clk,
    input reset
);
    localparam PAYLOAD_W        = 440 + 2 + 2;
    localparam NUM_INPUTS       = 1;
    localparam SHARE_COUNTER_W  = 1;
    localparam PIPELINE_ARB     = 0;
    localparam ST_DATA_W        = 440;
    localparam ST_CHANNEL_W     = 2;
    localparam PKT_TRANS_LOCK   = 324;
    localparam SYNC_RESET       = 0;

    assign	src_valid			=  sink0_valid;
    assign	src_data			=  sink0_data;
    assign	src_channel			=  sink0_channel;
    assign	src_startofpacket  	        =  sink0_startofpacket;
    assign	src_endofpacket		        =  sink0_endofpacket;
    assign	sink0_ready			=  src_ready;
endmodule


`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1bOBcWnBAjxo2Gbpk1rbQZn37poCom1YAjr3Yes1A/KyYnBQPOvlR98uIkHFaMu6aZ79DhIf2ZO6Qt6O1JtQhLWn7AaLr9N+gfS+vaa8f0hfHjggVY0fm7uBWP44PRIxR4tlP2+Gy+eGtj1d8bK/qBFCUexH4/cE5hRxTR0xx/3MeiArhSVzzGqnBpJsxfjc7YL65AGzTOQ8pz5kXtxEUGAY2jRFi/VEpVv07CJMAV9VEQm04Y/rqUGjszf68lXi5nxNmHlX/q+bhrfu+efJ0/DTbSkgo7iSAy9PZCh8SkDHHCzslNP7t9cDkQPK0NOl1+t8lbiheEB4UFn5JvPBEN4xBGj9VxqlTAREdnbhkx//9h8weZmbOtf13DyzDlQ4tsPs7mx4oLxBNONttWa7rfw6cgNlkS5yf0VwEifRZUpLAx4lwjjq3C+AJcvLpJ4fEUrtUzbFq9NP4Q5IeUkrCO14xxWbEJTyx3Fg1YvOX9yjaX2zszHMkAd42aAeTQv/gjUoicgCa7EOugSrZ35XMpqSZCnjJ5/CF/xekc+qu2qGuRurI4Ix0IkA1KHieuXiQ74G/MKqWqJIo1JSNq9scr7K7z1TMzpndkhLtkUr5gB3kWz/wOaLCBxknen25lEF9FnRwfp0intO+NvQgOWv9bBDteAI2+4Ohf4brYXNuJwtoL6Jsb/zGmo6Lcjdw93xUegwPZ7Zak4BhnChme+Xbg5BsJCyXdW4noYbt6bO55Kkxee2Fieun1pfkMCshNpvBc/8WHHa+Pc/lGEwcRvhv3n"
`endif