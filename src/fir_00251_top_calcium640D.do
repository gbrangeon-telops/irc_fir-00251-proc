adel -all
alib work
SetActiveLib -work

setenv FIR251PROC "D:\Telops\FIR-00251-PROC"
setenv COMMON "D:\Telops\FIR-00251-Common"

#Acquisition
do  "$FIR251PROC\src\fir_00251_proc_acq_build.do"

#FPA
do  "$FIR251PROC\src\FPA\calcium640D\HDL\compil_calcium640D.do"

#serdes
do  "$FIR251PROC\src\nbits\HDL\compil_nbits_receiver.do"

#TOP_LEVEL
acom -2008 "$FIR251PROC\src\fir_00251_proc_calcium640D.bde"