set src_dir $root_dir/src
set constr_dir $root_dir/src/constraints
set common_hdl_dir "d:/Telops/Common_HDL"
set fpa_common_dir "D:/Telops/Common_HDL/Common_Projects/TEL2000/FPA_common/src"
set ip_dir "$root_dir/IP/${FPGA_SIZE}"
set proj_name [get_project]
set sensor [string range $proj_name 19 end]

#Add Telops IP Repos
set_property  ip_repo_paths  "$ip_dir/AEC/histogram_axis_tmi_4pix_v1_0 $ip_dir/FlashReset" [current_project]
update_ip_catalog

# Add Project IP sources
set ipfilelist {}
foreach subdir [glob -nocomplain -type d $ip_dir/*] {
   if {[glob -nocomplain $subdir/*.xci] != {}} {lappend ipfilelist [glob $subdir/*.xci]}
}
read_ip $ipfilelist

# Add FPA common source
add_files $fpa_common_dir

# Add ALDEC sources
# On exclut les top-level du startup pour que le fir_00251_proc_isc0207A soit montré comme
# l'entité de tête dans sa hiérarchie.
# Les projets de startup doivent ajouter le fir_00251_proc_startup.
set aldec_dir_files {}
foreach file [glob -nocomplain $aldec_dir/*.vhd] {
   if {[string match *fir_00251_proc_startup* $file] == 0} {lappend aldec_dir_files $file}
}
add_files $aldec_dir_files

# Add Project sources
add_files [concat \
   [glob -nocomplain $src_dir/ADCReadout/HDL/*.vhd] \
   [glob -nocomplain $src_dir/AEC/HDL/*.vhd] \
   [glob -nocomplain $src_dir/BD/*.vhd] \
   [glob -nocomplain $src_dir/Buffering/HDL/*.vhd] \
   [glob -nocomplain $src_dir/Calibration/HDL/*.vhd] \
   [glob -nocomplain $src_dir/clink/HDL/*.vhd] \
   [glob -nocomplain $src_dir/EHDRI/HDL/*.vhd] \
   [glob -nocomplain $src_dir/ExposureTime/HDL/*.vhd] \
   [glob -nocomplain $src_dir/Flagging/HDL/*.vhd] \
   [glob -nocomplain $src_dir/Flash_Ctrl/HDL/*.vhd] \
   [glob -nocomplain $src_dir/FPA/*.vhd] \
   [glob -nocomplain $src_dir/Gating/HDL/*.vhd] \
   [glob -nocomplain $src_dir/hder/HDL/*.vhd] \
   [glob -nocomplain $src_dir/ICU/HDL/*.vhd] \
   [glob -nocomplain $src_dir/irig/HDL/*.vhd] \
   [glob -nocomplain $src_dir/MGT/HDL/*.vhd] \
   [glob -nocomplain $src_dir/SFW/HDL/*.vhd] \
   [glob -nocomplain $src_dir/startup/HDL/*.vhd] \
   [glob -nocomplain $src_dir/Trig/HDL/*.vhd] \
   [glob -nocomplain $src_dir/FrameBuffer/HDL/*.vhd] \
]

# Add common project sources 
add_files [concat \
   [glob -nocomplain $common251_dir/*.vhd] \
   [glob -nocomplain $common251_dir/Buffering/*.vhd] \
   [glob -nocomplain $common251_dir/Calibration/*.vhd] \
   [glob -nocomplain $common251_dir/Fifo/*.vhd] \
   [glob -nocomplain $common251_dir/hdr_extractor/*.vhd] \
   [glob -nocomplain $common251_dir/Math/*.vhd] \
   [glob -nocomplain $common251_dir/MGT/hdl/*.{vhd,v}] \
   [glob -nocomplain $common251_dir/PWM_CTRL/HDL/*.vhd] \
   [glob -nocomplain $common251_dir/Ram/*.vhd] \
   [glob -nocomplain $common251_dir/signal_stat/*.vhd] \
   [glob -nocomplain $common251_dir/USART/*.vhd] \
   [glob -nocomplain $common251_dir/Utilities/*.vhd] \
   [glob -nocomplain $common251_dir/Lut/*.vhd] \
]

#ADD STAND ALONE COMMON HDL SOURCE
add_files [concat \
   $common_hdl_dir/Utilities/double_sync_vector.vhd \
   $common_hdl_dir/Utilities/double_sync.vhd \
   $common_hdl_dir/Utilities/Pulse_gen.vhd \
   $common_hdl_dir/Utilities/sync_pulse.vhd \
   $common_hdl_dir/Utilities/sync_reset.vhd \
   $common_hdl_dir/Utilities/sync_resetn.vhd \
   $common_hdl_dir/Utilities/reset_extension.vhd \
   $common_hdl_dir/Utilities/data_cdc_sync.vhd \
   $common_hdl_dir/SPI/ads1118_driver.vhd \
   $common_hdl_dir/SPI/spi_tx.vhd \
   $common_hdl_dir/SPI/spi_rx.vhd \
   $common_hdl_dir/gh_vhdl_lib/custom_MSI/gh_PWM.vhd \
   $common_hdl_dir/gh_vhdl_lib/custom_MSI/gh_stretch.vhd \
   $common_hdl_dir/gh_vhdl_lib/custom_MSI/gh_edge_det.vhd \
   $common_hdl_dir/gh_vhdl_lib/custom_MSI/gh_edge_det_xcd.vhd \
   $common_hdl_dir/gh_vhdl_lib/custom_MSI/gh_binary2gray.vhd \
   $common_hdl_dir/gh_vhdl_lib/memory/gh_fifo_async_sr.vhd \
   $common_hdl_dir/Utilities/err_sync.vhd \
   $common_hdl_dir/Utilities/Clk_Divider.vhd \
   $common_hdl_dir/Utilities/Clk_Divider_Pulse.vhd \
   $common_hdl_dir/RS232/uarts.vhd \
   $common_hdl_dir/Utilities/dcm_reset.vhd \
   $common_hdl_dir/Utilities/Clk_Divider_Async.vhd \
]


#Read Block Design
read_bd $ip_dir/managed_ip_project/managed_ip_project.srcs/sources_1/bd/${core_name}/${core_name}.bd
add_files $ip_dir/managed_ip_project/managed_ip_project.srcs/sources_1/bd/${core_name}/hdl/${core_name}_wrapper.vhd

#Associate bootloader file to microblaze
set boot_file $root_dir/sdk/$top_lvl/${top_lvl}_boot_${FPGA_SIZE}/Release/${top_lvl}_boot_${FPGA_SIZE}.elf
add_files $boot_file

set_property SCOPED_TO_REF ${core_name} [get_files $boot_file]
set_property SCOPED_TO_CELLS {MCU/microblaze_1} [get_files $boot_file]

#Add constraint files
add_files -fileset constrs_1  [concat \
   $constr_dir/fir00251_proc_physical.xdc \
   $constr_dir/fir00251_proc_physical_${FPGA_SIZE}.xdc \
   $constr_dir/fir00251_proc_timing.xdc \
   [glob -nocomplain $constr_dir/$sensor/*.xdc] \
   [glob -nocomplain $constr_dir/_encryption/*${FPGA_SIZE}*.xdc] \
]

# make sure the files are in correct precedence order (as per UG903 recommendation)
reorder_files -fileset constrs_1 -before [get_files -of [get_filesets { constrs_1}] fir00251_proc_timing.xdc] [get_files -of [get_filesets { constrs_1}] *physical*.xdc]
reorder_files -fileset constrs_1 -before [get_files -of [get_filesets { constrs_1}] *specific_physical.xdc] [get_files -of [get_filesets { constrs_1}] -filter {NAME !~ "*specific*"} *physical*.xdc]
reorder_files -fileset constrs_1 -after  [get_files -of [get_filesets { constrs_1}] fir00251_proc_timing.xdc] [get_files -of [get_filesets { constrs_1}] *specific_timing.xdc]
reorder_files -fileset constrs_1 -back   [get_files -of [get_filesets { constrs_1}] *target.xdc]
reorder_files -fileset constrs_1 -after  [get_files -of [get_filesets { constrs_1}] *release_target.xdc] [get_files -of [get_filesets { constrs_1}] -filter {NAME !~ "*release*"} *target.xdc]

#Set top level constraint
set_property target_constrs_file [get_files -of [get_filesets { constrs_1}]  -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]

#Disable webtalk
config_webtalk -user off

#Update the ip catalog
update_ip_catalog

#Disable Flatten hierachy to be able to include chipscope
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]

#Limit max fanout (see UG949 p143 for Fanout Guidelines table)
set_property STEPS.SYNTH_DESIGN.ARGS.FANOUT_LIMIT 200 [get_runs synth_1]

#Enable post-place optimization (see UG904 p87-93 for more details)
set_property STEPS.PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.ARGS.DIRECTIVE Default [get_runs impl_1]

