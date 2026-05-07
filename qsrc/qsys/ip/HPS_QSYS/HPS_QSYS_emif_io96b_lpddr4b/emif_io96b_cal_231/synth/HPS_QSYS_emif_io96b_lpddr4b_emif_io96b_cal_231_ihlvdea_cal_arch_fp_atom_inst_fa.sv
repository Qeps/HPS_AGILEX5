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



module stdfn_inst_fa_c2p_ssm #(
   parameter IS_USED  = 0,

   parameter SSM_C2P_DATA_MODE                               = "SSM_C2P_DATA_MODE_BYPASS",
   parameter FA_CORE_PERIPH_CLK_SEL_DATA_MODE                = "FA_CORE_PERIPH_CLK_SEL_DATA_MODE_UNUSED",
   parameter SSM_P2C_DATA_MODE                               = "SSM_P2C_DATA_MODE_BYPASS",
   localparam PORT_I_SSM_C2P_WIDTH                            = 40,
   localparam PORT_O_SSM_C2P_WIDTH                            = 40,
   localparam PORT_I_SSM_P2C_WIDTH                            = 20,
   localparam PORT_O_SSM_P2C_WIDTH                            = 20
) (
   input                                                      i_core_clk,
   input [PORT_I_SSM_C2P_WIDTH-1:0]                           i_ssm_c2p,
   output [PORT_O_SSM_C2P_WIDTH-1:0]                           o_ssm_c2p,
   input                                                      i_phy_clk_fr,
   input                                                      i_phy_clk_sync,
   input [PORT_I_SSM_P2C_WIDTH-1:0]                           i_ssm_p2c,
   output [PORT_O_SSM_P2C_WIDTH-1:0]                           o_ssm_p2c
);
   timeunit 1ns;
   timeprecision 1ps;

   tennm_ssm_c2p_fabric_adaptor # (
      .ssm_c2p_data_mode                                    (SSM_C2P_DATA_MODE),
      .fa_core_periph_clk_sel_data_mode                     (FA_CORE_PERIPH_CLK_SEL_DATA_MODE)
   ) fa_c2p_ssm (
      .i_core_clk                                           (i_core_clk),
      .i_phy_clk_fr                                         (i_phy_clk_fr),
      .i_phy_clk_sync                                       (i_phy_clk_sync),
      .i_ssm_c2p                                            (i_ssm_c2p),
      .o_ssm_c2p                                            (o_ssm_c2p)
   );
   tennm_ssm_p2c_fabric_adaptor # (
      .ssm_p2c_data_mode                                    (SSM_P2C_DATA_MODE),
      .fa_core_periph_clk_sel_data_mode                     (FA_CORE_PERIPH_CLK_SEL_DATA_MODE)
   ) fa_p2c_ssm (
      .i_core_clk                                           (i_core_clk),
      .i_phy_clk_fr                                         (i_phy_clk_fr),
      .i_phy_clk_sync                                       (i_phy_clk_sync),
      .i_ssm_p2c                                            (i_ssm_p2c),
      .o_ssm_p2c                                            (o_ssm_p2c)
   );

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "5MN9NQpD8+ZMUV5wpw/bilW4GWzAOs0M5sASEYt/MxN60NCMuvuNfw26pacSaTGGnfeAz98cjM4l4EhKomuxbYTyFdZfGSyWeIjuB6MM2ss+EZeHd4vLiCAzCA8UwQH30nNYSydFV+wySbM7XWFhtue4QweC/7683Yox4pvBHDW4Jtzux1cnT0+Yy47yYzsCcCwj1JxmbdDjpyJgpm8vHIdDecHGwN6jQ62PI4L4O1ZumQORB6uVnrlrhG1q5mOoMdLtUs5qEnu1LznrrZe3sOwghECzUFiBwDwGsZvFpKA6J1284phJSviroQ6U42sOPOncBRFMJwLa/FtqBISwAbIIdwIRmF6QzTn4PLX5vK2buIRlO4PADSx4kXqhFbGvHn1YHWgnhzi62jUUUhcty0UYL/pnhzBgmw0Aa3ZuFPliBCqhGEQab+lZBZ9o/s5jhpxjetUZNiRd/WSi56Lvc1LxzbT3A5KdCmDKgN21eC6yGB5Qm4HnzFxYxCvzJIMwsxTSgHVxACxRxLrQl4fl7fgbXSClHy+tU8xhK2F/YrX6ejLk9AURvhcy0wHUzp3B/q8SdzDovOnHgTR9mP85NH69z1L5L7Cv0E/pW2GPQ1krCJTrYjPJVrX+SnggHBALsNReJaTEdr6POJ0PpU/90vVFGjyVcdsb3tRA4T9l4eeBtSbykn3E5wfTubse/zx/OZsYcOI885vLrm2TI3fpM+G+mLdkn/FyyN69k5slO6Qn88Gn/XnBoXkZPsQhz6pwthoOTIME0BTk+l14hmbpV/hBJ3xYrnQuyv7Ji7iXKXl0zCxslh3PTT22iBF30aeBI76hGV/fDcLzvIIUJGniWsfKDalJAbzfRqpaaumrhPzJjCGovFHX8yBAtB8GLnRAFJ4GZNRXkTIBIAfSzPzAWfsY9AvyLHde86ffqk+K2SfpJIorXrnRCOazOQCe5kXEgE053yf2619V8mLQODJ7LHNrbGhJPoMsGmMwCPPMOhijQL/LPLQqTat6Qs3IciDl"
`endif