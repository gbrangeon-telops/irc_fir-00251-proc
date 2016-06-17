onerror { resume }
transcript off
add wave -noreg -logic {/tb_clink_top/STIM/ARESET}
add wave -noreg -logic {/tb_clink_top/STIM/CLK80}
add wave -noreg -decimal -literal {/tb_clink_top/PATTERN/FVAL_SIZE}
add wave -noreg -logic {/tb_clink_top/PATTERN/START}
add wave -noreg -literal {/tb_clink_top/PATTERN/test_state}
add wave -noreg -logic {/tb_clink_top/PATTERN/fval_i}
add wave -noreg -logic {/tb_clink_top/PATTERN/fval_last}
add wave -noreg -logic {/tb_clink_top/PATTERN/lval_i}
add wave -noreg -logic {/tb_clink_top/PATTERN/lval_last}
add wave -noreg -decimal -literal {/tb_clink_top/PATTERN/lval_counter}
add wave -noreg -logic {/tb_clink_top/PATTERN/DONE}
add wave -noreg -logic {/tb_clink_top/PATTERN/PATTERN_VALID}
add wave -noreg -literal {/tb_clink_top/PATTERN/timeout_state}
add wave -noreg -decimal -literal {/tb_clink_top/PATTERN/timeout_cnt}
add wave -noreg -decimal -literal {/tb_clink_top/PATTERN/timeout_cnt_reset}
add wave -noreg -logic {/tb_clink_top/PATTERN/timeout_occurred}
cursor "Cursor 1" 10us  
transcript on
