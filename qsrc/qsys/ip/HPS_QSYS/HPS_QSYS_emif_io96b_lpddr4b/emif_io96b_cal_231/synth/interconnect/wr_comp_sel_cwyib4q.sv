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




`timescale 1ps/1ps

module wr_comp_sel_cwyib4q #(
    parameter WIDTH=10,
    parameter PIPELINE_OUT=0,
    parameter PIPELINE_CMP=0
) (
    input           clk,
input [WIDTH:0] in_0, 

    input [WIDTH-1:0] base,
    input [1-1:0] shift_occurred, 
    input [1-1:0] clr,    
    output logic sel,
    output logic [1-1:0] sel_index
);
logic [1-1:0] equal,equal_reg;
logic sel_int;
logic [1-1:0] sel_index_int;
logic [1-1:0] shift_occurred_reg;


compare_eq #( .WIDTH (WIDTH) ) com0 ( .in_a(in_0[WIDTH-1:0]), .in_b(base), .equal(equal[0]) );



generate 
    if (PIPELINE_CMP) begin : PIPELINE_CMP_OUT
        always @ (posedge clk) begin
            equal_reg <= equal;
            shift_occurred_reg <= shift_occurred;
        end
    end
    else begin : NO_PIPELINE_CMP_OUT
        assign equal_reg = equal;
        assign shift_occurred_reg = shift_occurred;
    end
endgenerate

wr_pri_mux_cwyib4q pri_mux (
.in0             (equal_reg[0] && in_0[WIDTH]),

    .shift_index_out (shift_occurred_reg),
    .sel             (sel_int),
    .sel_index       (sel_index_int),
    .clr             (clr)

);

generate
    if (PIPELINE_OUT) begin
        always @ (posedge clk) begin
            sel       <= sel_int;
            sel_index <= sel_index_int;
        end
    end
    else begin
        assign sel = sel_int;
        assign sel_index = sel_index_int;
    end
endgenerate 
endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJMwZdNfuxagE4iJ6pToknN4pwzAS0rOkUZ37e8vvHfNBRyh+JWrDItVZALV26s5mIHk18/2MdQ6u6DYvCiKITDdnim5Gq68bqft26UwCGLJrBPwxXUC3M9nxrcMGXUUp2FNat2mEleGtQGRCocBr4MSP7BX/MQkGbf5l3lijM5PSqZCgA+F0Pt7O8f5cysKIbw5xEC/usTOO9nCF/jK2BOrAtvsZ8YVhCAVtnvbBww0YFMQXEDz75kUMmJWLYPosMKvdDjtaYKDsA8/QVt6zi62Hgwr81nT2wdDdqK1AxQqylQDcGTvsXPTeimpGsjHJkykMK84iOpXadk+OU1b/DQz/pHDK6EK9nf236An2mIMoH29eLgjE1rohh24zmraCzmpFeAOLN9HPe9iz3PIjubIQLd1VFl4fZsR3bn8tpAYaCrsybzj87H0BGh44opI+Bp2I0UvNTuYHym3OjxySXRRf+dQG6iPXU8KHjq4cXkxO0LdZ5IRnVD6jMu+DVmpQW70ZUF3kjCHqyUJT8C+0ch2aOW18CcEjX2AQ9jT5zrCRGTnxbVLU253lCHeP2EXEEOAXLdodV/i8aPZkaIjwH6m1COx1q8hasmy/v/VcwfSR6Cb3ferQGyVqJnsr0St1aSubBCY1OyIkkbThXH7xw5QnLsIp0D3SuxzBMAMNx7al8PSML7r6GbZvsr/gNBsdgrKxqSEQ2fgKx0WidDGVw80hss0fwyK9g9Id3OTWPEiRcK1S92AjUpJ9CW+sOZ+SayMgYwDsNZUGnuOpwBuHqDC"
`endif