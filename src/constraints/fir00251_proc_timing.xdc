## Timing Assertions Section

# Primary clocks
create_clock -period 5.000 -name SYS_CLK_0 -waveform {0.000 2.500} [get_ports SYS_CLK_P0]
create_clock -period 5.000 -name SYS_CLK_1 -waveform {0.000 2.500} [get_ports SYS_CLK_P1]
create_clock -period 8.000 -name MGT_CLK_0 -waveform {0.000 4.000} [get_ports AURORA_CLK_P0]
create_clock -period 8.000 -name MGT_CLK_1 -waveform {0.000 4.000} [get_ports AURORA_CLK_P1]
create_clock -period 8.000 -name data_mgt_tx_out_clk [get_pins ACQ/MGT/MGTS/DATA/tx_out_clk]
create_clock -period 8.000 -name video_mgt_tx_out_clk [get_pins ACQ/MGT/MGTS/VIDEO/tx_out_clk]
create_clock -period 8.000 -name exp_mgt_tx_out_clk [get_pins ACQ/MGT/MGTS/EXP/tx_out_clk]
create_clock -period 8.000 -name data_mgt_user_clk_i [get_pins ACQ/MGT/MGTS/DATA/user_clk]
create_clock -period 8.000 -name exp_mgt_user_clk_i [get_pins ACQ/MGT/MGTS/EXP/user_clk]
#create_clock -period 12.500 -name CH0_CLK_P -waveform {0.000 6.250} [get_ports CH0_CLK_P]
#create_clock -period 12.500 -name CH1_CLK_P -waveform {0.000 6.250} [get_ports CH1_CLK_P]
#create_clock -period 12.500 -name CH2_CLK_P -waveform {0.000 6.250} [get_ports CH2_CLK_P]
create_clock -period 60.000 -name usart_clk -waveform {0.000 30.000} [get_ports R_GIGE_BULK_CLK0]

# Virtual clocks
# Generated clocks

# renommer les horloges rérivées
#create_generated_clock -name CLK20 [get_pins ACQ/U8/U0/mmcm_adv_inst/CLKOUT0]
#create_generated_clock -name BDCLK80 [get_pins ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/mmcm_adv_inst/CLKOUT5]
#create_generated_clock -name BDCLK20 [get_pins ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/mmcm_adv_inst/CLKOUT4]
#create_generated_clock -name BDCLK50 [get_pins ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/mmcm_adv_inst/CLKOUT3]
#create_generated_clock -name BDCLK200 [get_pins ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/mmcm_adv_inst/CLKOUT2]
#create_generated_clock -name BDCLK160 [get_pins ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/mmcm_adv_inst/CLKOUT1]
#create_generated_clock -name BDCLK100 [get_pins ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/mmcm_adv_inst/CLKOUT0]

# Clock Groups
# Input and output delay constraints

## Timing Exceptions Section
# False Paths
set_false_path -from [get_clocks clk_out4_core_clk_wiz_1*] -to [get_clocks data_mgt_user_clk_i]
set_false_path -from [get_clocks data_mgt_user_clk_i] -to [get_clocks clk_out4_core_clk_wiz_1*]
set_false_path -from [get_clocks clk_out4_core_clk_wiz_1*] -to [get_clocks data_mgt_tx_out_clk]
set_false_path -from [get_clocks data_mgt_tx_out_clk] -to [get_clocks clk_out4_core_clk_wiz_1*]

set_false_path -from [get_clocks clk_out4_core_clk_wiz_1*] -to [get_clocks exp_mgt_user_clk_i]
set_false_path -from [get_clocks exp_mgt_user_clk_i] -to [get_clocks clk_out4_core_clk_wiz_1*]
set_false_path -from [get_clocks clk_out4_core_clk_wiz_1*] -to [get_clocks exp_mgt_tx_out_clk]
set_false_path -from [get_clocks exp_mgt_tx_out_clk] -to [get_clocks clk_out4_core_clk_wiz_1*]

set_false_path -from [get_clocks clk_out4_core_clk_wiz_1*] -to [get_clocks clk_out1_core_clk_wiz_1*]
set_false_path -from [get_clocks clk_out4_core_clk_wiz_1*] -to [get_clocks clk_out1_core_clk_wiz_1*]

set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks data_mgt_user_clk_i]
set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks exp_mgt_user_clk_i]
set_false_path -from [get_clocks data_mgt_user_clk_i] -to [get_clocks clk_out1_core_clk_wiz_1*]
set_false_path -from [get_clocks exp_mgt_user_clk_i] -to [get_clocks clk_out1_core_clk_wiz_1*]

set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks data_mgt_tx_out_clk]
set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks exp_mgt_tx_out_clk]
set_false_path -from [get_clocks data_mgt_tx_out_clk] -to [get_clocks clk_out1_core_clk_wiz_1*]
set_false_path -from [get_clocks exp_mgt_tx_out_clk] -to [get_clocks clk_out1_core_clk_wiz_1*]

set_false_path -from [get_clocks clk_out2_core_clk_wiz_1*] -to [get_clocks clk_out1_core_clk_wiz_1*]
set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks clk_out2_core_clk_wiz_1*]

set_false_path -from [get_cells {ACQ/BD/core_wrapper_i/core_i/proc_sys_reset_1/U0/ACTIVE_LOW_PR_OUT_DFF[0].peripheral_aresetn_reg[0]}] -to [all_registers]

#PELICAND
#set_false_path -from [get_clocks proxy_dclk_out_ch0_clink_clk_7x80MHz] -to [get_clocks clk_out1_core_clk_wiz_1*]
#set_false_path -from [get_clocks proxy_dclk_out_ch1_clink_clk_7x80MHz] -to [get_clocks clk_out1_core_clk_wiz_1*]

#set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks proxy_dclk_out_ch0_clink_clk_7x80MHz]
#set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks proxy_dclk_out_ch1_clink_clk_7x80MHz]

#set_false_path -from [get_clocks proxy_dclk_0_clink_clk_7x80MHz] -to [get_clocks clk_out1_core_clk_wiz_1*]
#set_false_path -from [get_clocks proxy_dclk_0_clink_clk_7x80MHz_1] -to [get_clocks clk_out1_core_clk_wiz_1*]

#set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks proxy_dclk_0_clink_clk_7x80MHz]
#set_false_path -from [get_clocks clk_out1_core_clk_wiz_1*] -to [get_clocks proxy_dclk_0_clink_clk_7x80MHz_1]

### Header False Path
set_false_path -from [get_pins {ACQ/HEADER/U4/SEQ_STATUS_reg[*]/C}] -to [get_clocks clk_out1_core_clk_wiz_1*]
set_false_path -from [get_pins {ACQ/HEADER/U1/CONFIG_reg[*][*]/C}] -to [get_clocks clk_out2_core_clk_wiz_1*]

# Max Delay / Min Delay
# Multicycle Paths
# Case Analysis
# Disable Timing

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/U8/U0/clk_20M_mmcm_clk_20MHz]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/U8/U0/clkfbout_mmcm_clk_20MHz]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLINK/U1/U6/O1]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLINK/U1/U12/DATAOUT]


#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets R_GIGE_BULK_CLK0_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets R_GIGE_BULK_CLK0]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/USART/clk_usart_0/U0/O1]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/USART/clk_usart_0/U0/clk_out2_clk_usart]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/USART/clk_usart_0/U0/clkfbout_clk_usart]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/USART/clk_usart_0/U0/clk_out1_clk_usart]


set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/clk_in1*]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/clk_out3*]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/clk_wiz_1/U0/clk_out2*]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLINK/U1/U14/U0/proxy_dclk_mult7_b_ch0_clink_clk_7x80MHz]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLINK/U1/U14/U0/clkfbout_ch0_clink_clk_7x80MHz]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLINK/U1/U14/U0/proxy_dclk_out_mult7_ch0_clink_clk_7x80MHz]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLINK/U1/U14/U0/proxy_dclk_out_ch0_clink_clk_7x80MHz]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLINK/U1/U14/U0/proxy_dclk_mult7_b_ch0_clink_clk_7x10MHz]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLINK/U1/U14/U0/clkfbout_ch0_clink_clk_7x10MHz]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLINK/U1/U14/U0/proxy_dclk_out_mult7_ch0_clink_clk_7x10MHz]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLINK/U1/U14/U0/proxy_dclk_out_ch0_clink_clk_7x10MHz]
set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets CLINK/U1/U14/U0/proxy_dclk_in_ch0_clink_clk_7x10MHz]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/MIG_Calibration/CAL_DDR_MIG/u_core_CAL_DDR_MIG_0_mig/u_ddr3_infrastructure/clk_pll_i]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/MIG_Calibration/CAL_DDR_MIG/u_core_CAL_DDR_MIG_0_mig/u_ddr3_infrastructure/mmcm_clkout0]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/MIG_Calibration/CAL_DDR_MIG/u_core_CAL_DDR_MIG_0_mig/u_ddr3_clk_ibuf/sys_clk_ibufg]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/MIG_Code/mig_7series_0/u_core_mig_7series_0_1_mig/u_ddr3_infrastructure/pll_clk3_out]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ACQ/BD/core_wrapper_i/core_i/MIG_Code/mig_7series_0/u_core_mig_7series_0_1_mig/u_ddr3_infrastructure/clk_pll_i]

set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets CLINK/U1/n_0_U3]
set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets CLINK/U1/n_2_U3]


