#alib work
#SetActiveLib -work

setenv FIR251PROC "D:\Telops\FIR-00251-PROC"
setenv COMMON "D:\Telops\FIR-00251-Common"
    
# Compile Common Section
do "$COMMON\compile_all_common.do"
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

#MGT 
do D:\Telops\FIR-00251-Proc\src\MGT\HDL\compil_mgt.do

#EXP time
do D:\Telops\FIR-00251-Proc\src\ExposureTime\hdl\compil_exposure_time.do

#HDER Inserter
do D:\Telops\FIR-00251-Proc\src\Hder\hdl\compil_hder_inserter.do

#TRIG gen
do D:\Telops\FIR-00251-Proc\src\Trig\hdl\compil_trig_gen.do

#USB
acom  "$FIR251PROC\src\usb\hdl\USB_CTRL.bde"

#IRIG
do D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_compile.do

#AEC
do D:\Telops\FIR-00251-Proc\src\AEC\HDL\build_AEC_intf.do

#calibration
do D:\Telops\FIR-00251-Proc\src\Calibration\HDL\compil_calibration.do

#flash intf
acom \
D:\Telops\FIR-00251-Proc\src\Flash_Ctrl\HDL\flash_ctrl.vhd \
D:\Telops\FIR-00251-Proc\src\Flash_Ctrl\HDL\flash_output.vhd \
D:\Telops\FIR-00251-Proc\src\Flash_Ctrl\HDL\flash_process.vhd \
D:\Telops\FIR-00251-Proc\src\Flash_Ctrl\HDL\Flash_intf.bde

#USART
do "$COMMON\VHDL\USART\build_usart.do"


#ICU
do D:\Telops\FIR-00251-Proc\src\ICU\HDL\build_ICU.do

#ADC Readout
do D:\telops\FIR-00251-Proc\src\ADCReadout\HDL\build_adc_readout.do

#Buffering
do D:\Telops\FIR-00251-Proc\src\Buffering\HDL\build_buffering_intf.do
	
# Frame buffer
do D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\build_frame_buffer.do  
#EHDRI
do D:\Telops\FIR-00251-Proc\src\eHDRI\HDL\build_ehdri_intf.do

#Flagging
do D:\Telops\FIR-00251-Proc\src\Flagging\HDL\flagging_compile.do

#Gating
do D:\Telops\FIR-00251-Proc\src\Gating\HDL\gating_compile.do

#SFW
do D:\Telops\FIR-00251-Proc\src\SFW\HDL\build_SFW.do 

#Startup Hardware
acom D:\Telops\FIR-00251-Proc\src\startup\HDL\Startup_HW_Test.vhd -relax

#CORE
acom  "$FIR251PROC\src\BD\bd_wrapper.vhd" 

#top
acom  "$FIR251PROC\src\fir_00251_proc_acq.bde"
