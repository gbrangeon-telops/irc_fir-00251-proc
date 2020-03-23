rem Clean up
del %binDir%\tempS0_%fpgaSize%.srec
del %binDir%\tempS3_%fpgaSize%.srec
del %binDir%\_promgen_%fpgaSize%.log

rem Fetch hw and sw files
call %scriptsDir%\fetchHwSwFiles.bat
set bitFile=%sdkDir%\%baseName%_%fpgaSize%.bit

rem Generate SREC image file
%x_mb-objcopy% -O srec --srec-forceS3 --srec-len=16 %elfFile% %binDir%\tempS3_%fpgaSize%.srec
%x_xilperl% %scriptsDir%\setSRecordS0.pl -i %binDir%\tempS3_%fpgaSize%.srec -t %baseName% -o %binDir%\tempS0_%fpgaSize%.srec

IF [%fpgaSize%]==[160] (
%x_promgen% -w -p mcs -spi -c FF -o "%binDir%\prom\%baseName%_%fpgaSize%.mcs" -s 16384 -u 0 %bitFile% -data_file up 670000 "%releaseFile%" -data_file up 680000 "%binDir%\tempS0_%fpgaSize%.srec" > %binDir%\_promgen_%fpgaSize%.log
 ) ELSE ( 
%x_promgen% -w -p mcs -spi -c FF -o "%binDir%\prom\%baseName%_%fpgaSize%.mcs" -s 16384 -u 0 %bitFile% -data_file up AF0000 "%releaseFile%" -data_file up B00000 "%binDir%\tempS0_%fpgaSize%.srec" > %binDir%\_promgen_%fpgaSize%.log
 )
if errorlevel 1 (
	echo PROM file generation failed!
	pause
   exit
)
