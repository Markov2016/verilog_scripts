module buffer_ROM(clk,reset,wen,index_qua,index_cor,Q,XM0,YM0,XR0,YR0,index_cor0,wen_trans0);
  input clk,reset,wen;
  input [2:0] index_qua;
  input [6:0] index_cor;
  input [47:0] Q;
  
  output reg [15:0] XM0,YM0,XR0,YR0;
  output reg [9:0] index_cor0;
  output wen_trans0;

  D_trigger1 d0(clk,1'b1,wen,wen_trans0);
  
  always@(posedge clk or negedge  reset)begin
    if(~reset) begin
      XM0 <= 16'b0;YM0 <= 16'b0;XR0 <= 16'b0;YR0 <= 16'b0;
      index_cor0 <= 10'b0;
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
    end 
  end
  
endmodule


module buffer_cordic_cell(clk,reset,index_cor,index_cor_,wen_in,wen_out,XM__,YM__,XR__,YR__,XM_,YM_,XR_,YR_);
  input [9:0] index_cor;
  input [15:0] XM__,YM__,XR__,YR__;
  input  clk,reset,wen_in;
  output [9:0] index_cor_;
  output [15:0] XM_,YM_,XR_,YR_;
  output wen_out;
  
  D_trigger16 txm0(clk,reset,XM__,XM_);
  D_trigger16 tym0(clk,reset,YM__,YM_);

  wire [2:0] wen_trans;
  D_trigger1 tw0(clk,1'b1,wen_in,wen_trans[0]);
  D_trigger1 tw1(clk,1'b1,wen_trans[0],wen_trans[1]);
  D_trigger1 tw2(clk,1'b1,wen_trans[1],wen_trans[2]);
  D_trigger1 tw3(clk,1'b1,wen_trans[2],wen_out);
  
  wire [9:0] index_cor0,index_cor1,index_cor2;
  D_trigger10 ti0(clk,reset,index_cor ,index_cor0);
  D_trigger10 ti1(clk,reset,index_cor0,index_cor1);
  D_trigger10 ti2(clk,reset,index_cor1,index_cor2);
  D_trigger10 ti3(clk,reset,index_cor2,index_cor_);
  
  wire [15:0] XR_0,XR_1,XR_2;
  D_trigger16 txr0(clk,reset,XR__,XR_0);
  D_trigger16 txr1(clk,reset,XR_0,XR_1);
  D_trigger16 txr2(clk,reset,XR_1,XR_2);
  D_trigger16 txr3(clk,reset,XR_2,XR_);
  
  wire [15:0] YR_0,YR_1,YR_2;
  D_trigger16 tyr0(clk,reset,YR__,YR_0);
  D_trigger16 tyr1(clk,reset,YR_0,YR_1);
  D_trigger16 tyr2(clk,reset,YR_1,YR_2);
  D_trigger16 tyr3(clk,reset,YR_2,YR_);
  
endmodule