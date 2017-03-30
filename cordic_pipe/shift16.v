module shift16(in,out);
input [15:0] in;
output [15:0] out;

assign out[15:14] = 2'b0;
assign out[13:0] = in[14:1];
endmodule

