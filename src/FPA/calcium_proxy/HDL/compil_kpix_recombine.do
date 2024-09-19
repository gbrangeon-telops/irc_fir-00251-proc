#savealltabs
#setactivelib work
#clearlibrary 	


#__BEGIN BUILD KPIX

acom -d $FIR251PROC/src/FPA/calcium_proxy/Sim/kpix -incr -nowarn DAGGEN_0523 \
 $FIR251COMMON/VHDL/tel2000pkg.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd \
 $FIR251PROC/src/FPA/calcium640D/HDL/FPA_define.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/proxy_define.vhd \
 $COMMON_HDL/Utilities/sync_reset.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/kpix_pixelbldr.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/kpix_dlypipeline.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/kpix_bramaddr.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/kpix_bramwrapper.vhd \
 -2008 $FIR251PROC/src/FPA/calcium_proxy/HDL/kpix_bramctrl.vhd \
 $FIR251PROC/src/FPA/calcium_proxy/HDL/kpix_recombine.bde

#__END BUILD KPIX