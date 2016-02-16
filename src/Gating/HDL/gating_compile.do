--SetActiveLib -work
--clearlibrary fir_00251
--clearlibrary work

setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv GATING_INTF "D:\Telops\FIR-00251-Proc\src\Gating\HDL"

# Package
acom -nowarn DAGGEN_0523 \
 "$COMMON\VHDL\tel2000pkg.vhd" \
 "$COMMON\VHDL\img_header_define.vhd"

#common_hdl
acom -incr -nowarn DAGGEN_0523 \
 "$COMMON_HDL\Utilities\SYNC_RESET.vhd" \
 "$COMMON_HDL\Utilities\double_sync.vhd" \
 "$COMMON_HDL\Utilities\double_sync_vector.vhd" \
 "$COMMON_HDL\Utilities\sync_resetn.vhd"

acom -nowarn DAGGEN_0523 \
 "$GATING_INTF\gating_define.vhd" \
 "$GATING_INTF\gating_mblaze_intf.vhd" \
 "$GATING_INTF\gating_SM.vhd" \
 "$GATING_INTF\gating_top.bde"

