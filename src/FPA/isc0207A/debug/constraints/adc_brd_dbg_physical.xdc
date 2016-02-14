
############### DEVICE PARAMETER ##################
set_operating_conditions -grade industrial
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

############### REFERENCE CLOCK ##################
#set_property PACKAGE_PIN R21 [get_ports SYS_CLK_P0]
set_property PACKAGE_PIN P21 [get_ports SYS_CLK_N0]
set_property IOSTANDARD LVDS_25 [get_ports SYS_CLK_P0]
set_property IOSTANDARD LVDS_25 [get_ports SYS_CLK_N0]
set_property DIFF_TERM TRUE [get_ports SYS_CLK_P0]
set_property DIFF_TERM TRUE [get_ports SYS_CLK_N0]

# quads clks sources                                                         
set_property PACKAGE_PIN L24 [get_ports QUAD3_CLK]
set_property PACKAGE_PIN M24 [get_ports QUAD4_CLK]
set_property PACKAGE_PIN P20 [get_ports QUAD1_CLK]
set_property PACKAGE_PIN P19 [get_ports QUAD2_CLK]
set_property IOSTANDARD LVCMOS25 [get_ports QUAD3_CLK]
set_property IOSTANDARD LVCMOS25 [get_ports QUAD4_CLK]
set_property IOSTANDARD LVCMOS25 [get_ports QUAD1_CLK]
set_property IOSTANDARD LVCMOS25 [get_ports QUAD2_CLK]

# fpa_freq_id
set_property IOSTANDARD LVCMOS25 [get_ports FPA_FREQ_ID]
set_property IOB TRUE [get_ports FPA_FREQ_ID]
set_property PULLDOWN true [get_ports FPA_FREQ_ID]

# spi signals                                                                           
set_property PACKAGE_PIN U22 [get_ports SPI_SCLK]
set_property PACKAGE_PIN AF25 [get_ports SPI_SDI]
set_property PACKAGE_PIN AF24 [get_ports SPI_SDO]
set_property IOSTANDARD LVCMOS25 [get_ports SPI_*]
#set_property PULLDOWN true [get_ports SPI_SDO]
set_property IOB TRUE [get_ports SPI_SDO]
set_property IOB TRUE [get_ports SPI_CSN]
set_property IOB TRUE [get_ports SPI_MUX0]
set_property IOB TRUE [get_ports SPI_MUX1]
set_property IOB TRUE [get_ports SPI_SCLK]
set_property IOB TRUE [get_ports SPI_SDI]

############### DESERIALIZERS ##################
# quad1 outputs clock
set_property PACKAGE_PIN P23 [get_ports CH0_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH0_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH0_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH0_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH0_CLK_N]

# quad2 outputs clock
set_property PACKAGE_PIN N21 [get_ports CH1_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH1_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH1_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH1_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH1_CLK_N]

# quad3 outputs clock
set_property PACKAGE_PIN R23 [get_ports CH2_CLK_N]
set_property IOSTANDARD LVDS_25 [get_ports CH2_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH2_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH2_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH2_CLK_N]

# quad4 outputs clock
set_property PACKAGE_PIN AC24 [get_ports CH3_CLK_N]
set_property IOSTANDARD LVDS_25 [get_ports CH3_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH3_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH3_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH3_CLK_N]

# quad1 (adc1 to adc4) data link
set_property PACKAGE_PIN R20 [get_ports {CH0_DATA_N[0]}]
set_property PACKAGE_PIN T23 [get_ports {CH0_DATA_N[1]}]
set_property PACKAGE_PIN M22 [get_ports {CH0_DATA_N[2]}]
set_property PACKAGE_PIN T25 [get_ports {CH0_DATA_N[3]}]
set_property IOSTANDARD LVDS_25 [get_ports CH0_DATA_*]
set_property DIFF_TERM true [get_ports CH0_DATA_*]

# quad2 (adc5 to adc8) data link                                                                
set_property PACKAGE_PIN U20 [get_ports {CH1_DATA_N[0]}]
set_property PACKAGE_PIN T19 [get_ports {CH1_DATA_N[1]}]
set_property PACKAGE_PIN K26 [get_ports {CH1_DATA_N[2]}]
set_property PACKAGE_PIN N17 [get_ports {CH1_DATA_N[3]}]
set_property IOSTANDARD LVDS_25 [get_ports CH1_DATA_*]
set_property DIFF_TERM true [get_ports CH1_DATA_*]

# quad3 (adc9 to adc12) data link                                                                              
set_property PACKAGE_PIN P18 [get_ports {CH2_DATA_N[0]}]
set_property PACKAGE_PIN T17 [get_ports {CH2_DATA_N[1]}]
set_property PACKAGE_PIN M19 [get_ports {CH2_DATA_N[2]}]
set_property PACKAGE_PIN R17 [get_ports {CH2_DATA_N[3]}]
set_property IOSTANDARD LVDS_25 [get_ports CH2_DATA_*]
set_property DIFF_TERM true [get_ports CH2_DATA_*]

# quad4 (adc13 to adc16) data link                                                                            
set_property PACKAGE_PIN Y21 [get_ports {CH3_DATA_N[0]}]
set_property PACKAGE_PIN AD24 [get_ports {CH3_DATA_N[1]}]
set_property PACKAGE_PIN AC22 [get_ports {CH3_DATA_N[2]}]
set_property PACKAGE_PIN AC21 [get_ports {CH3_DATA_N[3]}]
set_property IOSTANDARD LVDS_25 [get_ports CH3_DATA_*]
set_property DIFF_TERM true [get_ports CH3_DATA_*]

#iogroup define for bank13                                                   
set_property IODELAY_GROUP IODBANK13 [get_cells U1/CH0/g0.idelayctrl_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U1/CH0/CLK_delay/delay_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U1/CH0/q*_delay/delay_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U1/CH1/CLK_delay/delay_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U1/CH1/q*_delay/delay_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U1/CH2/CLK_delay/delay_inst]
set_property IODELAY_GROUP IODBANK13 [get_cells U1/CH2/q*_delay/delay_inst]

#iogroup define for bank12                                                    
set_property IODELAY_GROUP IODBANK12 [get_cells U1/CH3/g0.idelayctrl_inst]
set_property IODELAY_GROUP IODBANK12 [get_cells U1/CH3/CLK_delay/delay_inst]
set_property IODELAY_GROUP IODBANK12 [get_cells U1/CH3/q*_delay/delay_inst]








