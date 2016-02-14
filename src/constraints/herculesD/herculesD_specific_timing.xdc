## Timing Assertions Section

# Primary clocks
create_clock -period 12.500 -name CH0_CLK_P -waveform {0.000 6.250} [get_ports CH0_CLK_P]
create_clock -period 12.500 -name CH1_CLK_P -waveform {0.000 6.250} [get_ports CH1_CLK_P]

#create_clock -period 12.5 [get_ports proxy_dclk_in]
#set_input_jitter [get_clocks -of_objects [get_ports proxy_dclk_in]] 0.3


#set_property BEL BFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst_reg[3]}]

#set_property BEL DFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[11]}]

#set_property BEL CFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[6]}]
#set_property BEL BFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[17]}]

#set_property BEL C6LUT [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_2}]

#set_property BEL A6LUT [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter[0]_i_6}]

#set_property BEL CFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[2]}]

#set_property BEL CFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst_reg[0]}]

#set_property BEL C6LUT [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_1}]

#set_property BEL DFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[19]}]

#set_property BEL DFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[7]}]

#set_property BEL CFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[10]}]

#set_property BEL B6LUT [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_4}]

#set_property BEL CFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[18]}]

#set_property BEL DFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[15]}]

#set_property BEL B6LUT [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_3__0}]

#set_property BEL DFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[3]}]

#set_property BEL CFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[14]}]

#set_property BEL BFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[9]}]

#set_property BEL CFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst_reg[0]}]

#set_property BEL DFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[7]}]

#set_property BEL A6LUT [get_cells CLINK/U1/i_0]

#set_property BEL BFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[21]}]

#set_property BEL C6LUT [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_5}]

#set_property BEL BFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[9]}]

#set_property BEL B6LUT [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_3}]

#set_property BEL BFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[21]}]
#set_property BEL DFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[3]}]

#set_property BEL DFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst_reg[1]}]

#set_property BEL CFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[6]}]

#set_property BEL CFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[18]}]

#set_property BEL A6LUT [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[2]_i_1__0}]

#set_property BEL BFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst_reg[3]}]
#set_property BEL DFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[19]}]

#set_property BEL D6LUT [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_6}]

#set_property BEL A6LUT [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter[0]_i_1}]
#set_property BEL CFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[2]}]

#set_property BEL CFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[14]}]
#set_property BEL C6LUT [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_1__0}]

#set_property BEL D6LUT [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_2__0}]

#set_property BEL DFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[15]}]

#set_property BEL DFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[11]}]

#set_property BEL BFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[17]}]
#set_property BEL B6LUT [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[3]_i_1__0}]

#set_property BEL C6LUT [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_6__0}]



#set_property BEL BFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[5]}]
#set_property BEL D6LUT [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[1]_i_1}]

#set_property BEL A6LUT [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter[0]_i_6__0}]

#set_property BEL AFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst_reg[2]}]

#set_property BEL CFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[22]}]

#set_property BEL C6LUT [get_cells CLINK/U1/i_2]
#set_property BEL CFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[22]}]

#set_property BEL D6LUT [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[1]_i_1__0}]

#set_property BEL BFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[13]}]

#set_property BEL A6LUT [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[2]_i_1}]

#set_property BEL BFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[1]}]

#set_property BEL BFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[1]}]

#set_property BEL AFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst_reg[2]}]

#set_property BEL CFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[10]}]

#set_property BEL B6LUT [get_cells CLINK/U1/i_1]

#set_property BEL A6LUT [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_4__0}]

#set_property BEL BFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[5]}]

#set_property BEL B6LUT [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[3]_i_1}]

#set_property BEL DFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[23]}]

#set_property BEL DFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[23]}]

#set_property BEL A6LUT [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_5__0}]

#set_property BEL BFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[13]}]

#set_property BEL B6LUT [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter[0]_i_1__0}]

#set_property BEL DFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst_reg[1]}]

#set_property BEL D6LUT [get_cells CLINK/U1/i_3]

#set_property BEL AFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[12]}]
#set_property BEL AFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[4]}]
#set_property BEL AFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[8]}]
#set_property BEL AFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[0]}]
#set_property BEL AFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[16]}]
#set_property BEL AFF [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[20]}]
#set_property BEL AFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[0]}]
#set_property BEL AFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[4]}]
#set_property BEL AFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[8]}]
#set_property BEL AFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[12]}]
#set_property BEL AFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[16]}]
#set_property BEL AFF [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[20]}]

#set_property BEL A6LUT [get_cells CLINK/U1/i_4]
set_property LOC MMCME2_ADV_X1Y2 [get_cells CLINK/U1/U14/U0/mmcm_adv_inst]

set_property LOC IDELAYCTRL_X0Y1 [get_cells CLINK/U1/idelayctrl_b13]
#set_property LOC SLICE_X0Y55 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[20]_i_1}]
#set_property LOC SLICE_X4Y88 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[20]_i_1__0}]
set_property LOC MMCME2_ADV_X0Y1 [get_cells CLINK/U1/U1/U0/mmcm_adv_inst]
#set_property LOC SLICE_X4Y83 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[0]_i_2__0}]
#set_property LOC SLICE_X0Y51 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[4]_i_1}]
#set_property LOC SLICE_X4Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[12]_i_1__0}]
#set_property LOC SLICE_X0Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[16]_i_1}]
#set_property LOC SLICE_X4Y85 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[8]_i_1__0}]
#set_property LOC SLICE_X4Y84 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[4]_i_1__0}]
#set_property LOC SLICE_X0Y53 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[12]_i_1}]
#set_property LOC SLICE_X0Y50 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[0]_i_2}]
#set_property LOC SLICE_X0Y52 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[8]_i_1}]
#set_property LOC SLICE_X4Y87 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[16]_i_1__0}]

#set_property LOC SLICE_X0Y55 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[21]}]

#set_property LOC SLICE_X4Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[12]}]

#set_property LOC SLICE_X0Y51 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[7]}]
#set_property LOC SLICE_X4Y87 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[18]}]

set_property LOC BUFGCTRL_X0Y6 [get_cells CLINK/U1/U1/U0/clkout1_buf]

#set_property LOC SLICE_X5Y87 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_3__0}]

#set_property LOC SLICE_X0Y50 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[0]}]

#set_property LOC SLICE_X0Y50 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[3]}]

#set_property LOC SLICE_X1Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst_reg[1]}]

#set_property LOC SLICE_X1Y55 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_2__0}]
#set_property LOC SLICE_X4Y88 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[21]}]

#set_property LOC SLICE_X0Y50 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[1]}]

set_property LOC BUFGCTRL_X0Y8 [get_cells CLINK/U1/U14/U0/clkout1_buf]

#set_property LOC SLICE_X4Y85 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[8]}]

#set_property LOC SLICE_X4Y85 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[11]}]

#set_property LOC SLICE_X1Y53 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_5}]

#set_property LOC SLICE_X4Y87 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[19]}]

#set_property LOC SLICE_X0Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[16]}]

set_property LOC BUFGCTRL_X0Y3 [get_cells CLINK/U1/U1/U0/clkout2_buf]
#set_property LOC SLICE_X3Y84 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_4__0}]

#set_property LOC SLICE_X4Y84 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[4]}]

#set_property LOC SLICE_X4Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[15]}]

#set_property LOC SLICE_X1Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_1}]

#set_property LOC SLICE_X6Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst_reg[1]}]

set_property LOC BUFGCTRL_X0Y14 [get_cells CLINK/U1/U14/U0/clkin1_bufg]

#set_property LOC SLICE_X0Y52 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[8]}]

#set_property LOC SLICE_X65Y210 [get_cells CLINK/U1/i_1]

#set_property LOC SLICE_X0Y55 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[22]}]

#set_property LOC SLICE_X1Y53 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_6}]

#set_property LOC SLICE_X1Y52 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter[0]_i_1}]

#set_property LOC SLICE_X6Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_1__0}]
set_property LOC BUFGCTRL_X0Y7 [get_cells CLINK/U1/U1/U0/clkout3_buf]

#set_property LOC SLICE_X1Y49 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_4}]

#set_property LOC SLICE_X4Y88 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[22]}]
#set_property LOC SLICE_X0Y51 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[4]}]

#set_property LOC SLICE_X1Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst_reg[2]}]

set_property LOC BUFGCTRL_X0Y9 [get_cells CLINK/U1/U14/U0/clkout3_buf]
#set_property LOC SLICE_X4Y84 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[7]}]

#set_property LOC SLICE_X0Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[19]}]

#set_property LOC SLICE_X6Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[3]_i_1__0}]

#set_property LOC SLICE_X65Y210 [get_cells CLINK/U1/i_0]
#set_property LOC SLICE_X4Y83 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[1]}]
#set_property LOC SLICE_X4Y85 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[10]}]

#set_property LOC SLICE_X1Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[1]_i_1}]

#set_property LOC SLICE_X0Y50 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter[0]_i_6}]
#set_property LOC SLICE_X4Y83 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[3]}]

#set_property LOC SLICE_X0Y53 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[15]}]
#set_property LOC SLICE_X7Y88 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_2}]

#set_property LOC SLICE_X1Y55 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[0]_i_3}]

#set_property LOC SLICE_X4Y87 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[16]}]

set_property LOC BUFGCTRL_X0Y2 [get_cells CLINK/U1/U14/U0/clkout2_buf]
#set_property LOC SLICE_X0Y53 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[12]}]

#set_property LOC SLICE_X0Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[18]}]
#set_property LOC SLICE_X6Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst_reg[0]}]

#set_property LOC SLICE_X6Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[1]_i_1__0}]

#set_property LOC SLICE_X4Y84 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[6]}]
#set_property LOC SLICE_X1Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[2]_i_1}]

#set_property LOC SLICE_X4Y83 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[0]}]

#set_property LOC SLICE_X0Y51 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[5]}]

#set_property LOC SLICE_X1Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst_reg[3]}]

#set_property LOC SLICE_X0Y55 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[23]}]

#set_property LOC SLICE_X65Y210 [get_cells CLINK/U1/i_3]
#set_property LOC SLICE_X4Y88 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[23]}]

#set_property LOC SLICE_X6Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[2]_i_1__0}]

#set_property LOC SLICE_X0Y53 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[14]}]

#set_property LOC SLICE_X4Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[13]}]
#set_property LOC SLICE_X1Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst[3]_i_1}]

#set_property LOC SLICE_X0Y55 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[20]}]

#set_property LOC SLICE_X4Y88 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[20]}]

#set_property LOC SLICE_X6Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst_reg[3]}]
#set_property LOC SLICE_X0Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[17]}]

#set_property LOC SLICE_X4Y85 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[9]}]
#set_property LOC SLICE_X0Y52 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[11]}]

#set_property LOC SLICE_X65Y210 [get_cells CLINK/U1/i_2]

#set_property LOC SLICE_X4Y84 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[5]}]

#set_property LOC SLICE_X5Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_5__0}]

#set_property LOC SLICE_X0Y51 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[6]}]

#set_property LOC SLICE_X1Y54 [get_cells {CLINK/U1/U10/RST200ms_TRUE.temp_rst_reg[0]}]

#set_property LOC SLICE_X5Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter[0]_i_1__0}]

set_property LOC BUFGCTRL_X0Y13 [get_cells CLINK/U1/U14/U0/clkf_buf]

set_property LOC BUFGCTRL_X0Y11 [get_cells CLINK/U1/U1/U0/clkf_buf]

#set_property LOC SLICE_X4Y83 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[2]}]

#set_property LOC SLICE_X0Y50 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[2]}]

#set_property LOC SLICE_X5Y87 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst[0]_i_6__0}]

#set_property LOC SLICE_X0Y53 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[13]}]

#set_property LOC SLICE_X4Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[14]}]

#set_property LOC SLICE_X4Y83 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter[0]_i_6__0}]

#set_property LOC SLICE_X0Y52 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[10]}]

#set_property LOC SLICE_X6Y86 [get_cells {CLINK/U1/U8/RST200ms_TRUE.temp_rst_reg[2]}]

set_property LOC BUFGCTRL_X0Y12 [get_cells CLINK/U1/U1/U0/clkin1_bufg]

#set_property LOC SLICE_X61Y210 [get_cells CLINK/U1/i_4]
#set_property LOC SLICE_X0Y52 [get_cells {CLINK/U1/U10/RST200ms_TRUE.counter_reg[9]}]

#set_property LOC SLICE_X4Y87 [get_cells {CLINK/U1/U8/RST200ms_TRUE.counter_reg[17]}]


