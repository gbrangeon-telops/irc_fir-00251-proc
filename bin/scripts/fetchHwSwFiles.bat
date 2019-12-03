set config=Release

rem Clean up
del %elfFile%
del %bootFile%

rem Fetch hw and sw files
copy %sdkDir%\%baseName%_%fpgaSize%\%config%\%baseName%_%fpgaSize%.elf %elfFile%
if errorlevel 1 goto err
copy %sdkDir%\%baseName%_boot_%fpgaSize%\%config%\%baseName%_boot_%fpgaSize%.elf %bootFile%
if errorlevel 1 goto err

goto end

:err
echo Copy failed!
pause
exit

:end
