module adder4(add1,add2,carry_in,out,carry_out);
input [3:0] add1,add2;
input carry_in;
output [3:0] out;
output carry_out;
wire [3:0] carry;

wire [3:0] G,P;
assign G = add1 & add2;
assign P = add1 ^ add2;
assign out[0] = (add1[0] ^ add2[0]) ^ carry_in;
assign out[1] = (add1[1] ^ add2[1]) ^ carry[0];
assign out[2] = (add1[2] ^ add2[2]) ^ carry[1];
assign out[3] = (add1[3] ^ add2[3]) ^ carry[2];
assign carry[0]  = G[0] ^ (P[0] & carry_in);
assign carry[1]  = G[1] ^ (P[1] & G[0]) ^ (P[1] & P[0] & carry_in);
assign carry[2]  = G[2] ^ (P[2] & G[1]) ^ (P[2] & P[1] & G[0]) ^ (P[2] & P[1] & P[0] & carry_in);
assign carry_out = G[3] ^ (P[3] & G[2]) ^ (P[3] & P[2] & G[1]) ^ (P[3] & P[2] & P[1] & G[0]) ^ (P[3] & P[2] & P[1] & P[0] & carry_in);

endmodule