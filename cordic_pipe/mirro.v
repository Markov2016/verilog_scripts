module mirro(clk,reset,XM,YM,index_qua,wen,D,sin_amp,wen_out);
  input clk,reset;
  input [15:0] XM,YM;
  input [2:0] index_qua;
  input wen;
  input [47:0] D;

  wire [15:0] temp1,temp2,temp3;

  output reg [15:0] sin_amp;
  output reg wen_out;

  assign temp1[14:0] = (index_qua[0]^index_qua[1])?YM[15:1]:XM[15:1];assign temp1[15] = 1'b0;

  adder16 a0(~temp1,16'h0001,temp2,1'b0);
  
  assign temp3[15:0] = (index_qua[1]^index_qua[2])?temp2:temp1;

  always@(posedge clk or negedge reset)begin
    if(~reset) begin
      wen_out <= 1'b0;
      sin_amp <= 16'b0;
    end
    else begin
      wen_out <= wen;
      sin_amp <= (wen)?temp3:16'b0;
    end
  end
endmodule
