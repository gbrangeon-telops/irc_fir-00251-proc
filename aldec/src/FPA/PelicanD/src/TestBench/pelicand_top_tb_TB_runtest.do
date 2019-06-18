
SetActiveLib -work
clearlibrary pelicanD

acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd
acom D:\Telops\FIR-00251-Common\VHDL\img_header_define.vhd

acom d:\Telops\FIR-00251-Proc\IP\160\fwft_afifo_w28_d16\fwft_afifo_w28_d16_sim_netlist.vhdl
--acom d:\Telops\FIR-00251-Proc\IP\160\fwft_sfifo_w28_d16\fwft_sfifo_w28_d16_sim_netlist.vhdl
acom d:\Telops\FIR-00251-Proc\IP\160\fwft_sfifo_w32_d16\fwft_sfifo_w32_d16_sim_netlist.vhdl
--acom d:\Telops\FIR-00251-Proc\IP\160\fwft_sfifo_w33_d16\fwft_sfifo_w33_d16_sim_netlist.vhdl
--acom d:\Telops\FIR-00251-Proc\IP\160\tdp_ram_w8_d2048\tdp_ram_w8_d2048_sim_netlist.vhdl
--acom d:\Telops\FIR-00251-Proc\IP\160\axi_uartlite_100MHz_921600\axi_uartlite_100MHz_921600_sim_netlist.vhdl
acom d:\Telops\FIR-00251-Proc\IP\160\t_axi4_stream32_sfifo_d2048\t_axi4_stream32_sfifo_d2048_sim_netlist.vhdl
acom d:\Telops\FIR-00251-Proc\IP\160\t_axi4_stream32_afifo_d512\t_axi4_stream32_afifo_d512_sim_netlist.vhdl
acom d:\Telops\FIR-00251-Proc\IP\160\sfifo_w8_d64\sfifo_w8_d64_sim_netlist.vhdl
--acom d:\Telops\FIR-00251-Proc\IP\160\sfifo_w8_d16\sfifo_w8_d16_sim_netlist.vhdl

do D:\Telops\FIR-00251-Proc\src\FPA\PelicanD\hdl\compil_PelicanD.do

#runexe "d:/telops/fir-00251-Proc/src/copy_to_cpp.bat"
#adel mb_model
#cd D:\Telops\FIR-00251-Proc\aldec\src\FPA\PelicanD\src
#buildc PelicanD.dlm
#addfile mb_model.dll
#addsc mb_model.dll
##
#acom "D:\Telops\FIR-00251-Proc\aldec\src\Testbench\SystemC\mb_model_wrapper.vhd"
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\PelicanD\src\PelicanD_top_tb.bde
acom d:\Telops\FIR-00251-Proc\aldec\src\FPA\PelicanD\src\TestBench\pelicand_top_tb_TB.vhd
##
#
asim -ses pelicand_top_tb_TB 
#
#--add wave -noreg -hexadecimal -literal {/hder_inserter_top_tb_TB/U3/U1/MB_MOSI}
#
#-- receveur config
--wave UUT/U1/U4/*
#
#-- detecteur freq_id
wave UUT/U1/U7/*
#
#-- trig controller
wave UUT/U1/U1/*

#-- sequenceur
wave UUT/U1/U2/*  
#
#-- frame io interface
--wave UUT/U1/U19/*            

#-- hw driver sequencer
--wave UUT/U1/U5/U1/*                   

#-- hw serial module--
--wave UUT/U1/U5/U2/*                   

#-- hw uart block--
#wave UUT/U1/U5/U6/* 

#-- hw ram
--wave UUT/U1/U5/U3/*                     
                    
#-- stat gen
#wave UUT/U1/U6/* 

#-- diag data gen
--wave UUT/U1/U9/U1/*

#-- data dispatcher
--wave UUT/U1/U9/U6/*

#-- dout fifo
--wave UUT/U1/U8/* 

#--fifo writer
#wave UUT/U1/U9/U4/*  

#hw driver
--wave UUT/U1/U5/*

#top level pelicanD
--wave UUT/U1/*

run 10 ms