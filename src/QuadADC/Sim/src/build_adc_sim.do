alib work
setActivelib work

setenv ADC_INTF_ROOT "D:\Telops\FIR-00251-Proc\src\QuadADC\"
setenv COMMON_HDL "D:\Telops\Common_HDL"
acom "$COMMON_HDL\SPI\spi_rx.vhd"
acom "$COMMON_HDL\SPI\spi_tx.vhd"
acom "$COMMON_HDL\SPI\spi_slave.vhd"
acom "$COMMON_HDL\Utilities\sync_reset.vhd"

--do "$ADC_INTF_ROOT\HDL\build_adc_receiver.do"

acom -incr -nowarn DAGGEN_0523 \
"$ADC_INTF_ROOT\Sim\src\adc_model.vhd" \
"$ADC_INTF_ROOT\Sim\src\tb_clocks.vhd" \
"$ADC_INTF_ROOT\Sim\src\adc_ctrl_sm.vhd" \
"$ADC_INTF_ROOT\Sim\src\data_gen.vhd" \
"$ADC_INTF_ROOT\Sim\src\adc_tb_stim_top_level.bde" \
"$ADC_INTF_ROOT\Sim\src\adc_tb_4ch_top_level.bde" \
"$ADC_INTF_ROOT\Sim\src\adc_cfg_tb_top_level.bde" \
"$ADC_INTF_ROOT\Sim\src\adc_deser_tb_top_level.bde"
