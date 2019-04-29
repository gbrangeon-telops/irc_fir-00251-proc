alib work
setActivelib work

setenv AEC_INTF "D:\Telops\FIR-00251-Proc\src\AEC\HDL"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv PROC "D:\Telops\FIR-00251-Proc"

# Package
acom  "D:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd"
acom  "D:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd"

#common_hdl
acom -nowarn DAGGEN_0523 "$COMMON_HDL\Utilities\SYNC_RESET.vhd" \
 "$COMMON_HDL\Utilities\double_sync.vhd" \
 "$COMMON_HDL\Utilities\double_sync_vector.vhd" \
 "$COMMON_HDL\Utilities\sync_resetn.vhd"

#common-251
acom -relax "$COMMON\VHDL\hdr_extractor\hder_extractor.vhd"
acom "$COMMON\VHDL\Utilities\axis16_img_extractor.vhd"

#source Histogram
acom -nowarn DAGGEN_0523 \
 #"$AEC_INTF\netlist\hdl_netlist\histogram_axis_tmi.srcs\sources_1\ip\histogram_axis_tmi_blk_mem_gen_v8_1_0\histogram_axis_tmi_blk_mem_gen_v8_1_0_funcsim.vhdl" \
 #"$AEC_INTF\netlist\hdl_netlist\histogram_axis_tmi.srcs\sources_1\ip\histogram_axis_tmi_c_addsub_v12_0_0\histogram_axis_tmi_c_addsub_v12_0_0_funcsim.vhdl" \
 #"$AEC_INTF\netlist\hdl_netlist\histogram_axis_tmi.srcs\sources_1\ip\histogram_axis_tmi_c_counter_binary_v12_0_0\histogram_axis_tmi_c_counter_binary_v12_0_0_funcsim.vhdl" \
 "$AEC_INTF\netlist\sysgen\conv_pkg.vhd" \
 "$AEC_INTF\netlist\sysgen\srl17e.vhd" \
 "$AEC_INTF\netlist\sysgen\single_reg_w_init.vhd" \
 "$AEC_INTF\netlist\sysgen\synth_reg_w_init.vhd" \
 "$AEC_INTF\netlist\sysgen\synth_reg_reg.vhd" \
 "$AEC_INTF\netlist\sysgen\synth_reg.vhd" \
 "$AEC_INTF\netlist\sysgen\xlclockdriver_rd.vhd" \
 "$AEC_INTF\netlist\sysgen\histogram_axis_tmi_entity_declarations.vhd" \
 "$AEC_INTF\netlist\sysgen\histogram_axis_tmi.vhd"

#source AEC
acom -nowarn DAGGEN_0523 "$AEC_INTF\AEC_CUMSUM.vhd" \
 -relax "$AEC_INTF\AEC_Ctrl.vhd" \
 "$AEC_INTF\AECPlus.vhd" \
 "$AEC_INTF\AEC.bde"

#sim



