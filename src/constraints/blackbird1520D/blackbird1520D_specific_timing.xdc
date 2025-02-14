## Timing Constraints Section

# Primary clocks
create_clock -period 14.286 -name CH0_CLK_P -waveform {0.000 7.143} [get_ports CH0_CLK_P]
#create_clock -period 14.286 -name CH1_CLK_P -waveform {0.000 7.143} [get_ports CH1_CLK_P]
#create_clock -period 14.286 -name CH2_CLK_P -waveform {0.000 7.143} [get_ports CH2_CLK_P]
create_clock -period 14.286 -name CH3_CLK_P -waveform {0.000 7.143} [get_ports CH3_CLK_P]

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH0_CLK_P]
#set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH1_CLK_P]
#set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH2_CLK_P]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CH3_CLK_P]

set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_140_bb1920D_clks_mmcm]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_100_bb1920D_clks_mmcm]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_70_bb1920D_clks_mmcm]
