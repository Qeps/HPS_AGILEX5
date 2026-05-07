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

module rd_response_mem_cwyib4q #(
    parameter ST_DATA_W = 35,
    parameter ID_W      = 10,
    parameter PIPELINE_OUT = 0,
    parameter PIPELINE_CMP = 0
) ( 
    input                 clk,
    input                 rst,
    input                 in_valid,
    input [ST_DATA_W-1:0] in_data,
    output                in_ready,
    output logic          out_valid,
    output[ST_DATA_W-1:0] out_data,
    input                 out_ready,
    output                cmd_valid,
    output [ID_W-1:0]     cmd_id,
    input                 cmd_ready,
    input                 rsp_valid,
    input [ID_W-1:0]      rsp_id,
    output logic          rsp_ready    
);

localparam PIPELINE_CNT = PIPELINE_OUT + PIPELINE_CMP ;


	  localparam [4:0] depth = 1;
	  localparam [4:0] depth_index = 1;


logic [ST_DATA_W:0] dout0;
logic [1-1:0] sel_index;
logic [1-1 :0] demuxed,demuxed_valid;
logic ready_out_mem;
logic [1 -1 :0] shift_occurred;

rd_sipo_plus_cwyib4q #(
    .TOTAL_W (ST_DATA_W+1),
    .ID_W    (ID_W) 
) mem (
    .clk             (clk),
    .rst             (rst),
    .in_valid        (in_valid  & cmd_ready),
    .in_data         (in_data),
    .in_ready       (ready_out_mem),
    .clr             (demuxed_valid), 
    .shift_occurred  (shift_occurred),
    .dout0           (dout0)
);


rd_comp_sel_cwyib4q #(
    .PIPELINE_OUT(PIPELINE_OUT),
    .PIPELINE_CMP(PIPELINE_CMP),
    .WIDTH       (ID_W)
) comp_sel (
    .clk            (clk),
    .in_0           ({dout0[ST_DATA_W],dout0[ID_W-1:0]}),
    .base           (rsp_id),
    .shift_occurred (shift_occurred),
    .sel            (),
    .sel_index      (sel_index),
    .clr            (demuxed_valid)
);

rd_demux_cwyib4q demux ( .index(sel_index), .demuxed(demuxed)  );

generate 
genvar i;
    for (i=0;i<1;i++) begin : MY_LABEL_0
        assign demuxed_valid[i] = demuxed[i] & rsp_valid & rsp_ready;
    end
endgenerate 
rd_mux_cwyib4q #(
    .DATA_W(ST_DATA_W)
) mux (
    .index (sel_index),
    .in0           (dout0[ST_DATA_W-1:0]),
    .muxed (out_data)
);

assign in_ready = ready_out_mem;
generate 
    if (PIPELINE_CMP==1) begin : PPL_1
        always @ (posedge clk) begin
            out_valid <= rsp_valid;
            rsp_ready    <= out_ready;
        end
    end
    else begin : PPL_0
        assign out_valid = rsp_valid;
        assign rsp_ready    = out_ready;
    end
endgenerate


assign cmd_valid = in_valid & in_ready;
assign cmd_id    = in_data[ID_W-1:0];

endmodule

module rd_demux_cwyib4q (
    input  [1-1:0] index,
    output [1 -1 :0] demuxed
);

generate 
genvar i;
    for (i=0;i<1;i++) begin : MY_LABEL_1
        assign demuxed[i] = (i==index);
    end
endgenerate
endmodule


module rd_mux_cwyib4q #(
    parameter DATA_W = 10
) (
    input [1-1:0] index,

    input  [DATA_W-1:0] in0,

    output logic [DATA_W-1:0] muxed
);
  
always @ * 
    case (index)
     default : muxed = in0;

    endcase

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJMxR+NjE5ivPlY0zlX51n5EoJjPgqR2S2ZsFuOMmQDftP0g5GD5hT29Z1jc+/NKAozY1ebCwz7y1se5p86IKIdgefBeKQ0gDDNHgI73AdqOIEk1FAmMAbqIs4xTcYEYd/5WY3NBaiHFR/4uv6SvBXkLjDnGxDMO3v3NAF5Lz8f+xv6NThCD8JycYiRkPCJ18J2QV77MNbpMawbvB1pzr7c0lpVgKOjxDn59/smF0W2aFz9D79pYKF3yUgRyj2MFkIsH9pmj421QZzgTcSNk/EEv0VWvf7ok2weEe5aU6sP5cT4g51chafQODnIzb5ny4JJrnK76dAg5I2pw9lDKdMcHwtHEnYcd+cSt7iGzPDxxS+nyZYVHUEwLb/8rQpB0U466O7cESU6o+SIbT8L7xIDvwbftA0gu7QvtCqsoGLbLghHKY3ttKBWeNT5tVn1Q9a5IiRQW0RygIUd3LHvQVqVuRPnWlTtavks9+DgYOO4N5w4POr761w3demhkCM6+j76n55Ug9R8B8v+vNkrRwVom2jrsN57n/iGfu4amNazU8oivz7PTZMNJpFKCyGP63PdOtc6KKacHbRW6dDezlqs1bQW81SZTxFTgJXNrTx3X2p8+n/51ySqpzhsq4vGJCkgcrOmJ+IAmPJarXYm+rGxXe49aiIC6w4HzP/EH7AnwPO+CYb9X1+CzYX6s9YR1A4Sps842LELpYDJb4sDYOdPTV1fw8kttcNLhn2/tK0el9k9ePKsiucgBOpyDvSDAmiqikx/oD9sLTieWvzda3PhW"
`endif