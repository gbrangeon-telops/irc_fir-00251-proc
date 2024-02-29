cd [file dirname [file normalize [info script]]]/..
set sth_file [pwd]/aldec/compile/sources.sth

if {[file exists $sth_file] != 1} {
	return -code error "Top design not set within the Active-HDL workspace"
}
set fd [open $sth_file]
set sth_content [read $fd]
close $fd

regsub -all {\\} $sth_content {/} sth_content
regsub -all {=[^\n]*} $sth_content {} sth_content
set sth_content [string range $sth_content 1 end]
set sth_content [split $sth_content \[\]]

if {[dict exists $sth_content "Files List"] != 1} {
	return -code error "Files list not present within the sth file"
}
set proj_srcs [dict get $sth_content "Files List"]

set proj_srcs [lsearch -all -inline -nocase $proj_srcs */Telops/*]
set proj_top [lindex $proj_srcs end]
set proj_dir [file rootname $proj_top]
set proj_name [file tail $proj_dir]
set proj_srcs [join $proj_srcs]

# Create project
create_project $proj_name $proj_dir

# Set project properties
set obj [get_projects $proj_name]
set_property "part" "xc7k70tfbg676-1" $obj
set_property "simulator_language" "VHDL" $obj
set_property "target_language" "VHDL" $obj

# Add sources
add_files $proj_srcs

# Use VHDL 2008
set_property file_type {VHDL 2008} [get_files -filter {FILE_TYPE == VHDL}]

# Set top level design
set_property top [lindex [find_top -fileset [current_fileset]] 0] [current_fileset]
set_property top [lindex [find_top -fileset [get_filesets sim_1]] 0] [get_filesets sim_1]

# Set simulation runtime
set_property runtime 1000us [get_filesets sim_1]
