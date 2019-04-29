call %scriptsDir%\updateReleaseSvnRevsFile.bat
call %scriptsDir%\updateVersionFile.bat

rem Clean up
del %releaseFile%
del %releaseLogFile%

%x_xilperl% %scriptsDir%\generateReleaseFile.pl^
   -fa %firmwareVersionMajor% -fi %firmwareVersionMinor% -fs %firmwareVersionSubMinor% -fb %firmwareVersionBuild%^
   -p %revFile% -o %outputRevFile% -s1 %storageRevFile1% -s2 %storageRevFile2%^
   -r %releaseFile% -l %releaseLogFile%
   