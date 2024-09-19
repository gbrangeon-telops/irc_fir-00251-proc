adel -all
alib work
setactivelib work

#Packages
acom "$FIR251COMMON/VHDL/tel2000pkg.vhd"
acom "$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd"
acom "$FIR251PROC/src/FPA/PelicanD/HDL/FPA_define.vhd"
acom "$FIR251PROC/src/FPA/scd_proxy/HDL/proxy_define.vhd"
acom "$FIR251COMMON/VHDL/iserdes/clink/fpa_serdes_define.vhd"

#Utilities
acom "$COMMON_HDL/Utilities/sync_reset.vhd"
acom "$COMMON_HDL/Utilities/double_sync.vhd"
acom "$COMMON_HDL/Utilities/double_sync_vector.vhd"

#Clink
acom "$FIR251COMMON/VHDL/iserdes/clink/clink_pattern_validator.vhd"		  

#Simulation
acom "$FIR251PROC/src/clink/Sim/src/clink_tb_stim.vhd"
acom "$FIR251PROC/src/clink/Sim/src/tb_clink_top.bde"


