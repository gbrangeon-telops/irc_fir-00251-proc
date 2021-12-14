## Physical Constraints Section

############### DEVICE PARAMETER ##################
set_property DCI_CASCADE {34} [get_iobanks 33]

############################### GT LOC ###################################
# IMPORTANT : Proccessing fpga can be build with or without a mgt for video streaming. A choice must be made between two set of constraints. 

	# Use the following contraints for a build without the video mgt (when MGT_2CH = false on top bde) 
	set_logic_unconnected [get_ports {VIDEO_UPLINK_N[0]}]
	#set_logic_unconnected [get_ports {VIDEO_UPLINK_N[1]}] 
	set_logic_unconnected [get_ports {VIDEO_UPLINK_P[0]}]
	#set_logic_unconnected [get_ports {VIDEO_UPLINK_P[1]}] 

	#Use the following contraints for a build with the video mgt (when MGT_2CH = true on top bde) 
#	set_property PACKAGE_PIN K1 [get_ports {VIDEO_UPLINK_N[0]}]
#	set_property PACKAGE_PIN H1 [get_ports {VIDEO_UPLINK_N[1]}]
	

###############  ADC INTERFACE  #############
# quad1 outputs clock
set_property PACKAGE_PIN P23 [get_ports CH0_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH0_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH0_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH0_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH0_CLK_N]

# quad2 outputs clock
set_property PACKAGE_PIN N21 [get_ports CH1_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH1_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH1_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH1_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH1_CLK_N]

# quad3 outputs clock
#set_property PACKAGE_PIN R23 [get_ports CH2_CLK_N]
#set_property IOSTANDARD LVDS_25 [get_ports CH2_CLK_P]
#set_property IOSTANDARD LVDS_25 [get_ports CH2_CLK_N]
#set_property DIFF_TERM TRUE [get_ports CH2_CLK_P]
#set_property DIFF_TERM TRUE [get_ports CH2_CLK_N]

# quad4 outputs clock
#set_property PACKAGE_PIN AC24 [get_ports CH3_CLK_N]
#set_property IOSTANDARD LVDS_25 [get_ports CH3_CLK_P]
#set_property IOSTANDARD LVDS_25 [get_ports CH3_CLK_N]
#set_property DIFF_TERM TRUE [get_ports CH3_CLK_P]
#set_property DIFF_TERM TRUE [get_ports CH3_CLK_N]

# quad1 (adc1 to adc4) data link
set_property PACKAGE_PIN R20 [get_ports {CH0_DATA_N[0]}]
set_property PACKAGE_PIN T23 [get_ports {CH0_DATA_N[1]}]
set_property PACKAGE_PIN M22 [get_ports {CH0_DATA_N[2]}]
set_property PACKAGE_PIN T25 [get_ports {CH0_DATA_N[3]}]
set_property IOSTANDARD LVDS_25 [get_ports CH0_DATA_*]
set_property DIFF_TERM true [get_ports CH0_DATA_*]

# quad2 (adc5 to adc8) data link                                                                
set_property PACKAGE_PIN U20 [get_ports {CH1_DATA_N[0]}]
set_property PACKAGE_PIN T19 [get_ports {CH1_DATA_N[1]}]
set_property PACKAGE_PIN K26 [get_ports {CH1_DATA_N[2]}]
set_property PACKAGE_PIN N17 [get_ports {CH1_DATA_N[3]}]
set_property IOSTANDARD LVDS_25 [get_ports CH1_DATA_*]
set_property DIFF_TERM true [get_ports CH1_DATA_*]

# quad3 (adc9 to adc12) data link                                                                              
#set_property PACKAGE_PIN P18 [get_ports {CH2_DATA_N[0]}]
#set_property PACKAGE_PIN T17 [get_ports {CH2_DATA_N[1]}]
#set_property PACKAGE_PIN M19 [get_ports {CH2_DATA_N[2]}]
#set_property PACKAGE_PIN R17 [get_ports {CH2_DATA_N[3]}]
#set_property IOSTANDARD LVDS_25 [get_ports CH2_DATA_*]
#set_property DIFF_TERM true [get_ports CH2_DATA_*]

# quad4 (adc13 to adc16) data link                                                                            
#set_property PACKAGE_PIN Y21 [get_ports {CH3_DATA_N[0]}]
#set_property PACKAGE_PIN AD24 [get_ports {CH3_DATA_N[1]}]
#set_property PACKAGE_PIN AC22 [get_ports {CH3_DATA_N[2]}]
#set_property PACKAGE_PIN AC21 [get_ports {CH3_DATA_N[3]}]
#set_property IOSTANDARD LVDS_25 [get_ports CH3_DATA_*]
#set_property DIFF_TERM true [get_ports CH3_DATA_*]

# quads clks sources                                                         
#set_property PACKAGE_PIN L24 [get_ports QUAD3_CLK]
#set_property PACKAGE_PIN M24 [get_ports QUAD4_CLK]
set_property PACKAGE_PIN P20 [get_ports QUAD1_CLK]
set_property PACKAGE_PIN P19 [get_ports QUAD2_CLK]
#set_property IOSTANDARD LVCMOS25 [get_ports QUAD3_CLK]
#set_property IOSTANDARD LVCMOS25 [get_ports QUAD4_CLK]
set_property IOSTANDARD LVCMOS25 [get_ports QUAD1_CLK]
set_property IOSTANDARD LVCMOS25 [get_ports QUAD2_CLK]

# fpa_digios out                                                                           
set_property PACKAGE_PIN M26 [get_ports FPA_DIGIO1]
set_property PACKAGE_PIN N26 [get_ports FPA_DIGIO2]
set_property PACKAGE_PIN N24 [get_ports FPA_DIGIO3]
set_property PACKAGE_PIN P24 [get_ports FPA_DIGIO4]
set_property PACKAGE_PIN L25 [get_ports FPA_DIGIO5]
set_property PACKAGE_PIN M25 [get_ports FPA_DIGIO6]
set_property PACKAGE_PIN P26 [get_ports FPA_DIGIO7]
set_property PACKAGE_PIN R26 [get_ports FPA_DIGIO8]
set_property PACKAGE_PIN M20 [get_ports FPA_DIGIO9]
set_property PACKAGE_PIN N19 [get_ports FPA_DIGIO10]
#set_property IOB TRUE [get_ports FPA_DIGIO*] 

# fpa_digios in  
set_property PACKAGE_PIN P25 [get_ports FPA_DIGIO11]
set_property PACKAGE_PIN R25 [get_ports FPA_DIGIO12]
set_property IOSTANDARD LVCMOS25 [get_ports FPA_DIGIO*]
#set_property IOB TRUE [get_ports FPA_DIGIO*] 

# fpa_freq_id
set_property PACKAGE_PIN N16 [get_ports FPA_FREQ_ID]
set_property IOSTANDARD LVCMOS25 [get_ports FPA_FREQ_ID]
set_property IOB TRUE [get_ports FPA_FREQ_ID]
set_property PULLDOWN true [get_ports FPA_FREQ_ID]

# fpa_on                                                                                                      
set_property PACKAGE_PIN U16 [get_ports FPA_ON]
set_property IOSTANDARD LVCMOS25 [get_ports FPA_ON]
set_property IOB TRUE [get_ports FPA_ON]

# spi signals                                                                           
set_property PACKAGE_PIN V22 [get_ports SPI_CSN]
set_property PACKAGE_PIN U22 [get_ports SPI_SCLK]
set_property PACKAGE_PIN AF25 [get_ports SPI_SDI]
set_property PACKAGE_PIN AF24 [get_ports SPI_SDO]
set_property PACKAGE_PIN AE21 [get_ports SPI_MUX0]
set_property PACKAGE_PIN AD21 [get_ports SPI_MUX1]

set_property IOSTANDARD LVCMOS25 [get_ports SPI_*]
set_property IOB TRUE [get_ports SPI_SDO]
set_property IOB TRUE [get_ports SPI_CSN]
set_property IOB TRUE [get_ports SPI_MUX0]
set_property IOB TRUE [get_ports SPI_MUX1]
set_property IOB TRUE [get_ports SPI_SCLK]
set_property IOB TRUE [get_ports SPI_SDI]


################### DDR3 ######################
#Unused IO (needed when MEM_4DDR = 0)

set_property -dict {PACKAGE_PIN AF17 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[32]]
set_property -dict {PACKAGE_PIN AE17 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[33]]
set_property -dict {PACKAGE_PIN AF14 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[34]]
set_property -dict {PACKAGE_PIN AF15 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[35]]
set_property -dict {PACKAGE_PIN AD15 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[36]]
set_property -dict {PACKAGE_PIN AE15 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[37]]
set_property -dict {PACKAGE_PIN AF19 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[38]]
set_property -dict {PACKAGE_PIN AF20 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[39]]
set_property -dict {PACKAGE_PIN AA14 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[40]]
set_property -dict {PACKAGE_PIN AA15 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[41]]
set_property -dict {PACKAGE_PIN AC14 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[42]]
set_property -dict {PACKAGE_PIN AD14 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[43]]
set_property -dict {PACKAGE_PIN AB15 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[44]]
set_property -dict {PACKAGE_PIN AB14 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[45]]
set_property -dict {PACKAGE_PIN AA18 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[46]]
set_property -dict {PACKAGE_PIN AA17 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[47]]
set_property -dict {PACKAGE_PIN AD18 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[48]]
set_property -dict {PACKAGE_PIN AC18 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[49]]
set_property -dict {PACKAGE_PIN AC17 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[50]]
set_property -dict {PACKAGE_PIN AB17 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[51]]
set_property -dict {PACKAGE_PIN AA20 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[52]]
set_property -dict {PACKAGE_PIN AA19 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[53]]
set_property -dict {PACKAGE_PIN AD19 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[54]]
set_property -dict {PACKAGE_PIN AC19 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[55]]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[56]]
set_property -dict {PACKAGE_PIN Y17 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[57]]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[58]]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[59]]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[60]]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[61]]
set_property -dict {PACKAGE_PIN V18 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[62]]
set_property -dict {PACKAGE_PIN V19 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dq[63]]

set_property -dict {PACKAGE_PIN AD16 IOSTANDARD SSTL15 slew SLOW} [get_ports CAL_DDR_dm[4]]
set_property -dict {PACKAGE_PIN AB16 IOSTANDARD SSTL15 slew SLOW} [get_ports CAL_DDR_dm[5]]
set_property -dict {PACKAGE_PIN AB20 IOSTANDARD SSTL15 slew SLOW} [get_ports CAL_DDR_dm[6]]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD SSTL15 slew SLOW} [get_ports CAL_DDR_dm[7]]

set_property -dict {PACKAGE_PIN AF18 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dqs_n[4]]
set_property -dict {PACKAGE_PIN Y16 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dqs_n[5]]
set_property -dict {PACKAGE_PIN AE20 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dqs_n[6]]
set_property -dict {PACKAGE_PIN W19 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dqs_n[7]]

set_property -dict {PACKAGE_PIN AE18 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dqs_p[4]]
set_property -dict {PACKAGE_PIN Y15 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dqs_p[5]]
set_property -dict {PACKAGE_PIN AD20 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dqs_p[6]]
set_property -dict {PACKAGE_PIN W18 IOSTANDARD SSTL15_T_DCI slew SLOW} [get_ports CAL_DDR_dqs_p[7]]