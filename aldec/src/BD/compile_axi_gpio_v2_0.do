alib interrupt_control_v3_0
setactivelib interrupt_control_v3_0

acom -O3 -work interrupt_control_v3_0 -2002  -relax D:/Xilinx/Vivado/2013.4/data/ip/xilinx/interrupt_control_v3_0/hdl/src/vhdl/interrupt_control.vhd


alib axi_gpio_v2_0
setactivelib axi_gpio_v2_0

acom -O3 -work axi_gpio_v2_0 -2002  -relax D:/Xilinx/Vivado/2013.4/data/ip/xilinx/axi_gpio_v2_0/hdl/src/vhdl/gpio_core.vhd
acom -O3 -work axi_gpio_v2_0 -2002  -relax D:/Xilinx/Vivado/2013.4/data/ip/xilinx/axi_gpio_v2_0/hdl/src/vhdl/axi_gpio.vhd

setactivelib work





