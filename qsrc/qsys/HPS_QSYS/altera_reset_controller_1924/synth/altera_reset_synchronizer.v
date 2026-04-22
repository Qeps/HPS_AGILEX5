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


// $Id: //acds/rel/25.3.1/ip/iconnect/merlin/altera_reset_controller/altera_reset_synchronizer.v#1 $
// $Revision: #1 $
// $Date: 2025/10/16 $

// -----------------------------------------------
// Reset Synchronizer
// -----------------------------------------------
`timescale 1 ns / 1 ns

module altera_reset_synchronizer
#(
    parameter ASYNC_RESET = 1,
    parameter DEPTH       = 2
)
(
    input   reset_in /* synthesis ALTERA_ATTRIBUTE = "SUPPRESS_DA_RULE_INTERNAL=R101" */,

    input   clk,
    output  reset_out
);

    // -----------------------------------------------
    // Synchronizer register chain. We cannot reuse the
    // standard synchronizer in this implementation 
    // because our timing constraints are different.
    //
    // Instead of cutting the timing path to the d-input 
    // on the first flop we need to cut the aclr input.
    // 
    // We omit the "preserve" attribute on the final
    // output register, so that the synthesis tool can
    // duplicate it where needed.
    // -----------------------------------------------
    (*preserve*) reg [DEPTH-1:0] altera_reset_synchronizer_int_chain;
    reg altera_reset_synchronizer_int_chain_out;

    generate if (ASYNC_RESET) begin

        // -----------------------------------------------
        // Assert asynchronously, deassert synchronously.
        // -----------------------------------------------
        always @(posedge clk or posedge reset_in) begin
            if (reset_in) begin
                altera_reset_synchronizer_int_chain <= {DEPTH{1'b1}};
                altera_reset_synchronizer_int_chain_out <= 1'b1;
            end
            else begin
                altera_reset_synchronizer_int_chain[DEPTH-2:0] <= altera_reset_synchronizer_int_chain[DEPTH-1:1];
                altera_reset_synchronizer_int_chain[DEPTH-1] <= 0;
                altera_reset_synchronizer_int_chain_out <= altera_reset_synchronizer_int_chain[0];
            end
        end

        assign reset_out = altera_reset_synchronizer_int_chain_out;
     
    end else begin

        // -----------------------------------------------
        // Assert synchronously, deassert synchronously.
        // -----------------------------------------------
        always @(posedge clk) begin
            altera_reset_synchronizer_int_chain[DEPTH-2:0] <= altera_reset_synchronizer_int_chain[DEPTH-1:1];
            altera_reset_synchronizer_int_chain[DEPTH-1] <= reset_in;
            altera_reset_synchronizer_int_chain_out <= altera_reset_synchronizer_int_chain[0];
        end

        assign reset_out = altera_reset_synchronizer_int_chain_out;
 
    end
    endgenerate

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "p4G5aqSQ9TchkOY9hF0+pFF7DDJR0hvDqNS9CPueQc5md9wfv0hWMQ6pJcxo0Drzbe39osFaopgdkAYFALRbTXYBz12dtCWBppKRqwUV3L13u4YpnW9w3QXN3+gnL/OLJRYtIm4wrZqSo45BIXaGqXFjDAtVBNfWmrJr+t3hVbKcFL9vPkK+NVFoZy+6pA3YoPk6sKQg08FKNNhNkYHHSungXP+bIW8NoAlgT/WJsaOlPGfIclSkOpPc4BurxYeQYrDRgbrOJ1pE7FsVML519SRQqIeUrsSj8OiGl70NYnjfrMQxf9bzhvz5f6ycc/6zYkCUANQt87if85m194Dw165FzWp8GifpzTbht0rRvJfAIymphTGCJxMBo7qMftZ3sD5QndRqa+b/ekhJP8fzVXMyE9biFZDdmv/bPLES00fzxN3MMg6WTh6LMEb3yh+FnkjzmtIrpPQbyYsX6tbs1i5kGwn5mEopKshHGDmwm2DN3CzAYq7tNwWcPQbvAeYabSHQUTrAyPthJ+kQbQojb+5ewn8vrwdm1GShdnooEzDcX3GuMPkwSPiWSXdNt5f3GxHSIIidIjCPcqW42cWLT1/vjgcenpEWaZWikdYWTg1bXpOdtstLRpiYP/qRhhaz6vT8zU2qA79tctw0ceCrLW0CIC8QBmt21keuD4JL6AiDnHmPjjCv4qHwCu4z1gy3/PBBIBcUBII/OYCrHshZiist3NuEDfkyCKKlF5En/fchKDDuqsZFKzqMM/EtWZDspk6fF4Oi0dN3s+UlYkqUKTNJUovuXpIow67KRzVubHHzuw29D500GlU012jPV1AVAHnbSYNFOOcfTq2xNjAB9Lo1XYHbIfdFFlA2IZNSHfBxWaChuiY9n3cfz4kms5Mwrfl4P3ocWAiuWNPwV+QHUa9oXq5xTPzvO2YihG0BhAPbEZBlSXRjU8zqtruiSeGqJiDD6+PKcq5kiCleZo23DqAXcrlw7c4BTE61HSuiOMzguYbfCvU4z3NodnE+uZQC"
`endif