adel -all
alib work
SetActiveLib -work

setenv FIR251PROC "D:\Telops\FIR-00251-PROC"
setenv COMMON "D:\Telops\FIR-00251-Common"

#Acquisition
do  "$FIR251PROC\src\fir_00251_proc_acq_build.do"

#CLINK receivers
do  "$FIR251PROC\src\clink\HDL\compil_clink_receiver.do"

#FPA
do  "$FIR251PROC\src\FPA\PelicanD_150Hz\hdl\compil_pelicanD_150Hz.do"

#TOP_LEVEL
acom  "$FIR251PROC\src\fir_00251_proc_pelicanD_150Hz.bde"