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
module ed_synth_dut_altera_merlin_demultiplexer_1921_ekcygpi
(
    input  [2-1      : 0]   sink_valid,
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

    output reg                      src1_valid,
    output reg [124-1    : 0] src1_data, 
    output reg [2-1 : 0] src1_channel, 
    output reg                      src1_startofpacket,
    output reg                      src1_endofpacket,
    input                           src1_ready,


    (*altera_attribute = "-name MESSAGE_DISABLE 15610" *) 
    input clk,
    (*altera_attribute = "-name MESSAGE_DISABLE 15610" *) 
    input reset

);

    localparam NUM_OUTPUTS = 2;
    wire [NUM_OUTPUTS - 1 : 0] ready_vector;

    always @* begin
        src0_data          = sink_data;
        src0_startofpacket = sink_startofpacket;
        src0_endofpacket   = sink_endofpacket;
        src0_channel       = sink_channel >> NUM_OUTPUTS;

        src0_valid         = sink_channel[0] && sink_valid[0];

        src1_data          = sink_data;
        src1_startofpacket = sink_startofpacket;
        src1_endofpacket   = sink_endofpacket;
        src1_channel       = sink_channel >> NUM_OUTPUTS;

        src1_valid         = sink_channel[1] && sink_valid[1];

    end

    assign ready_vector[0] = src0_ready;
    assign ready_vector[1] = src1_ready;

    assign sink_ready = |(sink_channel & ready_vector);

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1YAxH9vBu8Trg5AsZCMjma4TP/H6uA9NqpB5iRMvdL6wKAxAlu3tlJHAwa3r5XksATXtoUZ3qLnLJklW4HwpTiqYyN2IVtDFeqd2w1x+1Hz7S2IjJY0MWM6V0uvauaQI8BQU4hpG8m7/qGRZsQjA8R5OzMkHLRF+2PKEBWXSypjZE2PHTa1szRUDUR43tTBhRzieV1AC5PnvMRNxUnjzdFu03qbjX2trZLqtPUajf/vttS1cXsgzaf1K1l3rfHXPl113islcNeIZTlgu6M73CVLryXNMKhzuf/KSyMkAsooh1CmVOUGuUsX9ZNI3bPCzBfWCZYHzBsKzo1ZFgdykcLPXQlL2t5RMv5IBmJKCn30HnU/GS01zK3vm57ecRD+sGIRkBFy9rd7e1tOUSIBQdBl7Zy25pk7bbHtCpXGu6S4i7U9uPZluaMsPNTkuizqjU7QNrb0IdnZOaMpk7x+joBoRhog1f2lI4Ya+dGMylmpnc2cTT3tX0BOkm8JHSS+2WMkWtK2yK2mjMqnzcTZ2DsEOTot39WM3i0jO4zaOfCD8N3OZtfL9Mgr0qRxAA33JXVQT9Zhcb7/ut0CI6zFiVaQjCJMnvJreOHflBaYAaJtE8Zrq9PyQHg5QxmNJ6bIZerxt4dvIY2mEcL4dsHSKbsSd6GRYc8gc+Jh+RPEMmT8Jnuel0pJ4fMcy8iIc4J8aYjvPBwtbK/tY2GFtte2ro/EmjlWhy0aiEMwpRO3UNdbN0D3hsk2ozsardae4lMCY+fzsMA7UR5piNJgpCneXH1i"
`endif