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

module wr_sipo_plus_kt2puei #(
    parameter DEPTH = 1, 
    parameter TOTAL_W = 35,
    parameter ID_W    =10
) (
    input clk,
    input rst,
    input in_valid,
    input [TOTAL_W-2:0] in_data, 
    output in_ready,
    input [DEPTH-1:0] clr, 
    output [DEPTH-1:0] shift_occurred, 
    output [TOTAL_W-1:0] dout0

);

logic [TOTAL_W-1:0] mem[DEPTH-1:0];




logic shift_in;



assign shift_in  = in_ready & in_valid;




always @ (posedge clk) begin
    if (shift_in)
        mem[1-1][TOTAL_W-2:0] <= in_data[TOTAL_W-2:0];

end

always @ (posedge clk) begin

    if (rst)
        mem[0][TOTAL_W-1] <= 0;
    else if (shift_in)
        mem[0][TOTAL_W-1] <= 1 & (! clr[0]);
    else if (clr[0])
        mem[0][TOTAL_W-1] <= 0;

end

assign in_ready = !(  mem[0][TOTAL_W-1]  );

assign dout0 = mem[0];

endmodule
    


`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJOyug/7HPicG+deAahYX3wQ2WvmFOM4Ujm2waJPqbaNx3oi7KhaoK2WrEeXUOpbD2Hsxh+gShiv+9A5bj4hPgYtrhHY+015Xt/4IJeqU6TGA6mxwyVoFEhfejuUCNkPXaXtY5WIm2fz8KMTM9x5edVDZA/z6gpI9c2qXRDemlHQt5WLaXDM/V58xq7rw/7otTu4cp1bJ4HqQvnGa1EQtMnf+rdySVtRckqdqpZsJc4NNprZK+SvTSLQLnN3IrhWVcl+qZuxLnV6m40goiV3a7JK9ho0RuH60wAkJ2moRtL7/5G0dYugYRGjR7PDHgzHZ8nRndjx4Ob/Fh6eAM1F1viVrUeBp8WrDMrik2ypM3hk9fawQXfkPeABKlSHkqt86SshMLMsgs/Fju3Q+dAmqh8ZolRjJB73m+hAPpCO05PCveBxAh+yD01nVlbaWROR2+J2OzzlA2Br3OCdG0n4BImkwC/l/zNlV+shJDf7wyRiNP5H6nDz7Vwqg4kZQnlXl9PDpCzOuLLBfxYiFtlQRmiOqzkr+J0rdJFnPgLHmyjojLVUNMtvSkx3SdqMYMmv4NRjcdg2cOom1jQR1Y+RCcAfo0n5HF56jdc0s4R33sPX0/khQolQEnyDixDb48crSYmIpAQJGhuniq83oucJvomlGHRS+zrpBC/bZev6Zsms3x6eiCks402o5ae+B6wsqvbgpLtuSyVTTpjffvZzoTM2Ser3SjYiGYZKJTnHB3BdNZ9Y88gmqzArXGP61FZSc9DFL4OLpqb8HFUx/dk7cIbz"
`endif