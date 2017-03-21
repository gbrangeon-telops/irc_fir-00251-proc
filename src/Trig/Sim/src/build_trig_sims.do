alib work
setActivelib work

setenv TRIG "D:\Telops\FIR-00251-Proc\src\Trig"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"

#IP

#Common
do "$COMMON\compile_all_common.do"
acom "$COMMON_HDL\Utilities\sync_resetn.vhd"
acom "$COMMON_HDL\Utilities\sync_reset.vhd"
acom "$COMMON_HDL\Utilities\double_sync.vhd"
acom "$COMMON_HDL\Utilities\double_sync_vector.vhd"
acom "$COMMON_HDL\gh_vhdl_lib\custom_MSI\gh_stretch.vhd"
acom "$COMMON_HDL\gh_vhdl_lib\custom_MSI\gh_edge_det.vhd"

#Calibration
do "$TRIG\HDL\compil_trig_gen.do"

#Simulation
acom "$TRIG\Sim\src\trig_tb_stim.vhd"
acom "$TRIG\Sim\src\tb_trig_top.bde"


