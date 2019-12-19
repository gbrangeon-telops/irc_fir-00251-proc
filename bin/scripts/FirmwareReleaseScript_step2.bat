set sensorName=%1
set fpgaSize=%2
set logFile=%3

echo BEGIN Release compile %sensorName% %fpgaSize%>> %logFile%

REM Set environment variables
call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat %sensorName% %fpgaSize%

REM Build main project
cmd /c %x_xsct% %projectDir%\sdk\build_sw.tcl %sensorName% %fpgaSize% 0 0
if not exist %sdkDir%\%baseName%_%fpgaSize%\Release\%baseName%_%fpgaSize%.elf (
   echo Build project failed!
   pause
   exit
)
echo Build project done>> %logFile%

REM Generate release files
call %scriptsDir%\generateReleaseFile.bat
echo generateReleaseFile done>> %logFile%

REM Verify release files
call %scriptsDir%\verifyRelease.bat
echo verifyRelease done>> %logFile%

REM Generate prom files
call %scriptsDir%\generatePromFile.bat
echo generatePromFile done>> %logFile%

echo END Release compile %sensorName% %fpgaSize%>> %logFile%
echo.>> %logFile%
