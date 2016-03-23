## Timing Assertions Section

# Primary clocks

#create_clock -period 25.000 -name CH0_CLK_P -waveform {0.000 12.500} [get_ports CH0_CLK_P]
#create_clock -period 25.000 -name CH1_CLK_P -waveform {0.000 12.500} [get_ports CH1_CLK_P]
#create_clock -period 25.000 -name CH2_CLK_P -waveform {0.000 12.500} [get_ports CH2_CLK_P]
#create_clock -period 25.000 -name CH2_CLK_P -waveform {0.000 12.500} [get_ports CH3_CLK_P]

#create_clock -period 5.000 -name REFCLK -waveform {0.000 2.500} -add [get_ports SYS_CLK_P0]

create_clock -period 25.000 -name CLK_RX_0 -waveform {0.000 12.500} [get_ports CH0_CLK_P]
create_clock -period 25.000 -name CLK_RX_1 -waveform {0.000 12.500} [get_ports CH1_CLK_P]
#create_clock -period 25.000 -name CLK_RX_2 -waveform {0.000 12.500} [get_ports CH2_CLK_P]
#create_clock -period 25.000 -name CLK_RX_3 -waveform {0.000 12.500} -add [get_ports CH3_CLK_P]

create_clock -period 25.000 -name QUAD_CLK -waveform {0.000 12.500} -add [get_nets {U3/U26/quad_clk_iob[1]}]

# Virtual clocks
create_clock -period 3.571 -name DCO_0_VIRT -waveform {0.000 1.786}
create_clock -period 3.571 -name DCO_1_VIRT -waveform {0.000 1.786}
#create_clock -period 3.571 -name DCO_2_VIRT -waveform {0.000 1.786}
#create_clock -period 3.571 -name DCO_3_VIRT -waveform {0.000 1.786}

# Generated clocks

# rename the auto-derived clocks
create_generated_clock -name CLK1X_13 [get_pins U1/CH0/master_gen.pll_inst/plle2_adv_inst/CLKOUT0]
create_generated_clock -name CLK7X_13 [get_pins U1/CH0/master_gen.pll_inst/plle2_adv_inst/CLKOUT1]
#create_generated_clock -name CLK1X_12 [get_pins U1/CH3/master_gen.pll_inst/plle2_adv_inst/CLKOUT0]
#create_generated_clock -name CLK7X_12 [get_pins U1/CH3/master_gen.pll_inst/plle2_adv_inst/CLKOUT1]

set_input_jitter BDCLK200 0.002
set_input_jitter CLK_RX_0 0.400
set_input_jitter CLK_RX_1 0.400
#set_input_jitter CLK_RX_2 0.400
#set_input_jitter CLK_RX_3 0.400
set_input_jitter DCO_0_VIRT 0.060
set_input_jitter DCO_1_VIRT 0.060
#set_input_jitter DCO_2_VIRT 0.060
#set_input_jitter DCO_3_VIRT 0.060

# Clock Groups

set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets U1/CH1/O]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U14/clk_200_clk_wiz_0_adc_startup]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U14/clk_80_clk_wiz_0_adc_startup]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U14/clk_100_clk_wiz_0_adc_startup]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U14/clkfbout_clk_wiz_0_adc_startup]
#set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets O]

set_false_path -from CLK_RX_0 -to [get_cells U1/CH0/U12/iserdese2_master]
#set_false_path -from CLK_RX_3 -to [get_cells U1/CH3/U12/iserdese2_master]
#set_false_path -from CLK_RX_3 -to [get_cells U1/CH1/U12/iserdese2_master]
#set_false_path -from CLK_RX_0 -to [get_cells CH0/U12/iserdese2_master]
#set_false_path -from CLK_RX_1 -to [get_cells CH1/U12/iserdese2_master]
#set_false_path -from CLK_RX_2 -to [get_cells CH2/U12/iserdese2_master]
#set_false_path -from CLK_RX_3 -to [get_cells CH3/U12/iserdese2_master]
#set_false_path -from [get_clocks CLK100] -to [get_clocks CLK1X_12]
#set_false_path -from [get_clocks CLK100] -to [get_clocks CLK1X_13]
#set_false_path -from [get_clocks REFCLK] -to [get_clocks CLK1X_12]
set_false_path -from [get_clocks {BDCLK200 BDCLK100}] -to [get_clocks {CLK1X_12 CLK1X_13}]
set_false_path -from [get_clocks {CLK_RX_1 CLK_RX_2}] -to CLK7X_13
set_false_path -from [get_clocks DCO*] -to [get_clocks CLK7X*]
set_false_path -from BDCLK100 -to SCLK
set_false_path -from SCLK -to BDCLK100

# Input and output delay constraints

## Timing Exceptions Section
# False Paths
# Max Delay / Min Delay
# Multicycle Paths
# Case Analysis
# Disable Timing

#set_input_delay -clock DCO_0_VIRT -min 0.625 [get_ports CH0*]
#set_input_delay -clock DCO_0_VIRT -max 1.161 [get_ports CH0*]
#set_input_delay -clock DCO_1_VIRT -min 0.625 [get_ports CH1*]
#set_input_delay -clock DCO_1_VIRT -max 1.161 [get_ports CH1*]
#set_input_delay -clock DCO_2_VIRT -min 0.625 [get_ports CH2*]
#set_input_delay -clock DCO_2_VIRT -max 1.161 [get_ports CH2*]
#set_input_delay -clock DCO_3_VIRT -min 0.625 [get_ports CH3*]
#set_input_delay -clock DCO_3_VIRT -max 1.161 [get_ports CH3*]
set_input_delay -clock SCLK -clock_fall -max 125.000 [get_ports SPI_SDO]

set_output_delay -clock SCLK -min -5.000 [get_ports SPI_SDI]

set_property LOC ILOGIC_X0Y99 [get_cells U3/U21/U6/U2/freq_id_reg]
