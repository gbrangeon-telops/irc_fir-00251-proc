#savealltabs
--SetActiveLib -work
--clearlibrary 	
alib work
setActivelib work

#__BEGIN BUILD BB1920 SERDES

# common
acom -incr -nowarn DAGGEN_0523 \
 D:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\blackbird1920D\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\proxy_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\fpa_serdes_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_serdes_clk_wrapper.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\idelay_wrapper.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_delay_validator_core.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\high_duration_meas.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_validator_ctrler.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_signals_validator.bde \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_delay_validator.bde \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_delay_ctrl.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_bitslip_ctrl.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\clink\clink_calibration.bde 

--acom -incr -nowarn DAGGEN_0523 \
acom d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\scd_proxy2_dout.vhd
acom d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\scd_proxy2_dsync.vhd
acom d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\scd_proxy2_mux_dsync.vhd
acom d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\clink_serdes8_clk_wrapper.vhd
acom d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\scd_proxy2_serdes.bde
acom d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\bb1920_deserializer.bde