-- setactivelib work
-- clearlibrary fir_00251
-- clearlibrary work


-- acom $FIR251COMMON/VHDL/tel2000pkg.vhd 

#Utilities
-- do $FIR251PROC/src/compil_utilities.do

acom $FIR251PROC/src/Irig/HDL/IRIG_define_v2.vhd 

-- reset long
acom $FIR251PROC/src/Irig/HDL/irig_reset_v2.vhd

-- conditionneur
acom -nowarn DAGGEN_0523 \
 $FIR251PROC/src/Irig/HDL/irig_clock_detector_v2.vhd \
 $FIR251PROC/src/Irig/HDL/ad747x_driver.vhd \
 $FIR251PROC/src/Irig/HDL/adc_sample_counter_v2.vhd \
 $FIR251PROC/src/Irig/HDL/adc_sample_sel_v2.vhd \
 $FIR251PROC/src/Irig/HDL/adc_sample_averaging_v2.vhd \
 $FIR251PROC/src/Irig/HDL/channel_gain_ctler_v2.vhd \
 $FIR251PROC/src/Irig/HDL/adc_sample_en_v2.vhd \
 $FIR251PROC/src/Irig/HDL/irig_signal_conditioner_v2.bde

-- horloges internes
acom $FIR251PROC/src/Irig/HDL/irig_refclk_generator_v2.vhd 

-- decodeur alphabet
acom -nowarn DAGGEN_0523 \
 $FIR251PROC/src/Irig/HDL/irig_comparator_v2.vhd \
 $FIR251PROC/src/Irig/HDL/irig_threshold_gen_v2.vhd \
 $FIR251PROC/src/Irig/HDL/LL8_Fanout2_v2.vhd \
 $FIR251PROC/src/Irig/HDL/irig_alphab_detector_v2.vhd \
 $FIR251PROC/src/Irig/HDL/irig_alphab_decoder_ctrl_v2.vhd \
 $FIR251PROC/src/Irig/HDL/irig_alphab_decoder_v2.bde

-- decodeur de trame
acom $FIR251PROC/src/Irig/HDL/irig_frame_decoder_v2.vhd  

-- contrôleur
acom -nowarn DAGGEN_0523 \
 $FIR251PROC/src/Irig/HDL/irig_controller_v2.vhd \
 $FIR251PROC/src/Irig/HDL/irig_mb_intf.vhd \
 $FIR251PROC/src/Irig/HDL/expb_irig_v2.bde

-- acom  $COMMON_HDL/SPI/ad7478_driver_v2.vhd
-- acom $FIR251PROC/src/Irig/HDL/ad7478_driver_TB_v2.vhd

