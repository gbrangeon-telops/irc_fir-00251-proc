## Timing Constraints Section
create_clock -period 25.000 -name mclk_source -waveform {0.000 12.500} [get_pins U3/U26/U2/MCLK_5_0M_Gen.U10M/U0/mclk_source]
create_clock -period 12.500 -name quad_phase_clk -waveform {0.000 6.250}  [get_pins U3/U26/U2/MCLK_5_0M_Gen.U10M/U0/quad_phase_clk]

create_clock -period 100.000 -name CLK_RX_0 -waveform {0.000 50.000} [get_ports CH0_CLK_P]
create_clock -period 100.000 -name CLK_RX_1 -waveform {0.000 50.000} [get_ports CH1_CLK_P]
create_clock -period 100.000 -name CLK_RX_2 -waveform {0.000 50.000} [get_ports CH2_CLK_P]
create_clock -period 100.000 -name CLK_RX_3 -waveform {0.000 50.000} [get_ports CH3_CLK_P]

# Virtual clocks
create_clock -period 14.286 -name DCO_0_VIRT -waveform {0.000 7.143}
create_clock -period 14.286 -name DCO_1_VIRT -waveform {0.000 7.143}
create_clock -period 14.286 -name DCO_2_VIRT -waveform {0.000 7.143}
create_clock -period 14.286 -name DCO_3_VIRT -waveform {0.000 7.143}

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks mclk_source]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks quad_phase_clk]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CLK_RX_0]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CLK_RX_1]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CLK_RX_2]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CLK_RX_3]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U3/U26/U2/MCLK_5_0M_Gen.U10M/U0/mclk_source]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/U8/U0/clk_20M_mmcm_clk_20MHz]
set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets U1/CH0/n_0_U7]
set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets U1/CH0/CLK_IN]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/U8/U0/clkfbout_mmcm_clk_20MHz]