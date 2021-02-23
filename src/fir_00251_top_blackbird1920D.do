adel -all
alib work
SetActiveLib -work

setenv FIR251PROC "D:\Telops\FIR-00251-PROC"
setenv COMMON "D:\Telops\FIR-00251-Common"

#Acquisition
do  "$FIR251PROC\src\fir_00251_proc_acq_build.do"

#FPA
do  "$FIR251PROC\src\FPA\blackbird1920D\HDL\compil_blackbird1920D.do"

#serdes
do  "$FIR251PROC\src\bb1920_serdes\HDL\compil_bb1920_receiver.do"

#TOP_LEVEL
acom  "$FIR251PROC\src\fir_00251_proc_blackbird1920D.bde"