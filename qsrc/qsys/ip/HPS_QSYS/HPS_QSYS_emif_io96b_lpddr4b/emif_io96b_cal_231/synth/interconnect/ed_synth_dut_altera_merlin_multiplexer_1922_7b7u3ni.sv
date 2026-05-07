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



module ed_synth_dut_altera_merlin_multiplexer_1922_7b7u3ni
(
    input                       sink0_valid,
    input [124-1   : 0]  sink0_data,
    input [2-1: 0]  sink0_channel,
    input                       sink0_startofpacket,
    input                       sink0_endofpacket,
    output                      sink0_ready,


    output reg                  src_valid,
    output [124-1    : 0] src_data,
    output [2-1 : 0] src_channel,
    output                      src_startofpacket,
    output                      src_endofpacket,
    input                       src_ready,

    input clk,
    input reset
);
    localparam PAYLOAD_W        = 124 + 2 + 2;
    localparam NUM_INPUTS       = 1;
    localparam SHARE_COUNTER_W  = 1;
    localparam PIPELINE_ARB     = 1;
    localparam ST_DATA_W        = 124;
    localparam ST_CHANNEL_W     = 2;
    localparam PKT_TRANS_LOCK   = 72;
    localparam SYNC_RESET       = 0;

    assign	src_valid			=  sink0_valid;
    assign	src_data			=  sink0_data;
    assign	src_channel			=  sink0_channel;
    assign	src_startofpacket  	        =  sink0_startofpacket;
    assign	src_endofpacket		        =  sink0_endofpacket;
    assign	sink0_ready			=  src_ready;
endmodule


`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1bkkCK8M8XjYWiz01OqMEhdXH5Blbnk4aW/XQyhTW5Z1j/azxujeA2q8vhutRSAl6HkuUcTMlea3QafZsejPuWfsT5j4Zi2WUa7sn+crauYVJ4lVRTPGgKNK72A+3DpF1PivJfZbUMU2aDz6caHNfHE2M3WTUSBTmRkSi6AfvbU7kzbqMnGNW4DIzMb1Q08jNcS5ecUvg5B0SJItvSjHE/xlk0yTkiAl7LaX2cio2Dag+8DiO1aXVZG2fQcXtvLt3NzgYMGmw8zHgSwe0Ax/58Z0gIDCtgDT33qdx5RulLgAMBvc+p0Us+zvSyij7vS6QnfxDu48Wh1hBuJbYk6hQXL8Alm071Wcd5p1opHimYNyDMBngn9HbEr1V8eo3eCpwtf3R4kh3+EB4axDyFiU3+Hz5LcxBEtGm0JbG21SCMQHUn9NL40d32hKMNhiGzFJoLvKDRdeaxaOMNRgUe+H28jMx2X5yyCEzh46jhDGGQQst0J9KRvNGHgFYthZdWwotslUn4upOmvHOoAoe6QJFXjaOK0XKjBMyeDcDNYXdLkvXaM8ywPXPZjQ25CIGJi95ODmeWOMEeJfYQmblsOrxPbauQ3X0VrWZI8G6S7glcb/yuyL+pV7lgx69T/ZGLHmtRScMwPE4Mnb8+lFOqOsQQ6GhZSHnqRlp9oMDFXjmbOfXCSyvtqjdLKCJu5nC3jBGiM9kdKcw/xUo5yornJgk3kXD9UFOHWN3VxPuGL3Ks5i2c4DAJ8iOal0qjUnt+1h5TgtqmgK7umwePNrlArhinv"
`endif