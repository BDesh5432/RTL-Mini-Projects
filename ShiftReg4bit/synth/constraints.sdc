# Create a clock with 10ns period (100 MHz) on input port clk
create_clock -name clk -period 10 [get_ports clk]

# Set input delay relative to the clock (optional, here 2ns)
set_input_delay 2 -clock clk [get_ports din]

# Set output delay relative to the clock (optional, here 2ns)
set_output_delay 2 -clock clk [get_ports q*]

