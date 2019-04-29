alib work
setActivelib work

setenv SFW_INTF "D:\Telops\FIR-00251-Proc\src\SFW\HDL"			   
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv PROC "D:\Telops\FIR-00251-Proc"

# Package
acom -nowarn DAGGEN_0523 "D:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd"
acom -nowarn DAGGEN_0523 "D:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd"
acom -nowarn DAGGEN_0523 "$SFW_INTF\sfw_define.vhd"
acom -nowarn DAGGEN_0523 "$PROC\"

#common_hdl
acom -incr -nowarn DAGGEN_0523 \
 "$COMMON_HDL\Utilities\SYNC_RESET.vhd" \
 "$COMMON_HDL\Utilities\sync_resetn.vhd" \
  "$COMMON_HDL\Utilities\double_sync.vhd" \
 

#fir-common
acom -incr -nowarn DAGGEN_0523 \
	"$COMMON\VHDL\Utilities\axil32_addr_demux4.vhd" \
	"$COMMON\VHDL\Utilities\axil32_to_native.vhd"
	
#IP Source
acom -incr -nowarn DAGGEN_0523 \
	"$PROC\ip\sdp_ram_w32_d128\sdp_ram_w32_d128_funcsim.vhdl"

#source SFW
acom -nowarn DAGGEN_0523 "$SFW_INTF\fw_decoder.vhd" \
 -relax "$SFW_INTF\SFW_Ctrl.vhd" \
 "$SFW_INTF\sfw_processing.vhd"	 \
 "$SFW_INTF\sfw_acquisition_sm.vhd"	 \
 "$SFW_INTF\sfw_trig_cdc.vhd"	 \
 "$SFW_INTF\SFW.bde"
