module ROM_64_48 (clk,RETN,cen,wen,A,D,Q);
input clk,RETN,cen,wen;
input [5:0] A;
input [47:0] D;
output [47:0] Q;
reg [47:0] ROM [0:63];

reg [5:0] count;
assign Q = (wen ==1)?ROM[A]:D;

always@(posedge clk)begin
  if(wen==0)begin
    ROM[A] <= D;
  end
end

endmodule 


