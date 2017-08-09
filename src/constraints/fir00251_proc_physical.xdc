## Physical Constraints Section
# located anywhere in the file, preferably before or after the timing constraints
# or stored in a separate constraint file

############### DEVICE PARAMETER ##################
set_operating_conditions -grade industrial
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property DCI_CASCADE {34} [get_iobanks 33]


############### REFERENCE CLOCK ##################
#set_property PACKAGE_PIN R21 [get_ports SYS_CLK_P0]
set_property PACKAGE_PIN P21 [get_ports SYS_CLK_N0]
set_property IOSTANDARD LVDS_25 [get_ports SYS_CLK_P0]
set_property IOSTANDARD LVDS_25 [get_ports SYS_CLK_N0]
set_property DIFF_TERM TRUE [get_ports SYS_CLK_P0]
set_property DIFF_TERM TRUE [get_ports SYS_CLK_N0]

set_property PACKAGE_PIN AB11 [get_ports SYS_CLK_P1]
set_property IOSTANDARD DIFF_SSTL15 [get_ports SYS_CLK_P1]
set_property IOSTANDARD DIFF_SSTL15 [get_ports SYS_CLK_N1]
set_property DIFF_TERM FALSE [get_ports SYS_CLK_P1]
set_property DIFF_TERM FALSE [get_ports SYS_CLK_N1]


####################### GT reference clock LOC #######################

set_property PACKAGE_PIN H5 [get_ports AURORA_CLK_N0]

set_property PACKAGE_PIN D5 [get_ports AURORA_CLK_N1]


############################### GT LOC ###################################

set_property PACKAGE_PIN P1 [get_ports {DATA_UPLINK_N[0]}]
set_property PACKAGE_PIN M1 [get_ports {DATA_UPLINK_N[1]}]
#set_property LOC GTXE2_CHANNEL_X0Y1 [get_cells U7/U3/U0/gt_wrapper_i/data_mgt_multi_gt_i/gt1_data_mgt_i/gtxe2_i] # path non valid

set_property PACKAGE_PIN K1 [get_ports {VIDEO_UPLINK_N[0]}]
set_property PACKAGE_PIN H1 [get_ports {VIDEO_UPLINK_N[1]}]
#set_property LOC GTXE2_CHANNEL_X0Y2 [get_cells U7/U4/U0/gt_wrapper_i/video_mgt_multi_gt_i/gt0_video_mgt_i/gtxe2_i] # path non valid
#set_property LOC GTXE2_CHANNEL_X0Y3 [get_cells U7/U4/U0/gt_wrapper_i/video_mgt_multi_gt_i/gt1_video_mgt_i/gtxe2_i] # path non valid

set_property PACKAGE_PIN F1 [get_ports {PROC_EXP_N[0]}]
set_property PACKAGE_PIN D1 [get_ports {PROC_EXP_N[1]}]

set_property LOC GTXE2_COMMON_X0Y0 [get_cells */ACQ/MGT/MGTS/DATA_COMMON/gtxe2_common_i]
#set_property LOC GTXE2_COMMON_X0Y1 [get_cells U7/MGTS/U0/gt_wrapper_i/mgt_exp_brd_multi_gt_i/gtxe2_common_i] # path non valid

##################### GIGE #######################################
set_property PACKAGE_PIN F25 [get_ports GIGE_BULK_TXD0]
set_property PACKAGE_PIN H21 [get_ports GIGE_SERTC]
set_property PACKAGE_PIN J26 [get_ports GIGE_UART_TXD1]
set_property PACKAGE_PIN E26 [get_ports R_GIGE_BULK_CLK0]
set_property PACKAGE_PIN H26 [get_ports R_GIGE_BULK_RXD0]
set_property PACKAGE_PIN H24 [get_ports R_GIGE_SERTFG]
set_property PACKAGE_PIN G21 [get_ports R_GIGE_UART_RXD1]
set_property IOSTANDARD LVCMOS33 [get_ports GIGE_BULK_TXD0]
set_property IOSTANDARD LVCMOS33 [get_ports GIGE_SERTC]
set_property IOSTANDARD LVCMOS33 [get_ports GIGE_UART_TXD1]
set_property IOSTANDARD LVCMOS33 [get_ports R_GIGE_BULK_CLK0]
set_property IOSTANDARD LVCMOS33 [get_ports R_GIGE_BULK_RXD0]
set_property IOSTANDARD LVCMOS33 [get_ports R_GIGE_SERTFG]
set_property IOSTANDARD LVCMOS33 [get_ports R_GIGE_UART_RXD1]

##################### POWER MANAGMENT ############################
set_property PACKAGE_PIN AF9 [get_ports POWER_ON_ADC_DDC]
set_property PACKAGE_PIN AF13 [get_ports POWER_ON_BUFFER]
set_property PACKAGE_PIN AE13 [get_ports POWER_ON_COOLER]
set_property PACKAGE_PIN AF8 [get_ports POWER_ON_EXPANSION]
set_property PACKAGE_PIN AF10 [get_ports POWER_ON_PLEORA]
set_property PACKAGE_PIN AE8 [get_ports POWER_ON_SFW]
set_property PACKAGE_PIN AE12 [get_ports POWER_ON_SPARE1]
set_property PACKAGE_PIN AF12 [get_ports POWER_ON_SPARE2]
set_property PACKAGE_PIN AD6 [get_ports PWR_SPARE]
set_property IOSTANDARD SSTL15 [get_ports POWER_ON_ADC_DDC]
set_property IOSTANDARD SSTL15 [get_ports POWER_ON_BUFFER]
set_property IOSTANDARD SSTL15 [get_ports POWER_ON_COOLER]
set_property IOSTANDARD SSTL15 [get_ports POWER_ON_EXPANSION]
set_property IOSTANDARD SSTL15 [get_ports POWER_ON_PLEORA]
set_property IOSTANDARD SSTL15 [get_ports POWER_ON_SFW]
set_property IOSTANDARD SSTL15 [get_ports POWER_ON_SPARE1]
set_property IOSTANDARD SSTL15 [get_ports POWER_ON_SPARE2]
set_property IOSTANDARD SSTL15 [get_ports PWR_SPARE]

#################### FLASH MEM #########################
set_property PACKAGE_PIN K20 [get_ports R_FLASH_ALE]
set_property PACKAGE_PIN H19 [get_ports R_FLASH_CE2_N]
set_property PACKAGE_PIN G20 [get_ports R_FLASH_CE_N]
set_property PACKAGE_PIN J20 [get_ports R_FLASH_CLE]
set_property PACKAGE_PIN E20 [get_ports R_FLASH_DQS]
set_property PACKAGE_PIN J15 [get_ports R_FLASH_IO0]
set_property PACKAGE_PIN J16 [get_ports R_FLASH_IO1]
set_property PACKAGE_PIN G15 [get_ports R_FLASH_IO2]
set_property PACKAGE_PIN F15 [get_ports R_FLASH_IO3]
set_property PACKAGE_PIN H16 [get_ports R_FLASH_IO4]
set_property PACKAGE_PIN G16 [get_ports R_FLASH_IO5]
set_property PACKAGE_PIN D15 [get_ports R_FLASH_IO6]
set_property PACKAGE_PIN D16 [get_ports R_FLASH_IO7]
set_property PACKAGE_PIN C17 [get_ports R_FLASH_IO8]
set_property PACKAGE_PIN C18 [get_ports R_FLASH_IO9]
set_property PACKAGE_PIN C19 [get_ports R_FLASH_IO10]
set_property PACKAGE_PIN B19 [get_ports R_FLASH_IO11]
#set_property PACKAGE_PIN B17 [get_ports R_FLASH_IO12]
#set_property PACKAGE_PIN A17 [get_ports R_FLASH_IO13]
#set_property PACKAGE_PIN A18 [get_ports R_FLASH_IO14]
#set_property PACKAGE_PIN A19 [get_ports R_FLASH_IO15]
set_property PACKAGE_PIN J19 [get_ports R_FLASH_RB_N1]
set_property PACKAGE_PIN C16 [get_ports R_FLASH_RB_N2]
set_property PACKAGE_PIN F19 [get_ports R_FLASH_RE_N]
set_property PACKAGE_PIN B16 [get_ports R_FLASH_WE_N]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_CE2_N]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_CE_N]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_CLE]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_DQS]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO0]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO1]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO2]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO3]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO4]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO5]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO6]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO7]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO8]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO9]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO10]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO11]
#set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO12]
#set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO13]
#set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO14]
#set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_IO15]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_RB_N1]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_RB_N2]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_RE_N]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_WE_N]
set_property IOSTANDARD LVCMOS33 [get_ports R_FLASH_ALE]
set_property PULLUP true [get_ports R_FLASH_CE_N]
set_property PULLUP true [get_ports R_FLASH_CE2_N]

################## USB  #############################
set_property PACKAGE_PIN K15 [get_ports {R_ACBUS[0]}]
set_property PACKAGE_PIN M16 [get_ports {R_ACBUS[1]}]
set_property PACKAGE_PIN E16 [get_ports {R_ACBUS[2]}]
set_property PACKAGE_PIN E15 [get_ports {R_ACBUS[3]}]
set_property PACKAGE_PIN F18 [get_ports {R_ACBUS[4]}]
set_property PACKAGE_PIN G17 [get_ports {R_ACBUS[5]}]
set_property PACKAGE_PIN E17 [get_ports {R_ACBUS[6]}]
set_property PACKAGE_PIN F17 [get_ports {R_ACBUS[7]}]
set_property PACKAGE_PIN D18 [get_ports {R_ADBUS[0]}]
set_property PACKAGE_PIN E18 [get_ports {R_ADBUS[1]}]
set_property PACKAGE_PIN H18 [get_ports {R_ADBUS[2]}]
set_property PACKAGE_PIN H17 [get_ports {R_ADBUS[3]}]
set_property PACKAGE_PIN D20 [get_ports {R_ADBUS[4]}]
set_property PACKAGE_PIN D19 [get_ports {R_ADBUS[5]}]
set_property PACKAGE_PIN F20 [get_ports {R_ADBUS[6]}]
set_property PACKAGE_PIN G19 [get_ports {R_ADBUS[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ACBUS[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ACBUS[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ACBUS[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ACBUS[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ADBUS[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ACBUS[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ACBUS[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ACBUS[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ADBUS[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ADBUS[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ADBUS[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ADBUS[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ADBUS[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ACBUS[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ADBUS[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {R_ADBUS[4]}]

set_property PACKAGE_PIN K16 [get_ports USB_EECLK]
set_property PACKAGE_PIN L18 [get_ports USB_EECS]
set_property PACKAGE_PIN K17 [get_ports USB_EEDATA]
set_property PACKAGE_PIN M17 [get_ports USB_RESET_N]
set_property IOSTANDARD LVCMOS33 [get_ports USB_RESET_N]
set_property IOSTANDARD LVCMOS33 [get_ports USB_EEDATA]
set_property IOSTANDARD LVCMOS33 [get_ports USB_EECS]
set_property IOSTANDARD LVCMOS33 [get_ports USB_EECLK]

################### PROM  ##############################
set_property PACKAGE_PIN B24 [get_ports PROC_PROM_D0]
set_property PACKAGE_PIN A25 [get_ports PROC_PROM_D1]
set_property PACKAGE_PIN A22 [get_ports PROC_PROM_D3]
set_property PACKAGE_PIN B22 [get_ports PROC_PROM_D2]
set_property PACKAGE_PIN C23 [get_ports R_PROC_PROM_CS_N]
set_property IOSTANDARD LVCMOS33 [get_ports PROC_PROM_D0]
set_property IOSTANDARD LVCMOS33 [get_ports PROC_PROM_D1]
set_property IOSTANDARD LVCMOS33 [get_ports PROC_PROM_D3]
set_property IOSTANDARD LVCMOS33 [get_ports PROC_PROM_D2]
set_property IOSTANDARD LVCMOS33 [get_ports R_PROC_PROM_CS_N]

################### GPS & IRIG #########################
set_property PACKAGE_PIN G25 [get_ports GPS_PPS_BUF]
set_property PACKAGE_PIN E25 [get_ports GPS_RX_TO_FPGA]
set_property PACKAGE_PIN G26 [get_ports GPS_TX_FROM_FPGA]
set_property IOSTANDARD LVCMOS33 [get_ports GPS_PPS_BUF]
set_property IOSTANDARD LVCMOS33 [get_ports GPS_RX_TO_FPGA]
set_property IOSTANDARD LVCMOS33 [get_ports GPS_TX_FROM_FPGA]

set_property PACKAGE_PIN F23 [get_ports IRIG_B_002_BUF]
set_property PACKAGE_PIN E23 [get_ports IRIG_B_ADC_SDO]
set_property PACKAGE_PIN F24 [get_ports IRIG_B_G0_N]
set_property PACKAGE_PIN G24 [get_ports IRIG_B_G1_N]
set_property PACKAGE_PIN D25 [get_ports IRIG_B_G2_N]
set_property PACKAGE_PIN G22 [get_ports IRIG_B_PPMS]
set_property IOSTANDARD LVCMOS33 [get_ports IRIG_B_002_BUF]
set_property IOSTANDARD LVCMOS33 [get_ports IRIG_B_ADC_SDO]
set_property IOSTANDARD LVCMOS33 [get_ports IRIG_B_G0_N]
set_property IOSTANDARD LVCMOS33 [get_ports IRIG_B_G2_N]
set_property IOSTANDARD LVCMOS33 [get_ports IRIG_B_G1_N]
set_property IOSTANDARD LVCMOS33 [get_ports IRIG_B_PPMS]

set_property PACKAGE_PIN F22 [get_ports R_IRIG_B_ADC_SCLK]
set_property PACKAGE_PIN D23 [get_ports R_IRIG_B_ADC_CS_N]
set_property IOSTANDARD LVCMOS33 [get_ports R_IRIG_B_ADC_SCLK]
set_property IOSTANDARD LVCMOS33 [get_ports R_IRIG_B_ADC_CS_N]


################### ADC Readout #########################
set_property PACKAGE_PIN U21 [get_ports ADC798x_SDI]
set_property PACKAGE_PIN Y20 [get_ports ADC798x_SDO]
set_property PACKAGE_PIN Y26 [get_ports ADC798x_SCLK]
set_property PACKAGE_PIN Y25 [get_ports ADC798x_Cnv]
set_property IOSTANDARD LVCMOS25 [get_ports ADC798x_SDI]
set_property IOSTANDARD LVCMOS25 [get_ports ADC798x_SDO]
set_property IOSTANDARD LVCMOS25 [get_ports ADC798x_SCLK]
set_property IOSTANDARD LVCMOS25 [get_ports ADC798x_Cnv]
set_property PULLUP true [get_ports ADC798x_SDO]

################### XADC ################################
set_property PACKAGE_PIN P11 [get_ports PROC_XADC_VN]
#set_property IOSTANDARD LVCMOS18 [get_ports PROC_XADC_VP]
#set_property IOSTANDARD LVCMOS18 [get_ports PROC_XADC_VN]


set_property PACKAGE_PIN C26 [get_ports {XADC_MUX[0]}]
set_property PACKAGE_PIN A23 [get_ports {XADC_MUX[1]}]
set_property PACKAGE_PIN A24 [get_ports {XADC_MUX[2]}]
set_property PACKAGE_PIN B25 [get_ports {XADC_MUX[3]}]
set_property PACKAGE_PIN L19 [get_ports {XADC_MUX[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {XADC_MUX[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {XADC_MUX[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {XADC_MUX[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {XADC_MUX[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {XADC_MUX[4]}]

################### SFW  & SHUTTER ################################
set_property PACKAGE_PIN K21 [get_ports SFW_ENCA]
set_property PACKAGE_PIN L23 [get_ports SFW_ENCB]
set_property PACKAGE_PIN B21 [get_ports SFW_INDEX]
set_property PACKAGE_PIN C21 [get_ports SFW_RX_TO_FPGA]
set_property PACKAGE_PIN D24 [get_ports SFW_TX_FROM_FPGA]
set_property IOSTANDARD LVCMOS33 [get_ports SFW_ENCA]
set_property IOSTANDARD LVCMOS33 [get_ports SFW_TX_FROM_FPGA]
set_property IOSTANDARD LVCMOS33 [get_ports SFW_RX_TO_FPGA]
set_property IOSTANDARD LVCMOS33 [get_ports SFW_INDEX]
set_property IOSTANDARD LVCMOS33 [get_ports SFW_ENCB]

set_property PACKAGE_PIN D21 [get_ports SHUTTER_INA]
set_property PACKAGE_PIN C22 [get_ports SHUTTER_INB]
set_property IOSTANDARD LVCMOS33 [get_ports SHUTTER_INB]
set_property IOSTANDARD LVCMOS33 [get_ports SHUTTER_INA]

################### FAN ################################
set_property PACKAGE_PIN B26 [get_ports EXTERNAL_FAN_PWM]
set_property PACKAGE_PIN B20 [get_ports INTERNAL_FAN_PWM]
set_property PACKAGE_PIN E21 [get_ports FPGA_PROC_PWM]
set_property IOSTANDARD LVCMOS33 [get_ports EXTERNAL_FAN_PWM]
set_property IOSTANDARD LVCMOS33 [get_ports INTERNAL_FAN_PWM]
set_property IOSTANDARD LVCMOS33 [get_ports FPGA_PROC_PWM]


################### Power Managment ######################
set_property PACKAGE_PIN T7 [get_ports LED_RED]
set_property PACKAGE_PIN U4 [get_ports LED_GREEN]
set_property PACKAGE_PIN AA3 [get_ports LED_YELLOW]
set_property PACKAGE_PIN A20 [get_ports SELF_RESET]
set_property PACKAGE_PIN AD11 [get_ports BUTTON]
set_property IOSTANDARD SSTL15 [get_ports LED_RED]
set_property IOSTANDARD SSTL15 [get_ports LED_GREEN]
set_property IOSTANDARD SSTL15 [get_ports LED_YELLOW]
set_property IOSTANDARD LVCMOS33 [get_ports SELF_RESET]
set_property IOSTANDARD SSTL15 [get_ports BUTTON]

################### BOARD HW REV  #######################
set_property IOSTANDARD LVCMOS33 [get_ports  {REV_GPIO[*]}]
set_property PACKAGE_PIN B17 [get_ports REV_GPIO[3]]
set_property PACKAGE_PIN A17 [get_ports REV_GPIO[2]]
set_property PACKAGE_PIN A18 [get_ports REV_GPIO[1]]
set_property PACKAGE_PIN A19 [get_ports REV_GPIO[0]]


################### TRIG ################################
set_property PACKAGE_PIN D26 [get_ports R_TRIG_OUT]
set_property PACKAGE_PIN C24 [get_ports TRIG_IN_BUF]
set_property IOSTANDARD LVCMOS33 [get_ports R_TRIG_OUT]
set_property IOSTANDARD LVCMOS33 [get_ports TRIG_IN_BUF]

################### PRESENT SIGNAL ######################
set_property PACKAGE_PIN K23 [get_ports PWR_PRSNT_N]
set_property PACKAGE_PIN L22 [get_ports JTAG_PRSNT_N]
set_property PACKAGE_PIN K22 [get_ports BUFFER_PRSNT_N]
set_property PACKAGE_PIN J23 [get_ports EXP_PRSNT_N]
set_property IOSTANDARD LVCMOS33 [get_ports PWR_PRSNT_N]
set_property IOSTANDARD LVCMOS33 [get_ports JTAG_PRSNT_N]
set_property IOSTANDARD LVCMOS33 [get_ports BUFFER_PRSNT_N]
set_property IOSTANDARD LVCMOS33 [get_ports EXP_PRSNT_N]

################### FPGA COM ######################

set_property PACKAGE_PIN AD10 [get_ports FPGA_TO_FPGA0]
set_property PACKAGE_PIN AE10 [get_ports FPGA_TO_FPGA1]
set_property PACKAGE_PIN V11 [get_ports FPGA_TO_FPGA2]
set_property PACKAGE_PIN W11 [get_ports FPGA_TO_FPGA3]
set_property IOSTANDARD SSTL15 [get_ports FPGA_TO_FPGA0]
set_property IOSTANDARD SSTL15 [get_ports FPGA_TO_FPGA1]
set_property IOSTANDARD SSTL15 [get_ports FPGA_TO_FPGA2]
set_property IOSTANDARD SSTL15 [get_ports FPGA_TO_FPGA3]

#Signal not present on Kc70
set_property PACKAGE_PIN V13 [get_ports WATER_LEVEL]
set_property PACKAGE_PIN W13 [get_ports FPGA_TO_FPGA5]
#set_property PACKAGE_PIN AC16 [get_ports FPGA_TO_FPGA6]
#set_property PACKAGE_PIN W14 [get_ports FPGA_TO_FPGA7]
#set_property PACKAGE_PIN W8 [get_ports FPGA_TO_FPGA8]
set_property IOSTANDARD SSTL15 [get_ports WATER_LEVEL]
set_property IOSTANDARD SSTL15 [get_ports FPGA_TO_FPGA5]
#set_property IOSTANDARD SSTL15 [get_ports FPGA_TO_FPGA6]
#set_property IOSTANDARD SSTL15 [get_ports FPGA_TO_FPGA7]
#set_property IOSTANDARD SSTL15 [get_ports FPGA_TO_FPGA8]

set_property PACKAGE_PIN H22 [get_ports OEM_RX_TO_FPGA]
set_property PACKAGE_PIN H23 [get_ports OEM_TX_FROM_FPGA]
set_property IOSTANDARD LVCMOS33 [get_ports OEM_RX_TO_FPGA]
set_property IOSTANDARD LVCMOS33 [get_ports OEM_TX_FROM_FPGA]


################### Others  ###########################

set_property PACKAGE_PIN L17 [get_ports VIDEO_FAULT1_N]
set_property PACKAGE_PIN K18 [get_ports VIDEO_FAULT2_N]
set_property IOSTANDARD LVCMOS33 [get_ports VIDEO_FAULT2_N]
set_property IOSTANDARD LVCMOS33 [get_ports VIDEO_FAULT1_N]

set_property PACKAGE_PIN J18 [get_ports FPGA_OUT_INIT_B]
set_property IOSTANDARD LVCMOS33 [get_ports FPGA_OUT_INIT_B]

set_property PACKAGE_PIN J21 [get_ports COOLER_READY]
set_property IOSTANDARD LVCMOS33 [get_ports COOLER_READY]

set_property PACKAGE_PIN J24 [get_ports COOLER_RX_TO_FPGA]
set_property PACKAGE_PIN J25 [get_ports COOLER_TX_FROM_FPGA]
set_property IOSTANDARD LVCMOS33 [get_ports COOLER_RX_TO_FPGA]
set_property IOSTANDARD LVCMOS33 [get_ports COOLER_TX_FROM_FPGA]

set_property PACKAGE_PIN L20 [get_ports DDR_POWERGOOD]
set_property IOSTANDARD LVCMOS33 [get_ports DDR_POWERGOOD]

set_property PACKAGE_PIN E22 [get_ports DEBUG_LED_N]
set_property IOSTANDARD LVCMOS33 [get_ports DEBUG_LED_N]

#set_property LOC BSCAN_X0Y1 [get_cells BD/core_wrapper_i/core_i/MCU/mdm_1/U0/Use_E2.BSCANE2_I]













