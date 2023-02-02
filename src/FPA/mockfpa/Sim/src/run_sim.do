#Simulation file

asim -ses +access +r stim
#transcript off	  
do "D:\Telops\FIR-00251-Proc\src\FPA\mockfpa\Sim\src\waveform.do"
#transcript on

run 5ms
