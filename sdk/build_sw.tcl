
#get root directory relative to this file
set current_file_location_absolute_path [file normalize [file dirname [info script]]]
source $current_file_location_absolute_path/sdk_proc_cmd.tcl

#Parse arguments
if {$argc < 2} {return -code error "At least 2 arguments are expected"}
set detector [lindex $argv 0]
set size [lindex $argv 1]
if {$argc >= 3} {set create_project [lindex $argv 2]} else {set create_project 1}
if {$argc >= 4} {set compile_arg [lindex $argv 3]} else {set compile_arg "both"}

#Create project
if {$create_project == 1} {
   create_proc_sw $detector $size
}


#Build project
build_proc_sw $detector $size $compile_arg
