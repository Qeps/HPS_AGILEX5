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




`timescale 1ns / 1ns

module ed_synth_dut_altera_avalon_st_pipeline_stage_1930_bv2ucky #(
    parameter 
      USE_FIFO_IP = 0, 
      SYMBOLS_PER_BEAT = 1,
      BITS_PER_SYMBOL = 8,
      USE_PACKETS = 0,
      USE_EMPTY = 0,
      PIPELINE_READY = 1,
      SYNC_RESET     = 0,
      CHANNEL_WIDTH = 0,
      ERROR_WIDTH = 0,

      DATA_WIDTH = SYMBOLS_PER_BEAT * BITS_PER_SYMBOL,
      PACKET_WIDTH = 0,
      EMPTY_WIDTH = 0
  )
  (
    input clk,
    input reset,

    output in_ready,
    input in_valid,
    input [DATA_WIDTH - 1 : 0] in_data,
    input [(CHANNEL_WIDTH ? (CHANNEL_WIDTH - 1) : 0) : 0] in_channel,
    input [(ERROR_WIDTH ? (ERROR_WIDTH - 1) : 0) : 0] in_error,
    input in_startofpacket,
    input in_endofpacket,
    input [(EMPTY_WIDTH ? (EMPTY_WIDTH - 1) : 0) : 0] in_empty,

    input out_ready,
    output out_valid,
    output [DATA_WIDTH - 1 : 0] out_data,
    output [(CHANNEL_WIDTH ? (CHANNEL_WIDTH - 1) : 0) : 0] out_channel,
    output [(ERROR_WIDTH ? (ERROR_WIDTH - 1) : 0) : 0] out_error,
    output out_startofpacket,
    output out_endofpacket,
    output [(EMPTY_WIDTH ? (EMPTY_WIDTH - 1) : 0) : 0] out_empty
);
  localparam 
    PAYLOAD_WIDTH = 
      DATA_WIDTH +
      PACKET_WIDTH +
      CHANNEL_WIDTH +
      EMPTY_WIDTH +
      ERROR_WIDTH;

  wire [PAYLOAD_WIDTH - 1: 0] in_payload;
  wire [PAYLOAD_WIDTH - 1: 0] out_payload;

  assign in_payload[DATA_WIDTH - 1 : 0] = in_data;
  generate
    if (PACKET_WIDTH) begin
      assign in_payload[
        DATA_WIDTH + PACKET_WIDTH - 1 : 
        DATA_WIDTH
      ] = {in_startofpacket, in_endofpacket};
    end
    if (CHANNEL_WIDTH) begin
      assign in_payload[
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH - 1 : 
        DATA_WIDTH + PACKET_WIDTH
      ] = in_channel;
    end
    if (EMPTY_WIDTH) begin
      assign in_payload[
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH + EMPTY_WIDTH - 1 : 
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH
      ] = in_empty;
    end
    if (ERROR_WIDTH) begin
      assign in_payload[
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH + EMPTY_WIDTH + ERROR_WIDTH - 1 : 
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH + EMPTY_WIDTH
      ] = in_error;
    end
  endgenerate

  localparam NUM_128BIT_SLOTS = (PAYLOAD_WIDTH / 128) + (((PAYLOAD_WIDTH % 128) == 0) ? 0 : 1);
  localparam LAST_PAYLOAD_W = ((PAYLOAD_WIDTH % 128) == 0) ? 128 : (PAYLOAD_WIDTH % 128); 
  genvar i;
  generate 
  for (i = 0; i < NUM_128BIT_SLOTS; i = i + 1) begin : gen_inst
      if (i == NUM_128BIT_SLOTS - 1) begin
         altera_avalon_st_pipeline_base #(
           .SYMBOLS_PER_BEAT (LAST_PAYLOAD_W),
           .BITS_PER_SYMBOL (1),
           .PIPELINE_READY (PIPELINE_READY),
           .SYNC_RESET (SYNC_RESET)
          ) core (
            .clk (clk),
            .reset (reset),
            .in_ready (in_ready),
            .in_valid (in_valid),
            .in_data (in_payload[(i*128)+LAST_PAYLOAD_W-1:i*128]),
            .out_ready (out_ready),
           .out_valid (out_valid),
           .out_data (out_payload[(i*128)+LAST_PAYLOAD_W-1:i*128])
	  );
      end
      else begin
         altera_avalon_st_pipeline_base #(
           .SYMBOLS_PER_BEAT (128),
           .BITS_PER_SYMBOL (1),
           .PIPELINE_READY (PIPELINE_READY),
           .SYNC_RESET (SYNC_RESET)
         ) core (
           .clk (clk),
           .reset (reset),
           .in_ready (),
           .in_valid (in_valid),
           .in_data (in_payload[(i+1)*128-1:i*128]),
           .out_ready (out_ready),
           .out_valid (),
           .out_data (out_payload[(i+1)*128-1:i*128])
         );
      end
  end
  endgenerate

  assign out_data = out_payload[DATA_WIDTH - 1 : 0];
  generate
    if (PACKET_WIDTH) begin
      assign {out_startofpacket, out_endofpacket} = 
        out_payload[DATA_WIDTH + PACKET_WIDTH - 1 : DATA_WIDTH];
    end else begin
      assign {out_startofpacket, out_endofpacket} = 2'b0;
    end

    if (CHANNEL_WIDTH) begin
      assign out_channel = out_payload[
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH - 1 : 
        DATA_WIDTH + PACKET_WIDTH
      ];
    end else begin
      assign out_channel = 1'b0;
    end
    if (EMPTY_WIDTH) begin
      assign out_empty = out_payload[
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH + EMPTY_WIDTH - 1 : 
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH
      ];
    end else begin
      assign out_empty = 1'b0;
    end
    if (ERROR_WIDTH) begin
      assign out_error = out_payload[
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH + EMPTY_WIDTH + ERROR_WIDTH - 1 : 
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH + EMPTY_WIDTH
      ];
    end else begin
      assign out_error = 1'b0;
    end
  endgenerate

endmodule



`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1aa0MuSPOSPKB9qh6bLaBB0F94qzZxHAn1cJUDZ8IxXtX7Y3RgzBfqIAHeuTSpPIQCLFu726bu6wkJ2X9BDnpejlGiUbuHD6p7Z+FvBcoVI9t+eJNQhpWBfPsiR5tVxMgQZcl8KsTf3K4P0Pt8swA+saSbZ6go9Z89Y+k87mjdsFPcedmivKP3vkQt9cAidLNZiM97sBu4dJjn+i7uH8DdPQXiqbgpW5CLP6RFQz8Bhx/iGoanTkNUz9ViFq2AqlNfwXiK2lhWnnVdMMSKWHktrjEHlycCZx1Gd8LPDzfMCjFTKhaRazdpBKp7YmdLzZCpbF5hXaumZIaHf1+2DozS0kEnanwXJvDC85nDZialTXYKP3p359j+7u5UYyBNisUtZ0K7aN38udfmK+Bz+E8FjrT/1w+BCq0t6t64fwxnx6cq7WyBz4ylQdOfYBeEyc3Wo/rAlhpOqwyGbd7FdRac0U/egg/Z/c8gFWFPbPa1nat3ac7K7AhQNgocog4KD8Abjra1NEPEBW/hd/meWUV344tNQ/ZdzbQye33hc9ehrJrqCotuClmqcblJAdDKeg64JmrHV3jgMHdpELT1yTqlunP5Q0sGgKkJhl7N4hoK1mtZ9PHBdJJjLA5tKK7MC5B9iBxqXKzsOVpdwQSFJVch4neGn7lslvQZZUgViIa8TXurQPi813V7U14tQzBWN+MnbtmxbkeZ4RH1dkRKJcEd2z5MA+rWnR40ICxNPuPv+gzzOdRwUWbZ2b9IvI9yTOL+ueoNlGIVcd/2EFvu+hqwk"
`endif