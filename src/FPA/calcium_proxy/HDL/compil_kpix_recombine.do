#savealltabs
#SetActiveLib -work
#clearlibrary 	


#__BEGIN BUILD KPIX

acom -2008 -d d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\Sim\kpix -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\proxy_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium640D\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\kpix_pixelbldr.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\kpix_dlypipeline.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\kpix_bramaddr.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\kpix_bramwrapper.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\calcium_proxy\HDL\kpix_bramctrl.vhd

#__END BUILD KPIX