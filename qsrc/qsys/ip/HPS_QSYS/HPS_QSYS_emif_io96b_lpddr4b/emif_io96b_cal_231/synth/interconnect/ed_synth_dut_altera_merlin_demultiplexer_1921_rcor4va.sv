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






`timescale 1 ns / 1 ns



// altera message_off 16753
module ed_synth_dut_altera_merlin_demultiplexer_1921_rcor4va
(
    input  [1-1      : 0]   sink_valid,
    input  [124-1    : 0]   sink_data, 
    input  [2-1 : 0]   sink_channel, 
    input                         sink_startofpacket,
    input                         sink_endofpacket,
    output                        sink_ready,

    output reg                      src0_valid,
    output reg [124-1    : 0] src0_data, 
    output reg [2-1 : 0] src0_channel, 
    output reg                      src0_startofpacket,
    output reg                      src0_endofpacket,
    input                           src0_ready,


    (*altera_attribute = "-name MESSAGE_DISABLE 15610" *) 
    input clk,
    (*altera_attribute = "-name MESSAGE_DISABLE 15610" *) 
    input reset

);

    localparam NUM_OUTPUTS = 1;
    wire [NUM_OUTPUTS - 1 : 0] ready_vector;

    always @* begin
        src0_data          = sink_data;
        src0_startofpacket = sink_startofpacket;
        src0_endofpacket   = sink_endofpacket;
        src0_channel       = sink_channel >> NUM_OUTPUTS;

        src0_valid         = sink_channel[0] && sink_valid;

    end

    assign ready_vector[0] = src0_ready;

    assign sink_ready = |(sink_channel & {{1{1'b0}},{ready_vector[NUM_OUTPUTS - 1 : 0]}});

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1YZeehHWG9/gTTdp07PX3BYGDueRj1ZLHj4rk6C5CSZ3c4M+w1ezMSU9UWhkoPneYtt8ouKwYuv9fJvVBTdLOYGCaqRzr1dFU/dWopPX7PycObiy1489AcnR7pWdOpFTJycvqdMfMPs1ia5Q3qaq0jF3jsBx0zko0VwCqQdcE27+iQ0oz5oxzn/TdcazwBfKSrzpeTb+WvIKbSy9WSerOXGJxQVZEQoVXPSPMMc/1AjildIDehNWePFlesH1F3MUng6/PXX+uJ4Eum35XMljkMpzGquWuHJfyqBNYOG2wl54Bye/OZHTBcQdeM0vpFDvTgodD6XQQbCg0Numn2Ql8/8+Z1FNXqzk0vKhhMaXNjquKZfsYah8fFxDxeMPso0QUpkhGBVCRCV9hbHLMo2xqhkLHZjxsEmcEzsaBf2GhHr+tk2QtxPqGtfK9XDCWjSW90QzGpMrPhKpAuu5c3vsnLrDAes/GHMXioTwtz6IiZIo19XqDo2Z4o1t/G/aw2cOWnZb0mqUOyzGMscwoBYwTV4BnwRTsV2lPQTsgZXcnblHL4vZ9ZqrIhrU1rtQ2vOdKB9pe6tU1jELLOytsSAiR5X8GjUCJshkWEgv5O8rh77ZqrcXQc+cgpqMuzhWXPS1I4NuPdl8Uo0/eUa1QynYnxTstI/TCCVoSEiY96b2cBkbuBCWH5g4/KiHWZAgG062d3MHt5JtR1yJmkTF+fZ3EcPBOuER4ACmoonHlk1U9V6J4YpaHcZ6H+nc3PtYrZfyp/J6XWIJlYF4KcZ7tmmAZNq"
`endif