alib work
setActivelib work

setenv CALIB "D:\Telops\FIR-00251-Proc\src\Calibration"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"

#IP
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w32_d16\fwft_sfifo_w32_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w192_d16\fwft_sfifo_w192_d16_funcsim.vhdl			  

#Common
acom "$COMMON\VHDL\Utilities\axil32_to_native.vhd"
acom "$COMMON_HDL\Utilities\sync_resetn.vhd"
acom "$COMMON_HDL\Utilities\sync_reset.vhd"
acom "$COMMON_HDL\gh_vhdl_lib\custom_MSI\gh_stretch.vhd"
acom "$COMMON_HDL\gh_vhdl_lib\custom_MSI\gh_edge_det.vhd"

#Calibration
do "$CALIB\HDL\compil_calibration.do"

#Simulation
acom "$CALIB\Sim\src\calib_tb_stim.vhd"
acom "$CALIB\Sim\src\tb_calib_top.bde"


