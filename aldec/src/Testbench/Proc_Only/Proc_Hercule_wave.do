onerror { resume }
transcript off
add wave -noreg -logic {/Processing_tb/U2/ACLK}
add wave -noreg -logic {/Processing_tb/U2/ARESETN}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/AWADDR}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/AWPROT}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/AWREADY}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/AWVALID}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/WVALID}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/WREADY}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/WDATA}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/WSTRB}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/BVALID}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/BREADY}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/BRESP}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/ARVALID}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/ARREADY}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/ARADDR}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/ARPROT}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/RVALID}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/RREADY}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/RDATA}
add wave -noreg -hexadecimal -literal {/Processing_tb/U2/RRESP}
add wave -noreg -logic {/Processing_tb/XADC/ACLK}
add wave -noreg -logic {/Processing_tb/XADC/ARESETN}
add wave -noreg -hexadecimal -literal {/Processing_tb/XADC/XADC_MOSI}
add wave -noreg -hexadecimal -literal {/Processing_tb/XADC/XADC_MISO}
add wave -noreg -logic {/Processing_tb/CLINK_UART/ACLK}
add wave -noreg -logic {/Processing_tb/CLINK_UART/ARESETN}
add wave -noreg -hexadecimal -literal {/Processing_tb/CLINK_UART/AXI4_LITE_MISO}
add wave -noreg -hexadecimal -literal {/Processing_tb/CLINK_UART/AXI4_LITE_MOSI}
add wave -noreg -logic {/Processing_tb/CLINK_UART/INTERRUPT}
add wave -noreg -logic {/Processing_tb/CLINK_UART/RX}
add wave -noreg -logic {/Processing_tb/CLINK_UART/TX}
add wave -noreg -logic {/Processing_tb/INTC/ACLK}
add wave -noreg -logic {/Processing_tb/INTC/ARESETN}
add wave -noreg -hexadecimal -literal {/Processing_tb/INTC/AXI4_LITE_MISO}
add wave -noreg -hexadecimal -literal {/Processing_tb/INTC/AXI4_LITE_MOSI}
add wave -noreg -hexadecimal -literal {/Processing_tb/INTC/INTERRUPT}
add wave -noreg -hexadecimal -literal {/Processing_tb/INTC/INTERRUPT_ADDRESS}
add wave -noreg -logic {/Processing_tb/INTC/IRQ}
add wave -noreg -hexadecimal -literal {/Processing_tb/INTC/PROCESSOR_ACK}
add wave -noreg -logic {/Processing_tb/INTC/PROCESSOR_CLK}
add wave -noreg -logic {/Processing_tb/INTC/PROCESSOR_RST}
cursor "Cursor 1" 500us  
cursor "Cursor 2" 64003681ps  
transcript on
