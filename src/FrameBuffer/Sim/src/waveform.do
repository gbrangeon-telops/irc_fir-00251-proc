onerror { resume }
transcript off	  
   
add wave -named_row "-------------------------- STIM----------------------------------"
add wave -noreg -logic {/Top/U1/CLK_DATA}
add wave -noreg -logic {/Top/U1/CLK_DIN}
add wave -noreg -logic {/Top/U1/ARESETN}
add wave -noreg -logic {/Top/U1/SW_PARAM}
add wave -noreg -logic {/Top/U1/AXIS_MOSI}
add wave -noreg -logic {/Top/U1/AXIS_MISO}
add wave -noreg -logic {/Top/U1/sw_type_cng}
add wave -noreg -logic {/Top/U1/BM_SW_CFG}
add wave -noreg -logic {/Top/U1/transmit}
add wave -noreg -logic {}
add wave -noreg -logic {}
 
 add wave -named_row "--------------- Writer (input)----------------------"
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_RX_DATA_MOSI.TVALID}	
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_RX_DATA_MOSI.TDATA}	
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_RX_DATA_MOSI.TLAST}	
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_RX_DATA_MISO.TREADY}
add wave -noreg -logic {/Top/U2/g0/U6/wr_next_incoming_frame} 	 
add wave -noreg -logic {/Top/U2/g0/U6/done}
add wave -noreg -logic {/Top/U2/g0/U6/next_read_buffer.tag}
add wave -noreg -logic {/Top/U2/g0/U6/current_write_buffer.tag}
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}

add wave -named_row "--------------- Writer (output)----------------------"
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_DATA_MOSI.TVALID}	
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_DATA_MOSI.TDATA}	
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_DATA_MOSI.TLAST}	
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_DATA_MISO.TREADY}

add wave -named_row "--------------- Reader(output)----------------------"
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_TX_DATA_MOSI.TVALID}	
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_TX_DATA_MOSI.TDATA}	
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_TX_DATA_MOSI.TLAST}	
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_TX_DATA_MISO.TREADY}	  

add wave -named_row "--------------- config----------------------"

add wave -noreg -logic {/Top/U2/g0/U6/USER_CFG}  
add wave -noreg -logic {/Top/U2/g0/U6/FB_CFG}  
add wave -noreg -logic {/Top/U2/g0/U6/CFG_UPDATE_PENDING}  
add wave -noreg -logic {/Top/U2/g0/U6/FLUSH}  
add wave -noreg -logic {/Top/U2/g0/U6/read_in_progress}  
add wave -noreg -logic {/Top/U2/g0/U6/write_in_progress}  
add wave -noreg -logic {/Top/U2/g0/U6/cfg_update_done}  
add wave -noreg -logic {/Top/U2/g0/U6/user_cfg_dval}  
add wave -noreg -logic {/Top/U2/g0/U6/cfg_updater_sm}  
add wave -noreg -logic {/Top/U2/U1/MB_MOSI}  
 add wave -noreg -logic {/Top/U2/U1/MB_MISO}
add wave -noreg -logic {/Top/U1/cfg_i}
add wave -noreg -logic {/Top/U2/g0/U6/current_read_buffer_valid}
add wave -noreg -logic {/Top/U2/g0/U6/sof_i}
add wave -noreg -logic {/Top/U2/g0/U6/current_read_buffer_sync.tag}
add wave -noreg -logic {/Top/U2/g0/U6/next_write_buffer.tag}
add wave -noreg -logic {/Top/U2/g0/U6/current_write_buffer.tag}
add wave -noreg -logic {}/Top/U2/g0/U6/init_cfg_done
add wave -noreg -logic {/Top/U2/g0/U6/s2mm_err_o}
add wave -noreg -logic {/Top/U2/g0/U6/switch_sm}
add wave -noreg -logic {/Top/U2/g0/U6/writer_sm}
add wave -noreg -logic {/Top/U2/g0/U6/cmd_cnt}

add wave -noreg -logic {/Top/U2/g0/U6/s2mm_cmd_mosi.TVALID} 
add wave -noreg -logic {/Top/U2/g0/U6/s2mm_cmd_miso.TREADY}
add wave -noreg -logic {}
add wave -noreg -logic {/Top/U2/g0/U5/cmd_cnt}
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}

# 
#transcript on
#