#savealltabs
#adel -all
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd \
 D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fastrd2\fastrd2_define.vhd \
  D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\FPA_define.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\proxy_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd
   
#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

# sources FPA common
acom D:\Telops\FIR-00251-Common\VHDL\Utilities\native_to_axil32.vhd
do D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\compil_fpa_common.do
do D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fastrd2\compil_fastrd2_common.do	 

# source PLL DRP Controler
do D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\pll_drp_ctrler\compile_pll_drp_ctrler.do

#acom D:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\sc_min_max_ctrl.vhd
#acom D:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\sc_high_duration.vhd
#acom D:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\sc_high_low_duration.bde
 
# fichiers isc0804A_2k
acom  -nowarn DAGGEN_0523 -incr \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_clks_gen_core.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_clks_mmcm.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_digio_map.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_mblaze_intf.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_bitstream_gen.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_clks_gen.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_spi_feeder.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_elcorr_refs_ctrl.vhd \
D:\Telops\FIR-00251-Common\VHDL\Utilities\axis64_throughput_ctrl.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_prog_ctrler.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_readout_kernel.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_readout_ctrler.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_hw_driver.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A_2k\HDL\isc0804A_2k_intf.bde
 
                                            