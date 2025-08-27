module CNTR(
    input LdB,
    input clk,
    input decB,
    input [15:0] din,
    output reg [15:0] dout
);
always @(posedge clk)
   begin
     if(LdB)
       dout <= din;
     else if(decB)
        dout <= dout - 1;
   end
endmodule
