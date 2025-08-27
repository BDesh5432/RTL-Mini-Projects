module COMP(input [15:0]din, output eqz);
  assign eqz = (din-1 == 0);
endmodule