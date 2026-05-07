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


module wr_pri_mux_cwyib4q (
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
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJPENSnhBdEaJUxjCTCS2Ao1Matp050LIaF+1PO09ngYuXg6+nZWcQQZb3ugQ+mzUiJQEtKDB5N7R13EUO32agcAQxR/o2zEOlwbXSuq5P0+taPda6eiGhZSsJJnSvJjKUgAEej+bXrkjwTn5B+d2r6IY+a1+d8l6mO8rYoSgW0rJNa7UyWEylA6WVnRu5zvrCOUhB/HB65ZSxoMFCKE5yz0Uca2uIO2RVLypJxrgxZIhXoEB23peQhKj5qOlUH0KGwRMZR1CC7BkK7EMX2xYpRFVY7apFRVVfurTNqevRz9bC4dTozR+IQoJbFuHSw42oZJZ1QtZL4uYTrrOwlUyGNf14noTwtarEXWmRCm0hZjgh3DwIRmTh5jiIAWT9eBlbuOLu34a3pPljErA+Bvu8PcfV/9lQbEXSkSkipkrScB8bWRzmSBFOP0rrSyCN1utjZ/1mLDMXD6Ckw0RvetYosMZ0GqR51Jg7uw7STv/3okOZKhQt40EOSEFR9pj2xB9tbOD/ADFpTj7Jas5wxk4YEUOevi73H359y6yBNkcHWxeJnavyWQw54DrOSJ/D3UAT6EFAYuuDhFIhdCQU4MbpAcHXmTNvvZ6gZsSWHjMbhwdBVpe0R5wl832dfUhu64a5APFGGxPHGkcEkgJkL7zgYL2D4fryE2srmqPWBplhwtC6dk8LUwTvMxQkXG6JejkoGnAQbR9O0nx2UvyApw5ywOt0DKTumiIl+FiPsSQYQ9iHALbQxx7Of7UAH3YHudgs6vfOrtvNPHi/qKAZQxQbA2"
`endif