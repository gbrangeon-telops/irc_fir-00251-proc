## Timing Constraints Section

# Primary clocks
create_clock -period 25.000 -name CH0_CLK_P -waveform {0.000 12.500} [get_ports CH0_CLK_P]
create_clock -period 25.000 -name CH1_CLK_P -waveform {0.000 12.500} [get_ports CH1_CLK_P]

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH0_CLK_P]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH1_CLK_P]


