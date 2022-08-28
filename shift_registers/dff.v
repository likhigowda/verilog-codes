`timescale 1ns / 1ps

module dff(clk, rst, d, q);

input clk, rst, d;
output q;
reg q;

always @(posedge clk)
begin
	if(rst)
		q <= 1'b0;
	else
		q <= d;
end

endmodule
