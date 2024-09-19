alib work
setactivelib work

setenv ICU_DIR "$FIR251PROC/src/ICU/HDL"

setenv PROC "$FIR251PROC"

acom -incr -nowarn DAGGEN_0523 "$FIR251COMMON/VHDL/tel2000pkg.vhd" \
 "$FIR251COMMON/VHDL/img_header_define.vhd" \
 "$COMMON_HDL/Utilities/sync_reset.vhd" \
 "$COMMON_HDL/Utilities/sync_resetn.vhd" \
 "$ICU_DIR/ICU_SM.vhd"
acom -relax "$ICU_DIR/ICU_Ctrl.vhd" \
 "$ICU_DIR/ICU_toplevel.bde"
