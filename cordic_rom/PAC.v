module PAC(clk,reset,cen,index_qua,index_rea,index_cor,sin_amp,trans_in,trans_out);
input clk,reset,cen;
input [2:0] index_qua;
input [5:0] index_rea;
input [6:0] index_cor;
output[15:0] sin_amp;
input trans_in;
output trans_out;

wire [15:0] XM,YM,XR,YR,X,Y;
wire [9:0] index_cor0;
wire [2:0] index_qua_;
wire trans_rom,trans_cor;


// delay line

//ROM r0(.clk(clk),.cen(cen),.wen(wen),.reset(reset),.index_qua(index_qua),.index_rea(index_rea),.index_wri(index_wri),.index_cor(index_cor),.D(D),
//	.XM(XM),.YM(YM),.XR(XR),.YR(YR),.index_cor0(index_cor0),.trans_in(trans_in),.trans_out(trans_rom));

ROM_readonly r0(.clk(clk),.cen(cen),.reset(reset),.index_qua(index_qua),.index_rea(index_rea),.index_cor(index_cor),
	.XM(XM),.YM(YM),.XR(XR),.YR(YR),.index_cor0(index_cor0),.trans_in(trans_in),.trans_out(trans_rom));

CORDIC c0(.clk(clk),.reset(reset),.XM(XM),.YM(YM),.XR(XR),.YR(YR),.index_cor0(index_cor0),
	.X(X),.Y(Y),.index_qua_(index_qua_),.trans_in(trans_rom),.trans_out(trans_cor));

mirro m0(.clk(clk),.reset(reset),.X(X),.Y(Y),.index_qua(index_qua_),
	.sin_amp(sin_amp),.trans_in(trans_cor),.trans_out(trans_out));

endmodule 


