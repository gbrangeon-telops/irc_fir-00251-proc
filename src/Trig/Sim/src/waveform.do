onerror { resume }
transcript off
add wave -noreg -logic {/tb_trig_top/aresetn}
add wave -noreg -logic {/tb_trig_top/clk_mb}
add wave -noreg -decimal -literal {/tb_trig_top/TRIG/MB_MISO}
add wave -noreg -decimal -literal {/tb_trig_top/TRIG/MB_MOSI}
add wave -noreg -logic {/tb_trig_top/TRIG/EXT_TRIG}
add wave -named_row "CONTROLLER"
add wave -noreg -decimal -literal {/tb_trig_top/TRIG/U3/U2/CONFIG}
add wave -noreg -logic {/tb_trig_top/TRIG/U3/U2/EXTERNAL_TRIG}
add wave -noreg -logic {/tb_trig_top/TRIG/U3/U2/SEQ_SOFTTRIG}
add wave -noreg -logic {/tb_trig_top/TRIG/U3/U2/SFW_SYNC_TRIG}
add wave -noreg -logic {/tb_trig_top/TRIG/U3/U2/seq_trig_i}
add wave -noreg -logic {/tb_trig_top/TRIG/U3/U2/seq_enable_i}
add wave -noreg -decimal -literal {/tb_trig_top/TRIG/U3/U2/clk_counter_rising}
add wave -noreg -logic {/tb_trig_top/TRIG/U3/U2/seq_delay_enable_i}
add wave -noreg -logic {/tb_trig_top/TRIG/U3/U2/INTERNAL_PULSE}
add wave -noreg -logic {/tb_trig_top/TRIG/U3/U2/RAW_PULSE}
add wave -noreg -logic {/tb_trig_top/TRIG/U3/U2/integration_detect}
add wave -noreg -decimal -literal {/tb_trig_top/TRIG/U3/U2/frame_count}
add wave -named_row "CONDITIONER"
add wave -noreg -decimal -literal {/tb_trig_top/TRIG/U6/PARAM}
add wave -noreg -logic {/tb_trig_top/TRIG/U6/TRIG_IN}
add wave -noreg -literal {/tb_trig_top/TRIG/U6/trig_gen_sm}
add wave -noreg -decimal -literal {/tb_trig_top/TRIG/U6/cnt}
add wave -noreg -logic {/tb_trig_top/TRIG/U6/raw_trig_i}
add wave -noreg -logic {/tb_trig_top/TRIG/U6/acq_window_i}
add wave -noreg -logic {/tb_trig_top/TRIG/U6/raw_acq_trig_i}
add wave -noreg -logic {/tb_trig_top/TRIG/U6/raw_xtra_trig_i}
add wave -noreg -logic {/tb_trig_top/TRIG/U6/acq_trig_i}
add wave -noreg -logic {/tb_trig_top/TRIG/U6/xtra_trig_i}
add wave -noreg -logic {/tb_trig_top/TRIG/U6/trig_out_i}
add wave -noreg -decimal -literal {/tb_trig_top/TRIG/U6/cnt_trigout}
cursor "Cursor 1" 12us  
transcript on
