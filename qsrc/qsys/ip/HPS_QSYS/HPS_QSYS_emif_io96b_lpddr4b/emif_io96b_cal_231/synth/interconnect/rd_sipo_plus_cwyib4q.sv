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




`timescale 1ps/1ps

module rd_sipo_plus_cwyib4q #(
    parameter DEPTH = 1, 
    parameter TOTAL_W = 35,
    parameter ID_W    =10
) (
    input clk,
    input rst,
    input in_valid,
    input [TOTAL_W-2:0] in_data, 
    output in_ready,
    input [DEPTH-1:0] clr, 
    output [DEPTH-1:0] shift_occurred, 
    output [TOTAL_W-1:0] dout0

);

logic [TOTAL_W-1:0] mem[DEPTH-1:0];




logic shift_in;



assign shift_in  = in_ready & in_valid;




always @ (posedge clk) begin
    if (shift_in)
        mem[1-1][TOTAL_W-2:0] <= in_data[TOTAL_W-2:0];

end

always @ (posedge clk) begin

    if (rst)
        mem[0][TOTAL_W-1] <= 0;
    else if (shift_in)
        mem[0][TOTAL_W-1] <= 1 & (! clr[0]);
    else if (clr[0])
        mem[0][TOTAL_W-1] <= 0;

end

assign in_ready = !(  mem[0][TOTAL_W-1]  );

assign dout0 = mem[0];

endmodule
    


`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJOb4awNd9JppWb8j3Oy2FvRS4YIYmlKRCdgr7YfNRIOU1kgWpVsYrTS8dg/gOg+hEGilOK5fbz2hOSZZwjqTAOHrMkniULAMismBw28yykVWB4oQE0rJHXtyzs2lMQ/n9Z/r5EfwlaFwQJntcCXZKXP1Q+ivrAN+LG7XH92YSF7iFB5YQti3u2A+bKZurdSDfw63AIBqC8YRdxc5WTl5BLfyxUPUYKle8EIvXain24RfRqh22L7lebuz6RHseC0GLHNuMBTJH4F7x1BlaNbHuqth2sJzOzJhIj7hhFb1j3OWgp/PmH7YR3pVGDLdOdh/gGOeUXROyOQfTG402fuhJtUDG/95LHj0wqKMs6H9mxLNUU6SA0EULWQ+SYrNbrMveG9HfT2MqBYncV74yCWuOuD5Mvzgg8zNVb6U1X3GGqxmx9fphuceEWef1CvvH5hydOARua81FTcLq8uUxMRWicdqv900gipt4MxFLNdnK6IGx4nou8nVo8AopXhoLigvXVTUpWHDY7Ur1n8NhUZfdwwXGf7R3GZNS8pHhXsBBPDfcO9+xxNUipq673sqDw6IGI/P38OdULu14PPpypzWjuva9R/h/UGVXINn3+4X3I0g4smJlT6hj3MGT1LvTwo6iTviKyS9KtCNOpQbUdrGQ7ypPn/c2Q+/6AnV5YNzymSSaK+5CgbYKLD4sC0Y3o/LJ8Udjp4tQMpVqf9URpudJmug/dDIEuMzzzioy8qq8/hcDXMy0zOqBFU1ZjzWNL6MJZjW+NAE3gCqmKn6Br6ZNMs"
`endif