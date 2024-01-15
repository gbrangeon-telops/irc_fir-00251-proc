## Timing Constraints Section

# Primary clocks
create_clock -period 28.571 -name CH0_CLK [get_ports CH0_CLK_P]
create_clock -period 28.571 -name CH3_CLK [get_ports CH3_CLK_P]


# Virtual clocks

# Generated clocks

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH0_CLK]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH3_CLK]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks mclk_source_*]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks quad*_clk_source_*]

# Input and output delay constraints


## Timing Exceptions Section

# False Paths

# Max Delay / Min Delay
# Multicycle Paths
# Case Analysis
# Disable Timing

