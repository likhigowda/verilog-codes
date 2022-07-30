// t flip flop
module tff(clk, rst, t, q);
input clk, rst, t;
output q;
reg q;

always @(negedge clk or posedge rst)    // posedge clk for downcount
begin
    if (rst == 1)
        q = 1'b0;
    else
    begin
        if (t == 1)
            q = ~q;
    end
end
endmodule

// 4 bit ripple carry counter
module rcc(clk, rst, q);
input clk, rst;
output [3:0]q;

parameter t = 1'b1;

tff q0(clk, rst, t, q[0]);
tff q1(q[0], rst, t, q[1]);
tff q2(q[1], rst, t, q[2]);
tff q3(q[2], rst, t, q[3]);


endmodule

// testbench for ripple carry counter
module rcc_test;
reg clk, rst;
wire [3:0]q;

rcc uut(clk, rst, q);

initial
begin
    $monitor("time = %g ; rst = %b ; count = %d",$time,rst,q);
    rst = 1'b1 ; clk = 1'b0;
    #10 rst = 1'b0;
    #180 $finish;
end

always #5 clk = ~clk;

endmodule


