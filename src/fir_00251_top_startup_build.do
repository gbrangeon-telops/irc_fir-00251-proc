adel -all
alib work
SetActiveLib -work

setenv FIR251PROC "D:\Telops\FIR-00251-PROC"
setenv COMMON "D:\Telops\FIR-00251-Common"

#FPA isc0207A
do  "$FIR251PROC\src\fir_00251_top_isc0207A_build.do"

#TOP_LEVEL
acom  "$FIR251PROC\src\fir_00251_proc_startup_160.bde"
acom  "$FIR251PROC\src\fir_00251_proc_startup_325.bde"