set sensorName=%1
set fpgaSize=%2
set logFile=%3

echo BEGIN Export release files %sensorName% %fpgaSize%>> %logFile%

REM Set environment variables
call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat %sensorName% %fpgaSize%

REM Export release files and move them
call %scriptsDir%\exportReleaseArchive.bat
move %releaseDir% %projectDir%\bin\ReleasedFirmwares
if errorlevel 1 (
   echo Move release files failed!
   pause
   exit
)
echo exportReleaseArchive done>> %logFile%

echo END Export release files %sensorName% %fpgaSize%>> %logFile%
echo.>> %logFile%
