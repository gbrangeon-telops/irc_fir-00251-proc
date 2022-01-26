onerror { resume }
transcript off	  

#add wave -named_row "stim" 		
add wave -noreg -logic {/Top/U1/CLK_DIN}
add wave -noreg -logic {/Top/U1/transmit}
add wave -noreg -logic {/top/U1/CLK_DATA}

add wave -named_row "------------------------fifo out-------------------------------------"
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}	 
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}	
add wave -noreg -logic {}	 
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}	 
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}	

		
 add wave -named_row "------------------------AXIS_64-------------------------------------"
add wave -noreg -logic {/Top/U2/g0/WRITE_FR/pix_counter}	 
add wave -noreg -logic {/Top/U2/g0/WRITE_FR/FRAME_RATE_MIN}
add wave -noreg -logic {/Top/U2/g0/WRITE_FR/FRAME_RATE_MAX}
add wave -noreg -logic {}	 
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}	 
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}	 
add wave -noreg -logic {}
add wave -noreg -logic {}
 
add wave -named_row "------------------------WRITER-------------------------------------"
add wave -noreg -logic {/Top/U1/CLK_DIN} 
add wave -noreg -logic {/top/U2/g0/U6/fb_cfg_i}
add wave -noreg -logic {/top/U2/g0/U6/sof_i}	   
add wave -noreg -logic {/Top/U2/g0/U6/wr_next_incoming_frame}
add wave -noreg -logic {/Top/U2/g0/U6/done}
add wave -noreg -logic {/Top/U2/g0/U6/writer_sm}		  
add wave -noreg -logic {/Top/U2/g0/U6/s2mm_addr} 
add wave -named_row "buffer manager intf"
add wave -noreg -logic {/Top/U2/g0/U6/WR_BUFFER_STATUS}
add wave -noreg -logic {/Top/U2/g0/U6/WR_BUFFER_STATUS_UPDATE}
add wave -noreg -logic {/Top/U2/g0/U6/STALL_WRITER} 
 	  
			  
add wave -named_row "cmd & status"
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_CMD_MOSI.TVALID}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_CMD_MOSI.TDATA}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_CMD_MISO.TREADY}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_STS_MOSI.TVALID}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_STS_MOSI.TDATA}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_STS_MISO.TREADY}



add wave -named_row "input"
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_RX_DATA_MOSI.TVALID}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_RX_DATA_MOSI.TDATA}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_RX_DATA_MOSI.TLAST}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_RX_DATA_MOSI.TID}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_RX_DATA_MISO.TREADY}
add wave -named_row "output"
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_DATA_MOSI.TVALID}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_DATA_MOSI.TDATA}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_DATA_MOSI.TLAST}
add wave -noreg -logic {/Top/U2/g0/U6/AXIS_S2MM_DATA_MOSI.TID}
add wave -noreg -logic {/Top/U2/vU6/AXIS_S2MM_DATA_MISO.TREADY}
 
add wave -noreg -logic {/Top/U2/g0/U6/switch_sm} 


add wave -named_row "--------------------------FIFO----------------------------------"
add wave -noreg -logic {/Top/U2/g0/U7/TX_MOSI.TVALID}
add wave -noreg -logic {/Top/U2/g0/U7/TX_MOSI.TDATA}
add wave -noreg -logic {/Top/U2/g0/U7/TX_MOSI.TLAST}
add wave -noreg -logic {/Top/U2/g0/U7/TX_MISO.TREADY}
add wave -noreg -logic {/Top/U2/g0/U6/mask_tlast} 





add wave -named_row "--------------------------READER----------------------------------"	   

add wave -noreg -logic {/Top/U2/g0/U5/reader_sm} 
add wave -noreg -logic {/Top/U2/g0/U5/done} 
add wave -noreg -logic {/top/U2/g0/U5/eof}

add wave -noreg -logic {/Top/U2/g0/U5/dm_sts_ack_sm}
add wave -noreg -logic {/Top/U2/g0/U5/dm_rdy}
add wave -noreg -logic {/Top/U2/g0/U5/output_sm}
add wave -noreg -logic {/Top/U2/g0/U5/pix_cnt}
add wave -noreg -logic {/Top/U2/g0/U5/fval_cnt}
add wave -noreg -logic {/Top/U2/g0/U5/dm_sts_ack_sm}

add wave -noreg -logic {/Top/U2/g0/U5/gen_tid}	 
add wave -noreg -logic {/Top/U2/g0/U5/gen_tlast}
add wave -noreg -logic {}

add wave -named_row "buffer manager intf"
add wave -noreg -logic {/Top/U2/g0/U5/RD_BUFFER_STATUS}
add wave -noreg -logic {/Top/U2/g0/U5/RD_BUFFER_STATUS_UPDATE}
add wave -noreg -logic {}
 


add wave -named_row "cmd & status"
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_MM2S_CMD_MOSI.TVALID}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_MM2S_CMD_MOSI.TDATA}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_MM2S_CMD_MISO.TREADY}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_MM2S_STS_MOSI.TVALID}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_MM2S_STS_MOSI.TDATA}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_MM2S_STS_MISO.TREADY} 

add wave -named_row "input"
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_MM2S_DATA_MOSI.TVALID}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_MM2S_DATA_MOSI.TDATA}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_MM2S_DATA_MOSI.TLAST}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_MM2S_DATA_MOSI.TID}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_MM2S_DATA_MISO.TREADY}	
   
add wave -named_row "fifo input"
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_fifo_in_mosi.TVALID}
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_fifo_in_mosi.TDATA}
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_fifo_in_mosi.TLAST}
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_fifo_in_mosi.TID}
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_fifo_in_miso.TREADY}	
	  
add wave -named_row "fifo output"  
add wave -noreg -logic {/top/U1/CLK_DATA}  
add wave -noreg -logic {/Top/U2/g0/U5/CLK}
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_fifo_out_mosi.TVALID}
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_fifo_out_mosi.TDATA}
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_fifo_out_mosi.TLAST}
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_fifo_out_mosi.TID}
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_fifo_out_miso.TREADY}	

add wave -named_row "output" 
add wave -noreg -logic {/Top/U2/g0/U5/width}
add wave -noreg -logic {/Top/U2/g0/U5/throttle_sm}
add wave -noreg -logic {/Top/U2/g0/U5/cnt}
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_data_tx_mosi}
add wave -noreg -logic {/Top/U2/g0/U5/axis_mm2s_data_tx_miso}
add wave -noreg -logic {} 
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_TX_DATA_MOSI.TVALID}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_TX_DATA_MOSI.TDATA}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_TX_DATA_MOSI.TLAST}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_TX_DATA_MOSI.TID}
add wave -noreg -logic {/Top/U2/g0/U5/AXIS_TX_DATA_MISO.TREADY}	  

add wave -named_row "--------------------------AXIS 64 FR----------------------------------"	
add wave -noreg -logic {/Top/U2/g0/READ_FR/FRAME_RATE_MIN}
add wave -noreg -logic {/Top/U2/g0/READ_FR/FRAME_RATE_MAX}
add wave -noreg -logic {/Top/U2/g0/READ_FR/pix_counter}
add wave -noreg -logic {/top/U1/CLK_DATA}
add wave -noreg -logic {}
add wave -noreg -logic {}	 
add wave -noreg -logic {}
add wave -noreg -logic {}
 
add wave -named_row "buffer manager intf"
add wave -noreg -logic {/Top/U2/g0/U5/throttler_sm}
add wave -noreg -logic {/Top/U2/g0/U5/cnt}
add wave -noreg -logic {}
add wave -noreg -logic {}
add wave -noreg -logic {}

add wave -named_row "--------------------------BUFFER MANAGER ----------------------------------"
add wave -noreg -logic {/top/U2/g0/U3/USER_CFG}
add wave -noreg -logic {/Top/U2/g0/U3/init_cfg_done} 
add wave -noreg -logic {/Top/U2/g0/U2/cfg_updater_sm}
add wave -noreg -logic /Top/U2/g0/U2/reader_rqst{}
add wave -noreg -logic {/Top/U2/g0/U2/writer_rqst}
add wave -noreg -logic {/Top/U2/g0/U2/wr_buffer_status_i}
add wave -noreg -logic {/Top/U2/g0/U2/rd_buffer_status_i}
add wave -noreg -logic {/Top/U2/g0/U2/wr_sts_ack_i}
add wave -noreg -logic {/Top/U2/U2/rd_sts_ack_i}
add wave -noreg -logic {/Top/U2/g0/U2/wr_sts_ack_o}
add wave -noreg -logic {/Top/U2/g0/U2/rd_sts_ack_o}
add wave -noreg -logic {/Top/U2/g0/U2/flush_i}
add wave -noreg -logic {/Top/U2/g0/U2/buffer_full_sts}
add wave -noreg -logic {/Top/U2/g0/U2/reader_done_i}
add wave -noreg -logic {/Top/U2/g0/U2/writer_done_i}
add wave -noreg -logic {/Top/U2/g0/U2/cfg_updater_rqst}
add wave -noreg -logic {/Top/U2/g0/U2/init_cfg_done}
add wave -noreg -logic {/Top/U2/g0/U2/cfg_update_done}

add wave -noreg -logic {/Top/U2/g0/U2/reader_rqst_sm} 
add wave -noreg -logic {/Top/U2/g0/U2/reader_rqst_latch}

add wave -noreg -logic {/Top/U2/g0/U2/writer_rqst_sm}
add wave -noreg -logic {/Top/U2/g0/U2/writer_rqst_latch}
add wave -noreg -logic {/Top/U2/g0/U2/reader_rqst_latch_o}
add wave -noreg -logic {}
add wave -noreg -logic {}

add wave -named_row "--------------------------uBlaze intf ----------------------------------"

add wave -noreg -logic {/Top/U2/g0/U2/user_cfg_i}
add wave -noreg -logic {/Top/U2/g0/U2/cfg_update_done}
add wave -noreg -logic {/Top/U2/g0/U2/USER_CFG}
add wave -noreg -logic {/Top/U2/g0/U2/axi_awaddr}
add wave -noreg -logic {/Top/U2/g0/U2/MB_MOSI}
add wave -noreg -logic {/Top/U2/g0/U2/MB_MISO}
add wave -noreg -logic {/Top/U2/g0/U2/new_config_valid}
add wave -noreg -logic {/Top/U2/g0/U2/new_config_valid_last}
add wave -noreg -logic {/Top/U2/g0/U2/new_config_valid_re}

add wave -named_row "--------------------------BRAM ----------------------------------"

add wave -noreg -logic {/Top/U3/AXI_BRAM_MOSI}
add wave -noreg -logic {/Top/U3/AXI_BRAM_MISO}

  
transcript on
