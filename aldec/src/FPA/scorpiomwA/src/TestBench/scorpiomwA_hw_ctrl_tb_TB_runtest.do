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


#pour la simulation
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w3_d16\fwft_sfifo_w3_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\sfifo_w10_d256\sfifo_w10_d256_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w8_d64\fwft_sfifo_w8_d64_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w56_d16\fwft_sfifo_w56_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_afifo_w62_d16\fwft_afifo_w62_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w72_d16\fwft_sfifo_w72_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w33_d16\fwft_sfifo_w33_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w76_d16\fwft_sfifo_w76_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\scorpiomwA_10MHz_mmcm\scorpiomwA_10MHz_mmcm_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\scorpiomwA_15MHz_mmcm\scorpiomwA_15MHz_mmcm_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\scorpiomwA_18MHz_mmcm\scorpiomwA_18MHz_mmcm_funcsim.vhdl 

do D:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\compil_scorpiomwA.do 

--acom d:\Telops\FIR-00251-Proc\src\FPA\scorpiomwA\HDL\scorpiomwA_clks_gen.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_diag_line_gen.vhd
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\scorpiomwA\src\scorpiomwa_hw_ctrl_tb.bde
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\scorpiomwA\src\TestBench\scorpiomwa_hw_ctrl_tb_TB.vhd


asim -ses scorpiomwa_hw_ctrl_tb_TB 


-- mb interface
--wave UUT/U4/*
  
  -- fpa_ ctler
--wave UUT/U5/U2/U3/*
  
   -- readout controller
wave UUT/U5/U5/*
 
 
-- scorpiomwA_digio_map
--wave UUT/U19/* 


-- scorpiomwA_digio_map
--wave UUT/U19/* 

-- readout controller
--wave UUT/U9/U1/U1/*
 
run 20 ms