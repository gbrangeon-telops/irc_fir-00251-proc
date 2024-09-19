#savealltabs
#setactivelib work

#clearlibrary 	


#__BEGIN BUILD CLINK

# common
acom -incr -nowarn DAGGEN_0523 \
 "$FIR251COMMON/VHDL/tel2000pkg.vhd" \
 "$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd" \
 "$FIR251PROC/src/FPA/marsD/HDL/FPA_define.vhd" \
 "$FIR251PROC/src/FPA/Megalink/HDL/proxy_define.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/fpa_serdes_define.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_serdes_clk_wrapper.vhd" \
 "$FIR251COMMON/VHDL/iserdes/idelay_wrapper.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/iserdes_wrapper.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_delay_validator_core.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/high_duration_meas.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_validator_ctrler.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_signals_validator.bde" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_delay_validator.bde" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_delay_ctrl.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_bitslip_ctrl.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_calibration.bde"

# CLINK
acom -incr -nowarn DAGGEN_0523 \
 "$FIR251PROC/src/clink/HDL/scd_clink_dout_ctrl_v2.vhd" \
 "$FIR251PROC/src/clink/HDL/mglk_clink_dout_ctrl.vhd" \
 "$FIR251PROC/src/clink/HDL/clink_dout_ctrl_v2.bde" \
 "$FIR251PROC/src/clink/HDL/clink_deserializer.bde" \
 "$FIR251PROC/src/clink/HDL/clink_receiver_3ch.bde"

#__END BUILD CLINK