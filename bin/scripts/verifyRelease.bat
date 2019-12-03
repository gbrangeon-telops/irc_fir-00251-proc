%x_xilperl% %scriptsDir%\verifyRelease.pl^
   -pbf %buildInfoFile% -obf %outputBuildInfoFile% -sbf %storageBuildInfoFile%^
   -of %outputRevFile% -sf1 %storageRevFile1% -sf2 %storageRevFile2% -pf %revFile%^
   -rf %releaseLogFile% -size %fpgaSize% -osize %outputFpgaSize%
pause
