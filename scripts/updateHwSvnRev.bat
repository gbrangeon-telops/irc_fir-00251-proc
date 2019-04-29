@echo off

set sensorName=%1

set procDir=D:\Telops\FIR-00251-Proc
set commonDir=D:\Telops\FIR-00251-Common
set commonHdlDir=D:\Telops\Common_HDL

set srcExtensionList=".bde" ".vhd" ".xdc"

set tortoiseSVNDir="C:\Program Files\TortoiseSVN"
set svn_subwcrev=%tortoiseSVNDir%\bin\SubWCRev.exe

set hwRevFile=%procDir%\sdk\fir_00251_proc_%sensorName%\hw\hw_svn_rev.txt

REM Delete old revision file
del %hwRevFile%

REM Proc repo
echo %procDir% $WCREV$>> %hwRevFile%
%svn_subwcrev% %procDir% %hwRevFile% %hwRevFile%

REM Proc IP files
for /f %%G in ('dir /b /s /a:-d %procDir%\IP') do (
   if "%%~xG"==".xci" (
      echo %%G $WCREV$>> %hwRevFile%
      %svn_subwcrev% %%G %hwRevFile% %hwRevFile%
   )
)

REM Proc scripts files
for /f %%G in ('dir /b /s /a:-d %procDir%\scripts') do (
   echo %%G $WCREV$>> %hwRevFile%
   %svn_subwcrev% %%G %hwRevFile% %hwRevFile%
)

REM Proc src files
for /f %%G in ('dir /b /s /a:-d %procDir%\src') do (
   for %%H in (%srcExtensionList%) do (
      if "%%~xG"==%%H (
         echo %%G $WCREV$>> %hwRevFile%
         %svn_subwcrev% %%G %hwRevFile% %hwRevFile%
      )
   )
)

REM Common repo
echo %commonDir% $WCREV$>> %hwRevFile%
%svn_subwcrev% %commonDir% %hwRevFile% %hwRevFile%

REM Common IP files
for /f %%G in ('dir /b /s /a:-d %commonDir%\IP') do (
   if "%%~xG"==".xci" (
      echo %%G $WCREV$>> %hwRevFile%
      %svn_subwcrev% %%G %hwRevFile% %hwRevFile%
   )
)

REM Common src files
for /f %%G in ('dir /b /s /a:-d %commonDir%\VHDL') do (
   for %%H in (%srcExtensionList%) do (
      if "%%~xG"==%%H (
         echo %%G $WCREV$>> %hwRevFile%
         %svn_subwcrev% %%G %hwRevFile% %hwRevFile%
      )
   )
)

REM Common_HDL repo
echo %commonHdlDir% $WCREV$>> %hwRevFile%
%svn_subwcrev% %commonHdlDir% %hwRevFile% %hwRevFile%

REM Common_HDL FPA files
for /f %%G in ('dir /b /s /a:-d %commonHdlDir%\Common_Projects\TEL2000\FPA_common\src') do (
   echo %%G $WCREV$>> %hwRevFile%
   %svn_subwcrev% %%G %hwRevFile% %hwRevFile%
)

REM Common_HDL gh files
for /f %%G in ('dir /b /s /a:-d %commonHdlDir%\gh_vhdl_lib\custom_MSI') do (
   echo %%G $WCREV$>> %hwRevFile%
   %svn_subwcrev% %%G %hwRevFile% %hwRevFile%
)

REM Common_HDL RS232 file
echo %commonHdlDir%\RS232\uarts.vhd $WCREV$>> %hwRevFile%
%svn_subwcrev% %commonHdlDir%\RS232\uarts.vhd %hwRevFile% %hwRevFile%

REM Common_HDL SPI files
for /f %%G in ('dir /b /a:-d %commonHdlDir%\SPI\*.vhd') do (
   echo %commonHdlDir%\SPI\%%G $WCREV$>> %hwRevFile%
   %svn_subwcrev% %commonHdlDir%\SPI\%%G %hwRevFile% %hwRevFile%
)

REM Common_HDL gh files
for /f %%G in ('dir /b /a:-d %commonHdlDir%\Utilities\*.vhd') do (
   echo %commonHdlDir%\Utilities\%%G $WCREV$>> %hwRevFile%
   %svn_subwcrev% %commonHdlDir%\Utilities\%%G %hwRevFile% %hwRevFile%
)
