adel -all
setactivelib work
acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_common_pkg.vhd
acom $FIR251COMMON/VHDL/iserdes/adc/fpa_serdes_define.vhd

#utilities
do $FIR251PROC/src/compil_utilities.do
do $FIR251PROC/src/Quad_serdes/HDL/build_quad_receiver.do

acom $FIR251PROC/aldec/src/afpa_quad_serdes/src/quad_receiver_tb.bde
acom $FIR251PROC/aldec/src/afpa_quad_serdes/src/TestBench/quad_receiver_tb_TB.vhd


asim -ses quad_receiver_tb_TB 



wave UUT/U12/*
-- wave UUT/U5/*

-- run 20 us
 run 30 ms
