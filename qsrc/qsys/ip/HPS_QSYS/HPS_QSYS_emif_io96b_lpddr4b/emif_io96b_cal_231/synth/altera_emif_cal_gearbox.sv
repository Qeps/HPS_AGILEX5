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


///////////////////////////////////////////////////////////////////////////////
// This module implements the gearbox logic to compress the number of wire
// connections to the IOSSM debug port.
//
///////////////////////////////////////////////////////////////////////////////


module altera_emif_cal_gearbox
  #(parameter AXI_ADDR_WIDTH = 20,
    parameter AXI_DATA_WIDTH = 32)
   (

    // AXI-Lite User Interface
    input  logic                       axi_clk,
    input  logic                       axi_rst_n,

    input  logic                       axi_awvalid,
    output logic                       axi_awready,
    input  logic  [AXI_ADDR_WIDTH-1:0] axi_awaddr,

    input  logic                       axi_arvalid,
    output logic                       axi_arready,
    input  logic  [AXI_ADDR_WIDTH-1:0] axi_araddr,

    input  logic                       axi_wvalid,
    output logic                       axi_wready,
    input  logic  [AXI_DATA_WIDTH-1:0] axi_wdata,

    output logic                       axi_rvalid,
    input  logic                       axi_rready,
    output logic [ 1:0]                axi_rresp,
    output logic [AXI_DATA_WIDTH-1:0]  axi_rdata,

    output logic                       axi_bvalid,
    input  logic                       axi_bready,
    output logic [ 1:0]                axi_bresp,

    // IOSSM C2P/P2C Interface
    output logic [5:0]                 ssm_c2p,
    input  logic [4:0]                 ssm_p2c
    );
   
   timeunit 1ns;
   timeprecision 1ps;

   logic                        clk, rst_n;
   
   assign clk     = axi_clk;
   assign rst_n     = axi_rst_n;

   logic                        f2c_addr_valid, f2c_data_valid;
   logic [7:0][3:0]             f2c_addr      , f2c_data      ;
   (* preserve *) logic [3:0]   f2c_pkt;
   (* preserve *) logic         f2c_pkt_valid;
   logic [7:0][3:0]             f2c_rdata ;
   logic [1:0]                  f2c_rresp ;
   logic                        f2c_rvalid;
   logic                        axi_grant_read;
   logic [4:0]                  prev_ssm_p2c;
   
   typedef enum bit [3:0] {
      F2C_CMD_WRITE=0,
      F2C_CMD_READ=1,
      F2C_CMD_ACK=2
   } f2c_cmd_t;
   f2c_cmd_t                    f2c_cmd;

   typedef enum bit [4:0] {
      F2C_IDLE,
      F2C_CMD,
      F2C_A[8],
      F2C_D[8],
      F2C_WAIT,
      F2C_CLEAR 
   } f2c_state_t;
   f2c_state_t f2c_state;
   
   assign ssm_c2p[4] = f2c_pkt_valid;
   assign ssm_c2p[3:0] = f2c_pkt;

   //////////////////////////////////////////////////////////////////
   // RESPONSE PATH
   //////////////////////////////////////////////////////////////////
   // 
   // For read response, we need to accumulate all the 8slices (of 4bits each) to a 32-bit rdata.
   //         rctr: read-counter keeps a track of which slice is being recvd.
   //
   // For write response, its sent ut in the same cycle.
   // 
   assign axi_rvalid = f2c_rvalid;
   assign axi_rdata  = f2c_rdata;
   assign axi_rresp  = f2c_rresp;
   assign axi_bvalid = ssm_p2c[4] && ssm_p2c[3:0] == F2C_CMD_ACK && (!prev_ssm_p2c);
   assign axi_bresp  = 2'b0;
   logic [2:0] rctr;
   logic       rctr_en;
   always @(posedge clk, negedge rst_n) begin
      if (!rst_n) begin
         f2c_rresp    <= '0;
         f2c_rdata    <= '0;
      end else begin
         if (!rctr_en) f2c_rresp <= (ssm_p2c[4] && ssm_p2c[2]) ? ssm_p2c[1:0] : '0;
         if (rctr_en) f2c_rdata[7-rctr] <= ssm_p2c[3:0];     
      end
   end
   always @(posedge clk, negedge rst_n) begin
      if (!rst_n) begin
         rctr         <= '0;
         rctr_en      <= '0;
      end else begin
         rctr <= rctr_en? rctr + 1'b1 : rctr;
         if (ssm_p2c[4] && ssm_p2c[2] && rctr_en == 0 && !prev_ssm_p2c) begin
            rctr_en <= 1'b1;
         end else if (rctr_en==1 && &rctr) begin
            rctr_en <= 1'b0;
         end
      end
   end
   
   always @(posedge clk, negedge rst_n) begin
      if (!rst_n) begin
         f2c_rvalid   <= '0;
      end else begin
         if(!f2c_rvalid) begin
            f2c_rvalid <= &rctr;         
         end 
         else  begin
            if(axi_rready || (ssm_p2c[4] && ssm_p2c[2] && rctr_en == 0 && !prev_ssm_p2c))
               f2c_rvalid <= '0; 
         end      
      end
   end

   always_ff@(posedge clk, negedge rst_n)begin
      if(!rst_n) begin
         prev_ssm_p2c <= 5'b11111;
      end else begin
         prev_ssm_p2c <= ssm_p2c;
      end
   end

   //////////////////////////////////////////////////////////////////
   // COMMAND/WDATA PATH
   //////////////////////////////////////////////////////////////////
   // 
   // f2c_state
   // 
   //  IDLE -> CMD -> A0 -> A1 -> .... A7 ---> D0 -> D1 -> .... D7 ----> CLEAR -> IDLE
   //                                      |                         |                                    
   //                                      v                         ^                                    
   //                                      |                         |                                    
   //                                      --------------->-----------
   //                                            if cmd =read                                     
   // For read request ->
   //       required: a handshake on AR-channel
   //       to send : CMD=1 (READ), followed by ADDR slices
   //       control : f2c_state FSM controls sending out 4-bit slice at a time. 
   //                 It jumps to CLEAR state after state A_7
   // 
   // For write request, 
   //       required: a handshake on AW-channel and W-channel
   //       to send : CMD=1 (READ), followed by ADDR slices and DATA slices
   //       control : f2c_state FSM controls sending out 4-bit slice at a time. 
   // 

   // If either AR/AW, then grant that. 
   // If   both AR/AW, then arbitrate
   assign axi_awready = !f2c_addr_valid && (!axi_arvalid || !axi_grant_read); 
   assign axi_arready = !f2c_addr_valid && (!axi_awvalid ||  axi_grant_read); 
   assign axi_wready  = !f2c_data_valid;
   
   // Arbitration between AR/AW
   always @(posedge clk, negedge rst_n) begin
      if (!rst_n) begin
         axi_grant_read   <= 1'b1;
      end else begin
         case (1)
           (axi_arvalid && axi_arready): axi_grant_read <= 1'b0; // Just allowed a  read, next time prioritize write
           (axi_awvalid && axi_awready): axi_grant_read <= 1'b1; // Just allowed a write, next time prioritize  read
         endcase
      end
   end
   
   // Store AXI (Addr/WData) signals, deassert axready/wready, if these storages are full.
   always @(posedge clk, negedge rst_n) begin
      if (!rst_n) begin
         {f2c_addr_valid,f2c_addr} <= '0;
         {f2c_data_valid,f2c_data} <= '0;
         f2c_cmd                   <= F2C_CMD_WRITE;
      end else begin
         if (axi_arvalid && axi_arready) begin
            f2c_addr_valid <= 1'b1;
            f2c_addr       <= 32'(axi_araddr);
            f2c_cmd        <= F2C_CMD_READ;
         end else if  (axi_awvalid && axi_awready) begin
            f2c_addr_valid <= 1'b1;
            f2c_addr       <= 32'(axi_awaddr);
            f2c_cmd        <= F2C_CMD_WRITE;
         end else if (f2c_state == F2C_CLEAR) begin
            f2c_addr_valid <= 1'b0;
         end
         if (axi_wvalid && axi_wready) begin
            f2c_data_valid <= 1'b1;
            f2c_data       <= 32'(axi_wdata);
         end else if (f2c_state == F2C_CLEAR && f2c_cmd == F2C_CMD_WRITE) begin // A stored write data can only proceed with wr command
            f2c_data_valid <= 1'b0;
         end
      end
   end
   
   // F2C State Machine
   always @(posedge clk, negedge rst_n) begin

      if (!rst_n) begin
         f2c_state     <= F2C_IDLE;
         f2c_pkt       <= '0;
         f2c_pkt_valid <= '0;

      end else begin

         case (f2c_state)

           F2C_IDLE: begin
              if ((f2c_addr_valid && f2c_cmd==F2C_CMD_READ) || (f2c_addr_valid && f2c_data_valid)) begin
                 f2c_state <= F2C_CMD;
                 f2c_pkt <= f2c_cmd;
                 f2c_pkt_valid <= 1'b1;
              end
           end
           
           F2C_CMD: begin
              f2c_state     <= F2C_A0;
              f2c_pkt       <= f2c_addr[7];
              f2c_pkt_valid <= 1'b1;
           end
           
           F2C_A0, F2C_A1, F2C_A2, F2C_A3, F2C_A4, F2C_A5, F2C_A6 : begin
              f2c_state     <= f2c_state.next();
              f2c_pkt       <= f2c_addr[7-(f2c_state-F2C_A0+1)];
              f2c_pkt_valid <= 1'b1;
           end
           
           F2C_A7 : begin
              if (f2c_cmd == F2C_CMD_READ) begin
                 f2c_state     <= F2C_WAIT;
                 f2c_pkt_valid <= 1'b0;
                 f2c_pkt       <= 4'b0;
              end else begin
                 f2c_state     <= F2C_D0;
                 f2c_pkt_valid <= 1'b1;
                 f2c_pkt       <= f2c_data[7];
              end
           end
                 
           F2C_D0, F2C_D1, F2C_D2, F2C_D3, F2C_D4, F2C_D5, F2C_D6 : begin
              f2c_state     <= f2c_state.next();
              f2c_pkt       <= f2c_data[7-(f2c_state-F2C_D0+1)];
              f2c_pkt_valid <= 1'b1;
           end

           F2C_D7 : begin
              f2c_state     <= F2C_WAIT;
              f2c_pkt       <= 4'b0;
              f2c_pkt_valid <= 1'b0;
           end
           
           F2C_WAIT: begin
              if (f2c_rvalid || (ssm_p2c[4] && ssm_p2c[3:0] == F2C_CMD_ACK && (!prev_ssm_p2c))) begin
                 f2c_state     <= F2C_CLEAR;
              end else begin
                 f2c_state     <= F2C_WAIT;
              end
           end
           
           F2C_CLEAR: begin
              f2c_state <= F2C_IDLE;
           end
           
         endcase 
         
      end
      
   end

   /*TODO
    * Assertions
    *     This gearbx assumes a strict sequence. Add assertions, for the sequence.
    * Timeout?
    * 
    */
   
   
endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1ap+YD0pIinu8ng0TBY3eGsj/LOKyi6BvBV3xi5VIaagIXcB5w8Hghvcq27P+lUTImUtLMGSPSmAv9en57fhxpTrabsTmmXOEvmrLHOWFCgPraZsrRNwxncx8aqI2gwVV3Eo9FkQhclvdU4jCOzn82Wsu1NrIQPHIWpdZn1jKQD7KW1w+Cw85c7PxkKVTiDDtElbhE9FeEgZ9FHXXoRiduQx4R9s3SQlGi2CM1LX7PoF06RpE/4SCL9OOGGmDaxFeHGG2HfT+28V+hEzjB+JY5O+GFhKiBkZUiCDMabXYjcNK1QAxLHcA8zVA28Kz+yG4XTOm7eDi5qzCC7IDoZxKcxVMiyq3o9YpnCsuUkS7S1cfTOzA66Jl+9UlhT0j/4B3QHL3a5SUw6cxEhLpzzqO3DxlTQYelSdxmpGwj2m8qVScUhclZljkQMccF0wmMD3cJQCNdYvYtcBiCmCyb81POtnm15kt6hLSoELKwRGlbR8gvXN2lJTxFCzAHhFbbuLXiNX0rrCl9yQjAGRVn7otcVAnmV8482gi2CrUWqh1vV2en1XW3J4NsSSEKI4C2sGB7AVYCldZIwoft5HdH9YLrZjMdIo+sSpQugqWmd0uw/4xc5CCxrna+QUz5WYYTJixcTu1NJM5bXgmkkE6s5K+vfjdQ9TleJ4Nk3w7BPS7YhtwCBsYgEQ3srVidJyhkghE9oVPlTDKU5feK1cElwt/0v9IAMKKIViQlsw35vd/5SyWMOVdnwyhICL5JN/9DhPgSe3HZLUA9JshuUKZP3VQZ5"
`endif