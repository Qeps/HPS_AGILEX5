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

module compare_eq #(
    parameter WIDTH=10
) (
    input [WIDTH-1:0]  in_a,
    input [WIDTH-1:0]  in_b,
    output             equal
);

assign equal = (in_a==in_b);

endmodule 
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "p4G5aqSQ9TchkOY9hF0+pFF7DDJR0hvDqNS9CPueQc5md9wfv0hWMQ6pJcxo0Drzbe39osFaopgdkAYFALRbTXYBz12dtCWBppKRqwUV3L13u4YpnW9w3QXN3+gnL/OLJRYtIm4wrZqSo45BIXaGqXFjDAtVBNfWmrJr+t3hVbKcFL9vPkK+NVFoZy+6pA3YoPk6sKQg08FKNNhNkYHHSungXP+bIW8NoAlgT/WJsaP4PtswJiFziLR7gEjQktmVH5iZmJ9U5BqxxmL3/bS/iZrtFFXgvtVNXvTy4uy76ggxS7ORQQmBoASHLCKS91m/MMCsvOAY334Zzcv/9auSo7l/F4wiYejmbyR7t3Gwts48rAW4gC4hu4HoGIRx3kOmSFHbOaRMbUXJrXSd6/S6NJkyMG/pcDwBkTTOfqaYLvHtN7Yv/FSE2oPETgDgn9k1RCNAXH1j2y65V2qTV8TJenbiiA/pL6TGE9PlCvPsrzJRcolon4b8Zo55KnSr8yCnqGh6i+hiKQFDlUDqRkRasQCqlVQ9ZtQfiJgLUAQAjTm7ZnUXkBPRKerSTMgVfVwxk8Hm8h/sfXaXfP3/jNahcsuTv58io7L3NuuUH8o2x52C/2qA6Xf8B0+itiJmmD82QXEkVcaz78eIf5lCDf+SjEfIrrB+p/uilgmSMkTIVYeygYvL9ZMGtjq6CbF26FdJkKucVYxegFwQqCMdYeNADz4b8cS1HrqJvjSPI+x2C1HjYYO/6Fe3sjWigiGdGz7gOFD1XWBnSA8Io8LA0YyQy9zPMdCInTGB828IG8Awwx/oeZVC0+Sefei0yd2i6IBT6BSbF2DUuoyJsXtK8CB1qO0O7BJNFHv1k6QaEGoFNQAQrECiB7zz60/omnAPQBn3WkdGji43XnNolBkd/CkYNuFT7fJH/yk3l41oKviUfEw1rMh3S5MjdRmNFgHDX/EmlsgnZH8peGADUzpeHVaa3MaOofNjijEIdnMoroPwrZmprHBGzKIp3fwvmRE2ZT/y"
`endif