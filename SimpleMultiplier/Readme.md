Serial Multiplier (Verilog)

A modular serial shift-add multiplier implemented in Verilog with separate datapath and control path modules. Verified using Icarus Verilog and GTKWave.

Features:
1.Clear separation between datapath (Mul_DP) and control (Mul_CP) logic.
2.Modular design using PIPO registers, counter, comparator, and adder.
3.Includes testbench for functional verification.

Project Structure:
src/    # Contains all Verilog source modules (datapath, control, components)
tb/     # Testbench files

How to Run:
iverilog -o mul_tb tb/Mul_TB.v src/*.v
vvp mul_tb
gtkwave mul_tb.vcd

Future Improvements:
Add parameterized bit-width support.
