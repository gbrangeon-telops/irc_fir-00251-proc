alib work
setactivelib work

setenv BUF_INTF_SIM "$FIR251PROC/src/Buffering/Sims/"
setenv PROC "$FIR251PROC"
												 
setenv BUF_INTF "$FIR251PROC/src/Buffering/Sims"  

# Package
acom  "$FIR251COMMON/VHDL/tel2000pkg.vhd"

#common_hdl
acom "$COMMON_HDL/Utilities/SYNC_RESET.vhd"
acom "$COMMON_HDL/Utilities/double_sync.vhd"
acom "$COMMON_HDL/Utilities/double_sync_vector.vhd"
acom "$COMMON_HDL/Utilities/sync_resetn.vhd"	 
												 
#fir-00251-common
acom "$PROC/IP/ip_axis32_fanout2/ip_axis32_fanout2_funcsim.vhdl"
acom "$FIR251COMMON/VHDL/Utilities/axis32_fanout2.vhd"
acom "$FIR251COMMON/VHDL/Utilities/axis32_sw_1_2.vhd"
acom "$FIR251COMMON/VHDL/Utilities/axis32_sw_2_1.vhd"
acom "$FIR251COMMON/VHDL/Utilities/axis16_sw_1_2.vhd"
acom "$FIR251COMMON/VHDL/Utilities/axis16_sw_2_1.vhd"
acom "$FIR251COMMON/VHDL/Utilities/axis32_hole.vhd"
acom "$FIR251COMMON/VHDL/Utilities/axis32_reg.vhd"
acom "$FIR251COMMON/VHDL/Utilities/axis32_hole_sync.vhd"
acom "$FIR251COMMON/VHDL/Utilities/axis32_RandomMiso.vhd"
acom "$FIR251COMMON/VHDL/Utilities/axis32_delay.vhd" 
acom "$FIR251COMMON/VHDL/Utilities/axis32_img_boundaries.vhd"  
acom "$FIR251COMMON/VHDL/Utilities/axis32_stub.vhd"  

#simulation src
-- acom "$BUF_INTF_SIM/src/sync_switch_tb_stim.vhd"
acom "$COMMON_HDL/matlab/axis_file_input_16.vhd"
acom "$COMMON_HDL/matlab/axis_file_input_32.vhd"
acom "$COMMON_HDL/matlab/axis_file_output_32.vhd"

acom "$BUF_INTF_SIM/src/Sim Src/sync_switch_stim.vhd"	
acom "$BUF_INTF_SIM/src/sync_switch_top.bde"	 
