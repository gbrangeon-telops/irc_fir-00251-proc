onerror { resume }
transcript off
add wave -noreg -logic {/icu_tb_toplevel/U2/CLK}
add wave -noreg -logic {/icu_tb_toplevel/U2/ARESET}
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U2/AXIL_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U2/AXIL_MISO}
add wave -noreg -decimal -literal -unsigned {/icu_tb_toplevel/U2/pulse_width_i}
add wave -noreg -decimal -literal -unsigned {/icu_tb_toplevel/U2/period_i}
add wave -noreg -decimal -literal -unsigned {/icu_tb_toplevel/U2/transition_duration_i}
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U2/cmd_i}
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U2/mode_i}
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U2/polarity_i}
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U2/status_i}		
add wave -noreg -decimal -literal -unsigned {/icu_tb_toplevel/U1/U2/PULSE_WIDTH}   
add wave -noreg -decimal -literal -unsigned {/icu_tb_toplevel/U1/U2/pulse_width_hold}
add wave -noreg -decimal -literal -unsigned {/icu_tb_toplevel/U1/U2/PERIOD}		   
add wave -noreg -decimal -literal -unsigned {/icu_tb_toplevel/U1/U2/period_hold}
add wave -noreg -decimal -literal -unsigned {/icu_tb_toplevel/U1/U2/TRANSITION_DURATION}   
add wave -noreg -decimal -literal -unsigned {/icu_tb_toplevel/U1/U2/CALIB_POLARITY}   
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U1/U2/CMD}			   
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U1/U1/CMD}			   
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U1/U2/MODE}						
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U1/U2/POSITION}
add wave -noreg -decimal -literal -unsigned {/icu_tb_toplevel/U1/U2/transition_duration_hold}
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U1/U2/cmd_hold}
add wave -noreg -hexadecimal -literal -unsigned {/icu_tb_toplevel/U1/U2/mode_hold}
#add wave -noreg -logic {/icu_tb_toplevel/U1/U2/polarity_1p}
add wave -noreg -logic {/icu_tb_toplevel/U1/U2/polarity_hold}
#add wave -noreg -logic {/icu_tb_toplevel/U1/U2/new_cmd}
add wave -noreg -literal {/icu_tb_toplevel/U1/U2/state}	 
add wave -noreg -logic {/icu_tb_toplevel/U1/U2/new_config_1p}
add wave -noreg -logic {/icu_tb_toplevel/U1/U2/pulse}
#add wave -noreg -decimal -literal -signed2 {/icu_tb_toplevel/U1/U2/pulse_gen/period_cnt}
#add wave -noreg -decimal -literal -signed2 {/icu_tb_toplevel/U1/U2/pulse_gen/ms_cnt}
#add wave -noreg -decimal -literal -unsigned {/icu_tb_toplevel/U1/U2/pulse_gen/in_transition_cnt}
#add wave -noreg -decimal -literal {/icu_tb_toplevel/U1/U2/pulse_gen/PULSE_CNT_MAX}
#add wave -noreg -decimal -literal {/icu_tb_toplevel/U1/U2/pulse_gen/PERIOD_CNT_MAX}
add wave -noreg -logic {/icu_tb_toplevel/U1/U2/issue_move}
add wave -noreg -logic {/icu_tb_toplevel/U1/U2/in_transition}
add wave -noreg -logic {/icu_tb_toplevel/U1/IN_A}
add wave -noreg -logic {/icu_tb_toplevel/U1/IN_B}  							   
cursor "Cursor 1" 6045ns  
transcript on
