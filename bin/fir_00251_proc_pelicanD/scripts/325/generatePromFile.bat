@echo off

call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat pelicanD 325

%xDir%\Vivado\2018.3\bin\vivado -mode batch -source generatePromFile325.tcl

cmd /k
