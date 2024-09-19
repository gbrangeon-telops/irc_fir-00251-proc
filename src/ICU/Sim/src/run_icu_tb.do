acom "$FIR251PROC/src/ICU/Sim/src/icu_tb_stim.vhd"
acom "$FIR251PROC/src/ICU/Sim/src/icu_tb_toplevel.bde"

asim -ses icu_tb_toplevel 

do "$FIR251PROC/src/ICU/Sim/src/waveform.do"

run 200 ms