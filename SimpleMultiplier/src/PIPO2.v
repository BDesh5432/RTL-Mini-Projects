module PIPO2(
    input LdP,
    input clk,
    input clrP,
    input [15:0] din,
    output reg [15:0] dout
);
always @(posedge clk)
  begin
    if(clrP)
      dout <= 16'b0;
    else if(LdP)
      dout <= din;
  end
endmodule
