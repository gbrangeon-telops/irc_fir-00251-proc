rem Clean up
del %binDir%\download_%fpgaSize%.bit
del %binDir%\tempS0_%fpgaSize%.srec
del %binDir%\tempS3_%fpgaSize%.srec
del %binDir%\_data2mem_%fpgaSize%.log
del %binDir%\_promgen_%fpgaSize%.log

rem Fetch hw and sw files
call %scriptsDir%\fetchHwSwFiles.bat
set bitFile=%sdkDir%\hw_platform_%fpgaSize%\%baseName%.bit
set mmiFile=%sdkDir%\hw_platform_%fpgaSize%\%baseName%.mmi

rem Integrate boot loader elf file to bit file
set mcuInstPath=ACQ/BD/core_wrapper_i/core_i/MCU/microblaze_1
if "%sensorName%" == "startup" (
	set mcuInstPath=U1/%mcuInstPath%
)
call %x_updatemem% -meminfo %mmiFile% -data %bootFile% -bit %bitFile% -proc %mcuInstPath% -out %binDir%\download_%fpgaSize%.bit -force
if errorlevel 1 (
	echo ELF anb bit file integration failed!
	pause
	exit
)
rem Clean up
del %binDir%\scripts\%fpgaSize%\updatemem*

rem Generate SREC image file
%x_mb-objcopy% -O srec --srec-forceS3 --srec-len=16 %elfFile% %binDir%\tempS3_%fpgaSize%.srec
%x_xilperl% %scriptsDir%\setSRecordS0.pl -i %binDir%\tempS3_%fpgaSize%.srec -t %baseName% -o %binDir%\tempS0_%fpgaSize%.srec

rem Generate PROM file
rem %x_promgen% -w -p mcs -spi -c FF -o "%binDir%\prom\%baseName%_%fpgaSize%.mcs" -s 16384 -u 0 %binDir%\download_%fpgaSize%.bit -data_file up 670000 "%releaseFile%" -data_file up 680000 "%binDir%\tempS0_%fpgaSize%.srec" > %binDir%\_promgen_%fpgaSize%.log

IF [%fpgaSize%]==[160] (
%x_promgen% -w -p mcs -spi -c FF -o "%binDir%\prom\%baseName%_%fpgaSize%.mcs" -s 16384 -u 0 %binDir%\download_%fpgaSize%.bit -data_file up 670000 "%releaseFile%" -data_file up 680000 "%binDir%\tempS0_%fpgaSize%.srec" > %binDir%\_promgen_%fpgaSize%.log
 ) ELSE ( 
%x_promgen% -w -p mcs -spi -c FF -o "%binDir%\prom\%baseName%_%fpgaSize%.mcs" -s 16384 -u 0 %binDir%\download_%fpgaSize%.bit -data_file up AF0000 "%releaseFile%" -data_file up B00000 "%binDir%\tempS0_%fpgaSize%.srec" > %binDir%\_promgen_%fpgaSize%.log
 )
if errorlevel 1 (
	echo PROM file generation failed!
	pause
   exit
)
