alib work
setactivelib work


setenv PROC   "$FIR251PROC"
setenv UTILITIES "$COMMON_HDL/Utilities"

# Package
acom "$FIR251COMMON/VHDL/tel2000pkg.vhd"	 
acom "$PROC/src/FrameBuffer/HDL/fbuffer_define.vhd"

acom "$FIR251COMMON/VHDL/Buffering/BufferingDefine.vhd"

#common_hdl
do "$FIR251PROC/src/compil_utilities.do"
acom "$COMMON_HDL/gh_vhdl_lib/custom_MSI/gh_stretch.vhd"



#source 	  
acom -nowarn DAGGEN_0523 -incr \
"$FIR251COMMON/VHDL/Fifo/t_axi4_stream_wr128_rd64_fifo.vhd" \
"$FIR251COMMON/VHDL/Fifo/t_axi4_stream_wr128_rd128_fifo.vhd" \
"$FIR251COMMON/VHDL/axis128_frame_rate.vhd" \
"$FIR251COMMON/VHDL/axis64_frame_rate.vhd" \
"$FIR251COMMON/VHDL/Fifo/t_axi4_stream64_fifo.vhd" \
"$FIR251PROC/src/FrameBuffer/HDL/fb_ctrl_intf.vhd" \
"$FIR251COMMON/VHDL/Utilities/axis128_img_boundaries.vhd" \
"$FIR251COMMON/VHDL/Utilities/axis128_tid_gen.vhd" \
"$FIR251COMMON/VHDL/Utilities/axis128_hole_sync.vhd" \
"$FIR251COMMON/VHDL/Utilities/axis128_reg.vhd" \
"$FIR251PROC/src/FrameBuffer/HDL/ext_buff_switch.vhd" \
"$FIR251PROC/src/FrameBuffer/HDL/reader_fsm.vhd" \
"$FIR251PROC/src/FrameBuffer/HDL/writer_fsm.vhd"	   


#Top
acom "$FIR251PROC/src/FrameBuffer/HDL/FrameBuffer.bde"
											  
