## Timing Constraints Section

# Primary clocks
create_clock -period 100.000 -name CH0_CLK [get_ports CH0_CLK_P]
create_clock -period 100.000 -name CH3_CLK [get_ports CH3_CLK_P]

# Virtual clocks

# Generated clocks

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH0_CLK]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH3_CLK]

# Clock Groups
set_clock_groups -asynchronous -group {get_clocks -include_generated_clocks mclk_source_suphawkA_10_0_MHz_mmcm}
set_clock_groups -asynchronous -group {get_clocks -include_generated_clocks adc_clk_source_suphawkA_10_0_MHz_mmcm}

set_clock_groups -asynchronous -group {get_clocks -include_generated_clocks mclk_source_suphawkA_10_0_MHz_mmcm_1}
set_clock_groups -asynchronous -group {get_clocks -include_generated_clocks adc_clk_source_suphawkA_10_0_MHz_mmcm_1}

# Input and output delay constraints


## Timing Exceptions Section

# False Paths
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U3/U26/U2/U2/inst/adc_clk_source_suphawkA_10_0_MHz_mmcm] 



# Max Delay / Min Delay
# Multicycle Paths
# Case Analysis
# Disable Timing

