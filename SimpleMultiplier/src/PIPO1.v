module PIPO1(
    input LdA,
    input clk,
    input [15:0] din,
    output reg [15:0] dout
);
always @(posedge clk)
  begin
    if(LdA)
     dout <= din;
  end
endmodule
