#savealltabs
#SetActiveLib -work
#clearlibrary 	


#__BEGIN BUILD NBITS

# common
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\Common_HDL\Utilities\sync_reset.vhd \
 d:\Telops\Common_HDL\Utilities\dcm_reset.vhd \
#TODO Edit if more than 4 channel are needed
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\fpa_serdes_define.vhd
acom -incr -nowarn DAGGEN_0523 -2008 \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\nbits_generic\nbits_serdes_clk_wrapper.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\idelay_wrapper.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\iserdes_wrapper.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\nbits_generic\iserdes_nbits_wrapper.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\nbits_generic\nbits_delay_validator_core.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\high_duration_meas.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_validator_ctrler.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_signals_validator.bde \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\nbits_generic\nbits_delay_validator.bde \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\nbits_generic\nbits_delay_ctrl.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\nbits_generic\nbits_bitslip_ctrl.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\nbits_generic\nbits_calibration.bde \
# NBITS
 d:\Telops\FIR-00251-Common\VHDL\iserdes\nbits_generic\nbits_deserializer.bde \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\nbits_generic\nbits_receiver_nch.bde

#__END BUILD NBITS