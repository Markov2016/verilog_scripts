module buffer_ROM(clk,reset,wen,index_qua,index_cor,Q,XM0,YM0,XR0,YR0,index_cor0);
  input clk,reset,wen;
  input [2:0] index_qua;
  input [6:0] index_cor;
  input [47:0] Q;
  
  output reg [15:0] XM0,YM0,XR0,YR0;
  output reg [10:0] index_cor0;
  
  always@(posedge clk or negedge  reset)begin
    if(~reset) begin
      XM0 <= 16'b0;YM0 <= 16'b0;XR0 <= 16'b0;YR0 <= 16'b0;
      index_cor0 <= 11'b0;
    end
    else begin
      // XM & YM use 11 bits from Q
      XM0[15:0] <= Q[47:32];
      YM0[15:0] <= Q[23: 8];
      // XR & YR use 5  bits from Q, then shift K_M+2 bits
      XR0[7:0] <= Q[31:24];XR0[15:8] <= 8'b0;
      YR0[7:0] <= Q[7 : 0];YR0[15:8] <= 8'b0;
      // index_cor0 
      index_cor0[6:0] <= index_cor;
      index_cor0[9:7] <= index_qua;
      index_cor0[10]  <= wen;
    end 
  end
  
  
endmodule

module buffer_cordic_cell(clk,reset,index_cor,index_cor_,XR__,YR__,XR_,YR_);
  input [10:0] index_cor;
  input [15:0] XR__,YR__;
  input  clk,reset;
  output [10:0] index_cor_;
  output [15:0] XR_,YR_;  
  wire [10:0] index_cor0,index_cor1,index_cor2,index_cor3;
  D_trigger11 ti0(clk,reset,index_cor ,index_cor0);
  D_trigger11 ti1(clk,reset,index_cor0,index_cor1);
  D_trigger11 ti2(clk,reset,index_cor1,index_cor2);
  D_trigger11 ti3(clk,reset,index_cor2,index_cor3);
  D_trigger11 ti4(clk,reset,index_cor3,index_cor_);
  
  wire [15:0] XR_0,XR_1,XR_2,XR_3;
  D_trigger16 tx0(clk,reset,XR__,XR_0);
  D_trigger16 tx1(clk,reset,XR_0,XR_1);
  D_trigger16 tx2(clk,reset,XR_1,XR_2);
  D_trigger16 tx3(clk,reset,XR_2,XR_3);
  D_trigger16 tx4(clk,reset,XR_3,XR_);
  
  wire [15:0] YR_0,YR_1,YR_2,YR_3;
  D_trigger16 ty0(clk,reset,YR__,YR_0);
  D_trigger16 ty1(clk,reset,YR_0,YR_1);
  D_trigger16 ty2(clk,reset,YR_1,YR_2);
  D_trigger16 ty3(clk,reset,YR_2,YR_3);
  D_trigger16 ty4(clk,reset,YR_3,YR_);
  
endmodule