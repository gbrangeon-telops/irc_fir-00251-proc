onerror { resume }
transcript off
add wave -noreg -logic {/data_cdc_tb_stim_top_level/U1/full_i}
add wave -noreg -logic {/data_cdc_tb_stim_top_level/U1/empty_i}
add wave -noreg -logic {/data_cdc_tb_stim_top_level/U1/ARESET}
add wave -noreg -logic {/data_cdc_tb_stim_top_level/U1/srst}
add wave -noreg -logic {/data_cdc_tb_stim_top_level/U1/WCLK}
add wave -noreg -logic {/data_cdc_tb_stim_top_level/U1/WR}
add wave -noreg -hexadecimal -literal {/data_cdc_tb_stim_top_level/U1/D}
add wave -noreg -logic {/data_cdc_tb_stim_top_level/U1/RCLK}
add wave -noreg -logic {/data_cdc_tb_stim_top_level/U1/DVAL}
add wave -noreg -hexadecimal -literal {/data_cdc_tb_stim_top_level/U1/Q}
add wave -noreg -logic {/data_cdc_tb_stim_top_level/U1/ERR}
cursor "Cursor 1" 10us  
transcript on
