
setactivelib work
clearlibrary headerInserter

acom $FIR251COMMON/VHDL/tel2000pkg.vhd
acom $FIR251COMMON/VHDL/img_header_define.vhd


acom $FIR251PROC/IP/sp_ram_byte_w32_d64/sp_ram_byte_w32_d64_funcsim.vhdl
acom $FIR251PROC/IP/t_axi4_lite32_w_afifo_d16/t_axi4_lite32_w_afifo_d16_funcsim.vhdl
acom $FIR251PROC/IP/t_axi4_lite32_w_afifo_d64/t_axi4_lite32_w_afifo_d64_funcsim.vhdl
acom $FIR251PROC/IP/t_axi4_stream32_sfifo_d2048/t_axi4_stream32_sfifo_d2048_funcsim.vhdl
acom $FIR251PROC/IP/fwft_sfifo_w8_d16/fwft_sfifo_w8_d16_funcsim.vhdl

do $FIR251PROC/src/Hder/hdl/compil_hder_inserter.do

##runexe "$FIR251PROC/src/copy_to_cpp.bat"
adel mb_model
cd $FIR251PROC/aldec/src/HeaderInserter/src
buildc hder_inserter.dlm
addfile mb_model.dll
addsc mb_model.dll

acom "$FIR251PROC/aldec/src/Testbench/SystemC/mb_model_wrapper.vhd"
acom $FIR251PROC/aldec/src/HeaderInserter/src/hder_inserter_top_tb.bde
acom $FIR251PROC/aldec/src/HeaderInserter/src/TestBench/hder_inserter_top_tb_TB.vhd
#

asim -ses hder_inserter_top_tb_TB 

-- add wave -noreg -hexadecimal -literal {/hder_inserter_top_tb_TB/U3/U1/MB_MOSI}

-- receveur config
#wave UUT/U3/U1/*

-- fifo header lent
-- wave UUT/U3/U1/U2/*

-- sequenceur
wave UUT/U3/U4/* 

-- fpa header fifo
-- wave UUT/U3/U3/*  

-- frame id fifo
-- wave UUT/U3/U4/U3/*

run  3 ms