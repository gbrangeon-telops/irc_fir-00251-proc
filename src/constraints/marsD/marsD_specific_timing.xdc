## Timing Constraints Section

# Primary clocks
create_clock -period 37.500 -name CH0_CLK -waveform {0.000 18.750} [get_ports CH0_CLK_P]

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH0_CLK]

