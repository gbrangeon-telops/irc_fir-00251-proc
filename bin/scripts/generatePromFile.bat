REM input : <sensorname> <fpgasize>
call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat %1 %2

call %xDir%\Vivado\2018.3\bin\vivado -mode batch -source %scriptsDir%\generatePromFile.tcl -notrace -tclargs %fpgaSize% %sensorName%
if errorlevel 1 (
	echo PROM file generation failed!
	pause
   exit
)
