## Timing Constraints Section

# Primary clocks
create_clock -period 100.000 -name CH0_CLK [get_ports CH0_CLK_P]
create_clock -period 100.000 -name CH3_CLK [get_ports CH3_CLK_P]

# Virtual clocks

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH0_CLK]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH3_CLK]

set_clock_groups -asynchronous -group {mclk_source_isc0207A_5_0_MHz_mmcm}
set_clock_groups -asynchronous -group {adc_clk_source_isc0207A_5_0_MHz_mmcm}

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U3/U26/U2/U2/inst/adc_clk_source_isc0207A_5_0_MHz_mmcm]