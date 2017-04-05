module PA16_(clk,reset,wen_in,fcw,init,phase,wen_out);
  input clk,reset,wen_in;
  input [15:0] fcw,init;
  output reg [15:0] phase;
  output wen_out;
  wire [15:0] phase_wire;
  
  adder16 a0(fcw,phase,phase_wire,1'b0);
  always@(posedge clk or negedge reset) begin
    if(~reset)
      phase <= init;
    else
      phase <= phase_wire;
  end
  //D_trigger1 d0(clk,1'b1,wen_in,wen_out);
  assign wen_out = wen_in;
endmodule





