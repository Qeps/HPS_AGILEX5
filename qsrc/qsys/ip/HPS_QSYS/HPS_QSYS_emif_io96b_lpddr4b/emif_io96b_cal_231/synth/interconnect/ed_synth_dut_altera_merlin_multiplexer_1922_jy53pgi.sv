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








// altera message_off 13448

`timescale 1 ns / 1 ns



module ed_synth_dut_altera_merlin_multiplexer_1922_jy53pgi
(
    input                       sink0_valid,
    input [440-1   : 0]  sink0_data,
    input [2-1: 0]  sink0_channel,
    input                       sink0_startofpacket,
    input                       sink0_endofpacket,
    output                      sink0_ready,


    output reg                  src_valid,
    output [440-1    : 0] src_data,
    output [2-1 : 0] src_channel,
    output                      src_startofpacket,
    output                      src_endofpacket,
    input                       src_ready,

    input clk,
    input reset
);
    localparam PAYLOAD_W        = 440 + 2 + 2;
    localparam NUM_INPUTS       = 1;
    localparam SHARE_COUNTER_W  = 1;
    localparam PIPELINE_ARB     = 1;
    localparam ST_DATA_W        = 440;
    localparam ST_CHANNEL_W     = 2;
    localparam PKT_TRANS_LOCK   = 324;
    localparam SYNC_RESET       = 0;

    assign	src_valid			=  sink0_valid;
    assign	src_data			=  sink0_data;
    assign	src_channel			=  sink0_channel;
    assign	src_startofpacket  	        =  sink0_startofpacket;
    assign	src_endofpacket		        =  sink0_endofpacket;
    assign	sink0_ready			=  src_ready;
endmodule


`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJOEuD5n3oxCoiqS7RhkP0RvTzjkz/bnrfnMA7g8xcbr6i3zZhdoo50K8+JgIHaFU3M7+pvrRz5BG1n92vrT4upcOIhvFR6HhfNDsafOAE39PmAj1k1lGbX026hM6bJleeBcbFgTyiZm5m6gHHYvpxxOCwvVWK2tJro7ZAR+L/mAds1zr4SUWlNrcFvGSv+PVyJP4gIclShnql7OVKxtUrWxmXcGrsMrD58j2yFcYWjSaIH+vtjUIN25AjX8P8z10x5CbYB9Po5CAyyWfQX8lNOTe+rbghAreM4gAOh3FauqsKW//N+Wm+AnsT2X2Jw/Vb5iNHtff9EDGYPxbT0IaFmpGUChHLne0kjkBUoy5y1i9pGCftv/ZHc9TizsKKhxBxjKXz+eLkdbI3a0U2/YfIvkKozxsQyebaIyeUXbT63QboUv5uVmnQKP0AUsOkhTf3r3/xMuJ5K1AAVhoZ4Y4hygml2Aac3sWQVPLXSczl+9yqcDd1njUpKxkLGP4j1Ar56tM2f7ptly+BW5T2IwNbEJVRfg6f+c3/wcgkLa0KuoaVY55MqPrvfozweuPHB42fm9VAnz9lP5fD3jvCbE7xHJozroyTUqTfnUAPIX5605/IXrlEm7Ydg2wDm7RaDV0vsyUOkxfLBD062W2n3xsu6SgIjc5hPLM8ZdXbNFFvj+XBCjzJKmdHTMebuHUBG+JzxlutOfs78MbfpEvqBxZuAoufD9cG6kP4G1dGtyEjddtsWkJ5xrFiqzXfcr9OrMeroaRZPGBltsGyAI7bCceG5F"
`endif