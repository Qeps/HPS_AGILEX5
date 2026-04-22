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



module HPS_QSYS_intel_agilex_5_soc_0_intel_sundancemesa_hps_100_s3hty6a(
  output wire [0 : 0 ] h2f_reset
 ,input wire [0 : 0 ] hps2fpga_clk
 ,input wire [0 : 0 ] hps2fpga_rst
 ,output wire [3 : 0 ] hps2fpga_awid
 ,output wire [27 : 0 ] hps2fpga_awaddr
 ,output wire [7 : 0 ] hps2fpga_awlen
 ,output wire [2 : 0 ] hps2fpga_awsize
 ,output wire [1 : 0 ] hps2fpga_awburst
 ,output wire [0 : 0 ] hps2fpga_awlock
 ,output wire [3 : 0 ] hps2fpga_awcache
 ,output wire [2 : 0 ] hps2fpga_awprot
 ,output wire [0 : 0 ] hps2fpga_awvalid
 ,input wire [0 : 0 ] hps2fpga_awready
 ,output wire [127 : 0 ] hps2fpga_wdata
 ,output wire [15 : 0 ] hps2fpga_wstrb
 ,output wire [0 : 0 ] hps2fpga_wlast
 ,output wire [0 : 0 ] hps2fpga_wvalid
 ,input wire [0 : 0 ] hps2fpga_wready
 ,input wire [3 : 0 ] hps2fpga_bid
 ,input wire [1 : 0 ] hps2fpga_bresp
 ,input wire [0 : 0 ] hps2fpga_bvalid
 ,output wire [0 : 0 ] hps2fpga_bready
 ,output wire [3 : 0 ] hps2fpga_arid
 ,output wire [27 : 0 ] hps2fpga_araddr
 ,output wire [7 : 0 ] hps2fpga_arlen
 ,output wire [2 : 0 ] hps2fpga_arsize
 ,output wire [1 : 0 ] hps2fpga_arburst
 ,output wire [0 : 0 ] hps2fpga_arlock
 ,output wire [3 : 0 ] hps2fpga_arcache
 ,output wire [2 : 0 ] hps2fpga_arprot
 ,output wire [0 : 0 ] hps2fpga_arvalid
 ,input wire [0 : 0 ] hps2fpga_arready
 ,input wire [3 : 0 ] hps2fpga_rid
 ,input wire [127 : 0 ] hps2fpga_rdata
 ,input wire [1 : 0 ] hps2fpga_rresp
 ,input wire [0 : 0 ] hps2fpga_rlast
 ,input wire [0 : 0 ] hps2fpga_rvalid
 ,output wire [0 : 0 ] hps2fpga_rready
 ,input wire [0 : 0 ] lwhps2fpga_clk
 ,input wire [0 : 0 ] lwhps2fpga_rst
 ,output wire [3 : 0 ] lwhps2fpga_awid
 ,output wire [23 : 0 ] lwhps2fpga_awaddr
 ,output wire [7 : 0 ] lwhps2fpga_awlen
 ,output wire [2 : 0 ] lwhps2fpga_awsize
 ,output wire [1 : 0 ] lwhps2fpga_awburst
 ,output wire [0 : 0 ] lwhps2fpga_awlock
 ,output wire [3 : 0 ] lwhps2fpga_awcache
 ,output wire [2 : 0 ] lwhps2fpga_awprot
 ,output wire [0 : 0 ] lwhps2fpga_awvalid
 ,input wire [0 : 0 ] lwhps2fpga_awready
 ,output wire [31 : 0 ] lwhps2fpga_wdata
 ,output wire [3 : 0 ] lwhps2fpga_wstrb
 ,output wire [0 : 0 ] lwhps2fpga_wlast
 ,output wire [0 : 0 ] lwhps2fpga_wvalid
 ,input wire [0 : 0 ] lwhps2fpga_wready
 ,input wire [3 : 0 ] lwhps2fpga_bid
 ,input wire [1 : 0 ] lwhps2fpga_bresp
 ,input wire [0 : 0 ] lwhps2fpga_bvalid
 ,output wire [0 : 0 ] lwhps2fpga_bready
 ,output wire [3 : 0 ] lwhps2fpga_arid
 ,output wire [23 : 0 ] lwhps2fpga_araddr
 ,output wire [7 : 0 ] lwhps2fpga_arlen
 ,output wire [2 : 0 ] lwhps2fpga_arsize
 ,output wire [1 : 0 ] lwhps2fpga_arburst
 ,output wire [0 : 0 ] lwhps2fpga_arlock
 ,output wire [3 : 0 ] lwhps2fpga_arcache
 ,output wire [2 : 0 ] lwhps2fpga_arprot
 ,output wire [0 : 0 ] lwhps2fpga_arvalid
 ,input wire [0 : 0 ] lwhps2fpga_arready
 ,input wire [3 : 0 ] lwhps2fpga_rid
 ,input wire [31 : 0 ] lwhps2fpga_rdata
 ,input wire [1 : 0 ] lwhps2fpga_rresp
 ,input wire [0 : 0 ] lwhps2fpga_rlast
 ,input wire [0 : 0 ] lwhps2fpga_rvalid
 ,output wire [0 : 0 ] lwhps2fpga_rready
 ,inout wire [0 : 0 ] gpio41
);

// assignments for top ports

wire [ 0:0] hps2fpga_rst_intr;
wire [ 3:0] hps2fpga_awid_intr;
wire [ 27:0] hps2fpga_awaddr_intr;
wire [ 7:0] hps2fpga_awlen_intr;
wire [ 2:0] hps2fpga_awsize_intr;
wire [ 1:0] hps2fpga_awburst_intr;
wire [ 0:0] hps2fpga_awlock_intr;
wire [ 3:0] hps2fpga_awcache_intr;
wire [ 2:0] hps2fpga_awprot_intr;
wire [ 0:0] hps2fpga_awvalid_intr;
wire [ 0:0] hps2fpga_awready_intr;
wire [ 127:0] hps2fpga_wdata_intr;
wire [ 15:0] hps2fpga_wstrb_intr;
wire [ 0:0] hps2fpga_wlast_intr;
wire [ 0:0] hps2fpga_wvalid_intr;
wire [ 0:0] hps2fpga_wready_intr;
wire [ 3:0] hps2fpga_bid_intr;
wire [ 1:0] hps2fpga_bresp_intr;
wire [ 0:0] hps2fpga_bvalid_intr;
wire [ 0:0] hps2fpga_bready_intr;
wire [ 3:0] hps2fpga_arid_intr;
wire [ 27:0] hps2fpga_araddr_intr;
wire [ 7:0] hps2fpga_arlen_intr;
wire [ 2:0] hps2fpga_arsize_intr;
wire [ 1:0] hps2fpga_arburst_intr;
wire [ 0:0] hps2fpga_arlock_intr;
wire [ 3:0] hps2fpga_arcache_intr;
wire [ 2:0] hps2fpga_arprot_intr;
wire [ 0:0] hps2fpga_arvalid_intr;
wire [ 0:0] hps2fpga_arready_intr;
wire [ 3:0] hps2fpga_rid_intr;
wire [ 127:0] hps2fpga_rdata_intr;
wire [ 1:0] hps2fpga_rresp_intr;
wire [ 0:0] hps2fpga_rlast_intr;
wire [ 0:0] hps2fpga_rvalid_intr;
wire [ 0:0] hps2fpga_rready_intr;
wire [ 0:0] lwhps2fpga_rst_intr;
wire [ 3:0] lwhps2fpga_awid_intr;
wire [ 23:0] lwhps2fpga_awaddr_intr;
wire [ 7:0] lwhps2fpga_awlen_intr;
wire [ 2:0] lwhps2fpga_awsize_intr;
wire [ 1:0] lwhps2fpga_awburst_intr;
wire [ 0:0] lwhps2fpga_awlock_intr;
wire [ 3:0] lwhps2fpga_awcache_intr;
wire [ 2:0] lwhps2fpga_awprot_intr;
wire [ 0:0] lwhps2fpga_awvalid_intr;
wire [ 0:0] lwhps2fpga_awready_intr;
wire [ 31:0] lwhps2fpga_wdata_intr;
wire [ 3:0] lwhps2fpga_wstrb_intr;
wire [ 0:0] lwhps2fpga_wlast_intr;
wire [ 0:0] lwhps2fpga_wvalid_intr;
wire [ 0:0] lwhps2fpga_wready_intr;
wire [ 3:0] lwhps2fpga_bid_intr;
wire [ 1:0] lwhps2fpga_bresp_intr;
wire [ 0:0] lwhps2fpga_bvalid_intr;
wire [ 0:0] lwhps2fpga_bready_intr;
wire [ 3:0] lwhps2fpga_arid_intr;
wire [ 23:0] lwhps2fpga_araddr_intr;
wire [ 7:0] lwhps2fpga_arlen_intr;
wire [ 2:0] lwhps2fpga_arsize_intr;
wire [ 1:0] lwhps2fpga_arburst_intr;
wire [ 0:0] lwhps2fpga_arlock_intr;
wire [ 3:0] lwhps2fpga_arcache_intr;
wire [ 2:0] lwhps2fpga_arprot_intr;
wire [ 0:0] lwhps2fpga_arvalid_intr;
wire [ 0:0] lwhps2fpga_arready_intr;
wire [ 3:0] lwhps2fpga_rid_intr;
wire [ 31:0] lwhps2fpga_rdata_intr;
wire [ 1:0] lwhps2fpga_rresp_intr;
wire [ 0:0] lwhps2fpga_rlast_intr;
wire [ 0:0] lwhps2fpga_rvalid_intr;
wire [ 0:0] lwhps2fpga_rready_intr;


wire [0:0] gpio41_ibuf_o;
tennm_ph2_io_ibuf #(
    .buffer_usage("REGULAR"),
    .bus_hold("BUS_HOLD_OFF"),
    .equalization("EQUALIZATION_OFF"),
    .io_standard("IO_STANDARD_IOSTD_OFF"),
    .rzq_id("RZQ_ID_RZQ0"),
    .schmitt_trigger("SCHMITT_TRIGGER_OFF"),
    .termination("TERMINATION_RT_OFF"),
    .toggle_speed("TOGGLE_SPEED_SLOW"),
    .usage_mode("USAGE_MODE_GPIO"),
    .vref("VREF_OFF"),
    .weak_pull_down("WEAK_PULL_DOWN_OFF"),
    .weak_pull_up("WEAK_PULL_UP_OFF")
) hps_gpio41_ibuf(
    .i(gpio41),
    .o(gpio41_ibuf_o)
);

wire [0:0] gpio41_obuf_i;
tennm_ph2_io_obuf #(
    .buffer_usage("REGULAR"),
    .dynamic_pull_up_enabled("false"),
    .equalization("EQUALIZATION_OFF"),
    .io_standard("IO_STANDARD_IOSTD_OFF"),
    .open_drain("OPEN_DRAIN_OFF"),
    .rzq_id("RZQ_ID_RZQ0"),
    .slew_rate("SLEW_RATE_SLOW"),
    .termination("TERMINATION_SERIES_OFF"),
    .toggle_speed("TOGGLE_SPEED_SLOW"),
    .usage_mode("USAGE_MODE_GPIO")
) hps_gpio41_obuf(
    .i(gpio41_obuf_i),
    .o(gpio41),
    .oe(1'b1)
);

ready_latency_reset_synchronizer hps2fpga_axi4_rl_adp_inst_reset_sync(
 .clk(hps2fpga_clk)
,.rst_async(hps2fpga_rst)
,.rst_sync(hps2fpga_rst_intr)
);
ready_latency_reset_synchronizer lwhps2fpga_axi4_rl_adp_inst_reset_sync(
 .clk(lwhps2fpga_clk)
,.rst_async(lwhps2fpga_rst)
,.rst_sync(lwhps2fpga_rst_intr)
);

hps_axi4_ready_latency_adp #(
        .NUM_PIPELINES(2)
        ,.LOG_DEPTH(3)
        ,.ID_WIDTH(4)
        ,.ADDR_WIDTH(24)
        ,.DATA_WIDTH(32)
        ,.STRB_WIDTH(4)
        ,.BUFFER_TYPE("MLAB")
        ) lwhps2fpga_axi4_rl_adp_inst(
 .clk(lwhps2fpga_clk)
,.reset(lwhps2fpga_rst_intr)
,.awid(lwhps2fpga_awid_intr)
,.awid_r(lwhps2fpga_awid)
,.awaddr(lwhps2fpga_awaddr_intr)
,.awaddr_r(lwhps2fpga_awaddr)
,.awlen(lwhps2fpga_awlen_intr)
,.awlen_r(lwhps2fpga_awlen)
,.awsize(lwhps2fpga_awsize_intr)
,.awsize_r(lwhps2fpga_awsize)
,.awburst(lwhps2fpga_awburst_intr)
,.awburst_r(lwhps2fpga_awburst)
,.awlock(lwhps2fpga_awlock_intr)
,.awlock_r(lwhps2fpga_awlock)
,.awcache(lwhps2fpga_awcache_intr)
,.awcache_r(lwhps2fpga_awcache)
,.awprot(lwhps2fpga_awprot_intr)
,.awprot_r(lwhps2fpga_awprot)
,.awvalid(lwhps2fpga_awvalid_intr)
,.awvalid_r(lwhps2fpga_awvalid)
,.awready(lwhps2fpga_awready)
,.awready_r(lwhps2fpga_awready_intr)
,.wdata(lwhps2fpga_wdata_intr)
,.wdata_r(lwhps2fpga_wdata)
,.wstrb(lwhps2fpga_wstrb_intr)
,.wstrb_r(lwhps2fpga_wstrb)
,.wlast(lwhps2fpga_wlast_intr)
,.wlast_r(lwhps2fpga_wlast)
,.wvalid(lwhps2fpga_wvalid_intr)
,.wvalid_r(lwhps2fpga_wvalid)
,.wready(lwhps2fpga_wready)
,.wready_r(lwhps2fpga_wready_intr)
,.bid(lwhps2fpga_bid)
,.bid_r(lwhps2fpga_bid_intr)
,.bresp(lwhps2fpga_bresp)
,.bresp_r(lwhps2fpga_bresp_intr)
,.bvalid(lwhps2fpga_bvalid)
,.bvalid_r(lwhps2fpga_bvalid_intr)
,.bready(lwhps2fpga_bready_intr)
,.bready_r(lwhps2fpga_bready)
,.arid(lwhps2fpga_arid_intr)
,.arid_r(lwhps2fpga_arid)
,.araddr(lwhps2fpga_araddr_intr)
,.araddr_r(lwhps2fpga_araddr)
,.arlen(lwhps2fpga_arlen_intr)
,.arlen_r(lwhps2fpga_arlen)
,.arsize(lwhps2fpga_arsize_intr)
,.arsize_r(lwhps2fpga_arsize)
,.arburst(lwhps2fpga_arburst_intr)
,.arburst_r(lwhps2fpga_arburst)
,.arlock(lwhps2fpga_arlock_intr)
,.arlock_r(lwhps2fpga_arlock)
,.arcache(lwhps2fpga_arcache_intr)
,.arcache_r(lwhps2fpga_arcache)
,.arprot(lwhps2fpga_arprot_intr)
,.arprot_r(lwhps2fpga_arprot)
,.arvalid(lwhps2fpga_arvalid_intr)
,.arvalid_r(lwhps2fpga_arvalid)
,.arready(lwhps2fpga_arready)
,.arready_r(lwhps2fpga_arready_intr)
,.rid(lwhps2fpga_rid)
,.rid_r(lwhps2fpga_rid_intr)
,.rdata(lwhps2fpga_rdata)
,.rdata_r(lwhps2fpga_rdata_intr)
,.rresp(lwhps2fpga_rresp)
,.rresp_r(lwhps2fpga_rresp_intr)
,.rlast(lwhps2fpga_rlast)
,.rlast_r(lwhps2fpga_rlast_intr)
,.rvalid(lwhps2fpga_rvalid)
,.rvalid_r(lwhps2fpga_rvalid_intr)
,.rready(lwhps2fpga_rready_intr)
,.rready_r(lwhps2fpga_rready)
);
hps_axi4_ready_latency_adp #(
        .NUM_PIPELINES(2)
        ,.LOG_DEPTH(3)
        ,.ID_WIDTH(4)
        ,.ADDR_WIDTH(28)
        ,.DATA_WIDTH(128)
        ,.STRB_WIDTH(16)
        ,.BUFFER_TYPE("MLAB")
        ) hps2fpga_axi4_rl_adp_inst(
 .clk(hps2fpga_clk)
,.reset(hps2fpga_rst_intr)
,.awid(hps2fpga_awid_intr)
,.awid_r(hps2fpga_awid)
,.awaddr(hps2fpga_awaddr_intr)
,.awaddr_r(hps2fpga_awaddr)
,.awlen(hps2fpga_awlen_intr)
,.awlen_r(hps2fpga_awlen)
,.awsize(hps2fpga_awsize_intr)
,.awsize_r(hps2fpga_awsize)
,.awburst(hps2fpga_awburst_intr)
,.awburst_r(hps2fpga_awburst)
,.awlock(hps2fpga_awlock_intr)
,.awlock_r(hps2fpga_awlock)
,.awcache(hps2fpga_awcache_intr)
,.awcache_r(hps2fpga_awcache)
,.awprot(hps2fpga_awprot_intr)
,.awprot_r(hps2fpga_awprot)
,.awvalid(hps2fpga_awvalid_intr)
,.awvalid_r(hps2fpga_awvalid)
,.awready(hps2fpga_awready)
,.awready_r(hps2fpga_awready_intr)
,.wdata(hps2fpga_wdata_intr)
,.wdata_r(hps2fpga_wdata)
,.wstrb(hps2fpga_wstrb_intr)
,.wstrb_r(hps2fpga_wstrb)
,.wlast(hps2fpga_wlast_intr)
,.wlast_r(hps2fpga_wlast)
,.wvalid(hps2fpga_wvalid_intr)
,.wvalid_r(hps2fpga_wvalid)
,.wready(hps2fpga_wready)
,.wready_r(hps2fpga_wready_intr)
,.bid(hps2fpga_bid)
,.bid_r(hps2fpga_bid_intr)
,.bresp(hps2fpga_bresp)
,.bresp_r(hps2fpga_bresp_intr)
,.bvalid(hps2fpga_bvalid)
,.bvalid_r(hps2fpga_bvalid_intr)
,.bready(hps2fpga_bready_intr)
,.bready_r(hps2fpga_bready)
,.arid(hps2fpga_arid_intr)
,.arid_r(hps2fpga_arid)
,.araddr(hps2fpga_araddr_intr)
,.araddr_r(hps2fpga_araddr)
,.arlen(hps2fpga_arlen_intr)
,.arlen_r(hps2fpga_arlen)
,.arsize(hps2fpga_arsize_intr)
,.arsize_r(hps2fpga_arsize)
,.arburst(hps2fpga_arburst_intr)
,.arburst_r(hps2fpga_arburst)
,.arlock(hps2fpga_arlock_intr)
,.arlock_r(hps2fpga_arlock)
,.arcache(hps2fpga_arcache_intr)
,.arcache_r(hps2fpga_arcache)
,.arprot(hps2fpga_arprot_intr)
,.arprot_r(hps2fpga_arprot)
,.arvalid(hps2fpga_arvalid_intr)
,.arvalid_r(hps2fpga_arvalid)
,.arready(hps2fpga_arready)
,.arready_r(hps2fpga_arready_intr)
,.rid(hps2fpga_rid)
,.rid_r(hps2fpga_rid_intr)
,.rdata(hps2fpga_rdata)
,.rdata_r(hps2fpga_rdata_intr)
,.rresp(hps2fpga_rresp)
,.rresp_r(hps2fpga_rresp_intr)
,.rlast(hps2fpga_rlast)
,.rlast_r(hps2fpga_rlast_intr)
,.rvalid(hps2fpga_rvalid)
,.rvalid_r(hps2fpga_rvalid_intr)
,.rready(hps2fpga_rready_intr)
,.rready_r(hps2fpga_rready)
);

wire[63:0] unused_bits;
(* preserve *)(* altera_attribute = "-name PRESERVE_FANOUT_FREE_WYSIWYG ON" *) 
tennm_soc_hps #(
.soc_hps_wrapper_powerdown_mode("FALSE")
,.soc_hps_wrapper_hps_a55_core_state("HPS_A55_CORE_STATE_BOTH_ON")
,.soc_hps_wrapper_hps_a76_core_selection("HPS_A76_CORE_SELECTION_DUAL")
,.soc_hps_wrapper_hps_l3_memory_size("HPS_L3_MEMORY_SIZE_1_MB")
,.soc_hps_wrapper_powermode_freq_hz(32'b00110111101000010111110001010000)
,.soc_hps_wrapper_h2f_addr_width(32'b00000000000000000000000000011100)
,.soc_hps_wrapper_h2f_data_width(32'b00000000000000000000000010000000)
,.soc_hps_wrapper_lwh2f_addr_width(32'b00000000000000000000000000011000)
,.soc_hps_wrapper_lwh2f_data_width(32'b00000000000000000000000000100000)
 ) sundancemesa_hps_inst (
  .spim0_miso_i({
     1'h0
  })
 ,.fpga_eventireq({
     1'h0
  })
 ,.lwsoc2fpga_ar_valid({
     lwhps2fpga_arvalid_intr
  })
 ,.emac0_ptp_aux_ts_trig_i({
     1'h0
  })
 ,.lwsoc2fpga_b_resp({
     lwhps2fpga_bresp_intr
  })
 ,.tpiu_trace_ctl({
     1'h0
  })
 ,.uart1_dsr_n({
     1'h0
  })
 ,.lwsoc2fpga_aw_ready({
     lwhps2fpga_awready_intr
  })
 ,.s2f_rst({
     h2f_reset[0:0]
  })
 ,.emac0_phy_rxd_i({
     8'h0
  })
 ,.cs_dbg_fpga_apb_prdata({
     32'h0
  })
 ,.uart1_dcd_n({
     1'h0
  })
 ,.dft_in_core_loopback_en_n({
     1'h1
  })
 ,.emac1_gmii_mdi_i({
     1'h0
  })
 ,.lwsoc2fpga_b_id({
     lwhps2fpga_bid_intr
  })
 ,.fpga2soc_emac_timestamp_data({
     64'h0
  })
 ,.fpga2soc_emac_timestamp_clk({
     1'h0
  })
 ,.emac0_phy_rxer_i({
     1'h0
  })
 ,.fpga7_dma_single({
     1'h0
  })
 ,.fpga_atb_atbytes({
     2'h0
  })
 ,.soc2fpga_port_size_config_0({
     1'h0
  })
 ,.soc2fpga_aw_cache({
     hps2fpga_awcache_intr
  })
 ,.soc2fpga_port_size_config_1({
     1'h1
  })
 ,.lwsoc2fpga_w_last({
     lwhps2fpga_wlast_intr
  })
 ,.i2c_emac0_sda_i({
     1'h0
  })
 ,.fpga_atb_atdata({
     32'h0
  })
 ,.fpga2_dma_single({
     1'h0
  })
 ,.emac1_phy_rxdv_i({
     1'h0
  })
 ,.soc2fpga_b_id({
     hps2fpga_bid_intr
  })
 ,.uart1_cts_n({
     1'h0
  })
 ,.soc2fpga_aw_burst({
     hps2fpga_awburst_intr
  })
 ,.lwsoc2fpga_aw_id({
     lwhps2fpga_awid_intr
  })
 ,.cs_tck_fpga({
     1'h0
  })
 ,.uart1_ri_n({
     1'h0
  })
 ,.emac1_phy_col_i({
     1'h0
  })
 ,.hps_iob_18_bidir_out({
     gpio41_obuf_i
  })
 ,.soc2fpga_w_data({
     hps2fpga_wdata_intr
  })
 ,.uart0_rx({
     1'h0
  })
 ,.cs_dbg_fpga_apb_pclken({
     1'h0
  })
 ,.lwsoc2fpga_aw_len({
     lwhps2fpga_awlen_intr
  })
 ,.cs_hwevents_fpga({
     44'h0
  })
 ,.i2c_emac2_scl_i({
     1'h0
  })
 ,.i2c1_sda_i({
     1'h0
  })
 ,.emac1_phy_crs_i({
     1'h0
  })
 ,.lwsoc2fpga_ar_ready({
     lwhps2fpga_arready_intr
  })
 ,.lwsoc2fpga_ar_id({
     lwhps2fpga_arid_intr
  })
 ,.fpga_atb_atvalid({
     1'h0
  })
 ,.soc2fpga_r_last({
     hps2fpga_rlast_intr
  })
 ,.uart0_dsr_n({
     1'h0
  })
 ,.soc2fpga_ar_cache({
     hps2fpga_arcache_intr
  })
 ,.lwsoc2fpga_r_resp({
     lwhps2fpga_rresp_intr
  })
 ,.lwsoc2fpga_port_size_config_0({
     1'h1
  })
 ,.emac1_ptp_aux_ts_trig_i({
     1'h0
  })
 ,.uart0_dcd_n({
     1'h0
  })
 ,.emac1_phy_rxd_i({
     8'h0
  })
 ,.lwsoc2fpga_r_id({
     lwhps2fpga_rid_intr
  })
 ,.fpga5_dma_single({
     1'h0
  })
 ,.soc2fpga_ar_burst({
     hps2fpga_arburst_intr
  })
 ,.i3c_s_sda_in_a({
     1'h0
  })
 ,.soc2fpga_ar_lock({
     hps2fpga_arlock_intr
  })
 ,.soc2fpga_b_resp({
     hps2fpga_bresp_intr
  })
 ,.fpga0_dma_single({
     1'h0
  })
 ,.soc2fpga_ar_addr({
     hps2fpga_araddr_intr
  })
 ,.fpga_atb_atresetn({
     1'h0
  })
 ,.soc2fpga_r_id({
     hps2fpga_rid_intr
  })
 ,.lwsoc2fpga_ar_lock({
     lwhps2fpga_arlock_intr
  })
 ,.emac1_phy_rxclk_i({
     1'h0
  })
 ,.uart0_cts_n({
     1'h0
  })
 ,.soc2fpga_aw_valid({
     hps2fpga_awvalid_intr
  })
 ,.hps_iob_18_bidir_in({
     gpio41_ibuf_o
  })
 ,.emac0_phy_txclk_i({
     1'h0
  })
 ,.lwsoc2fpga_ar_addr({
     lwhps2fpga_araddr_intr
  })
 ,.soc2fpga_b_valid({
     hps2fpga_bvalid_intr
  })
 ,.emac2_phy_col_i({
     1'h0
  })
 ,.emac2_phy_txclk_i({
     1'h0
  })
 ,.i2c0_sda_i({
     1'h0
  })
 ,.i2c_emac1_scl_i({
     1'h0
  })
 ,.fpga_eventoack({
     1'h0
  })
 ,.soc2fpga_w_last({
     hps2fpga_wlast_intr
  })
 ,.emac2_gmii_mdi_i({
     1'h0
  })
 ,.fpga0_dma_req({
     1'h0
  })
 ,.emac1_phy_rxer_i({
     1'h0
  })
 ,.emac2_phy_crs_i({
     1'h0
  })
 ,.fpga1_dma_req({
     1'h0
  })
 ,.fpga_atb_afready({
     1'h0
  })
 ,.spis0_ss_in_n({
     1'h0
  })
 ,.spis1_mosi_i({
     1'h0
  })
 ,.lwsoc2fpga_w_strb({
     lwhps2fpga_wstrb_intr
  })
 ,.lwsoc2fpga_b_valid({
     lwhps2fpga_bvalid_intr
  })
 ,.fpga2_dma_req({
     1'h0
  })
 ,.i3c_m_sda_in_a({
     1'h0
  })
 ,.spis1_ss_in_n({
     1'h0
  })
 ,.lwsoc2fpga_clk({
     lwhps2fpga_clk
  })
 ,.f2s_gp({
     32'h0
  })
 ,.fpga3_dma_req({
     1'h0
  })
 ,.lwsoc2fpga_aw_cache({
     lwhps2fpga_awcache_intr
  })
 ,.soc2fpga_w_valid({
     hps2fpga_wvalid_intr
  })
 ,.soc2fpga_aw_len({
     hps2fpga_awlen_intr
  })
 ,.fpga4_dma_req({
     1'h0
  })
 ,.soc2fpga_ar_prot({
     hps2fpga_arprot_intr
  })
 ,.emac2_phy_rxdv_i({
     1'h0
  })
 ,.uart0_ri_n({
     1'h0
  })
 ,.emac2_ptp_aux_ts_trig_i({
     1'h0
  })
 ,.fpga3_dma_single({
     1'h0
  })
 ,.fpga5_dma_req({
     1'h0
  })
 ,.soc2fpga_aw_lock({
     hps2fpga_awlock_intr
  })
 ,.fpga6_dma_req({
     1'h0
  })
 ,.lwsoc2fpga_w_valid({
     lwhps2fpga_wvalid_intr
  })
 ,.cs_dbg_fpga_apb_pready({
     1'h0
  })
 ,.emac2_phy_rxd_i({
     8'h0
  })
 ,.f2s_pending_rst_ack({
     1'h0
  })
 ,.fpga7_dma_req({
     1'h0
  })
 ,.lwsoc2fpga_aw_burst({
     lwhps2fpga_awburst_intr
  })
 ,.soc2fpga_ar_valid({
     hps2fpga_arvalid_intr
  })
 ,.soc2fpga_aw_addr({
     hps2fpga_awaddr_intr
  })
 ,.lwsoc2fpga_ar_prot({
     lwhps2fpga_arprot_intr
  })
 ,.spis0_mosi_i({
     1'h0
  })
 ,.uart1_rx({
     1'h0
  })
 ,.lwsoc2fpga_aw_lock({
     lwhps2fpga_awlock_intr
  })
 ,.soc2fpga_r_resp({
     hps2fpga_rresp_intr
  })
 ,.soc2fpga_aw_ready({
     hps2fpga_awready_intr
  })
 ,.lwsoc2fpga_ar_len({
     lwhps2fpga_arlen_intr
  })
 ,.i3c_s_scl_in_a({
     1'h0
  })
 ,.lwsoc2fpga_aw_addr({
     lwhps2fpga_awaddr_intr
  })
 ,.soc2fpga_ar_size({
     hps2fpga_arsize_intr
  })
 ,.spim0_ss_in_n({
     1'h0
  })
 ,.soc2fpga_b_ready({
     hps2fpga_bready_intr
  })
 ,.lwsoc2fpga_r_data({
     lwhps2fpga_rdata_intr
  })
 ,.fpga_atb_atclk({
     1'h0
  })
 ,.spim1_ss_in_n({
     1'h0
  })
 ,.fpga_ctitrigin({
     8'h0
  })
 ,.cs_tdi_fpga({
     1'h0
  })
 ,.lwsoc2fpga_ar_size({
     lwhps2fpga_arsize_intr
  })
 ,.emac0_gmii_mdi_i({
     1'h0
  })
 ,.i2c_emac0_scl_i({
     1'h0
  })
 ,.i2c_emac2_sda_i({
     1'h0
  })
 ,.dbgapbdisable({
     1'h0
  })
 ,.soc2fpga_r_valid({
     hps2fpga_rvalid_intr
  })
 ,.lwsoc2fpga_b_ready({
     lwhps2fpga_bready_intr
  })
 ,.lwsoc2fpga_ar_cache({
     lwhps2fpga_arcache_intr
  })
 ,.cs_dbg_fpga_apb_pslverr({
     1'h0
  })
 ,.fpga6_dma_single({
     1'h0
  })
 ,.soc2fpga_w_ready({
     hps2fpga_wready_intr
  })
 ,.soc2fpga_aw_prot({
     hps2fpga_awprot_intr
  })
 ,.lwsoc2fpga_r_valid({
     lwhps2fpga_rvalid_intr
  })
 ,.i2c1_scl_i({
     1'h0
  })
 ,.lwsoc2fpga_ar_burst({
     lwhps2fpga_arburst_intr
  })
 ,.emac0_phy_rxdv_i({
     1'h0
  })
 ,.fpga1_dma_single({
     1'h0
  })
 ,.lwsoc2fpga_w_ready({
     lwhps2fpga_wready_intr
  })
 ,.cs_dbg_fpga_apb_pclk({
     1'h0
  })
 ,.i3c_m_scl_in_a({
     1'h0
  })
 ,.fpga_ctitrigoutack({
     8'h0
  })
 ,.lwsoc2fpga_aw_prot({
     lwhps2fpga_awprot_intr
  })
 ,.soc2fpga_ar_ready({
     hps2fpga_arready_intr
  })
 ,.soc2fpga_w_strb({
     hps2fpga_wstrb_intr
  })
 ,.fpga_atb_atid({
     7'h0
  })
 ,.lwsoc2fpga_aw_valid({
     lwhps2fpga_awvalid_intr
  })
 ,.soc2fpga_aw_size({
     hps2fpga_awsize_intr
  })
 ,.lwsoc2fpga_w_data({
     lwhps2fpga_wdata_intr
  })
 ,.soc2fpga_aw_id({
     hps2fpga_awid_intr
  })
 ,.emac2_phy_rxer_i({
     1'h0
  })
 ,.lwsoc2fpga_aw_size({
     lwhps2fpga_awsize_intr
  })
 ,.emac0_phy_rxclk_i({
     1'h0
  })
 ,.spim1_miso_i({
     1'h0
  })
 ,.soc2fpga_r_ready({
     hps2fpga_rready_intr
  })
 ,.soc2fpga_ar_id({
     hps2fpga_arid_intr
  })
 ,.emac0_phy_col_i({
     1'h0
  })
 ,.emac2_phy_rxclk_i({
     1'h0
  })
 ,.i2c_emac1_sda_i({
     1'h0
  })
 ,.lwsoc2fpga_r_last({
     lwhps2fpga_rlast_intr
  })
 ,.emac1_phy_txclk_i({
     1'h0
  })
 ,.fpga4_dma_single({
     1'h0
  })
 ,.soc2fpga_ar_len({
     hps2fpga_arlen_intr
  })
 ,.lwsoc2fpga_r_ready({
     lwhps2fpga_rready_intr
  })
 ,.emac0_phy_crs_i({
     1'h0
  })
 ,.cs_ntrst_fpga({
     1'h0
  })
 ,.f2s_free_clk({
     1'h0
  })
 ,.soc2fpga_clk({
     hps2fpga_clk
  })
 ,.cs_tms_fpga({
     1'h0
  })
 ,.emac_ptp_ref_clk({
     1'h0
  })
 ,.soc2fpga_r_data({
     hps2fpga_rdata_intr
  })
 ,.i2c0_scl_i({
     1'h0
  })
);

endmodule


