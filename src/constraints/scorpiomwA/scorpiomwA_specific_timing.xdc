## Timing Constraints Section

# Primary clocks
#create_clock -period 55.556 -name CLK_RX_0 -waveform {0.000 27.778} [get_ports CH0_CLK_P]
#create_clock -period 55.556 -name CLK_RX_1 -waveform {0.000 27.778} [get_ports CH1_CLK_P]
#create_clock -period 25.000 -name CLK_RX_2 -waveform {0.000 12.500} [get_ports CH2_CLK_P]
#create_clock -period 25.000 -name CLK_RX_3 -waveform {0.000 12.500} [get_ports CH3_CLK_P]

# Virtual clocks
#create_clock -period 7.937 -name DCO_0_VIRT -waveform {0.000 3.968}
#create_clock -period 7.937 -name DCO_1_VIRT -waveform {0.000 3.968}
#create_clock -period 3.571 -name DCO_2_VIRT -waveform {0.000 1.786}
#create_clock -period 3.571 -name DCO_3_VIRT -waveform {0.000 1.786}

# Generated clocks


#set_input_jitter CLK_RX_0 0.400
#set_input_jitter CLK_RX_1 0.400
#set_input_jitter CLK_RX_2 0.400
#set_input_jitter CLK_RX_3 0.400
#set_input_jitter DCO_0_VIRT 0.060
#set_input_jitter DCO_1_VIRT 0.060
#set_input_jitter DCO_2_VIRT 0.060
#set_input_jitter DCO_3_VIRT 0.060

# Clock Groups
#set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CLK_RX_0]
#set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CLK_RX_1]
#set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CLK_RX_2]
#set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks CLK_RX_3]

# Input and output delay constraints
#set_input_delay -clock DCO_0_VIRT -min 0.625 [get_ports CH0*]
#set_input_delay -clock DCO_0_VIRT -max 1.161 [get_ports CH0*]
#set_input_delay -clock DCO_1_VIRT -min 0.625 [get_ports CH1*]
#set_input_delay -clock DCO_1_VIRT -max 1.161 [get_ports CH1*]
#set_input_delay -clock DCO_2_VIRT -min 0.625 [get_ports CH2*]
#set_input_delay -clock DCO_2_VIRT -max 1.161 [get_ports CH2*]
#set_input_delay -clock DCO_3_VIRT -min 0.625 [get_ports CH3*]
#set_input_delay -clock DCO_3_VIRT -max 1.161 [get_ports CH3*]


## Timing Exceptions Section
#set_false_path -from [get_clocks mclk_source_scorpiomwA_18MHz_mmcm_1] -to [get_clocks clk_out1_core_clk_wiz_1_0_2]
#set_false_path -from [get_clocks clk_out1_core_clk_wiz_1_0_2] -to [get_clocks mclk_source_scorpiomwA_18MHz_mmcm_1]
#set_false_path -from [get_clocks mclk_source_scorpiomwA_18MHz_mmcm_1] -to [get_clocks clk_out6_core_clk_wiz_1_0_2]
#set_false_path -from [get_clocks clk_out6_core_clk_wiz_1_0_2] -to [get_clocks mclk_source_scorpiomwA_18MHz_mmcm_1]

# False Paths
#set_false_path -from CLK_RX_0 -to [get_cells U1/CH0/U12/iserdese2_master]
#set_false_path -from CLK_RX_1 -to [get_cells U1/CH1/U12/iserdese2_master]
#set_false_path -from CLK_RX_2 -to [get_cells U1/CH2/U12/iserdese2_master]
#set_false_path -from CLK_RX_3 -to [get_cells U1/CH3/U12/iserdese2_master]
#set_false_path -from [get_clocks DCO*] -to [get_clocks clk_7x*]

set_clock_groups -asynchronous -group {mclk_source_scorpiomwA_18MHz_mmcm_1}
set_clock_groups -asynchronous -group {mclk_source_scorpiomwA_18MHz_mmcm}

set_clock_groups -asynchronous -group {adc_phase_clk_scorpiomwA_18MHz_mmcm_1}
set_clock_groups -asynchronous -group {adc_phase_clk_scorpiomwA_18MHz_mmcm}


# Max Delay / Min Delay
# Multicycle Paths
# Case Analysis
# Disable Timing

set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets U1/CH0/CLK_IN]
set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets U1/CH1/CLK_IN]
set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets U1/CH1/O]
#set_property LOC ILOGIC_X0Y99 [get_cells U3/U21/U6/U2/freq_id_reg]
