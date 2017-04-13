module phase_compression_13(clk,reset,phase,index_qua,index_rea,index_cor,trans_in,trans_out);
input clk,reset,trans_in;
input  [15:0] phase;
output trans_out;
output reg [2:0] index_qua;
output reg [5:0] index_rea;
output reg [6:0] index_cor;

wire [12:0] Index;
wire [2:0] temp_qua;
wire [5:0] temp_rea;
wire [6:0] temp_cor;

assign Index = (phase[13])?~phase[12:0]:phase[12:0];
assign temp_qua = phase[15:13];
assign temp_rea = Index[12:7];
assign temp_cor = Index[6:0];

D_trigger1 d0(clk,1'b1,trans_in,trans_out);

always@(posedge clk)begin
	if(~reset) begin
		index_qua <= 3'b0;
		index_rea <= 6'b0;
		index_cor <= 7'b0;
	end
	else begin
		index_qua <= temp_qua;
		index_rea <= temp_rea;
		index_cor <= temp_cor;
	end
end


endmodule

