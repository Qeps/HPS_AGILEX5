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

module add_a_b_s0_s1 #(
    parameter SIZE = 5
)(
    input [SIZE-1:0] a,
    input [SIZE-1:0] b,
    input s0,
    input s1,
    output [SIZE-1:0] out
);
    wire [SIZE:0] left;
    wire [SIZE:0] right;
    wire temp;
    
    assign left = {a ^ b, s0};
    assign right = {a[SIZE-2:0] & b[SIZE-2:0], s1, s0};
    assign {out, temp} = left + right;
    
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "wa4P/9mz5QzJaCbKgT7JOJw4FVjuprs8A5RwJjfxAxxciUOWXJIn+FtPapWtMIjHamBsUWdV2bvRqNThOSwB+furcJmByBPZXvoub8NXFzxmQ/2dXljymLby/MfmD/YBDoZ57TSQmUKoNpmLTjhhJ+g763dviJXfQF2BSnAiUoHGPmEdVkhyj7dhPx4+Eu2ipptj5TeG4+F9tpD57NeNYwNyTn1aD43KEoaGWeqQkbGkX4M8Sy4XoIFeDFgGb3G2JAaqTJOJQENFkmT1eyCOvU9rBqMPLJpBgLLDkN3nJXg7OtbRqNaMshhsjl8XQoRHtFvqnRrPDGGrjdF2CD/GjJdt9JbOopNYuW6X/Bfz1S525H/5TNLDf5hespkwHfcki7NKMViyVZgyIiuvn7wib4Wn+KNlte2UkOccAVUMLE5RjU8DTgFCSQVMgg5eJV8Ojc+tSy89kqR8p9y/KOIYt8hyQLtSaAZ3rUMFv0d5z7YongxuG/10rExGJbrVB71BP3fIa64wInMO/NaFGHMno/SnjIxbMmXU1itF8DPWvyLm6iuagEtlQf5g3sAMA+tuQt4UTDWO/7j7Ab0BX8EKDM+dHT7DNLl8fVYk7bImeH5m2x1s6bRIE1lvaWpvTNNW0zcJbRfp3vnr9F7a5AiGm6J8bnDuah26MAw9fKox3fIVbnNffszlutyTTmlCzL7GRvKTycFb8/1f+8+wxXDld1eCBV3MQbLGR+oPA6s1YW1m5R9WU3v0I4PqG9/EA86ATeEuvdg97Y53SweGXHrKxvn2wcHm49/NN4dsETwXFcscAdQcNbe5ECShLqaG7Sj0ULzUO6xRtxU8CtE1mGq2gRIpE0bA5/cOaKWk5nP4C9i8LJv1v7fu3Gt85HAaYH8Q29+76JZukyYC4k/N+QWH0LuxllGyHdEvBNI38po+jQ4qeCETb0Bnm8WufWmKs7n1a4De2cXWw/bpNPZ58mexqu+yYbfdruuMvTgpWezptiiS8batY/4F6oxWQvIjg6pI"
`endif