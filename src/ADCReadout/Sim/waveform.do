onerror { resume }
transcript off
add wave -noreg -logic {/adc_readout_tb_toplevel/U1/CLK}
add wave -noreg -logic {/adc_readout_tb_toplevel/U1/MBCLK}
add wave -noreg -logic {/adc_readout_tb_toplevel/U1/ARESET}
add wave -noreg -decimal -literal -signed2 -binarypoint 16 {/adc_readout_tb_toplevel/U1/R}
add wave -noreg -decimal -literal -signed2 -binarypoint 16 {/adc_readout_tb_toplevel/U1/Q}
add wave -noreg -logic {/adc_readout_tb_toplevel/U1/DVAL}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_tb_toplevel/U1/DATA}
add wave -noreg -hexadecimal -literal -signed2 {/adc_readout_tb_toplevel/U1/data_miso}
add wave -noreg -hexadecimal -literal -signed2 {/adc_readout_tb_toplevel/U1/data_mosi}
add wave -noreg -logic {/adc_readout_tb_toplevel/U2/ADC_DVAL}
add wave -noreg -decimal -literal -signed2 {/adc_readout_tb_toplevel/U2/ADC_DATA}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_tb_toplevel/U2/IMG_INFO}
add wave -noreg -logic {/adc_readout_tb_toplevel/U2/int_sync}
add wave -noreg -decimal -literal -signed2 {/adc_readout_tb_toplevel/U2/delta}
add wave -noreg -hexadecimal -literal -unsigned {/adc_readout_tb_toplevel/U2/shift_register}
add wave -noreg -logic {/adc_readout_tb_toplevel/U2/new_adc_data}
add wave -noreg -logic {/adc_readout_tb_toplevel/U2/new_sum_data}
add wave -noreg -decimal -literal -signed2 {/adc_readout_tb_toplevel/U2/running_sum}
add wave -noreg -height 100 -decimal -analog -analogmin -1490 -analogmax -919 -signed2 {/adc_readout_tb_toplevel/U2/running_sum_hold}
add wave -noreg -decimal -literal -signed2 -binarypoint 4 {/adc_readout_tb_toplevel/U2/raw_data_S12Q4}
add wave -noreg -decimal -literal -signed2 -binarypoint 4 {/adc_readout_tb_toplevel/U2/temp_S12Q4}
add wave -noreg -decimal -literal -signed2 -binarypoint 16 {/adc_readout_tb_toplevel/U2/millivolt_data_S15Q16}
add wave -noreg -logic {/adc_readout_tb_toplevel/U2/dout_valid}
add wave -noreg -hexadecimal -literal {/adc_readout_tb_toplevel/U2/millivolt_data_out}
add wave -noreg -decimal -literal -signed2 {/adc_readout_tb_toplevel/U2/millivolt_data_out_sync}
add wave -noreg -logic {/adc_readout_tb_toplevel/U2/dout_valid_sync}
add wave -noreg -logic {/adc_readout_tb_toplevel/U2/start_transaction}
add wave -noreg -literal -signed2 {/adc_readout_tb_toplevel/U2/conv_state}
add wave -noreg -logic {/adc_readout_tb_toplevel/U2/DVAL_OUT}
add wave -noreg -decimal -literal -signed2 {/adc_readout_tb_toplevel/U2/VALUE_OUT}
add wave -noreg -logic {/adc_readout_tb_toplevel/U2/CLK_DATA}
add wave -noreg -decimal -literal -signed2 -binarypoint 16 {/adc_readout_tb_toplevel/U2/product_SS15Q16}
add wave -noreg -decimal -literal -signed2 -binarypoint 4 {/adc_readout_tb_toplevel/U2/adc_calib_q_S12Q4_i}
add wave -noreg -decimal -literal -signed2 -binarypoint 12 {/adc_readout_tb_toplevel/U2/adc_calib_r_S3Q12_i}
add wave -noreg -literal {/adc_readout_tb_toplevel/U2/write_state}
add wave -noreg -hexadecimal -literal {/adc_readout_tb_toplevel/U2/frame_id_i}
add wave -noreg -hexadecimal -literal {/adc_readout_tb_toplevel/U2/axil_mosi_i}
cursor "Cursor 1" 11478261ps  
transcript on
