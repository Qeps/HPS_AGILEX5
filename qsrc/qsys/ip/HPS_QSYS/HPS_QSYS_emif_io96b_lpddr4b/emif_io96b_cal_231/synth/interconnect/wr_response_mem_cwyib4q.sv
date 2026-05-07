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

module wr_response_mem_cwyib4q #(
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

wr_sipo_plus_cwyib4q #(
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


wr_comp_sel_cwyib4q #(
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

wr_demux_cwyib4q demux ( .index(sel_index), .demuxed(demuxed)  );

generate 
genvar i;
    for (i=0;i<1;i++) begin : MY_LABEL_0
        assign demuxed_valid[i] = demuxed[i] & rsp_valid & rsp_ready;
    end
endgenerate 
wr_mux_cwyib4q #(
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

module wr_demux_cwyib4q (
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


module wr_mux_cwyib4q #(
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
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJOFLzq68/N4HBSdUgqdfU0qi+ZD1EET+Fx4tqE4fn5uI/ol1XUCFTwXKJlEXz5FdWQ8G5zFquJQ3j1KLt+s0eW3Im4m/KcB5F9H4Uyo7ZnkzWcUGz07S/Z6mT75+D9IlzT0qmPFL51+Bj8u5Xkdq6F8y1xtCAu1KGn6WV93cWtbxxzbASF7z+JTGi/W648Y4ZgYB6oeaiYj0WyUcJMHLBbaQyuKZlqcaQieWXNB5tHne41X7l7LCrwphGdNSpKEhDlvaPj+ft0DSM5B1T48y7f03As0+uCpUY85/D4Tf4h5PnLWZFPW/RUbqBXTruMuhYHl0pC7VdGAe8JH66zvmsQHlfGCiWTBf4YauZ3sziaEs2zftDX7MBrJQB7t2GMXdzzVTIJ0KkYoL8Eb4qcWOBOZJH7EJqNuxWCz5stk1ADC02XhmyYo5FCBIxlhUjJm8XiD1yT2hkVu5o8L2YG86MKUSI49pRQKZdrtaLyMxAN43CiwtMkD2HtOa1GQfSDdKA8l4kxRX3wE0xtykGfT83oBwrRQZidg7VtJEHMAeInNv96gRNbZkMTIYfP6SBFsNXcRMnZzWDUTMj5BZc1GAf2NTcMaAlojQ4u05GdSdf5Jvy40s/vFd7n8lt3xTw2K38lMC6kMo+0HKPLLzZ+VFKJy5O2eOJPkuk3GQXi/2BSoIjxfJ8hOrIPF5zw9QksqgISMII8woK/L24HJsarZHHJ6Mpeju2Bu8/ssYglC32h94YbYZMKQa4z97fMMi4aB4ZnKeZqOjtgUtpyae0+WtPJ2"
`endif