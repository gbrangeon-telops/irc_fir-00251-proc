onerror { resume }
transcript off
add wave -noreg -logic {/tb_expTime_top/aresetn}
add wave -noreg -logic {/tb_expTime_top/clk_mb}
add wave -noreg -decimal -literal {/tb_expTime_top/STIM/EHDRI_AXIL_MOSI}
add wave -noreg -decimal -literal {/tb_expTime_top/STIM/EHDRI_AXIL_MISO}
add wave -noreg -decimal -literal {/tb_expTime_top/STIM/ET_AXIL_MOSI}
add wave -noreg -decimal -literal {/tb_expTime_top/STIM/ET_AXIL_MISO}
add wave -noreg -decimal -literal {/tb_expTime_top/STIM/TRIG_AXIL_MOSI}
add wave -noreg -decimal -literal {/tb_expTime_top/STIM/TRIG_AXIL_MISO}
add wave -named_row "EHDRI SM"
add wave -noreg -logic {/tb_expTime_top/EHDRI/U4/Enable}
add wave -noreg -decimal -literal {/tb_expTime_top/EHDRI/U4/mem_address_i}
add wave -noreg -decimal -literal {/tb_expTime_top/EHDRI/U4/Mem_Data}
add wave -noreg -logic {/tb_expTime_top/EHDRI/U4/EXP_Ctrl_Busy}
add wave -noreg -decimal -literal {/tb_expTime_top/EHDRI/U4/FPA_Exp_Info}
add wave -named_row "EXP TIME"
add wave -noreg -decimal -literal {/tb_expTime_top/EXP_TIME/U2/EXP_CONFIG}
add wave -noreg -literal {/tb_expTime_top/EXP_TIME/U2/exp_ctrl_sm}
add wave -noreg -logic {/tb_expTime_top/EXP_TIME/U2/EXP_CTRL_BUSY}
add wave -noreg -decimal -literal {/tb_expTime_top/EXP_TIME/U2/EHDRI_EXP_INFO}
add wave -noreg -logic {/tb_expTime_top/EXP_TIME/U2/fpa_synchro_done}
add wave -noreg -decimal -literal {/tb_expTime_top/EXP_TIME/U2/FPA_EXP_INFO}
add wave -named_row "TRIG CONTROLLER"
add wave -noreg -decimal -literal {/tb_expTime_top/TRIG/U3/U2/CONFIG}
add wave -noreg -logic {/tb_expTime_top/TRIG/U3/U2/INTERNAL_PULSE}
add wave -noreg -logic {/tb_expTime_top/TRIG/U3/U2/RAW_PULSE}
add wave -noreg -logic {/tb_expTime_top/TRIG/U3/U2/integration_detect}
add wave -noreg -decimal -literal {/tb_expTime_top/TRIG/U3/U2/frame_count}
add wave -named_row "TRIG CONDITIONER"
add wave -noreg -decimal -literal {/tb_expTime_top/TRIG/U6/PARAM}
add wave -noreg -logic {/tb_expTime_top/TRIG/U6/TRIG_IN}
add wave -noreg -literal {/tb_expTime_top/TRIG/U6/trig_gen_sm}
add wave -noreg -decimal -literal {/tb_expTime_top/TRIG/U6/cnt}
add wave -noreg -logic {/tb_expTime_top/TRIG/U6/raw_trig_i}
add wave -noreg -logic {/tb_expTime_top/TRIG/U6/acq_window_i}
add wave -noreg -logic {/tb_expTime_top/TRIG/U6/raw_acq_trig_i}
add wave -noreg -logic {/tb_expTime_top/TRIG/U6/acq_trig_i}
add wave -noreg -logic {/tb_expTime_top/TRIG/U6/trig_out_i}
add wave -noreg -decimal -literal {/tb_expTime_top/TRIG/U6/cnt_trigout}
cursor "Cursor 1" 3095065ps  
transcript on
