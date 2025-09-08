//Synchronous FIFO 
module Sync_FIFO(clk, reset, data_in, wr_en, rd_en, data_out, Full, Empty);
parameter Width = 8;
parameter Depth = 10;           //FIFO Depth
input clk, reset, wr_en, rd_en;
input [Width-1:0] data_in;
output reg [Width-1:0] data_out;
output Full, Empty;

reg [Width-1:0] FIFO [Depth-1:0];
reg [$clog2(Depth)-1:0] wr_ptr, rd_ptr;
reg [$clog2(Depth):0] count;

always @(posedge clk)
 begin
   if(reset)
      begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count <= 0;
        data_out <= 0;
      end
   else
      begin
       if(wr_en && !Full)
        begin 
         FIFO[wr_ptr] <= data_in;
         wr_ptr <= (wr_ptr == Depth-1)? 0 : (wr_ptr + 1);
         count <= count + 1; 
        end
       if(rd_en && !Empty)
        begin
         data_out <= FIFO[rd_ptr];
         rd_ptr <= (rd_ptr == Depth-1)? 0 : (rd_ptr + 1);
         count <= count - 1;
        end
      end
 end

//Flags
assign Full = (count == Depth);
assign Empty = (count == 0);

endmodule