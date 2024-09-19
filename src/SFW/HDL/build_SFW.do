alib work
setactivelib work

setenv SFW_INTF "$FIR251PROC/src/SFW/HDL"			   


# Package
acom -nowarn DAGGEN_0523 "$FIR251COMMON/VHDL/tel2000pkg.vhd"
acom -nowarn DAGGEN_0523 "$FIR251COMMON/VHDL/img_header_define.vhd"
acom -nowarn DAGGEN_0523 "$SFW_INTF/sfw_define.vhd"

#common_hdl
acom -incr -nowarn DAGGEN_0523 \
 "$COMMON_HDL/Utilities/SYNC_RESET.vhd" \
 "$COMMON_HDL/Utilities/sync_resetn.vhd" \
  "$COMMON_HDL/Utilities/double_sync.vhd" \
 

#fir-common
acom -incr -nowarn DAGGEN_0523 \
	"$FIR251COMMON/VHDL/Utilities/axil32_addr_demux4.vhd" \
	"$FIR251COMMON/VHDL/Utilities/axil32_to_native.vhd"


#source SFW
acom -nowarn DAGGEN_0523 "$SFW_INTF/fw_decoder.vhd" \
 -relax "$SFW_INTF/SFW_Ctrl.vhd" \
 "$SFW_INTF/sfw_processing.vhd"	 \
 "$SFW_INTF/sfw_acquisition_sm.vhd"	 \
 "$SFW_INTF/sfw_trig_cdc.vhd"	 \
 "$SFW_INTF/SFW.bde"
