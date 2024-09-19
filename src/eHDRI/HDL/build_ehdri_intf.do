alib work
setactivelib work

setenv EHDRI_INTF "$FIR251PROC/src/eHDRI/HDL"


# Package
acom  "$FIR251COMMON/VHDL/tel2000pkg.vhd"

#common_hdl
acom "$COMMON_HDL/Utilities/SYNC_RESET.vhd"
acom "$FIR251COMMON/VHDL/Utilities/axil32_to_native.vhd"

#source EHDRI
acom "$EHDRI_INTF/ehdri_ctrl.vhd"
acom "$EHDRI_INTF/ehdri_SM.vhd"

#Top
acom "$EHDRI_INTF/EHDRI_toplevel.bde"
