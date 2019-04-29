set config=Release

rem Clean up
del %elfFile%
del %bootFile%
del %bitFile%
del %bmmFile%

rem Fetch hw and sw files
copy %sdkDir%\%baseName%\%config%\%baseName%.elf %elfFile%
copy %sdkDir%\%baseName%_boot\%config%\%baseName%_boot.elf %bootFile%
copy %sdkDir%\hw\%baseName%.bit %bitFile%
copy %sdkDir%\hw\%baseName%_bd.bmm %bmmFile%

