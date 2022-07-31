// synchronus bcd counter
module bcd(clk, rst, q);
input clk, rst;
output [3:0]q;
reg [3:0]q;

always @(posedge clk or posedge rst)
begin
    if(rst)
        q = 4'b0000;
    else
    begin
        if(q == 4'b1001)
            q = 4'b0000;
        else
            q = q + 1'b1;
     end   
        
end
endmodule

// testbench
module bcd_test;
reg clk, rst;
wire [3:0]q;

bcd uut(clk, rst, q);
initial
begin
    $monitor("time = %g ; rst = %b ; count = %d",$time,rst,q);
    rst = 1'b1;
    clk = 1'b0;
    #10 rst = 1'b0;
    #150 $finish;
end

always #5 clk = ~clk;

endmodule