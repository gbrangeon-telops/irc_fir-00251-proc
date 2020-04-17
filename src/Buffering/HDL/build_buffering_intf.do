alib work
setActivelib work

setenv BUF_INTF "D:\Telops\FIR-00251-Proc\src\Buffering\HDL"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv PROC "D:\Telops\FIR-00251-Proc"

# Package
acom "D:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd"
acom "D:\Telops\FIR-00251-Common\VHDL\Calibration\calib_define.vhd"

#common_hdl
acom \
 "$COMMON_HDL\Utilities\SYNC_RESET.vhd" \
 "$COMMON_HDL\Utilities\double_sync.vhd" \
 "$COMMON_HDL\Utilities\double_sync_vector.vhd" \
 "$COMMON_HDL\Utilities\Pulse_gen.vhd" \
 "$COMMON_HDL\Utilities\sync_resetn.vhd" \
 "$COMMON_HDL\Utilities\sync_pulse.vhd"

#fir-00251-common
acom \
 "$COMMON\VHDL\Utilities\axis64_fanout2.vhd" \
 "$COMMON\VHDL\Utilities\axis64_reg.vhd" \
 "$COMMON\VHDL\Utilities\axis64_img_boundaries.vhd" \
 "$COMMON\VHDL\Utilities\axis64_sw_1_2.vhd" \
 "$COMMON\VHDL\Utilities\axis64_sw_2_1.vhd" \
 "$COMMON\VHDL\Utilities\axis64_hole_sync.vhd" \
 "$COMMON\VHDL\Utilities\axis64_tid_gen.vhd" \
 "$COMMON\VHDL\fifo\t_axi4_stream64_fifo.vhd" \
 "$COMMON\VHDL\Utilities\axil32_to_native96.vhd" \
 "$COMMON\VHDL\Utilities\shift_registers_x.vhd" \
 "$COMMON\VHDL\axis64_pixel_cnt.vhd" \
 "$COMMON\VHDL\Buffering\BufferingDefine.vhd" \
 "$COMMON\VHDL\Buffering\buffering_fsm.vhd" \
 "$COMMON\VHDL\Buffering\axis64_img_sof.vhd" \
 "$COMMON\VHDL\Utilities\axis16_merge_axis64.vhd"
acom -relax "$COMMON\VHDL\Buffering\buffering_Ctrl.vhd"
acom -relax "$COMMON\VHDL\hdr_extractor\axis64_hder_extractor.vhd"	 

#source Buffering
acom "$BUF_INTF\moi_source_selector.vhd" 
acom "$BUF_INTF\moi_flag_gen.vhd" 
acom "$BUF_INTF\moi_handler.bde" 

#Top
acom "$COMMON\VHDL\Buffering\buffering.bde"
acom "$BUF_INTF\buffering_wrapper.bde"

