#savealltabs
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\PelicanD\HDL\fpa_define.vhd \
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
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\lut_axil_absolute_add.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calib_config.vhd \
 -relax D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calib_block_sel.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calib_param_sequencer.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\param_fifo_block.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\param_lut_fifo.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\param16_fifo.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calib_status_gen.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calib_fast_hder_gen.vhd \
 D:\Telops\FIR-00251-Proc\IP\calib_param_ram\calib_param_ram_funcsim.vhdl \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\pixel_saturation_flag.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\pixel_saturation_repl.vhd

acom -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Common\VHDL\Memory_Interface\ddr_aoi_add_gen.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\ddr_data_decoder_core.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\ddr_data_decoder.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\badpixel_replacer.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\video_ehdri_SM.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\video_freeze_SM.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\video_fwposition_SM.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\video_fwposition_Selector.bde \
 -relax D:\Telops\FIR-00251-Common\VHDL\hdr_extractor\axis16_hder_extractor.vhd \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\video_ehdri_selector.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\video_freeze.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\video_data_handler.bde \
 D:\Telops\FIR-00251-Proc\src\Calibration\HDL\calibration.bde

