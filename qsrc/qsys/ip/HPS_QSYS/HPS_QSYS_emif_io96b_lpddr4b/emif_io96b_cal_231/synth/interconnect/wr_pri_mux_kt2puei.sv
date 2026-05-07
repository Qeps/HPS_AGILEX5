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


module wr_pri_mux_kt2puei (
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
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJM2Gdc7xSHBzAHHKjMzGrADrVR+bb2u9BbzQs3opkcynEHg7t41ZqhP+fFCl6pS0rCmFxn2SiINdBQbb7JjKRoG+9nsf9llpwjpIB3XimxzQ7SpQm6DJSLPTLXxSHBmF4/xtkpD4NBWBWx6CwwwmGN3/U2vFrk6bUltlpaScZU3FANaVuG5FBp14z0WY+vEXzT3oMlzVGQ0GaA290+S76VGwNp/jlbGhjzg/DviD2NFwVuWuZHRQ6VboudnChy+PWj6V8MfprOZrixp/B7t/w6GxUwMhs5KG0uBPuGX/HKw+kaXKx7jn57tH7S3d+yv+GNbL3NUj0KgWMgrk3znd0Ojo40eavkuJTjTmIPFo320A8VqaFF46EVdJSyMmQheO/KWO5YvAcnHCQxPVwSVAjkWMiOvtmHgK5Kv0tCM1cbzAiuNKyXXz6mz5P4Ew0aCR0A0WSPjhaFV3k/kLVuGj5FRNtFIvvUxdPLYAPBbfjhETHoF7ZVpHUOTWD85MdtAIIhLht2ggqPbCEf8dCkiP8bUZocZf6X9GmF2U8bgNFeqUTUrElAcrOaP2dSIszJKOYAqNz5hEZcWYKHESucdolq02dtAgixEx8yvgc3zK3hYCfm2J8rJRQ2SpMNLDlh9e8L6S7NTWxpBDG9lmdhUI80ZVdwssgKoo5Nzh0jYpP1MC/M3+H/cXhvKBUnSEzgbJoTX5A3DBDlyNC6khYDVXUh65cXecEQM+Y+MSZcoz4PJYNhkoHl3OQWYbBR2aRgSV13aEbVZRlEBp281xWYRWp8b"
`endif