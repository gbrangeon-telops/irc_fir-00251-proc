onerror { resume }
transcript off
add wave -noreg -logic {/flagging_tb/U1/U3/ARESET}
add wave -noreg -logic {/flagging_tb/U1/U3/CLK}
add wave -noreg -decimal -literal -unsigned {/flagging_tb/U1/U3/Hder_Axil_Mosi}
add wave -noreg -decimal -literal -unsigned {/flagging_tb/U1/U3/Hder_Axil_Miso}
add wave -noreg -logic {/flagging_tb/U1/U3/SOFT_TRIG}
add wave -noreg -logic {/flagging_tb/U1/U3/HARD_TRIG}
add wave -noreg -decimal -literal -unsigned {/flagging_tb/U1/U3/FLAG_CFG}
add wave -noreg -decimal -literal -unsigned {/flagging_tb/U1/U3/IMG_INFO}
add wave -noreg -logic {/flagging_tb/U1/U3/sreset}
add wave -noreg -logic {/flagging_tb/U1/U3/soft_trig_i}
add wave -noreg -logic {/flagging_tb/U1/U3/soft_trig_last}
add wave -noreg -logic {/flagging_tb/U1/U3/flag_cfg_dval_last}
add wave -noreg -logic {/flagging_tb/U1/U3/enable_softtrig_i}
add wave -noreg -logic {/flagging_tb/U1/U3/wait_for_init_i}
add wave -noreg -logic {/flagging_tb/U1/U3/acq_started}
add wave -noreg -logic {/flagging_tb/U1/U3/trig_i}
add wave -noreg -logic {/flagging_tb/U1/U3/trig_last_i}
add wave -noreg -logic {/flagging_tb/U1/U3/trig_delay_i}
add wave -noreg -logic {/flagging_tb/U1/U3/mixed_trig_i}
add wave -noreg -logic {/flagging_tb/U1/U3/mixed_trig_last_i}
add wave -noreg -logic {/flagging_tb/U1/U3/flag_enable_i}
add wave -noreg -logic {/flagging_tb/U1/U3/exp_feedbk_last}
add wave -noreg -decimal -literal {/flagging_tb/U2/Feedback_FPA_Info}
add wave -noreg -decimal -literal -unsigned {/flagging_tb/U1/U3/clk_counter_rising}
add wave -noreg -decimal -literal -unsigned {/flagging_tb/U1/U3/clk_counter_falling}
add wave -noreg -decimal -literal -unsigned {/flagging_tb/U1/U3/frame_count}
add wave -noreg -decimal -literal -unsigned {/flagging_tb/U1/U3/axil_mosi_i}
add wave -noreg -decimal -literal -unsigned {/flagging_tb/U1/U3/axil_miso_i}
add wave -noreg -logic {/flagging_tb/U1/U3/flag_hder_enable}
add wave -noreg -hexadecimal -literal {/flagging_tb/hder_mosi}
add wave -noreg -hexadecimal -literal {/flagging_tb/hder_miso}
add wave -noreg -literal {/flagging_tb/U1/U3/writing_state}
add wave -noreg -decimal -literal {/flagging_tb/U2/feedback_fpa_info_i}
cursor "Cursor 1" 2us  
cursor "Cursor 2" 670ns  
cursor "Cursor 3" 2us  
transcript on
