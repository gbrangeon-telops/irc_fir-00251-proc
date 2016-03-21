set sensorName=%1
set baseName=fir_00251_proc_%sensorName%

set commonDir=D:\Telops\FIR-00251-Common
set projectDir=D:\Telops\FIR-00251-Proc
set sdkDir=%projectDir%\sdk\%baseName%
set srcDir=%projectDir%\src
set binDir=%projectDir%\bin\%baseName%
set scriptsDir=%projectDir%\bin\scripts
set outputDir=D:\Telops\FIR-00251-Output
set storageDir=D:\Telops\FIR-00257-Storage
set ntxminiDir=F:\Production\IRCAM\Firmwares\FIR-00251-NTx-Mini\Archives

set elfFile=%binDir%\%baseName%.elf
set srecFile=%binDir%\%baseName%.srec
set bootFile=%binDir%\%baseName%_boot.elf
set bitFile=%binDir%\%baseName%.bit
set bmmFile=%binDir%\%baseName%_bd.bmm
set buildInfoFile=%srcDir%\BuildInfo\%sensorName%\BuildInfo.h
set releaseFile=%binDir%\%baseName%_release.bin
set releaseLogFile=%binDir%\%baseName%_release.txt
set revFile=%binDir%\svnrevs.pl
set outputRevFile=%outputDir%\bin\svnrevs.pl
set storageRevFile=%storageDir%\bin\svnrevs.pl
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
if exist D:\Xilinx\SDK\2013.4\*.* set xDir=D:\Xilinx
@echo Xilinx directory: %xDir%

set x_mb-objcopy=%xDir%\SDK\2013.4\gnu\microblaze\nt\bin\mb-objcopy.exe
set x_data2mem=%xDir%\SDK\2013.4\bin\nt64\data2mem.exe
set x_promgen=%xDir%\14.7\LabTools\LabTools\bin\nt64\promgen.exe
set x_xilperl=%xDir%\Vivado\2013.4\ids_lite\ISE\bin\nt64\xilperl.exe

copy %versionFile% %versionFile:.txt=.bat%
call %versionFile:.txt=.bat%
del %versionFile:.txt=.bat%
