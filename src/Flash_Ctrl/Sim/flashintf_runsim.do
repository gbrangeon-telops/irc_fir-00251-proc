onerror { resume }
transcript off
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/Flash_Command_In}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/Flash_Command_Out}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/Flash_Command_Ctrl}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/Flash_Data_In}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/Flash_Data_Out}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/Flash_Data_Ctrl}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/NAND_SM}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U1/U1/ReadyBusyN}
add wave -noreg -logic {/flashintf_testbench/U2/CLK100}
add wave -noreg -logic {/flashintf_testbench/U2/Rst}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/Axi_Mosi}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/Axi_Miso}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/BRAM_Mosi}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/BRAM_Miso}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/cfg_waddr}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/cfg_raddr}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/cfg_read_data}
add wave -noreg -logic {/flashintf_testbench/U1/U1/cfg_wren}
add wave -noreg -logic {/flashintf_testbench/U1/U1/cfg_rden}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/axi_mosi_i}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/axi_miso_i}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/nand_sm_i}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/flash_command_out_i}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/flash_command_ctrl_i}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/flash_data_out_i}
add wave -noreg -hexadecimal -literal -unsigned {/flashintf_testbench/U1/U1/flash_data_ctrl_i}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U1/U2/Axi_Mosi}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U1/U2/Axi_Miso}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U2/TestReadValue}
add wave -noreg -logic {/flashintf_testbench/U1/U4/clka}
add wave -noreg -logic {/flashintf_testbench/U1/U4/rsta}
add wave -noreg -logic {/flashintf_testbench/U1/U4/ena}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U1/U4/wea}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U1/U4/addra}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U1/U4/dina}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U1/U4/douta}
add wave -noreg -logic {/flashintf_testbench/U1/U4/clkb}
add wave -noreg -logic {/flashintf_testbench/U1/U4/rstb}
add wave -noreg -logic {/flashintf_testbench/U1/U4/enb}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U1/U4/web}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U1/U4/addrb}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U1/U4/dinb}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U1/U4/doutb}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U2/FlashReadyBusy}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U2/CmdIO}
add wave -noreg -hexadecimal -literal {/flashintf_testbench/U2/DataIO}
cursor "Cursor 1" 81.34ns  
transcript on
