set root_dir "d:/Telops/fir-00251-Proc"
set sensor "startup"
set proj_name "fir_00251_proc_${sensor}"
set FPA_path $root_dir/src/FPA/isc0207A
set proj_dir $root_dir/xilinx/${sensor}
set script_dir $root_dir/scripts
set aldec_dir $root_dir/aldec/compile


# Create project
create_project $proj_name $proj_dir

# Set project properties
set obj [get_projects $proj_name]
set_property "part" "xc7k160tfbg676-1" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "VHDL" $obj

# Add FPA Files
add_files $FPA_path/HDL

# Add top level
add_files $aldec_dir/$proj_name.vhd


# Add Specific IP file

# Add Fir-00251-Proc project file
source $script_dir/Base_project.tcl

#Add specific constraint files
add_files -norecurse -fileset constrs_1 $constr_dir/$sensor

# make sure the files are in correct precedence order (as per UG903 recommendation)
reorder_files -fileset constrs_1 -after [get_files -of_objects constrs_1 -filter {NAME !~ "*specific*"} *timing.xdc] [get_files -of_objects constrs_1 *specific*.xdc]
reorder_files -fileset constrs_1 -after [get_files -of_objects constrs_1 -filter {NAME !~ "*specific*"} *physical.xdc] [get_files -of_objects constrs_1 *specific_physical.xdc]

#Set top level constraint
set_property target_constrs_file [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]

#create the bd wrapper
make_wrapper -files [get_files $proj_dir/$proj_name.srcs/sources_1/bd/core/core.bd] -top
add_files -norecurse $proj_dir/$proj_name.srcs/sources_1/bd/core/hdl/core_wrapper.vhd

#Update the ip catalog
update_ip_catalog

#Set top level design
set_property top $proj_name [current_fileset]

update_compile_order -fileset sources_1

set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
