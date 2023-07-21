rem Parse HW Rev file
set hwRevFile=%sdkDir%\fir_00251_proc_%sensorName%_%fpgaSize%_hw_svn_rev.txt
for /f "tokens=2 delims=:" %%G in ('findstr /c:"encryption key" %hwRevFile%') do (
   set temp_encrypt_key_name=%%G
   goto continue
)
:continue
rem Remove spaces
set encrypt_key_name=%temp_encrypt_key_name: =%

rem Set variables
if %sensorName%==startup (
   set releaseDir="%binDir%\Release_%firmwareVersion:.=_% (%sensorName%_%fpgaSize%, %encrypt_key_name% key)"
) else (
   if %sensorName%==startup_4DDR ( 
      set releaseDir="%binDir%\Release_%firmwareVersion:.=_% (%sensorName%_%fpgaSize%, %encrypt_key_name% key)"
   ) else (
      set releaseDir="%binDir%\Release_%firmwareVersion:.=_% (%sensorName%, %encrypt_key_name% key)"
   ) 
)
set paperworkTemplateDir=%scriptsDir%\paperwork_%fpgaSize%\template
set ntxminiFileBaseName=CommonTEL2000LibProject_xml_%xmlVersion%
set ntxminiFile=%ntxminiFileBaseName%_%sensorWidth%x%sensorHeight%.bat
set fubatch=%releaseDir%\Release_%firmwareVersion:.=_%.bat
set fubatchJtag=%releaseDir%\Release_%firmwareVersion:.=_%_jtag.bat
set cfiFile=%binDir%\prom\%baseName%_%fpgaSize%.cfi
set jtagPromBridgeDir="\\STARK\DisqueTELOPS\Production\IRCAM\Tools\PROM-JTAG Bridge"

rem Clean up
del %paperworkTemplateDir%.zip
for /f "delims=" %%G in ('dir /b /a:d %binDir% ^| findstr "Release_"') do (
   rd "%binDir%\%%G" /s /q
)

rem Verify encryption consistency
for /f %%i in ('%x_xsct% %scriptsDir%\getEncryptationStatus.tcl %binDir%\Prom\%baseName%_%fpgaSize%.mcs') do  set encrypt_key_status=%%i

if not %encrypt_key_status%==NONE (
 echo Bitstream encrypted 
 rem todo what to do with encrypt_key_name
 set encrypt_key_name=key_name
 goto consistent
)
if %encrypt_key_status%==NONE (
 echo Bitstream unencrypted
 goto consistent
)

:inconsistent
echo hwRevFile and cfiFile are not consistent!
pause
exit
:consistent

rem Prepare firmware package
mkdir %releaseDir%\FIR-00251-Proc\
copy %binDir%\prom\%baseName%_%fpgaSize%.* %releaseDir%\FIR-00251-Proc\
copy %jtagPromBridgeDir%\scripts\jtag_prom_prog.bat %releaseDir%\FIR-00251-Proc\
if errorlevel 1 goto err

mkdir %releaseDir%\FIR-00251-Output\
copy %outputDir%\bin\prom\%outputBaseName%.* %releaseDir%\FIR-00251-Output\
copy %jtagPromBridgeDir%\scripts\jtag_prom_prog.bat %releaseDir%\FIR-00251-Output\
if errorlevel 1 goto err

mkdir %releaseDir%\FIR-00257-Storage\
copy %storageDir%\bin\prom\*.* %releaseDir%\FIR-00257-Storage\
copy %jtagPromBridgeDir%\scripts\jtag_prom_prog.bat %releaseDir%\FIR-00257-Storage\
if errorlevel 1 goto err

mkdir %releaseDir%\FIR-00251-NTx-Mini\
mkdir %releaseDir%\FIR-00251-NTx-Mini\%ntxminiFileBaseName%
copy %ntxminiDir%\%ntxminiFileBaseName%\%ntxminiFileBaseName%_%sensorWidth%x%sensorHeight%_*.exe %releaseDir%\FIR-00251-NTx-Mini\%ntxminiFileBaseName%
if errorlevel 1 goto err
copy %ntxminiDir%\%ntxminiFile% %releaseDir%\FIR-00251-NTx-Mini
if errorlevel 1 goto err

%x_xsct% %scriptsDir%\paperwork_%fpgaSize%\generatePaperwork.tcl -sensor %sensorName% -key %encrypt_key_name% ^
   -v %firmwareVersion% -o %outputRevFile% -storage_revs1 %storageRevFile1% -storage_revs2 %storageRevFile2% -p %revFile% -x %xmlVersion% -fs %flashSettingsVersion% -fdv %flashDynamicValuesVersion% -cal %calibFilesVersion% -t %paperworkTemplateDir%
   
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
echo cd FIR-00251-NTx-Mini>> %fubatch%
echo call %ntxminiFile%>> %fubatch%
echo if not %%errorlevel%% == 0 goto err>> %fubatch%
echo cd ..>> %fubatch%
echo.>> %fubatch%
echo %%fu_exe%% -p p FIR-00251-Proc\fir_00251_proc_%sensorName%_%fpgaSize%.mcs>> %fubatch%
echo %%fu_exe%% -p o FIR-00251-Output\%outputBaseName%.mcs>> %fubatch%
echo %%fu_exe%% -p s FIR-00257-Storage\fir_00257_storage.mcs>> %fubatch%
echo.>> %fubatch%
echo pause>> %fubatch%
echo.>> %fubatch%
echo :end>> %fubatch%
echo exit>> %fubatch%
echo.>> %fubatch%
echo :err>> %fubatch%
echo echo "NTx-Mini update failed!">> %fubatch%
echo pause>> %fubatch%

rem Generate firmware programmer batch file for JTAG
echo @echo off> %fubatchJtag%
echo.>> %fubatchJtag%
echo :start_fu>> %fubatchJtag%
echo.>> %fubatchJtag%
echo cd FIR-00251-NTx-Mini>> %fubatchJtag%
echo call %ntxminiFile%>> %fubatchJtag%
echo if not %%errorlevel%% == 0 goto err>> %fubatchJtag%
echo cd ..>> %fubatchJtag%
echo.>> %fubatchJtag%
echo cd FIR-00251-Proc>> %fubatchJtag%
echo call jtag_prom_prog.bat>> %fubatchJtag%
echo cd ..\FIR-00251-Output>> %fubatchJtag%
echo call jtag_prom_prog.bat>> %fubatchJtag%
echo cd ..\FIR-00257-Storage>> %fubatchJtag%
echo call jtag_prom_prog.bat>> %fubatchJtag%
echo cd ..>> %fubatchJtag%
echo.>> %fubatchJtag%
echo :end>> %fubatchJtag%
echo exit>> %fubatchJtag%
echo.>> %fubatchJtag%
echo :err>> %fubatchJtag%
echo echo "NTx-Mini update failed!">> %fubatchJtag%
echo pause>> %fubatchJtag%
goto end

:err
echo Copy failed!
pause
exit

:end
