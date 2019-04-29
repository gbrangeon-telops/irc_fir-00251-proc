alib work
setActivelib work
	   
setenv ADC_INTF "D:\Telops\FIR-00251-Proc\src\QuadADC\HDL"
setenv COMMON "D:\Telops\FIR-00251-Common"
setenv COMMON_HDL "D:\Telops\Common_HDL"
setenv PROC "D:\Telops\FIR-00251-Proc"
setenv FPA_COMMON "$COMMON_HDL\Common_Projects\TEL2000\FPA_common\src"
	   
do D:\telops\FIR-00251-Proc\src\QuadADC\HDL\build_adc_receiver.do

acom -incr -nowarn DAGGEN_0523 \
 "$COMMON_HDL\Utilities\double_sync_vector.vhd"

acom -incr -nowarn DAGGEN_0523 \
"$FPA_COMMON\fpa_common_pkg.vhd" \
"$FPA_COMMON\spi_mux_ctler.vhd" \

acom -incr -nowarn DAGGEN_0523 \
"$PROC\src\FPA\isc0207A\HDL\FPA_define.vhd" \
"$PROC\src\FPA\isc0207A\HDL\isc0207A_clks_gen.vhd" \
"$ADC_INTF\..\debug\debug_data_sync.vhd" \
"$ADC_INTF\..\debug\adc_rcv_clk_560MHz.vhd" \
"$ADC_INTF\..\debug\adc_startup_clks.vhd" \
"$ADC_INTF\..\debug\data_sampling_dbg.vhd" \
"$ADC_INTF\..\debug\high_duration.vhd" \
"$ADC_INTF\..\debug\min_max_ctrl.vhd" \
"$ADC_INTF\..\debug\high_low_duration.bde" \
"$ADC_INTF\..\debug\adc_board_startup_top_level.bde"
