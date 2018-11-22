set firmwareArchive="F:\DisqueTELOPS\Production\IRCAM\Firmwares\Archive"
set releaseDir="%binDir%\Release_%firmwareVersion:.=_% (%sensorName%)"
set paperworkTemplateDir=%scriptsDir%\paperwork\template
set ntxminiFile=CommonTEL2000LibProject_xml_%xmlVersion%_%sensorWidth%x%sensorHeight%.exe
set fubatch=%releaseDir%\Release_%firmwareVersion:.=_%.bat

rem Clean up
del %paperworkTemplateDir%.zip
rd %releaseDir% /s /q

rem Prepare firmware package
mkdir %releaseDir%\FIR-00251-Proc\
copy %binDir%\prom\*.* %releaseDir%\FIR-00251-Proc\

mkdir %releaseDir%\FIR-00251-Output\
copy %outputDir%\bin\prom\*.* %releaseDir%\FIR-00251-Output\

mkdir %releaseDir%\FIR-00257-Storage\
copy %storageDir%\bin\prom\*.* %releaseDir%\FIR-00257-Storage\

mkdir %releaseDir%\FIR-00251-NTx-Mini\
copy %ntxminiDir%\%ntxminiFile% %releaseDir%\FIR-00251-NTx-Mini\%ntxminiFile% 

%x_xilperl% %scriptsDir%\paperwork\generatePaperwork.pl -sensor %sensorName% ^
   -v %firmwareVersion% -o %outputRevFile% -storage_revs1 %storageRevFile1% -storage_revs2 %storageRevFile2% -p %revFile% -x %xmlVersion% -fs %flashSettingsVersion% -fdv %flashDynamicValuesVersion% -t %paperworkTemplateDir%

%zip% a -r -tzip %paperworkTemplateDir%.zip %paperworkTemplateDir%\*.*

move %paperworkTemplateDir%.zip %releaseDir%\Release_%firmwareVersion:.=_%.xlsx
cscript.exe %scriptsDir%\xlsx2pdf.js %releaseDir%\Release_%firmwareVersion:.=_%.xlsx

rem Generate firmware updater batch file
echo @echo off> %fubatch%
echo.>> %fubatch%
echo set fu_exe=tsirfu.exe>> %fubatch%
echo.>> %fubatch%
echo where %%fu_exe%%>> %fubatch%
echo if %%errorlevel%% == 0 goto start_fu>> %fubatch%
echo.>> %fubatch%
echo set fu_retry=0 >> %fubatch%
echo :findfu>> %fubatch%
echo if not exist %%fu_exe%% (>> %fubatch%
echo    if %%fu_retry%% == 2 (>> %fubatch%
echo       echo Error: Cannot find firmware updater.>> %fubatch%
echo       pause>> %fubatch%
echo       goto end>> %fubatch%
echo    )>> %fubatch%
echo    set fu_exe=..\%%fu_exe%%>> %fubatch%
echo    set /a fu_retry+=1 >> %fubatch%
echo    goto findfu>> %fubatch%
echo )>> %fubatch%
echo.>> %fubatch%
echo :start_fu>> %fubatch%
echo.>> %fubatch%
echo FIR-00251-NTx-Mini\%ntxminiFile%>> %fubatch%
echo if not %%errorlevel%% == 0 goto end>> %fubatch%
echo.>> %fubatch%
echo %%fu_exe%% -p p FIR-00251-Proc\fir_00251_proc_%sensorName%.mcs>> %fubatch%
echo %%fu_exe%% -p o FIR-00251-Output\fir_00251_output.mcs>> %fubatch%
echo %%fu_exe%% -p s FIR-00257-Storage\fir_00257_storage.mcs>> %fubatch%
echo.>> %fubatch%
echo pause>> %fubatch%
echo.>> %fubatch%
echo :end>> %fubatch%

rem move /-Y %releaseDir% %firmwareArchive%
