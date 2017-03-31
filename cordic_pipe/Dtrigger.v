module D_trigger1(clk,reset,D,Q);
input clk,reset;
input  D;
output reg  Q;

always@(posedge clk or negedge reset) begin
  if(~reset) begin
    Q <= 1'b0;
  end
  else begin 
    Q <= D;
  end
end

endmodule

module D_trigger4(clk,reset,D,Q);
input clk,reset;
input [3:0] D;
output reg [3:0] Q;

always@(posedge clk or negedge reset) begin
  if(~reset) begin
    Q <= 4'b0;
  end
  else begin 
    Q <= D;
  end
end

endmodule

module D_trigger10(clk,reset,D,Q);
input clk,reset;
input [9:0] D;
output reg [9:0] Q;

always@(posedge clk or negedge reset) begin
  if(~reset) begin
    Q <= 11'b0;
  end
  else begin 
    Q <= D;
  end
end

endmodule

module D_trigger16(clk,reset,D,Q);
input clk,reset;
input [15:0] D;
output reg [15:0] Q;

always@(posedge clk or negedge reset) begin
  if(~reset) begin
    Q <= 16'b0;
  end
  else begin 
    Q <= D;
  end
end

endmodule


module Double_DT(clk,reset,D0,D1,Q0,Q1);
  input clk,reset;
  input [3:0] D0,D1;
  output [3:0] Q0,Q1;
  
  D_trigger4 d0(clk,reset,D0,Q0);
  D_trigger4 d2(clk,reset,D1,Q1);
endmodule
