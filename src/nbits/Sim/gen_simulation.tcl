cd [file dirname [file normalize [info script]]]/..
set root_dir [pwd]
set proj_name [file tail $root_dir]
set proj_dir $root_dir/Sim

set fd [open $proj_dir/work.epr]
set proj_srcs [split [read $fd] "\n"]
close $fd

set proj_srcs [lsearch -all -inline $proj_srcs *.vhd*]
set i 0
foreach line $proj_srcs {
	lset proj_srcs $i [string range $line 0 [string first \" $line 1]]
	incr i
}
set proj_srcs [string map {\\ /} [join $proj_srcs]]

# Create project
create_project $proj_name $proj_dir

# Set project properties
set obj [get_projects $proj_name]
set_property "part" "xc7k70tfbg676-1" $obj
set_property "simulator_language" "VHDL" $obj
set_property "target_language" "VHDL" $obj

# Add sources
add_files $proj_srcs

# Add simulation sources
add_files $proj_dir/HDL

# Use VHDL 2008
set_property file_type {VHDL 2008} [get_files -filter {FILE_TYPE == VHDL}]

# Set top level design
set_property top [lindex [find_top -fileset [current_fileset]] 0] [current_fileset]
set_property top [lindex [find_top -fileset [get_filesets sim_1]] 0] [get_filesets sim_1]

# Set simulation runtime
set_property runtime 1000us [get_filesets sim_1]
