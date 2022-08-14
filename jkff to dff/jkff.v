`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:48:43 08/14/2022 
// Design Name: 
// Module Name:    jkff 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module jkff(j, k, clk, rst, q);
    input j;
    input k;
    input clk;
    input rst;
	 output q;
	 
	 reg q;
	 
	 always @(posedge clk)
	 begin
	 
		 if(rst)
			q = 1'b0;
		 else
		 begin
			case({j,k})
				2'b00:q = q;
				2'b01:q = 1'b0;
				2'b10:q = 1'b1;
				2'b11:q = ~q;
			endcase
		 end
		 
	 end
	
endmodule
