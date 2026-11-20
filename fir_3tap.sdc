###################################################################

## timing contstraints
# 500 MHz -> 2ns

create_clock [get_ports clk]  -period 8.0  -waveform {0 1}
set_clock_uncertainty 0.3  [get_clocks clk]

#set_propagated_clock [get_clocks clk]

set_clock_transition -rise 0.05 [get_clocks clk]
set_clock_transition -fall 0.05 [get_clocks clk]

#set_input_delay -clock clk  1.0    [get_ports {A[3]}]
#set_input_delay -clock clk  1.0    [get_ports {A[2]}]
#set_input_delay -clock clk  1.0    [get_ports {A[1]}]
#set_input_delay -clock clk  1.0    [get_ports {A[0]}]
#set_input_delay -clock clk  1.0    [get_ports {B[3]}]
#set_input_delay -clock clk  1.0    [get_ports {B[2]}]
#set_input_delay -clock clk  1.0    [get_ports {B[1]}]
#set_input_delay -clock clk  1.0    [get_ports {B[0]}]
#set_input_delay -clock clk  1.0    [get_ports C_in]
set_input_delay -clock clk   1.2    [all_inputs]


#set_output_delay -clock clk  1.2  [get_ports {SUM[3]}]
#set_output_delay -clock clk  1.2  [get_ports {SUM[2]}]
#set_output_delay -clock clk  1.2  [get_ports {SUM[1]}]
#set_output_delay -clock clk  1.2  [get_ports {SUM[0]}]
#set_output_delay -clock clk  1.2  [get_ports C_out]
set_output_delay -clock clk 1.2 [all_outputs]


#set_load -pin_load 0.0004 [get_ports {SUM[3]}]
#set_load -pin_load 0.0004 [get_ports {SUM[2]}]
#set_load -pin_load 0.0004 [get_ports {SUM[1]}]
#set_load -pin_load 0.0004 [get_ports {SUM[0]}]
#set_load -pin_load 0.0004 [get_ports C_out]
set_load -pin_load 0.0004 [all_outputs]

