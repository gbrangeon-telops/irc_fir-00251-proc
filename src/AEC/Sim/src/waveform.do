onerror { resume }
transcript off
add wave -noreg -logic {/aec_tb_top/U4/ARESETN}
add wave -noreg -logic {/aec_tb_top/U4/CLK160}
add wave -noreg -logic {/aec_tb_top/U4/CLK100}
add wave -named_row "STIM"
add wave -noreg -decimal -literal -signed2 {/aec_tb_top/U4/stream_val}
add wave -noreg -logic -unsigned {/aec_tb_top/U4/AXI_STREAM_MISO.TREADY}
add wave -noreg -hexadecimal -literal -unsigned {/aec_tb_top/U4/AXI_STREAM_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/aec_tb_top/U4/AXIL_MOSI}
add wave -noreg -hexadecimal -literal -unsigned {/aec_tb_top/U4/AXIL_MISO}
add wave -noreg -decimal -literal -signed2 {/aec_tb_top/U4/image_fraction_o}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U4/timestamp_i}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U4/lowerbin_id_i}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U4/lowercumsum_i}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U4/uppercumsum_i}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U4/nb_pixel_i}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U4/exposuretime_i}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U4/error_s}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U4/imagefraction_fbck_i}
add wave -named_row "HDER_EXTRACTOR"
add wave -noreg -logic {/aec_tb_top/U1/U1/CLK_STREAM}
add wave -noreg -logic -unsigned {/aec_tb_top/U1/U1/sreset}
add wave -noreg -logic -unsigned {/aec_tb_top/U1/U1/IMG_DATA_MISO.TREADY}
add wave -noreg -hexadecimal -literal -unsigned {/aec_tb_top/U1/U1/IMG_DATA_MOSI}
add wave -noreg -logic {/aec_tb_top/U1/U1/tid}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U1/U1/uHdr_addr_loc32}
add wave -noreg -decimal -literal {/aec_tb_top/U1/U1/img_hdr_len_o}
add wave -noreg -decimal -literal {/aec_tb_top/U1/U1/img_exposuretime_o}
add wave -noreg -logic -unsigned {/aec_tb_top/U1/U1/test_logic}
add wave -named_row "AEC"
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U1/U3/IMAGE_FRACTION}
add wave -noreg -logic -unsigned {/aec_tb_top/U1/U3/AEC_CTRL_CLEARMEM}
add wave -noreg -binary -literal -unsigned {/aec_tb_top/U1/U3/AEC_MODE}
add wave -noreg -literal {/aec_tb_top/U1/U3/AEC_state}
add wave -noreg -logic -unsigned {/aec_tb_top/U1/U3/HIST_CLEARMEM}
add wave -noreg -logic {/aec_tb_top/U1/U3/HIST_RDY}
add wave -noreg -logic {/aec_tb_top/U1/U3/tmi_error_s}
add wave -noreg -logic {/aec_tb_top/U1/U3/tmi_idle_s}
add wave -noreg -logic -unsigned {/aec_tb_top/U1/U3/tmi_busy_s}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U1/U3/tmi_add_s}
add wave -noreg -logic -unsigned {/aec_tb_top/U1/U3/tmi_dval_s}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U1/U3/tmi_rddata_s}
add wave -noreg -logic -unsigned {/aec_tb_top/U1/U3/tmi_rddval_s}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U1/U3/TMI_add_out}
add wave -noreg -hexadecimal -literal -unsigned {/aec_tb_top/U1/U3/CumSum_Acc}
add wave -noreg -logic {/aec_tb_top/U1/U3/if_maxfound}
add wave -noreg -logic -unsigned {/aec_tb_top/U1/U3/CUMSUM_READY}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U1/U3/LOWERCUMSUM}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U1/U3/UPPERCUMSUM}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U1/U3/LOWERBINID}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U1/U3/IMAGE_FRACTION_FBCK}
add wave -noreg -decimal -literal -unsigned {/aec_tb_top/U1/U3/NB_PIXEL}
add wave -noreg -logic {/aec_tb_top/U1/U3/CUMSUM_ERROR}
add wave -noreg -logic {/aec_tb_top/U1/hist_reset}
add wave -noreg -hexadecimal -literal {/aec_tb_top/U1/exptime_in}
add wave -noreg -hexadecimal -literal {/aec_tb_top/U1/h_exptime}
cursor "Cursor 1" 100us  
transcript on
