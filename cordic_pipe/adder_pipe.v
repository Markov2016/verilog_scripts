module adder_pipe(clk,reset,a1,a2,b,sign);
  input clk,reset;
  input [15:0] a1,a2;
  input sign;
  output [15:0] b;
  
  wire [3:0] carry;
  wire [3:0] temp_pre1 [0:5];
  wire [3:0] temp_pre2 [0:5];
  wire [3:0] temp_pos  [0:5];
  wire [3:0] temp_carry;
  wire [15:0]temp_a2 = (sign == 1)?~a2:a2;
    
  // 0:3 adder
  adder4 A_0(a1[3:0],temp_a2[3:0],sign,temp_pos[0],temp_carry[0]);
  D_trigger1 tc0(clk,reset,temp_carry[0],carry[0]);
  D_trigger4 D00(clk,reset,temp_pos[0],temp_pos[1]);
  D_trigger4 D01(clk,reset,temp_pos[1],temp_pos[2]);
  D_trigger4 D02(clk,reset,temp_pos[2],b[3:0]);
  
  //4:7 adder
  Double_DT D10(clk,reset,a1[7:4],temp_a2[7:4],temp_pre1[0],temp_pre2[0]);
  adder4 A_1(temp_pre1[0],temp_pre2[0],carry[0],temp_pos[3],temp_carry[1]);
  D_trigger1 tc1(clk,reset,temp_carry[1],carry[1]);
  D_trigger4 D11(clk,reset,temp_pos[3],temp_pos[4]);
  D_trigger4 D12(clk,reset,temp_pos[4],b[7:4]);
  
  //8:11 adder
  Double_DT D20(clk,reset,a1[11:8],temp_a2[11:8],temp_pre1[1],temp_pre2[1]);
  Double_DT D21(clk,reset,temp_pre1[1],temp_pre2[1],temp_pre1[2],temp_pre2[2]);
  adder4 A_2(temp_pre1[2],temp_pre2[2],carry[1],temp_pos[5],temp_carry[2]);
  D_trigger1 tc2(clk,reset,temp_carry[2],carry[2]);
  D_trigger4 D22(clk,reset,temp_pos[5],b[11:8]);
  
  //12:15 adder
  Double_DT D30(clk,reset,a1[15:12],temp_a2[15:12],temp_pre1[3],temp_pre2[3]);
  Double_DT D31(clk,reset,temp_pre1[3],temp_pre2[3],temp_pre1[4],temp_pre2[4]);
  Double_DT D32(clk,reset,temp_pre1[4],temp_pre2[4],temp_pre1[5],temp_pre2[5]);
  adder4 A_3(temp_pre1[5],temp_pre2[5],carry[2],b[15:12],temp_carry[3]);
  D_trigger1 tc3(clk,reset,temp_carry[3],carry[3]);
endmodule
