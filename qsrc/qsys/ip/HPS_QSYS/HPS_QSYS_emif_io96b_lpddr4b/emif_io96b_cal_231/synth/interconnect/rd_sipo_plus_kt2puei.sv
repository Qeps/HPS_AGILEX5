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

module rd_sipo_plus_kt2puei #(
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
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJOk5uKGy8P/E/BUPyqu125UOURYQmRBMxMCTmUoK0EHZvtTbFv9RsLfMiRzu4nRfkh3WMs9r1Z+np0YMByWN/Owqpzhj5s0YSqCAt/mqJ2RccFElZnwBE0E2IUQ2YBA8ejpMjffRxwNKXQAniNj3ERTvTZMBbD3ETfU3zxZEqw/ne4Krmd94Dq6fPRs/I/dcDlGpTBW9MvrQn+8qoZZ3S6iXKxHiHBMQD3swvFSpMv15Z7WojTIiY9aV0H4uDOCTF2MNcfPrbOMaMclD8jhayUk39znEbTfnCGte7A/Z/tLNm7B2WOIT6pmTL/mRkjIEaPDP9ZNiwmAaVLTo2fsh/ztqKUsGuMxpTwpvTGNYJzZ8C6eaW6BxgdWwTNj4Ab4BMbenxIz2BvdnccY8+LBspOIl1Tx//ylvlTJGX/JSQsVXtodg0OiHwbvWtlDqhiGnl+CGUK2/UHY+nqd/fFqzZSnSFyHQCAI2HTgdfScQ1qI/qK4Pi794rOqRkHLQZhyJ3LS71vvudPv1maLtclvgvzngiduurF7MQ/GOYo+Uuj4+AdflecUh+50QoZ8NFT3X8FkB5kXNUURN5AzzZWkbKapgv2E7Ngt3kc6BxvmkY1gghfBLrVKctN4k/H/goc5VKTggHJYO9LFhGs5A8J3Kl59TY5HUD1lPMyipvWZk4oBgUX08nSKYKdYBXN3ymoZl6vsvVmYd7oeJ+6OXOwpMVglIbyuNiY+VTXHiD6TXRlvkk4YhAnnTWKk5KDxi3rtv44lhJCOD99DJozxeGYe5xZj"
`endif