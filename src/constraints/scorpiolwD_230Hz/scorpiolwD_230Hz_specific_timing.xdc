## Timing Constraints Section
## Timing Assertions Section

# Primary clocks
create_clock -period 25.000 -name CH0_CLK_P -waveform {0.000 12.500} [get_ports CH0_CLK_P]
create_clock -period 25.000 -name CH1_CLK_P -waveform {0.000 12.500} [get_ports CH1_CLK_P]


set_property LOC MMCME2_ADV_X1Y2 [get_cells CLINK/U1/U14/U0/mmcm_adv_inst]
#set_property LOC IDELAYCTRL_X0Y1 [get_cells CLINK/U1/idelayctrl_b13]
set_property LOC MMCME2_ADV_X0Y1 [get_cells CLINK/U1/U1/U0/mmcm_adv_inst]
set_property LOC BUFGCTRL_X0Y6 [get_cells CLINK/U1/U1/U0/clkout1_buf]
set_property LOC BUFGCTRL_X0Y8 [get_cells CLINK/U1/U14/U0/clkout1_buf]
set_property LOC BUFGCTRL_X0Y3 [get_cells CLINK/U1/U1/U0/clkout2_buf]
set_property LOC BUFGCTRL_X0Y14 [get_cells CLINK/U1/U14/U0/clkin1_bufg]
set_property LOC BUFGCTRL_X0Y7 [get_cells CLINK/U1/U1/U0/clkout3_buf]
set_property LOC BUFGCTRL_X0Y9 [get_cells CLINK/U1/U14/U0/clkout3_buf]
set_property LOC BUFGCTRL_X0Y2 [get_cells CLINK/U1/U14/U0/clkout2_buf]
set_property LOC BUFGCTRL_X0Y13 [get_cells CLINK/U1/U14/U0/clkf_buf]
set_property LOC BUFGCTRL_X0Y11 [get_cells CLINK/U1/U1/U0/clkf_buf]
set_property LOC BUFGCTRL_X0Y12 [get_cells CLINK/U1/U1/U0/clkin1_bufg]