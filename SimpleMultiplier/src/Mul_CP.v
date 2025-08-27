module Mul_CP(input eqz, start, clk, reset, output reg LdA, LdB, LdP, clrP, decB, done);
reg [2:0]state, next_state;
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
always @(posedge clk)
  begin
    if(reset)
      state <= S0;
    else   
      state <= next_state;
  end
  
always @(*)
  begin
  next_state = state;
    case(state)
       S0: 
         begin 
           if(start)
              next_state = S1;
         end
       S1: next_state = S2;
       S2: next_state = S3;
       S3: 
         begin 
           if(eqz)
             next_state = S4;
         end
       S4: next_state = S0;
       default: next_state = S0;
    endcase     
  end

always @(state)
  begin
    case(state)
       S0: 
         begin
          #1 LdA = 0; LdB = 0; LdP = 0; clrP = 0; decB = 0; done = 0;
         end
       S1: #1 LdA=1;
       S2:
         begin
           #1 LdA = 0; LdB = 1; clrP = 1;
         end
       S3: 
         begin
           #1 LdB = 0; clrP = 0; LdP = 1; decB = 1;
         end
       S4: 
         begin
           #1 LdP = 0; decB = 0; done = 1;
         end
       default:
         begin
           #1 LdA = 0; LdB = 0; LdP = 0; clrP = 0; decB = 0; done = 0;
         end 
    endcase   
  end
endmodule