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
   set releaseDir="%binDir%\Release_%firmwareVersion:.=_% (%sensorName%, %encrypt_key_name% key)"
)
set paperworkTemplateDir=%scriptsDir%\paperwork_%fpgaSize%\template
set ntxminiFile=CommonTEL2000LibProject_xml_%xmlVersion%_%sensorWidth%x%sensorHeight%.exe
set fubatch=%releaseDir%\Release_%firmwareVersion:.=_%.bat
set cfiFile=%binDir%\prom\%baseName%_%fpgaSize%.cfi

rem Clean up
del %paperworkTemplateDir%.zip
for /f "delims=" %%G in ('dir /b /a:d %binDir% ^| findstr "Release_"') do (
   rd "%binDir%\%%G" /s /q
)

rem Verify encryption consistency
set cfiFileLineFound=0
for /f "delims=" %%G in ('findstr /c:"%baseName%_%fpgaSize%.bit" %cfiFile%') do (
   set cfiFileLine=%%G
   set cfiFileLineFound=1
)
if %cfiFileLineFound%==1 (
   if %cfiFileLine:~-9%==ENCRYPTED (
      if not %encrypt_key_name%==NONE (
         echo Bitstream encrypted with %encrypt_key_name% key
         goto consistent
      )
   ) else (
      if %encrypt_key_name%==NONE (
         echo Bitstream unencrypted
         goto consistent
      )
   )
)
:inconsistent
echo hwRevFile and cfiFile are not consistent!
pause
exit
:consistent

rem Prepare firmware package
mkdir %releaseDir%\FIR-00251-Proc\
copy %binDir%\prom\%baseName%_%fpgaSize%.* %releaseDir%\FIR-00251-Proc\
if errorlevel 1 goto err

mkdir %releaseDir%\FIR-00251-Output\
copy %outputDir%\bin\prom\%outputBaseName%.* %releaseDir%\FIR-00251-Output\
if errorlevel 1 goto err

mkdir %releaseDir%\FIR-00257-Storage\
copy %storageDir%\bin\prom\*.* %releaseDir%\FIR-00257-Storage\
if errorlevel 1 goto err

mkdir %releaseDir%\FIR-00251-NTx-Mini\
copy %ntxminiDir%\%ntxminiFile% %releaseDir%\FIR-00251-NTx-Mini\%ntxminiFile% 
if errorlevel 1 goto err

%x_xilperl% %scriptsDir%\paperwork_%fpgaSize%\generatePaperwork.pl -sensor %sensorName% -key %encrypt_key_name% ^
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
echo FIR-00251-NTx-Mini\%ntxminiFile%>> %fubatch%
echo if not %%errorlevel%% == 0 goto end>> %fubatch%
echo.>> %fubatch%
echo %%fu_exe%% -p p FIR-00251-Proc\fir_00251_proc_%sensorName%_%fpgaSize%.mcs>> %fubatch%
echo %%fu_exe%% -p o FIR-00251-Output\%outputBaseName%.mcs>> %fubatch%
echo %%fu_exe%% -p s FIR-00257-Storage\fir_00257_storage.mcs>> %fubatch%
echo.>> %fubatch%
echo pause>> %fubatch%
echo.>> %fubatch%
echo :end>> %fubatch%
goto end

:err
echo Copy failed!
pause
exit

:end
