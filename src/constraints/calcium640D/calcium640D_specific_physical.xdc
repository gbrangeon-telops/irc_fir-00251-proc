## Physical Constraints Section

###############  DETECTOR INTERFACE  #############
set_property PACKAGE_PIN N23 [get_ports CH0_CLK_N]
set_property IOSTANDARD LVDS_25 [get_ports CH0_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH0_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH0_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH0_CLK_N]

set_property PACKAGE_PIN N22 [get_ports CH1_CLK_N]
set_property IOSTANDARD LVDS_25 [get_ports CH1_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH1_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH1_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH1_CLK_N]

set_property PACKAGE_PIN R23 [get_ports CH2_CLK_N]
set_property IOSTANDARD LVDS_25 [get_ports CH2_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH2_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH2_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH2_CLK_N]

set_property PACKAGE_PIN AC24 [get_ports CH3_CLK_N]
set_property IOSTANDARD LVDS_25 [get_ports CH3_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports CH3_CLK_N]
set_property DIFF_TERM TRUE [get_ports CH3_CLK_P]
set_property DIFF_TERM TRUE [get_ports CH3_CLK_N]

set_property IOSTANDARD LVDS_25 [get_ports CH0_DATA_*]
set_property IOSTANDARD LVDS_25 [get_ports CH1_DATA_*]
set_property IOSTANDARD LVDS_25 [get_ports CH2_DATA_*]
set_property IOSTANDARD LVDS_25 [get_ports CH3_DATA_*]
set_property DIFF_TERM true [get_ports CH0_DATA_*]
set_property DIFF_TERM true [get_ports CH1_DATA_*]
set_property DIFF_TERM true [get_ports CH2_DATA_*]
set_property DIFF_TERM true [get_ports CH3_DATA_*]

set_property PACKAGE_PIN R20 [get_ports {CH0_DATA_N[0]}]
set_property PACKAGE_PIN T23 [get_ports {CH0_DATA_N[1]}]
set_property PACKAGE_PIN M22 [get_ports {CH0_DATA_N[2]}]
set_property PACKAGE_PIN T25 [get_ports {CH0_DATA_N[3]}]

set_property PACKAGE_PIN U20 [get_ports {CH1_DATA_N[0]}]
set_property PACKAGE_PIN T19 [get_ports {CH1_DATA_N[1]}]
set_property PACKAGE_PIN K26 [get_ports {CH1_DATA_N[2]}]
set_property PACKAGE_PIN N17 [get_ports {CH1_DATA_N[3]}]

set_property PACKAGE_PIN P18 [get_ports {CH2_DATA_N[0]}]
set_property PACKAGE_PIN T17 [get_ports {CH2_DATA_N[1]}]
set_property PACKAGE_PIN M19 [get_ports {CH2_DATA_N[2]}]
set_property PACKAGE_PIN R17 [get_ports {CH2_DATA_N[3]}]

set_property PACKAGE_PIN Y21 [get_ports {CH3_DATA_N[0]}]
set_property PACKAGE_PIN AD24 [get_ports {CH3_DATA_N[1]}]
set_property PACKAGE_PIN AC22 [get_ports {CH3_DATA_N[2]}]
set_property PACKAGE_PIN AC21 [get_ports {CH3_DATA_N[3]}]

##################### DETECTOR ################################

# SCD proxy reset signal
set_property PACKAGE_PIN V22 [get_ports DET_SPARE_N1]
set_property IOSTANDARD LVDS_25 [get_ports DET_SPARE_P1]
set_property IOSTANDARD LVDS_25 [get_ports DET_SPARE_N1]
set_property DIFF_TERM FALSE [get_ports DET_SPARE_P1]
set_property DIFF_TERM FALSE [get_ports DET_SPARE_N1]

# SCD proxy integrate signal
set_property PACKAGE_PIN AF25 [get_ports DET_SPARE_N2]
set_property IOSTANDARD LVDS_25 [get_ports DET_SPARE_P2]
set_property IOSTANDARD LVDS_25 [get_ports DET_SPARE_N2]
set_property DIFF_TERM FALSE [get_ports DET_SPARE_P2]
set_property DIFF_TERM FALSE [get_ports DET_SPARE_N2]

set_property PACKAGE_PIN M20 [get_ports F_SYNC_N]
set_property IOSTANDARD LVDS_25 [get_ports F_SYNC_P]
set_property IOSTANDARD LVDS_25 [get_ports F_SYNC_N]
set_property DIFF_TERM FALSE [get_ports F_SYNC_P]
set_property DIFF_TERM FALSE [get_ports F_SYNC_N]

set_property PACKAGE_PIN L24 [get_ports SER_TC_N]
set_property IOSTANDARD LVDS_25 [get_ports SER_TC_P]
set_property IOSTANDARD LVDS_25 [get_ports SER_TC_N]
set_property DIFF_TERM FALSE [get_ports SER_TC_P]
set_property DIFF_TERM FALSE [get_ports SER_TC_N]

set_property PACKAGE_PIN P20 [get_ports SER_TFG_N]
set_property IOSTANDARD LVDS_25 [get_ports SER_TFG_P]
set_property IOSTANDARD LVDS_25 [get_ports SER_TFG_N]
set_property DIFF_TERM TRUE [get_ports SER_TFG_P]
set_property DIFF_TERM TRUE [get_ports SER_TFG_N]

set_property PACKAGE_PIN U16 [get_ports DET_FPA_ON]
set_property IOSTANDARD LVCMOS25 [get_ports DET_FPA_ON]

set_property PACKAGE_PIN N16 [get_ports DET_FREQ_ID]
set_property IOSTANDARD LVCMOS25 [get_ports DET_FREQ_ID]
