set GenICam_h=%commonDir%\Software\GenICam.h

for /f %%i in ('%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %srcDir%\IRCamFiles\FlashSettingsFile.h -f TSFSFILES_VERSION') do  set fsMajorVersion=%%i
set FlashSettingsFile_h=%srcDir%\IRCamFiles\FlashSettingsFile_v%fsMajorVersion%.h

for /f %%i in ('%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %srcDir%\IRCamFiles\FlashDynamicValuesFile.h -f TSDVFILES_VERSION') do  set fdvMajorVersion=%%i
set FlashDynamicValuesFile_h=%srcDir%\IRCamFiles\FlashDynamicValuesFile_v%fdvMajorVersion%.h

set FirmwareVersionFile=%projectDir%\bin\FirmwareReleaseVersion.txt

echo|set /p="set firmwareVersionMajor="> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FirmwareVersionFile% -f firmwareVersionMajor>> %versionFile%
echo.>> %versionFile%
echo|set /p="set firmwareVersionMinor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FirmwareVersionFile% -f firmwareVersionMinor>> %versionFile%
echo.>> %versionFile%
echo|set /p="set firmwareVersionSubMinor=%sensorCode%">> %versionFile%
echo.>> %versionFile%
echo|set /p="set firmwareVersionBuild=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FirmwareVersionFile% -f firmwareVersionBuild>> %versionFile%
echo.>> %versionFile%
echo set firmwareVersion=%%firmwareVersionMajor%%.%%firmwareVersionMinor%%.%%firmwareVersionSubMinor%%.%%firmwareVersionBuild%%>> %versionFile%

echo.>> %versionFile%

echo|set /p="set xmlVersionMajor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %GenICam_h% -f GC_XMLMAJORVERSION>> %versionFile%
echo.>> %versionFile%
echo|set /p="set xmlVersionMinor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %GenICam_h% -f GC_XMLMINORVERSION>> %versionFile%
echo.>> %versionFile%
echo|set /p="set xmlVersionSubMinor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %GenICam_h% -f GC_XMLSUBMINORVERSION>> %versionFile%
echo.>> %versionFile%
echo set xmlVersion=%%xmlVersionMajor%%.%%xmlVersionMinor%%.%%xmlVersionSubMinor%%>> %versionFile%

echo.>> %versionFile%

echo|set /p="set flashSettingsVersionMajor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashSettingsFile_h% -f FLASHSETTINGS_FILEMAJORVERSION_V%fsMajorVersion%>> %versionFile%
echo.>> %versionFile%
echo|set /p="set flashSettingsVersionMinor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashSettingsFile_h% -f FLASHSETTINGS_FILEMINORVERSION_V%fsMajorVersion%>> %versionFile%
echo.>> %versionFile%
echo|set /p="set flashSettingsVersionSubMinor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashSettingsFile_h% -f FLASHSETTINGS_FILESUBMINORVERSION_V%fsMajorVersion%>> %versionFile%
echo.>> %versionFile%
echo set flashSettingsVersion=%%flashSettingsVersionMajor%%.%%flashSettingsVersionMinor%%.%%flashSettingsVersionSubMinor%%>> %versionFile%

echo.>> %versionFile%

echo|set /p="set flashDynamicValuesVersionMajor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashDynamicValuesFile_h% -f FLASHDYNAMICVALUES_FILEMAJORVERSION_V%fdvMajorVersion%>> %versionFile%
echo.>> %versionFile%
echo|set /p="set flashDynamicValuesVersionMinor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashDynamicValuesFile_h% -f FLASHDYNAMICVALUES_FILEMINORVERSION_V%fdvMajorVersion%>> %versionFile%
echo.>> %versionFile%
echo|set /p="set flashDynamicValuesVersionSubMinor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashDynamicValuesFile_h% -f FLASHDYNAMICVALUES_FILESUBMINORVERSION_V%fdvMajorVersion%>> %versionFile%
echo.>> %versionFile%
echo set flashDynamicValuesVersion=%%flashDynamicValuesVersionMajor%%.%%flashDynamicValuesVersionMinor%%.%%flashDynamicValuesVersionSubMinor%%>> %versionFile%

copy %versionFile% %versionFile:.txt=.bat%
call %versionFile:.txt=.bat%
del %versionFile:.txt=.bat%
