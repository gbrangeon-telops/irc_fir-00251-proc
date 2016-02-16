set root_dir "d:/Telops/fir-00251-Proc"
set script_dir $root_dir/scripts
set src_dir $root_dir/src
set aldec_dir $root_dir/aldec/compile
set constr_dir $root_dir/src/constraints
set ip_dir $root_dir/IP
set common_dir "d:/Telops/fir-00251-Common/VHDL"
set common_dir_ip "d:/Telops/fir-00251-Common/IP"
set common_hdl_dir "d:/Telops/Common_HDL"
set fpa_common_dir "D:/Telops/Common_HDL/Common_Projects/TEL2000/FPA_common/src"

set filelist ""

# Add common project sources 
add_files -norecurse $common_dir
add_files -norecurse $common_dir/Fifo/
add_files -norecurse $common_dir/hdr_extractor/
add_files -norecurse $common_dir/Math/
add_files -norecurse $common_dir/Ram/
add_files -norecurse $common_dir/Memory_Interface/
add_files -norecurse $common_dir/Utilities/
add_files -norecurse $common_dir/USART/

add_files -norecurse $common_dir/MGT/hdl/
add_files -norecurse $common_dir/PWM_CTRL/HDL/
add_files $common_dir/Buffering/
add_files -norecurse $common_dir/Calibration/

# Add common project IP sources (should be  move to fir-00251-Proc)
read_ip $common_dir_ip/AXI4_Stream32_to_64/AXI4_Stream32_to_64.xci
read_ip $common_dir_ip/AXI4_Stream64_to_32/AXI4_Stream64_to_32.xci
read_ip $common_dir_ip/axis_32_to_16/axis_32_to_16.xci
read_ip $common_dir_ip/axis_32_to_16_lite/axis_32_to_16_lite.xci
read_ip $common_dir_ip/axis_clock_converter_div2/axis_clock_converter_div2.xci
read_ip $common_dir_ip/axis_conv_linebuffer_64w_1024d/axis_conv_linebuffer_64w_1024d.xci
read_ip $common_dir_ip/axis_data_fifo_32w_1024d_aclk/axis_data_fifo_32w_1024d_aclk.xci
read_ip $common_dir_ip/exp_mgt/exp_mgt.xci
read_ip $common_dir_ip/data_mgt/data_mgt.xci
read_ip $common_dir_ip/video_mgt/video_mgt.xci

# ADD Common Ip Special vhd file
#set filelist  [concat $filelist $common_dir_ip/AXI4_Stream32_to_64/AXI4_Stream32_to_64_wrapper.vhd]
#set filelist  [concat $filelist $common_dir_ip/AXI4_Stream64_to_32/AXI4_Stream64_to_32_wrapper.vhd]

# Add FPA common source
add_files $fpa_common_dir

# Add Project IP sources
foreach subdir [glob -nocomplain -type d $ip_dir/*] {
   if {[glob -nocomplain $subdir/*.xci] != {}} {read_ip [glob $subdir/*.xci]}
}

# Add ALDEC sources
add_files $aldec_dir

# Add Project VHD sources
# AEC
set filelist  [concat $filelist [glob  $src_dir/AEC/HDL/netlist/sysgen/*.vhd]]
set filelist  [concat $filelist [glob  $src_dir/AEC/HDL/netlist/sysgen/*.coe]]
set filelist  [concat $filelist [glob  $src_dir/AEC/HDL/*.vhd]]
#Add Histrogram IP
read_ip "D:/Telops/FIR-00251-Proc/src/AEC/HDL/netlist/hdl_netlist/histogram_axis_tmi.srcs/sources_1/ip/histogram_axis_tmi_c_counter_binary_v12_0_0/histogram_axis_tmi_c_counter_binary_v12_0_0.xci" 
read_ip "D:/Telops/FIR-00251-Proc/src/AEC/HDL/netlist/hdl_netlist/histogram_axis_tmi.srcs/sources_1/ip/histogram_axis_tmi_blk_mem_gen_v8_1_0/histogram_axis_tmi_blk_mem_gen_v8_1_0.xci" 
read_ip "D:/Telops/FIR-00251-Proc/src/AEC/HDL/netlist/hdl_netlist/histogram_axis_tmi.srcs/sources_1/ip/histogram_axis_tmi_c_addsub_v12_0_0/histogram_axis_tmi_c_addsub_v12_0_0.xci"


# BD
set filelist  [concat $filelist [glob  $src_dir/BD/*.vhd]]

# FPA Common
set filelist  [concat $filelist [glob -nocomplain $src_dir/FPA/*.vhd]]

# Buffering
set filelist  [concat $filelist [glob -nocomplain $src_dir/Buffering/HDL/*.vhd]]

# Calibration
set filelist  [concat $filelist [glob -nocomplain $src_dir/Calibration/HDL/*.vhd]]

# clink
set filelist  [concat $filelist [glob -nocomplain $src_dir/clink/HDL/*.vhd]]

# exposure time
set filelist  [concat $filelist [glob -nocomplain $src_dir/ExposureTime/HDL/*.vhd]]

# Flash CTRL
set filelist  [concat $filelist [glob -nocomplain $src_dir/Flash_Ctrl/HDL/*.vhd]]

# FPGA_Comm
set filelist  [concat $filelist [glob -nocomplain $src_dir/fpga_comm/HDL/*.vhd]]

# Header Inserter
set filelist  [concat $filelist [glob -nocomplain $src_dir/hder/HDL/*.vhd]]

# IRIG
set filelist  [concat $filelist [glob -nocomplain $src_dir/irig/HDL/*.vhd]]

# MGT
#TBD

# TRIG
set filelist  [concat $filelist [glob -nocomplain $src_dir/Trig/HDL/*.vhd]]

#USB
set filelist  [concat $filelist [glob -nocomplain $src_dir/USB/HDL/*.vhd]]

#ICU
set filelist  [concat $filelist [glob -nocomplain $src_dir/ICU/HDL/*.vhd]]

#EHDRI
set filelist  [concat $filelist [glob -nocomplain $src_dir/EHDRI/HDL/*.vhd]]

#QADC
set filelist  [concat $filelist [glob -nocomplain $src_dir/QuadADC/HDL/*.vhd]]

#FLAGGING
set filelist  [concat $filelist [glob -nocomplain $src_dir/Flagging/HDL/*.vhd]]

#GATING
set filelist  [concat $filelist [glob -nocomplain $src_dir/Gating/HDL/*.vhd]]

#SFW
set filelist  [concat $filelist [glob -nocomplain $src_dir/SFW/HDL/*.vhd]]



# Add the file list
add_files $filelist

#ADD STAND ALONE COMMON HDL SOURCE
add_files $common_hdl_dir/Utilities/double_sync_vector.vhd
add_files $common_hdl_dir/Utilities/double_sync.vhd
add_files $common_hdl_dir/Utilities/sync_reset.vhd
add_files $common_hdl_dir/Utilities/sync_resetn.vhd
add_files $common_hdl_dir/Utilities/reset_extension.vhd
add_files $common_hdl_dir/SPI/ads1118_driver.vhd
add_files $common_hdl_dir/SPI/spi_tx.vhd
add_files $common_hdl_dir/SPI/spi_rx.vhd
add_files $common_hdl_dir/gh_vhdl_lib/custom_MSI/gh_PWM.vhd
add_files $common_hdl_dir/gh_vhdl_lib/custom_MSI/gh_stretch.vhd
add_files $common_hdl_dir/gh_vhdl_lib/custom_MSI/gh_edge_det.vhd
add_files $common_hdl_dir/gh_vhdl_lib/custom_MSI/gh_edge_det_xcd.vhd
add_files $common_hdl_dir/Utilities/err_sync.vhd
add_files $common_hdl_dir/Utilities/Clk_Divider.vhd
add_files $common_hdl_dir/Utilities/Clk_Divider_Pulse.vhd
add_files $common_hdl_dir/RS232/uarts.vhd
add_files $common_hdl_dir/Utilities/dcm_reset.vhd

#Add constraint file
add_files -norecurse -fileset constrs_1 $constr_dir

#Generate the bloc design
source $script_dir/gen_bd_core.tcl

#Extract bd address map
source $script_dir/tel_xparam_extract.tcl

#close the bd design
close_bd_design core

#Set as out-of context module
create_fileset -blockset -define_from core core
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Common/IP/AXI4_Stream32_to_64/AXI4_Stream32_to_64.xci]
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Common/IP/AXI4_Stream64_to_32/AXI4_Stream64_to_32.xci]
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/clink_clk_7x80MHz/clink_clk_7x80MHz.xci]
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/sfifo_w8_d64/sfifo_w8_d64.xci]
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/tdp_ram_w8_d2048/tdp_ram_w8_d2048.xci]
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/t_axi4_stream32_sfifo_d2048/t_axi4_stream32_sfifo_d2048.xci]
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/t_axi4_stream32_afifo_d512/t_axi4_stream32_afifo_d512.xci]
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/t_axi4_lite32_w_afifo_d16/t_axi4_lite32_w_afifo_d16.xci]
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/t_axi4_lite32_w_afifo_d64/t_axi4_lite32_w_afifo_d64.xci]
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/fwft_sfifo_w8_d16/fwft_sfifo_w8_d16.xci]
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/sp_ram_byte_w32_d64/sp_ram_byte_w32_d64.xci]
set_property generate_synth_checkpoint true [get_files  d:/Telops/fir-00251-Proc/IP/afifo_w57d16/afifo_w57d16.xci]

#Disable unused file
set_property is_enabled false [get_files  $root_dir/src/constraints/chipscope.xdc]
set_property is_enabled false [get_files  $root_dir/src/constraints/core_mig_7series_1_0.xdc]
