call %scriptsDir%\updateReleaseSvnRevsFile.bat
call %scriptsDir%\updateVersionFile.bat

rem Clean up
del %releaseFile%
del %releaseLogFile%

%x_xilperl% %scriptsDir%\generateReleaseFile.pl^
   -fa %firmwareVersionMajor% -fi %firmwareVersionMinor% -fs %firmwareVersionSubMinor% -fb %firmwareVersionBuild%^
   -p %revFile% -o %outputRevFile% -s %storageRevFile%^
   -r %releaseFile% -l %releaseLogFile%
   