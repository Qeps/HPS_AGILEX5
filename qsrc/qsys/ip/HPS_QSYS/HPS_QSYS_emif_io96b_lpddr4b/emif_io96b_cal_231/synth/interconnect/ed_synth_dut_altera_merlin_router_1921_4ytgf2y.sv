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









`timescale 1 ns / 1 ns


module ed_synth_dut_altera_merlin_router_1921_4ytgf2y_default_decode
  #(
     parameter DEFAULT_CHANNEL = 0,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 0 
   )
  (output [152 - 152 : 0] default_destination_id,
   output [2-1 : 0] default_wr_channel,
   output [2-1 : 0] default_rd_channel,
   output [2-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[152 - 152 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 2'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 2'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 2'b1 << DEFAULT_RD_CHANNEL;
    end
  endgenerate

endmodule


module ed_synth_dut_altera_merlin_router_1921_4ytgf2y
(
    input clk,
    input reset,

    input                       sink_valid,
    input  [188-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    output                          src_valid,
    output reg [188-1    : 0] src_data,
    output reg [2-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    localparam PKT_ADDR_H = 67;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 152;
    localparam PKT_DEST_ID_L = 152;
    localparam PKT_PROTECTION_H = 162;
    localparam PKT_PROTECTION_L = 160;
    localparam ST_DATA_W = 188;
    localparam ST_CHANNEL_W = 2;
    localparam DECODER_TYPE = 1;

    localparam PKT_TRANS_WRITE = 70;
    localparam PKT_TRANS_READ  = 71;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    localparam ADDR_RANGE = 64'h0;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;

    localparam REAL_ADDRESS_RANGE = OPTIMIZED_ADDR_H - PKT_ADDR_L;

    reg [PKT_DEST_ID_W-1 : 0] destid;

    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;
    wire [2-1 : 0] default_src_channel;




    wire read_transaction;
    assign read_transaction  = sink_data[PKT_TRANS_READ];


    ed_synth_dut_altera_merlin_router_1921_4ytgf2y_default_decode the_default_decode(
      .default_destination_id (),
      .default_wr_channel   (),
      .default_rd_channel   (),
      .default_src_channel  (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;

        destid      = sink_data[PKT_DEST_ID_H : PKT_DEST_ID_L];



        if (destid == 0  && read_transaction) begin
            src_channel = 2'b1;
        end

    end


    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJPrw2GhIFjfwjl+eKYOnkdLubhs/4mEhTnxYoq85XcDobb7QMmuDPTMy+zY07BvKE8DP4yb1ODw7IqxiepHC9XLtzd8o7Op6uAJpkhEhhPsizgevPcaVxfgbwA4aUR3qfx7gI3MjLC54NOm1h+mMvqFrXtefKVD0epV/PUhI/h1KrjXzr2tURrHt1xvw5HEgXiF/fvukWyYIKffVGx4cIY3SGwIRjkLGcQN5vlDCeVgfXEYgWbZFrbVAmGnjRRjbwEvjT+yeokRPQJlHVRQTrYdx5macLdOsJ9LiL2eEQcz9YsEn41gC26Jv675mjzXeDf6AtoabBhPy3VMwYhOaTFoG7zGtw6PQXKnDL8SrEaSOJvh3ocDHPd5gUFxaYLKoHcX6qF9rtpvyfUC1ntRPO0bEeV6DdxFNCZdqQHV/tvK4l1/pxn1MS5kqpvHGGqQ+QPM/onnTKvcjq84Zw8BeryxA1pZnuBl6grGPWroavU2Nb30DHHVUiDTze4BAe+fNzOHAHaBKn2Rpb0xAcVd77BZPZysaXy0YDFFQcoPrdVOMrZzXR5Jeew9QVdJLXMY9dXuHg07f8a7qrRxS0gKnM8e6oyUgAj+EpqjXkocAKhlt6jTv0gUzEhADQLHwZGEop7HnoFTTAydmxquc5Aaf9i7bdobsyOOPvUN9y/REermPdp5tI4vCS65DoQMzbyEtxWlIhidw1c5JMiaKxxUekKsaLAMA1MbCWfzApmXcEJ1ZBD7lk7QLV/HN2RV7Z9uZJvSEuzG9WTAQwB25LewllFJ"
`endif