REM input : <sensorname> <fpgasize> <createAndBuild=0 or Build=1>
call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat %1 %2

cmd /c %x_xsct% %projectDir%\sdk\build_sw.tcl %sensorName% %fpgaSize% %3 "main_only"
if errorlevel 1 (
	echo Create and build file failed!
	pause
   exit
)