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


module ff_macro_p2c # (
 parameter DATA_WIDTH = 256,
 parameter NUM_FLOPS = 1 // based on number of flops you need in 1 dir 
 ) (
 input logic clk,

 input [DATA_WIDTH -1:0] in_data ,

 output [DATA_WIDTH -1:0] out_data

);


 (* altera_attribute = {"-name FORCE_HYPER_REGISTER_FOR_PERIPHERY_CORE_TRANSFER ON"} *)
    reg [DATA_WIDTH-1:0] in_data_reg [NUM_FLOPS:0];    

    assign in_data_reg[0] = in_data;


    genvar i;
    
    generate 
    for (i=0 ; i<NUM_FLOPS ; i=i+1 ) begin : hps_p2c_ff
      always @(posedge clk) begin
          in_data_reg[i+1] <= in_data_reg[i];
      end
    end
    endgenerate

    assign out_data = in_data_reg[NUM_FLOPS];



    
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "wa4P/9mz5QzJaCbKgT7JOJw4FVjuprs8A5RwJjfxAxxciUOWXJIn+FtPapWtMIjHamBsUWdV2bvRqNThOSwB+furcJmByBPZXvoub8NXFzxmQ/2dXljymLby/MfmD/YBDoZ57TSQmUKoNpmLTjhhJ+g763dviJXfQF2BSnAiUoHGPmEdVkhyj7dhPx4+Eu2ipptj5TeG4+F9tpD57NeNYwNyTn1aD43KEoaGWeqQkbG5Q5FvyzSeudawTmE0Mwe4Npv9h9T4PBo7YJ0Whd1Ktg0dcmax4zfM+vjLoeBa6NoQU8AK6dFIpjqPgOG8GpnIFqcGXqsRkRIi+kfFwH5TNRRhdNZIpxw5Ua66EGNtLzWur5qSE+56OWhbQY1VfC99oRxq74O+s5NQ1GGM9o/1y3GEpJJpN2CkE460LxVunEARYbXalgeG4kkoJhjia4g8n+19V74HwHuwkSHEoSGmkHSaUn73NIyx67R3cO/Rjj593VZ+VDzs7+xbRD4tklCYLHK7fwnfC03gHz6Mp1a7PmQ5JbGmdl316eaOfNi9FlTfUX+cvcu4UMRJQ6AU05zrbcUy2UzGE7ljbJCx7fQU1BnIYJIv1qsoKkRpF0zMKyVP0UUgH5GrHkUo5dLN3SkF+XkKvFmzZDCiE8RkQttsVQsWlstpm5gUG2WunbG2tk8G/PkNIOjtYStA9fgwIfWs/VLng8PS6qLggaKfWTlI2otRc4bxkIbr0YGcenGcFtq9Zp8vn3BiWmveAnL8b5s2Dn/UWCtBEEwZC91yMNKrAd6iV+FzQoPlVe9Hx/07G8vcvtrpfyRot9UXEENOi35AXJx0yF53n+ttSapGyn3VRNJQJ4IZPwQAS7FcxyAQ6AVkRqC+vY6fEW3orqQDd1NxXI9Kx+T/YcpPakxCmAd2il3hAaXb4K3MYqfRC7IriGSR/VJeivhzCJYAOPZr8KsH3zGBSnQprfnKcaBtKHeTyIgWP9V+xcyeRWy1GhjnEz8B1a28jsLnQ+EATYl0rVGi"
`endif