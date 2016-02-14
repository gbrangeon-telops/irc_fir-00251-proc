alib work
setActivelib work

setenv BUF_INTF_SIM "D:\telops\FIR-00251-Proc\src\Buffering\Sims\"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv PROC "D:\Telops\FIR-00251-Proc"
												 
setenv BUF_INTF "D:\telops\FIR-00251-Proc\src\Buffering\Sims"  

# Package
acom  "D:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd"

#common_hdl
acom "$COMMON_HDL\Utilities\SYNC_RESET.vhd"
acom "$COMMON_HDL\Utilities\double_sync.vhd"
acom "$COMMON_HDL\Utilities\double_sync_vector.vhd"
acom "$COMMON_HDL\Utilities\sync_resetn.vhd"	 
												 
#fir-00251-common
acom "$PROC\IP\ip_axis32_fanout2\ip_axis32_fanout2_funcsim.vhdl"
acom "$COMMON\VHDL\Utilities\axis32_fanout2.vhd"
acom "$COMMON\VHDL\Utilities\axis32_sw_1_2.vhd"
acom "$COMMON\VHDL\Utilities\axis32_sw_2_1.vhd"
acom "$COMMON\VHDL\Utilities\axis16_sw_1_2.vhd"
acom "$COMMON\VHDL\Utilities\axis16_sw_2_1.vhd"
acom "$COMMON\VHDL\Utilities\axis32_hole.vhd"
acom "$COMMON\VHDL\Utilities\axis32_reg.vhd"
acom "$COMMON\VHDL\Utilities\axis32_hole_sync.vhd"
acom "$COMMON\VHDL\Utilities\axis32_RandomMiso.vhd"
acom "$COMMON\VHDL\Utilities\axis32_delay.vhd" 
acom "$COMMON\VHDL\Utilities\axis32_img_boundaries.vhd"  
acom "$COMMON\VHDL\Utilities\axis32_stub.vhd"  

#simulation src
--acom "$BUF_INTF_SIM\src\sync_switch_tb_stim.vhd"
acom "$COMMON_HDL\matlab\axis_file_input_16.vhd"
acom "$COMMON_HDL\matlab\axis_file_input_32.vhd"
acom "$COMMON_HDL\matlab\axis_file_output_32.vhd"

acom "$BUF_INTF_SIM\src\Sim Src\sync_switch_stim.vhd"	
acom "$BUF_INTF_SIM\src\sync_switch_top.bde"	 
