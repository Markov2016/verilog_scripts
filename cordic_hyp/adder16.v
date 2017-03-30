module adder16(in1,in2,out,sign);
input [15:0]in1,in2;
input sign;
output [15:0] out;

wire [15:0] in2_;
wire [15:0] temp1;assign temp1 = in1 + (~in2) + 1;
wire [15:0] temp2;assign temp2 = in1 + in2;
assign out = (sign)?temp1:temp2;

endmodule 

