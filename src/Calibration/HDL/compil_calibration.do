#savealltabs
#setactivelib work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 \
 $FIR251COMMON/VHDL/tel2000pkg.vhd \
 $FIR251COMMON/VHDL/img_header_define.vhd \
 $FIR251COMMON/VHDL/Calibration/calib_define.vhd 

acom -nowarn DAGGEN_0523 \
 $FIR251PROC/src/Calibration/HDL/axil_channels_ctrl.vhd \
 $FIR251PROC/src/Calibration/HDL/calib_config.vhd \
 -relax $FIR251PROC/src/Calibration/HDL/calib_block_sel.vhd \
 $FIR251PROC/src/Calibration/HDL/calib_param_sequencer.vhd \
 $FIR251PROC/src/Calibration/HDL/param_fifo_block.bde \
 $FIR251PROC/src/Calibration/HDL/param_sync_to_axis32.vhd \
 $FIR251PROC/src/Calibration/HDL/param16_fifo.vhd \
 $FIR251PROC/src/Calibration/HDL/calib_status_gen.vhd \
 $FIR251PROC/src/Calibration/HDL/calib_fast_hder_gen.vhd \
 $FIR251PROC/src/Calibration/HDL/pixel_saturation_flag.vhd \
 $FIR251PROC/src/Calibration/HDL/pixel_saturation_repl.vhd \
 $FIR251PROC/src/Calibration/HDL/pixel_negative_flag.vhd \
 $FIR251PROC/src/Calibration/HDL/pixel_bpr_flag.vhd \
 $FIR251COMMON/VHDL/Utilities/pixel_bad_repl.vhd \
 $FIR251COMMON/VHDL/Utilities/axis32_reg_wrap.vhd \
 $FIR251COMMON/VHDL/Math/native_fi32tofp32.vhd \
 $FIR251COMMON/VHDL/Math/native_fp32_mult.vhd \
 $FIR251COMMON/VHDL/Math/axis_fi32tou32.vhd  
 
acom -nowarn DAGGEN_0523 -2008 \
 $FIR251PROC/src/Calibration/HDL/calib_aoi_align.vhd
 
acom -nowarn DAGGEN_0523 \
 $FIR251PROC/src/Calibration/HDL/ddr_aoi_add_gen.vhd \
 $FIR251PROC/src/Calibration/HDL/ddr_data_decoder_core.vhd \
 $FIR251PROC/src/Calibration/HDL/ddr_data_decoder.bde \
 $FIR251PROC/src/Calibration/HDL/badpixel_replacer64.vhd \
 $FIR251PROC/src/Calibration/HDL/NLC.bde \
 $FIR251PROC/src/Calibration/HDL/FSU.bde \
 $FIR251PROC/src/Calibration/HDL/RQC.bde \
 $FIR251PROC/src/Calibration/HDL/FCC.bde \
 $FIR251PROC/src/Calibration/HDL/CFF.bde \
 $FIR251PROC/src/Calibration/HDL/calibration_common.bde \
 $FIR251PROC/src/Calibration/HDL/calibration_core.bde \
 $FIR251PROC/src/Calibration/HDL/calibration.bde

