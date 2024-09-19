call %~dp0\..\..\..\scripts\setEnvironment.bat blackbird1280D 160
%xDir%\Vivado\2018.3\bin\vivado -mode batch -source %scriptsDir%\generatePromFile.tcl -notrace -tclargs %fpgaSize% %sensorName%
