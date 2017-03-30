module MUX_2_6 (in1,in2,sign,out);
  input [5:0] in1,in2;
  input sign;
  output [5:0] out;
  assign out = (sign)?in1:in2;
endmodule


