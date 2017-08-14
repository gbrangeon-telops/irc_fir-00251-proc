#savealltabs
#adel -all
#SetActiveLib -work
#clearlibrary 	

#packages
acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\proxy_define.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd \
 d:\Telops\FIR-00251-Common\VHDL\iserdes\adc\fpa_serdes_define.vhd
   
#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

# sources FPa common 
acom -relax d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\ad5648_driver.vhd 
do d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\compil_fpa_common.do


# fichiers hawk
acom  -nowarn DAGGEN_0523 -incr \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_clks_gen_core.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_clks_mmcm.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_clks_gen.bde \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_detector_ctrler.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_dig_data_reg.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_mux_ctrl_reg.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_windowing_ctrl_reg.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_windowing_data_reg.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_readout_ctrler.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_spi_tx_check.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_digio_map.vhd \
d:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_mblaze_intf.vhd \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_prog_ctrler.bde \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_hw_driver.bde \
D:\Telops\FIR-00251-Proc\src\FPA\hawkA\HDL\hawkA_intf.bde
 
