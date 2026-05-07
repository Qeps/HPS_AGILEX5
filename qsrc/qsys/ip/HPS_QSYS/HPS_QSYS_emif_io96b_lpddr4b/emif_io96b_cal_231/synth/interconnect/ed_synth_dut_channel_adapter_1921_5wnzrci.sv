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



// altera message_off 13469

module ed_synth_dut_channel_adapter_1921_5wnzrci 
(
 output reg         in_ready,
 input              in_valid,
 input     [8-1: 0] in_data,
 input [8-1: 0] in_channel,
 input              in_startofpacket,
 input              in_endofpacket,
 input               out_ready,
 output reg          out_valid,
 output reg [8-1: 0] out_data,
 output reg          out_startofpacket,
 output reg          out_endofpacket,
 input              clk,
 input              reset_n
 
 
);

    reg out_channel;

   always @* begin
      in_ready = out_ready;
      out_valid = in_valid;
      out_data = in_data;
      out_startofpacket = in_startofpacket;
      out_endofpacket = in_endofpacket;

      out_channel = in_channel; 

      if (in_channel > 0) begin
         out_valid = 0;
      end
   end

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJMcFhTk2C6sj4KR23yI2jcDKOamno2Vqw9Tz9LYH+Gg3fR09Tn7K+gV5CLGJLg6tvuEOSoQ3S+NlE5lm4OXLsqERl10VCkyKTXiqH4kApoZ7To3Eq6D96eU6o6pIoFmL0ViyEbQuiRwgXSo4ZvX7Fjkpp2tNd/O7nMRjpS1m7qaYoitFC6BVF0W5Jg5Xo+lJlkl/8HwENjCcXYhS20bT76bbr9kE6uy4dud/MqTbdMgpYPb2A7Oh1UbiJ//GdOtXyWxfhV+2nSeBPUQa2zD8bxLDhCPdkf6zwxOVvhO/j4146Ah49mFDGIfwZoZKIeR7PfcsBn79BBNIaRxOTzxxpyB6t+xspjQh748WmU2qXP+pj9efvFCDahzURfOmrbRRE6+BSdM5JRu2Nd9cfnw8eEH7IkInGIGxkDPI09hwEESMmth2IGtANOzZr6/FyO+LBJGezvlYivqvaFKzF9wfNzZWGy7ZqP4LtAr48pG90A0/VfiZI6jaMQNlVYKkw6h1GIkY2Emh4bR2HzFx9TD8xlvI6rbfAWNDvYpCwcDFyNBuI2JDYWrOUYhJHQ5cnSL7IwTnHJ9u7PN/yO4S5x31Fz/Ho+ayOW3DuDqBNq9WtkSvIAb5fnYg4k1Whlbp4kK4Pc8MYDQcmcCflfaaa1zYXS7aVZb9nSy5Zdf0w3I/z9lADrzU3OHr+LFTPld1B7/+qdTPHDXjfOMXFAtRJqdVhIM9TcWlp06ffJ96B3BuCE4aS19t7aRXdYVuv6/ruXxLqn8NL5r8qDD017lTH8fCaQ6"
`endif