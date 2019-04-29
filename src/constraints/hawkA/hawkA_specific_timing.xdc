## Timing Constraints Section

# Primary clocks
create_clock -period 100.000 -name CH0_CLK [get_ports CH0_CLK_P]

# Virtual clocks

# Generated clocks

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH0_CLK]
set_clock_groups -asynchronous -group {get_clocks -include_generated_clocks mclk_source_hawkA_10MHz_mmcm}
set_clock_groups -asynchronous -group {get_clocks -include_generated_clocks adc_clk_source_hawkA_10MHz_mmcm}


# Input and output delay constraints


## Timing Exceptions Section

# False Paths


# Max Delay / Min Delay
# Multicycle Paths
# Case Analysis
# Disable Timing

