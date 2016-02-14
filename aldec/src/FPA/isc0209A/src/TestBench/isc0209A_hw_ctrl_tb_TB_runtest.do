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
do D:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\compil_isc0209A.do 

#pour la simulation
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w3_d16\fwft_sfifo_w3_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\sfifo_w10_d256\sfifo_w10_d256_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w8_d64\fwft_sfifo_w8_d64_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w56_d16\fwft_sfifo_w56_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_afifo_w62_d16\fwft_afifo_w62_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w72_d16\fwft_sfifo_w72_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w33_d16\fwft_sfifo_w33_d16_funcsim.vhdl
acom D:\Telops\FIR-00251-Proc\IP\fwft_sfifo_w76_d16\fwft_sfifo_w76_d16_funcsim.vhdl


acom d:\Telops\FIR-00251-Proc\src\FPA\isc0209A\HDL\isc0209A_clks_gen.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_diag_line_gen.vhd
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\isc0209A\src\TestBench\isc0209A_dummy.vhd
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\isc0209A\src\isc0209a_hw_ctrl_tb.bde
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\isc0209A\src\TestBench\isc0209a_hw_ctrl_tb_TB.vhd


asim -ses isc0209a_hw_ctrl_tb_TB 


-- mb interface
--wave UUT/U4/*

-- afpa_hw_driver_ctrler
--wave UUT/U5/U4/*

-- dac ctrler 
--wave UUT/U5/U3/U2/* 

-- dac spi 
--wave UUT/U5/U3/U1/*
  
  -- fpa_ ctler
--wave UUT/U5/U2/U2/*
  
   -- fpa_ ctler
--wave UUT/U5/U2/U5/*
 
 
-- isc0209A_digio_map
--wave UUT/U19/*                 
                  
-- diag dval gen
--wave UUT/U3/* 
wave UUT/U9/U1/U1/*

-- diag dval gen
--wave UUT/U9/U2/U1/*

--wave UUT/U9/U18/* 

-- integration
--wave UUT/U5/U1/* 

--wave UUT/U5/U4/*

-- diag data gen
--wave UUT/U9/U2/U4/* 
 
run 10 ms