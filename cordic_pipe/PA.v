module PA4(clk,reset,fcw,init,carry_in,carry_out,phase);
  input clk,reset,carry_in;
  input [3:0] fcw,init;
  output reg carry_out;
  output reg [3:0] phase;
  
  wire carry_wire;
  wire [3:0] phase_wire;
  
  adder4 a0(phase,fcw,carry_in,phase_wire,carry_wire);
  
  always@(posedge clk or negedge reset)begin
    if(~reset)begin
	   phase <= init;
	   carry_out <= 1'b0;
    end
    else begin
	   phase <= phase_wire;
	   carry_out <= carry_wire;
    end
  end
endmodule

module PA16(clk,reset,fcw,init,phase,wen,trans3);
  input clk,reset,wen;
  input [15:0] fcw,init;
  output [15:0] phase;
  output trans3;

  
  wire [3:0] carry;
  wire [3:0] temp_pre [0:9];
  wire [3:0] temp_pos [0:5];
  wire trans0,trans1,trans2,trans3;
  D_trigger1 d0(clk,reset,wen ,trans0);
  D_trigger1 d1(clk,reset,trans0,trans1);
  D_trigger1 d2(clk,reset,trans1,trans2);
  D_trigger1 d3(clk,reset,trans2,trans3);
  
  // 0:3 adder
  D_trigger4 D00(clk,reset,fcw[3:0]   ,temp_pre[0]);
  PA4        P0 (clk,reset,temp_pre[0],init[3:0]  ,1'b0    ,carry[0],temp_pos[0]);
  D_trigger4 D01(clk,reset,temp_pos[0],temp_pos[1]);
  D_trigger4 D02(clk,reset,temp_pos[1],temp_pos[2]);
  D_trigger4 D03(clk,reset,temp_pos[2],phase[3:0] );
  
  //4:7 adder
  D_trigger4 D10(clk,reset,fcw[7:4]   ,temp_pre[1]);
  D_trigger4 D11(clk,reset,temp_pre[1],temp_pre[2]);
  PA4        P1 (clk,reset,temp_pre[2],init[7:4]  ,carry[0],carry[1],temp_pos[3]);
  D_trigger4 D12(clk,reset,temp_pos[3],temp_pos[4]);
  D_trigger4 D13(clk,reset,temp_pos[4],phase[7:4] );
  
  //8:11 adder
  D_trigger4 D20(clk,reset,fcw[11:8]  ,temp_pre[3]);
  D_trigger4 D21(clk,reset,temp_pre[3],temp_pre[4]);
  D_trigger4 D22(clk,reset,temp_pre[4],temp_pre[5]);
  PA4        P2 (clk,reset,temp_pre[5],init[11:8]  ,carry[1],carry[2],temp_pos[5]);
  D_trigger4 D23(clk,reset,temp_pos[5],phase[11:8]);
  
  //12:15 adder
  D_trigger4 D30(clk,reset,fcw[15:12] ,temp_pre[6]);
  D_trigger4 D31(clk,reset,temp_pre[6],temp_pre[7]);
  D_trigger4 D32(clk,reset,temp_pre[7],temp_pre[8]);
  D_trigger4 D33(clk,reset,temp_pre[8],temp_pre[9]);
  PA4        P3 (clk,reset,temp_pre[9],init[15:12]  ,carry[2],carry[3],phase[15:12]);
endmodule






