## Timing Constraints Section

# Primary clocks
create_clock -period 60.000 -name CH0_CLK [get_ports CH0_CLK_P]
create_clock -period 60.000 -name CH3_CLK [get_ports CH3_CLK_P]


# Virtual clocks

# Generated clocks

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH0_CLK]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH3_CLK]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks mclk_source_isc0207A_3k_8_3_MHz_mmcm]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks quad_clk_source_isc0207A_3k_8_3_MHz_mmcm]


# Input and output delay constraints


## Timing Exceptions Section

# False Paths

# Max Delay / Min Delay
# Multicycle Paths
# Case Analysis
# Disable Timing

