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

#FPA
do  "$FIR251PROC/src/FPA/isc0207A_3k/HDL/compil_isc0207A_3k.do"

#ADC receiver interface
do  "$FIR251PROC/src/quad_serdes/HDL/build_quad_receiver.do"

#TOP_LEVEL
acom  "$FIR251PROC/src/fir_00251_proc_isc0207A_3k.bde"