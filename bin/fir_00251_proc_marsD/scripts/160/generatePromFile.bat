@echo off


call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat marsD 160

%xDir%\Vivado\2018.3\bin\vivado -mode batch -source %scriptsDir%\generatePromFile.tcl -notrace -tclargs %fpgaSize% %sensorName%

cmd /k
