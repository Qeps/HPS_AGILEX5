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
`pragma questa_oem_00 "FQbdgc6L7IBAY6fOekGDZSoPPgzAvTLS5KI4ZFuNrzNpTW8vAdrHoXjbN9QDDni9wandNqca4alTzfPQdbuyX8xJkBUKByOgHDrbWP9Om8Wf/wBzwdp7QRgAIoMl3XHkp6wfCOAmKGBGXhS+D0N58GZjgAxZE5k1kPkGwTW2HK66FVEKxZmgFTH/3PkyONzjSYFAnIyDnLAccODH1NLcP+QMpGqPUsBsbddxoMEc9m61yKLLcN1edZuvMbpwfVUZ198NmER5B0CLHwfTcw7kuyBMml28Xx5GLjYalYlEQ+rHXhz84HQ494NHRUbprIq3ijB9ElwiFnMyBQRL7nRh3/PRMzfPGysimnnusR++rmEkq8vix8YiUuqe2HjEcH4NkWakmRThF1ocIshoaLzM4+FxkwhNTb8I6wBvECc5m+yyyehTa0Yzuo9UcGxO3JTCtlmPNLIPKSgVy7JL8XpefPY+FcTXDtpD5g+vzpxv9ruR3jWEDdcxL9y0rPRLB6RF9egD6iYnW2xsQzah/d5Pd73d0jsx7/8JEJ2yFOR7bCGbOGEbS1peNwWNcfF7yvMRT97npYZhL0BugVlqIkUiIeWS/PEyvn+otU9OG/HnF6ZJ7gfcS6yNzWMN8AMVqgxv3hHRcq5/or1wBM9OEp7JPQ2meml7rfAAgvMAAP9hA6vUoTUhUoGfx8xo1yiBNxZq69OLNoRAqQPlel8nCy1PSKbBC7MqXO+DyxMbX7G8EV+rXGjFiRrgz40ePZ/x4JCVBcVtl6TR4nwMjwxP7nF5CdR2lVm+zFDuTZpYWddB63yVc+o3wYQ7TsmQSvn2K4f+ANg+WcHrwbB6KVzKWaCsaV0ejfzQzExtaJgVz3SjS2hqoRSXVSS6VR+UNojdhHw52t4J3XIzmINVHV+JJpEBECQBVVB++dI306kGGlK1Fa7rkpEE6Ba5NliIODHwYA+Qo/YPpPi8p9FUvFsvKUG4T5USf1lyWpR+C1GWpCpm6KLEh6lOsVIIocggUfjggB7E"
`endif