@echo off

call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat scorpiolwD_230Hz 160

%xDir%\Vivado\2018.3\bin\vivado -mode batch -source %scriptsDir%\generatePromFile.tcl -notrace -tclargs %fpgaSize% %sensorName%


cmd /k
