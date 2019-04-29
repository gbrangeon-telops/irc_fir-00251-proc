onerror { resume }
transcript off
add wave -noreg -logic {/tb_calib_top/STIM/ARESETN}
add wave -noreg -logic {/tb_calib_top/STIM/CLK100}
add wave -noreg -hexadecimal -literal {/tb_calib_top/STIM/AXIL_MOSI}
add wave -noreg -hexadecimal -literal {/tb_calib_top/STIM/AXIL_MISO}
add wave -noreg -hexadecimal -literal {/tb_calib_top/STIM/addr}
add wave -noreg -hexadecimal -literal {/tb_calib_top/CONFIG/MB_MOSI}
add wave -noreg -hexadecimal -literal {/tb_calib_top/CONFIG/MB_MISO}
add wave -noreg -hexadecimal -literal {/tb_calib_top/CONFIG/CALIB_RAM_BLOCK_OFFSET}
add wave -noreg -hexadecimal -literal {/tb_calib_top/CONFIG/PIXEL_DATA_BASE_ADDR}
add wave -noreg -hexadecimal -literal {/tb_calib_top/CONFIG/CAL_BLOCK_INDEX_MAX}
add wave -noreg -hexadecimal -literal {/tb_calib_top/CONFIG/AOI_PARAM}
add wave -noreg -logic {/tb_calib_top/CONFIG/AOI_PARAM_DVAL}
add wave -noreg -hexadecimal -literal {/tb_calib_top/CONFIG/CALIB_BLOCK_INFO_ARRAY}
add wave -noreg -logic {/tb_calib_top/CONFIG/CALIB_BLOCK_INFO_DVAL}
add wave -noreg -hexadecimal -literal {/tb_calib_top/CONFIG/CALIB_BLOCK_SEL_MODE}
add wave -noreg -hexadecimal -literal {/tb_calib_top/SEL/FPA_IMG_INFO}
add wave -noreg -literal {/tb_calib_top/SEL/sel_state}
add wave -noreg -hexadecimal -literal {/tb_calib_top/SEL/FRAME_ID}
add wave -noreg -hexadecimal -literal {/tb_calib_top/SEL/HDER_INFO}
add wave -noreg -logic {/tb_calib_top/SEL/HDER_SEND_START}
add wave -noreg -binary -literal {/tb_calib_top/SEL/ERR}
add wave -noreg -logic {/tb_calib_top/STIM/CLK160}
add wave -noreg -decimal -literal {/tb_calib_top/STIM/EXTRACTED_BLOCK_INDEX}
add wave -noreg -logic {/tb_calib_top/STIM/EXTRACTED_INFO_VALID}
add wave -noreg -logic {/tb_calib_top/U55/re}
add wave -noreg -logic {/tb_calib_top/U55/sre}
add wave -noreg -logic {/tb_calib_top/U2/Q}
add wave -noreg -literal {/tb_calib_top/SEQ/read_state}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/calib_block_index}
add wave -noreg -hexadecimal -literal {/tb_calib_top/SEQ/ddr_addr_offset_i}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/ram_info_base_addr}
add wave -noreg -logic {/tb_calib_top/SEQ/RAM_RD_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/ram_info_addr_index}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/RAM_RD_ADD}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/RAM_RD_DATA}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/ram_info_data_index}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/ram_info}
add wave -noreg -logic {/tb_calib_top/SEQ/output_en}
add wave -noreg -logic {/tb_calib_top/SEQ/ERR}
add wave -noreg -hexadecimal -literal {/tb_calib_top/SEQ/DDR_ADDR_OFFSET}
add wave -noreg -logic {/tb_calib_top/SEQ/DDR_READ_START}
add wave -named_row "FIFO"
add wave -noreg -logic {/tb_calib_top/STIM/CLK160}
add wave -noreg -logic {/tb_calib_top/STIM/FL_PIPE}
add wave -named_row "DATA"
add wave -noreg -logic {/tb_calib_top/STIM/CLK80}
add wave -noreg -logic {/tb_calib_top/STIM/CLK160}
add wave -noreg -logic {/tb_calib_top/DIN_MISO.TREADY}
add wave -noreg -decimal -literal {/tb_calib_top/DIN_MOSI}
add wave -noreg -logic {/tb_calib_top/pix_in_miso.TREADY}
add wave -noreg -decimal -literal {/tb_calib_top/pix_in_mosi}
add wave -noreg -logic {/tb_calib_top/core0_din_miso.TREADY}
add wave -noreg -decimal -literal {/tb_calib_top/core0_din_mosi}
add wave -noreg -logic {/tb_calib_top/core1_din_miso.TREADY}
add wave -noreg -decimal -literal {/tb_calib_top/core1_din_mosi}
add wave -noreg -logic {/tb_calib_top/pix_out_miso.TREADY}
add wave -noreg -decimal -literal {/tb_calib_top/pix_out_mosi}
add wave -noreg -logic {/tb_calib_top/DOUT_MISO.TREADY}
add wave -noreg -decimal -literal {/tb_calib_top/DOUT_MOSI}
add wave -noreg -decimal -literal {/tb_calib_top/pix_combine_err}
cursor "Cursor 1" 12us  
transcript on
