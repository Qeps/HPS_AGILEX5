// ============================================================================
// Copyright (c) 2025 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development
//   Kits made by Terasic.  Other use of this code, including the selling
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use
//   or functionality of this code.
//
// ============================================================================
//
//  Terasic Technologies Inc
//  No.80, Fenggong Rd., Hukou Township, Hsinchu County 303035. Taiwan
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//Date:  Tue May  6 11:16:28 2025
// ============================================================================

`define ENABLE_LPDDR4A
`define ENABLE_LPDDR4B
`define ENABLE_HPS
//`define ENABLE_CAM

module golden_top(

      ///////// CLOCK /////////
      input              CLOCK0_50,
      input              CLOCK1_50,
      input              CLOCK2_50,

      ///////// KEY /////////
      input    [ 1: 0]   KEY, //BUTTON is Low-Active

      ///////// SW /////////
      input    [ 3: 0]   SW,

      ///////// LED /////////
      output   [ 7: 0]   LED,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output   [ 1: 0]   DRAM_CS_n,
      output             DRAM_WE_n,
      output             DRAM_CAS_n,
      output             DRAM_RAS_n,

`ifdef ENABLE_LPDDR4A
      ///////// LPDDR4A /////////
      input              LPDDR4A_REFCLK_p,
      output             LPDDR4A_CS_n,
      output   [ 5: 0]   LPDDR4A_CA,
      output             LPDDR4A_CK,
      output             LPDDR4A_CKE,
      output             LPDDR4A_CK_n,
      inout    [ 3: 0]   LPDDR4A_DM,
      inout    [31: 0]   LPDDR4A_DQ,
      inout    [ 3: 0]   LPDDR4A_DQS,
      inout    [ 3: 0]   LPDDR4A_DQS_n,
      output             LPDDR4A_RESET_n,
      input              LPDDR4A_RZQ,
`endif /*ENABLE_LPDDR4A*/

`ifdef ENABLE_LPDDR4B
      ///////// LPDDR4B /////////
      input              LPDDR4B_REFCLK_p,
      output             LPDDR4B_CS_n,
      output   [ 5: 0]   LPDDR4B_CA,
      output             LPDDR4B_CK,
      output             LPDDR4B_CKE,
      output             LPDDR4B_CK_n,
      inout    [ 3: 0]   LPDDR4B_DM,
      inout    [31: 0]   LPDDR4B_DQ,
      inout    [ 3: 0]   LPDDR4B_DQS,
      inout    [ 3: 0]   LPDDR4B_DQS_n,
      output             LPDDR4B_RESET_n,
      input              LPDDR4B_RZQ,
`endif /*ENABLE_LPDDR4B*/

      ///////// HDMI /////////
      inout              HDMI_LRCLK,
      inout              HDMI_MCLK,
      inout              HDMI_SCLK,
      output             HDMI_TX_CLK,
      output             HDMI_TX_HS,
      output             HDMI_TX_VS,
      output   [23: 0]   HDMI_TX_D,
      output             HDMI_TX_DE,
      inout              HDMI_I2C_SCL,
      inout              HDMI_I2C_SDA,
      input              HDMI_TX_INT,
      inout              HDMI_I2S,

`ifdef ENABLE_CAM
      ///////// CAM /////////
      input              CAM_CLK_p,
      input              CAM_CLK_n,
      input    [ 1: 0]   CAM_D_p,
      input    [ 1: 0]   CAM_D_n,
      inout              CAM_I2C_SCL,
      inout              CAM_I2C_SDA,
      inout              CAM_GPIO,
      input              CAM_RZQ1,
`endif /*ENABLE_CAM*/

      ///////// FPGA UART /////////
      output             FPGA_UART_TX,
      input              FPGA_UART_RX,

      ///////// ADC /////////
      output             ADC_SCK,
      input              ADC_SDO,
      output             ADC_SDI,
      output             ADC_CS_n,

      ///////// GPIO /////////
      inout    [35: 0]   GPIO0_D,
      inout    [35: 0]   GPIO1_D,

`ifdef ENABLE_HPS
      ///////// HPS /////////
      input              HPS_CLK_25,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input              HPS_ENET_RX_CTL,
      input    [ 3: 0]   HPS_ENET_RX_DATA,
      output             HPS_ENET_TX_CLK,
      output             HPS_ENET_TX_CTL,
      output   [ 3: 0]   HPS_ENET_TX_DATA,
      inout              HPS_GSENSOR_I2C_EN,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C_SCL,
      inout              HPS_I2C_SDA,
      inout              HPS_KEY,
      inout              HPS_LED,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout    [ 3: 0]   HPS_SD_DATA,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLK,
      inout    [ 7: 0]   HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/

      ///////// FAN /////////
      input              FAN_ALERT_n

);


//=======================================================
//  REG/WIRE declarations
//=======================================================
wire                   system_clk_50;
wire                   system_clk_100_internal;
wire                   ninit_done;
wire                   system_reset_n;
wire [10-3:0]          fpga_led_pio;
wire [10-7:0]          fpga_dipsw_pio;
wire [10-9:0]          fpga_button_pio;
wire [10-9:0]          fpga_debounced_buttons;
wire [10-4:0]          fpga_led_internal;
wire                   heartbeat_led;
reg  [24:0]            heartbeat_count;

//=======================================================
//  Structural coding
//=======================================================
assign                 system_reset_n = ~ninit_done;
assign                 system_clk_50  = CLOCK2_50;

//assign                 LED = fpga_led_pio;
assign                 LED = 8'hFF;
assign                 fpga_dipsw_pio = SW;
assign                 fpga_button_pio = KEY;
assign                 heartbeat_led = ~heartbeat_count[24];
assign                 fpga_led_pio = {heartbeat_led,fpga_led_internal};

pll pll_inst (
.refclk   (system_clk_50),
.locked   (),
.rst      (ninit_done),
.outclk_0 (system_clk_100_internal)
);

qsys_top soc_inst (
.clk_100_clk                               (system_clk_100_internal),
.reset_reset_n                             (system_reset_n),
.ninit_done_ninit_done                     (ninit_done),
.led_pio_external_connection_in_port       (fpga_led_internal),
.led_pio_external_connection_out_port      (fpga_led_internal),
.dipsw_pio_external_connection_export      (fpga_dipsw_pio),
.button_pio_external_connection_export     (fpga_debounced_buttons),

.hps_io_hps_osc_clk                        (HPS_CLK_25),
.emif_hps_emif_mem_0_mem_cs            	 (LPDDR4A_CS_n),            
.emif_hps_emif_mem_0_mem_ca            	 (LPDDR4A_CA),            
.emif_hps_emif_mem_0_mem_cke           	 (LPDDR4A_CKE),           
.emif_hps_emif_mem_0_mem_dq             	 (LPDDR4A_DQ),            
.emif_hps_emif_mem_0_mem_dqs_t         	 (LPDDR4A_DQS),         
.emif_hps_emif_mem_0_mem_dqs_c         	 (LPDDR4A_DQS_n),         
.emif_hps_emif_mem_0_mem_dmi           	 (LPDDR4A_DM),          
.emif_hps_emif_mem_ck_0_mem_ck_t       	 (LPDDR4A_CK),      
.emif_hps_emif_mem_ck_0_mem_ck_c       	 (LPDDR4A_CK_n),                            
.emif_hps_emif_mem_reset_n_mem_reset_n 	 (LPDDR4A_RESET_n),
.emif_hps_emif_oct_0_oct_rzqin         	 (LPDDR4A_RZQ),   
.emif_hps_emif_ref_clk_0_clk           	 (LPDDR4A_REFCLK_p), 
.hps_io_emac0_tx_clk                       (HPS_ENET_TX_CLK),
.hps_io_emac0_rx_clk                       (HPS_ENET_RX_CLK),
.hps_io_emac0_tx_ctl                       (HPS_ENET_TX_CTL),
.hps_io_emac0_rx_ctl                       (HPS_ENET_RX_CTL),
.hps_io_emac0_txd0                         (HPS_ENET_TX_DATA[0]),
.hps_io_emac0_txd1                         (HPS_ENET_TX_DATA[1]),
.hps_io_emac0_rxd0                         (HPS_ENET_RX_DATA[0]),
.hps_io_emac0_rxd1                         (HPS_ENET_RX_DATA[1]),
.hps_io_emac0_txd2                         (HPS_ENET_TX_DATA[2]),
.hps_io_emac0_txd3                         (HPS_ENET_TX_DATA[3]),
.hps_io_emac0_rxd2                         (HPS_ENET_RX_DATA[2]),
.hps_io_emac0_rxd3                         (HPS_ENET_RX_DATA[3]),
.hps_io_mdio0_mdio                         (HPS_ENET_MDIO),
.hps_io_mdio0_mdc                          (HPS_ENET_MDC),
.hps_io_sdmmc_cclk                         (HPS_SD_CLK),
.hps_io_sdmmc_cmd                          (HPS_SD_CMD),
.hps_io_sdmmc_data0                        (HPS_SD_DATA[0]),
.hps_io_sdmmc_data1                        (HPS_SD_DATA[1]),
.hps_io_sdmmc_data2                        (HPS_SD_DATA[2]),
.hps_io_sdmmc_data3                        (HPS_SD_DATA[3]),
.hps_io_uart1_rx                           (HPS_UART_RX),
.hps_io_uart1_tx                           (HPS_UART_TX),
.hps_io_usb0_clk                           (HPS_USB_CLK),
.hps_io_usb0_stp                           (HPS_USB_STP),
.hps_io_usb0_dir                           (HPS_USB_DIR),
// Todo clarify for NXT or NXR
.hps_io_usb0_nxt                           (HPS_USB_NXT),
.hps_io_usb0_data0                         (HPS_USB_DATA[0]),
.hps_io_usb0_data1                         (HPS_USB_DATA[1]),
.hps_io_usb0_data2                         (HPS_USB_DATA[2]),
.hps_io_usb0_data3                         (HPS_USB_DATA[3]),
.hps_io_usb0_data4                         (HPS_USB_DATA[4]),
.hps_io_usb0_data5                         (HPS_USB_DATA[5]),
.hps_io_usb0_data6                         (HPS_USB_DATA[6]),
.hps_io_usb0_data7                         (HPS_USB_DATA[7]),
.hps_io_i2c1_sda                           (HPS_I2C_SDA),
.hps_io_i2c1_scl                           (HPS_I2C_SCL),
.hps_io_gpio28                             (HPS_GSENSOR_INT),
.hps_io_gpio34                             (HPS_GSENSOR_I2C_EN),
//.hps_io_gpio33                           (HPS_GSENSOR_INT2),
.hps_io_gpio40                             (HPS_KEY),
.hps_io_gpio41                             (HPS_LED),
.emif_io96b_lpddr4_0_s0_axi4_ctrl_ready_reset_n (),
.emif_io96b_lpddr4_0_mem_0_mem_cs               (LPDDR4B_CS_n),
.emif_io96b_lpddr4_0_mem_0_mem_ca               (LPDDR4B_CA),
.emif_io96b_lpddr4_0_mem_0_mem_cke              (LPDDR4B_CKE),
.emif_io96b_lpddr4_0_mem_0_mem_dq               (LPDDR4B_DQ),
.emif_io96b_lpddr4_0_mem_0_mem_dqs_t            (LPDDR4B_DQS),
.emif_io96b_lpddr4_0_mem_0_mem_dqs_c            (LPDDR4B_DQS_n),
.emif_io96b_lpddr4_0_mem_0_mem_dmi              (LPDDR4B_DM),
.emif_io96b_lpddr4_0_mem_ck_0_mem_ck_t          (LPDDR4B_CK),
.emif_io96b_lpddr4_0_mem_ck_0_mem_ck_c          (LPDDR4B_CK_n),
.emif_io96b_lpddr4_0_mem_reset_n_mem_reset_n    (LPDDR4B_RESET_n),
.emif_io96b_lpddr4_0_oct_0_oct_rzqin            (LPDDR4B_RZQ),
.emif_io96b_lpddr4_0_ref_clk_clk                (LPDDR4B_REFCLK_p)
);


// Debounce logic to clean out glitches within 1ms
debounce debounce_inst (
.clk                                       (system_clk_100_internal),
.reset_n                                   (system_reset_n),
.data_in                                   (fpga_button_pio),
.data_out                                  (fpga_debounced_buttons)
);
defparam debounce_inst.WIDTH = 2;
defparam debounce_inst.POLARITY = "LOW";
defparam debounce_inst.TIMEOUT = 10000;               // at 100Mhz this is a debounce time of 1ms
defparam debounce_inst.TIMEOUT_WIDTH = 32;            // ceil(log2(TIMEOUT))

always @(posedge system_clk_100_internal or negedge system_reset_n) begin
  if (~system_reset_n)
    heartbeat_count <= 25'd0;
  else
    heartbeat_count <= heartbeat_count + 25'd1;
end

endmodule
