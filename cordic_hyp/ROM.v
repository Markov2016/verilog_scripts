module ROM(clk,cen,wen,reset,index_qua,index_rea,index_wri,index_cor,D,
	XM,YM,XR,YR,index_cor0,trans_in,trans_out);

input clk,cen,wen,reset,trans_in;
input [2:0] index_qua;
input [5:0] index_rea,index_wri;
input [6:0] index_cor;
input [47:0] D;

wire [5:0] A;
wire [47:0] Q;

output [15:0] XM,YM,XR,YR;
output [9:0] index_cor0;
output trans_out;

MUX_2_6 m0(index_rea,index_wri,wen,A);

ROM_64_48 R0(clk,1'b1,cen,wen,A,D,Q);

buffer_ROM b_rom(clk,reset,trans_in,index_qua,index_cor,Q,XM,YM,XR,YR,index_cor0,trans_out);

endmodule

module ROM_64_48 (clk,RETN,cen,wen,A,D,Q);
input clk,RETN,cen,wen;
input [5:0] A;
input [47:0] D;
output [47:0] Q;
reg [47:0] ROM [0:63];

reg [5:0] count;
assign Q = (wen ==1)?ROM[A]:D;

always@(posedge clk)begin
  if(wen==0)begin
    ROM[A] <= D;
  end
end

endmodule 
