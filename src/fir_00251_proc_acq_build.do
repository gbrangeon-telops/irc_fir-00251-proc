#alib work
#SetActiveLib -work

setenv FIR251PROC "D:\Telops\FIR-00251-PROC"
setenv COMMON "D:\Telops\FIR-00251-Common"
    
# Compile Common Section
do "$COMMON\compile_all_common.do"

#MGT
#do  "D:\Telops\FIR-00251-Common\VHDL\MGT\Hdl\compile_data_mgt_rtl.do"
#do  "D:\Telops\FIR-00251-Common\VHDL\MGT\Hdl\compile_exp_mgt_rtl.do"
#do  "D:\Telops\FIR-00251-Common\VHDL\MGT\Hdl\compile_video_mgt_rtl.do"
#acom  "D:\Telops\FIR-00251-Common\VHDL\MGT\Hdl\data_mgt_cdc_sync_exdes.vhd"
#acom  "D:\Telops\FIR-00251-Common\VHDL\MGT\Hdl\data_mgt_clock_module.vhd"
#acom  "D:\Telops\FIR-00251-Common\VHDL\MGT\Hdl\data_mgt_gt_common_wrapper.vhd"
#acom  "D:\Telops\FIR-00251-Common\VHDL\MGT\Hdl\data_mgt_support_reset_logic.vhd"
#acom  "D:\Telops\FIR-00251-Common\VHDL\MGT\Hdl\exp_mgt_cdc_sync_exdes.vhd"
#acom  "D:\Telops\FIR-00251-Common\VHDL\MGT\Hdl\exp_mgt_clock_module.vhd"
#acom  "D:\Telops\FIR-00251-Common\VHDL\MGT\Hdl\exp_mgt_gt_common_wrapper.vhd"
#acom  "D:\Telops\FIR-00251-Common\VHDL\MGT\Hdl\exp_mgt_support_reset_logic.vhd"
acom  "$COMMON\VHDL\MGT\Hdl\mgt_block.bde"
acom  "$COMMON\VHDL\MGT\Hdl\mgt_wrapper.bde"

#Utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

#EXP time
do D:\Telops\FIR-00251-Proc\src\ExposureTime\hdl\compil_exposure_time.do

#HDER Inserter
do D:\Telops\FIR-00251-Proc\src\Hder\hdl\compil_hder_inserter.do

#TRIG gen
do D:\Telops\FIR-00251-Proc\src\Trig\hdl\compil_trig_gen.do

#USB
acom  "$FIR251PROC\src\usb\hdl\USB_CTRL.bde"

#FPGA_COMM
acom  "$FIR251PROC\src\fpga_comm\hdl\FPGA_COMM.bde"

#FAN MANAGER
#do "D:\Telops\FIR-00251-Common\VHDL\PWM_CTRL\hdl\compile_pwm.do"

#IRIG
do D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_compile.do

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

#AEC
do D:\Telops\FIR-00251-Proc\src\AEC\HDL\build_AEC_intf.do

#ICU
do D:\Telops\FIR-00251-Proc\src\ICU\HDL\build_ICU.do

#Buffering
do D:\Telops\FIR-00251-Proc\src\Buffering\HDL\build_buffering_intf.do
								 
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
#acom  "$FIR251PROC\xilinx\scorpiolwD\fir_00251_proc_scorpiolwD.srcs\sources_1\bd\core\hdl\core.vhd"
#acom  "$FIR251PROC\xilinx\pelicanD\fir_00251_proc_pelicanD.srcs\sources_1\bd\core\hdl\core_wrapper.vhd"
acom  "$FIR251PROC\src\BD\bd_wrapper.vhd" 

#top
acom  "$FIR251PROC\src\fir_00251_proc_acq.bde"
