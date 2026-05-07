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




module emif_ph2_gen_ff_init_1 (
    input wire clk,
    input wire d,
    output reg q 
    );
    
    initial
        q <= 1'b1;
        
    always @(posedge clk)
        q <= d;
    
    
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJM54FRcvHjFo0XAe6W71a4vJs9E/38A3Sgkb+VAbf79hzMQKq/e9BbXYzHmo3OG9aGI7CAk+rbA2SwnzpuAmLk5Hy67ySDBLNEtvGLJZHlIFqJ3vuV02CyYEuR2KGj82mt61HXwAYzeHCeAl5pnB8PnDksxp5jooLzIywMDgu+UzcM1B5idxhX5r4SbxZnYSWbWmNFVxGWfnn6JDZr6nJ4R2C/2SSv+Ek9LOgpIWr6DMEGdvJo6Y1A6IaOLPg4HpcI4QlEJ9URXWlhOpTyklnxzYdQqHFm/8VqvyAsNjsu1erK0eT8LbdknSgzPXR4HJoYx2GbbxWAHV0zsGUQwQZ5Dem8hDjWmoCrZ1aPXpVj4wTYVVXu6al1NgwNgWUnqcs4s7OEcfaGL6WagMYjOBYKeSg2y4iKBC97l9QTbA+r8FOEt18rsrdCWh7aSvu+U/45xpCc/wNpwli71RvDXN2oEbwWcW04lb8lfooD1h59WFBXxXpbZi2xY2mJ36RnGDLv9yX72OjDciWUzBT/rR0TyDOgvlmuTU+lV9P6hNYNX2ZLr1wCW67O3vcpQxk1p9D6pp1d943Ov/xPgrBPkRz5aRnFvzl87qVp5TMBKC/AMj5yNGsoRTyDOPgVD76zuL0ceFFt8qiCs6Ymxl4XLIAAsA/kUJB9RKxIQDeXLh9Nf+tPfUjbxou1Xiy10oY2A9WHUwxkwiSbSGu8N7hRbZgGHh9uRkAIhcMLZhX8SZ4hug9NMpCeQmroXPgoSIYff+hakatkEQTXy7Q81rsev9pvj"
`endif