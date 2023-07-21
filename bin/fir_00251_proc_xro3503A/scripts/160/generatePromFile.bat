@echo off

call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat xro3503A 160

C:\Xilinx\Vivado\2018.3\bin\vivado -mode batch -source generatePromFile160.tcl

cmd /k
