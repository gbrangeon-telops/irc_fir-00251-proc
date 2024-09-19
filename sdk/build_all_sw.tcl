set current_file_location_absolute_path [file normalize [file dirname [info script]]]
puts "current_file_location_absolute_path=$current_file_location_absolute_path"
source "$current_file_location_absolute_path/sdk_proc_cmd.tcl"


create_proc_sw blackbird1280D
build_proc_sw blackbird1280D 325

create_proc_sw blackbird1520D
build_proc_sw blackbird1520D 325

create_proc_sw blackbird1920D
build_proc_sw blackbird1920D 325

# create_proc_sw calcium640D
# build_proc_sw calcium640D 325

create_proc_sw hawkA
build_proc_sw hawkA 160

create_proc_sw herculesD
build_proc_sw herculesD 160

create_proc_sw isc0207A
build_proc_sw isc0207A 160

create_proc_sw isc0207A_3k
build_proc_sw isc0207A_3k 325

create_proc_sw isc0209A
build_proc_sw isc0209A 160

create_proc_sw isc0804A
build_proc_sw isc0804A 325

create_proc_sw isc0804A_500Hz
build_proc_sw isc0804A_500Hz 325

create_proc_sw isc0804A_2k
build_proc_sw isc0804A_2k 325

create_proc_sw pelicanD
build_proc_sw pelicanD 160

create_proc_sw scorpiolwD_230Hz
build_proc_sw scorpiolwD_230Hz 160

create_proc_sw scorpiomwA
build_proc_sw scorpiomwA 160

create_proc_sw scorpiomwA_300Hz
build_proc_sw scorpiomwA_300Hz 160

create_proc_sw startup
build_proc_sw startup 160
build_proc_sw startup 325

create_proc_sw startup_4DDR 325
build_proc_sw startup_4DDR 325

create_proc_sw suphawkA
build_proc_sw suphawkA 325

create_proc_sw xro3503A
build_proc_sw xro3503A 325
