// verilog code

`define TRUE 1'b1
`define FALSE 1'b0

// delays
`define Y2RDELAY 3	// Yellow to red delay
`define R2GDELAY 2	//	Red to green delay

module sig_control(hwy, cntry, x, clock, clear);

input x, clock, clear;

output [1:0]hwy, cntry;	//2-bit output for 3 states of signal
reg [1:0]hwy, cntry;	//GREEN, YELLOW, RED;

parameter RED = 2'd0;
parameter YELLOW = 2'd1;
parameter GREEN = 2'd2;

// state definition	    // HWY		CNTRY
parameter s0 = 3'd0;	// GREEN	RED
parameter s1 = 3'd1;	// YELLOW	RED
parameter s2 = 3'd2;	// RED		RED
parameter s3 = 3'd3;	// RED		GREEN
parameter s4 = 3'd4;	// RED		YELLOW

// internal state variables
reg [2:0] state;
reg [2:0] next_state;

//state changes only at positive edge of clock
always @(posedge clock)
begin
	if(clear)
		state <= s0;
	else
		state <= next_state;
end
		
// Compute values of main signal and country signal
always @(state)
begin
	hwy = GREEN;	// Default Light Assignment for Highway light
	cntry = RED;	// Default Light Assignment for Country light
	case(state)
		s0: ;	// No change, use default
		s1: hwy = YELLOW;
		s2: hwy = RED;
		s3 : begin
    			hwy = RED;
    			cntry = GREEN;
			 end
		s4: begin
				hwy = RED;
				cntry = YELLOW;
			end
	endcase
end


// State machine using case statements
always @(state or x)
begin
	case(state)
		s0 : if(x)
				next_state = s1;
			  else
				next_state = s0;
					
		s1 : begin	// delay some positive edges of clock
				repeat(`Y2RDELAY) @(posedge clock);
				next_state = s2;
			  end
			  
		s2 : begin	// delay some positive edges of clock
				repeat(`R2GDELAY) @(posedge clock);
				next_state = s3;
			  end
			  
		s3 : if(x)
				next_state = s3;
			  else
				next_state = s4;
					
		s4 : begin	// delay some positive edges of clock
				repeat(`Y2RDELAY) @(posedge clock);
				next_state = s0;
			  end
			  
		default : next_state = s0;
	endcase
end

endmodule


// testbench
module stimulus;

wire [1:0]hwy, cntry;
reg x, clock, clear;

sig_control uut(hwy, cntry, x, clock, clear);

initial
    $monitor($time, " highway = %d, country = %d, car_on_cntry = %d",hwy, cntry, x);
    
// set up clock
initial
begin
    clock = `FALSE;
    forever #5 clock = ~clock;
end

// control clear signal (reset button)
initial
begin
    clear = `TRUE;
    repeat(5) @(negedge clock);
    clear = `FALSE;
end

// apply stimulus
initial
begin
    x = `FALSE;
    
    repeat(20) @(negedge clock); x = `TRUE;
    repeat(10) @(negedge clock); x = `FALSE;
    
    repeat(20) @(negedge clock); x = `TRUE;
    repeat(10) @(negedge clock); x = `FALSE;
    
    repeat(10) @(negedge clock); $finish;
end
endmodule
