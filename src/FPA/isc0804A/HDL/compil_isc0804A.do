#savealltabs
#adel -all
#setactivelib work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
	$FIR251COMMON/VHDL/tel2000pkg.vhd \
	$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd \
	$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd \
	$FIR251PROC/src/FPA/isc0804A/HDL/FPA_define.vhd \
	$FIR251PROC/src/FPA/isc0804A/HDL/proxy_define.vhd \
	$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_define.vhd \
	$FIR251COMMON/VHDL/img_header_define.vhd \
	$FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd
   
#utilities
do $FIR251PROC/src/compil_utilities.do

# sources FPa common
acom $FIR251COMMON/VHDL/Utilities/native_to_axil32.vhd
do $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/compil_fpa_common.do
do $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/compil_fastrd_common.do

acom $FIR251PROC/src/FPA/scorpiomwA/HDL/sc_min_max_ctrl.vhd
acom $FIR251PROC/src/FPA/scorpiomwA/HDL/sc_high_duration.vhd
acom $FIR251PROC/src/FPA/scorpiomwA/HDL/sc_high_low_duration.bde
 
# fichiers isc0804A
acom  -nowarn DAGGEN_0523 -incr \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_clks_gen_core.vhd \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_clks_mmcm.vhd \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_digio_map.vhd \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_mblaze_intf.vhd \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_bitstream_gen.vhd \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_clks_gen.bde \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_spi_feeder.vhd \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_readout_kernel.vhd \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_elcorr_refs_ctrl.vhd \
	$FIR251COMMON/VHDL/Utilities/axis64_throughput_ctrl.vhd \
	$FIR251COMMON/VHDL/Fifo/t_axi4_stream_wr64_rd128_fifo.vhd \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_readout_ctrler.bde \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_prog_ctrler.bde \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_hw_driver.bde \
	$FIR251PROC/src/FPA/isc0804A/HDL/isc0804A_intf.bde
 
                                            