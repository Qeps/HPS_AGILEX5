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

module wr_sipo_plus_cwyib4q #(
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
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJMwrI3h8ByLDyZJEfsMFp6iGGOZbaZopa42ck8eMRDb6cqm589LSgtAMfqvhj5L9A/jLvNikiHawPPOrI5NvpheVlHaAFi6frj4+NtZWmRtb9ji9IrpbcG/mMl5yBjJTBOFVB4eQDUTrIkPte7uDhiley7QxMxCs3NC+xzMuGsBgawcnqe04cr/wjKaHsEqKaPPrt3J4pOGshLh9qqGH5UhYU2Bw603uk7H0XQHyV4YMXwufXtBd3a/soXpIFFJAioRLknRIB+RYeUnPQiSxXBWOmLaoaVKV4yaaHcr8RCCMhGj8WOgN+v4e9bkV55tuydtBBKGEiNUNlr3ucuKbvXNExyQa8/rutfzqmRgUUlFwOM28c5vQiDsl7gT3+yPsSiS2qZA/D2+yXZLcthAAjms2uQdcLb1ExYlutC1q1znlwqK1gZqiPKjr2jQIVhfv0KF0CoKM1GEWmhgCtW2LgVpELGx4a3/gymbzyYcVVgKs4/VfutRj0lioeyeYLsq0M4YEPQtJwjjvvGdrTzZhV+eMqtcXvI8e/PYqm1rXeIX7r3tF7YEb1/ovHfH4rkbUr2lH5GvstnCc3Il6AHr4TDCD8YRZ7uH+HhSqtKsJ85avvLnhFGKkBjufXVifRfNYMUKfGQhWm6iqcQcF0xTtYF3ib8CmPbhYL8czVfnffoSu8YsuKVi7ogKG16mMR+sh19QMyWraj1YsIxmJswoRnPVRzAkWPTCn9H2e1E8alIIt2wKJde0P21m7PuWxs9pR0g/IsELN1OKoWcHSdnZXmY9"
`endif