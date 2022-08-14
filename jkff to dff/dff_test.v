`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:15:40 08/14/2022
// Design Name:   dff
// Module Name:   dff_test.v
// Project Name:  sample
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dff
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dff_test_v;

	// Inputs
	reg d;
	reg clk;
	reg rst;

	// Outputs
	wire q;

	// Instantiate the Unit Under Test (UUT)
	dff uut (
		.d(d), 
		.clk(clk), 
		.rst(rst), 
		.q(q)
	);

	initial begin
		// Initialize Inputs
		d = 0;
		clk = 0;
		rst = 1;
		
		#10 rst = 0;
		#10 d = 1;
		#10 d = 0;
		#20 $finish;

	end
	
	always #5 clk = ~clk;
      
endmodule

