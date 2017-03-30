module PAC(clk,reset,cen,wen_trans,index_qua,index_rea,index_cor,sin_amp,wen_out,index_wri,D);
input clk,reset,cen,wen_trans;
input [2:0] index_qua;
input [5:0] index_wri,index_rea;
input [6:0] index_cor;
input [47:0] D;
output[15:0] sin_amp;
output wen_out;

wire [47:0] Q;
wire [5:0] A;
wire [15:0] XM0,YM0,XR0,YR0;wire [10:0] index_cor0;
wire [15:0] XM1,YM1,XR1,YR1;wire [10:0] index_cor1;
wire [15:0] XM2,YM2,XR2,YR2;wire [10:0] index_cor2;
wire [15:0] XM3,YM3,XR3,YR3;wire [10:0] index_cor3;
wire [15:0] XM4,YM4,XR4,YR4;wire [10:0] index_cor4;
wire [15:0] XM5,YM5,XR5,YR5;wire [10:0] index_cor5;
wire [15:0] XM6,YM6,XR6,YR6;wire [10:0] index_cor6;
wire [15:0] XM7,YM7,XR7,YR7;wire [10:0] index_cor7;
wire [2:0] index_qua7;wire wen7;

// delay line
wire trans7;

MUX_2_6 m0(index_rea,index_wri,wen_trans,A);

ROM_64_48 R0(clk,1'b1,cen,wen_trans,A,D,Q);

buffer_ROM b_rom(clk,reset,wen_trans,index_qua,index_cor,Q,XM0,YM0,XR0,YR0,index_cor0);

CORDIC_CELL c0(clk,reset,XM0,YM0,XR0,YR0,XM1,YM1,XR1,YR1,index_cor0,index_cor1,3'b110);
CORDIC_CELL c1(clk,reset,XM1,YM1,XR1,YR1,XM2,YM2,XR2,YR2,index_cor1,index_cor2,3'b101);
CORDIC_CELL c2(clk,reset,XM2,YM2,XR2,YR2,XM3,YM3,XR3,YR3,index_cor2,index_cor3,3'b100);
CORDIC_CELL c3(clk,reset,XM3,YM3,XR3,YR3,XM4,YM4,XR4,YR4,index_cor3,index_cor4,3'b011);
CORDIC_CELL c4(clk,reset,XM4,YM4,XR4,YR4,XM5,YM5,XR5,YR5,index_cor4,index_cor5,3'b010);
CORDIC_CELL c5(clk,reset,XM5,YM5,XR5,YR5,XM6,YM6,XR6,YR6,index_cor5,index_cor6,3'b001);
CORDIC_CELL c6(clk,reset,XM6,YM6,XR6,YR6,XM7,YM7,XR7,YR7,index_cor6,index_cor7,3'b000);

assign index_qua7 = index_cor7[9:7];
assign wen_trans7 = index_cor7[10];

mirro m1(clk,reset,XM7,YM7,index_qua7,wen_trans7,D,sin_amp,wen_out);

endmodule 


