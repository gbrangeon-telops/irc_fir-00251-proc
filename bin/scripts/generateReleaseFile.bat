call %scriptsDir%\updateReleaseSvnRevsFile.bat
call %scriptsDir%\updateVersionFile.bat %sensorName%

rem Clean up
del %releaseFile%
del %releaseLogFile%

REM Call setEnvironment to get the last firmwareVersion values
call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat %sensorName% %fpgaSize%

call %x_xsct% %scriptsDir%\generateReleaseFile.tcl -fa %firmwareVersionMajor% -fi %firmwareVersionMinor% -fs ^
%firmwareVersionSubMinor% -fb %firmwareVersionBuild% -p %revFile% -o %outputRevFile% -s1 %storageRevFile1% -s2 %storageRevFile2% -r %releaseFile% -l %releaseLogFile%
if errorlevel 1 (
	echo Release file generation failed!
	pause
   exit
)
