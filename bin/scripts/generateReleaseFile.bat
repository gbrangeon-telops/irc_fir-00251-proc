call %scriptsDir%\updateReleaseSvnRevsFile.bat
call %scriptsDir%\updateVersionFile.bat %sensorName%

rem Clean up
del %releaseFile%
del %releaseLogFile%

call %x_xsct% %scriptsDir%\generateReleaseFile.tcl -fa %firmwareVersionMajor% -fi %firmwareVersionMinor% -fs ^
%firmwareVersionSubMinor% -fb %firmwareVersionBuild% -p %revFile% -o %outputRevFile% -s1 %storageRevFile1% -s2 %storageRevFile2% -r %releaseFile% -l %releaseLogFile%
if errorlevel 1 (
	echo Release file generation failed!
	pause
   exit
)
