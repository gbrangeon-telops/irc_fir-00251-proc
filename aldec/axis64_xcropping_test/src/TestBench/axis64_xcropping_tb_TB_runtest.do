adel -all
acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd


#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do   


acom  d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt.vhd
acom  d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_min_max_ctrl.vhd
acom  d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_data_cnt_min_max.bde

acom d:\Telops\FIR-00251-Common\VHDL\Utilities\axis64_data_pos.vhd
acom d:\Telops\FIR-00251-Common\VHDL\Utilities\axis64_data_sel.vhd
acom d:\Telops\FIR-00251-Common\VHDL\Utilities\axis64_line_pos.vhd
acom d:\Telops\FIR-00251-Common\VHDL\Utilities\axis64_xcropping.bde                                 

acom D:\Telops\FIR-00251-Common\VHDL\Utilities\axis64_RandomMiso.vhd

                                                                                                                                        
                                                                     
acom d:\Telops\FIR-00251-Proc\aldec\axis64_xcropping_test\src\axis64_xcropping_tb.bde
acom d:\Telops\FIR-00251-Proc\aldec\axis64_xcropping_test\src\TestBench\axis64_xcropping_tb_TB.vhd


asim -ses axis64_xcropping_tb_TB 



wave UUT/U1/U3a/* 
wave UUT/U1/g0/U1/*


#wave UUT/U1/U3b/*
#wave UUT/U1/U3c/*
wave UUT/U2/*           
wave UUT/U4/*    
wave UUT/U1/*
wave UUT/U1/g0/U2/*

--run 20 us
run 20 ms
