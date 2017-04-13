module ROM(clk,cen,wen,reset,index_qua,index_rea,index_wri,index_cor,D,
	XM,YM,XR,YR,index_cor0,trans_in,trans_out);

input clk,cen,wen,reset,trans_in;
input [2:0] index_qua;
input [5:0] index_rea,index_wri;
input [6:0] index_cor;
input [47:0] D;

wire [5:0] A;
wire [47:0] Q;

output [15:0] XM,YM,XR,YR;
output [9:0] index_cor0;
output trans_out;

MUX_2_6 m0(index_rea,index_wri,wen,A);

ROM_64_48 R0(clk,1'b1,cen,wen,A,D,Q);

buffer_ROM b_rom(clk,reset,trans_in,index_qua,index_cor,Q,XM,YM,XR,YR,index_cor0,trans_out);

endmodule

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

module ROM_readonly(clk,cen,reset,index_qua,index_rea,index_cor,
	XM,YM,XR,YR,index_cor0,trans_in,trans_out);

input clk,cen,reset;
input [2:0] index_qua;
input [5:0] index_rea;
input [6:0] index_cor;

wire [47:0] Q;
wire trans_rom;

output [15:0] XM,YM,XR,YR;
output [9:0] index_cor0;
input trans_in;
output trans_out;

ROM_64_48_readonly R0(.clk(clk),.cen(cen),.A(index_rea),
	.Q(Q),.trans_in(trans_in),.trans_out(trans_out));

buffer_ROM_readonly b_rom(.clk(clk),.reset(reset),.index_qua(index_qua),.index_cor(index_cor),.Q(Q),
	.XM(XM),.YM(YM),.XR(XR),.YR(YR),.index_cor0(index_cor0));

endmodule

module ROM_64_48_readonly(clk,cen,A,Q,trans_in,trans_out);
input clk,cen;
input [5:0] A;
output reg [47:0] Q;
input trans_in;
output trans_out;

D_trigger1 d0(clk,1'b1,trans_in,trans_out);

always@(posedge clk) begin
	case(A)
		6'b000000: Q <= 48'hfff9c9019201;//0
		6'b000001: Q <= 48'hffefc904b603;//1
		6'b000010: Q <= 48'hffdcc807da06;//2
		6'b000011: Q <= 48'hffbec80afd08;//3
		6'b000100: Q <= 48'hff97c80e210b;//4
		6'b000101: Q <= 48'hff65c811430d;//5
		6'b000110: Q <= 48'hff2ac8146510;//6
		6'b000111: Q <= 48'hfee5c8178612;//7
		6'b001000: Q <= 48'hfe96c71aa714;//8
		6'b001001: Q <= 48'hfe3ec71dc617;//9
		6'b001010: Q <= 48'hfddbc720e419;//10
		6'b001011: Q <= 48'hfd6fc724011c;//11
		6'b001100: Q <= 48'hfcf9c6271c1e;//12
		6'b001101: Q <= 48'hfc79c62a3621;//13
		6'b001110: Q <= 48'hfbf0c52d4f23;//14
		6'b001111: Q <= 48'hfb5dc5306526;//15
		6'b010000: Q <= 48'hfac0c4337a28;//16
		6'b010001: Q <= 48'hfa19c4368d2a;//17
		6'b010010: Q <= 48'hf969c3399d2d;//18
		6'b010011: Q <= 48'hf8afc33cac2f;//19
		6'b010100: Q <= 48'hf7ecc23fb832;//20
		6'b010101: Q <= 48'hf71fc242c234;//21
		6'b010110: Q <= 48'hf648c145c936;//22
		6'b010111: Q <= 48'hf568c048cd39;//23
		6'b011000: Q <= 48'hf47fc04bcf3b;//24
		6'b011001: Q <= 48'hf38cbf4ecd3d;//25
		6'b011010: Q <= 48'hf290be51c940;//26
		6'b011011: Q <= 48'hf18abd54c142;//27
		6'b011100: Q <= 48'hf07bbc57b644;//28
		6'b011101: Q <= 48'hef63bc5aa847;//29
		6'b011110: Q <= 48'hee42bb5d9749;//30
		6'b011111: Q <= 48'hed17ba60814b;//31
		6'b100000: Q <= 48'hebe3b963684e;//32
		6'b100001: Q <= 48'heaa6b8664b50;//33
		6'b100010: Q <= 48'he961b7692a52;//34
		6'b100011: Q <= 48'he812b66c0654;//35
		6'b100100: Q <= 48'he6bab56edd57;//36
		6'b100101: Q <= 48'he559b471af59;//37
		6'b100110: Q <= 48'he3f0b3747e5b;//38
		6'b100111: Q <= 48'he27db177475d;//39
		6'b101000: Q <= 48'he102b07a0d5f;//40
		6'b101001: Q <= 48'hdf7eaf7ccd62;//41
		6'b101010: Q <= 48'hddf2ae7f8964;//42
		6'b101011: Q <= 48'hdc5dad824066;//43
		6'b101100: Q <= 48'hdac0ab84f168;//44
		6'b101101: Q <= 48'hd91aaa879e6a;//45
		6'b101110: Q <= 48'hd76ba98a466c;//46
		6'b101111: Q <= 48'hd5b5a78ce86e;//47
		6'b110000: Q <= 48'hd3f6a68f8470;//48
		6'b110001: Q <= 48'hd22fa5921b72;//49
		6'b110010: Q <= 48'hd060a394ad74;//50
		6'b110011: Q <= 48'hce89a2973976;//51
		6'b110100: Q <= 48'hccaaa099bf78;//52
		6'b110101: Q <= 48'hcac39f9c3f7a;//53
		6'b110110: Q <= 48'hc8d49d9eb97c;//54
		6'b110111: Q <= 48'hc6de9ca12c7e;//55
		6'b111000: Q <= 48'hc4e09aa39a80;//56
		6'b111001: Q <= 48'hc2da99a60182;//57
		6'b111010: Q <= 48'hc0cd97a86284;//58
		6'b111011: Q <= 48'hbeb895aabd86;//59
		6'b111100: Q <= 48'hbc9c94ad1187;//60
		6'b111101: Q <= 48'hba7992af5e89;//61
		6'b111110: Q <= 48'hb84e90b1a48b;//62
		6'b111111: Q <= 48'hb61c8fb3e48d;//63
	endcase
end
endmodule
