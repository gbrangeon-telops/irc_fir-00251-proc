adel -all
acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd
acom $FIR251PROC/src/FPA/hawkA/HDL/FPA_define.vhd
acom $FIR251PROC/src/FPA/hawkA/HDL/Proxy_define.vhd 

# sources FPa common 
#acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_trig_controller.vhd
#acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/dfpa_hardw_stat_gen.vhd
#acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_intf_sequencer.vhd
#acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_status_gen.vhd
#acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_define.vhd

#utilities
do $FIR251PROC/src/compil_utilities.do  
do $FIR251PROC/src/FPA/hawkA/HDL/compil_hawkA.do 

#pour la simulation
acom $FIR251PROC/IP/fwft_sfifo_w3_d16/fwft_sfifo_w3_d16_funcsim.vhdl
acom $FIR251PROC/IP/sfifo_w10_d256/sfifo_w10_d256_funcsim.vhdl
acom $FIR251PROC/IP/fwft_sfifo_w8_d64/fwft_sfifo_w8_d64_funcsim.vhdl
acom $FIR251PROC/IP/fwft_sfifo_w56_d16/fwft_sfifo_w56_d16_funcsim.vhdl
acom $FIR251PROC/IP/fwft_afifo_w62_d16/fwft_afifo_w62_d16_funcsim.vhdl
acom $FIR251PROC/IP/fwft_sfifo_w72_d16/fwft_sfifo_w72_d16_funcsim.vhdl
acom $FIR251PROC/IP/fwft_sfifo_w33_d16/fwft_sfifo_w33_d16_funcsim.vhdl
acom $FIR251PROC/IP/fwft_sfifo_w76_d256/fwft_sfifo_w76_d256_funcsim.vhdl

--acom $FIR251PROC/src/FPA/hawkA/HDL/hawkA_clks_gen.vhd
--acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_diag_line_gen.vhd
acom $FIR251PROC/aldec/src/FPA/hawkA/src/TestBench/hawka_hw_ctrl_tb_TB.vhd


asim -ses hawka_hw_ctrl_tb_TB 


-- mb interface
--wave UUT/U4/*

-- afpa_hw_driver_ctrler
--wave UUT/U5/U4/*

-- dac ctrler 
--wave UUT/U5/U3/U2/* 

-- dac spi 
--wave UUT/U5/U3/U1/*
  
  -- fpa_ ctler
--wave UUT/U5/U2/U6/*
  
   -- fpa_ ctler
--wave UUT/U5/U2/U5/*
 
 
-- hawkA_digio_map
--wave UUT/U19/* 


-- clocks gen
--wave UUT/U26/* 
                  
-- diag dval gen
--wave UUT/U3/* 

-- diag dval gen
--wave UUT/U9/U5/* 

--wave UUT/U9/U3/* 
                  
wave UUT/U5/U5/*                 
run 10 ms