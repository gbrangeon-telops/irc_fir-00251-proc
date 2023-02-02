alib work
setActivelib work

setenv COMMON "D:\Telops\FIR-00251-Common"
setenv PROC   "D:\Telops\FIR-00251-Proc"
setenv UTILITIES "D:\Telops\Common_HDL\Utilities"

# Package
acom "$COMMON\VHDL\tel2000pkg.vhd"	 
acom "$PROC\src\FrameBuffer\HDL\fbuffer_define.vhd"

#common_hdl
do "D:\Telops\FIR-00251-Proc\src\compil_utilities.do"
acom "D:\Telops\Common_HDL\gh_vhdl_lib\custom_MSI\gh_stretch.vhd"

#source 	  
acom -nowarn DAGGEN_0523 -incr \
"D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream_wr128_rd64_fifo.vhd" \
"D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream_wr128_rd128_fifo.vhd" \
"D:\Telops\FIR-00251-Common\VHDL\axis128_frame_rate.vhd" \
"D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream64_fifo.vhd" \
"D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\fb_ctrl_intf.vhd" \
"D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\reader_fsm.vhd" \
"D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\writer_fsm.vhd"	   


#Top
acom "D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\FrameBuffer.bde"
											  
