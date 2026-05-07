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

module wr_comp_sel_kt2puei #(
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

wr_pri_mux_kt2puei pri_mux (
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
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJPmjCFVjDGnENpUgi1hYpMbeIsvihK0X2SL/0is1K4mviU3y9QewR6UQ51wrP3dT3Oj4GdG0+WPh8MLb7+2YkfQAqaTHTmbUTZQ6JwGQWn8ppmi9I5GXXyhIXf8K2pDu7nq8U/7ueRciqh2ISjSGGcWLMj1uLv7TMe4XtMSsBpcoEoHwEPW4YjOkWnvUDtIKUQRX1FLq231zER4ZHT17r0CvicV8hn1ToIIeX/x6DsEgA7UnjRyChXhiqen/jWvILxsBuxh65q6o77fOViP/UlSF0rVdv3YK8fNIb/p25u39WoP8TnQAG9khKSHCbUE3uvHJ1khVc/w/0p0gRy5UVhwLXFcgRzqHbj4n7p9BVeLSfXOykro7+lNSgUk/eq3qIbhdsyCw37kGkzO7bqHPCiwJiDlp7+XyeYdONa94DgvxlN6rR0n4ksO4p175/jiWToIpRiHzKcyJ6wVy+Wj4aATmC542dj3OHvg6SOjeFIWiCaNss+HH7iI9N6dSzFFUGZJnVgAkE2Gr7CgUEDilpWsGIiuwT+kA2PxEC+RAdQNxrf6iTUObQvSxkjC06/sfSobO9SfWK4E98gIsT/m+9nzTsD62pJUVL6lhWz1XCq1Had8ukcdvRBwW02Ga11I5BG6UmcPdkxjhfSD/SVhMyO3LnYA/yem6dFxLRXrRdbVRv67nnUxbTadxe33VKdoLHD87t+RUWQxj/Jq4EqB4pIitU2SBGMavraiBPAINe+mI/m5gPruWi9zutjO3Y5iEH3dR8bIaMpmRniRus9ZoqK2"
`endif