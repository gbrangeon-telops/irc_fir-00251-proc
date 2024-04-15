alib work
setActivelib work

setenv ICU_DIR "D:\Telops\FIR-00251-Proc\src\ICU\HDL"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv PROC "D:\Telops\FIR-00251-Proc"

acom -incr -nowarn DAGGEN_0523 "D:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd" \
 "D:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd" \
 "$COMMON_HDL\Utilities\sync_reset.vhd" \
 "$COMMON_HDL\Utilities\sync_resetn.vhd" \
 "$ICU_DIR\ICU_SM.vhd"
acom -relax "$ICU_DIR\ICU_Ctrl.vhd" \
 "$ICU_DIR\ICU_toplevel.bde"
