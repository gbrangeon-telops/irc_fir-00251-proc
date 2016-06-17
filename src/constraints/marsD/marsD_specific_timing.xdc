## Timing Constraints Section

# Primary clocks
create_clock -period 37.500 -name CH0_CLK_P -waveform {0.000 18.750} [get_ports CH0_CLK_P]
create_clock -period 37.500 -name CH1_CLK_P -waveform {0.000 18.750} [get_ports CH1_CLK_P]

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH0_CLK_P]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH1_CLK_P]


set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets CLINK/clk_ch0]
