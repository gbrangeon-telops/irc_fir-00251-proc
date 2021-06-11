#savealltabs
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\Calibration\calib_define.vhd

#calibration
acom -nowarn DAGGEN_0523 \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\NLC.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\FSU.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\RQC.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\FCC.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\CFF.bde 

acom -nowarn DAGGEN_0523 \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\axil_channels_ctrl.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calib_config.vhd \
 -relax D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calib_block_sel.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calib_param_sequencer.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\param_fifo_block.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\param16_fifo.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calib_status_gen.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calib_fast_hder_gen.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\pixel_saturation_flag.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\pixel_saturation_repl.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\pixel_bpr_flag.vhd \
 D:\Telops\FIR-00251-Common\VHDL\Utilities\pixel_bad_repl.vhd \
 D:\Telops\FIR-00251-Common\VHDL\Math\axis_fi32tou32.vhd  
 


acom -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\Calibration\HDL\ddr_aoi_add_gen.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\ddr_data_decoder_core.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\ddr_data_decoder.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\badpixel_replacer64.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calibration_common.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calibration_core.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calibration.bde

