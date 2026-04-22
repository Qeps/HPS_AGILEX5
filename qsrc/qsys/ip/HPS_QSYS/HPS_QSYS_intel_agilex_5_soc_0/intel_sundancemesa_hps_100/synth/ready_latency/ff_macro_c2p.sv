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


module ff_macro_c2p # (
 parameter DATA_WIDTH = 256,
 parameter NUM_FLOPS = 1 // based on number of flops you need in 1 dir 
 ) (
 input logic clk,

 input [DATA_WIDTH -1:0] in_data ,

 output [DATA_WIDTH -1:0] out_data

);


 (* altera_attribute = {"-name FORCE_HYPER_REGISTER_FOR_CORE_PERIPHERY_TRANSFER ON; -name HYPER_REGISTER_DELAY_CHAIN 350"} *)
    reg [DATA_WIDTH-1:0] in_data_reg [NUM_FLOPS:0];    

    assign in_data_reg[0] = in_data;


    genvar i;
    
    generate 
    for (i=0 ; i<NUM_FLOPS ; i=i+1 ) begin : hps_c2p_ff
      always @(posedge clk) begin
          in_data_reg[i+1] <= in_data_reg[i];
      end
    end
    endgenerate

    assign out_data = in_data_reg[NUM_FLOPS];



    
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "wa4P/9mz5QzJaCbKgT7JOJw4FVjuprs8A5RwJjfxAxxciUOWXJIn+FtPapWtMIjHamBsUWdV2bvRqNThOSwB+furcJmByBPZXvoub8NXFzxmQ/2dXljymLby/MfmD/YBDoZ57TSQmUKoNpmLTjhhJ+g763dviJXfQF2BSnAiUoHGPmEdVkhyj7dhPx4+Eu2ipptj5TeG4+F9tpD57NeNYwNyTn1aD43KEoaGWeqQkbHgg/58dgqiVirk7KDDug18PkZ4nk4VgEVm4HJ8n37AV9YQg1mXq9Zsm83IFqaVO2K0fl89zIS/d4yMy7k9C3Lq8fwUECLVLzH++aXoU+H27gVjVbMvZTqJBBFfs4jL9/egm/qubtLyzJt5iOCl79G8+dcNtTr1GaZD2f6QKIKf8J8OP8qBzaX7x3Kgj4qv1BKfK8mbKYZ8TEmdFCJQWktDjjWk6JnmsiXxSUNy4hJWk5DrlBS4csCvDIS3YdSlAtgS6ln4syau8qlPTD8SlE2kscQL0A8KjuqmnogZSG+IWluUViHLONFqZ/3W0kMUyy8usZUwQT+ZWdi1Fn7IEw9tCgdOJXf+14NlTL9zI1kL40h+apwRncSvLKmzyhg/8r5OhBESBDuxh/GjlQif0eOup0siX5TWk8PgkOzpIBL9EloRFIzSRK8iM77jNk4e4D2daZx8QkX9PxyGJXovGVjqmPQIiW4D+rQ06wb9iTQEj2+8UGNm1W8MusQZiohckl18Aq3ICsnHE7vRqU4Uf/CdxZ/sGLB1xgZVH7M8XeAP0KLKJlAmO0rl9LmdxoJhJ0GfbAmnoX1ATheEfMPHlQQU2iDnzsoTPuNJZ6o7q9CXmrWWaf+zrb5Uhep39gb5WfgC1gWegyS6zAcn7FhIdduYYhY6QuLpOgD2bsE9qnwaD7l9+BaNfGkIfgkOCbTnseZA0mQyLM/ctdWe8EZdVpch+Dja1dN3FkJImIqqI1BQgVAv+xZj1QHeDv4lUfaKvIbqgFA+SFuL4PlRRYgq9KZB"
`endif