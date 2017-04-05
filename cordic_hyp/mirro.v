module mirro(clk,reset,XM,YM,index_qua,wen,D,sin_amp,wen_out);
  input clk,reset;
  input [15:0] XM,YM;
  input [2:0] index_qua;
  input wen;
  input [47:0] D;

  wire [15:0] temp1,temp2,temp3;

  output reg [15:0] sin_amp;
  output wen_out;

  D_trigger1 d0(clk,1'b1,wen,wen_out);

  assign temp1[14:0] = (index_qua[0]^index_qua[1])?YM[15:1]:XM[15:1];assign temp1[15] = 1'b0;

  assign temp2 = (~temp1) + 16'h0001;
  
  assign temp3[15:0] = (index_qua[1]^index_qua[2])?temp2:temp1;

  always@(posedge clk)begin
    if(~reset) begin
      sin_amp <= 16'b0;
    end
    else begin
      sin_amp <= temp3;
    end
  end
endmodule
