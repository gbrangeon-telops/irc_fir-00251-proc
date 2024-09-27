adel -all
acom $FIR251COMMON/VHDL/tel2000pkg.vhd


#utilities
do $FIR251PROC/src/compil_utilities.do   


acom  $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_data_cnt.vhd
acom  $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_min_max_ctrl.vhd
acom  $COMMON_HDL/Common_Projects/TEL2000/FPA_common/src/fpa_data_cnt_min_max.bde

acom $FIR251COMMON/VHDL/Utilities/axis64_data_pos.vhd
acom $FIR251COMMON/VHDL/Utilities/axis64_data_sel.vhd
acom $FIR251COMMON/VHDL/Utilities/axis64_line_pos.vhd
acom $FIR251COMMON/VHDL/Utilities/axis64_xcropping.bde                                 

acom $FIR251COMMON/VHDL/Utilities/axis64_RandomMiso.vhd

                                                                                                                                        
                                                                     
acom $FIR251PROC/aldec/axis64_xcropping_test/src/axis64_xcropping_tb.bde
acom $FIR251PROC/aldec/axis64_xcropping_test/src/TestBench/axis64_xcropping_tb_TB.vhd


asim -ses axis64_xcropping_tb_TB 



wave UUT/U1/U3a/* 
wave UUT/U1/g0/U1/*


#wave UUT/U1/U3b/*
#wave UUT/U1/U3c/*
wave UUT/U2/*           
wave UUT/U4/*    
wave UUT/U1/*
wave UUT/U1/g0/U2/*

-- run 20 us
run 20 ms
