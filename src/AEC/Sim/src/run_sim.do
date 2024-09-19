

#Common
acom "$FIR251COMMON/IP/axis_32_to_16/axis_32_to_16_funcsim.vhdl"
acom "$FIR251COMMON/VHDL/Utilities/axis_32_to_16_wrap.vhd"
acom "$FIR251COMMON/VHDL/Utilities/axis16_RandomMiso.vhd"

#Simulation file
acom -relax "$FIR251PROC/src/AEC/Sim/src/aec_tb_stim.vhd"
acom "$FIR251PROC/src/AEC/Sim/src/aec_tb_top.bde"

asim -ses +access +r aec_tb_top
#transcript off
do "$FIR251PROC/src/AEC/Sim/src/waveform.do"
#transcript on
run 100 us
						