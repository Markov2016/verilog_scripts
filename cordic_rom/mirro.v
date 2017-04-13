module mirro(clk,reset,X,Y,index_qua,
  sin_amp,trans_in,trans_out);

  input clk,reset,trans_in;
  input [15:0] X,Y;
  input [2:0] index_qua;

  wire [15:0] temp1,temp2,temp3;

  output reg [15:0] sin_amp;
  output trans_out;

  D_trigger1 d0(clk,1'b1,trans_in,trans_out);

  assign temp1[14:0] = (index_qua[0]^index_qua[1])?Y[15:1]:X[15:1];assign temp1[15] = 1'b0;

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
