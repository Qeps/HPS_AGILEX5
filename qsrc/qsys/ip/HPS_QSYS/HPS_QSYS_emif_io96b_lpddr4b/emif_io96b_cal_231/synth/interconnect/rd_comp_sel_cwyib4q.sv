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

module rd_comp_sel_cwyib4q #(
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

rd_pri_mux_cwyib4q pri_mux (
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
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJNkpZBuDqdKC3MKHKJX+EKTST+6vfpJhZKCwTaLQBGc70T7tFiZgqsEIv54LO8fIGTzszpXKCET6sLqZ8UDWVi6Dg5Ew1cF765DsbhogeTtrf17S8n555H4aojVTXX+jxqkiKpGO88hGI382SvmpMHOfFj+IRex3eIjAYTDjEVv8HC+8hR0TRwQ9i5AL7b+Kftu2krv1mOMJECWjN7l/D4lcD9XqWZXNCvg2cWZwdCk9jztJDiYqUUPOUgyF7mDUQu3T7GC1d2l3CYwzXkngY1dcBN0KFUNwliqKYfpDXCtzRT4gPHnOVXAtq7frk3pKs3+yWlJxWQCzhFlYLvolIwAexVxmVSXmo7mY/8ZD2wck1QI2Nq8TomZAFCfABB9hNkewq7FlVpY5OP/r79n6eVkMKiYuDZVeruQfbxe4fH9Ys07g6JBhrI/tmwHMfbUfFRvMMGtWoF/KgkKEeL5vR7Fpz/Skt39YIqiN8Mpot5BUPW1AJgQKjXuUj1aCE+Y/Axp7okCFAAO0tFcIZGV3uKrK9uyU3X26BRDiTDLBq+bxV3coiWUBZzJw1dKxofdCFdHTaSMTtTa7H/x6v/Q8ZCtpbAhNKfPOCGKgJhmbVO2z9tr1c+kOQUFf4kRqzaZH/vxkWzAEj/L0Ur6cUlVJwvBI4JXSN+N7XKkWrUiPV+dMHc07IgX9WaRwJczuvNBZrtfmZCkPcKRb2oySon8SIQxP3z+BuW3/drrHbRorHjI5JPQ9a1th2m1ZrU2OMr2Mn80+0UqcRSwG3mr5/iQYxvU"
`endif