asim -ses +access +r bb1920_deserializer_simulation --/scd_proxy2_serdes\

--do waveform.do	   
do "$FIR251PROC/src/bb1920_serdes/SIM/waveform.do"

run 10 ns
