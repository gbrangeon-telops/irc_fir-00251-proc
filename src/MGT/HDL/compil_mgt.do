

setenv COMMON "D:\Telops\FIR-00251-Common"	 

#packages
acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd  
 
# Compile Common Section
do "$COMMON\compile_all_common.do"
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

acom -nowarn DAGGEN_0523 \
 D:\Telops\FIR-00251-Proc\src\MGT\Hdl\mgt_stream_merger.vhd \
 D:\Telops\FIR-00251-Proc\src\MGT\Hdl\mgt_block.bde \
 D:\Telops\FIR-00251-Proc\src\MGT\Hdl\mgt_wrapper.bde


