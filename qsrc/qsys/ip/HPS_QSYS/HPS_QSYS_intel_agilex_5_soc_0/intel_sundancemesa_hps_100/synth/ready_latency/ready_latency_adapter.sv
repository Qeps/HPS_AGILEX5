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

// this module has zero ready latency input and non zero latency output


module ready_latency_adapter # (
 parameter READY_LATENCY_OUT = 2,
 parameter PAYLOAD_WIDTH = 256,
 parameter LOG_DEPTH = 3,
 parameter BUFFER_TYPE = "MLAB"
) (  
 output logic         in_ready,
 input  logic            in_valid,
 input  logic   [PAYLOAD_WIDTH-1: 0]  in_data,
 // Interface: out
 input  logic             out_ready,
 output logic          out_valid,
 output logic [PAYLOAD_WIDTH-1: 0] out_data,
  // Interface: clk
 input logic          clk,
 // Interface: reset
 input logic           reset

 /*AUTOARG*/);

   // ---------------------------------------------------------------------
   //| Signal Declarations
   // ---------------------------------------------------------------------
   
   logic [PAYLOAD_WIDTH-1:0]   in_payload;
   logic [PAYLOAD_WIDTH-1:0]   out_payload;
   logic            in_ready_wire;
   logic            out_valid_wire;
   logic [2:0]      fifo_fill;
   logic    rdreq;
   logic empty;   

   logic [READY_LATENCY_OUT-1:0] in_ready_dly_reg;
   logic in_ready_dly;
   assign in_ready_dly = (READY_LATENCY_OUT > 0) ? in_ready_dly_reg[0] : in_ready;

   logic fifo_wr_req;
   assign fifo_wr_req = (in_valid === 1'b1) && (in_ready_dly === 1'b1);
 
   localparam DEPTH = 2 ** LOG_DEPTH -1 ;

   // ---------------------------------------------------------------------
   //| Payload Mapping
   // ---------------------------------------------------------------------
   always @* begin
     in_payload = {in_data};
     {out_data} = out_payload;
   end

   // ---------------------------------------------------------------------
   //| FIFO
   // ---------------------------------------------------------------------                           
    scfifo_s # (
      .LOG_DEPTH (LOG_DEPTH),
      .WIDTH (PAYLOAD_WIDTH),
      .ALMOST_FULL_VALUE (DEPTH-1),
      .SHOW_AHEAD (1),
      .BUFFER_TYPE (BUFFER_TYPE)
    ) fifo_inst ( 
       .clock        (clk),
       .aclr       (1'b0),
       .sclr (reset),
       //.in_ready   (),
       .wrreq  (fifo_wr_req),      
       .data    (in_payload),
      //.out_ready  (out_ready),
       .rdreq      (rdreq),
       .q (out_payload),
       .usedw (fifo_fill),
       .empty (empty),
       .full (full),
       .almost_empty (),
       .almost_full ()
       );

   // ---------------------------------------------------------------------
   //| Ready & valid signals.
   // ---------------------------------------------------------------------
   always @* begin
      in_ready = ( DEPTH- fifo_fill > READY_LATENCY_OUT);
   end

    always @(posedge clk) begin
        in_ready_dly_reg[READY_LATENCY_OUT-1] <= in_ready;
        for (int i = 0; i < READY_LATENCY_OUT - 1; i++) begin
            in_ready_dly_reg[i] <= in_ready_dly_reg[i+1];
        end
    end

    generate
      if (BUFFER_TYPE == "MLAB") begin 
        assign out_valid = !empty;
      end
      else begin
        always @(posedge clk) begin
          out_valid <= !empty;
        end
      end
    endgenerate

   // ---------------------------------------------------------------------
   //| Read logic
   // ---------------------------------------------------------------------
   // read when out ready and fifo not empty

assign rdreq = out_ready && !empty;



endmodule


`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "wa4P/9mz5QzJaCbKgT7JOJw4FVjuprs8A5RwJjfxAxxciUOWXJIn+FtPapWtMIjHamBsUWdV2bvRqNThOSwB+furcJmByBPZXvoub8NXFzxmQ/2dXljymLby/MfmD/YBDoZ57TSQmUKoNpmLTjhhJ+g763dviJXfQF2BSnAiUoHGPmEdVkhyj7dhPx4+Eu2ipptj5TeG4+F9tpD57NeNYwNyTn1aD43KEoaGWeqQkbHp3TMPr42idOxdxq4hrmYttpFz3nUDdmqFuVAxqI+yu+N6SBhn98HtL3Pw+DnIZn9A+JTf7BrQu2m1WN+hydsdBG7dvAYgsb9hRe96DgwsySOAjqgUndUWPMGrokkdSJgJfkSasvrP0ogAslDbRx0yN90TeQwrHSsJeHQfppXqIdmxEg1HgYKyWULZ4d273WcWVZ7QQ/XyGN3zb/LHpIknGuhXBJ5jzkDXtIUB5LZ9zpLFNGiQWaoUuQyaFvV/LurdLDzgXVRPMoM7xmtCblQTlFKr7QNnJpDldRkuuGFAohwGXtKYpReeqK+kUeExFKIkbMskTC2yIQMO3MRxN1Jiu3F5QVQfBCjbGgAEF6e1KqMdC8n90xKaXEwpn4KNG7b665KO4RU3xhscsGYKFjxt3mR10gR/9JO8Jh2pv1Hcn0Az4GsxKTafNjUVkV+L3q/1MsympMRdTO3idZVsMAtmCY+tyxOqn1qnpbNOwbFhNm+eBHO12NI5QWlfSqCF2A0+bKI6NU9hfxSPFWVkh7IkL+V1IfbTBPy9HsKGkFhaXNpOLc+WXbvJ+xleyoFIVueXB+weiPeYsCzqg4VjxPLM88RtihXd65uECN9lbZW99Vji77vFktvRfFg0NvYhvK/4IRP2sgdFIy5Sd5u9ymI9Trx0hyckkf98xNZ9csIKmCXiYudjSDH5C/cSn50bcs5qc9Akrp8tGUawEOcqoXweX4o+tL3dX6Hf1HriA62gnrdizVRf9QUnBLSmxg71GF9961qHHD5JFVgj06SQxmYq"
`endif