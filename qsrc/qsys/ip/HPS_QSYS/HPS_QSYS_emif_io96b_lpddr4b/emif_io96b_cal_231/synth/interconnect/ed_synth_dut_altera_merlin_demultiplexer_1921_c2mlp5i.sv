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
module ed_synth_dut_altera_merlin_demultiplexer_1921_c2mlp5i
(
    input  [1-1      : 0]   sink_valid,
    input  [440-1    : 0]   sink_data, 
    input  [2-1 : 0]   sink_channel, 
    input                         sink_startofpacket,
    input                         sink_endofpacket,
    output                        sink_ready,

    output reg                      src0_valid,
    output reg [440-1    : 0] src0_data, 
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
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1ammJdxJWryvfI682mAwDykfEYhynhFoHfZeFPAOtyncKh4OOy0WMgDVwCmrZyggdeVe7UdhKxQbP2Yon6pGgF/46kbfPffjRampzDGGJlV1OgLjfs6T+yhHl0MJixyqsiddjrNuUoZMGu9XAG1ev4Q11Bh0tBta/qvZaufOD94fHUJvRrOHaoCC/7DZu87T2VEN2ShsOWFXR4IPktcvlC3pTY3pjNNnnO632pNwmK5XCnhIJQknHC68c7LLvrWCeU1nG7Cs2sEHPeZ4ot1ickTNwUghuEBCqScGbkufaHALutjWF7UVghEicK6M8vcsqCSpVfM7PoAk/YifXD8PvIX1GFtCRQahl9aM2tW86SkR9oZ7cQeFBPQaOPukMVDbPRxNkSj8J0bo3+04lY8TP+DvBXQnaNz/MOum6vpfW87Jt/X81nTGD5hHq30j7pOi/jp1WzhLlDqDwlNarTfXEsFiGBZAYABPiGRheYdlQJngo7LvU0y9XfHj0BF6vlpuxQobSbO3vv2L05KCJXz9WGewADukxmNxhzumzuOYtQ98EHoLLdvN+1+axIEUujQKn8w5PsM5OMqBAqEj4O3KggP5Fh0QB9nekyNom03Wjs8UcdINQgKbKjofyizvtYtWIlo5LFxOBVP5SRxIB6717Cjof7UK0LLBVaOdopJL3IGE71sL7zYpjISPl4aybUaOmxwmc+SUckc90E2BwxNtR1DHNF2KRa6OyVtpvmYxctw6CKV1OBJ4OWPC97fIdKUZtyuUCeaR1Z2UrVXJuq9Y7Ue"
`endif