alib work
setactivelib work

setenv AEC_INTF "$FIR251PROC/src/AEC/HDL"

# Package
acom  "$FIR251COMMON/VHDL/tel2000pkg.vhd"
acom  "$FIR251COMMON/VHDL/img_header_define.vhd"

#common_hdl
acom -nowarn DAGGEN_0523 "$COMMON_HDL/Utilities/SYNC_RESET.vhd" \
 "$COMMON_HDL/Utilities/double_sync.vhd" \
 "$COMMON_HDL/Utilities/double_sync_vector.vhd" \
 "$COMMON_HDL/Utilities/sync_resetn.vhd"


#source Histogram
acom "$FIR251PROC/IP/160/histogram_axis_tmi_4pix_0/histogram_axis_tmi_4pix_0_stub.vhdl"
 
#source decimator
do $FIR251COMMON/VHDL/decimator/Hdl/build_decimator.do

#source AEC
acom -nowarn DAGGEN_0523 "$AEC_INTF/AEC_CUMSUM.vhd" \
-relax "$AEC_INTF/AEC_Ctrl.vhd" \
 "$AEC_INTF/AECPlus.vhd" \
 "$AEC_INTF/aec_decimator_wrapper.bde" \
 "$AEC_INTF/AEC.bde"

#sim



