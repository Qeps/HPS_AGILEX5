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


// a generic clock divider to be used in simulation
module clk_div #(
  parameter RATIO = 2
) (
  input wire clk_input,
  output wire clk_output
);
  localparam WIDTH = $clog2(RATIO);
  logic [WIDTH-1:0] r_reg;

  initial r_reg = 0;

  always @(posedge clk_input)
    r_reg <= r_reg + 1;

  assign clk_output = r_reg[WIDTH-1];
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJOXrdr9GYffBU24LdNtG7ZhaVImgkXROGBTeSssOPkB68f0onrSYVVV26F+MtZtV2hkMFQV5CIQr7X7sZU3sdWWJAIs+Jvi6vsNs6HMJaU904enzvYHOVhApyT/onGtx6dx4eLhF/EPRLdwv1r78RGFsRSPrG7jYKhxicLzV/YpRxTxcz6wTEDF3ky5K/EoB2qryVyI27IWaVxmPCdlFEdBGpvJxffHSFMVPIjni39pAEKVQ33iCeTQOoziGCuT6S3ehUaoqe9f8q3yGYpdQW4lNqL02fI8hRtf7E0ucKUqzAV0Ye/HLgirsaNXX979vZ3wO8ukmyj5rpTZaWRRaz8spbeIbJVjG9NbcYqFTrl5Hsq6Ruz0F4tRYt+i9ZL3DYSeNZzA5PItXGqOYibRbMlLaUcQ1E+adKOmOmnuST+Jh+VXhg0D/+o5aNO2ECF45v+0211a66diSv1sFvbpFDnT7PT51bx6rO6xfRsp1w2zVyDp0wVokmGGmSo+ni+NJxwYCmCyyKF2mBsTPxbko5B/l0iq6KTRyv+2jj+g/6sRVamrR3IiThnf1+I4oSboAymAX+/dFz1LL076APB6BptOA0YfHi7k0Q1pxA9hk6V9HupIkIrJ+wZC7CLvXDt+nI3RcbHBeV45vgP9u1QBmH/dxCHcEbwrfi3bv+QajSzVcmHBiWbMAjD8IzjtULBTxcRDl2WPt29ASgGIkiLt9t+BxGIG6Ic5TxOi6QtkGF24jcGfhJAxadzFazOYdIn4OQETha37/2VWzCv+LNzHhr1U"
`endif