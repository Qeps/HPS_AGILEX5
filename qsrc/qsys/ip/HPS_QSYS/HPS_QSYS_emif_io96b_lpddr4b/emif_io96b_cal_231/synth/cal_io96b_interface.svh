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


`ifndef CAL_ARCH_FP_INTERFACE

`define CAL_ARCH_FP_INTERFACE 1

// altera message_off 18455
interface AXILITE_BUS #(
  parameter int signed PORT_AXI_AXADDR_WIDTH  = 0,
  parameter int signed PORT_AXI_AXID_WIDTH    = 0,
  parameter int signed PORT_AXI_AXBURST_WIDTH = 0,
  parameter int signed PORT_AXI_AXLEN_WIDTH   = 0,
  parameter int signed PORT_AXI_AXSIZE_WIDTH  = 0,
  parameter int signed PORT_AXI_AXUSER_WIDTH  = 0,
  parameter int signed PORT_AXI_DATA_WIDTH    = 0,
  parameter int signed PORT_AXI_STRB_WIDTH    = 0,
  parameter int signed PORT_AXI_RESP_WIDTH    = 0,
  parameter int signed PORT_AXI_ID_WIDTH      = 0,
  parameter int signed PORT_AXI_USER_WIDTH    = 0,
  parameter int signed PORT_AXI_AXQOS_WIDTH   = 0,
  parameter int signed PORT_AXI_AXCACHE_WIDTH = 0,
  parameter int signed PORT_AXI_AXPROT_WIDTH  = 0
);

typedef logic                              clk_t;
typedef logic                              rst_n_t;
typedef logic [PORT_AXI_AXADDR_WIDTH-1:0]  addr_t;
typedef logic [PORT_AXI_AXID_WIDTH-1:0]    id_t;
typedef logic [PORT_AXI_AXBURST_WIDTH-1:0] burst_t;
typedef logic [PORT_AXI_AXLEN_WIDTH-1:0]   len_t;
typedef logic [PORT_AXI_AXSIZE_WIDTH-1:0]  size_t;
typedef logic [PORT_AXI_AXUSER_WIDTH-1:0]  user_t;
typedef logic [PORT_AXI_DATA_WIDTH-1:0]    data_t;
typedef logic [PORT_AXI_STRB_WIDTH-1:0]    strb_t;
typedef logic [PORT_AXI_RESP_WIDTH-1:0]    resp_t;
typedef logic [PORT_AXI_ID_WIDTH-1:0]      respid_t;
typedef logic [PORT_AXI_USER_WIDTH-1:0]    respuser_t;
typedef logic [PORT_AXI_AXQOS_WIDTH-1:0]   qos_t;
typedef logic [PORT_AXI_AXCACHE_WIDTH-1:0] cache_t;
typedef logic [PORT_AXI_AXPROT_WIDTH-1:0]  prot_t;

clk_t             clk;
rst_n_t           rst_n;

id_t              awid;
addr_t            awaddr;
len_t             awlen;
size_t            awsize;
burst_t           awburst;
logic             awlock;
cache_t           awcache;
prot_t            awprot;
qos_t             awqos;
user_t            awuser;
logic             awvalid;
logic             awready;

data_t            wdata;
strb_t            wstrb;
logic             wlast;
respuser_t        wuser;
logic             wvalid;
logic             wready;

respid_t          bid;
resp_t            bresp;
respuser_t        buser;
logic             bvalid;
logic             bready;

id_t              arid;
addr_t            araddr;
len_t             arlen;
size_t            arsize;
burst_t           arburst;
logic             arlock;
cache_t           arcache;
prot_t            arprot;
qos_t             arqos;
user_t            aruser;
logic             arvalid;
logic             arready;

respid_t          rid;
data_t            rdata;
resp_t            rresp;
logic             rlast;
respuser_t        ruser;
logic             rvalid;
logic             rready;

modport Manager (
   input clk, rst_n,
   output awid, awaddr, awlen, awsize, awburst, awlock, awcache, awprot, awqos, awuser, awvalid, input awready,
   output wdata, wstrb, wlast, wuser, wvalid, input wready,
   input bid, bresp, buser, bvalid, output bready,
   output arid, araddr, arlen, arsize, arburst, arlock, arcache, arprot, arqos, aruser, arvalid, input arready,
   input rid, rdata, rresp, rlast, ruser, rvalid, output rready
);

modport Subordinate (
   output clk, rst_n,
   input awid, awaddr, awlen, awsize, awburst, awlock, awcache, awprot, awqos, awuser, awvalid, output awready,
   input wdata, wstrb, wlast, wuser, wvalid, output wready,
   output bid, bresp, buser, bvalid, input bready,
   input arid, araddr, arlen, arsize, arburst, arlock, arcache, arprot, arqos, aruser, arvalid, output arready,
   output rid, rdata, rresp, rlast, ruser, rvalid, input rready
);

endinterface

`endif 
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1ZHIf/7QoM7vuJXSwmRy4Cct0b7L0ERAV33KfnEBcPwMlIHfS3ZlLeMn76Cr7K4NfZFNK4a5xnW5HNvzPggCdb76ijO9CuSX+mSnY3YBbPyrrw839hUuyCt94VvE3SbbXiZ0IjZz2dhrMFAdgbxJSlRX5AB4/EyRr6miIUZh0MSC9JDf+KZKIzEGouRCyo+XAXRbiqodMJzxTmsR2zakElRGHiS0Y8SA2ANoZm2NwzIc5r3f3Djq+uOwlvi5hZBLvkK60yVVwqesaeh7w+EXfrVwY5EzVi6kkCkBX3ocDU4zPo5jmKkRt1oZ2XKi46QGwrthzMHQRUutWNPfwfUdskMBr0DB/3fpOhPfmDr/nCS8avtp2SSvjsKtwToR3f7OWT95XwgEe7RpuBNsakp6gd+Yakk2XcinzHhWVuqfab5htRNGbFgRR04KZ+J7phuvbODCTIIpF9bIUHuIERP2zMUqOE55z6pWiXk9PyPaGTpaxCieQWebrykgePFKnIBSoheDDjLAh+l+fea8uvsRC+8gJG0HPwbt5lcejjhBNglHwUN8RDgJtQh5srUJL2J2ivN/5aUceA6U8gCGMo5GTjcicQfPJYbG/Tbs8zxMpP+JcJf78WKRxJUnRat7uaiVUSgpjCUoP4SCHAsVDLjWdBAbHqbV3wDAuUHMBfDR6/V/Y7aS3muIoMEbv4DSWTjvmBqUmtcvGyFR4hkOXcuiWo9cRre6UHI9tUcv8bJlfngCF5ag9VkabzDakVsyoOwMwRSvBwGUdgnA4vDpnQi2WQE"
`endif