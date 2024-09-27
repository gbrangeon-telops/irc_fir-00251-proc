#savealltabs
-- setactivelib work
-- clearlibrary 	
alib work
setactivelib work

#__BEGIN BUILD BB1920 SERDES

# common
acom -incr -nowarn DAGGEN_0523 \
 "$FIR251COMMON/VHDL/tel2000pkg.vhd" \
 "$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd" \
 "$FIR251PROC/src/FPA/blackbird1920D/HDL/FPA_define.vhd" \
 "$FIR251PROC/src/FPA/scd_proxy2/HDL/proxy_define.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/fpa_serdes_define.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_serdes_clk_wrapper.vhd" \
 "$FIR251COMMON/VHDL/iserdes/idelay_wrapper.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_delay_validator_core.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/high_duration_meas.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_validator_ctrler.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_signals_validator.bde" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_delay_validator.bde" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_delay_ctrl.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_bitslip_ctrl.vhd" \
 "$FIR251COMMON/VHDL/iserdes/clink/clink_calibration.bde" 

-- acom -incr -nowarn DAGGEN_0523 \
acom "$FIR251PROC/src/bb1920_serdes/HDL/scd_proxy2_dout.vhd"
acom "$FIR251PROC/src/bb1920_serdes/HDL/scd_proxy2_dsync.vhd"
acom "$FIR251PROC/src/bb1920_serdes/HDL/scd_proxy2_mux_dsync.vhd"
acom "$FIR251PROC/src/bb1920_serdes/HDL/clink_serdes8_clk_wrapper.vhd"
acom "$FIR251PROC/src/bb1920_serdes/HDL/scd_proxy2_serdes.bde"
acom "$FIR251PROC/src/bb1920_serdes/HDL/bb1920_deserializer.bde"