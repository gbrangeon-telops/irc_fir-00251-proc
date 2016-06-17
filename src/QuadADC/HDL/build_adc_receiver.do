#alib work
#setActivelib work
	   
setenv ADC_INTF "D:\Telops\FIR-00251-Proc\src\QuadADC\HDL"
setenv COMMON "D:\Telops\FIR-00251-Common\VHDL"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv PROC "D:\Telops\FIR-00251-Proc"
setenv FPA_COMMON "$COMMON_HDL\Common_Projects\TEL2000\FPA_common\src"
	   
# Package
acom -incr "$COMMON\tel2000pkg.vhd"
acom "$COMMON\iserdes\adc\fpa_serdes_define.vhd"

#common_hdl
acom -incr -nowarn DAGGEN_0523 \
"$COMMON_HDL\Utilities\SYNC_RESET.vhd" \
"$COMMON_HDL\Utilities\double_sync.vhd" \
"$COMMON_HDL\Utilities\sync_resetn.vhd" \
"$COMMON_HDL\Utilities\gen_areset.vhd" \
"$COMMON_HDL\Utilities\Clk_Divider.vhd" \
"$COMMON_HDL\Utilities\dcm_reset.vhd" \
"$COMMON_HDL\Utilities\reset_extension.vhd" \
"$COMMON_HDL\Utilities\oddr_clk_vector.vhd" \
"$COMMON_HDL\SPI\spi_rx.vhd" \
"$COMMON_HDL\SPI\spi_tx.vhd"
	   	 
acom -incr -nowarn DAGGEN_0523 \
#"$PROC\IP\afifo_w57d16\afifo_w57d16_funcsim.vhdl" \
"$COMMON\iserdes\idelay_wrapper.vhd" \
"$ADC_INTF\adc_clk7x_wrapper.vhd" \
"$COMMON\iserdes\adc\adc_iserdes_wrapper.vhd" \
"$COMMON\iserdes\delay_calibration.vhd" \
"$ADC_INTF\adc_data_sync.vhd" \
"$COMMON\iserdes\adc\test_pattern_validator.vhd" \
"$ADC_INTF\quad_adc_ctrl.vhd" \
"$ADC_INTF\adc_receiver_1ch.bde" \
"$ADC_INTF\adc_data_deserializer_8chn.bde" \
"$ADC_INTF\adc_data_deserializer.bde"
