#savealltabs
#adel -all
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\proxy_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd
   
#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

# sources FPa common 
acom -relax d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\ad5648_driver.vhd 
do d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\compil_fpa_common.do


# fichiers isc0209A
acom  -nowarn DAGGEN_0523 -incr \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_clks_gen_core.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_clks_mmcm.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_clks_gen.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_readout_ctrler.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_digio_map.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_mblaze_intf.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_mode_reg.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_window_reg.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_prog_mux.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_prog_spi_feeder.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_prog_ctrler.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_hw_driver.bde \
D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_intf.bde
 
                                            