alib work
setactivelib work

setenv BUF_INTF "$FIR251PROC/src/Buffering/HDL"
setenv PROC "$FIR251PROC"

# Package
acom "$FIR251COMMON/VHDL/tel2000pkg.vhd"
acom "$FIR251COMMON/VHDL/Calibration/calib_define.vhd"

#common_hdl
acom \
 "$COMMON_HDL/Utilities/SYNC_RESET.vhd" \
 "$COMMON_HDL/Utilities/double_sync.vhd" \
 "$COMMON_HDL/Utilities/double_sync_vector.vhd" \
 "$COMMON_HDL/Utilities/Pulse_gen.vhd" \
 "$COMMON_HDL/Utilities/sync_resetn.vhd" \
 "$COMMON_HDL/Utilities/sync_pulse.vhd"

#fir-00251-common
acom \
 "$FIR251COMMON/VHDL/Utilities/axis64_fanout2.vhd" \
 "$FIR251COMMON/VHDL/Utilities/axis64_reg.vhd" \
 "$FIR251COMMON/VHDL/Utilities/axis64_img_boundaries.vhd" \
 "$FIR251COMMON/VHDL/Utilities/axis64_sw_2_1.vhd" \
 "$FIR251COMMON/VHDL/Utilities/axis64_hole_sync.vhd" \
 "$FIR251COMMON/VHDL/Utilities/axis64_tid_gen.vhd" \
 "$FIR251COMMON/VHDL/fifo/t_axi4_stream64_fifo.vhd" \
 "$FIR251COMMON/VHDL/Utilities/axil32_to_native96.vhd" \
 "$FIR251COMMON/VHDL/Utilities/shift_registers_x.vhd" \
 "$FIR251COMMON/VHDL/axis64_pixel_cnt.vhd" \
 "$FIR251COMMON/VHDL/Buffering/BufferingDefine.vhd" \
 "$FIR251COMMON/VHDL/Buffering/buffering_fsm.vhd" \
 "$FIR251COMMON/VHDL/Buffering/axis64_img_sof.vhd" \
 "$FIR251COMMON/VHDL/Utilities/axis16_merge_axis64.vhd"
acom -relax "$FIR251COMMON/VHDL/Buffering/buffering_Ctrl.vhd"
acom -relax "$FIR251COMMON/VHDL/hdr_extractor/axis64_hder_extractor.vhd"	 

#source Buffering
acom "$BUF_INTF/moi_source_selector.vhd" 
acom "$BUF_INTF/moi_flag_gen.vhd" 
acom "$BUF_INTF/moi_handler.bde" 
acom "$FIR251COMMON/VHDL/Buffering/flow_controller.vhd"
#Top
acom "$FIR251COMMON/VHDL/Buffering/buffering.bde"
acom "$BUF_INTF/buffering_wrapper.bde"

