#savealltabs
#setactivelib work
#clearlibrary 	


#__BEGIN BUILD NBITS

# common
acom -incr -nowarn DAGGEN_0523 \
 "$COMMON_HDL/Utilities/sync_reset.vhd" \
 "$COMMON_HDL/Utilities/dcm_reset.vhd" \
#TODO Edit if more than 4 channel are needed
 "$FIR251COMMON/VHDL/iserdes/clink/fpa_serdes_define.vhd"
acom -incr -nowarn DAGGEN_0523 -2008 \
 "$FIR251COMMON/VHDL/iserdes/nbits_generic/nbits_serdes_clk_wrapper.vhd" \
 "$FIR251COMMON/VHDL/iserdes/idelay_wrapper.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/iserdes_wrapper.vhd" \
 "$FIR251COMMON/VHDL/iserdes/nbits_generic/iserdes_nbits_wrapper.vhd" \
 "$FIR251COMMON/VHDL/iserdes/nbits_generic/nbits_delay_validator_core.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/high_duration_meas.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_validator_ctrler.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_signals_validator.bde" \
 "$FIR251COMMON/VHDL/iserdes/nbits_generic/nbits_delay_validator.bde" \
 "$FIR251COMMON/VHDL/iserdes/nbits_generic/nbits_delay_ctrl.vhd" \
 "$FIR251COMMON/VHDL/iserdes/nbits_generic/nbits_bitslip_ctrl.vhd" \
 "$FIR251COMMON/VHDL/iserdes/nbits_generic/nbits_calibration.bde" \
# NBITS
 "$FIR251COMMON/VHDL/iserdes/nbits_generic/nbits_deserializer.bde" \
 "$FIR251COMMON/VHDL/iserdes/nbits_generic/nbits_receiver_nch.bde"

#__END BUILD NBITS