@echo off

call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat herculesD 160

%xDir%\Vivado\2018.3\bin\vivado -mode batch -source generatePromFile160.tcl
cmd /k
