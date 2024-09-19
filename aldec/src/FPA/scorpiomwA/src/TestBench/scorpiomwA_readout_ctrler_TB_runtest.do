adel -all
acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fleg_brd_define.vhd
acom $FIR251PROC/src/FPA/scorpiomwA/HDL/FPA_define.vhd
acom $FIR251PROC/src/FPA/scorpiomwA/HDL/Proxy_define.vhd 

# sources FPa common 
#acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_trig_controller.vhd
#acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/dfpa_hardw_stat_gen.vhd
#acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_intf_sequencer.vhd
#acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_status_gen.vhd
#acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/adc_brd_define.vhd

#utilities
do $FIR251PROC/src/compil_utilities.do  

#pour la simulation 

acom $FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_clks_gen.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_diag_line_gen.vhd
--acom $FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_diag_data_gen.vhd
--acom $FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_digio_map.vhd

acom $FIR251PROC/src/FPA/scorpiomwA/HDL/scorpiomwA_readout_ctrler.vhd
acom  $FIR251PROC/aldec/src/FPA/scorpiomwA/src/TestBench/scorpiomwA_readout_ctrler_TB.vhd


asim -ses scorpiomwA_readout_ctrler_TB 

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
