module HPS_QSYS (
		output wire        test_lpddr4b,               //       test_lpddr4b.test_complete
		input  wire        button_in,                  //          button_in.button_in
		output wire        s0_axi4_ctrl_ready_reset_n, // s0_axi4_ctrl_ready.reset_n
		output wire [0:0]  mem_0_mem_cs,               //              mem_0.mem_cs
		output wire [5:0]  mem_0_mem_ca,               //                   .mem_ca
		output wire [0:0]  mem_0_mem_cke,              //                   .mem_cke
		inout  wire [31:0] mem_0_mem_dq,               //                   .mem_dq
		inout  wire [3:0]  mem_0_mem_dqs_t,            //                   .mem_dqs_t
		inout  wire [3:0]  mem_0_mem_dqs_c,            //                   .mem_dqs_c
		inout  wire [3:0]  mem_0_mem_dmi,              //                   .mem_dmi
		output wire [0:0]  mem_ck_0_mem_ck_t,          //           mem_ck_0.mem_ck_t
		output wire [0:0]  mem_ck_0_mem_ck_c,          //                   .mem_ck_c
		output wire        mem_reset_n_mem_reset_n,    //        mem_reset_n.mem_reset_n
		input  wire        oct_0_oct_rzqin,            //              oct_0.oct_rzqin
		input  wire        ref_clk_clk,                //            ref_clk.clk
		inout  wire        hps_io_gpio41,              //             hps_io.gpio41
		input  wire        refclk_clk,                 //             refclk.clk
		output wire        locked_export,              //             locked.export
		input  wire        reset_reset,                //              reset.reset
		input  wire        in_reset_reset_n,           //           in_reset.reset_n
		output wire        ninit_done_ninit_done,      //         ninit_done.ninit_done
		output wire        test_lwh2f                  //         test_lwh2f.test_complete
	);
endmodule

