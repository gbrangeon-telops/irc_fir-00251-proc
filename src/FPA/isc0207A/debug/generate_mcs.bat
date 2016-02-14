set xDir=C:\Xilinx
set bitDir=D:\Telops\FIR-00251-Proc\xilinx\adc_brd_dbg\adc_brd_dbg.runs\impl_1
set binDir=D:\Telops\FIR-00251-Proc\src\FPA\isc0207A\debug\bin
set baseName=adc_brd_mux_dbg

set x_promgen=%xDir%\14.7\LabTools\LabTools\bin\nt64\promgen.exe

%x_promgen% -w -p mcs -spi -c FF -o "%binDir%\%baseName%.mcs" -s 16384 -u 0 %bitDir%\%baseName%.bit 