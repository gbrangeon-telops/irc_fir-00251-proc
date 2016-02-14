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
add wave -noreg -hexadecimal -literal {/tb_calib_top/CONFIG/EXPOSURE_TIME_MULT_FP32}
add wave -noreg -logic {/tb_calib_top/CONFIG/EXPOSURE_TIME_MULT_FP32_DVAL}
add wave -noreg -hexadecimal -literal {/tb_calib_top/CONFIG/CALIB_BLOCK_INFO_ARRAY}
add wave -noreg -logic {/tb_calib_top/CONFIG/CALIB_BLOCK_INFO_DVAL}
add wave -noreg -hexadecimal -literal {/tb_calib_top/CONFIG/CALIB_BLOCK_SEL_MODE}
add wave -noreg -hexadecimal -literal {/tb_calib_top/SEL/FPA_IMG_INFO}
add wave -noreg -literal {/tb_calib_top/SEL/sel_state}
add wave -noreg -hexadecimal -literal {/tb_calib_top/SEL/active_block_index}
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
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/SATURATION_THRESHOLD}
add wave -noreg -logic {/tb_calib_top/SEQ/SATURATION_THRESHOLD_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/NLC_LUT_PARAM}
add wave -noreg -logic {/tb_calib_top/SEQ/NLC_LUT_PARAM_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/RANGE_OFS_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/RANGE_OFS_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/POW2_OFFSET_EXP_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/POW2_OFFSET_EXP_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/POW2_RANGE_EXP_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/POW2_RANGE_EXP_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/NLC_POW2_M_EXP_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/NLC_POW2_M_EXP_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/NLC_POW2_B_EXP_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/NLC_POW2_B_EXP_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/DELTA_TEMP_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/DELTA_TEMP_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/ALPHA_OFFSET_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/ALPHA_OFFSET_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/POW2_ALPHA_EXP_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/POW2_ALPHA_EXP_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/POW2_BETA0_EXP_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/POW2_BETA0_EXP_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/POW2_KAPPA_EXP_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/POW2_KAPPA_EXP_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/NUC_MULT_FACTOR_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/NUC_MULT_FACTOR_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/RQC_LUT_PARAM}
add wave -noreg -logic {/tb_calib_top/SEQ/RQC_LUT_PARAM_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/RQC_LUT_PAGE_ID}
add wave -noreg -logic {/tb_calib_top/SEQ/RQC_LUT_PAGE_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/RQC_POW2_M_EXP_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/RQC_POW2_M_EXP_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/RQC_POW2_B_EXP_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/RQC_POW2_B_EXP_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/OFFSET_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/OFFSET_FP32_WR_EN}
add wave -noreg -decimal -literal {/tb_calib_top/SEQ/POW2_LSB_FP32}
add wave -noreg -logic {/tb_calib_top/SEQ/POW2_LSB_FP32_WR_EN}
add wave -named_row "FIFO"
add wave -noreg -logic {/tb_calib_top/STIM/CLK160}
add wave -noreg -logic {/tb_calib_top/STIM/FL_PIPE}
add wave -noreg -logic {/tb_calib_top/U17/SYNC_MISO.TREADY}
add wave -noreg -logic {/tb_calib_top/U17/SYNC_MOSI.TVALID}
add wave -noreg -logic {/tb_calib_top/U17/SYNC_MOSI.TLAST}
add wave -noreg -logic {/tb_calib_top/U17/FL_PIPE_N}
add wave -noreg -decimal -literal {/tb_calib_top/U17/DOUT}
add wave -noreg -logic {/tb_calib_top/U17/VALID}
add wave -noreg -logic {/tb_calib_top/U17/A_FULL}
add wave -noreg -logic {/tb_calib_top/U17/OVFL}
add wave -noreg -logic {/tb_calib_top/U49/SYNC_MISO.TREADY}
add wave -noreg -logic {/tb_calib_top/U49/SYNC_MOSI.TVALID}
add wave -noreg -logic {/tb_calib_top/U49/SYNC_MOSI.TLAST}
add wave -noreg -logic {/tb_calib_top/U49/FL_PIPE_N}
add wave -noreg -decimal -literal {/tb_calib_top/U49/DOUT0}
add wave -noreg -logic {/tb_calib_top/U49/VALID0}
add wave -noreg -decimal -literal {/tb_calib_top/U49/DOUT1}
add wave -noreg -logic {/tb_calib_top/U49/VALID1}
add wave -noreg -decimal -literal {/tb_calib_top/U49/DOUT2}
add wave -noreg -logic {/tb_calib_top/U49/VALID2}
add wave -noreg -decimal -literal {/tb_calib_top/U49/DOUT3}
add wave -noreg -logic {/tb_calib_top/U49/VALID3}
add wave -noreg -decimal -literal {/tb_calib_top/U49/DOUT4}
add wave -noreg -logic {/tb_calib_top/U49/VALID4}
add wave -noreg -logic {/tb_calib_top/U49/A_FULL}
add wave -noreg -logic {/tb_calib_top/U49/OVFL}
cursor "Cursor 1" 12us  
transcript on
