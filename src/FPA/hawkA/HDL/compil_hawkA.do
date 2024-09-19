#savealltabs
#adel -all
#setactivelib work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 $FIR251COMMON/VHDL/tel2000pkg.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd \
 $FIR251PROC/src/FPA/hawkA/HDL/FPA_define.vhd \
 $FIR251PROC/src/FPA/hawkA/HDL/proxy_define.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_define.vhd \
 $FIR251COMMON/VHDL/img_header_define.vhd \
 $FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd
   
#utilities
do $FIR251PROC/src/compil_utilities.do

# sources FPa common 
acom -relax $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/ad5648_driver.vhd 
do $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/compil_fpa_common.do


# fichiers hawk
acom  -nowarn DAGGEN_0523 -incr \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_clks_gen_core.vhd \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_clks_mmcm.vhd \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_clks_gen.bde \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_detector_ctrler.vhd \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_dig_data_reg.vhd \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_mux_ctrl_reg.vhd \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_windowing_ctrl_reg.vhd \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_windowing_data_reg.vhd \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_readout_ctrler.vhd \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_spi_tx_check.vhd \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_digio_map.vhd \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_mblaze_intf.vhd \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_prog_ctrler.bde \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_hw_driver.bde \
$FIR251PROC/src/FPA/hawkA/HDL/hawkA_intf.bde
 
