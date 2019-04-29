create_clock -period 5.000 -name REFCLK -waveform {0.000 2.500} -add [get_ports SYS_CLK_P0]
#create_clock -period 5.00000000000000000 -name REFCLK -waveform {0.00000000000000000 2.50000000000000000} -add [get_ports REFCLK]
#create_clock -period 10.00000000000000000 -name SYSCLK -waveform {0.00000000000000000 5.00000000000000000} -add [get_ports CLK100]
#create_clock -period 25.00000000000000000 -name CLK_RX_0 -waveform {0.00000000000000000 12.50000000000000000} -add [get_ports CH0_CLK_P]
create_clock -period 25.000 -name CLK_RX_0 -waveform {0.000 12.500} -add [get_ports CH0_CLK_P]
create_clock -period 25.000 -name CLK_RX_1 -waveform {0.000 12.500} -add [get_ports CH1_CLK_P]
create_clock -period 25.000 -name CLK_RX_2 -waveform {0.000 12.500} -add [get_ports CH2_CLK_P]
#create_clock -period 25.00000000000000000 -name CLK_RX_2 -waveform {0.00000000000000000 12.50000000000000000} -add [get_ports CH2_CLK_P]
create_clock -period 25.000 -name CLK_RX_3 -waveform {0.000 12.500} -add [get_ports CH3_CLK_P]

create_clock -period 25.000 -name QUAD_CLK -waveform {0.000 12.500} -add [get_nets {U4/quad_clk_iob[1]}]

# Virtual clocks
create_clock -period 3.571 -name DCO_0_VIRT -waveform {0.000 1.786}
create_clock -period 3.571 -name DCO_1_VIRT -waveform {0.000 1.786}
create_clock -period 3.571 -name DCO_2_VIRT -waveform {0.000 1.786}
create_clock -period 3.571 -name DCO_3_VIRT -waveform {0.000 1.786}

# Generated clocks

# rename the auto-derived clocks
create_generated_clock -name CLK1X_13 [get_pins U2/CH0/master_gen.pll_inst/plle2_adv_inst/CLKOUT0]
create_generated_clock -name CLK7X_13 [get_pins U2/CH0/master_gen.pll_inst/plle2_adv_inst/CLKOUT1]
create_generated_clock -name CLK1X_12 [get_pins U2/CH3/master_gen.pll_inst/plle2_adv_inst/CLKOUT0]
create_generated_clock -name CLK7X_12 [get_pins U2/CH3/master_gen.pll_inst/plle2_adv_inst/CLKOUT1]

create_generated_clock -name CLK200 [get_pins U14/plle2_adv_inst/CLKOUT0]
create_generated_clock -name CLK100 [get_pins U14/plle2_adv_inst/CLKOUT1]
create_generated_clock -name CLK80 [get_pins U14/plle2_adv_inst/CLKOUT2]

create_generated_clock -name SCLK -source [get_pins U14/plle2_adv_inst/CLKOUT1] -divide_by 1000 [get_nets U1/spi_out/SCL]

set_input_jitter REFCLK 0.002
set_input_jitter CLK_RX_0 0.400
set_input_jitter CLK_RX_1 0.400
set_input_jitter CLK_RX_2 0.400
set_input_jitter CLK_RX_3 0.400
set_input_jitter DCO_0_VIRT 0.060
set_input_jitter DCO_1_VIRT 0.060
set_input_jitter DCO_2_VIRT 0.060
set_input_jitter DCO_3_VIRT 0.060

# Clock Groups


set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets U2/CH1/O]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U14/clk_200_clk_wiz_0_adc_startup]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U14/clk_80_clk_wiz_0_adc_startup]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U14/clk_100_clk_wiz_0_adc_startup]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets U14/clkfbout_clk_wiz_0_adc_startup]
set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets O]

set_false_path -from CLK_RX_0 -to [get_cells U2/CH0/U12/iserdese2_master]
set_false_path -from CLK_RX_3 -to [get_cells U2/CH3/U12/iserdese2_master]
#set_false_path -from CLK_RX_3 -to [get_cells U2/CH1/U12/iserdese2_master]
#set_false_path -from CLK_RX_0 -to [get_cells CH0/U12/iserdese2_master]
#set_false_path -from CLK_RX_1 -to [get_cells CH1/U12/iserdese2_master]
#set_false_path -from CLK_RX_2 -to [get_cells CH2/U12/iserdese2_master]
#set_false_path -from CLK_RX_3 -to [get_cells CH3/U12/iserdese2_master]
#set_false_path -from [get_clocks CLK100] -to [get_clocks CLK1X_12]
#set_false_path -from [get_clocks CLK100] -to [get_clocks CLK1X_13]
#set_false_path -from [get_clocks REFCLK] -to [get_clocks CLK1X_12]
set_false_path -from [get_clocks {REFCLK CLK100}] -to [get_clocks {CLK1X_12 CLK1X_13}]
set_false_path -from [get_clocks {CLK_RX_1 CLK_RX_2}] -to CLK7X_13
set_false_path -from [get_clocks DCO*] -to [get_clocks CLK7X*]
set_false_path -from CLK100 -to SCLK
set_false_path -from SCLK -to CLK100

# Input and output delay constraints

#set_input_delay -clock CLK100 -max 1 [get_ports SPI_SCLK]
#set_input_delay -clock CLK100 -max 0 [get_ports SPI_SDI]
#set_input_delay -clock CLK100 -max 0 [get_ports SPI_SDO]
#set_input_delay -clock CLK100 -max 0 [get_ports SPI_CSN]

#set_input_delay -clock SYSCLK -min 0 [get_ports QUAD_DATA_FLAG]
#set_input_delay -clock SYSCLK -max 10 [get_ports QUAD_DATA_FLAG]
#set_output_delay -clock SYSCLK -min 0 [get_ports QUAD*_DVAL]
#set_output_delay -clock SYSCLK -max 10 [get_ports QUAD*_DVAL]
#set_output_delay -clock SYSCLK -min 0 [get_ports {QUAD1_DATA[*]}]
#set_output_delay -clock SYSCLK -max 10 [get_ports {QUAD1_DATA[*]}]
#set_output_delay -clock SYSCLK -min 0 [get_ports {QUAD2_DATA[*]}]
#set_output_delay -clock SYSCLK -max 10 [get_ports {QUAD2_DATA[*]}]
#set_output_delay -clock SYSCLK -min 0 [get_ports {QUAD3_DATA[*]}]
#set_output_delay -clock SYSCLK -max 10 [get_ports {QUAD3_DATA[*]}]
#set_output_delay -clock SYSCLK -min 0 [get_ports {QUAD4_DATA[*]}]
#set_output_delay -clock SYSCLK -max 10 [get_ports {QUAD4_DATA[*]}]

# physical

set_operating_conditions -grade industrial
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property PACKAGE_PIN A20 [get_ports SELF_RESET]
set_property IOSTANDARD LVCMOS33 [get_ports SELF_RESET]

set_property PACKAGE_PIN P23 [get_ports CH0_CLK_P]
set_property PACKAGE_PIN N21 [get_ports CH1_CLK_P]
set_property PACKAGE_PIN R23 [get_ports CH2_CLK_N]
set_property PACKAGE_PIN AC24 [get_ports CH3_CLK_N]

set_property PACKAGE_PIN T20 [get_ports {CH0_DATA_P[0]}]
set_property PACKAGE_PIN T22 [get_ports {CH0_DATA_P[1]}]
set_property PACKAGE_PIN M21 [get_ports {CH0_DATA_P[2]}]
set_property PACKAGE_PIN T24 [get_ports {CH0_DATA_P[3]}]

set_property PACKAGE_PIN U20 [get_ports {CH1_DATA_N[0]}]
set_property PACKAGE_PIN T19 [get_ports {CH1_DATA_N[1]}]
set_property PACKAGE_PIN K26 [get_ports {CH1_DATA_N[2]}]
set_property PACKAGE_PIN N17 [get_ports {CH1_DATA_N[3]}]

set_property PACKAGE_PIN R18 [get_ports {CH2_DATA_P[0]}]
set_property PACKAGE_PIN U17 [get_ports {CH2_DATA_P[1]}]
set_property PACKAGE_PIN N18 [get_ports {CH2_DATA_P[2]}]
set_property PACKAGE_PIN R16 [get_ports {CH2_DATA_P[3]}]

set_property PACKAGE_PIN W20 [get_ports {CH3_DATA_P[0]}]
set_property PACKAGE_PIN AD23 [get_ports {CH3_DATA_P[1]}]
set_property PACKAGE_PIN AB22 [get_ports {CH3_DATA_P[2]}]
set_property PACKAGE_PIN AB21 [get_ports {CH3_DATA_P[3]}]

set_property PACKAGE_PIN M26 [get_ports DET_CC_N1]
set_property PACKAGE_PIN N24 [get_ports DET_CC_N2]
set_property PACKAGE_PIN L25 [get_ports DET_CC_N3]
set_property PACKAGE_PIN P26 [get_ports DET_CC_N4]
set_property PACKAGE_PIN N26 [get_ports DET_CC_P1]
set_property PACKAGE_PIN P24 [get_ports DET_CC_P2]
set_property PACKAGE_PIN M25 [get_ports DET_CC_P3]
set_property PACKAGE_PIN R26 [get_ports DET_CC_P4]

set_property PACKAGE_PIN M20 [get_ports F_SYNC_N]
set_property PACKAGE_PIN N19 [get_ports F_SYNC_P]
set_property PACKAGE_PIN P25 [get_ports INT_FBK_N]
set_property PACKAGE_PIN R25 [get_ports INT_FBK_P]
#QUAD3_CLK
set_property PACKAGE_PIN L24 [get_ports SER_TC_N]
#QUAD4_CLK
set_property PACKAGE_PIN M24 [get_ports SER_TC_P]
#QUAD1_CLK
set_property PACKAGE_PIN P20 [get_ports SER_TFG_N]
#QUAD2_CLK
set_property PACKAGE_PIN P19 [get_ports SER_TFG_P]
set_property PACKAGE_PIN U16 [get_ports DET_FPA_ON]

set_property PACKAGE_PIN AE21 [get_ports SPI_MUX0]
set_property PACKAGE_PIN AD21 [get_ports SPI_MUX1]
set_property PACKAGE_PIN AF24 [get_ports SPI_SDO]

set_property PACKAGE_PIN R21 [get_ports SYS_CLK_P0]
set_property PACKAGE_PIN AB11 [get_ports SYS_CLK_P1]

set_property PACKAGE_PIN V22 [get_ports SPI_CSN]
set_property PACKAGE_PIN U22 [get_ports SPI_SCLK]
set_property PACKAGE_PIN AF25 [get_ports SPI_SDI]

set_property IOSTANDARD LVDS_25 [get_ports CH0_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH0_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH0_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH0_CLK_N]

set_property IOSTANDARD LVDS_25 [get_ports CH1_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH1_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH1_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH1_CLK_N]

set_property IOSTANDARD LVDS_25 [get_ports CH2_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH2_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH2_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH2_CLK_N]

set_property IOSTANDARD LVDS_25 [get_ports CH3_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH3_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH3_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH3_CLK_N]

set_property IOSTANDARD LVDS_25 [get_ports CH0_DATA_*]
set_property IOSTANDARD LVDS_25 [get_ports CH1_DATA_*]
set_property IOSTANDARD LVDS_25 [get_ports CH2_DATA_*]
set_property IOSTANDARD LVDS_25 [get_ports CH3_DATA_*]

set_property IOSTANDARD LVCMOS25 [get_ports DET_CC_N1]
set_property IOSTANDARD LVCMOS25 [get_ports DET_CC_N2]
set_property IOSTANDARD LVCMOS25 [get_ports DET_CC_N3]
set_property IOSTANDARD LVCMOS25 [get_ports DET_CC_N4]
set_property IOSTANDARD LVCMOS25 [get_ports DET_CC_P1]
set_property IOSTANDARD LVCMOS25 [get_ports DET_CC_P2]
set_property IOSTANDARD LVCMOS25 [get_ports DET_CC_P3]
set_property IOSTANDARD LVCMOS25 [get_ports DET_CC_P4]

set_property IOSTANDARD LVCMOS25 [get_ports F_SYNC_N]
set_property IOSTANDARD LVCMOS25 [get_ports INT_FBK_N]
set_property IOSTANDARD LVCMOS25 [get_ports F_SYNC_P]
set_property IOSTANDARD LVCMOS25 [get_ports INT_FBK_P]
set_property IOSTANDARD LVCMOS25 [get_ports SER_TC_N]
set_property IOSTANDARD LVCMOS25 [get_ports SER_TC_P]
set_property IOSTANDARD LVCMOS25 [get_ports SER_TFG_N]
set_property IOSTANDARD LVCMOS25 [get_ports SER_TFG_P]
set_property IOSTANDARD LVCMOS25 [get_ports DET_FPA_ON]

set_property DRIVE 8 [get_ports SER_TC_P]
set_property DRIVE 8 [get_ports SER_TC_N]
set_property DRIVE 8 [get_ports SER_TFG_P]
set_property DRIVE 8 [get_ports SER_TFG_N]
set_property SLEW SLOW [get_ports SER_TC_P]
set_property SLEW SLOW [get_ports SER_TC_N]
set_property SLEW SLOW [get_ports SER_TFG_P]
set_property SLEW SLOW [get_ports SER_TFG_N]

set_property IOSTANDARD LVCMOS25 [get_ports SPI_MUX0]
set_property IOSTANDARD LVCMOS25 [get_ports SPI_MUX1]
set_property IOSTANDARD LVCMOS25 [get_ports SPI_CSN]
set_property IOSTANDARD LVCMOS25 [get_ports SPI_SCLK]
set_property IOSTANDARD LVCMOS25 [get_ports SPI_SDI]
set_property IOSTANDARD LVCMOS25 [get_ports SPI_SDO]

set_property IOSTANDARD LVDS_25 [get_ports SYS_CLK_P0]
set_property IOSTANDARD LVDS_25 [get_ports SYS_CLK_N0]
set_property DIFF_TERM TRUE [get_ports SYS_CLK_P0]
set_property DIFF_TERM TRUE [get_ports SYS_CLK_N0]
set_property IOSTANDARD DIFF_SSTL135 [get_ports SYS_CLK_P1]
set_property IOSTANDARD DIFF_SSTL135 [get_ports SYS_CLK_N1]
set_property DIFF_TERM FALSE [get_ports SYS_CLK_P1]
set_property DIFF_TERM FALSE [get_ports SYS_CLK_N1]

set_property DIFF_TERM true [get_ports CH0_DATA_*]
set_property DIFF_TERM true [get_ports CH1_DATA_*]
set_property DIFF_TERM true [get_ports CH2_DATA_*]
set_property DIFF_TERM true [get_ports CH3_DATA_*]

set_property IODELAY_GROUP IODBANK13 [get_cells U2/CH0/g0.idelayctrl_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U2/CH0/CLK_delay/delay_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U2/CH0/q*_delay/delay_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U2/CH1/CLK_delay/delay_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U2/CH1/q*_delay/delay_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U2/CH2/CLK_delay/delay_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U2/CH2/q*_delay/delay_inst]

#iogroup define for bank 12 Chan3
set_property IODELAY_GROUP IODBANK12 [get_cells U2/CH3/g0.idelayctrl_inst]
set_property IODELAY_GROUP IODBANK12 [get_cells U2/CH3/CLK_delay/delay_inst]
set_property IODELAY_GROUP IODBANK12 [get_cells U2/CH3/q*_delay/delay_inst]

#set_property IOB TRUE [get_ports CH0_CLK_*]
#set_property IOB TRUE [get_ports CH1_CLK_*]
#set_property IOB TRUE [get_ports CH2_CLK_*]
#set_property IOB TRUE [get_ports CH3_CLK_*]
#set_property IOB TRUE [get_ports CH0_DATA_*]
#set_property IOB TRUE [get_ports CH1_DATA_*]
#set_property IOB TRUE [get_ports CH2_DATA_*]
#set_property IOB TRUE [get_ports CH3_DATA_*]
#set_property IOB FALSE [get_ports {QUAD1_DATA[*]}]
#set_property IOB FALSE [get_ports {QUAD2_DATA[*]}]
#set_property IOB FALSE [get_ports {QUAD3_DATA[*]}]
#set_property IOB FALSE [get_ports {QUAD4_DATA[*]}]
#set_property IOB FALSE [get_ports QUAD1_DVAL]
#set_property IOB FALSE [get_ports QUAD2_DVAL]
#set_property IOB FALSE [get_ports QUAD3_DVAL]
#set_property IOB FALSE [get_ports QUAD4_DVAL]
#set_property IOB FALSE [get_ports QUAD_DATA_FLAG]

#set_property IOB FALSE [get_ports IO_RESET]
#set_property IOB FALSE [get_ports INIT_DONE]
#set_property IOB FALSE [get_ports PWR_DOWN]
#set_property IOB FALSE [get_ports BITSLIP]
#set_property IOB FALSE [get_ports ARESETN]
#set_property IOB FALSE [get_ports REFCLK]
#set_property IOB FALSE [get_ports REF_CLK_RESET]
#set_property IOB FALSE [get_ports CLK100]

set_property DONT_TOUCH true [get_cells U2/CH0/U9]


#set_input_delay -clock [get_clocks CLK_RX_0] -rise 0.000 [get_ports {CH0_CLK_N CH0_CLK_P CH0_DATA_N[0] CH0_DATA_N[1] CH0_DATA_N[2] CH0_DATA_N[3] CH0_DATA_P[0] CH0_DATA_P[1] CH0_DATA_P[2] CH0_DATA_P[3]}]
set_input_delay -clock DCO_0_VIRT -min 0.625 [get_ports CH0*]
set_input_delay -clock DCO_0_VIRT -max 1.161 [get_ports CH0*]
set_input_delay -clock DCO_1_VIRT -min 0.625 [get_ports CH1*]
set_input_delay -clock DCO_1_VIRT -max 1.161 [get_ports CH1*]
set_input_delay -clock DCO_2_VIRT -min 0.625 [get_ports CH2*]
set_input_delay -clock DCO_2_VIRT -max 1.161 [get_ports CH2*]
set_input_delay -clock DCO_3_VIRT -min 0.625 [get_ports CH3*]
set_input_delay -clock DCO_3_VIRT -max 1.161 [get_ports CH3*]
set_input_delay -clock SCLK -clock_fall -max 125.000 [get_ports SPI_SDO]

set_output_delay -clock SCLK -min -5.000 [get_ports SPI_SDI]



