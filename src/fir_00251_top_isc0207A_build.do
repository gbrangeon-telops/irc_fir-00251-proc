adel -all
alib work
SetActiveLib -work

setenv FIR251PROC "D:\Telops\FIR-00251-PROC"
setenv COMMON "D:\Telops\FIR-00251-Common"
    
do  "$FIR251PROC\src\fir_00251_proc_acq_build.do"

#FPA isc0207A
do D:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\compil_isc0207A.do

#ADC receiver interface
do D:\telops\FIR-00251-Proc\src\QuadADC\HDL\build_adc_receiver.do

#TOP_LEVEL
acom  "$FIR251PROC\src\fir_00251_proc_isc0207A.bde"