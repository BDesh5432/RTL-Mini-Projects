module ADD(input [15:0] A , B, output reg [15:0] C);
always@(*)
C = A+B;
endmodule