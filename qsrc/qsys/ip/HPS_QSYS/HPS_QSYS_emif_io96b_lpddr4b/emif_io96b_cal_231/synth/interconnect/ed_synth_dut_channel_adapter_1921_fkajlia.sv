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

module ed_synth_dut_channel_adapter_1921_fkajlia 
(
 output reg         in_ready,
 input              in_valid,
 input     [8-1: 0] in_data,
 input              in_startofpacket,
 input              in_endofpacket,
 input               out_ready,
 output reg          out_valid,
 output reg [8-1: 0] out_data,
 output reg [8-1: 0] out_channel,
 output reg          out_startofpacket,
 output reg          out_endofpacket,
 input              clk,
 input              reset_n
 
 
);

    wire in_channel;
    assign in_channel =0 ;

   always @* begin
      in_ready = out_ready;
      out_valid = in_valid;
      out_data = in_data;
      out_startofpacket = in_startofpacket;
      out_endofpacket = in_endofpacket;

      out_channel = 0;
      out_channel = in_channel;

   end

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJNUdY5Sxgg/RWccgFjhp1diK+xv5NjHP1zDtf26t5K5n57glvIPlB6ELeFikBETjPJ/G3fFniCjAC0tw0b+JinlIsyQin0Lbfy0Lby6p+IxrLVLsLzYmcNcpnfBkmgv/vL/f2LFUKcB0lNUTFOdBYBLUaRudgQenl1cc4i7ZV7L9BQYETlInmYQfPsMr093KKSxZcqfSOrMSSrb7hllx+sDIfnlM9bF9dzX7RzW82iBGn/+p0hePzecj3Dlohq00Ep/ovq6vq0xMARdpPiJCv7hO+vjQUFRhBxGS1qDD9C4aSWyIC7h3hLFJ/Ue8BpRyhOOcwnDnQ9ZV/Dojd43rDNFKr9r4OcxiXz02RUG7Ll5hydg+qRIVCU6ibHgLXFyYQOEN/t4sk4rZGpckGmne4o/M0yV8gM7RrLiM42qhOQ0vPQpUDUIwk/FYYxC66VbOwweVIijfjBm+0WPUVTIEYfgY4W8qpvHbNZgttvsjLHcmlPVQTbnQU3tryBzfGhvA+aHvwcs6NAQwzVZuLl4fUGgaBXIIQkbQ07UEKmZh36VS4gdPJFL+UIOdMu03x0Keb1NzXYc3bjNMTQKbgBWZXEPDV9xfEI94LyBCHUMrz2c47z9pQq22h7Nu05zWvBhnpnL1CiyNvBhoXq+QWZSLPfb6jbFBrhz4vOBPBUO92tHPIQGGdJrt8Fl7bkyGGhhLvZjo0xjZloxBaRpqBAJXliJZweHsSiKyqw/6+KSbaCrew3A/04w5ITBls7sG0qm/wZ5QSDtbatxmHT/1Lgv0x75"
`endif