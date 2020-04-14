set sensorName=%1
set fpgaSize=%2
set baseName=fir_00251_proc_%sensorName%

set commonDir=D:\Telops\FIR-00251-Common
set projectDir=D:\Telops\FIR-00251-Proc
set sdkDir=%projectDir%\sdk\%baseName%
set srcDir=%projectDir%\src
set binDir=%projectDir%\bin\%baseName%
set scriptsDir=%projectDir%\bin\scripts
set outputDir=D:\Telops\FIR-00251-Output
set storageDir=D:\Telops\FIR-00257-Storage
set ntxminiDir=\\STARK\DisqueTELOPS\Production\IRCAM\Firmwares\FIR-00251-NTx-Mini\Archives

set elfFile=%binDir%\%baseName%_%fpgaSize%.elf
set bootFile=%sdkDir%\%baseName%_boot_%fpgaSize%\Release\%baseName%_boot_%fpgaSize%.elf
set hwFile=%sdkDir%\%baseName%_%fpgaSize%.hdf

set buildInfoFile=%srcDir%\BuildInfo\%sensorName%\BuildInfo.h
set releaseFile=%binDir%\%baseName%_%fpgaSize%_release.bin
set releaseLogFile=%binDir%\%baseName%_%fpgaSize%_release.txt
set revFile=%binDir%\svnrevs_%fpgaSize%.pl

if "%fpgaSize%" == "160" (
   set outputFpgaSize=70
) else (
   set outputFpgaSize=160
)
set outputRevFile=%outputDir%\bin\svnrevs_%outputFpgaSize%.pl
set outputBaseName=fir_00251_output_%outputFpgaSize%
set outputBuildInfoFile=%outputDir%\src\BuildInfo\BuildInfo.h

set storageRevFile1=%storageDir%\bin\svnrevs_16.pl
set storageRevFile2=%storageDir%\bin\svnrevs_32.pl
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
if exist D:\Xilinx\SDK\2016.3\*.* set xDir=D:\Xilinx
@echo Xilinx directory: %xDir%

set x_mb-objcopy=%xDir%\SDK\2016.3\gnu\microblaze\nt\bin\mb-objcopy.exe
set x_xsct=%xDir%\SDK\2016.3\bin\xsct.bat
set x_xilperl=%xDir%\Vivado\2016.3\ids_lite\ISE\bin\nt64\xilperl.exe

set xDir=C:\Xilinx
if exist D:\Xilinx\14.7\*.* set xDir=D:\Xilinx
@echo Xilinx directory: %xDir%

set x_promgen=%xDir%\14.7\LabTools\LabTools\bin\nt64\promgen.exe

copy %versionFile% %versionFile:.txt=.bat%
call %versionFile:.txt=.bat%
del %versionFile:.txt=.bat%
