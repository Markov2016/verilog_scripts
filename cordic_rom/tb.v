`timescale 1ns/ 1ns
module tb2();
  reg clk,reset,cen,wen,writed,reseted;
  reg [5:0] index_wri;
  reg [15:0] fcw,offset;
  wire [47:0] D;
  wire [15:0] sin_amp;
  wire wen_out;
  reg [15:0] i;
  reg [47:0] LUT [0:63];
  assign D = LUT[index_wri];
  cordic_rom d1(clk,reset,cen,wen,index_wri,D,fcw,offset,sin_amp,wen_out);
  initial begin
    $readmemh("./core/LUT_11_5.txt",LUT);
    clk = 1;reset = 1;cen = 0;wen = 1;writed = 0;reseted = 0;
    index_wri = 6'b0;
    fcw = 16'h0111;
    offset = 16'b0;
    i <= 16'b0;
    #21 reset = 0;#20 reset = 1;
    #100 reset = 0;wen = 0;
  end
  always begin
    #5 clk = ~clk;
  end
  
  integer w_file;
  initial begin  w_file = $fopen("data_out.txt");end
  always@(posedge wen) begin
    reset <= 1;
  end
  
  wire [5:0] next_index_wri;assign next_index_wri = index_wri + 1;

  always@(posedge clk) begin
    if(wen == 0) begin
      if(writed == 1)begin
        wen <= 1;
      end
      else begin
        index_wri <= next_index_wri;
        if(index_wri == 6'b111111) begin
          writed <= 1;
        end
      end
    end
    else if(writed & wen_out) begin
      i <= i+1;
      $fdisplay(w_file,"%h",sin_amp);  
      if (i>=4095) begin
       $fclose(w_file);
       $stop;
      end
    end
  end
endmodule