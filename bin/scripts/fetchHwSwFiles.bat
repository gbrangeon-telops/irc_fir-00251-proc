set config=Release

rem Clean up
del %elfFile%

rem Fetch hw and sw files
copy %sdkDir%\%baseName%_%fpgaSize%\%config%\%baseName%_%fpgaSize%.elf %elfFile%
if errorlevel 1 (
   echo Copy failed!
   pause
   exit
)
