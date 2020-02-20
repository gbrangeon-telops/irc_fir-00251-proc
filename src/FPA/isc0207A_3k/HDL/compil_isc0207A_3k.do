#savealltabs
#adel -all
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\proxy_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd
   
#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

## sources FPa common 
acom D:\Telops\FIR-00251-Common\VHDL\Utilities\native_to_axil32.vhd
do D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\compil_fpa_common.do
do D:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\compil_fastrd_common.do

# fichiers isc0207A_3k
acom  -nowarn DAGGEN_0523 -incr \
D:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_elcorr_refs_ctrl.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_clks_gen_core.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_clks_mmcm.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_digio_map.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_mblaze_intf.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_bitstream_gen.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_clks_gen.bde \
d:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_spi_feeder.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_readout_kernel.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_readout_ctrler.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_prog_ctrler.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_hw_prog.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_hw_driver.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0207A_3k\HDL\isc0207A_3k_intf.bde
 
                                            