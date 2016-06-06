adel -all
acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd
acom d:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fleg_brd_define.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\FPA_define.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\Proxy_define.vhd 

# sources FPa common 
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_trig_controller.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\dfpa_hardw_stat_gen.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_intf_sequencer.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_status_gen.vhd
#acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\adc_brd_define.vhd

#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do  
do d:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\compil_scorpiomwA.do
#pour la simulation 


#pour la simulation
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w3_d16\fwft_sfifo_w3_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\sfifo_w10_d256\sfifo_w10_d256_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w8_d256\fwft_sfifo_w8_d256_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w56_d256\fwft_sfifo_w56_d256_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_afifo_w62_d16\fwft_afifo_w62_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w72_d16\fwft_sfifo_w72_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w33_d16\fwft_sfifo_w33_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w76_d16\fwft_sfifo_w76_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\scorpiomwA_10MHz_mmcm\scorpiomwA_10MHz_mmcm_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\scorpiomwA_15MHz_mmcm\scorpiomwA_15MHz_mmcm_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\scorpiomwA_18MHz_mmcm\scorpiomwA_18MHz_mmcm_funcsim.vhdl 
acom D:\Telops\FIR-00251-Proc\IP\scorpiomwA_17MHz_mmcm\scorpiomwA_17MHz_mmcm_funcsim.vhdl

acom d:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\scorpiomwA_readout_ctrler.vhd
acom  d:\Telops\FIR-00251-Proc\aldec\src\FPA\scorpiomwA\src\TestBench\scorpiomwA_readout_ctrler_TB.vhd


asim -ses scorpiomwA_readout_ctrler_TB 

-- diag gen
--wave UUT/U2/* 

-- diag gen
--wave UUT/U2/Udbg/*

-- dval gen
wave UUT/*
wave -noreg samp_cnt

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
                     
run 13 ms
