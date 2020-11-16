#savealltabs
#SetActiveLib -work
#clearlibrary 	


#__BEGIN BUILD BB1920 SERDES

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

#IP
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\fifo_generator_1_stub.vhdl \
 d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\fifo_generator_1_sim_netlist.vhdl
 
# BB1920 SERDES
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\data_dispatcher.vhd \
 d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\Stim.vhd \
 d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\scd_proxy2_dout.vhd \
 d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\scd_proxy2_dsync.vhd \
 d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\clink_serdes8_clk_wrapper.vhd \
 d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\scd_proxy2_serdes.bde \
 d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\scd_proxy2_serdes_simulation.bde \
 d:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\bb1920_deserializer.bde

#__END BUILD BB1920 SERDES