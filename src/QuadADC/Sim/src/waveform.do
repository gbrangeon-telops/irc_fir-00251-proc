onerror { resume }
transcript off
add wave -named_row "ADATA" -bold -color 49,150,99
add wave -noreg -logic {/adc_tb_stim_top_level/U6/CLK40}
add wave -noreg -logic {/adc_tb_stim_top_level/U4/CLK40_PH0}
add wave -noreg -logic {/adc_tb_stim_top_level/U4/CLK40_PH1}
add wave -noreg -logic {/adc_tb_stim_top_level/U4/CLK40_PH2}
add wave -noreg -logic {/adc_tb_stim_top_level/U6/ARESET}
add wave -noreg -logic {/adc_tb_stim_top_level/U6/EN}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U6/DATA}
add wave -named_row "ADC_CTRL" -bold -color 49,150,99
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U8/cfg}
add wave -noreg -logic {/adc_tb_stim_top_level/U8/DVAL}
add wave -noreg -logic {/adc_tb_stim_top_level/U8/ack_i}
add wave -noreg -logic {/adc_tb_stim_top_level/U8/sreset}
add wave -noreg -logic {/adc_tb_stim_top_level/U8/CLK}
add wave -noreg -logic {/adc_tb_stim_top_level/U8/ARESET}
add wave -noreg -logic {/adc_tb_stim_top_level/U8/CAL_DONE}
add wave -noreg -logic {/adc_tb_stim_top_level/U8/CS_N}
add wave -noreg -logic {/adc_tb_stim_top_level/U8/SDI}
add wave -noreg -logic {/adc_tb_stim_top_level/U8/SCLK}
add wave -named_row "ADC config rx" -bold -color 49,150,99
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U1/spi_cfg/DOUT}
add wave -noreg -logic {/adc_tb_stim_top_level/U1/spi_cfg/DVAL}
add wave -noreg -logic {/adc_tb_stim_top_level/U1/output_test_pattern}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U1/test_pattern}
add wave -named_row "ADC model" -bold -color 49,150,99
add wave -noreg -logic {/adc_tb_stim_top_level/U1/rst_i}
add wave -noreg -logic {/adc_tb_stim_top_level/U1/enc_i}
add wave -noreg -logic {/adc_tb_stim_top_level/U1/bit_clk}
add wave -noreg -logic {/adc_tb_stim_top_level/U1/fr_s}
add wave -noreg -logic {/adc_tb_stim_top_level/U1/fr_d}
add wave -noreg -logic {/adc_tb_stim_top_level/U1/dco_s}
add wave -noreg -hexadecimal -literal -unsigned {/adc_tb_stim_top_level/U1/data0}
add wave -noreg -logic {/adc_tb_stim_top_level/U1/FR_P}
add wave -noreg -hexadecimal -literal -unsigned {/adc_tb_stim_top_level/U1/data0_hold}
add wave -noreg -logic {/adc_tb_stim_top_level/U1/DCO_P}
add wave -noreg -logic {/adc_tb_stim_top_level/U1/bit_clk}
add wave -named_row "Receiver 1ch" -bold -color 49,150,99
add wave -noreg -logic {/adc_tb_stim_top_level/U2/clk_1x}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/ext_clk_in}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/dcm_locked}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/GND}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/ARESETN}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/CLK100}
add wave -named_row "adc_iserdes_wrapper" -bold -color 49,150,99
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U8/clk_in_int_inv}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U8/sreset}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U8/sreset1}
add wave -noreg -hexadecimal -literal -unsigned {/adc_tb_stim_top_level/U1/data0_hold}
add wave -noreg -hexadecimal -literal -unsigned {/adc_tb_stim_top_level/U2/U8/q_reg_s}
add wave -noreg -hexadecimal -literal -unsigned {/adc_tb_stim_top_level/U2/U8/q_reg_out}
add wave -noreg -hexadecimal -literal -unsigned {/adc_tb_stim_top_level/U2/U8/q_reg_slip}
add wave -noreg -decimal -literal -signed2 {/adc_tb_stim_top_level/U2/U12/slip_pos}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U8/DDLY}
add wave -noreg -hexadecimal -literal -signed2 {/adc_tb_stim_top_level/U2/U8/Q}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U8/clk_in}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U8/clk_div_in}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U8/reset}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U8/bitslip}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U8/bitslip_dir}
add wave -noreg -decimal -literal -signed2 {/adc_tb_stim_top_level/U2/U8/bitslip_proc/state}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/ext_clk_in}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/q_adc1_in}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/ext_clk_in_d}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/q_adc1_in_d}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/clk_7x}
add wave -noreg -hexadecimal -literal -signed2 {/adc_tb_stim_top_level/U2/CLK_D}
add wave -named_row "delay_calibration" -bold -color 49,150,99
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U9/CLK}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U9/sreset}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U2/U9/DATA}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U9/BITSLIP}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U9/START_TEST}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U9/LD}
add wave -noreg -logic -signed2 {/adc_tb_stim_top_level/U2/U9/RDY}
add wave -noreg -hexadecimal -literal -signed2 {/adc_tb_stim_top_level/U2/U9/DELAY}
add wave -noreg -hexadecimal -literal -signed2 {/adc_tb_stim_top_level/U2/U9/data_i}
add wave -noreg -hexadecimal -literal -signed2 {/adc_tb_stim_top_level/U2/U9/data_1p}
add wave -noreg -color 0,128,0 -literal -bold {/adc_tb_stim_top_level/U2/U9/bs_state}
add wave -noreg -color 0,128,0 -literal -bold {/adc_tb_stim_top_level/U2/U9/dly_state}
add wave -noreg -decimal -literal -signed2 {/adc_tb_stim_top_level/U2/U9/bitslip_calib_sm/cnt}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U9/rdy_out}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U9/bitslip_out}
add wave -noreg -color 0,4,132 -logic -signed2 {/adc_tb_stim_top_level/U2/U9/start_test_out}
add wave -noreg -color 0,128,0 -hexadecimal -literal {/adc_tb_stim_top_level/U2/U9/delay_calib_sm/next_delay_v}
add wave -noreg -color 0,4,132 -logic {/adc_tb_stim_top_level/U2/U9/ld_out}
add wave -named_row "test_pattern_validator" -bold -color 49,150,99
add wave -noreg -color 0,4,132 -logic {/adc_tb_stim_top_level/U2/U15/CLK}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U15/sreset}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U2/U15/data_i}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U2/U15/data_hold}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U2/U15/data_1p}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U2/U15/test_pattern_hold}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U15/done_i}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U15/pattern_valid_i}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U2/U15/DATA}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U15/START}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U2/U15/TEST_PATTERN}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U15/LOAD_PATTERN}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U15/PATTERN_VALID}
add wave -noreg -logic {/adc_tb_stim_top_level/U2/U15/DONE}
add wave -named_row "test pattern validator (ext)" -bold -color 49,150,99
add wave -noreg -logic {/adc_tb_stim_top_level/U7/CLK}
add wave -noreg -logic {/adc_tb_stim_top_level/U7/sreset}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U7/data_i}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U7/data_hold}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U7/data_1p}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U7/test_pattern_hold}
add wave -noreg -logic {/adc_tb_stim_top_level/U7/test_started}
add wave -noreg -logic {/adc_tb_stim_top_level/U7/done_i}
add wave -noreg -logic {/adc_tb_stim_top_level/U7/pattern_valid_i}
add wave -noreg -logic {/adc_tb_stim_top_level/U7/ARESET}
add wave -noreg -hexadecimal -literal {/adc_tb_stim_top_level/U7/DATA}
add wave -noreg -logic {/adc_tb_stim_top_level/U7/START}
add wave -noreg -hexadecimal -literal -signed2 {/adc_tb_stim_top_level/U7/TEST_PATTERN}
add wave -noreg -logic {/adc_tb_stim_top_level/U7/LOAD_PATTERN}
add wave -noreg -logic {/adc_tb_stim_top_level/U7/PATTERN_VALID}
add wave -noreg -logic {/adc_tb_stim_top_level/U7/DONE}
cursor "Cursor 1" 10us  
transcript on
