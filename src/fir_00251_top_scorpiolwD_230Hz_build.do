adel -all
alib work
setactivelib work

#get root directory relative to this file
set current_file_location_absolute_path [file normalize [file dirname [info script]]]
set parts [file split $current_file_location_absolute_path]
setenv root_location_absolute_path [file join {*}[lrange $parts 0 end-2]]

setenv FIR251PROC "$root_location_absolute_path/irc_fir-00251-proc/"
setenv FIR251COMMON "$root_location_absolute_path/irc_fir-00251-common/"

#Acquisition
do  "$FIR251PROC/src/fir_00251_proc_acq_build.do"

#CLINK receivers
do  "$FIR251PROC/src/clink/HDL/compil_clink_receiver.do"

#FPA
do  "$FIR251PROC/src/FPA/scorpiolwD_230Hz/HDL/compil_scorpiolwD_230Hz.do"

#TOP_LEVEL
acom  "$FIR251PROC/src/fir_00251_proc_scorpiolwD_230Hz.bde"