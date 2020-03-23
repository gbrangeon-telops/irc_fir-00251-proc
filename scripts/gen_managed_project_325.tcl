set proj_name "managed_ip_project"
set root_dir "D:/Telops/FIR-00251-Proc"
set FPGA_SIZE "325"
set script_dir $root_dir/scripts
set ip_dir $root_dir/IP/$FPGA_SIZE

# Create project
create_project $proj_name $ip_dir/$proj_name -ip

# Set project properties
set obj [get_projects $proj_name]
if {$FPGA_SIZE=="325"} {set_property "part" "xc7k325tfbg676-1" $obj} else {set_property "part" "xc7k160tfbg676-1" $obj}
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "VHDL" $obj


# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets sources_1] ""]} {
  create_fileset -srcset sources_1
}

#Add ip Repo
set_property  ip_repo_paths  "$ip_dir/AEC/histogram_axis_tmi_4pix_v1_0 $ip_dir/FlashReset" [current_project]
update_ip_catalog

# Add IP sources
set ipfilelist {}
foreach subdir [glob -nocomplain -type d $ip_dir/*] {
   if {[glob -nocomplain $subdir/*.xci] != {}} {lappend ipfilelist [glob $subdir/*.xci]}
}
add_files $ipfilelist

#Create Block design
source $script_dir/gen_bd_core_${FPGA_SIZE}.tcl
validate_bd_design
save_bd_design

#Create the BD wrapper
make_wrapper -files [get_files $ip_dir/managed_ip_project/managed_ip_project.srcs/sources_1/bd/core/core.bd] -top

#extract BD clock
source $script_dir/tel_xparam_extract.tcl

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]

puts "INFO: Project created:$proj_name"


