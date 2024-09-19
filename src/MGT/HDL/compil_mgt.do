
#packages
acom "$FIR251COMMON/VHDL/tel2000pkg.vhd"
 
# Compile Common Section
do "$FIR251COMMON/compile_all_common.do"
do "$FIR251PROC/src/compil_utilities.do"

acom -nowarn DAGGEN_0523 \
 "$FIR251PROC/src/MGT/Hdl/mgt_stream_merger.vhd" \
 "$FIR251PROC/src/MGT/Hdl/mgt_block.bde" \
 "$FIR251PROC/src/MGT/Hdl/mgt_wrapper.bde"


