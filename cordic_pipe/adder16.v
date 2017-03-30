module adder16(in1,in2,out,sign);
input [15:0]in1,in2;
input sign;
output [15:0] out;

wire [15:0] in2_;
assign in2_ = (sign)?~in2+1:in2;
assign out = in1+in2_;

endmodule 

