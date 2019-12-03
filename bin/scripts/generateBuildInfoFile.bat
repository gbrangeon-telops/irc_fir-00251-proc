@echo off
set sensorName=%1
call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat %sensorName% 160
rem Clean up
del %buildInfoFile%

echo #ifndef BUILDINFO_H>> %buildInfoFile%
echo #define BUILDINFO_H>> %buildInfoFile%
echo.>> %buildInfoFile%

echo #ifdef ARCH_FPGA_160>> %buildInfoFile%
echo.>> %buildInfoFile%
rem Get hardware revision
echo #define SVN_HARDWARE_REV      $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %hwFile% %buildInfoFile% %buildInfoFile%

rem Get software revision
echo #define SVN_SOFTWARE_REV      $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %elfFile% %buildInfoFile% %buildInfoFile%

rem Get boot loader revision
echo #define SVN_BOOTLOADER_REV    $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %bootFile% %buildInfoFile% %buildInfoFile%

rem Get common directory revision
echo #define SVN_COMMON_REV        $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %commonDir% %buildInfoFile% %buildInfoFile%

rem Check for uncommitted changes
echo.>> %buildInfoFile%
echo #define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV ^< 0) ^|^| (SVN_SOFTWARE_REV ^< 0) ^|^| (SVN_BOOTLOADER_REV ^< 0) ^|^| (SVN_COMMON_REV ^< 0))>> %buildInfoFile%
echo.>> %buildInfoFile%
echo #if SVN_UNCOMMITTED_CHANGES>> %buildInfoFile%
echo #warning Uncommitted changes detected.>> %buildInfoFile%
echo #endif>> %buildInfoFile%

rem Check for hardware definition file mismatch
set hwFilePlatform=%sdkDir%\hw_platform_%fpgaSize%\system.hdf
%x_xilperl% %scriptsDir%\compareFiles.pl -f1 %hwFile% -f2 %hwFilePlatform%
set hardwareMismatch=%errorlevel%

echo.>> %buildInfoFile%
echo #define HARDWARE_MISMATCH (%hardwareMismatch%)>> %buildInfoFile%
echo.>> %buildInfoFile%
echo #if HARDWARE_MISMATCH>> %buildInfoFile%
echo #error %hwFilePlatform% does not match %hwFile%>> %buildInfoFile%
echo #endif>> %buildInfoFile%
echo.>> %buildInfoFile%

echo #elif defined(ARCH_FPGA_325)>> %buildInfoFile%
echo.>> %buildInfoFile%
rem switch ENV variable
@echo off
call D:\Telops\FIR-00251-Proc\bin\scripts\setEnvironment.bat %sensorName% 325

rem Get hardware revision
echo #define SVN_HARDWARE_REV      $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %hwFile% %buildInfoFile% %buildInfoFile%

rem Get software revision
echo #define SVN_SOFTWARE_REV      $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %elfFile% %buildInfoFile% %buildInfoFile%

rem Get boot loader revision
echo #define SVN_BOOTLOADER_REV    $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %bootFile% %buildInfoFile% %buildInfoFile%

rem Get common directory revision
echo #define SVN_COMMON_REV        $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %commonDir% %buildInfoFile% %buildInfoFile%

rem Check for uncommitted changes
echo.>> %buildInfoFile%
echo #define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV ^< 0) ^|^| (SVN_SOFTWARE_REV ^< 0) ^|^| (SVN_BOOTLOADER_REV ^< 0) ^|^| (SVN_COMMON_REV ^< 0))>> %buildInfoFile%
echo.>> %buildInfoFile%
echo #if SVN_UNCOMMITTED_CHANGES>> %buildInfoFile%
echo #warning Uncommitted changes detected.>> %buildInfoFile%
echo #endif>> %buildInfoFile%

rem Check for hardware definition file mismatch
set hwFilePlatform=%sdkDir%\hw_platform_%fpgaSize%\system.hdf
%x_xilperl% %scriptsDir%\compareFiles.pl -f1 %hwFile% -f2 %hwFilePlatform%
set hardwareMismatch=%errorlevel%

echo.>> %buildInfoFile%
echo #define HARDWARE_MISMATCH (%hardwareMismatch%)>> %buildInfoFile%
echo.>> %buildInfoFile%
echo #if HARDWARE_MISMATCH>> %buildInfoFile%
echo #error %hwFilePlatform% does not match %hwFile%>> %buildInfoFile%
echo #endif>> %buildInfoFile%
echo.>> %buildInfoFile%

echo #endif  // FPGA_ARCH Check>> %buildInfoFile%
echo.>> %buildInfoFile%

echo #endif // BUILDINFO_H>> %buildInfoFile%
