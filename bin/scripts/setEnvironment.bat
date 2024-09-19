set sensorName=%1
set fpgaSize=%2
set baseName=fir_00251_proc_%sensorName%

set currentDir=%~dp0\..\..\..
call %currentDir%\setEnvironment.bat %1 %2

set commonDir=%currentDir%\irc_fir-00251-common
set projectDir=%currentDir%\irc_fir-00251-proc
set sdkDir=%projectDir%\sdk\%baseName%
set srcDir=%projectDir%\src
set binDir=%projectDir%\bin\%baseName%
set scriptsDir=%projectDir%\bin\scripts
set outputDir=%currentDir%\irc_fir-00251-output
set storageDir=%currentDir%\ircam_fir-00251-storage_temp
set ntxminiDir=\\STARK\DisqueTELOPS\Production\IRCAM\Firmwares\FIR-00251-NTx-Mini\Archives

set elfFile=%binDir%\%baseName%_%fpgaSize%.elf
set bootFile=%sdkDir%\%baseName%_boot_%fpgaSize%\Release\%baseName%_boot_%fpgaSize%.elf
set hwFile=%sdkDir%\%baseName%_%fpgaSize%.hdf

set buildInfoFile=%srcDir%\BuildInfo\%sensorName%\BuildInfo.h
set releaseFile=%binDir%\%baseName%_%fpgaSize%_release.bin
set releaseLogFile=%binDir%\%baseName%_%fpgaSize%_release.txt
set revFile=%binDir%\svnrevs_%fpgaSize%.tcl

if "%fpgaSize%" == "160" (
   set outputFpgaSize=70
) else (
   set outputFpgaSize=160
)

set outputRevFile=%outputDir%\bin\svnrevs_%outputFpgaSize%.tcl
set outputBaseName=fir_00251_output_%outputFpgaSize%
set outputBuildInfoFile=%outputDir%\src\BuildInfo\BuildInfo.h

set storageRevFile1=%storageDir%\bin\svnrevs_16.tcl
set storageRevFile2=%storageDir%\bin\svnrevs_32.tcl
set storageBuildInfoFile=%storageDir%\src\BuildInfo\BuildInfo.h

set versionFile=%binDir%\version.txt
set sensorInfoFile=%projectDir%\bin\SensorInformation.txt

for /F "skip=2 tokens=1-4 delims=," %%G in (%sensorInfoFile%) do (
   rem echo %%G^(%%H^) %%Ix%%J
   if "%sensorName%" == "%%G" (
      set sensorCode=%%H
      set sensorWidth=%%I
      set sensorHeight=%%J
   )
)

set zip="C:\Program Files\7-Zip\7z.exe"

set tortoiseSVNDir="C:\Program Files\TortoiseSVN"
set svn_subwcrev=%tortoiseSVNDir%\bin\SubWCRev.exe

set xDir=C:\Xilinx
if exist D:\Xilinx\SDK\2018.3\*.* set xDir=D:\Xilinx
@echo SDK Xilinx directory: %xDir%

set x_mb-objcopy=%xDir%\SDK\2018.3\gnu\microblaze\nt\bin\mb-objcopy.exe
set x_xsct=%xDir%\SDK\2018.3\bin\xsct.bat

set xDir=C:\Xilinx
if exist D:\Xilinx\Vivado\2018.3\*.* set xDir=D:\Xilinx
@echo Vivado Xilinx directory: %xDir%

copy %versionFile% %versionFile:.txt=.bat%
call %versionFile:.txt=.bat%
del %versionFile:.txt=.bat%
