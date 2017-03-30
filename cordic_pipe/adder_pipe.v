module adder_pipe(clk,reset,a1,a2,b,sign);
  input clk,reset;
  input [15:0] a1,a2;
  input sign;
  output [15:0] b;
  
  wire [3:0] carry;
  wire [3:0] temp_pre1 [0:9];
  wire [3:0] temp_pre2 [0:9];
  wire [3:0] temp_pos  [0:9];
  wire [3:0] temp_carry;
  wire [15:0]temp_a2 = (sign == 1)?~a2:a2;
  wire sign_;
    
  // 0:3 adder
  Double_DT D00(clk,reset,a1[3:0],temp_a2[3:0],temp_pre1[0],temp_pre2[0]);
  D_trigger1 ts0(clk,reset,sign,sign_);
  adder4 A_0(temp_pre1[0],temp_pre2[0],sign_,temp_pos[0],temp_carry[0]);
  D_trigger1 tc0(clk,reset,temp_carry[0],carry[0]);
  D_trigger4 D01(clk,reset,temp_pos[0],temp_pos[1]);
  D_trigger4 D02(clk,reset,temp_pos[1],temp_pos[2]);
  D_trigger4 D03(clk,reset,temp_pos[2],temp_pos[3]);
  D_trigger4 D04(clk,reset,temp_pos[3],b[3:0]);
  
  //4:7 adder
  Double_DT D10(clk,reset,a1[7:4],temp_a2[7:4],temp_pre1[1],temp_pre2[1]);
  Double_DT D11(clk,reset,temp_pre1[1],temp_pre2[1],temp_pre1[2],temp_pre2[2]);
  adder4 A_1(temp_pre1[2],temp_pre2[2],carry[0],temp_pos[4],temp_carry[1]);
  D_trigger1 tc1(clk,reset,temp_carry[1],carry[1]);
  D_trigger4 D12(clk,reset,temp_pos[4],temp_pos[5]);
  D_trigger4 D13(clk,reset,temp_pos[5],temp_pos[6]);
  D_trigger4 D14(clk,reset,temp_pos[6],b[7:4]);
  
  //8:11 adder
  Double_DT D20(clk,reset,a1[11:8],temp_a2[11:8],temp_pre1[3],temp_pre2[3]);
  Double_DT D21(clk,reset,temp_pre1[3],temp_pre2[3],temp_pre1[4],temp_pre2[4]);
  Double_DT D22(clk,reset,temp_pre1[4],temp_pre2[4],temp_pre1[5],temp_pre2[5]);
  adder4 A_2(temp_pre1[5],temp_pre2[5],carry[1],temp_pos[7],temp_carry[2]);
  D_trigger1 tc2(clk,reset,temp_carry[2],carry[2]);
  D_trigger4 D23(clk,reset,temp_pos[7],temp_pos[8]);
  D_trigger4 D24(clk,reset,temp_pos[8],b[11:8]);
  
  //12:15 adder
  Double_DT D30(clk,reset,a1[15:12],temp_a2[15:12],temp_pre1[6],temp_pre2[6]);
  Double_DT D31(clk,reset,temp_pre1[6],temp_pre2[6],temp_pre1[7],temp_pre2[7]);
  Double_DT D32(clk,reset,temp_pre1[7],temp_pre2[7],temp_pre1[8],temp_pre2[8]);
  Double_DT D33(clk,reset,temp_pre1[8],temp_pre2[8],temp_pre1[9],temp_pre2[9]);
  adder4 A_3(temp_pre1[9],temp_pre2[9],carry[2],temp_pos[9],temp_carry[3]);
  D_trigger1 tc3(clk,reset,temp_carry[3],carry[3]);
  D_trigger4 D34(clk,reset,temp_pos[9],b[15:12]);
endmodule


