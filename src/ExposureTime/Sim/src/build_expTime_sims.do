alib work
setActivelib work

setenv PROC "D:\Telops\FIR-00251-Proc"
setenv EXPTIME "$PROC\src\ExposureTime"
setenv EHDRI "$PROC\src\eHDRI"
setenv TRIG "$PROC\src\Trig"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"

#IP
acom "$PROC\IP\ehdri_index_mem\ehdri_index_mem_funcsim.vhdl"

#Common
do "$COMMON\compile_all_common.do"
acom "$COMMON\VHDL\Utilities\shift_registers_x.vhd"
acom "$COMMON_HDL\Utilities\sync_resetn.vhd"
acom "$COMMON_HDL\Utilities\sync_reset.vhd"
acom "$COMMON_HDL\Utilities\double_sync.vhd"
acom "$COMMON_HDL\Utilities\double_sync_vector.vhd"
acom "$COMMON_HDL\gh_vhdl_lib\custom_MSI\gh_stretch.vhd"
acom "$COMMON_HDL\gh_vhdl_lib\custom_MSI\gh_edge_det.vhd"

#ExposureTime
do "$EXPTIME\HDL\compil_exposure_time.do"

#eHDRI
do "$EHDRI\HDL\build_ehdri_intf.do"

#Trig
do "$TRIG\HDL\compil_trig_gen.do"

#Simulation
acom "$EXPTIME\Sim\src\expTime_tb_stim.vhd"
acom "$EXPTIME\Sim\src\tb_expTime_top.bde"


