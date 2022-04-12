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


#source Histogram
acom "$PROC\IP\160\histogram_axis_tmi_4pix_0\histogram_axis_tmi_4pix_0_stub.vhdl"
 
#source decimator
do "D:\Telops\FIR-00251-Common\VHDL\decimator\Hdl\build_decimator.do"

#source AEC
acom -nowarn DAGGEN_0523 "$AEC_INTF\AEC_CUMSUM.vhd" \
-relax "$AEC_INTF\AEC_Ctrl.vhd" \
 "$AEC_INTF\AECPlus.vhd" \
 "$AEC_INTF\aec_decimator_wrapper.bde" \
 "$AEC_INTF\AEC.bde"

#sim



