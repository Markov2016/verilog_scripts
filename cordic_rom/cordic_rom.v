module cordic_rom(clk,reset,cen,wen,index_wri,D,fcw,offset,sin_amp,trans_pac);
  input clk,reset,cen,wen;
  input [5:0] index_wri;
  input [15:0] fcw,offset;
  input [47:0] D;
  output [15:0] sin_amp;
  output trans_pac;
  
  wire [2:0] index_qua;
  wire [5:0] index_rea;
  wire [6:0] index_cor;
  wire [15:0] phase;
  wire trans_pa,trans_pc;

  PA16_ pa(.clk(clk),.reset(reset),.fcw(fcw),.init(offset),
    .phase(phase),.trans_in(wen),.trans_out(trans_pa));

  phase_compression_13 pc(.clk(clk),.reset(reset),.phase(phase),
    .index_qua(index_qua),.index_rea(index_rea),.index_cor(index_cor),.trans_in(trans_pa),.trans_out(trans_pc));

  PAC pac(.clk(clk),.reset(reset),.cen(cen),.index_qua(index_qua),.index_rea(index_rea),.index_cor(index_cor),
    .sin_amp(sin_amp),.trans_in(trans_pc),.trans_out(trans_pac));
  
endmodule



