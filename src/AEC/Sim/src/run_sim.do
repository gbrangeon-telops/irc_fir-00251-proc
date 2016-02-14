setenv COMMON "D:\Telops\FIR-00251-Common"

#Common
acom "$COMMON\IP\axis_32_to_16\axis_32_to_16_funcsim.vhdl"
acom "$COMMON\VHDL\Utilities\axis_32_to_16_wrap.vhd"
acom "$COMMON\VHDL\Utilities\axis16_RandomMiso.vhd"

#Simulation file
acom -relax "D:\Telops\FIR-00251-Proc\src\AEC\Sim\src\aec_tb_stim.vhd"
acom "D:\Telops\FIR-00251-Proc\src\AEC\Sim\src\aec_tb_top.bde"

asim -ses +access +r aec_tb_top
#transcript off
do "D:\Telops\FIR-00251-Proc\src\AEC\Sim\src\waveform.do"
#transcript on
run 100 us
						