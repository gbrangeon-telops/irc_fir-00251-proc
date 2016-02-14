
set proj_name "clink_ch_tb"
set root_dir "d:/Telops/fir-00251-Proc/src/clink/Sim"
set proj_dir $root_dir/
set ip_dir $root_dir/../../../IP
set src_dir $root_dir/
set aldec_dir $root_dir/../../../aldec/compile

# Create project
create_project $proj_name $proj_dir

# Set project properties
set obj [get_projects $proj_name]
set_property "part" "xc7k70tfbg676-1" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "VHDL" $obj

# Add sources
add_files $src_dir

# Add IP sources
read_ip $ip_dir/clink_ch/clink_ch.xci

# Add aldec compile sources
add_files $aldec_dir/serdes_top_3ch.vhd

#Update the ip catalog
update_ip_catalog

#Set top level design
set_property top Clink_ch_tb [current_fileset]
set_property top Clink_ch_tb [get_filesets sim_1]

puts "INFO: Project created:clink_ch_example"

#run simulation
set_property runtime 1000us [get_filesets sim_1]
launch_xsim -simset sim_1 -mode behavioral
