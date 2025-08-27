module Mul_TB;
  reg [15:0] data_in;
  reg clk, start, reset;
  wire done;
  wire eqz;
  wire LdA, LdB, LdP, clrP, decB;

  Mul_DP Dp(.LdA(LdA), .LdB(LdB), .LdP(LdP), .clrP(clrP), .decB(decB), .clk(clk), 
            .data_in(data_in), .eqz(eqz)); 
  Mul_CP Cp(.eqz(eqz), .start(start), .clk(clk), .reset(reset), 
            .LdA(LdA), .LdB(LdB), .LdP(LdP), .clrP(clrP), .decB(decB), .done(done));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // VCD dump for GTKWave
    $dumpfile("mul_tb.vcd");   // Name of dump file
    $dumpvars(0, Mul_TB);      // Dump all variables in Mul_TB and its hierarchy
  end

  // Stimulus
  initial begin
    $monitor($time, " A/B loaded: data_in=%d, done=%b", data_in, done);

    // Initialize
    reset = 1; start = 0; data_in = 0;
    #10;
    reset = 0;

    // Load A
    data_in = 7; start = 1; #10 start = 0;
    #10 data_in = 5;

    wait(done);
    #10;
    $display("Result of 7 * 5 is stored in P (Dp.Y) = %d", Dp.Y);

    #20;
    reset = 1; #10 reset = 0;
    data_in = 3; start = 1; #10 start = 0;
    #10 data_in = 10;
    wait(done);
    $display("Result of 3 * 10 is stored in P = %d", Dp.Y);

    #50 $finish;
  end
endmodule
