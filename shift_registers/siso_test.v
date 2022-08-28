`timescale 1ns / 1ps

module siso_test_v;

// Inputs
reg clk;
reg rst;
reg inp;

// Outputs
wire q;

// Instantiate the Unit Under Test (UUT)
siso uut(clk, rst, inp, q);

initial clk = 1'b0;
always #5 clk = ~clk;

initial
begin
	$monitor($time, " rst = %b, inp = %b, q = %b",rst,inp,q);
	rst = 1'b1;
	inp = 1'b1;
	
	#10 rst = 1'b0;
	#50 $finish;
end

endmodule

	

