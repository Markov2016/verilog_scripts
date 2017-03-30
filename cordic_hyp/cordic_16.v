module cordic_16_pipe(clk,reset,cen,wen,index_wri,D,fcw,offset,sin_amp);
  input clk,reset,cen,wen;
  input [5:0] index_wri;
  input [15:0] fcw,offset;
  input [47:0] D;
  output [15:0] sin_amp;
  
  wire [2:0] index_qua;
  wire [5:0] index_rea;
  wire [6:0] index_cor;
  wire [15:0] phase;

  PA16_ pa(clk,reset,fcw,offset,phase);
  phase_compression_13 pc(phase,index_qua,index_rea,index_cor);
  PAC pac(clk,reset,cen,wen,index_qua,index_rea,index_cor,sin_amp,index_wri,D);
  
endmodule

