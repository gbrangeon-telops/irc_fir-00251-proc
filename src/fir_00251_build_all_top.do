adel -all
alib work
SetActiveLib -work

setenv FIR251PROC "D:\Telops\FIR-00251-PROC"
setenv COMMON "D:\Telops\FIR-00251-Common"

#__BEGIN BUILD ALL PROC

#Individual builds
#-----------------
#do  "$FIR251PROC\src\fir_00251_top_blackbird1280D_build.do"
#do  "$FIR251PROC\src\fir_00251_top_blackbird1520D_build.do"
#do  "$FIR251PROC\src\fir_00251_top_blackbird1920D_build.do"
#do  "$FIR251PROC\src\fir_00251_top_hawkA_build.do"
#do  "$FIR251PROC\src\fir_00251_top_herculesD_build.do"
#do  "$FIR251PROC\src\fir_00251_top_isc0207A_build.do"
#do  "$FIR251PROC\src\fir_00251_top_isc0207A_3k_build.do"
#do  "$FIR251PROC\src\fir_00251_top_isc0209A_build.do"
#do  "$FIR251PROC\src\fir_00251_top_isc0804A_build.do"
#do  "$FIR251PROC\src\fir_00251_top_isc0804A_500Hz_build.do"
#do  "$FIR251PROC\src\fir_00251_top_marsD_build.do"
#do  "$FIR251PROC\src\fir_00251_top_pelicanD_build.do"
#do  "$FIR251PROC\src\fir_00251_top_scorpiolwD_230Hz_build.do"
#do  "$FIR251PROC\src\fir_00251_top_scorpiolwD_build.do"
#do  "$FIR251PROC\src\fir_00251_top_scorpiomwA_build.do"
#do  "$FIR251PROC\src\fir_00251_top_scorpiomwD_build.do"
#do  "$FIR251PROC\src\fir_00251_top_startup_build.do"
#do  "$FIR251PROC\src\fir_00251_top_suphawkA_build.do"
#do  "$FIR251PROC\src\fir_00251_top_xro3503A_build.do"

#Collective builds (non-recursive)
#---------------------------------
#Acquisition
do  "$FIR251PROC\src\fir_00251_proc_acq_build.do"

#CLINK receivers
do  "$FIR251PROC\src\clink\HDL\compil_clink_receiver.do"
do  "$FIR251PROC\src\bb1920_serdes\HDL\compil_bb1920_receiver.do"

#ADC receiver interface
do  "$FIR251PROC\src\quad_serdes\HDL\build_quad_receiver.do"

#FPA blackbird1280D
do "$FIR251PROC\src\FPA\blackbird1280D\hdl\compil_blackbird1280D.do"
acom  "$FIR251PROC\src\fir_00251_proc_blackbird1280D.bde"
#FPA blackbird1520D
do "$FIR251PROC\src\FPA\blackbird1520D\hdl\compil_blackbird1520D.do"
acom  "$FIR251PROC\src\fir_00251_proc_blackbird1520D.bde"
#FPA blackbird1920D
do "$FIR251PROC\src\FPA\blackbird1920D\hdl\compil_blackbird1920D.do"
acom  "$FIR251PROC\src\fir_00251_proc_blackbird1920D.bde"
#FPA hawkA
do "$FIR251PROC\src\FPA\hawkA\HDL\compil_hawkA.do"
acom  "$FIR251PROC\src\fir_00251_proc_hawkA.bde"
#FPA herculesD
do "$FIR251PROC\src\FPA\herculesD\hdl\compil_HerculesD.do"
acom  "$FIR251PROC\src\fir_00251_proc_herculesD.bde"
#FPA isc0207A
do "$FIR251PROC\src\FPA\isc0207A\HDL\compil_isc0207A.do"
acom  "$FIR251PROC\src\fir_00251_proc_isc0207A.bde"
#startup
acom  "$FIR251PROC\src\fir_00251_proc_startup_160.bde"
acom  "$FIR251PROC\src\fir_00251_proc_startup_325.bde"
#FPA isc0207A_3k
do  "$FIR251PROC\src\FPA\isc0207A_3k\HDL\compil_isc0207A_3k.do"
acom  "$FIR251PROC\src\fir_00251_proc_isc0207A_3k.bde"
#FPA isc0209A
do "$FIR251PROC\src\FPA\isc0209A\HDL\compil_isc0209A.do"
acom  "$FIR251PROC\src\fir_00251_proc_isc0209A.bde"
#FPA isc0804A
do  "$FIR251PROC\src\FPA\isc0804A\HDL\compil_isc0804A.do"
acom  "$FIR251PROC\src\fir_00251_proc_isc0804A.bde"
#FPA isc0804A_500Hz
do  "$FIR251PROC\src\FPA\isc0804A_500Hz\HDL\compil_isc0804A_500Hz.do"
acom  "$FIR251PROC\src\fir_00251_proc_isc0804A_500Hz.bde"
#FPA marsD
do "$FIR251PROC\src\FPA\marsD\HDL\compil_marsD.do"
acom  "$FIR251PROC\src\fir_00251_proc_marsD.bde"
#FPA pelicanD
do "$FIR251PROC\src\FPA\PelicanD\hdl\compil_pelicanD.do"
acom  "$FIR251PROC\src\fir_00251_proc_pelicanD.bde"
#FPA scorpiolwD
do "$FIR251PROC\src\FPA\scorpiolwD\HDL\compil_scorpiolwD.do"
acom  "$FIR251PROC\src\fir_00251_proc_scorpiolwD.bde"
#FPA scorpiolwD_230Hz
do "$FIR251PROC\src\FPA\scorpiolwD_230Hz\HDL\compil_scorpiolwD_230Hz.do"
acom  "$FIR251PROC\src\fir_00251_proc_scorpiolwD_230Hz.bde"
#FPA scorpiomwA
do "$FIR251PROC\src\FPA\scorpiomwA\HDL\compil_scorpiomwA.do"
acom  "$FIR251PROC\src\fir_00251_proc_scorpiomwA.bde"
#FPA scorpiomwA_300Hz
do "$FIR251PROC\src\FPA\scorpiomwA_300Hz\HDL\compil_scorpiomwA_300Hz.do"
acom  "$FIR251PROC\src\fir_00251_proc_scorpiomwA_300Hz.bde"
#FPA scorpiomwD
do "$FIR251PROC\src\FPA\scorpiomwD\HDL\compil_scorpiomwD.do"
acom  "$FIR251PROC\src\fir_00251_proc_scorpiomwD.bde"
#FPA suphawkA
do "$FIR251PROC\src\FPA\suphawkA\HDL\compil_suphawkA.do"
acom  "$FIR251PROC\src\fir_00251_proc_suphawkA.bde"
#FPA xro3503A
do "$FIR251PROC\src\FPA\xro3503A\HDL\compil_xro3503A.do"
acom  "$FIR251PROC\src\fir_00251_proc_xro3503A.bde"

#__END BUILD ALL PROC