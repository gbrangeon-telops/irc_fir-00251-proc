--SetActiveLib -work
--clearlibrary fir_00251
--clearlibrary work


--acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd 

#Utilities
--do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

acom D:\Telops\FIR-00251-Proc\src\Irig\HDL\IRIG_define_v2.vhd 

-- reset long
acom D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_reset_v2.vhd

-- conditionneur
acom -nowarn DAGGEN_0523 \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_clock_detector_v2.vhd \
 d:\Telops\FIR-00251-Proc\src\Irig\HDL\ad747x_driver.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\adc_sample_counter_v2.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\adc_sample_sel_v2.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\adc_sample_averaging_v2.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\channel_gain_ctler_v2.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\adc_sample_en_v2.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_signal_conditioner_v2.bde

-- horloges internes
acom D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_refclk_generator_v2.vhd 

-- decodeur alphabet
acom -nowarn DAGGEN_0523 \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_comparator_v2.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_threshold_gen_v2.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\LL8_Fanout2_v2.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_alphab_detector_v2.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_alphab_decoder_ctrl_v2.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_alphab_decoder_v2.bde

-- decodeur de trame
acom D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_frame_decoder_v2.vhd  

-- contrôleur
acom -nowarn DAGGEN_0523 \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_controller_v2.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_mb_intf.vhd \
 D:\Telops\FIR-00251-Proc\src\Irig\HDL\expb_irig_v2.bde

--acom  d:\Telops\Common_HDL\SPI\ad7478_driver_v2.vhd
--acom D:\Telops\FIR-00251-Proc\src\Irig\HDL\ad7478_driver_TB_v2.vhd

