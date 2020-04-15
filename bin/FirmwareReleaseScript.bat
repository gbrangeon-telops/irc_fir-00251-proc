@echo off
set projectDir=D:\Telops\FIR-00251-Proc
set FirmwareReleaseListFile=%projectDir%\bin\FirmwareReleaseList.txt
set FirmwareReleaseVersionFile=%projectDir%\bin\FirmwareReleaseVersion.txt
set FirmwareReleaseLogFile=%projectDir%\bin\FirmwareRelease.log
set svnDir="http://einstein/svn/firmware/"

REM Clean up
del %FirmwareReleaseLogFile%
rd /Q /S %projectDir%\bin\ReleasedFirmwares
md %projectDir%\bin\ReleasedFirmwares

REM Parse FirmwareReleaseVersionFile
for /F "tokens=1-2 delims==" %%G in ('findstr "firmwareVersionMajor" %FirmwareReleaseVersionFile%') do set major=%%H
for /F "tokens=1-2 delims==" %%G in ('findstr "firmwareVersionMinor" %FirmwareReleaseVersionFile%') do set minor=%%H
for /F "tokens=1-2 delims==" %%G in ('findstr "firmwareVersionBuild" %FirmwareReleaseVersionFile%') do set build=%%H
set firmwareReleaseVersion=%major%.%minor%.x.%build%
echo *****************************************>> %FirmwareReleaseLogFile%
echo BEGIN Firmware release %firmwareReleaseVersion%>> %FirmwareReleaseLogFile%
echo *****************************************>> %FirmwareReleaseLogFile%
echo.>> %FirmwareReleaseLogFile%

REM REM Create and build projects for pre-release
REM for /F "skip=3 tokens=1-2 eol=# delims=," %%G in (%FirmwareReleaseListFile%) do (
   REM call D:\Telops\FIR-00251-Proc\bin\scripts\FirmwareReleaseScript_step1.bat %%G %%H %FirmwareReleaseLogFile%
REM )

REM Commit pre-release
set preReleaseMessage=Pre-release %firmwareReleaseVersion%
svn commit %projectDir% -m "%preReleaseMessage%"
svn update %projectDir%
echo *****************************************>> %FirmwareReleaseLogFile%
echo Pre-release commit done>> %FirmwareReleaseLogFile%
echo *****************************************>> %FirmwareReleaseLogFile%
echo.>> %FirmwareReleaseLogFile%

REM Build projects for release
for /F "skip=3 tokens=1-2 eol=# delims=," %%G in (%FirmwareReleaseListFile%) do (
   call D:\Telops\FIR-00251-Proc\bin\scripts\FirmwareReleaseScript_step2.bat %%G %%H %FirmwareReleaseLogFile%
)

REM Commit release
set releaseMessage=Release %firmwareReleaseVersion%
svn commit %projectDir% -m "%releaseMessage%"
svn update %projectDir%
echo *****************************************>> %FirmwareReleaseLogFile%
echo Release commit done>> %FirmwareReleaseLogFile%

REM Tag release
for /F %%G in ('PowerShell -Command "& {Get-Date -format "yyyy-MM-dd"}"') do set releaseDate=%%G
set tagPath=/tags/%releaseDate% - %releaseMessage%
svn copy D:\Telops\FIR-00251-Common "%svnDir%FIR-00251-Common%tagPath%" -m "%releaseMessage%"
svn copy D:\Telops\FIR-00251-NTx-Mini "%svnDir%FIR-00251-NTx-Mini%tagPath%" -m "%releaseMessage%"
svn copy %projectDir% "%svnDir%FIR-00251-Proc%tagPath%" -m "%releaseMessage%"
svn copy D:\Telops\FIR-00251-Output "%svnDir%FIR-00251-Output%tagPath%" -m "%releaseMessage%"
svn copy D:\Telops\FIR-00257-Storage "%svnDir%FIR-00257-Storage%tagPath%" -m "%releaseMessage%"
echo Release tags done>> %FirmwareReleaseLogFile%
echo *****************************************>> %FirmwareReleaseLogFile%
echo.>> %FirmwareReleaseLogFile%

REM Export release files
for /F "skip=3 tokens=1-2 eol=# delims=," %%G in (%FirmwareReleaseListFile%) do (
   call D:\Telops\FIR-00251-Proc\bin\scripts\FirmwareReleaseScript_step3.bat %%G %%H %FirmwareReleaseLogFile%
)

echo *****************************************>> %FirmwareReleaseLogFile%
echo END Firmware release %firmwareReleaseVersion%>> %FirmwareReleaseLogFile%
echo *****************************************>> %FirmwareReleaseLogFile%

start %FirmwareReleaseLogFile%
