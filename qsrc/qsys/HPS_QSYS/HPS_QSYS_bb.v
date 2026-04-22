module HPS_QSYS (
		output wire [3:0]   hps2fpga_awid,    // hps2fpga.awid
		output wire [27:0]  hps2fpga_awaddr,  //         .awaddr
		output wire [7:0]   hps2fpga_awlen,   //         .awlen
		output wire [2:0]   hps2fpga_awsize,  //         .awsize
		output wire [1:0]   hps2fpga_awburst, //         .awburst
		output wire         hps2fpga_awlock,  //         .awlock
		output wire [3:0]   hps2fpga_awcache, //         .awcache
		output wire [2:0]   hps2fpga_awprot,  //         .awprot
		output wire         hps2fpga_awvalid, //         .awvalid
		input  wire         hps2fpga_awready, //         .awready
		output wire [127:0] hps2fpga_wdata,   //         .wdata
		output wire [15:0]  hps2fpga_wstrb,   //         .wstrb
		output wire         hps2fpga_wlast,   //         .wlast
		output wire         hps2fpga_wvalid,  //         .wvalid
		input  wire         hps2fpga_wready,  //         .wready
		input  wire [3:0]   hps2fpga_bid,     //         .bid
		input  wire [1:0]   hps2fpga_bresp,   //         .bresp
		input  wire         hps2fpga_bvalid,  //         .bvalid
		output wire         hps2fpga_bready,  //         .bready
		output wire [3:0]   hps2fpga_arid,    //         .arid
		output wire [27:0]  hps2fpga_araddr,  //         .araddr
		output wire [7:0]   hps2fpga_arlen,   //         .arlen
		output wire [2:0]   hps2fpga_arsize,  //         .arsize
		output wire [1:0]   hps2fpga_arburst, //         .arburst
		output wire         hps2fpga_arlock,  //         .arlock
		output wire [3:0]   hps2fpga_arcache, //         .arcache
		output wire [2:0]   hps2fpga_arprot,  //         .arprot
		output wire         hps2fpga_arvalid, //         .arvalid
		input  wire         hps2fpga_arready, //         .arready
		input  wire [3:0]   hps2fpga_rid,     //         .rid
		input  wire [127:0] hps2fpga_rdata,   //         .rdata
		input  wire [1:0]   hps2fpga_rresp,   //         .rresp
		input  wire         hps2fpga_rlast,   //         .rlast
		input  wire         hps2fpga_rvalid,  //         .rvalid
		output wire         hps2fpga_rready,  //         .rready
		inout  wire         hps_io_gpio41,    //   hps_io.gpio41
		input  wire         refclk_clk,       //   refclk.clk
		output wire         locked_export,    //   locked.export
		input  wire         reset_reset,      //    reset.reset
		input  wire         in_reset_reset_n  // in_reset.reset_n
	);
endmodule

