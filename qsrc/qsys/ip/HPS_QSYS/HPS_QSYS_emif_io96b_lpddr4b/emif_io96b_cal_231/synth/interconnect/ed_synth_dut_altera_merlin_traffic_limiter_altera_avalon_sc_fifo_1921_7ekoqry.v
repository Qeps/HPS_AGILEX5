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




`timescale 1 ps / 1 ps
module ed_synth_dut_altera_merlin_traffic_limiter_altera_avalon_sc_fifo_1921_7ekoqry #(
		parameter SYMBOLS_PER_BEAT    = 1,
		parameter BITS_PER_SYMBOL     = 4,
		parameter FIFO_DEPTH          = 6,
		parameter CHANNEL_WIDTH       = 0,
		parameter ERROR_WIDTH         = 0,
		parameter USE_PACKETS         = 0,
		parameter USE_FILL_LEVEL      = 0,
		parameter EMPTY_LATENCY       = 1,
		parameter USE_MEMORY_BLOCKS   = 0,
		parameter USE_STORE_FORWARD   = 0,
		parameter USE_ALMOST_FULL_IF  = 0,
		parameter USE_ALMOST_EMPTY_IF = 0,
		parameter EMPTY_WIDTH         = 1,
		parameter SYNC_RESET          = 0
	) (
		input  wire       clk,       
		input  wire       reset,     
		input  wire [3:0] in_data,   
		input  wire       in_valid,  
		output wire       in_ready,  
		output wire [3:0] out_data,  
		output wire       out_valid, 
		input  wire       out_ready  
	);

	generate
		if (EMPTY_WIDTH != 1)
		begin
		// synthesis translate_off
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
		//  synthesis translate_on
			instantiated_with_wrong_parameters_error_see_comment_above
					empty_width_check ( .error(1'b1) );
		end
		if (SYNC_RESET != 0)
		begin
		//  synthesis translate_off
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
		//  synthesis translate_on
			instantiated_with_wrong_parameters_error_see_comment_above
					sync_reset_check ( .error(1'b1) );
		end
	endgenerate

	ed_synth_dut_altera_avalon_sc_fifo_1931_fzgstwy #(
		.SYMBOLS_PER_BEAT    (SYMBOLS_PER_BEAT),
		.BITS_PER_SYMBOL     (BITS_PER_SYMBOL),
		.FIFO_DEPTH          (FIFO_DEPTH),
		.CHANNEL_WIDTH       (CHANNEL_WIDTH),
		.ERROR_WIDTH         (ERROR_WIDTH),
		.USE_PACKETS         (USE_PACKETS),
		.USE_FILL_LEVEL      (USE_FILL_LEVEL),
		.EMPTY_LATENCY       (EMPTY_LATENCY),
		.USE_MEMORY_BLOCKS   (USE_MEMORY_BLOCKS),
		.USE_STORE_FORWARD   (USE_STORE_FORWARD),
		.USE_ALMOST_FULL_IF  (USE_ALMOST_FULL_IF),
		.USE_ALMOST_EMPTY_IF (USE_ALMOST_EMPTY_IF),
		.EMPTY_WIDTH         (1),
		.SYNC_RESET          (0)
	) my_altera_avalon_sc_fifo_dest_id_fifo (
		.clk               (clk),                                  
		.reset             (reset),                                
		.in_data           (in_data),                              
		.in_valid          (in_valid),                             
		.in_ready          (in_ready),                             
		.out_data          (out_data),                             
		.out_valid         (out_valid),                            
		.out_ready         (out_ready),                            
		.csr_address       (2'b00),                                
		.csr_read          (1'b0),                                 
		.csr_write         (1'b0),                                 
		.csr_readdata      (),                                     
		.csr_writedata     (32'b00000000000000000000000000000000), 
		.almost_full_data  (),                                     
		.almost_empty_data (),                                     
		.in_startofpacket  (1'b0),                                 
		.in_endofpacket    (1'b0),                                 
		.out_startofpacket (),                                     
		.out_endofpacket   (),                                     
		.in_empty          (1'b0),                                 
		.out_empty         (),                                     
		.in_error          (1'b0),                                 
		.out_error         (),                                     
		.in_channel        (1'b0),                                 
		.out_channel       ()                                      
	);

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ehKyfygZ4Qfv9OnxuLLkHlFqZduXrOOOIRqFR8KbBMJTWy6QKog4DOsCxMtOsdBZIu4FykIc0geTmiGeiUgerwIydTtcYFmQfsbJgNr6qAJ8X/edNCa50Jfn+U80IjSiLs3CwUSXcR55Cp0HYFe1vmuHPmPy9o7n9DO7WvHCiyqCOpjtDKquQo/IFwJ4NputqZ/CwmwDJ69Subxr6F+7Ke7dlS1ZBTw5j7zkI1JEqJPO8UI5iYzZ1Ud5AIzwcM8g/n2nC2eN/73umkD8q8idVjnvZq787HyJnHhy353uUX9iV5D4FJVb60s5/76vn/nu1sPZFd1s2C4tQuT8beJmh1emf5oIewFUgrZKqIU3LoCuSDTH5dI4laZnYaTbaTV8v/sRVYwUXOGWXb13AYHel9AsVQkYiZmcvKdjW7SkPh9UpjUYIZjQI6FrcYlZBzxbZH4OuK9Kf+DbQmpvH70Afne3iw8npFoPG1+OqJ3RkxfYwGbDla2ARgF8TRn+U3XoSzSrBv6IrL698P4rwfknsxAPGH8Kl9VluHSpBoI6sVs0wMDeLs5XstqYPnlWUjeX4dsJ0ErH8JydgfpEcfOAbsMwOWb9ys+cLiZfYp223lzHnxRmjRpF3+w3+oD9SNnXzxWPIvf6qi6/JaybGk8DHfcW5+8pKyI1Qzln6EIjrotVpQS9FTemWssOUjaRVH8F7276Sh+jlQA2H5kG1GmGia8KF/RMb8l1BhYlgy55yc41r3VIy+a1/WK7+PwSa+tyaDWwdZFV1q0QoW7Y1mw6HEpTsNu6afIq+IXQ+7tM2LLchxFapM/DOhuiG/MFwm1fCWDAsEsrRmeiuzYIS9yzVRv8qefbKVwnMQKN1a9I/2fyDk9ro5O4hNi+Wv8LcC1KBaxOWSv3/aebRA224htZAUTVxO9v+9P2A7KljNy8u1193x6qkWLA1jn+20LkOna4CDQzkv4qhx/qOz7g6LpQZAjZ+r1m8xL8pBDasVH+Kpt3+XBAChQjIx91cC3cpGhw"
`endif