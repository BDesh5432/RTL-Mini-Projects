module Mul_DP(
    input LdA,
    input LdB,
    input LdP,
    input clrP,
    input decB,
    input clk,
    input [15:0] data_in,
    output eqz
);

wire [15:0] X, Y, Z, Bout;
PIPO1 A (.LdA(LdA), .clk(clk), .din(data_in), .dout(X));
PIPO2 P (.LdP(LdP), .clk(clk), .clrP(clrP), .din(Z), .dout(Y));
ADD add(.A(X), .B(Y), .C(Z));
CNTR B (.LdB(LdB), .clk(clk), .decB(decB), .din(data_in), .dout(Bout));
COMP eq (.din(Bout), .eqz(eqz));
endmodule
