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


// $File: //acds/rel/25.3.1/ip/iconnect/avalon_st/altera_avalon_st_pipeline_stage/altera_avalon_st_pipeline_stage.sv $
// $Revision: #1 $
// $Date: 2025/10/16 $
// $Author: psgswbuild $
//------------------------------------------------------------------------------

`timescale 1ns / 1ns

module altera_avalon_st_pipeline_stage #(
    parameter 
      USE_FIFO_IP = 0, // unsued at moment
      SYMBOLS_PER_BEAT = 1,
      BITS_PER_SYMBOL = 8,
      USE_PACKETS = 0,
      USE_EMPTY = 0,
      PIPELINE_READY = 1,
      SYNC_RESET     = 0,
      // Optional ST signal widths.  Value "0" means no such port.
      CHANNEL_WIDTH = 0,
      ERROR_WIDTH = 0,

      // Derived parameters
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

  // Assign in_data and other optional in_* interface signals to in_payload.
  assign in_payload[DATA_WIDTH - 1 : 0] = in_data;
  generate
    // optional packet inputs
    if (PACKET_WIDTH) begin
      assign in_payload[
        DATA_WIDTH + PACKET_WIDTH - 1 : 
        DATA_WIDTH
      ] = {in_startofpacket, in_endofpacket};
    end
    // optional channel input
    if (CHANNEL_WIDTH) begin
      assign in_payload[
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH - 1 : 
        DATA_WIDTH + PACKET_WIDTH
      ] = in_channel;
    end
    // optional empty input
    if (EMPTY_WIDTH) begin
      assign in_payload[
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH + EMPTY_WIDTH - 1 : 
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH
      ] = in_empty;
    end
    // optional error input
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

  // Assign out_data and other optional out_* interface signals from out_payload.
  assign out_data = out_payload[DATA_WIDTH - 1 : 0];
  generate
    // optional packet outputs
    if (PACKET_WIDTH) begin
      assign {out_startofpacket, out_endofpacket} = 
        out_payload[DATA_WIDTH + PACKET_WIDTH - 1 : DATA_WIDTH];
    end else begin
      // Avoid a "has no driver" warning.
      assign {out_startofpacket, out_endofpacket} = 2'b0;
    end

    // optional channel output
    if (CHANNEL_WIDTH) begin
      assign out_channel = out_payload[
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH - 1 : 
        DATA_WIDTH + PACKET_WIDTH
      ];
    end else begin
      // Avoid a "has no driver" warning.
      assign out_channel = 1'b0;
    end
    // optional empty output
    if (EMPTY_WIDTH) begin
      assign out_empty = out_payload[
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH + EMPTY_WIDTH - 1 : 
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH
      ];
    end else begin
      // Avoid a "has no driver" warning.
      assign out_empty = 1'b0;
    end
    // optional error output
    if (ERROR_WIDTH) begin
      assign out_error = out_payload[
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH + EMPTY_WIDTH + ERROR_WIDTH - 1 : 
        DATA_WIDTH + PACKET_WIDTH + CHANNEL_WIDTH + EMPTY_WIDTH
      ];
    end else begin
      // Avoid a "has no driver" warning.
      assign out_error = 1'b0;
    end
  endgenerate

endmodule


`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "FQbdgc6L7IBAY6fOekGDZSoPPgzAvTLS5KI4ZFuNrzNpTW8vAdrHoXjbN9QDDni9wandNqca4alTzfPQdbuyX8xJkBUKByOgHDrbWP9Om8Wf/wBzwdp7QRgAIoMl3XHkp6wfCOAmKGBGXhS+D0N58GZjgAxZE5k1kPkGwTW2HK66FVEKxZmgFTH/3PkyONzjSYFAnIyDnLAccODH1NLcP+QMpGqPUsBsbddxoMEc9m5kHjNOpAP4JeUqGYn/doSZsxyBzQRu8hZNY6S7LEQJwfdYLOoBb4r6zEJcWA1xMkXjj93RhH40L7xYidz4GEPdywS+dGE+cfJaz/iTiNCLfVdfo8EbVMHVSucIlH2JycUmfW/5X75OAkMi4RyzPSi8KWsJMNWneXqMZcAlcNnrOqiHUGkBfOWoHfCUyLkCvBpvotOqaLyWOT96Dv98o3fAOoefZhAu8cGDlMXrJrI4kTnf00wgOd4Jr3Bj+0qK+zkFazLTw9JRn+kvIoz1jVX12aDG1sr6dakDBtjuYB5RpSiekNH5rfb2WH1EHjc8frm4mQEeqFIl4xOg572PlJL9l6VBKtDL7DifpDSz2POYAhQNtnXXlA525nOuJ/RZgoFnOU+0MGytFal6jBkPg/4RDZ9bEMz9sHLv53efpCEOV8LkIUQ+1aRRGSxBH6IyAiNfzfzXOMqwZF9Wr5quc6F42OF3z8Hn18sxxWSUa69VarMK86gzr9+JxfxeayhKBVGxJFN5tfLMa45VByOxuRKppps3wzeA6u0wHUg89/Q7VLEaXDcuPy3xSSD/6vag5jGiVvM/ajjtRbVoF/0JMmhYEjidrNIYQuYGBHsnl+hVjZsTj/zREh67umQohQTLfnbHM9ocahhYxOUE+aGcH3cuyAWfNPoTVr/jndy6RAuHlKrUwRPZIeo4xLkKrTxomyfRiYvDXe8PIYtxmay+aDTWBiV1EItTITb2k3TTkp2uu/LsKf5D08FlZ+qVGwctkOeEJq5ZsAuSE3jnTLpZaGu1"
`endif