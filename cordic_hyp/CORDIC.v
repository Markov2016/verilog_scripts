module CORDIC(clk,reset,XM,YM,XR,YR,index_cor0,
	X,Y,index_qua_,trans_in,trans_out);

input clk,reset,trans_in;
input [15:0] XM,YM,XR,YR;
input [9:0] index_cor0;

wire [9:0] index_cor1,index_cor2,index_cor3,index_cor4,index_cor5,index_cor6,index_cor7;

wire [15:0] XM1,XM2,XM3,XM4,XM5,XM6;
wire [15:0] YM1,YM2,YM3,YM4,YM5,YM6;
wire [15:0] XR1,XR2,XR3,XR4,XR5,XR6,XR7;
wire [15:0] YR1,YR2,YR3,YR4,YR5,YR6,YR7;

wire [5:0] trans_inside;

output [15:0] X,Y;
output [2:0] index_qua_;
output trans_out;

assign index_qua_ = index_cor7[9:7];

CORDIC_CELL c0(clk,reset,XM ,YM ,XR ,YR ,XM1,YM1,XR1,YR1,index_cor0,index_cor1,trans_in       ,trans_inside[0],3'b110);
CORDIC_CELL c1(clk,reset,XM1,YM1,XR1,YR1,XM2,YM2,XR2,YR2,index_cor1,index_cor2,trans_inside[0],trans_inside[1],3'b101);
CORDIC_CELL c2(clk,reset,XM2,YM2,XR2,YR2,XM3,YM3,XR3,YR3,index_cor2,index_cor3,trans_inside[1],trans_inside[2],3'b100);
CORDIC_CELL c3(clk,reset,XM3,YM3,XR3,YR3,XM4,YM4,XR4,YR4,index_cor3,index_cor4,trans_inside[2],trans_inside[3],3'b011);
CORDIC_CELL c4(clk,reset,XM4,YM4,XR4,YR4,XM5,YM5,XR5,YR5,index_cor4,index_cor5,trans_inside[3],trans_inside[4],3'b010);
CORDIC_CELL c5(clk,reset,XM5,YM5,XR5,YR5,XM6,YM6,XR6,YR6,index_cor5,index_cor6,trans_inside[4],trans_inside[5],3'b001);
CORDIC_CELL c6(clk,reset,XM6,YM6,XR6,YR6,X  ,Y  ,XR7,YR7,index_cor6,index_cor7,trans_inside[5],trans_out      ,3'b000);

endmodule

module CORDIC_CELL(clk,reset,XM,YM,XR,YR,XM_,YM_,XR_,YR_,index_cor,index_cor_,wen_in,wen_out,count);

input [15:0] XM,YM,XR,YR;
input clk,reset,wen_in;
input [9:0] index_cor;
input [2:0] count;
output [15:0] XM_,YM_,XR_,YR_;
output [9:0] index_cor_;
output wen_out;

wire sign;
assign sign = index_cor[count];

wire [15:0] XM__,YM__,XR__,YR__;

shift16 sh1(XR,XR__);shift16 sh2(YR,YR__);
adder16 a1(XM,YR,XM__,sign);
adder16 a2(YM,XR,YM__,~sign);

D_trigger1  tw0(clk,1'b1,wen_in,wen_out);
D_trigger10 ti0(clk,reset,index_cor,index_cor_);
D_trigger16 txm(clk,reset,XM__,XM_);
D_trigger16 tym(clk,reset,YM__,YM_);
D_trigger16 txr(clk,reset,XR__,XR_);
D_trigger16 tyr(clk,reset,YR__,YR_);
  
endmodule

