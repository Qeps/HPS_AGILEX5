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


// // Copyright 2021 Intel Corporation. 
// //
// // This reference design file is subject licensed to you by the terms and 
// // conditions of the applicable License Terms and Conditions for Hardware 
// // Reference Designs and/or Design Examples (either as signed by you or 
// // found at https://www.altera.com/common/legal/leg-license_agreement.html ).  
// //
// // As stated in the license, you agree to only use this reference design 
// // solely in conjunction with Intel FPGAs or Intel CPLDs.  
// //
// // THE REFERENCE DESIGN IS PROVIDED "AS IS" WITHOUT ANY EXPRESS OR IMPLIED
// // WARRANTY OF ANY KIND INCLUDING WARRANTIES OF MERCHANTABILITY, 
// // NONINFRINGEMENT, OR FITNESS FOR A PARTICULAR PURPOSE. Intel does not 
// // warrant or assume responsibility for the accuracy or completeness of any
// // information, links or other items within the Reference Design and any 
// // accompanying materials.
// //
// // In the event that you do not agree with such terms and conditions, do not
// // use the reference design file.
// /////////////////////////////////////////////////////////////////////////////

(* altera_attribute = "-name SYNCHRONIZER_IDENTIFICATION OFF" *)
module  generic_m20k   #(
    parameter WIDTH = 8,
    parameter ADDR_WIDTH = 5
)(
    input clk,
    input [WIDTH-1:0] din,
    input [ADDR_WIDTH-1:0] waddr,
    input we,
    input re,
    input [ADDR_WIDTH-1:0] raddr,
    output [WIDTH-1:0] dout,
    input sclr
    );

    localparam DEPTH = 1 << ADDR_WIDTH;
    altera_syncram  altera_syncram_component (
                .address_a (waddr),
                .address_b (raddr),
                .clock0 (clk),
                .data_a (din),
                .wren_a (we),
                .rden_b (re),
                .q_b (dout),
                .aclr0 (1'b0),
                .aclr1 (1'b0),
                .address2_a (1'b1),
                .address2_b (1'b1),
                .addressstall_a (1'b0),
                .addressstall_b (1'b0),
                .byteena_a (1'b1),
                .byteena_b (1'b1),
                .clock1 (1'b1),
                .clocken0 (1'b1),
                .clocken1 (1'b1),
                .clocken2 (1'b1),
                .clocken3 (1'b1),
                .data_b ({WIDTH{1'b1}}),
                .eccencbypass (1'b0),
                .eccencparity (8'b0),
                .eccstatus (),
                .q_a (),
                .rden_a (1'b1),
                .sclr (sclr),
                .wren_b (1'b0));
    defparam
        altera_syncram_component.address_aclr_b  = "NONE",
        altera_syncram_component.address_reg_b  = "CLOCK0",
        altera_syncram_component.clock_enable_input_a  = "BYPASS",
        altera_syncram_component.clock_enable_input_b  = "BYPASS",
        altera_syncram_component.clock_enable_output_b  = "BYPASS",
        altera_syncram_component.enable_ecc  = "FALSE",
        altera_syncram_component.enable_force_to_zero  = "FALSE",
        altera_syncram_component.optimization_option  = "HIGH_SPEED",
        altera_syncram_component.intended_device_family  = "Agilex 5",
        altera_syncram_component.lpm_type  = "altera_syncram",
        altera_syncram_component.numwords_a  = DEPTH,
        altera_syncram_component.numwords_b  = DEPTH,
        altera_syncram_component.operation_mode  = "DUAL_PORT",
        altera_syncram_component.outdata_aclr_b  = "NONE",
        altera_syncram_component.outdata_sclr_b  = "SCLEAR",
        altera_syncram_component.outdata_reg_b  = "CLOCK0",
        altera_syncram_component.power_up_uninitialized  = "FALSE",
        altera_syncram_component.ram_block_type  = "M20K",
        altera_syncram_component.read_during_write_mode_mixed_ports  = "DONT_CARE",
        altera_syncram_component.widthad_a  = ADDR_WIDTH,
        altera_syncram_component.widthad_b  = ADDR_WIDTH,
        altera_syncram_component.width_a  = WIDTH,
        altera_syncram_component.width_b  = WIDTH,
        altera_syncram_component.width_byteena_a  = 1;


endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "wa4P/9mz5QzJaCbKgT7JOJw4FVjuprs8A5RwJjfxAxxciUOWXJIn+FtPapWtMIjHamBsUWdV2bvRqNThOSwB+furcJmByBPZXvoub8NXFzxmQ/2dXljymLby/MfmD/YBDoZ57TSQmUKoNpmLTjhhJ+g763dviJXfQF2BSnAiUoHGPmEdVkhyj7dhPx4+Eu2ipptj5TeG4+F9tpD57NeNYwNyTn1aD43KEoaGWeqQkbHlSvLnkA5GebWCoE0l+kG7u3klMVZqIQs+qhHgoRdWwbkE1n3c5H/YmtnTt5UBWKDXeZdXB+/Ddaj1FRmUwYSOlH/dz+WaivgTBoiB0kMmES0b8R5eb6C/UqfqmWdKAdzf5prhy6rYHh6HiIiUqSCKrx4YDnnrbWoDYeju2bT+oT4NzY/q5xqicBxVvIQDJrFDpebmsJVofKA1REs8pdPUb8OQqBE0CZ9XalEijOA6mBPrJOEMdPMNPPc7CqXOUnOqmQBs4sjQXSFQpXz1KFt2U1/MpSWjBzomzeFJAp7X+23Z9NxpRqYAaAhuqZozlLqXWTps9qgS3sPnX+i/zRpkbkpp+aA25536tj0+qWnunrQEZnZOS40FGWOuA4BTKaNckQPsesdKu/RdOkMUPg+0s+Q1qSLlmTLJWr60r4yOA+vkd33ysTbqAH21v60+O0jAvgxfPM+ydkXV58JtbUesc2E1KGqfmtKro4ZfodwRB/gq57sxVZr4rxJTr0MBdEbKV/yjlczM0DxopMxuWySmRu2ckzbw3Lig5/lZKFva1iC9EuMmmz2rKPSdKx0ancP7fNEvnYq/2DU+AnYVrfpp2IT4EzbfLXYDJYC0b582fpScCmXxRYBBDYooNqW8IleyKLBMq+kE5HYejmkf/ZtzXpfFjxHhROEfbVNcVj+nFP8NYMhwarzFnl6PVycFTifq398s2PzZ5BfzayG/gYCo6ORQ5I7WawPm/8q+an2HQBoBuuqisUFnaGPzjD9z0vSZz2PyB3rRkoOuh2CztW2p"
`endif