`timescale 1ns / 1ps

module fifo_stimulus_v;

// Inputs
reg clk;
reg rst;
reg [7:0] buf_in;
reg wr_en;
reg rd_en;

// Outputs
wire [7:0] buf_out;
wire buf_empty;
wire buf_full;
wire [6:0] fifo_counter;

// Instantiate the Unit Under Test (UUT)
fifo uut(clk, rst, buf_in, buf_out, wr_en, rd_en, buf_empty, buf_full, fifo_counter);

// to set clock
initial clk = 0;
always #5 clk = ~clk;

// stimulus
initial
begin
	$monitor($time, " rst = %d, buf_in = %d, wr_en = %d, rd_en = %d, buf_out = %d, fifo_counter = %d",rst,buf_in,wr_en,rd_en,buf_out,fifo_counter);
	rst = 0;
	wr_en = 0;
	rd_en = 0;
	
	#5 rst = 1;
	#10 rst = 0; wr_en = 1;
	#10 buf_in = 18;
	#10 buf_in = 9;
	#10 buf_in = 20; rd_en = 1;
	#10 buf_in = 40;
	#10 buf_in = 64;
	#60 $finish;
end

endmodule
	
	
	


	
