#savealltabs
#adel -all
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\proxy_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd
   
#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

# sources FPa common 
acom -relax d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\ad5648_driver.vhd 
do d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\compil_fpa_common.do


# fichiers suphawk
acom  -nowarn DAGGEN_0523 -incr \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_clks_gen_core.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_clks_mmcm.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_clks_gen.bde \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_detector_ctrler.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_dig_data_reg.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_mux_ctrl_reg.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_wdw_ctrl_reg.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_wdw_data_reg.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_readout_ctrler.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_spi_tx_check.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_digio_map.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_elcorr_refs_ctrl.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_mblaze_intf.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_prog_ctrler.bde \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_hw_driver.bde \
D:\Telops\FIR-00251-Proc\src\FPA\suphawkA\HDL\suphawkA_intf.bde
 
