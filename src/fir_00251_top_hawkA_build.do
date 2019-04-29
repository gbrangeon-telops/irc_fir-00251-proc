adel -all
alib work
SetActiveLib -work

setenv FIR251PROC "D:\Telops\FIR-00251-PROC"
setenv COMMON "D:\Telops\FIR-00251-Common"
    
do  "$FIR251PROC\src\fir_00251_proc_acq_build.do"

#FPA hawkA
do D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\compil_hawkA.do

#ADC receiver interface
do D:\telops\FIR-00251-Proc\src\quad_serdes\HDL\build_quad_receiver.do

#TOP_LEVEL
acom  D:\telops\FIR-00251-Proc\src\fir_00251_proc_hawkA.bde