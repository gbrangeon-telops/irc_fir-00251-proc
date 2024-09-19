setenv PROC_PATH "$dsn"  

# Compile memory model for 2Gb component
#vlog -O2 -sve -work fir_00251 -na all $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/example_design/sim/c0_ddr3_model.v
#vlog -O2 -sve -work fir_00251 -na all $dsn/../xilinx/fir_0251_Proc.srcs/sources_1/bd/core/ip/core_mig_7series_1_0/core_mig_7series_1_0/example_design/sim/c1_ddr3_model.v

setactivelib work

#assertion fail -disable -rec /Processing_tb/U3/U0/AXI_XADC_CORE_I/XADC_INST
#assertion fail -disable

runexe "$FIR251PROC/src/copy_to_cpp.bat"
adel mb_model
cd $PROC_PATH/src/Testbench/SystemC
buildc Hercules_Detector.dlm
addfile mb_model.dll
addsc mb_model.dll

acom "$PROC_PATH/src/TestBench/CLK_stim.vhd"
acom "$PROC_PATH/src/TestBench/SystemC/mb_model_wrapper.vhd"
acom "$PROC_PATH/src/TestBench/Proc_Only/Processing_tb.bde"


cd $PROC_PATH/src/TestBench/Proc_Only/ 
asim -ses +access +r Processing_tb 
do "$PROC_PATH/src/TestBench/Proc_Only/Proc_Hercule_wave.do"

run 500us

