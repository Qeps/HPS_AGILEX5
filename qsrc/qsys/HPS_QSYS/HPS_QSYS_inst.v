	HPS_QSYS u0 (
		.test_lpddr4b               (_connected_to_test_lpddr4b_),               //  output,   width = 1,       test_lpddr4b.test_complete
		.button_in                  (_connected_to_button_in_),                  //   input,   width = 1,          button_in.button_in
		.s0_axi4_ctrl_ready_reset_n (_connected_to_s0_axi4_ctrl_ready_reset_n_), //  output,   width = 1, s0_axi4_ctrl_ready.reset_n
		.mem_0_mem_cs               (_connected_to_mem_0_mem_cs_),               //  output,   width = 1,              mem_0.mem_cs
		.mem_0_mem_ca               (_connected_to_mem_0_mem_ca_),               //  output,   width = 6,                   .mem_ca
		.mem_0_mem_cke              (_connected_to_mem_0_mem_cke_),              //  output,   width = 1,                   .mem_cke
		.mem_0_mem_dq               (_connected_to_mem_0_mem_dq_),               //   inout,  width = 32,                   .mem_dq
		.mem_0_mem_dqs_t            (_connected_to_mem_0_mem_dqs_t_),            //   inout,   width = 4,                   .mem_dqs_t
		.mem_0_mem_dqs_c            (_connected_to_mem_0_mem_dqs_c_),            //   inout,   width = 4,                   .mem_dqs_c
		.mem_0_mem_dmi              (_connected_to_mem_0_mem_dmi_),              //   inout,   width = 4,                   .mem_dmi
		.mem_ck_0_mem_ck_t          (_connected_to_mem_ck_0_mem_ck_t_),          //  output,   width = 1,           mem_ck_0.mem_ck_t
		.mem_ck_0_mem_ck_c          (_connected_to_mem_ck_0_mem_ck_c_),          //  output,   width = 1,                   .mem_ck_c
		.mem_reset_n_mem_reset_n    (_connected_to_mem_reset_n_mem_reset_n_),    //  output,   width = 1,        mem_reset_n.mem_reset_n
		.oct_0_oct_rzqin            (_connected_to_oct_0_oct_rzqin_),            //   input,   width = 1,              oct_0.oct_rzqin
		.ref_clk_clk                (_connected_to_ref_clk_clk_),                //   input,   width = 1,            ref_clk.clk
		.hps_io_gpio41              (_connected_to_hps_io_gpio41_),              //   inout,   width = 1,             hps_io.gpio41
		.refclk_clk                 (_connected_to_refclk_clk_),                 //   input,   width = 1,             refclk.clk
		.locked_export              (_connected_to_locked_export_),              //  output,   width = 1,             locked.export
		.reset_reset                (_connected_to_reset_reset_),                //   input,   width = 1,              reset.reset
		.in_reset_reset_n           (_connected_to_in_reset_reset_n_),           //   input,   width = 1,           in_reset.reset_n
		.ninit_done_ninit_done      (_connected_to_ninit_done_ninit_done_),      //  output,   width = 1,         ninit_done.ninit_done
		.test_lwh2f                 (_connected_to_test_lwh2f_)                  //  output,   width = 1,         test_lwh2f.test_complete
	);

