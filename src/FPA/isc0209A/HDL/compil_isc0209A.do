#savealltabs
#adel -all
#setactivelib work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
	$FIR251COMMON/VHDL/tel2000pkg.vhd \
	$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd \
	$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd \
	$FIR251PROC/src/FPA/isc0209A/HDL/FPA_define.vhd \
	$FIR251PROC/src/FPA/isc0209A/HDL/proxy_define.vhd \
	$COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_define.vhd \
	$FIR251COMMON/VHDL/img_header_define.vhd \
	$FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd
   
#utilities
do $FIR251PROC/src/compil_utilities.do

# sources FPa common 
acom -relax $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/ad5648_driver.vhd 
do $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/compil_fpa_common.do


# fichiers isc0209A
acom  -nowarn DAGGEN_0523 -incr \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_clks_gen_core.vhd \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_clks_mmcm.vhd \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_clks_gen.bde \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_readout_ctrler.vhd \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_digio_map.vhd \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_mblaze_intf.vhd \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_mode_reg.vhd \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_window_reg.vhd \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_prog_mux.vhd \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_prog_spi_feeder.vhd \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_prog_ctrler.bde \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_hw_driver.bde \
	$FIR251PROC/src/FPA/isc0209A/HDL/isc0209A_intf.bde
	 
                                            