set releaseDir="%binDir%\Release_%firmwareVersion:.=_% (%sensorName%)"
set paperworkTemplateDir=%scriptsDir%\paperwork\template

rem Clean up
del %paperworkTemplateDir%.zip
rd %releaseDir% /s /q

mkdir %releaseDir%\FIR-00251-Proc\
copy %binDir%\prom\*.* %releaseDir%\FIR-00251-Proc\

mkdir %releaseDir%\FIR-00251-Output\
copy %outputDir%\bin\prom\*.* %releaseDir%\FIR-00251-Output\

mkdir %releaseDir%\FIR-00257-Storage\
copy %storageDir%\bin\prom\*.* %releaseDir%\FIR-00257-Storage\

mkdir %releaseDir%\FIR-00251-NTx-Mini\
copy %ntxminiDir%\CommonTEL2000LibProject_xml_%xmlVersion%_%sensorWidth%x%sensorHeight%.exe %releaseDir%\FIR-00251-NTx-Mini\CommonTEL2000LibProject_xml_%xmlVersion%_%sensorWidth%x%sensorHeight%.exe

%x_xilperl% %scriptsDir%\paperwork\generatePaperwork.pl -sensor %sensorName% ^
   -v %firmwareVersion% -o %outputRevFile% -storage_revs %storageRevFile% -p %revFile% -x %xmlVersion% -fs %flashSettingsVersion% -fdv %flashDynamicValuesVersion% -t %paperworkTemplateDir%

%zip% a -r -tzip %paperworkTemplateDir%.zip %paperworkTemplateDir%\*.*

move %paperworkTemplateDir%.zip %releaseDir%\Release_%firmwareVersion:.=_%.xlsx

echo F:\Production\IRCAM\Firmwares\tsirfu_batch.bat %firmwareVersion%> %releaseDir%\Release_%firmwareVersion:.=_%.bat
