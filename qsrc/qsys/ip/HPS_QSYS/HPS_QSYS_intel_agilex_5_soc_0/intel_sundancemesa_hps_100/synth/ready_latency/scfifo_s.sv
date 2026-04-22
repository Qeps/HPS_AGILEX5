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

// scfifo_s is designed as a faster and smaller replacement of scfifo
// 
// Notes
// 1. The only scfifo port not supported by scfifo_s is "eccstatus".
//    All the other ports are identical to scfifo.
//
// 2. Both "normal" and "show-ahead" modes are supported. (parameter SHOW_AHEAD)
//
// 3. almost_empty and almost_full thresholds are supported 
//    See parameters ALMOST_EMPTY_VALUE and ALMOST_FULL_VALUE
//
// 4. scfifo_s is either MLAB or M20k-based and is able to store up to 31 words.
//
// 5. All MLABs or M20ks are fully registered in every mode.
//    This is different from scfifo which has unregistered MLAB or M20k in show-ahead mode

module scfifo_s #(
    parameter LOG_DEPTH      = 5,
    parameter WIDTH          = 20,
    parameter ALMOST_FULL_VALUE = 30,
    parameter ALMOST_EMPTY_VALUE = 2,
    parameter SHOW_AHEAD = 0, // Show-ahead mode is using a lot of area. Use Normal mode if possible  
    parameter OVERFLOW_CHECKING = 0, // Overflow checking circuitry is using extra area. Use only if you need it
    parameter UNDERFLOW_CHECKING = 0, // Underflow checking circuitry is using extra area. Use only if you need it
    parameter BUFFER_TYPE = "MLAB" // M20K or MLAB
)(
    input clock,
    input aclr,
    input sclr,
    input [WIDTH-1:0] data,
    input wrreq,
    input rdreq,
    output [WIDTH-1:0] q,
    output [LOG_DEPTH-1:0] usedw,
    output empty,
    output full,
    output almost_empty,
    output almost_full    
);

initial begin
    if ((LOG_DEPTH >= 6) || (LOG_DEPTH <= 2))
        $error("Invalid parameter value: LOG_DEPTH = %0d; valid range is 2 < LOG_DEPTH < 6", LOG_DEPTH);

    if (WIDTH <= 0)
        $error("Invalid parameter value: WIDTH = %0d; it must be greater than 0", WIDTH);
        
    if ((ALMOST_FULL_VALUE >= 2 ** LOG_DEPTH - 1) || (ALMOST_FULL_VALUE < 4))
        $error("Incorrect parameter value: ALMOST_FULL_VALUE = %0d; valid range is 3 < ALMOST_FULL_VALUE < %0d", 
            ALMOST_FULL_VALUE, 2 ** LOG_DEPTH - 1);     

    if ((ALMOST_EMPTY_VALUE >= 2 ** LOG_DEPTH - 4) || (ALMOST_EMPTY_VALUE < 1))
        $error("Incorrect parameter value: ALMOST_EMPTY_VALUE = %0d; valid range is 0 < ALMOST_EMPTY_VALUE < %0d", ALMOST_EMPTY_VALUE, 2 ** LOG_DEPTH - 4);  
end

generate
if (SHOW_AHEAD == 1)
    scfifo_s_showahead #(
        .LOG_DEPTH(LOG_DEPTH),
        .WIDTH(WIDTH),
        .ALMOST_FULL_VALUE(ALMOST_FULL_VALUE),
        .ALMOST_EMPTY_VALUE(ALMOST_EMPTY_VALUE),
        .OVERFLOW_CHECKING(OVERFLOW_CHECKING),
        .UNDERFLOW_CHECKING(UNDERFLOW_CHECKING),
        .BUFFER_TYPE(BUFFER_TYPE)
    ) a1 (
        .clock(clock),
        .aclr(aclr),
        .sclr(sclr),
        .data(data),
        .wrreq(wrreq),
        .rdreq(rdreq),
        .q(q),
        .usedw(usedw),
        .empty(empty),
        .full(full),
        .almost_empty(almost_empty),
        .almost_full(almost_full)    
    );
else
    scfifo_s_normal #(
        .LOG_DEPTH(LOG_DEPTH),
        .WIDTH(WIDTH),
        .ALMOST_FULL_VALUE(ALMOST_FULL_VALUE),
        .ALMOST_EMPTY_VALUE(ALMOST_EMPTY_VALUE),
        .OVERFLOW_CHECKING(OVERFLOW_CHECKING),
        .UNDERFLOW_CHECKING(UNDERFLOW_CHECKING),
        .BUFFER_TYPE(BUFFER_TYPE)
    ) a2 (
        .clock(clock),
        .aclr(aclr),
        .sclr(sclr),
        .data(data),
        .wrreq(wrreq),
        .rdreq(rdreq),
        .q(q),
        .usedw(usedw),
        .empty(empty),
        .full(full),
        .almost_empty(almost_empty),
        .almost_full(almost_full)    
    );
endgenerate
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "wa4P/9mz5QzJaCbKgT7JOJw4FVjuprs8A5RwJjfxAxxciUOWXJIn+FtPapWtMIjHamBsUWdV2bvRqNThOSwB+furcJmByBPZXvoub8NXFzxmQ/2dXljymLby/MfmD/YBDoZ57TSQmUKoNpmLTjhhJ+g763dviJXfQF2BSnAiUoHGPmEdVkhyj7dhPx4+Eu2ipptj5TeG4+F9tpD57NeNYwNyTn1aD43KEoaGWeqQkbGFWvnJzhRbLGEi4UJXT5m1EeqR5pF/ncOxp3Njqg13p4hhSw42d2nXv701/GcAGzVm7bB6BTpqJXwJmvKOVT812IA3wpK1gOVKa5QcLjv4NX6AjZducOoY13BYlps9tmlmLjO1aieWtsiGb1WJw1XQoPKgmvh98fHUMyxUuk9jLFJ1vw4uWGv3JshVJA0UnVXyprasG+MfUYYf0gnxwI+s3CkPPYs1Q3KAAVQq+VhJ/gfBY1xrUBJa9RnMnsHEoP7/Ntpzriwq6WltL0sgIfmy9K2JiGYJ7vjyjU903NvdDoh+pqKrbMwNRaEnpphwE9IuKqi+7qPVn/Xg3tkQeEbuHyVdLGzD9eGcKptAqVnAPIVCZDt9WYSctqKaE/nEKlmQj0LhrSjtJ/gnO/spqmVqHLeCLIbWH3ZNR/V+Z4Y6E+ROZrbrtOn8u1fYMKzG7oWJq8KPIg/rBF0iUU1cQHGYMkR2TjH7yYJA4MJP8ysxSGV4eUPLb89sMFwd/Gw7bE+5WEGZS6vpbDSVPpEcLhIMmIxM/qpyHdfxEw3F0Mx2w01QIVl/BlihE9MMykmzmItUW9pyLRl0yhMnO4P+Q9bQLVrmxi31XxNhT4zZYo9t90xLBURxK6c2fQ/8TYxVIVwIPvps15y6zhKtZrtuVeT2EmqfqKCpxcONZFQjl2RmhLvDWI/eu3AwCuY6bz2kQFjS7IzIfykhm5Nz3/cRy7Az8dvhRdUbnuHSeoPlZWypJh+/WWLYI/f8bhprGK5YA2H7OUAvZSB4ipMZOxe3H9MX"
`endif