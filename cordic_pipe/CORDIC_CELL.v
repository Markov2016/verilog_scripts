module CORDIC_CELL(clk,reset,XM,YM,XR,YR,XM_,YM_,XR_,YR_,index_cor,index_cor_,count);
input [15:0] XM,YM,XR,YR;
input clk,reset;
input [10:0] index_cor;
input [2:0] count;
output [15:0] XM_,YM_,XR_,YR_;
output [10:0] index_cor_;

wire sign;
assign sign = index_cor[count];

wire [15:0] XR__,YR__;
shift16 sh1(XR,XR__);shift16 sh2(YR,YR__);

adder_pipe a1(clk,reset,XM,YR,XM_,sign);
adder_pipe a2(clk,reset,YM,XR,YM_,~sign);

buffer_cordic_cell b0(clk,reset,index_cor,index_cor_,XR__,YR__,XR_,YR_);
endmodule

