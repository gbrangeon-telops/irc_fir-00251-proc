alib work
setActivelib work

setenv EHDRI_INTF "D:\Telops\FIR-00251-Proc\src\eHDRI\HDL"
setenv COMMON "D:\Telops\FIR-00251-Common\VHDL"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv PROC "D:\Telops\FIR-00251-Proc"

# Package
acom  "D:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd"

#common_hdl
acom "$COMMON_HDL\Utilities\SYNC_RESET.vhd"
acom "$COMMON\Utilities\axil32_to_native.vhd"

#IP
--acom "$PROC\IP\ehdri_index_mem\ehdri_index_mem_funcsim.vhdl"

#source Buffering
acom "$EHDRI_INTF\ehdri_ctrl.vhd"
acom "$EHDRI_INTF\ehdri_SM.vhd"

#Top
acom "$EHDRI_INTF\EHDRI_toplevel.bde"
