`timescale 1ns / 1ps

module stimulus_v;

// Inputs
reg clk;
reg rst;
reg sensor;

// Outputs
wire [1:0] state;

// Instantiate the Unit Under Test (UUT)
traffic_controller uut(clk, rst, sensor, state);

// set clock
initial clk = 0;
always #5 clk = ~clk;

// stimulus 
initial
begin
	$monitor($time, " reset = %d, sensor = %d, state = %d",rst,sensor,state);
	rst = 1;
	#10 rst = 0;
	#10 sensor = 1;
	#40 sensor = 0;
	#40 $finish;
end

endmodule
	
