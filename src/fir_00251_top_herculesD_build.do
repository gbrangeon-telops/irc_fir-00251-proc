adel -all
alib work
SetActiveLib -work

setenv FIR251PROC "D:\Telops\FIR-00251-PROC"
setenv COMMON "D:\Telops\FIR-00251-Common"
    
do  "$FIR251PROC\src\fir_00251_proc_acq_build.do"

#CLINK receivers
do D:\Telops\FIR-00251-Proc\src\clink\HDL\compil_clink_receiver.do

#FPA herculesD
do D:\Telops\FIR-00251-Proc\src\FPA\herculesD\hdl\compil_HerculesD.do

#TOP_LEVEL
acom  "$FIR251PROC\src\fir_00251_proc_herculesD.bde"