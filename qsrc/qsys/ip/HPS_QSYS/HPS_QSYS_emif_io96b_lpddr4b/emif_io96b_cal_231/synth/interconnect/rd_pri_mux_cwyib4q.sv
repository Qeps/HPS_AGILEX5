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


module rd_pri_mux_cwyib4q (
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
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJMhVqAdv2fuvw2vBZ5qLR6beLrFYYm5XOWGbO50vx3JhnOW7ItccV3LnZ7nm7S8viFj2xjKco8iaqFB2UXjy5k7ojJB0NxTKcIj04+BlA87fYxmxLH1BgQ/dujdykGUx9opS1H0V2TQDUM9yyvMEpO9a36DaU0mOrkBKjia878kJWuQ7Yv+tgBOM09+wrrpUndHms7dJsXEZLjZuRZOnpevi0pgMy+LJRzYxQ8yYoi5Fu1BKZiXa7ToJ5EmEJLINjFbd5zNjg2EwLbYMN8qPG7Prv1BOCB3WgXMTe7xB1lkPL+4Z94chkHDE8sIqJLUSWbhX2ZQFcSySQdLryXuc64P1HewbnmS1MXaMNhs8HgsX5ODf9TUcqINwbp9hJ+UCvJSkkxJBhxdWy9MbMbXpGbt3+KJv7h6jzbUgfpCzgn3Ibk2T6WSUgAggmJBkWWICY0dojGNc4+l+f/1oHGVz7deiWhSUJHME+Q88h1Ie3Pvttv9m2fRLL0xIl7e25CUyAopAA3i8+doIkBqBYjAtA3XdLr8ldS50NVO3O+LfOODdBDlx4zWJKyCSuWbRJNhM+Ilh6RseHclxV6KkBV+Ngf6RHpRn1IZ6etAAp9Nbvbeleqx9gsrULfKzwuqocmqGSfsmSra8JwDGyUITJNa7KOH01VurCgxoXEKnnubF4v7HLfiXh2D/vBWMgQ09qhsbLMVAJNsgnzDlgqTNx2oQQmVs7LGjBjJPwcQhNipVuftAIk8MfNDWHyFRS8efxWnCj98IX3271cIvu8o7jZ7sn3N"
`endif