## Timing Constraints Section

# Primary clocks
create_clock -period 30.000 -name CLK_DATA_IN [get_ports CLK_DATA_P]

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CLK_DATA_IN]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_ddr_calciumD_clks_mmcm]
