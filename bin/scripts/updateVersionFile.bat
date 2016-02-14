set GenICam_h=%commonDir%\Software\GenICam.h
set FlashSettings_h=%srcDir%\sw\FlashSettings.h
set FlashDynamicValues_h=%srcDir%\sw\FlashDynamicValues.h
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
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashSettings_h% -f FS_FILESTRUCTUREMAJORVERSION>> %versionFile%
echo.>> %versionFile%
echo|set /p="set flashSettingsVersionMinor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashSettings_h% -f FS_FILESTRUCTUREMINORVERSION>> %versionFile%
echo.>> %versionFile%
echo|set /p="set flashSettingsVersionSubMinor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashSettings_h% -f FS_FILESTRUCTURESUBMINORVERSION>> %versionFile%
echo.>> %versionFile%
echo set flashSettingsVersion=%%flashSettingsVersionMajor%%.%%flashSettingsVersionMinor%%.%%flashSettingsVersionSubMinor%%>> %versionFile%

echo.>> %versionFile%

echo|set /p="set flashDynamicValuesVersionMajor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashDynamicValues_h% -f FDV_FILESTRUCTUREMAJORVERSION>> %versionFile%
echo.>> %versionFile%
echo|set /p="set flashDynamicValuesVersionMinor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashDynamicValues_h% -f FDV_FILESTRUCTUREMINORVERSION>> %versionFile%
echo.>> %versionFile%
echo|set /p="set flashDynamicValuesVersionSubMinor=">> %versionFile%
%x_xilperl% %scriptsDir%\fetchNumericValue.pl -if %FlashDynamicValues_h% -f FDV_FILESTRUCTURESUBMINORVERSION>> %versionFile%
echo.>> %versionFile%
echo set flashDynamicValuesVersion=%%flashDynamicValuesVersionMajor%%.%%flashDynamicValuesVersionMinor%%.%%flashDynamicValuesVersionSubMinor%%>> %versionFile%

copy %versionFile% %versionFile:.txt=.bat%
call %versionFile:.txt=.bat%
del %versionFile:.txt=.bat%
