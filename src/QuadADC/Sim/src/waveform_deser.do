onerror { resume }
transcript off
add wave -noreg -logic {/adc_deser_tb_top_level/areset}
add wave -noreg -logic {/adc_deser_tb_top_level/aresetn}
add wave -noreg -logic {/adc_deser_tb_top_level/clk100}
add wave -noreg -logic {/adc_deser_tb_top_level/clk200}
add wave -noreg -logic {/adc_deser_tb_top_level/clk40a}
add wave -noreg -logic {/adc_deser_tb_top_level/clk40b}
add wave -noreg -logic {/adc_deser_tb_top_level/clk40c}
add wave -noreg -logic {/adc_deser_tb_top_level/clk40d}
add wave -noreg -logic {/adc_deser_tb_top_level/cs_n}
add wave -noreg -logic {/adc_deser_tb_top_level/GND}
add wave -noreg -logic {/adc_deser_tb_top_level/init_done}
add wave -noreg -logic {/adc_deser_tb_top_level/LD}
add wave -noreg -logic {/adc_deser_tb_top_level/sclk}
add wave -noreg -logic {/adc_deser_tb_top_level/sdi}
add wave -noreg -logic {/adc_deser_tb_top_level/VCC}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/data_0_a}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/data_0_b}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/data_0_c}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/data_0_d}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/pattern_valid}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/rdy}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/start_test}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/test_done}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/test_pattern}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/INIT_DONE}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/SUCCESS}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/TEST_PTRN_EN}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/QUAD1_DVAL}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/QUAD2_DVAL}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/QUAD3_DVAL}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/QUAD4_DVAL}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/QUAD1_DATA}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/QUAD2_DATA}
add wave -noreg -color 0,4,132 -hexadecimal -literal -signed2 {/adc_deser_tb_top_level/U2/QUAD3_DATA}
add wave -noreg -color 0,128,0 -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/QUAD4_DATA}
add wave -named_row "deserializer 4" -bold -color 49,150,99
add wave -noreg -vgroup "/adc_deser_tb_top_level/U2"  {/adc_deser_tb_top_level/U2/areset} {/adc_deser_tb_top_level/U2/clk1x_master} {/adc_deser_tb_top_level/U2/clk7x_master} {/adc_deser_tb_top_level/U2/LD} {/adc_deser_tb_top_level/U2/NET2971} {/adc_deser_tb_top_level/U2/NET3695} {/adc_deser_tb_top_level/U2/NET4050} {/adc_deser_tb_top_level/U2/NET5072} {/adc_deser_tb_top_level/U2/VCC} {/adc_deser_tb_top_level/U2/pattern_valid} {/adc_deser_tb_top_level/U2/q00_data} {/adc_deser_tb_top_level/U2/q01_data} {/adc_deser_tb_top_level/U2/q02_data} {/adc_deser_tb_top_level/U2/q03_data} {/adc_deser_tb_top_level/U2/q10_data} {/adc_deser_tb_top_level/U2/q11_data} {/adc_deser_tb_top_level/U2/q12_data} {/adc_deser_tb_top_level/U2/q13_data} {/adc_deser_tb_top_level/U2/q20_data} {/adc_deser_tb_top_level/U2/q21_data} {/adc_deser_tb_top_level/U2/q22_data} {/adc_deser_tb_top_level/U2/q23_data} {/adc_deser_tb_top_level/U2/q30_data} {/adc_deser_tb_top_level/U2/q31_data} {/adc_deser_tb_top_level/U2/q32_data} {/adc_deser_tb_top_level/U2/q33_data} {/adc_deser_tb_top_level/U2/rdy} {/adc_deser_tb_top_level/U2/test_done} {/adc_deser_tb_top_level/U2/TEST_PATTERN} {/adc_deser_tb_top_level/U2/Dangling_Input_Signal} {/adc_deser_tb_top_level/U2/ARESETN} {/adc_deser_tb_top_level/U2/CH0_CLK_N} {/adc_deser_tb_top_level/U2/CH0_CLK_P} {/adc_deser_tb_top_level/U2/CH1_CLK_N} {/adc_deser_tb_top_level/U2/CH1_CLK_P} {/adc_deser_tb_top_level/U2/CH2_CLK_N} {/adc_deser_tb_top_level/U2/CH2_CLK_P} {/adc_deser_tb_top_level/U2/CH3_CLK_N} {/adc_deser_tb_top_level/U2/CH3_CLK_P} {/adc_deser_tb_top_level/U2/CLK100} {/adc_deser_tb_top_level/U2/IO_RESET} {/adc_deser_tb_top_level/U2/PWR_DOWN} {/adc_deser_tb_top_level/U2/QUAD_DATA_FLAG} {/adc_deser_tb_top_level/U2/REFCLK} {/adc_deser_tb_top_level/U2/REF_CLK_RESET} {/adc_deser_tb_top_level/U2/CH0_DATA_N} {/adc_deser_tb_top_level/U2/CH0_DATA_P} {/adc_deser_tb_top_level/U2/CH1_DATA_N} {/adc_deser_tb_top_level/U2/CH1_DATA_P} {/adc_deser_tb_top_level/U2/CH2_DATA_N} {/adc_deser_tb_top_level/U2/CH2_DATA_P} {/adc_deser_tb_top_level/U2/CH3_DATA_N} {/adc_deser_tb_top_level/U2/CH3_DATA_P} {/adc_deser_tb_top_level/U2/INIT_DONE} {/adc_deser_tb_top_level/U2/QUAD1_DVAL} {/adc_deser_tb_top_level/U2/QUAD2_DVAL} {/adc_deser_tb_top_level/U2/QUAD3_DVAL} {/adc_deser_tb_top_level/U2/QUAD4_DVAL} {/adc_deser_tb_top_level/U2/QUAD1_DATA} {/adc_deser_tb_top_level/U2/QUAD2_DATA} {/adc_deser_tb_top_level/U2/QUAD3_DATA} {/adc_deser_tb_top_level/U2/QUAD4_DATA}
add wave -named_row "adc_data_sync" -color 49,150,99
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/sreset}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/flag_sync}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/dval_i}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/dval_out}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0_sync/data_i}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0_sync/data_o}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/full_i}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/empty_i}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/ARESET}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/CLKD}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/DVAL_IN}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0_sync/D0}
add wave -noreg -hexadecimal -literal -signed2 {/adc_deser_tb_top_level/U2/CH0_sync/D1}
add wave -noreg -hexadecimal -literal -signed2 {/adc_deser_tb_top_level/U2/CH0_sync/D2}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0_sync/D3}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/CLK100}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/FLAG}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0_sync/Q}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0_sync/DVAL}
add wave -named_row "adc_receiver_1ch" -color 49,150,99
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/areset}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/bitslip}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/clk_1x}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/clk_7x}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/dcm_locked}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH2/dcm_locked}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH3/dcm_locked}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/iserdes_rst}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH2/iserdes_rst}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH3/iserdes_rst}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/external_test_in}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/ext_clk_in}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/ext_clk_in_d}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/GND}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/iserdes_rst}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/load}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/NET7958}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/pattern_valid_ext_in}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/pattern_valid_i}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/pattern_valid_int}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/q_adc1_in}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/q_adc1_in_d}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/q_adc2_in}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/q_adc2_in_d}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/q_adc3_in}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/q_adc3_in_d}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/q_adc4_in}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/q_adc4_in_d}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/start_test_i}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/test_done_ext_in}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/test_done_i}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/test_done_int}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0/CLK_D}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0/delay}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/Dangling_Input_Signal}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/ARESETN}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/CLK100}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/CLK_1x_MASTER}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/CLK_7x_MASTER}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/EXTERNAL_TEST}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/EXT_CLK_N}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/EXT_CLK_P}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/PATTERN_VALID}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/REFCLK}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/REF_CLK_RESET}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/TEST_DONE}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0/Q_ADC_N}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0/Q_ADC_P}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/CLK1X_OUT}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/CLK7X_OUT}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/DCLK}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/IDELAYCTRL_RDY}
add wave -noreg -logic {/adc_deser_tb_top_level/U2/CH0/START_TEST}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0/Q_ADC1_OUT}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0/Q_ADC2_OUT}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0/Q_ADC3_OUT}
add wave -noreg -hexadecimal -literal -unsigned {/adc_deser_tb_top_level/U2/CH0/Q_ADC4_OUT}
add wave -named_row "test_pattern_validator" -bold -color 49,150,99
add wave -noreg -vgroup "/adc_deser_tb_top_level/U2/CH0_test"  {/adc_deser_tb_top_level/U2/CH0_test/sreset} {/adc_deser_tb_top_level/U2/CH0_test/data_i} {/adc_deser_tb_top_level/U2/CH0_test/data_hold} {/adc_deser_tb_top_level/U2/CH0_test/data_1p} {/adc_deser_tb_top_level/U2/CH0_test/test_pattern_hold} {/adc_deser_tb_top_level/U2/CH0_test/test_started} {/adc_deser_tb_top_level/U2/CH0_test/done_i} {/adc_deser_tb_top_level/U2/CH0_test/pattern_valid_i} {/adc_deser_tb_top_level/U2/CH0_test/CLK} {/adc_deser_tb_top_level/U2/CH0_test/ARESET} {/adc_deser_tb_top_level/U2/CH0_test/DATA} {/adc_deser_tb_top_level/U2/CH0_test/START} {/adc_deser_tb_top_level/U2/CH0_test/TEST_PATTERN} {/adc_deser_tb_top_level/U2/CH0_test/LOAD_PATTERN} {/adc_deser_tb_top_level/U2/CH0_test/PATTERN_VALID} {/adc_deser_tb_top_level/U2/CH0_test/DONE}
add wave -named_row "delay_calibration" -bold -color 49,150,99
add wave -noreg -vgroup "/adc_deser_tb_top_level/U2/CH0/U9"  {/adc_deser_tb_top_level/U2/CH0/U9/sreset} {/adc_deser_tb_top_level/U2/CH0/U9/delay_i} {/adc_deser_tb_top_level/U2/CH0/U9/data_i} {/adc_deser_tb_top_level/U2/CH0/U9/data_hold} {/adc_deser_tb_top_level/U2/CH0/U9/EDGES} {/adc_deser_tb_top_level/U2/CH0/U9/delay_calib_sm/all_delays_visited} {/adc_deser_tb_top_level/U2/CH0/U9/delay_calib_sm/edge_found} {/adc_deser_tb_top_level/U2/CH0/U9/wait_done} {/adc_deser_tb_top_level/U2/CH0/U9/wait_counter/wait_cnt} {/adc_deser_tb_top_level/U2/CH0/U9/wait_counter/detect_cnt} {/adc_deser_tb_top_level/U2/CH0/U9/data_1p} {/adc_deser_tb_top_level/U2/CH0/U9/bs_state} {/adc_deser_tb_top_level/U2/CH0/U9/bs_next_state} {/adc_deser_tb_top_level/U2/CH0/U9/dly_state} {/adc_deser_tb_top_level/U2/CH0/U9/dly_next_state} {/adc_deser_tb_top_level/U2/CH0/U9/ld_out} {/adc_deser_tb_top_level/U2/CH0/U9/start_test_out} {/adc_deser_tb_top_level/U2/CH0/U9/BITSLIP_CNT} {/adc_deser_tb_top_level/U2/CH0/U9/bitslip_out} {/adc_deser_tb_top_level/U2/CH0/U9/start_calibration} {/adc_deser_tb_top_level/U2/CH0/U9/CLK} {/adc_deser_tb_top_level/U2/CH0/U9/ARESET} {/adc_deser_tb_top_level/U2/CH0/U9/DATA} {/adc_deser_tb_top_level/U2/CH0/U9/PATTERN_VALID} {/adc_deser_tb_top_level/U2/CH0/U9/TEST_DONE} {/adc_deser_tb_top_level/U2/CH0/U9/START_TEST} {/adc_deser_tb_top_level/U2/CH0/U9/BITSLIP} {/adc_deser_tb_top_level/U2/CH0/U9/DELAY} {/adc_deser_tb_top_level/U2/CH0/U9/LD} {/adc_deser_tb_top_level/U2/CH0/U9/DONE} {/adc_deser_tb_top_level/U2/CH0/U9/delay_success_i} {/adc_deser_tb_top_level/U2/CH0/U9/bitslip_success_i} {/adc_deser_tb_top_level/U2/CH0/U9/SUCCESS}
add wave -noreg -vgroup "/adc_deser_tb_top_level/U2/CH2/U9"  {/adc_deser_tb_top_level/U2/CH2/U9/sreset} {/adc_deser_tb_top_level/U2/CH2/U9/delay_i} {/adc_deser_tb_top_level/U2/CH2/U9/data_i} {/adc_deser_tb_top_level/U2/CH2/U9/data_hold} {/adc_deser_tb_top_level/U2/CH2/U9/EDGES} {/adc_deser_tb_top_level/U2/CH2/U9/delay_calib_sm/all_delays_visited} {/adc_deser_tb_top_level/U2/CH2/U9/delay_calib_sm/edge_found} {/adc_deser_tb_top_level/U2/CH2/U9/wait_done} {/adc_deser_tb_top_level/U2/CH2/U9/wait_counter/wait_cnt} {/adc_deser_tb_top_level/U2/CH2/U9/wait_counter/detect_cnt} {/adc_deser_tb_top_level/U2/CH2/U9/data_1p} {/adc_deser_tb_top_level/U2/CH2/U9/bs_state} {/adc_deser_tb_top_level/U2/CH2/U9/bs_next_state} {/adc_deser_tb_top_level/U2/CH2/U9/dly_state} {/adc_deser_tb_top_level/U2/CH2/U9/dly_next_state} {/adc_deser_tb_top_level/U2/CH2/U9/ld_out} {/adc_deser_tb_top_level/U2/CH2/U9/start_test_out} {/adc_deser_tb_top_level/U2/CH2/U9/BITSLIP_CNT} {/adc_deser_tb_top_level/U2/CH2/U9/bitslip_out} {/adc_deser_tb_top_level/U2/CH2/U9/start_calibration} {/adc_deser_tb_top_level/U2/CH2/U9/CLK} {/adc_deser_tb_top_level/U2/CH2/U9/ARESET} {/adc_deser_tb_top_level/U2/CH2/U9/DATA} {/adc_deser_tb_top_level/U2/CH2/U9/PATTERN_VALID} {/adc_deser_tb_top_level/U2/CH2/U9/TEST_DONE} {/adc_deser_tb_top_level/U2/CH2/U9/START_TEST} {/adc_deser_tb_top_level/U2/CH2/U9/BITSLIP} {/adc_deser_tb_top_level/U2/CH2/U9/DELAY} {/adc_deser_tb_top_level/U2/CH2/U9/LD} {/adc_deser_tb_top_level/U2/CH2/U9/DONE} {/adc_deser_tb_top_level/U2/CH2/U9/delay_success_i} {/adc_deser_tb_top_level/U2/CH2/U9/bitslip_success_i} {/adc_deser_tb_top_level/U2/CH2/U9/SUCCESS}
wavearea -name "Export Area 1" "10.391 us" "13.348 us" 6 8
wavearea -name "Export Area 2" "4782.608 ns" "8739.13 ns" 11 11
wavearea -name "Export Area 3" "760.835 us" "766.617 us" 8 8
cursor "Cursor 1" 406260876ps  
transcript on
