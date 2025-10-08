//ShiftReg Testbench
`timescale 1ns/1ps

module shift_reg_4bit_tb;

    reg clk;
    reg rst;
    reg din;
    wire [3:0] q;

    // Instantiate DUT (Device Under Test)
    shift_reg_4bit uut (
        .clk(clk),
        .rst(rst),
        .din(din),
        .q(q)
    );
initial begin
    $dumpfile("shift_reg_4bit.vcd");  // waveform dump file
    $dumpvars(0, shift_reg_4bit_tb); // dump everything in tb
end

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        din = 0;

        // Apply reset for 2 cycles
        #20 rst = 0;

        // Feed in data bits
        din = 1; #10;   // shift in 1
        din = 0; #10;   // shift in 0
        din = 1; #10;   // shift in 1
        din = 1; #10;   // shift in 1
        din = 0; #10;   // shift in 0
        din = 1; #10;   // shift in 1

        // Hold for a while
        #50;

        $finish;
    end

    // Monitor values
    initial begin
        $monitor("Time=%0t | rst=%b | din=%b | q=%b",
                  $time, rst, din, q);
    end

endmodule

