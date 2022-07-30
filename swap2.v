// Swap using third variable
module swap3;
reg a = 1'b1;
reg b = 1'b0;
reg temp;

initial
begin
    temp = a;
    a = b;
    b = temp;
    $display("after swapping using third variable: a = %b, b = %b",a,b);
end
endmodule

// Swap without using thied variable
module swap2;
reg a = 1'b1;
reg b = 1'b0;

initial
begin
    a <= b;
    b <= a;
    #5 $display("after swapping without using third variable: a = %b, b = %b",a,b);
end
endmodule