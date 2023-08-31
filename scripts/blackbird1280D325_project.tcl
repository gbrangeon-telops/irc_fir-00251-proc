#Set global variable
set root_dir "d:/Telops/fir-00251-Proc"
set sensor "blackbird1280D"
set FPGA_SIZE "325"
set core_name "core"
set proj_name "fir_00251_proc_${FPGA_SIZE}_${sensor}"
set top_lvl "fir_00251_proc_${sensor}"
set FPA_path $root_dir/src/FPA/${sensor}
set proj_dir $root_dir/xilinx/${sensor}
set script_dir $root_dir/scripts
set aldec_dir $root_dir/aldec/compile
set common251_dir "d:/Telops/fir-00251-Common/VHDL"

# Create project
create_project $proj_name $proj_dir

# Set project properties
set obj [get_projects $proj_name]
if {$FPGA_SIZE=="325"} {set_property "part" "xc7k325tfbg676-1" $obj} else {set_property "part" "xc7k160tfbg676-1" $obj}
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "VHDL" $obj

# Add FPA Files
add_files [concat \
   [glob -nocomplain $FPA_path/HDL/*.vhd] \
   [glob -nocomplain $root_dir/src/FPA/scd_proxy/HDL/*.vhd] \
   [glob -nocomplain $common251_dir/iserdes/clink/*.vhd] \
   [glob -nocomplain $common251_dir/iserdes/*.vhd] \
]

# Add Specific IP file

# Add Fir-00251-Proc project file
source $script_dir/Base_project.tcl

#Set top level design
set_property top $top_lvl [current_fileset]
update_compile_order -fileset sources_1

# Cleanup of unused sources
remove_files [get_files -filter {IS_AUTO_DISABLED}]

# Cleanup of leftover unused IPs that cause critical warnings during implementation
synth_design -rtl -name rtl_1
set iplist [get_ips -filter {NAME =~ "*serdes*mmcm" || NAME =~ "*fifo*"}]
foreach ip $iplist {
	set name [get_property NAME $ip]
	set cells [get_cells -hierarchical -filter "REF_NAME == $name"]
	if {[llength $cells] == 0} {
		set file [get_property IP_FILE $ip]
		remove_files $file
	}
}
close_design
