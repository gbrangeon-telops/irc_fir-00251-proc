rem Clean up
del %srecFile%
del %binDir%\download.bit
del %binDir%\temp.srec
del %binDir%\_data2mem.log
del %binDir%\_promgen.log

rem Fetch hw and sw files
call %scriptsDir%\fetchHwSwFiles.bat

rem Integrate boot loader elf file to bit file
%x_data2mem% -bm %bmmFile% -bt %bitFile% -bd %bootFile% -o b %binDir%\download.bit -log %binDir%\_data2mem.log

rem Generate SREC image file
%x_mb-objcopy% -O srec --srec-forceS3 --srec-len=16 %elfFile% %binDir%\temp.srec
%x_xilperl% %scriptsDir%\setSRecordS0.pl -i %binDir%\temp.srec -t %baseName% -o %srecFile%

rem Generate PROM file
%x_promgen% -w -p mcs -spi -c FF -o "%binDir%\prom\%baseName%.mcs" -s 16384 -u 0 %binDir%\download.bit -data_file up 670000 "%releaseFile%" -data_file up 680000 "%srecFile%" > %binDir%\_promgen.log
