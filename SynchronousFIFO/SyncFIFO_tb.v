//Testbench for Sync_FIFO
module SyncFIFO_tb;
    parameter Width = 8;
    parameter Depth = 10;

    reg clk, reset, wr_en, rd_en;
    reg [Width-1:0] data_in;
    wire [Width-1:0] data_out;
    wire Full, Empty;

    // DUT
    Sync_FIFO DUT (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_out(data_out),
        .Full(Full),
        .Empty(Empty)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units period
    end

    // Dump waveform
    initial begin
        $dumpfile("SyncFIFO.vcd");
        $dumpvars(0, SyncFIFO_tb);
    end

    // Test stimulus with verification
    reg [Width-1:0] expected_data [0:Depth-1];
    integer i;

    initial begin
        // Initialize signals
        reset = 1;
        wr_en = 0;
        rd_en = 0;
        data_in = 0;

        // Apply reset
        #10;
        reset = 0;

        // -------------------------
        // Write data into FIFO
        // -------------------------
        for(i = 0; i < Depth; i = i + 1) begin
            @(posedge clk);
            wr_en = 1;
            data_in = $random % 256;  // Random 8-bit data
            expected_data[i] = data_in; // Store expected data
            if(Full)
                $display("Warning: FIFO full at write %0d, time %0t", i, $time);
        end

        // Stop writing
        @(posedge clk);
        wr_en = 0;

        // -------------------------
        // Read data from FIFO
        // -------------------------
        for(i = 0; i < Depth; i = i + 1) begin
            @(posedge clk);
            rd_en = 1;
            if(Empty)
                $display("Warning: FIFO empty at read %0d, time %0t", i, $time);
            else begin
                // Delay for synchronous read
                #1;
                if(data_out !== expected_data[i])
                    $display("Error: Data mismatch at read %0d, expected = %0h, got = %0h, time = %0t", i, expected_data[i], data_out, $time);
            end
        end

        // Stop reading
        @(posedge clk);
        rd_en = 0;

        // Final status
        if(Empty)
            $display("FIFO is empty as expected at end of simulation.");
        else
            $display("FIFO is NOT empty at end of simulation.");

        if(!Full)
            $display("FIFO is not full at end of simulation (expected).");
        else
            $display("FIFO is still full at end of simulation, unexpected.");

        #20;
        $finish;
    end

endmodule
