-- setactivelib work
-- clearlibrary fir_00251
-- clearlibrary work


setenv GATING_INTF "$FIR251PROC/src/Gating/HDL"

# Package
acom -nowarn DAGGEN_0523 \
 "$FIR251COMMON/VHDL/tel2000pkg.vhd" \
 "$FIR251COMMON/VHDL/img_header_define.vhd"

#common_hdl
acom -incr -nowarn DAGGEN_0523 \
 "$COMMON_HDL/Utilities/SYNC_RESET.vhd" \
 "$COMMON_HDL/Utilities/double_sync.vhd" \
 "$COMMON_HDL/Utilities/double_sync_vector.vhd" \
 "$COMMON_HDL/Utilities/sync_resetn.vhd"

acom -nowarn DAGGEN_0523 \
 "$GATING_INTF/gating_define.vhd" \
 "$GATING_INTF/gating_mblaze_intf.vhd" \
 "$GATING_INTF/gating_SM.vhd" \
 "$GATING_INTF/gating_top.bde"

