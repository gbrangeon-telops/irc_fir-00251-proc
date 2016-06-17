#savealltabs
#SetActiveLib -work
#clearlibrary 	

#packages
acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\scorpiolwD\HDL\FPA_define.vhd
acom d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd
acom d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\fpa_serdes_define.vhd

#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

#uarts
--acom d:\Telops\Common_HDL\telops.vhd 
--acom d:\Telops\Common_HDL\Utilities\telops_testing.vhd
acom d:\Telops\Common_HDL\RS232\uarts.vhd

do D:\Telops\FIR-00251-Proc\src\FPA\megalink\HDL\compil_megalink.do


