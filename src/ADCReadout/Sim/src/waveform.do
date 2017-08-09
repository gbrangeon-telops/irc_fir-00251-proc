onerror { resume }
transcript off
add wave -noreg -logic {/adc_readout_adc_tb_top/STIM/ARESETN}
add wave -noreg -logic {/adc_readout_adc_tb_top/STIM/ARESET}
add wave -noreg -logic {/adc_readout_adc_tb_top/SIN_GEN/clk}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/SIN_GEN/sin_out}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/SIN_GEN/sine}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/SIN_GEN/cnt}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/AD7980/ANALOG_IN}
add wave -noreg -logic {/adc_readout_adc_tb_top/AD7980/ADC_CNV}
add wave -noreg -logic {/adc_readout_adc_tb_top/AD7980/ADC_SCLK}
add wave -noreg -logic {/adc_readout_adc_tb_top/AD7980/ADC_SDI}
add wave -noreg -logic {/adc_readout_adc_tb_top/AD7980/ADC_SDO}
add wave -noreg -literal {/adc_readout_adc_tb_top/AD7980/adc_mode}
add wave -noreg -literal {/adc_readout_adc_tb_top/AD7980/adc_state}
add wave -noreg -literal {/adc_readout_adc_tb_top/AD7980/adc_state_d1}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/AD7980/conv_cnt}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/AD7980/acq_cnt}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/AD7980/vin}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/CLK}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/ARESET}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/START_ADC}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/ADC_CNV}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/ADC_SDI}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/ADC_SCLK}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/ADC_SDO}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/ADC_DATA_RDY}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/ADC_INTF/ADC_DATA}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/ADC_BUSY}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/ADC_ERR}
add wave -noreg -literal {/adc_readout_adc_tb_top/ADC_INTF/acq_fsm}
add wave -noreg -literal {/adc_readout_adc_tb_top/ADC_INTF/acq_fsm}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/start_adc_i}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/data_rdy_i}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/busy_i}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/master_clk_i}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/sclk_i}
add wave -noreg -hexadecimal -literal {/adc_readout_adc_tb_top/ADC_INTF/div_clk_cnt}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/adc_conv_i}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/acq_window}
add wave -noreg -hexadecimal -literal {/adc_readout_adc_tb_top/ADC_INTF/data_register}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/sreset}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/adc_din_reg}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/master_clk_i_last}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/master_clk_acq_edge}
add wave -noreg -hexadecimal -literal {/adc_readout_adc_tb_top/ADC_INTF/master_clk_cnt}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/sclk_iob}
add wave -noreg -logic {/adc_readout_adc_tb_top/ADC_INTF/adc_conv_iob}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U2/FPA_Img_Info}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U2/R}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U2/Q}
add wave -noreg -logic {/adc_readout_adc_tb_top/U2/mb_clk_o}
add wave -noreg -logic {/adc_readout_adc_tb_top/U2/rst_i}
add wave -noreg -logic {/adc_readout_adc_tb_top/U2/int_i}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U2/frame_id}
add wave -noreg -logic {/adc_readout_adc_tb_top/U2/stall_i}
add wave -noreg -logic {/adc_readout_adc_tb_top/U1/ENABLE}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/IMG_INFO}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/ADC_CALIB_R}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/ADC_CALIB_Q}
add wave -noreg -logic {/adc_readout_adc_tb_top/U1/ADC_DVAL}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/ADC_DATA}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/VALUE_OUT}
add wave -noreg -logic {/adc_readout_adc_tb_top/U1/DVAL_OUT}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/ADC_RDOUT_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/ADC_RDOUT_MISO}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/axil_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/axil_miso_i}
add wave -noreg -literal {/adc_readout_adc_tb_top/U1/write_state}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/running_sum}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/running_sum_hold}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/delta}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/shift_register}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/adc_calib_q_S16Q4_i}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/adc_calib_r_S3Q16_i}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/raw_data_S16Q4}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/temp_S16Q4}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/product_SS19Q20}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/millivolt_data_S15Q16}
add wave -noreg -decimal -literal -signed2 {/adc_readout_adc_tb_top/U1/millivolt_data_out}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/millivolt_data_out_sync}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/millivolt_data_out_sync_hold}
add wave -noreg -logic {/adc_readout_adc_tb_top/U1/dout_valid_sync}
add wave -noreg -logic {/adc_readout_adc_tb_top/U1/adc_dval_i}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/adc_data_i}
add wave -noreg -logic {/adc_readout_adc_tb_top/U1/new_adc_data}
add wave -noreg -logic {/adc_readout_adc_tb_top/U1/new_sum_data}
add wave -noreg -logic {/adc_readout_adc_tb_top/U1/dout_valid}
add wave -noreg -logic {/adc_readout_adc_tb_top/U1/start_transaction}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_adc_tb_top/U1/frame_id_i}
add wave -noreg -logic {/adc_readout_adc_tb_top/U1/int_sync}
add wave -noreg -logic {/adc_readout_adc_tb_top/U1/cdc_err}
add wave -noreg -literal {/adc_readout_adc_tb_top/U1/conv_state}
add wave -noreg -vanalogbus "Sin_out_analog"  {/adc_readout_adc_tb_top/SIN_GEN/sin_out}
add wave -noreg -vanalogbus "Running_sum_an"  {/adc_readout_adc_tb_top/U1/running_sum}
add wave -noreg -vanalogbus "millivold_out_an"  {/adc_readout_adc_tb_top/U1/millivolt_data_out}
add wave -noreg -vanalogbus "millivolt_out_an_decimal"  {/adc_readout_adc_tb_top/U1/millivolt_data_out}
cursor "Cursor 6" 5ms  
cursor "Cursor 1" 2453347967ps  
cursor "Cursor 2" 8025ns  
cursor "Cursor 3" 2469813.39ns  
transcript on
