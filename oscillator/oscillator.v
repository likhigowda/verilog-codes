/*
Declare a register called oscillate. Initialize it to 0 and make it toggle every 30
time units. Do not use always statement (Hint: Use the forever loop).
*/

// verilog code
module oscillator();
reg q;

initial
    q = 1'b0;
    
initial
    $monitor($time, " q = %b",q);

initial
begin
    forever
    begin
        #30 q = ~q;
    end
end
endmodule


// testbench
module stimulus;

oscillator uut();

initial
begin
    #500 $finish;
end

endmodule



        
        