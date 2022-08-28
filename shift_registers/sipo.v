`timescale 1ns / 1ps

module sipo(clk, rst, inp, q);

input clk, rst, inp;
output [3:0]q;

dff u1(clk, rst, inp, q[0]);
dff u2(clk, rst, q[0], q[1]);
dff u3(clk, rst, q[1], q[2]);
dff u4(clk, rst, q[2], q[3]);

endmodule
