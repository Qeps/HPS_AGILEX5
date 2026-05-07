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


module rd_pri_mux_kt2puei (
input in0,
input [1-1:0] clr, 
input [1-1:0] shift_index_out, 
output logic sel,
output logic [1-1:0] sel_index
);

always @ * begin
    if (in0 && !clr[0]) begin
        sel = in0;
        sel_index=0;
    end
end

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJNMWGLl3aXVm6A0aODUn1cyEycBk3aUI8rxYVlWGyKQwXWTb83byuSr4avNPX2Y1w6gINtKHQQ1ti4W9k0y6Sq04fZbEMj8e5BMC8ejXsPSzXY2hFHjpY08elMm6bS54nB0QH0BGsdNEHYSFDqOurM8qkStEk/xJAkZcQu+Q6z+iO8FruPSdbsvpm686Ax2XrLovrDNa6OsVHFVuWHrDUZTG1pgIOgs60qIVkOavO6bl0eRNxcNiQ1qG9R7itbJcPrrtE9v6BpQNzsMVOJy/cMd5tdiKZpXYwyUX2GTTiEzQo0X3AYEHmVMrGFpD2pszrT9vtTbM3Thh3EjyvKDEBO4J446uxEnez08hxdBV8wYlJocqW84zaqaODLPeaO02oKtCpt0xhGfH4TuidntIuUtnMQVjPRIeu8fSDcvi98624SuLDUaW9OD3EtrMIatbpR2d1MZqH6mq/7foUxYE4Q9cqs5J4x5bhhYqj/Zd8mgxw3EffvQjb4WJIpLNOgdsib6fTiDriVixxvoIiYOhCv1hme8JqenMLFmHwyUWqRofktDP4CmtJQkasX3+NLpMsq8L4gR5SHLMnNaYQSIQyhqj3QjGtAB6NvnlHbhhasvgXYzdxaALnVeOXJIT5vP17AG4zbZCK97WD+7CLI6Ax+wwuGompuPiuIegDZ8xtZNYkpNbfWu2OABbi2gVTeubzRTxl/YsQwJs3fZQ2IsG3Pwmz6BrYHDdVeR8JKEAx0BXaQG9mIg+l00VtTJysrZoMOQhOiG0efZnylbZsn/Knl8"
`endif