#savealltabs
#setactivelib work
#clearlibrary 	

#Packages
acom -nowarn DAGGEN_0523 \
 $FIR251COMMON/VHDL/tel2000pkg.vhd \
 $FIR251COMMON/VHDL/Utilities/dbus64_reorder.vhd \
 $FIR251COMMON/VHDL/Utilities/dbus_reorder.vhd 

#utilities
do $FIR251PROC/src/compil_utilities.do

# sources
acom -nowarn DAGGEN_0523 \
 $FIR251PROC/src/Hder/HDL/hder_define.vhd \
 $FIR251COMMON/VHDL/Fifo/t_axi4_lite32_fifo.vhd \
 $FIR251COMMON/VHDL/Fifo/t_axi4_stream128_fifo.vhd \
 $FIR251COMMON/VHDL/Utilities/axis128_auto_sw_2_1.vhd \
 $FIR251PROC/src/Hder/HDL/hder_reorder.vhd \
 $FIR251PROC/src/Hder/HDL/hder_insert_sequencer.vhd \
 $FIR251PROC/src/Hder/HDL/hder_insert_mb_intf.vhd \
 $FIR251PROC/src/Hder/HDL/hder_inserter.bde  


				
