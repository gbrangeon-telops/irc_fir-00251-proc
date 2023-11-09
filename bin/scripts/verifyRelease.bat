call %xDir%\SDK\2018.3\bin\xsct.bat %scriptsDir%\verifyRelease.tcl^
   -pbf %buildInfoFile% -obf %outputBuildInfoFile% -sbf %storageBuildInfoFile%^
   -of %outputRevFile% -sf1 %storageRevFile1% -sf2 %storageRevFile2% -pf %revFile%^
   -rf %releaseLogFile% -size %fpgaSize% -osize %outputFpgaSize%
if errorlevel 1 (
	echo Verify release failed for %sensorName% %fpgaSize%
	pause
	exit
)
