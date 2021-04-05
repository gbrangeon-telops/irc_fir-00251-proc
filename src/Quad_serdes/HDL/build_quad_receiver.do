#alib work
#setActivelib work
	   
setenv ADC_INTF "D:\Telops\FIR-00251-Proc\src\Quad_serdes\HDL"
setenv COMMON "D:\Telops\FIR-00251-Common\VHDL"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv PROC "D:\Telops\FIR-00251-Proc"
setenv FPA_COMMON "$COMMON_HDL\Common_Projects\TEL2000\FPA_common\src"
	   
# Package
acom -incr "$COMMON\tel2000pkg.vhd"
acom "$COMMON\iserdes\adc\fpa_serdes_define.vhd"
acom "$FPA_COMMON\fpa_common_pkg.vhd"

#common_hdl
acom -incr -nowarn DAGGEN_0523 \
"$COMMON_HDL\Utilities\SYNC_RESET.vhd" \
"$COMMON_HDL\Utilities\double_sync.vhd" \
"$COMMON_HDL\Utilities\sync_resetn.vhd" \
"$COMMON_HDL\Utilities\gen_areset.vhd" \
"$COMMON_HDL\Utilities\Clk_Divider.vhd" \
"$COMMON_HDL\Utilities\Clk_Divider_Pulse.vhd" \
"$COMMON_HDL\Utilities\dcm_reset.vhd" \
"$COMMON_HDL\Utilities\reset_extension.vhd" \
"$COMMON_HDL\Utilities\oddr_clk_vector.vhd" \
"$COMMON_HDL\SPI\spi_rx.vhd" \
"$COMMON_HDL\SPI\spi_tx.vhd"
	   	 
acom -incr -nowarn DAGGEN_0523 \
#"$PROC\IP\afifo_w57d16\afifo_w57d16_funcsim.vhdl" \
"$COMMON\iserdes\idelay_wrapper.vhd" \
"$COMMON\iserdes\adc\adc_iserdes_wrapper.vhd" \
"$COMMON\iserdes\adc\adc_serdes_clk_wrapper.vhd" \
"$COMMON\iserdes\adc\adc_pattern_validator.vhd" \
"$COMMON\iserdes\adc\adc_pattern_validator_ctrler.vhd" \
"$COMMON\iserdes\clink\clink_delay_ctrl.vhd" \
"$COMMON\iserdes\clink\clink_bitslip_ctrl.vhd" \
"$COMMON\iserdes\clink\clink_calibration.bde" \
"$COMMON\iserdes\adc\quad_pattern_validator.bde" \
"$ADC_INTF\quad_data_deserializer.bde" \
"$ADC_INTF\quad_data_sync.vhd" \
"$ADC_INTF\quad_data_sync_v2.vhd" \
"$ADC_INTF\afpa_data_deserializer_8chn.bde" \
"$ADC_INTF\afpa_data_deserializer_8chn_v2.bde" \
"$ADC_INTF\afpa_data_deserializer_8chn.bde" \
"$ADC_INTF\afpa_data_deserializer_16chn_v2.bde"