#savealltabs
setactivelib work
#clearlibrary 	

#Packages and utilities
acom $FIR251PROC/src/Trig/HDL/trig_define.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd
do $FIR251PROC/src/compil_utilities.do

#signal stat
acom \
 "$FIR251COMMON/VHDL/signal_stat/min_max_define.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/min_max_ctrl.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/delay_measurement.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/trig_delay.bde" \
 "$FIR251COMMON/VHDL/signal_stat/period_duration.vhd" \
 "$FIR251COMMON/VHDL/signal_stat/trig_period.bde" \
 "$FIR251COMMON/VHDL/signal_stat/trig_period_8ch.bde"

#MBlaze config
acom $FIR251PROC/src/Trig/HDL/trig_gen_mblaze_intf.vhd	

#generateur de statut
acom $FIR251PROC/src/Trig/HDL/trig_gen_status.vhd

#generateurs de trigs
acom $FIR251PROC/src/Trig/HDL/trig_conditioner.vhd

# trigger controller
acom $FIR251PROC/src/Trig/HDL/progr_clk_div.vhd 
acom $FIR251PROC/src/Trig/HDL/trig_gen_ctler_core.vhd
acom $FIR251PROC/src/Trig/HDL/trig_gen_ctler.bde  

# stamper et RTC  
acom $FIR251PROC/src/Trig/HDL/edge_detect.vhd
acom $FIR251PROC/src/Trig/HDL/trig_stamper_ctler.vhd
acom $FIR251PROC/src/Trig/HDL/trig_stamper.bde
acom $FIR251PROC/src/Trig/HDL/trig_gen.bde