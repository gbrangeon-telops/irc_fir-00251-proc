## Timing Constraints Section

# Primary clocks
create_clock -period 30.000 -name CLK_DATA_IN [get_ports CLK_DATA_P]

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CLK_DATA_IN]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_ddr_calciumD_clks_mmcm]

# BRAM property (XPM uses less BRAM)
set_property RAM_DECOMP power [get_cells FPA/U9/U5/U4/xpm_memory_sdpram_inst/xpm_memory_base_inst/gen_wr_a.gen_word_narrow.mem_reg*]
