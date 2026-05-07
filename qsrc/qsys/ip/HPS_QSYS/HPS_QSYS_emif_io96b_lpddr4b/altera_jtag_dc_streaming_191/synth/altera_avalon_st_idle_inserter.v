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


// --------------------------------------------------------------------------------
//| Avalon ST Idle Inserter 
// --------------------------------------------------------------------------------

`timescale 1ns / 100ps
module altera_avalon_st_idle_inserter (

      // Interface: clk
      input              clk,
      input              reset_n,
      // Interface: ST in
      output reg         in_ready,
      input              in_valid,
      input      [7: 0]  in_data,

      // Interface: ST out 
      input              out_ready,
      output reg         out_valid,
      output reg [7: 0]  out_data
);

   // ---------------------------------------------------------------------
   //| Signal Declarations
   // ---------------------------------------------------------------------

   reg  received_esc;
   wire escape_char, idle_char;

   // ---------------------------------------------------------------------
   //| Thingofamagick
   // ---------------------------------------------------------------------

   assign idle_char = (in_data == 8'h4a);
   assign escape_char = (in_data == 8'h4d);

   always @(posedge clk or negedge reset_n) begin
      if (!reset_n) begin
         received_esc <= 0; 
      end else begin
         if (in_valid & out_ready) begin
            if ((idle_char | escape_char) & ~received_esc & out_ready) begin
                 received_esc <= 1;
            end else begin
                 received_esc <= 0;
            end
         end
      end
   end

   always @* begin
      //we are always valid
      out_valid = 1'b1;
      in_ready = out_ready & (~in_valid | ((~idle_char & ~escape_char) | received_esc));
      out_data = (~in_valid) ? 8'h4a :    //if input is not valid, insert idle
                 (received_esc) ? in_data ^ 8'h20 : //escaped once, send data XOR'd
                 (idle_char | escape_char) ? 8'h4d : //input needs escaping, send escape_char
                 in_data; //send data
   end
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "FQbdgc6L7IBAY6fOekGDZSoPPgzAvTLS5KI4ZFuNrzNpTW8vAdrHoXjbN9QDDni9wandNqca4alTzfPQdbuyX8xJkBUKByOgHDrbWP9Om8Wf/wBzwdp7QRgAIoMl3XHkp6wfCOAmKGBGXhS+D0N58GZjgAxZE5k1kPkGwTW2HK66FVEKxZmgFTH/3PkyONzjSYFAnIyDnLAccODH1NLcP+QMpGqPUsBsbddxoMEc9m536coY6RlPld6tG3m4jGnjP/2z0K4moKZ4865ZOHqOAsY35EyRPRM1xrCOY7dvDrr43Vs5RwvSRzlEXOlnJPvuQPAhkWye1LeqVMQyLP2hVID2eqVzVUOhp7jOFJODh7kN55owu2yAD8ipSrt77nStI3kki13+GAqRwcJ98nd4ahkYA0r0I3NOcxvsM399FWhN03uIS5YBV1P8ESaIZHnuPAsJ+TvpKg8cnHeszyXpDckT76fNYAhcjAhJroFhJhjOcr2LVXR1GDNQqAnxa5BRokszLtKVigeNkt9PHYFQVfyFdstUl3F2D9SfiBlqZI3hWL1d+gI0YD+gZb4dSqQJOmpFbT3HuML5q+RiYB3iP7UBCaCwLuz8eE7fC7PJW3S+lpdpJEA2nhgxcPRbaPXPmLXFQ+ywvf6BdRPEOF01gIVoFr3iz2Hhatb0pOmXxQ+sGql2lV83r39DtiJkARwCtq3ywahVZbwxKwz3OfFZsYhwauZ4rxepv4ROWKeQzh7bTdh+qMIpjQmtwTBDA5/ATPKudMsPHFDcMel5x50nnnmLfpKaxHVsd1uFwDC7qPPX1Mn9e9UhJhcxAEO5xgCvXvIbnhj3Cg3x4uyW1sgT2REsPvr+CAf1aST992+ALDalS8XZt/qpHXxfkjD94po5l+12jCdb4QFllrBd5xoKJq+rqfLOX63b6L+il80yjSUsKQYFtb+ED6yP8NoUaHf5B9XnK1ws59PfsDoESVHKerLcRuvndOT4a8BLEUVPMbTg1Tcs22MUKfT5bhqmHWDa"
`endif