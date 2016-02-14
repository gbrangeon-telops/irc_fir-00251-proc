#savealltabs
SetActiveLib -work
#clearlibrary 	

#Packages and utilities
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_define.vhd         
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

#MBlaze config
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_gen_mblaze_intf.vhd	

#generateur de statut
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_gen_status.vhd

#generateurs de trigs
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_conditioner.vhd

# trigger controller
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\hightime_measure.vhd
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\progr_clk_div.vhd 
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_gen_ctler_core.vhd
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_gen_ctler.bde  

# stamper et RTC  
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\edge_detect.vhd
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_stamper_ctler.vhd
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_stamper.bde
acom D:\Telops\FIR-00251-Proc\src\Trig\HDL\trig_gen.bde