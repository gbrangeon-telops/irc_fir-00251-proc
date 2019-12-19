set sensorName=%1
set fpgaSize=%2
set logFile=%3

echo BEGIN Pre-release compile %sensorName% %fpgaSize%>> %logFile%

REM Set environment variables
call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat %sensorName% %fpgaSize%

REM Create and build bootloader and main project
cmd /c %x_xsct% %projectDir%\sdk\build_sw.tcl %sensorName% %fpgaSize% 1 1
for %%A in (%sdkDir%\%baseName%_boot_%fpgaSize%\Release\%baseName%_boot_%fpgaSize%.elf %sdkDir%\%baseName%_%fpgaSize%\Release\%baseName%_%fpgaSize%.elf) do (
   if not exist %%A (
      echo Create and build project failed!
      pause
      exit
   )
)
echo Create and build project done>> %logFile%

REM Copy files
call %scriptsDir%\fetchHwSwFiles.bat
echo fetchHwSwFiles done>> %logFile%

echo END Pre-release compile %sensorName% %fpgaSize%>> %logFile%
echo.>> %logFile%
