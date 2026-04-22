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


//
// Module : ready_latency_reset_synchronizer
// Description :
//     2-stage reset synchronizer used for ready latency reset. Takes an
//     asynchronous, active high reset input (rst_async) and synchronizes it
//     to the rising edge of the clock (clk). The output (rst_sync) is active
//     high and safe for use in the clk domain. 
//     This module is intended to be used for Agilex 5 HPS ready latency
//     adapters for the fabric-facing bridges. HPS IP generation should
//     automatically instantiate and connect the HPS reset output (h2f_reset)
//     to the synchronizer input and synchronizer output to each bridge ready
//     latency adapter. This ensures HPS reset and the bridge soft-logic
//     resets are synchronized to the bridge clocks.
//
module ready_latency_reset_synchronizer (
    input logic clk,
    input logic rst_async,    // asynchronous active high input reset
    output logic rst_sync     // synchronized active high output reset 
);

    // 2-stage synchronizer register
    logic [1:0] sync_reg;

    // asynchronous assertion, synchronous deassertion of reset
    always_ff @(posedge clk or posedge rst_async) begin
        if (rst_async) begin
            sync_reg <= 2'b11;    // assert reset synchronously
        end else begin
            sync_reg <= {sync_reg[0], 1'b0}; // Shift in '0' to release reset
        end
    end

    // Output is the last stage of the synchronizer
    assign rst_sync = sync_reg[1];

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "wa4P/9mz5QzJaCbKgT7JOJw4FVjuprs8A5RwJjfxAxxciUOWXJIn+FtPapWtMIjHamBsUWdV2bvRqNThOSwB+furcJmByBPZXvoub8NXFzxmQ/2dXljymLby/MfmD/YBDoZ57TSQmUKoNpmLTjhhJ+g763dviJXfQF2BSnAiUoHGPmEdVkhyj7dhPx4+Eu2ipptj5TeG4+F9tpD57NeNYwNyTn1aD43KEoaGWeqQkbEwTnadx5CSlWCcJW0UxWD/JXP3ggYAO8b4f0oRdQ5TQKdO78LLTUjr1SvefymqkYT40ZCF73HNZ1SrLwMy66/ts2+LdNxDhjVoqgRf2GEPuN841CzVBXdcaeYhkGdXSnnuv7FXWYMSZOSPp4lKOnBDNCuqq0zMLs4qwzEhGwYjXVnr3NBfS341GU3/M2q7BQJF3z/2oKy1uDDt0g+wzWHUJfpYmjk7jalsvNo817Qdw70SgdicD/8lF+sEzw8eUxnsO2ennwdC/I51WC7gto51fvXhojQyLugnv2/G8omPn9Sze+hEkHJMcUMLghl1gvhnKnG4t1DMrtjBQxTLkUMDhONql9fg6wpGDzsUkFjV/OkKgO/ea+oCk9JR4ZnYVhCnXHX67m6/RJPf1CYqHz1iP2Ft/GjtYnz54jniQoU/Aqmqf0JdTMrUqBd9rdGpxnm4PFIsHstGp512KlBVFoQaB7IqMLKenhwQhu5IBhRjqSuZXAn7zrMYiRhFiOk/R4aC7EcSL/fdJ/xKEEJ3jwXYTkSEJrS5MWhqqy/E8hDtTBGb2F3CusXKEgxxGVSgHInpcO9XZxlnoWSuzyLSL6XU5EHwDUe3UJmbEYzk6+f4s7d8nCvfGzOHkTpJB/Zzjm/ppDN9lJw2YIxmadKpapm8Br1VBLwz0pLRsmgUtFv0hQ0armKHP1SkZK9OsuzhX8DJu5yvW9cQMT9TSl5E8TZjYIAfFU5yZWsGbJy/9B9pbGdEXKUVAj9jw6iEcniNe2Mocnhzx/evHejc3hfBHfCy"
`endif