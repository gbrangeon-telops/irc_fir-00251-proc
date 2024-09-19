#alib work
#setactivelib work

#get root directory relative to this file
set current_file_location_absolute_path [file normalize [file dirname [info script]]]
set parts [file split $current_file_location_absolute_path]
setenv root_location_absolute_path [file join {*}[lrange $parts 0 end-2]]

setenv FIR251PROC "$root_location_absolute_path/irc_fir-00251-proc/"
setenv FIR251COMMON "$root_location_absolute_path/irc_fir-00251-common/"
    
# Compile Common Section
do "$FIR251COMMON/compile_all_common.do"
do "$FIR251PROC/src/compil_utilities.do"

#MGT 
do "$FIR251PROC/src/MGT/HDL/compil_mgt.do"

#EXP time
do "$FIR251PROC/src/ExposureTime/hdl/compil_exposure_time.do"

#HDER Inserter
do "$FIR251PROC/src/Hder/hdl/compil_hder_inserter.do"

#TRIG gen
do "$FIR251PROC/src/Trig/hdl/compil_trig_gen.do"

#USB
acom  "$FIR251PROC/src/usb/hdl/USB_CTRL.bde"

#IRIG
do "$FIR251PROC/src/Irig/HDL/irig_compile.do"

#AEC
do "$FIR251PROC/src/AEC/HDL/build_AEC_intf.do"

#calibration
do "$FIR251PROC/src/Calibration/HDL/compil_calibration.do"

#flash intf
acom \
$FIR251PROC/src/Flash_Ctrl/HDL/flash_ctrl.vhd \
$FIR251PROC/src/Flash_Ctrl/HDL/flash_output.vhd \
$FIR251PROC/src/Flash_Ctrl/HDL/flash_process.vhd \
$FIR251PROC/src/Flash_Ctrl/HDL/Flash_intf.bde

#USART
do "$FIR251COMMON/VHDL/USART/build_usart.do"


#ICU
do "$FIR251PROC/src/ICU/HDL/build_ICU.do"

#ADC Readout
do "$FIR251PROC/src/ADCReadout/HDL/build_adc_readout.do"

#Buffering
do "$FIR251PROC/src/Buffering/HDL/build_buffering_intf.do"
	
# Frame buffer
do "$FIR251PROC/src/FrameBuffer/HDL/build_frame_buffer.do"  
#EHDRI
do "$FIR251PROC/src/eHDRI/HDL/build_ehdri_intf.do"

#Flagging
do "$FIR251PROC/src/Flagging/HDL/flagging_compile.do"

#Gating
do "$FIR251PROC/src/Gating/HDL/gating_compile.do"

#SFW
do "$FIR251PROC/src/SFW/HDL/build_SFW.do" 

#Startup Hardware
acom $FIR251PROC/src/startup/HDL/Startup_HW_Test.vhd -relax

#CORE
acom  "$FIR251PROC/src/BD/bd_wrapper.vhd" 

#top
acom  "$FIR251PROC/src/fir_00251_proc_acq.bde"
