module adder4(add1,add2,carry_in,sum,carry_out);
input [3:0] add1,add2;
input carry_in;
output [3:0] sum;
output carry_out;

assign {carry_out,sum} = add1+add2+carry_in;

endmodule
