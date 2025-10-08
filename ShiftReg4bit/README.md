# 4-bit Shift Register | RTL to Pre-PD STA

## Overview
This project implements a 4-bit shift register and performs RTL to Pre-Physical Design Static Timing Analysis (STA) using gscl45nm standard cell library.

## Tools Used
- Synthesis: Yosys  
- Timing Analysis: OpenSTA  
- Simulation: Icarus Verilog   
- Library: GSCL45nm.lib

## Steps Performed
1. RTL Design of 4-bit shift register  
2. Functional Simulation (testbench verification)  
3. Synthesis with GSCL45nm 45nm standard cell library  
4. STA (Setup and Hold Analysis) before placement and routing  

## Results
- Verified shift register behavior from VCD waveform  
- Generated synthesized netlist and timing reports  
- Checked setup/hold timing using constraints.sdc  