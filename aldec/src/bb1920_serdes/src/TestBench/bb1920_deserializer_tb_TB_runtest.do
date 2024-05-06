#packages
adel -all
alib work
setActivelib work


acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_common_pkg.vhd \
 D:\Telops\FIR-00251-Proc\src\FPA\blackbird1920D\HDL\FPA_define.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy2\HDL\proxy_define.vhd \

   
#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

acom \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_min_max_ctrl.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt_min_max.bde

acom D:\Telops\FIR-00251-Proc\IP\325\fwft_sfifo_w3_d16\fwft_sfifo_w3_d16_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_w36_d512\fwft_afifo_w36_d512_sim_netlist.vhdl
acom D:\Telops\FIR-00251-Proc\IP\325\fwft_afifo_w8_d256\fwft_afifo_w8_d256_sim_netlist.vhdl

acom -nowarn DAGGEN_0523 -incr \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_diag_line_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\afpa_diag_data_gen.vhd \
 d:\Telops\FIR-00251-Proc\aldec\src\bb1920_serdes\src\bb1920_data_gen_dispatcher.vhd \
 d:\Telops\FIR-00251-Proc\aldec\src\bb1920_serdes\src\LL8_to_serial.vhd \
 d:\Telops\FIR-00251-Proc\aldec\src\bb1920_serdes\src\dual_data_serializer.bde
 
acom d:\Telops\FIR-00251-Proc\aldec\src\bb1920_serdes\src\iserdes_wrapper.vhd 
acom d:\Telops\Common_HDL\gh_vhdl_lib\custom_MSI\gh_stretch.vhd
do D:\Telops\FIR-00251-Proc\src\bb1920_serdes\HDL\compil_bb1920_receiver.do
acom d:\Telops\FIR-00251-Proc\aldec\src\bb1920_serdes\src\bb1920_deserializer_tb.bde
acom d:\Telops\FIR-00251-Proc\aldec\src\bb1920_serdes\src\TestBench\bb1920_deserializer_tb_TB.vhd

asim bb1920_deserializer_tb_TB
add wave -named_row "------------------------Test bench-------------------------------------" 
wave UUT/* 
add wave -named_row "------------------------fpa data cnt-------------------------------------" 
wave UUT/U7/* 
add wave -named_row "------------------------afpa diag gen-------------------------------------" 
wave UUT/U4/* 
add wave -named_row "------------------------gen dispatcher-------------------------------------" 
wave UUT/U3/* 
add wave -named_row "------------------------dual seralizer-------------------------------------" 
wave UUT/U1/*
add wave -named_row "------------------------bb1920 deserializer CH1-------------------------------------" 
wave UUT/U5/CH1/* 
add wave -named_row "------------------------CH1 SERDES-------------------------------------" 
wave UUT/U5/CH1/U32/*   
add wave -named_row "------------------------CH1 proxy dout-------------------------------------" 
wave UUT/U5/CH1/U6/*   
add wave -named_row "------------------------clink calibration-------------------------------------" 
wave UUT/U5/CH1/U74/*		  
add wave -named_row "------------------------clink calibration delay-------------------------------------" 
wave UUT/U5/CH1/U74/U1/*		  
add wave -named_row "------------------------clink calibration bitslip-------------------------------------" 
wave UUT/U5/CH1/U74/U4/*		  
add wave -named_row "------------------------clink delay-------------------------------------" 
wave UUT/U5/CH1/U75/*
add wave -named_row "------------------------clink delay validator-------------------------------------" 
wave UUT/U5/CH1/U75/U8/U2/*
add wave -named_row "------------------------bb1920 deserializer-------------------------------------" 
wave UUT/U5/* 
add wave -named_row "------------------------bb1920 deserializer even-------------------------------------" 
wave UUT/U5/U1/*
wave UUT/U5/U2/*
add wave -named_row "------------------------bb1920 deserializer odd-------------------------------------" 
wave UUT/U5/U11/*
wave UUT/U5/U8/*

run 50 ms
