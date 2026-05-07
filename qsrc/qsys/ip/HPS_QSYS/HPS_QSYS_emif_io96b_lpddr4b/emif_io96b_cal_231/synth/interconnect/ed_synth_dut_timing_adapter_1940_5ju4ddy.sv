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





 


`timescale 1ns / 100ps



module ed_synth_dut_timing_adapter_1940_5ju4ddy #(parameter SYNC_RESET = 0)
(  
 input               in_valid,
 input     [8-1: 0]  in_data,
 input               out_ready,
 output reg          out_valid,
 output reg [8-1: 0] out_data,
 input              clk,
 input              reset_n

 /*AUTOARG*/);

   
   reg [8-1:0]   in_payload;
   reg [8-1:0]   out_payload;
   reg [1-1:0]   ready;   
   reg           in_ready;
   // synthesis translate_off
   always @(negedge in_ready) begin
      $display("%m: The downstream component is backpressuring by deasserting ready, but the upstream component can't be backpressured.");
   end
   // synthesis translate_on   

   always @* begin
     in_payload = {in_data};
     {out_data} = out_payload;
   end

   always_comb begin
     ready[0]    = out_ready;
     out_valid = in_valid;
     out_payload = in_payload;
     in_ready    = ready[0];
   end

generate if(SYNC_RESET == 0) begin

end
else begin
reg internal_sclr;
always @ (posedge clk) begin
internal_sclr <= reset_n;
end

end
endgenerate

endmodule


`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJN7gnTXl6PPMpX8PVCvK9GuUATZ07SKw6m0KwNZ2E6dg6ui+F5TErxBtgR2JnVFd8heAw6zXxJOmKuN/MKd0s2YwBRzXjzgXhxOjUZgCsl1JBuRmunzsuC4TVjhC1n8yAKdEIOcShbARcYnl0W+NG987+DEMXqjA4Aa7FM95gnHnvbkMr81W3hgPraoRWnZzySgJA+hc1Hu8R8fpNdY4GIhOtwYR44AAvmMkZvg7xkHvBymSuu3uJyKGnMBxVYQl/lPOrbw8oWAiMc1C57Be2/5kAx0qcRTlS9MoO8/n66EwWQ73q4bcTQ73YKtqOZgEuV6vnVibB9nPSNO/6GCoELAjsDS8/Y+FSx3Irr5un4rqhNWZ2hk18Gas3lX5DrkGG88JG5MRNgcZGPUZuj92Y97I46X6u3KElN7DYY/terhA+PhZmkMWX2Yejgup/AwfKFDklGI+QJDvOgN7IRNrlMGok0yTuAOCFyxE4oNdDxD7MG5MbALxC3AZ3gnfHeiiUNeVxqGEZF+3P0l6oSLVd87N5mc93+WbAygWQKERxh3FQ3nfkNXtxZ2lfEaQhRoFpE14T9xMcvJ4GqJ9BVDe7nnSDYXn7hY6RMEz29QKItInFsUUy35VTmEsUguTk0lawnG5Twdq8vLEBeuQ6eX/VDFvCYQi/nCwpAo0e8cPB0NsjSYQBkX21kn/X4RXqrq6oZ/pz1SACxUdRc0fVYLz3xYWIwj/faDOsZ9IYW2mA0RVYKBAnhjMWjgwyLcJ/V5Y+m+2SiPeCT0pTG4DAz9zNdm"
`endif