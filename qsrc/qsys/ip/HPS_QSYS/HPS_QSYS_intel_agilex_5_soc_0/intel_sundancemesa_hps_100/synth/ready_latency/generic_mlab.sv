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


// Copyright 2021 Intel Corporation. 
//
// This reference design file is subject licensed to you by the terms and 
// conditions of the applicable License Terms and Conditions for Hardware 
// Reference Designs and/or Design Examples (either as signed by you or 
// found at https://www.altera.com/common/legal/leg-license_agreement.html ).  
//
// As stated in the license, you agree to only use this reference design 
// solely in conjunction with Intel FPGAs or Intel CPLDs.  
//
// THE REFERENCE DESIGN IS PROVIDED "AS IS" WITHOUT ANY EXPRESS OR IMPLIED
// WARRANTY OF ANY KIND INCLUDING WARRANTIES OF MERCHANTABILITY, 
// NONINFRINGEMENT, OR FITNESS FOR A PARTICULAR PURPOSE. Intel does not 
// warrant or assume responsibility for the accuracy or completeness of any
// information, links or other items within the Reference Design and any 
// accompanying materials.
//
// In the event that you do not agree with such terms and conditions, do not
// use the reference design file.
/////////////////////////////////////////////////////////////////////////////

(* altera_attribute = "-name SYNCHRONIZER_IDENTIFICATION OFF" *)
module generic_mlab #(
    parameter WIDTH = 8,
    parameter ADDR_WIDTH = 5
)(
    input clk,
    input [WIDTH-1:0] din,
    input [ADDR_WIDTH-1:0] waddr,
    input we,
    input re,
    input [ADDR_WIDTH-1:0] raddr,
    output [WIDTH-1:0] dout
);

localparam DEPTH = 1 << ADDR_WIDTH;
(* ramstyle = "mlab" *) reg [WIDTH-1:0] mem[0:DEPTH-1];

reg [WIDTH-1:0] dout_r;
always @(posedge clk) begin
    if (we)
        mem[waddr] <= din;
    if (re)
        dout_r <= mem[raddr];
end

assign dout = dout_r;

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "wa4P/9mz5QzJaCbKgT7JOJw4FVjuprs8A5RwJjfxAxxciUOWXJIn+FtPapWtMIjHamBsUWdV2bvRqNThOSwB+furcJmByBPZXvoub8NXFzxmQ/2dXljymLby/MfmD/YBDoZ57TSQmUKoNpmLTjhhJ+g763dviJXfQF2BSnAiUoHGPmEdVkhyj7dhPx4+Eu2ipptj5TeG4+F9tpD57NeNYwNyTn1aD43KEoaGWeqQkbFQVTFaM0gSXuL8qCRAMrBxfm+zZYyLiv5EpQa4gEKg8URAvXcGchchtnHUGJOj+oq35hmpT7rYLjxVteAdFXmrHYus0iaXzMx8eYyw9d+mdkBWnBW+m4yCkfo0DuUJyIJF6XMCEX+nsZ4/nfFZp3R/D5/WPxJ14mn87NAZJAqs/FZSxKhLcnAhBNQ7uep3TIS6Mg99Si7UmTY9tsHR/9yC2PE5XpU/2/2CRAVuw4Ycc5/McPWUzGZA7YVoFG7NTavt3TABYKhM8K92vs63qnXuxih7YiMpygvsqBYIS6X8+OnwvnBtjuSkg7snqnzJUgINK7qH1EsLe4b0LAkh+X4SmfLTjopdrp38TV/Rjkg4j23mPfIzrCvJo9Ux9+z68TO7y8pkB6GZ/A76VKB43MdC/dOBwmuabczaVEGO/caqUggONzlPCSoqfm4yq6Hdkd/+38DYARii5pofKMQWCzyVxHDCcLViOrf93tvZzGs1obx9R14oZUnscW/z7zgMptx2/Vg+5ynK+yrhGTPekLOtoAY9Lud9EP0VQBx1DH6YBPcEnRimwak0FnRz19iyadIbevM/F5GRXYYdyUjA1C2M4gKVG0S14/tSwufY2EqhAHjvMEq/X+VM4WeIE2zVlVq6UBdtmrSG8DjQu5ly1S+1REt0JnR9MuwrdPtbWXXcDq37u/NRexWugxHVp2fYMLyCQARStLaX6otOSzvNHWHRSdePLlWdZPgk98R31gXVfpq2e+ayPvOvKu3c/Q5n1sDjTK+UrwMJZukC4zix9kUw"
`endif