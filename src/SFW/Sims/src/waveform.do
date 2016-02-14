onerror { resume }
transcript off
add wave -named_row "SIMULATION SRC"
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/STIM/AXIL_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/STIM/AXIL_MISO}
add wave -noreg -logic {/tb_sfw_top/STIM/CHAN_A}
add wave -noreg -logic {/tb_sfw_top/STIM/CHAN_B}
add wave -noreg -logic {/tb_sfw_top/STIM/CHAN_I}
add wave -noreg -logic {/tb_sfw_top/STIM/SFW_TRIG}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/STIM/FPA_EXP_INFO}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/STIM/FPA_IMG_INFO}
add wave -noreg -logic {/tb_sfw_top/STIM/EXP_INFO_BUSY}
add wave -noreg -logic {/tb_sfw_top/STIM/CLK100}
add wave -noreg -logic {/tb_sfw_top/STIM/ARESETN}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/STIM/lock}
add wave -noreg -decimal -literal -signed2 {/tb_sfw_top/STIM/rand_num}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/STIM/frame_id}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/STIM/exp_time_cmd}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/STIM/exp_time_indx}
add wave -named_row "FW_DECODER"
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U2/CHAN_A}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U2/CHAN_B}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U2/CHAN_I}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U2/NB_ENCODER_COUNTS}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U2/RPM_FACTOR}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U2/LOCK}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U2/POS}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U2/DIR}
add wave -noreg -decimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS}
add wave -noreg -virtual "VBus3"  -decimal {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(19)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(18)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(17)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(16)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(15)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(14)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(13)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(12)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(11)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(10)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(9)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(8)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(7)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(6)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(5)} {/tb_sfw_top/SFW_MOD/U2/RPM_MEAS(4)}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U2/NEXT_ZERO_PHASE}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U2/PREV_ZERO_PHASE}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U2/pos_i}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U2/dir_i}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U2/rpm_i}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U2/lock_i}
add wave -named_row "SFW_CTRL"
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U3/AXIL_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U3/AXIL_MISO}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U3/NB_ENCODER_COUNTS}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U3/RPM_FACTOR}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U3/MIN_POSITIONS}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U3/MAX_POSITIONS}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U3/CLEAR_ERR}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U3/VALID_PARAM}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U3/WHEEL_STATE}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U3/POSITION_SETPOINT}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U3/RPM_MAX}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U3/FILTER_LOCK}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U3/POSITION}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U3/RPM}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U3/ERROR_SPEED}
add wave -named_row "SFW_PRocessing"
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U1/WHEEL_STATE}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U1/POSITION_SETPOINT}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U1/RPM_MAX}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/CLEAR_ERR}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/VALID_PARAM}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/FILTER_NUM_LOCKED}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/ERROR_SPD}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/LOCKED}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U1/POSITION}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/DIR}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U1/RPM}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/INTEGRATION}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U1/RISING_POSITION}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U1/FALLING_POSITION}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U1/ACQ_FILTER_NUMBER}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U1/CURRENT_FILTER_NUMBER}
add wave -noreg -hexadecimal -literal -unsigned {/tb_sfw_top/SFW_MOD/U1/NEXT_FILTER_NUMBER}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/SYNC_TRIG}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U1/minimal_positions}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U1/maximal_positions}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/valid_parameters}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U1/wheel_state_i}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U1/position_setpoint_i}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U1/next_filter_number_i}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U1/current_filter_number_i}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/valid_filter}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/valid_filter_q1}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/next_position_invalid}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/valid_integration}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/filter_number_locked}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/integration_i}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/integration_r1}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/clear_errors}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U1/error_speed}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U1/rpm_max_i}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U1/position_i}
add wave -named_row "AXIL_MUX"
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U4/Axi_Master_Mosi}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U4/Axi_Master_Miso}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U4/AXIL_S0_Mosi}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U4/AXIL_S0_Miso}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U4/AXIL_S1_Mosi}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U4/AXIL_S1_Miso}
add wave -named_row "SPD_RAM"
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U7/clka}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U7/ena}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U7/wea}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U7/addra}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U7/dina}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U7/clkb}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U7/enb}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U7/addrb}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U7/doutb}
add wave -named_row "SFW_ACQ_SM"
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U8/VALID_PARAM}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U8/FILTER_NUM_LOCKED}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/WHEEL_STATE}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/RISING_POSITION}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/FALLING_POSITION}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/RPM}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/ACQ_FILTER_NUMBER}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/CURRENT_FILTER_NUMBER}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/NEXT_FILTER_NUMBER}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/SFW_HDR_MOSI}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/SFW_HDR_MISO}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/FPA_IMG_INFO}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U8/SYNC_TRIG}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/FPA_EXP_INFO}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U8/EXP_INFO_BUSY}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/EXP_RAM_ADDR}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/EXP_RAM_DATA}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U8/SYNC_ERROR}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U8/enable}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U8/valid_parameters}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/fpa_exp_info_o}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U8/sfw_trig_d1}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/next_exp_time}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/current_exp_time}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/exp_time}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/exp_time_indx}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/next_hdr_index}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/exp_feedbk_sr}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U8/sync_err_o}
add wave -noreg -literal {/tb_sfw_top/SFW_MOD/U8/write_state}
add wave -noreg -literal {/tb_sfw_top/SFW_MOD/U8/next_write_state}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/axil_mosi_i}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U8/axil_miso_i}
add wave -named_row "TB_SINK"
add wave -noreg -logic {/tb_sfw_top/U1/ARESETN}
add wave -noreg -logic {/tb_sfw_top/U1/CLK100}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/U1/AXIL_MOSI}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/U1/AXIL_MISO}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/U1/FPA_IMG_INFO}
add wave -noreg -decimal -literal -signed2 {/tb_sfw_top/U1/frame_id}
add wave -noreg -literal {/tb_sfw_top/U1/read_state_machine}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/U1/exp_feedbk_sr}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/U1/hdr_list}
add wave -named_row "TRIF_PULS"
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U10/PULSE}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U10/CLK_IN}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U10/CLK_OUT}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U10/PULSE_OUT}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U10/pulse_i}
add wave -noreg -hexadecimal -literal {/tb_sfw_top/SFW_MOD/U10/pulse_o}
add wave -noreg -logic {/tb_sfw_top/SFW_MOD/U10/pulse_or}
cursor "Cursor 1" 150918671895ps  
cursor "Cursor 2" 500ms  
cursor "Cursor 16" 100ms  
cursor "Cursor 11" 100ms  
cursor "Cursor 5" 60331105ns  
transcript on
