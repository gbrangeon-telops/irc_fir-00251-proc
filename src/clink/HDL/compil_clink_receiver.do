#savealltabs
#SetActiveLib -work
#clearlibrary 	


#__BEGIN BUILD CLINK

# common
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\marsD\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\Megalink\HDL\proxy_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\fpa_serdes_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_serdes_clk_wrapper.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\idelay_wrapper.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\iserdes_wrapper.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_delay_validator_core.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\high_duration_meas.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_validator_ctrler.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_signals_validator.bde \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_delay_validator.bde \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_delay_ctrl.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_bitslip_ctrl.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_calibration.bde

# CLINK
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\clink\HDL\scd_clink_dout_ctrl_v2.vhd \
 d:\Telops\FIR-00251-Proc\src\clink\HDL\mglk_clink_dout_ctrl.vhd \
 d:\Telops\FIR-00251-Proc\src\clink\HDL\clink_dout_ctrl_v2.bde \
 d:\Telops\FIR-00251-Proc\src\clink\HDL\clink_deserializer.bde \
 d:\Telops\FIR-00251-Proc\src\clink\HDL\clink_receiver_3ch.bde

#__END BUILD CLINK