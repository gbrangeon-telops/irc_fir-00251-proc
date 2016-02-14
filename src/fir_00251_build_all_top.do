adel -all
alib work
SetActiveLib -work

setenv FIR251PROC "D:\Telops\FIR-00251-PROC"
setenv COMMON "D:\Telops\FIR-00251-Common"

#__BEGIN BUILD ALL PROC

#Individual builds
#-----------------
#do  "$FIR251PROC\src\fir_00251_top_hawkA_build.do"
#do  "$FIR251PROC\src\fir_00251_top_herculesD_build.do"
#do  "$FIR251PROC\src\fir_00251_top_isc0207A_build.do"
#do  "$FIR251PROC\src\fir_00251_top_isc0209A_build.do"
#do  "$FIR251PROC\src\fir_00251_top_marsD_build.do"
#do  "$FIR251PROC\src\fir_00251_top_pelicanD_build.do"
#do  "$FIR251PROC\src\fir_00251_top_scorpiolwD_230Hz_build.do"
#do  "$FIR251PROC\src\fir_00251_top_scorpiolwD_build.do"
#do  "$FIR251PROC\src\fir_00251_top_scorpiomwD_build.do"

#Collective builds (non-recursive)
#---------------------------------
#Acquisition
do  "$FIR251PROC\src\fir_00251_proc_acq_build.do"

#CLINK receivers
do D:\Telops\FIR-00251-Proc\src\clink\HDL\compil_clink_receiver.do
#ADC receiver interface
do D:\telops\FIR-00251-Proc\src\QuadADC\HDL\build_adc_receiver.do

#FPA hawkA
do D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\compil_hawkA.do
acom  "$FIR251PROC\src\fir_00251_proc_hawkA.bde"
#FPA herculesD
do D:\Telops\FIR-00251-Proc\src\FPA\herculesD\hdl\compil_HerculesD.do
acom  "$FIR251PROC\src\fir_00251_proc_herculesD.bde"
#FPA isc0207A
do D:\Telops\FIR-00251-Proc\src\FPA\isc0207A\HDL\compil_isc0207A.do
acom  "$FIR251PROC\src\fir_00251_proc_isc0207A.bde"
#FPA isc0209A
do D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\compil_isc0209A.do
acom  "$FIR251PROC\src\fir_00251_proc_isc0209A.bde"
#FPA marsD
do D:\Telops\FIR-00251-Proc\src\FPA\marsD\HDL\compil_marsD.do
acom  "$FIR251PROC\src\fir_00251_proc_marsD.bde"
#FPA pelicanD
do D:\Telops\FIR-00251-Proc\src\FPA\PelicanD\hdl\compil_pelicanD.do
acom  "$FIR251PROC\src\fir_00251_proc_pelicanD.bde"
#FPA scorpiolwD
do D:\Telops\FIR-00251-Proc\src\FPA\scorpiolwD\HDL\compil_scorpiolwD.do
acom  "$FIR251PROC\src\fir_00251_proc_scorpiolwD.bde"
#FPA scorpiolwD_230Hz
do D:\Telops\FIR-00251-Proc\src\FPA\scorpiolwD_230Hz\HDL\compil_scorpiolwD_230Hz.do
acom  "$FIR251PROC\src\fir_00251_proc_scorpiolwD_230Hz.bde"
#FPA scorpiomwD
do D:\Telops\FIR-00251-Proc\src\FPA\scorpiomwD\HDL\compil_scorpiomwD.do
acom  "$FIR251PROC\src\fir_00251_proc_scorpiomwD.bde"

#__END BUILD ALL PROC