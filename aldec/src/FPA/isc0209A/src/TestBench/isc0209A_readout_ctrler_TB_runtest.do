adel -all
acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd
acom d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\FPA_define.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\Proxy_define.vhd 

# sources FPa common 
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_trig_controller.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\dfpa_hardw_stat_gen.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_intf_sequencer.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_status_gen.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd

#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do  

#pour la simulation 

acom d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_clks_gen.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_diag_line_gen.vhd
--acom d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_diag_data_gen.vhd
--acom d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_digio_map.vhd

acom d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_readout_ctrler.vhd
acom  d:\Telops\FIR-00251-Proc\aldec\src\FPA\isc0209A\src\TestBench\isc0209A_readout_ctrler_TB.vhd


asim -ses isc0209A_readout_ctrler_TB 

-- diag gen
--wave UUT/U2/* 

-- diag gen
--wave UUT/U2/Udbg/*

-- dval gen
wave UUT/*

--wave UUT/U6/*

-- data dispatcher
--wave UUT/U18/* 

-- sample counter
--wave UUT/U22/*

-- sample selection
--wave UUT/U7/*

-- sample sum
--wave UUT/U23/* 

-- sample mean
--wave UUT/U28/*

-- data reorder
--wave UUT/U12/*
                     
run 10 ms
