SetActiveLib -work
clearlibrary fir_00229


do d:\Telops\FIR-00229\src\FIR-00229\IRIG\irig_compile.do

acom d:\Telops\FIR-00229\src\FIR-00229\IRIG\IRIG_define.vhd
acom D:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\IRIG_Testbench_define.vhd
acom  d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\irigb_source.vhd

acom d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\comparator.vhd
acom d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\peak_detector.vhd
acom d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\opamp.vhd
acom d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\adc_ad7478_dummy.vhd 
acom d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\Irig_GlobalTest.bde 




acom d:\Telops\FIR-00229\src\FIR-00229\IRIG\Irig_Testbench\irigb_source_TB.vhd 
asim -ses irigb_source_TB 


wave /UUT/*  
 

run  20 ms

   
   