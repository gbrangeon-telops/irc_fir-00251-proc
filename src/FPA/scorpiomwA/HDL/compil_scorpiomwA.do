#savealltabs
#adel -all
#setactivelib work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 $FIR251COMMON/VHDL/tel2000pkg.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fastrd2/fastrd2_define.vhd \
 $FIR251PROC/src/FPA/scorpiomwA/HDL/FPA_define.vhd \
 $FIR251PROC/src/FPA/scorpiomwA/HDL/proxy_define.vhd \
 $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_define.vhd \
 $FIR251COMMON/VHDL/img_header_define.vhd \
 $FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd
   
#utilities
do $FIR251PROC/src/compil_utilities.do

# sources FPA common 
acom -relax $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/ad5648_driver.vhd 
do $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/compil_fpa_common.do
do $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fastrd2/compil_fastrd2_common.do

# fichiers scorpiomwA
acom  -nowarn DAGGEN_0523 -incr \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_clks_gen_core.vhd \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_clks_mmcm.vhd \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_digio_map.vhd \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_window_reg.vhd \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_readout_kernel.vhd \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_clks_gen.bde \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_prog_spi_feeder.vhd \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_mblaze_intf.vhd \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_prog_ctrler.bde \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_readout_ctrler.bde \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_hw_driver.bde \
$FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_intf.bde
