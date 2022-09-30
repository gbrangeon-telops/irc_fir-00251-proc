

SetActiveLib -work
clearlibrary work

acom d:\Telops\FIR-00251-Common\VHDL\tel2000pkg.vhd
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

#acom D:\Telops\FIR-00251-Proc\src\Irig\HDL\IRIG_define.vhd

do D:\Telops\FIR-00251-Proc\src\Irig\HDL\irig_compile.do


acom D:\Telops\FIR-00251-Proc\src\Irig\Sim\IRIG_Testbench_define.vhd
acom  D:\Telops\FIR-00251-Proc\src\Irig\Sim\irigb_source.vhd

acom D:\Telops\FIR-00251-Proc\src\Irig\Sim\comparator.vhd
acom D:\Telops\FIR-00251-Proc\src\Irig\Sim\peak_detector.vhd
acom D:\Telops\FIR-00251-Proc\src\Irig\Sim\opamp.vhd
acom D:\Telops\FIR-00251-Proc\src\Irig\Sim\adc_ad7478_dummy.vhd 
acom D:\Telops\FIR-00251-Proc\src\Irig\Sim\Irig_GlobalTest.bde 

acom D:\Telops\FIR-00251-Proc\src\Irig\Sim\irig_globaltest_TB.vhd 
asim -ses irig_globaltest_TB 
-- module complet
wave UUT/*
wave UUT/U7/*

-- detecteur d'horloge
--wave UUT/U7/U2/*

-- conditionner : adc sample en
--wave UUT/U7/U1/U2/* 
  
-- conditionner : pilote ADC
--wave UUT/U7/U1/U1/*  
                  
-- conditionner : adc sample counter
--wave UUT/U7/U1/U14/*   

-- conditionner : adc sample averaging
--wave UUT/U7/U1/U3/*  
                       
-- alphab : threshold
--wave UUT/U7/U3/U1/*

-- alphab : irig_comparartor
--wave UUT/U7/U3/U3/*  

-- alphab : detector
--wave UUT/U7/U3/U4/*  

-- contrôleur IRIG
--wave UUT/U7/U5/* 

-- frame decodeur IRIG
--wave UUT/U7/U4/* 


#SetActiveLib -work
#comp -include "$dsn\compile\Irig_GlobalTest.vhd" 
#comp -include "$dsn\src\Hdl\Sim\irig_globaltest_TB.vhd" 
--asim +access +r TESTBENCH_FOR_irig_globaltest 
--wave -ports /irig_globaltest_tb/UUT/U8/*
--wave -signals /irig_globaltest_tb/UUT/U7/U2/*


--wave -noreg /irig_globaltest_tb/UUT/U4/IRIG_SIGNAL_DVAL

#wave -noreg CLK
#wave -noreg IRIG_ENABLE
#wave -noreg RESET_IRIG_ERR
#wave -noreg IRIG_REG_MISO
#wave -noreg IRIG_PPS
#wave -noreg IRIG_REG_MOSI
#wave -noreg IRIG_REG_SEL
## The following lines can be used for timing simulation
## acom <backannotated_vhdl_file_name>
## comp -include "$dsn\src\TestBench\irig_globaltest_TB_tim_cfg.vhd" 
## asim +access +r TIMING_FOR_irig_globaltest 

                       
run 1200 ms

   
   