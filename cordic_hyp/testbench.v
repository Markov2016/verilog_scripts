`timescale 1ns/ 1ns
module testbench();
  reg clk,reset,cen,wen,writed,reseted;
  reg [5:0] index_wri;
  reg [15:0] fcw,offset;
  wire [47:0] D;
  wire [15:0] sin_amp;
  wire wen_out;
  reg [15:0] i;
  reg [47:0] LUT [0:63];
  assign D = LUT[index_wri];
  CORDIC_16_pipe d1(clk,reset,cen,wen,index_wri,D,fcw,offset,sin_amp,wen_out);
  initial begin
    $readmemh("./core_pipe/LUT_11_5.txt",LUT);
    clk = 1;reset = 1;cen = 0;wen = 1;writed = 0;reseted = 0;
    index_wri = 6'b111111;
    fcw = 16'h0111;
    offset = 16'b0;
    i <= 16'b0;
    #20 reset = 0;
    #20 reset = 1;
    wen = 0;
  end
  always begin
    #5 clk = ~clk;
  end
  
  integer w_file;
  initial begin  w_file = $fopen("data_out.txt");end
  always@(posedge wen_out) begin
    if( i == 16'b0) begin
      i <= 16'b1;
    end
  end
  
  always@(negedge clk) begin
    if(wen == 0) begin
      if(index_wri == 6'b111111 && writed == 1)begin
        wen <= 1;
        reset <= 0;
      end
      else begin
        if(index_wri == 6'b0) begin
          writed <= 1;
        end
        index_wri <= index_wri + 1;
      end
    end
    else if(writed) begin
      reset <= 1;
      if (i > 0 & wen_out > 0) begin
        i <= i+1;
        $fdisplay(w_file,"%h",sin_amp);  
        if (i>=4096) begin
         $fclose(w_file);
         $stop;
        end
      end
    end
  end
  /*
  always@(posedge wen) begin
    if( i == 16'b0) begin
      i = 16'b1;
    end
  end
  
  integer w_file;
  initial begin  w_file = $fopen("data_out.txt");end
  always@(negedge clk) begin
  if (i > 0) begin
    $fdisplay(w_file,"%h",sin_amp);
    i <= i+1;
    if (i>4096) begin
      $stop;
    end
  end
  
  end
  */
endmodule