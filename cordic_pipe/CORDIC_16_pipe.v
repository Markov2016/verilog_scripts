module CORDIC_16_pipe(clk,reset,cen,wen,index_wri,D,fcw,offset,sin_amp,wen7);
  input clk,reset,cen,wen;
  input [5:0] index_wri;
  input [15:0] fcw,offset;
  input [47:0] D;
  output [15:0] sin_amp;
  output wen7;
  
  wire [2:0] index_qua;
  wire [5:0] index_rea;
  wire [6:0] index_cor;
  wire [15:0] phase;
  wire wen_trans;

  PA16 pa(clk,reset,fcw,offset,phase,wen,wen_trans);
  phase_compression_13 pc(phase,index_qua,index_rea,index_cor);
  PAC pac(clk,reset,cen,wen_trans,index_qua,index_rea,index_cor,sin_amp,wen7,index_wri,D);
  
endmodule


