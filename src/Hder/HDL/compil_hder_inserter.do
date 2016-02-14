#savealltabs
#SetActiveLib -work
#clearlibrary 	

#Packages
acom -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\FIR-00251-Common\VHDL\Utilities\dbus_reorder.vhd 

#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

# sources
acom -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\Hder\HDL\hder_define.vhd \
 D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_lite32_fifo.vhd \
 D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream32_fifo.vhd \
 d:\Telops\FIR-00251-Proc\src\Hder\HDL\hder_reorder.vhd \
 d:\Telops\FIR-00251-Proc\src\Hder\HDL\hder_insert_sequencer.vhd \
 d:\Telops\FIR-00251-Proc\src\Hder\HDL\hder_insert_mb_intf.vhd \
 d:\Telops\FIR-00251-Proc\src\Hder\HDL\hder_inserter.bde



