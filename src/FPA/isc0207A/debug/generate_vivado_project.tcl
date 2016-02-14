set root_dir "d:/Telops/fir-00251-Proc"
set script_dir $root_dir/scripts
set src_dir $root_dir/src
set aldec_dir $src_dir/aldec/compile
set constr_dir $src_dir/FPA/isc0207A/debug/constraints
set ip_dir $root_dir/IP
set common_dir "d:/Telops/fir-00251-Common/VHDL"
set common_dir_ip "d:/Telops/fir-00251-Common/IP"
set common_hdl_dir "d:/Telops/Common_HDL"
set fpa_common_dir "D:/Telops/Common_HDL/Common_Projects/TEL2000/FPA_common/src"

set proj_name "adc_brd_dbg"
set proj_dir $root_dir/xilinx/$proj_name

create_project $proj_name $proj_dir

# Set project properties
set obj [get_projects $proj_name]
set_property "part" "xc7k160tfbg676-1" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "VHDL" $obj

set filelist ""

add_files -norecurse $common_dir

#read_ip $ip_dir/ch0_clink_clk_80MHz/ch0_clink_clk_80MHz.xci
read_ip $ip_dir/afifo_w57d16/afifo_w57d16.xci

# Add FPA common source
add_files $fpa_common_dir

# Add ALDEC sources
add_files $aldec_dir

set filelist  [concat $filelist [glob -nocomplain $src_dir/FPA/isc0207A/HDL/*.vhd]]
#set filelist  [concat $filelist [glob -nocomplain $src_dir/QuadADC/HDL/*.vhd]]
#set filelist  [concat $filelist [glob -nocomplain $src_dir/QuadADC/debug/*.vhd]]

# clink
#set filelist  [concat $filelist [glob -nocomplain $src_dir/clink/HDL/*.vhd]]

# Add the file list
add_files $filelist

#ADD STAND ALONE COMMON HDL SOURCE
add_files $common_hdl_dir/Utilities/sync_reset.vhd
add_files $common_hdl_dir/Utilities/double_sync.vhd
add_files $common_hdl_dir/Utilities/double_sync_vector.vhd
add_files $common_hdl_dir/Utilities/sync_resetn.vhd
add_files $common_hdl_dir/Utilities/gen_areset.vhd
add_files $common_hdl_dir/Utilities/Clk_Divider.vhd
add_files $common_hdl_dir/Utilities/dcm_reset.vhd
add_files $common_hdl_dir/Utilities/oddr_clk_vector.vhd
add_files $common_hdl_dir/Utilities/reset_extension.vhd
add_files $common_hdl_dir/SPI/spi_rx.vhd
add_files $common_hdl_dir/SPI/spi_tx.vhd

# Add top level
add_files $aldec_dir/adc_brd_mux_dbg.vhd

#Set top level design
add_files -norecurse -scan_for_includes D:/Telops/FIR-00251-Proc/aldec/compile/adc_brd_mux_dbg.vhd
update_compile_order -fileset sources_1
set_property top adc_brd_mux_dbg [current_fileset]
update_compile_order -fileset sources_1

#Add constraint file
add_files -norecurse -fileset constrs_1 $constr_dir

#Set top level constraint
#set_property target_constrs_file d:/Telops/fir-00251-Proc/src/QuadADC/debug/constraints/quad_rx_top_level_ctrl.xdc [current_fileset -constrset]
set_property target_constrs_file D:/Telops/FIR-00251-Proc/src/FPA/isc0207A/debug/constraints/adc_brd_dbg_physical.xdc [current_fileset -constrset]
set_property target_constrs_file D:/Telops/FIR-00251-Proc/src/FPA/isc0207A/debug/constraints/adc_brd_dbg_timing.xdc [current_fileset -constrset]

#Set as out-of context module
#set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/ch0_clink_clk_80MHz/ch0_clink_clk_80MHz.xci]
#set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/afifo_w57d16/afifo_w57d16.xci]

update_ip_catalog

update_compile_order -fileset sources_1

set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.FANOUT_LIMIT 1000 [get_runs synth_1]