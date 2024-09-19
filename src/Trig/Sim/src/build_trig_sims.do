alib work
setactivelib work

setenv TRIG "$FIR251PROC/src/Trig"


#IP

#Common
do "$FIR251COMMON/compile_all_common.do"
acom "$COMMON_HDL/Utilities/sync_resetn.vhd"
acom "$COMMON_HDL/Utilities/sync_reset.vhd"
acom "$COMMON_HDL/Utilities/double_sync.vhd"
acom "$COMMON_HDL/Utilities/double_sync_vector.vhd"
acom "$COMMON_HDL/gh_vhdl_lib/custom_MSI/gh_stretch.vhd"
acom "$COMMON_HDL/gh_vhdl_lib/custom_MSI/gh_edge_det.vhd"

#Calibration
do "$TRIG/HDL/compil_trig_gen.do"

#Simulation
acom "$TRIG/Sim/src/trig_tb_stim.vhd"
acom "$TRIG/Sim/src/tb_trig_top.bde"


