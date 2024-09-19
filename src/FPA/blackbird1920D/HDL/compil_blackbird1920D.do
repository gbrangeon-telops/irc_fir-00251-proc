#savealltabs
#setactivelib work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 \
 $FIR251COMMON/VHDL/tel2000pkg.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd \
 $FIR251PROC/src/FPA/blackbird1920D/HDL/FPA_define.vhd

#scd_proxy
do $FIR251PROC/src/FPA/scd_proxy2/HDL/compil_scd_proxy2.do


