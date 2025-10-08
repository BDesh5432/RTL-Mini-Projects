//4-Bit Shift Register
module shift_reg_4bit (
    input  wire       clk,    // Clock
    input  wire       rst,    // Synchronous reset
    input  wire       din,    // Serial data input
    output reg  [3:0] q       // 4-bit shift register output
);

    always @(posedge clk) begin
        if (rst) begin
            q <= 4'b0000;              // Clear on reset
        end else begin
            q <= {q[2:0], din};        // Shift left, insert din
        end
    end

endmodule

