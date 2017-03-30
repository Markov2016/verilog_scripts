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
