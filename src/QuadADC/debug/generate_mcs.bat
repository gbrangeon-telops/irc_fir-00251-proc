set xDir=C:\Xilinx
set bitDir=D:\telops\FIR-00251-Proc\xilinx\qadc_startup\qadc_startup.runs\impl_1
set binDir=D:\telops\FIR-00251-Proc\src\QuadADC\debug
set baseName=qadc_rx_board_startup_top_level

set x_promgen=%xDir%\14.7\LabTools\LabTools\bin\nt64\promgen.exe

%x_promgen% -w -p mcs -spi -c FF -o "%binDir%\%baseName%.mcs" -s 16384 -u 0 %bitDir%\%baseName%.bit 