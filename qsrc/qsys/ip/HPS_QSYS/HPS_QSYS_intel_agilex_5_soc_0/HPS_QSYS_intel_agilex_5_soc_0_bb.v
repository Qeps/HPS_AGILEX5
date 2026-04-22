module HPS_QSYS_intel_agilex_5_soc_0 (
		output wire         h2f_reset_reset,            //            h2f_reset.reset,   Active high reset from the HPS Reset Manager.
		input  wire         hps2fpga_axi_clock_clk,     //   hps2fpga_axi_clock.clk,     Clock from a single source in the FPGA.
		input  wire         hps2fpga_axi_reset_reset,   //   hps2fpga_axi_reset.reset,   Async reset to the Bridge logic. This signal is active-HIGH.
		output wire [3:0]   hps2fpga_awid,              //             hps2fpga.awid,    Identification tag for a write transaction.
		output wire [27:0]  hps2fpga_awaddr,            //                     .awaddr,  The address of the first transfer in a write transaction.
		output wire [7:0]   hps2fpga_awlen,             //                     .awlen,   The exact number of data transfers in a write transaction.
		output wire [2:0]   hps2fpga_awsize,            //                     .awsize,  The number of bytes in each data transfer in a write transaction.
		output wire [1:0]   hps2fpga_awburst,           //                     .awburst, Indicates how address changes between each transfer in a write transaction.
		output wire         hps2fpga_awlock,            //                     .awlock,  Provides information about the atomic characteristics of a write transaction.
		output wire [3:0]   hps2fpga_awcache,           //                     .awcache, Indicates how a write transaction is required to progress through a system.
		output wire [2:0]   hps2fpga_awprot,            //                     .awprot,  Protection attributes of a write transaction: privilege, security level, and access type.
		output wire         hps2fpga_awvalid,           //                     .awvalid, Indicates that the write address channel signals are valid.
		input  wire         hps2fpga_awready,           //                     .awready, Indicates that a transfer on the write address channel can be accepted.
		output wire [127:0] hps2fpga_wdata,             //                     .wdata,   Write data.
		output wire [15:0]  hps2fpga_wstrb,             //                     .wstrb,   Write strobes, indicate which byte lanes hold valid data.
		output wire         hps2fpga_wlast,             //                     .wlast,   User-defined extension for the write data channel.
		output wire         hps2fpga_wvalid,            //                     .wvalid,  Indicates that the write data channel signals are valid.
		input  wire         hps2fpga_wready,            //                     .wready,  Indicates that a transfer on the write data channel can be accepted.
		input  wire [3:0]   hps2fpga_bid,               //                     .bid,     Transaction identifier for the write response.
		input  wire [1:0]   hps2fpga_bresp,             //                     .bresp,   Write response, indicates the status of a write transaction.
		input  wire         hps2fpga_bvalid,            //                     .bvalid,  Indicates that the write response channel signals are valid.
		output wire         hps2fpga_bready,            //                     .bready,  Indicates that a transfer on the write response channel can be accepted.
		output wire [3:0]   hps2fpga_arid,              //                     .arid,    Transaction identifier for the read transaction.
		output wire [27:0]  hps2fpga_araddr,            //                     .araddr,  The address of the first transfer in a read transaction.
		output wire [7:0]   hps2fpga_arlen,             //                     .arlen,   The exact number of data transfers in a read transaction.
		output wire [2:0]   hps2fpga_arsize,            //                     .arsize,  The number of bytes in each data transfer in a read transaction.
		output wire [1:0]   hps2fpga_arburst,           //                     .arburst, Indicates how address changes between each transfer in a read transaction.
		output wire         hps2fpga_arlock,            //                     .arlock,  Provides information about the atomic characteristics of a read transaction.
		output wire [3:0]   hps2fpga_arcache,           //                     .arcache, Indicates how a read transaction is required to progress through a system.
		output wire [2:0]   hps2fpga_arprot,            //                     .arprot,  Protection attributes of a read transaction: privilege, security level, and access type.
		output wire         hps2fpga_arvalid,           //                     .arvalid, Indicates that the read address channel signals are valid.
		input  wire         hps2fpga_arready,           //                     .arready, Indicates that a transfer on the read address channel can be accepted.
		input  wire [3:0]   hps2fpga_rid,               //                     .rid,     Identification tag for read data and response.
		input  wire [127:0] hps2fpga_rdata,             //                     .rdata,   Read data.
		input  wire [1:0]   hps2fpga_rresp,             //                     .rresp,   Read response, indicates the status of a read transfer.
		input  wire         hps2fpga_rlast,             //                     .rlast,   Indicates whether this is the last data transfer in a read transaction.
		input  wire         hps2fpga_rvalid,            //                     .rvalid,  Indicates that the read data channel signals are valid.
		output wire         hps2fpga_rready,            //                     .rready,  Indicates that a transfer on the read data channel can be accepted.
		input  wire         lwhps2fpga_axi_clock_clk,   // lwhps2fpga_axi_clock.clk,     clock from a single source in the FPGA.
		input  wire         lwhps2fpga_axi_reset_reset, // lwhps2fpga_axi_reset.reset,   Async reset to the Bridge logic. This signal is active-HIGH.
		output wire [3:0]   lwhps2fpga_awid,            //           lwhps2fpga.awid,    Identification tag for a write transaction.
		output wire [23:0]  lwhps2fpga_awaddr,          //                     .awaddr,  The address of the first transfer in a write transaction.
		output wire [7:0]   lwhps2fpga_awlen,           //                     .awlen,   The exact number of data transfers in a write transaction.
		output wire [2:0]   lwhps2fpga_awsize,          //                     .awsize,  The number of bytes in each data transfer in a write transaction.
		output wire [1:0]   lwhps2fpga_awburst,         //                     .awburst, Indicates how address changes between each transfer in a write transaction.
		output wire         lwhps2fpga_awlock,          //                     .awlock,  Provides information about the atomic characteristics of a write transaction.
		output wire [3:0]   lwhps2fpga_awcache,         //                     .awcache, Indicates how a write transaction is required to progress through a system.
		output wire [2:0]   lwhps2fpga_awprot,          //                     .awprot,  Protection attributes of a write transaction: privilege, security level, and access type.
		output wire         lwhps2fpga_awvalid,         //                     .awvalid, Indicates that the write address channel signals are valid.
		input  wire         lwhps2fpga_awready,         //                     .awready, Indicates that a transfer on the write address channel can be accepted.
		output wire [31:0]  lwhps2fpga_wdata,           //                     .wdata,   Write data.
		output wire [3:0]   lwhps2fpga_wstrb,           //                     .wstrb,   Write strobes, indicate which byte lanes hold valid data.
		output wire         lwhps2fpga_wlast,           //                     .wlast,   User-defined extension for the write data channel.
		output wire         lwhps2fpga_wvalid,          //                     .wvalid,  Indicates that the write data channel signals are valid.
		input  wire         lwhps2fpga_wready,          //                     .wready,  Indicates that a transfer on the write data channel can be accepted.
		input  wire [3:0]   lwhps2fpga_bid,             //                     .bid,     Transaction identifier for the write response.
		input  wire [1:0]   lwhps2fpga_bresp,           //                     .bresp,   Write response, indicates the status of a write transaction.
		input  wire         lwhps2fpga_bvalid,          //                     .bvalid,  Indicates that the write response channel signals are valid.
		output wire         lwhps2fpga_bready,          //                     .bready,  Indicates that a transfer on the write response channel can be accepted.
		output wire [3:0]   lwhps2fpga_arid,            //                     .arid,    Transaction identifier for the read transaction.
		output wire [23:0]  lwhps2fpga_araddr,          //                     .araddr,  The address of the first transfer in a read transaction.
		output wire [7:0]   lwhps2fpga_arlen,           //                     .arlen,   The exact number of data transfers in a read transaction.
		output wire [2:0]   lwhps2fpga_arsize,          //                     .arsize,  The number of bytes in each data transfer in a read transaction.
		output wire [1:0]   lwhps2fpga_arburst,         //                     .arburst, Indicates how address changes between each transfer in a read transaction.
		output wire         lwhps2fpga_arlock,          //                     .arlock,  Provides information about the atomic characteristics of a read transaction.
		output wire [3:0]   lwhps2fpga_arcache,         //                     .arcache, Indicates how a read transaction is required to progress through a system.
		output wire [2:0]   lwhps2fpga_arprot,          //                     .arprot,  Protection attributes of a read transaction: privilege, security level, and access type.
		output wire         lwhps2fpga_arvalid,         //                     .arvalid, Indicates that the read address channel signals are valid.
		input  wire         lwhps2fpga_arready,         //                     .arready, Indicates that a transfer on the read address channel can be accepted.
		input  wire [3:0]   lwhps2fpga_rid,             //                     .rid,     Identification tag for read data and response.
		input  wire [31:0]  lwhps2fpga_rdata,           //                     .rdata,   Read data.
		input  wire [1:0]   lwhps2fpga_rresp,           //                     .rresp,   Read response, indicates the status of a read transfer.
		input  wire         lwhps2fpga_rlast,           //                     .rlast,   Indicates whether this is the last data transfer in a read transaction.
		input  wire         lwhps2fpga_rvalid,          //                     .rvalid,  Indicates that the read data channel signals are valid.
		output wire         lwhps2fpga_rready,          //                     .rready,  Indicates that a transfer on the read data channel can be accepted.
		inout  wire         hps_io_gpio41               //               hps_io.gpio41,  GPIO1 IO17
	);
endmodule

