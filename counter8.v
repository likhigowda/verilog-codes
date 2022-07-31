// 00 to FF up & down counter
module counter8(clk, rst, m, q);
input clk, rst, m;
output [7:0]q;
reg [7:0]q;

always @(posedge clk or posedge rst)
begin
    if(rst)
        q = 8'h00;
    else
    begin
        if(m == 1)
            q = q + 1'b1;
        else
            q = q - 1'b1;
    end
end
endmodule

// testbench
module counter8_test;
reg clk, rst, m;
wire [7:0]q;

counter8 uut(clk, rst, m, q);

initial
begin
    $monitor("time = %g ; rst = %b ; m = %b ; count = %d",$time,rst,m,q);
    rst = 1'b1;
    clk = 1'b0;
    m = 1'b1;
    #10 rst = 1'b0;
    #100 m = 1'b0;
    #300 rst = 1'b1;
    #305 rst = 1'b0; m = 1'b1;
    #350 $finish;
end

always #5 clk = ~clk;
endmodule
            