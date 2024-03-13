## Physical Constraints Section


###############  DATA INTERFACE  #############

set_property PACKAGE_PIN N23 [get_ports CLK_DATA_N]
set_property IOSTANDARD LVDS_25 [get_ports CLK_DATA_*]
set_property DIFF_TERM TRUE [get_ports CLK_DATA_*]

set_property PACKAGE_PIN R20 [get_ports {DATA_N[8]}]
set_property PACKAGE_PIN T23 [get_ports {DATA_N[4]}]
set_property PACKAGE_PIN M22 [get_ports {DATA_N[6]}]
set_property PACKAGE_PIN T25 [get_ports {DATA_N[2]}]
set_property PACKAGE_PIN U20 [get_ports {DATA_N[1]}]
set_property PACKAGE_PIN T19 [get_ports {DATA_N[5]}]
set_property PACKAGE_PIN K26 [get_ports {DATA_N[3]}]
set_property PACKAGE_PIN N17 [get_ports {DATA_N[7]}]
set_property IOSTANDARD LVDS_25 [get_ports DATA_*]
set_property DIFF_TERM TRUE [get_ports DATA_*]


###############  CONTROL INTERFACE  #############

set_property PACKAGE_PIN P20 [get_ports CLK_DDR_N]
set_property IOSTANDARD LVDS_25 [get_ports CLK_DDR_*]
set_property DIFF_TERM FALSE [get_ports CLK_DDR_*]

set_property PACKAGE_PIN N24 [get_ports MON_SW_CLK]
set_property IOSTANDARD LVCMOS25 [get_ports MON_SW_CLK]
set_property PACKAGE_PIN P24 [get_ports MON_SW_SDI]
set_property IOSTANDARD LVCMOS25 [get_ports MON_SW_SDI]
set_property PACKAGE_PIN P26 [get_ports MON_SDO]
set_property IOSTANDARD LVCMOS25 [get_ports MON_SDO]
set_property PULLTYPE PULLDOWN [get_ports MON_SDO]
set_property PACKAGE_PIN R26 [get_ports MON_CS_N]
set_property IOSTANDARD LVCMOS25 [get_ports MON_CS_N]
#set_property PACKAGE_PIN M20 [get_ports SW_SDO]       # not connected
#set_property IOSTANDARD LVCMOS25 [get_ports SW_SDO]
#set_property PULLTYPE PULLDOWN [get_ports SW_SDO]
set_property PACKAGE_PIN N19 [get_ports SW_CS_N]
set_property IOSTANDARD LVCMOS25 [get_ports SW_CS_N]

set_property PACKAGE_PIN M26 [get_ports PIXQNB_EN]
set_property IOSTANDARD LVCMOS25 [get_ports PIXQNB_EN]

set_property PACKAGE_PIN N26 [get_ports DAC_SCLK]
set_property IOSTANDARD LVCMOS25 [get_ports DAC_SCLK]
set_property PACKAGE_PIN L25 [get_ports DAC_SD]
set_property IOSTANDARD LVCMOS25 [get_ports DAC_SD]
set_property PACKAGE_PIN M25 [get_ports DAC_CSN]
set_property IOSTANDARD LVCMOS25 [get_ports DAC_CSN]

set_property PACKAGE_PIN R25 [get_ports CLK_RD]
set_property IOSTANDARD LVCMOS25 [get_ports CLK_RD]

set_property PACKAGE_PIN U16 [get_ports FPA_ON]
set_property IOSTANDARD LVCMOS25 [get_ports FPA_ON]

set_property PACKAGE_PIN N16 [get_ports FPA_FREQ_ID]
set_property IOSTANDARD LVCMOS25 [get_ports FPA_FREQ_ID]
set_property PULLTYPE PULLDOWN [get_ports FPA_FREQ_ID]

set_property PACKAGE_PIN AE21 [get_ports ROIC_SCLK]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_SCLK]
set_property PACKAGE_PIN AD21 [get_ports ROIC_MOSI]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_MOSI]
set_property PACKAGE_PIN V22 [get_ports ROIC_MISO]
set_property IOSTANDARD LVCMOS25 [get_ports ROIC_MISO]
set_property PULLTYPE PULLUP [get_ports ROIC_MISO]

set_property PACKAGE_PIN AF25 [get_ports CLK_FRM]
set_property IOSTANDARD LVCMOS25 [get_ports CLK_FRM]

set_property PACKAGE_PIN AF24 [get_ports POCAN_RESET]
set_property IOSTANDARD LVCMOS25 [get_ports POCAN_RESET]

