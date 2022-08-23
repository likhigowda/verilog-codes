`timescale 1ns / 1ps
/*
	hwy	cntry
s0	green	red
s1	yellow	yellow
s2	red	green

*/
module traffic_controller(clk, rst, sensor, state);

input clk, rst, sensor;
output [1:0]state;

reg [1:0]state;
reg [1:0]present_state;
reg [1:0]next_state;

// constants
parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;

// initial values
initial
begin
	present_state <= s0;
	next_state <= s0;
end

always @(posedge clk)
begin
	if(rst)
		present_state <= s0;
	else
		present_state <= next_state;
end

always @(present_state)
begin
	state <= present_state;
end

always @(sensor or present_state)
begin
	if(sensor == 1)
	begin
		case(present_state)
			s0:next_state = s1;
			s1:next_state = s2;
			s2:next_state = s2;
		endcase
	end
	
	else
	begin
		case(present_state)
			s2:next_state = s1;
			s1:next_state = s0;
			s0:next_state = s0;
		endcase
	end
		
end

endmodule
	
	
		
	


