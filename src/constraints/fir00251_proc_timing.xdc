## Timing Constraints Section

# Primary clocks
create_clock -period 5.000 -name SYS_CLK_0 -waveform {0.000 2.500} [get_ports SYS_CLK_P0]
create_clock -period 5.000 -name SYS_CLK_1 -waveform {0.000 2.500} [get_ports SYS_CLK_P1]
create_clock -period 8.000 -name MGT_CLK_0 -waveform {0.000 4.000} [get_ports AURORA_CLK_P0]
create_clock -period 8.000 -name MGT_CLK_1 -waveform {0.000 4.000} [get_ports AURORA_CLK_P1]
create_clock -period 8.000 -name data_mgt_tx_out_clk [get_pins *TXOUTCLK -hier -filter {name =~ *gt0_data_mgt*}]
create_clock -period 8.000 -name video_mgt_tx_out_clk [get_pins *TXOUTCLK -hier -filter {name =~ *gt0_video_mgt*}]
create_clock -period 8.000 -name exp_mgt_tx_out_clk [get_pins *TXOUTCLK -hier -filter {name =~ *gt0_exp_mgt*}]
create_clock -period 8.000 -name data_mgt_user_clk_i [get_pins -hier DATA/user_clk]
create_clock -period 8.000 -name exp_mgt_user_clk_i [get_pins -hier EXP/user_clk]
create_clock -period 60.000 -name usart_clk_in [get_ports R_GIGE_BULK_CLK0]
create_clock -period 60.000 -name usart_clk [get_pins *CLKOUT0 -hier -filter {name =~ *BULK_USART*}]

# Virtual clocks

# Generated clocks

# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks SYS_CLK_0]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks SYS_CLK_1]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks MGT_CLK_0]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks MGT_CLK_1]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks data_mgt_tx_out_clk]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks video_mgt_tx_out_clk]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks exp_mgt_tx_out_clk]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks data_mgt_user_clk_i]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks exp_mgt_user_clk_i]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks usart_clk]

# Input and output delay constraints
#set_output_delay [get_ports R_GIGE_BULK_RXD0]
#set_input_delay [get_ports GIGE_BULK_TXD0]
#set_disable_timing [get_ports R_FLASH_ALE]
#set_disable_timing [get_ports R_FLASH_CE2_N]
#set_disable_timing [get_ports R_FLASH_CE_N]
#set_disable_timing [get_ports R_FLASH_CLE]
#set_disable_timing [get_ports R_FLASH_RE_N]
#set_disable_timing [get_ports R_FLASH_WE_N]
#set_disable_timing [get_ports R_FLASH_RB_N1]
#set_disable_timing [get_ports R_FLASH_RB_N2]
#set_disable_timing [get_ports R_FLASH_DQS]
#set_disable_timing [get_ports R_FLASH_IO*]
#set_disable_timing [get_ports PROC_PROM_D0]
#set_disable_timing [get_ports PROC_PROM_D1]
#set_disable_timing [get_ports PROC_PROM_D3]
#set_disable_timing [get_ports PROC_PROM_D2]
#set_disable_timing [get_ports R_PROC_PROM_CS_N]
#set_disable_timing [get_ports IRIG_B_ADC_SDO]
#set_disable_timing [get_ports R_IRIG_B_ADC_CS_N]
#set_disable_timing [get_ports IRIG_B_G*]
#set_disable_timing [get_ports SFW_ENCA]
#set_disable_timing [get_ports SFW_ENCB]
#set_disable_timing [get_ports SFW_INDEX]


## Timing Exceptions Section

# False Paths
set_false_path -from [get_clocks clk_out4_core_clk_wiz_1*] -to [get_clocks clk_out1_core_clk_wiz_1*]
set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks clk_out4_core_clk_wiz_1*]

set_false_path -from [get_clocks clk_out2_core_clk_wiz_1*] -to [get_clocks clk_out1_core_clk_wiz_1*]
set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks clk_out2_core_clk_wiz_1*]

set_false_path -from [get_clocks clk_out6_core_clk_wiz_1*] -to [get_clocks clk_out1_core_clk_wiz_1*]
set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks clk_out6_core_clk_wiz_1*]

set_false_path -from [get_clocks clk_out4_core_clk_wiz_1*] -to [get_clocks clk_out2_core_clk_wiz_1*]
set_false_path -from [get_clocks clk_out2_core_clk_wiz_1*] -to [get_clocks clk_out4_core_clk_wiz_1*]

set_false_path -from [get_clocks clk_out6_core_clk_wiz_1*] -to [get_clocks clk_out2_core_clk_wiz_1*]
set_false_path -from [get_clocks clk_out2_core_clk_wiz_1*] -to [get_clocks clk_out6_core_clk_wiz_1*]

set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks clk_20M_mmcm*]
set_false_path -from [get_clocks clk_20M_mmcm*] -to [get_clocks clk_out1_core_clk_wiz_1*] 

set_false_path -from [get_cells *reset*_reg* -hierarchical -filter {NAME =~ *proc_sys_reset_1*}]

### Header False Path
set_false_path -from [get_pins -hier SEQ_STATUS_reg[*]/C] -to [get_clocks clk_out1_core_clk_wiz_1*]
set_false_path -from [get_pins -hier CONFIG_reg[*][*]/C] -to [get_clocks clk_out6_core_clk_wiz_1*]

set_false_path -through [get_nets -of_objects [get_pins -hier */IMAGE_INFO[*][*]]]

# Max Delay / Min Delay
# Multicycle Paths
# Case Analysis

# Disable Timing
set_disable_timing [get_ports GIGE_SERTC]
set_disable_timing [get_ports GIGE_UART_TXD1]
set_disable_timing [get_ports R_GIGE_SERTFG]
set_disable_timing [get_ports R_GIGE_UART_RXD1]
set_disable_timing [get_ports POWER_ON_ADC_DDC]
set_disable_timing [get_ports POWER_ON_BUFFER]
set_disable_timing [get_ports POWER_ON_COOLER]
set_disable_timing [get_ports POWER_ON_EXPANSION]
set_disable_timing [get_ports POWER_ON_PLEORA]
set_disable_timing [get_ports POWER_ON_SFW]
set_disable_timing [get_ports POWER_ON_SPARE1]
set_disable_timing [get_ports POWER_ON_SPARE2]
set_disable_timing [get_ports PWR_SPARE]
set_disable_timing [get_ports LED_RED]
set_disable_timing [get_ports LED_GREEN]
set_disable_timing [get_ports LED_YELLOW]
set_disable_timing [get_ports SELF_RESET]
set_disable_timing [get_ports BUTTON]
set_disable_timing [get_ports R_ACBUS*]
set_disable_timing [get_ports R_ADBUS*]
set_disable_timing [get_ports USB_EECS]
set_disable_timing [get_ports USB_EEDATA]
set_disable_timing [get_ports USB_RESET_N]
set_disable_timing [get_ports GPS_PPS_BUF]
set_disable_timing [get_ports GPS_RX_TO_FPGA]
set_disable_timing [get_ports GPS_TX_FROM_FPGA]
set_disable_timing [get_ports IRIG_B_002_BUF]
set_disable_timing [get_ports IRIG_B_PPMS]
set_disable_timing [get_ports XADC_MUX*]
set_disable_timing [get_ports SFW_RX_TO_FPGA]
set_disable_timing [get_ports SFW_TX_FROM_FPGA]
set_disable_timing [get_ports SHUTTER_INA]
set_disable_timing [get_ports SHUTTER_INB]
set_disable_timing [get_ports EXTERNAL_FAN_PWM]
set_disable_timing [get_ports INTERNAL_FAN_PWM]
set_disable_timing [get_ports FPGA_PROC_PWM]
set_disable_timing [get_ports R_TRIG_OUT]
set_disable_timing [get_ports TRIG_IN_BUF]
set_disable_timing [get_ports PWR_PRSNT_N]
set_disable_timing [get_ports JTAG_PRSNT_N]
set_disable_timing [get_ports BUFFER_PRSNT_N]
set_disable_timing [get_ports EXP_PRSNT_N]
set_disable_timing [get_ports FPGA_TO_FPGA0]
set_disable_timing [get_ports FPGA_TO_FPGA1]
set_disable_timing [get_ports FPGA_TO_FPGA2]
set_disable_timing [get_ports FPGA_TO_FPGA3]
set_disable_timing [get_ports WATER_LEVEL]
set_disable_timing [get_ports FPGA_TO_FPGA5]
set_disable_timing [get_ports OEM_RX_TO_FPGA]
set_disable_timing [get_ports OEM_TX_FROM_FPGA]
set_disable_timing [get_ports VIDEO_FAULT1_N]
set_disable_timing [get_ports VIDEO_FAULT2_N]
set_disable_timing [get_ports FPGA_OUT_INIT_B]
set_disable_timing [get_ports COOLER_READY]
set_disable_timing [get_ports COOLER_RX_TO_FPGA]
set_disable_timing [get_ports COOLER_TX_FROM_FPGA]
set_disable_timing [get_ports DDR_POWERGOOD]
set_disable_timing [get_ports DEBUG_LED_N]


#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/U8/U0/clk_20M_mmcm_clk_20MHz]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/U8/U0/clkfbout_mmcm_clk_20MHz]


#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets R_GIGE_BULK_CLK0_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets R_GIGE_BULK_CLK0]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/USART/clk_usart_0/U0/O1]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/USART/clk_usart_0/U0/clk_out2_clk_usart]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/USART/clk_usart_0/U0/clkfbout_clk_usart]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/USART/clk_usart_0/U0/clk_out1_clk_usart]


#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/clk_in1*]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/clk_out3*]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/clk_out2*]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/MIG_Calibration/CAL_DDR_MIG/u_core_CAL_DDR_MIG_0_mig/u_ddr3_infrastructure/clk_pll_i]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/MIG_Calibration/CAL_DDR_MIG/u_core_CAL_DDR_MIG_0_mig/u_ddr3_infrastructure/mmcm_clkout0]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/MIG_Calibration/CAL_DDR_MIG/u_core_CAL_DDR_MIG_0_mig/u_ddr3_clk_ibuf/sys_clk_ibufg]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets */BD/core_wrapper_i/core_i/MIG_Code/mig_7series_0/u_core_mig_7series_0_1_mig/u_ddr3_infrastructure/pll_clk3_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets */BD/core_wrapper_i/core_i/MIG_Code/mig_7series_0/u_core_mig_7series_0_1_mig/u_ddr3_infrastructure/clk_pll_i]
