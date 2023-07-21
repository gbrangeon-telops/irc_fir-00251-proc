## Timing Constraints Section

# Primary clocks
create_clock -period 5.000 [get_ports SYS_CLK_P0]
create_clock -period 5.000 [get_ports SYS_CLK_P1]
create_clock -period 8.000 -name MGT_CLK_0 [get_ports AURORA_CLK_P0]
create_clock -period 8.000 -name MGT_CLK_1 [get_ports AURORA_CLK_P1]
create_clock -period 60.000 -name usart_clk_in [get_ports R_GIGE_BULK_CLK0]


# Virtual clocks

# Generated clocks
create_generated_clock -name usart_clk [get_pins *CLKOUT0 -hier -filter {name =~ *BULK_USART*}]
create_generated_clock -name clk_mb [get_pins *mmcm_i/CLKFBOUT -hier -filter {name =~ *MIG_Code*}]
create_generated_clock -name clk_200 [get_pins *mmcm_i/CLKOUT0 -hier -filter {name =~ *MIG_Code*}]
create_generated_clock -name clk_mgt_init [get_pins *mmcm_i/CLKOUT1 -hier -filter {name =~ *MIG_Code*}]
create_generated_clock -name clk_irig [get_pins *mmcm_i/CLKOUT2 -hier -filter {name =~ *MIG_Code*}]
create_generated_clock -name clk_cal [get_pins *CLKOUT0 -hier -filter {name =~ *clk_wiz_1*}]
create_generated_clock -name clk_data [get_pins *CLKOUT1 -hier -filter {name =~ *clk_wiz_1*}]
create_generated_clock -name MIG_CAL_UI_CLK [get_pins *mmcm_i/CLKFBOUT -hier -filter {name =~ *CAL_DDR_MIG*}]
#create_generated_clock -name MIG_CODE_UI_CLK [get_pins *mmcm_i/CLKFBOUT -hier -filter {name =~ *MIG_Code*}]   #same as clk_mb


# Clock Groups
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks *SYS_CLK_P0]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks *SYS_CLK_P1]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks MGT_CLK_0]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks MGT_CLK_1]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks *data_mgt*RXOUTCLK]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks *data_mgt*TXOUTCLK]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks *exp_mgt*TXOUTCLK]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks *exp_mgt*RXOUTCLK]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks usart_clk_in]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks usart_clk]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_mb]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_200]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_mgt_init]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_irig]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_cal]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_data]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks MIG_CAL_UI_CLK]
#set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks MIG_CODE_UI_CLK]   #same as clk_mb

# Input and output delay constraints


## Timing Exceptions Section

# False Paths
#set_false_path -from [get_cells *reset*_reg* -hierarchical -filter {NAME =~ *proc_sys_reset_1*}]
# Since 2018.3, *reset*_reg* are replaced by : FDRE_BSR*,FDRE_PER*
set_false_path -from [get_cells *FDRE_* -hierarchical -filter {NAME =~ *proc_sys_reset_1*}]

### Header False Path
#set_false_path -from [get_pins -hier SEQ_STATUS_reg[*]/C] -to [get_clocks clk_mb]
#set_false_path -from [get_pins -hier CONFIG_reg[*][*]/C] -to [get_clocks clk_data]
#set_false_path -through [get_nets -of_objects [get_pins -hier */IMAGE_INFO[*][*]]]

# Max Delay / Min Delay
# Multicycle Paths
# Case Analysis

# Disable Timing
#set_disable_timing [get_ports GIGE_SERTC]
#set_disable_timing [get_ports GIGE_UART_TXD1]
#set_disable_timing [get_ports R_GIGE_SERTFG]
#set_disable_timing [get_ports R_GIGE_UART_RXD1]
#set_disable_timing [get_ports POWER_ON_ADC_DDC]
#set_disable_timing [get_ports POWER_ON_BUFFER]
#set_disable_timing [get_ports POWER_ON_COOLER]
#set_disable_timing [get_ports POWER_ON_EXPANSION]
#set_disable_timing [get_ports POWER_ON_PLEORA]
#set_disable_timing [get_ports POWER_ON_SFW]
#set_disable_timing [get_ports POWER_ON_SPARE1]
#set_disable_timing [get_ports POWER_ON_SPARE2]
#set_disable_timing [get_ports PWR_SPARE]
#set_disable_timing [get_ports LED_RED]
#set_disable_timing [get_ports LED_GREEN]
#set_disable_timing [get_ports LED_YELLOW]
#set_disable_timing [get_ports SELF_RESET]
#set_disable_timing [get_ports BUTTON]
#set_disable_timing [get_ports R_ACBUS*]
#set_disable_timing [get_ports R_ADBUS*]
#set_disable_timing [get_ports USB_EECS]
#set_disable_timing [get_ports USB_EEDATA]
#set_disable_timing [get_ports USB_RESET_N]
#set_disable_timing [get_ports GPS_PPS_BUF]
#set_disable_timing [get_ports GPS_RX_TO_FPGA]
#set_disable_timing [get_ports GPS_TX_FROM_FPGA]
#set_disable_timing [get_ports IRIG_B_002_BUF]
#set_disable_timing [get_ports IRIG_B_PPMS]
#set_disable_timing [get_ports XADC_MUX*]
#set_disable_timing [get_ports SFW_RX_TO_FPGA]
#set_disable_timing [get_ports SFW_TX_FROM_FPGA]
#set_disable_timing [get_ports SHUTTER_INA]
#set_disable_timing [get_ports SHUTTER_INB]
#set_disable_timing [get_ports EXTERNAL_FAN_PWM]
#set_disable_timing [get_ports INTERNAL_FAN_PWM]
#set_disable_timing [get_ports FPGA_PROC_PWM]
#set_disable_timing [get_ports R_TRIG_OUT]
#set_disable_timing [get_ports TRIG_IN_BUF]
#set_disable_timing [get_ports PWR_PRSNT_N]
#set_disable_timing [get_ports JTAG_PRSNT_N]
#set_disable_timing [get_ports BUFFER_PRSNT_N]
#set_disable_timing [get_ports EXP_PRSNT_N]
#set_disable_timing [get_ports FPGA_TO_FPGA0]
#set_disable_timing [get_ports FPGA_TO_FPGA1]
#set_disable_timing [get_ports FPGA_TO_FPGA2]
#set_disable_timing [get_ports FPGA_TO_FPGA3]
#set_disable_timing [get_ports WATER_LEVEL]
#set_disable_timing [get_ports FPGA_TO_FPGA5]
#set_disable_timing [get_ports OEM_RX_TO_FPGA]
#set_disable_timing [get_ports OEM_TX_FROM_FPGA]
#set_disable_timing [get_ports VIDEO_FAULT1_N]
#set_disable_timing [get_ports VIDEO_FAULT2_N]
#set_disable_timing [get_ports FPGA_OUT_INIT_B]
#set_disable_timing [get_ports COOLER_READY]
#set_disable_timing [get_ports COOLER_RX_TO_FPGA]
#set_disable_timing [get_ports COOLER_TX_FROM_FPGA]
#set_disable_timing [get_ports DDR_POWERGOOD]
#set_disable_timing [get_ports DEBUG_LED_N]


#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets R_GIGE_BULK_CLK0_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets R_GIGE_BULK_CLK0]
