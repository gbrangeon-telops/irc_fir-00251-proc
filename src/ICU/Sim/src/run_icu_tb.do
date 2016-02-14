acom "D:\Telops\FIR-00251-Proc\src\ICU\Sim\src\icu_tb_stim.vhd"
acom "D:\Telops\FIR-00251-Proc\src\ICU\Sim\src\icu_tb_toplevel.bde"

asim -ses icu_tb_toplevel 

do "D:\Telops\FIR-00251-Proc\src\ICU\Sim\src\waveform.do"

run 200 ms