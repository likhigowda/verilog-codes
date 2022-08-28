`timescale 1ns / 1ps

module siso(clk, rst, inp, q);

input clk, rst, inp;
output q;
wire w1, w2, w3;

dff u1(clk, rst, inp, w1);
dff u2(clk, rst, w1, w2);
dff u3(clk, rst, w2, w3);
dff u4(clk, rst, w3, q);


endmodule
