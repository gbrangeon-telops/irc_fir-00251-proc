#savealltabs
#adel -all
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\proxy_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd
   
#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

# sources FPa common
acom D:\Telops\FIR-00251-Common\VHDL\Utilities\native_to_axil32.vhd
do D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\compil_fpa_common.do
do D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\compil_fastrd_common.do

acom D:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\sc_min_max_ctrl.vhd
acom D:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\sc_high_duration.vhd
acom D:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\sc_high_low_duration.bde
 
# fichiers isc0804A
acom  -nowarn DAGGEN_0523 -incr \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_clks_gen_core.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_clks_mmcm.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_digio_map.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_mblaze_intf.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_bitstream_gen.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_clks_gen.bde \
d:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_spi_feeder.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_readout_kernel.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_elcorr_refs_ctrl.vhd \
D:\Telops\FIR-00251-Common\VHDL\Utilities\axis64_throughput_ctrl.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_readout_ctrler.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_prog_ctrler.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_hw_driver.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0804A\HDL\isc0804A_intf.bde
 
                                            