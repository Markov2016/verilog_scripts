module PA16_(clk,reset,fcw,init,phase,trans_in,trans_out);
  input clk,reset,trans_in;
  input [15:0] fcw,init;
  output reg [15:0] phase;
  output trans_out;
  wire [15:0] phase_wire;
  
  adder16 a0(fcw,phase,phase_wire,1'b0);
  always@(posedge clk or negedge reset) begin
    if(~reset)
      phase <= init;
    else
      phase <= phase_wire;
  end
  //D_trigger1 d0(clk,1'b1,trans_in_in,trans_out);
  assign trans_out = trans_in;
endmodule





