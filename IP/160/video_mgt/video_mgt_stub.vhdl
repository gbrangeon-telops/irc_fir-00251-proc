-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
-- Date        : Mon Apr 01 17:52:51 2019
-- Host        : TELOPS258-7 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub D:/Telops/FIR-00251-Proc/IP/160/video_mgt/video_mgt_stub.vhdl
-- Design      : video_mgt
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity video_mgt is
  Port ( 
    s_axi_tx_tdata : in STD_LOGIC_VECTOR ( 0 to 63 );
    s_axi_tx_tvalid : in STD_LOGIC;
    s_axi_tx_tready : out STD_LOGIC;
    s_axi_tx_tkeep : in STD_LOGIC_VECTOR ( 0 to 7 );
    s_axi_tx_tlast : in STD_LOGIC;
    m_axi_rx_tdata : out STD_LOGIC_VECTOR ( 0 to 63 );
    m_axi_rx_tvalid : out STD_LOGIC;
    m_axi_rx_tkeep : out STD_LOGIC_VECTOR ( 0 to 7 );
    m_axi_rx_tlast : out STD_LOGIC;
    rxp : in STD_LOGIC_VECTOR ( 0 to 1 );
    rxn : in STD_LOGIC_VECTOR ( 0 to 1 );
    txp : out STD_LOGIC_VECTOR ( 0 to 1 );
    txn : out STD_LOGIC_VECTOR ( 0 to 1 );
    gt_refclk1 : in STD_LOGIC;
    frame_err : out STD_LOGIC;
    hard_err : out STD_LOGIC;
    soft_err : out STD_LOGIC;
    channel_up : out STD_LOGIC;
    lane_up : out STD_LOGIC_VECTOR ( 0 to 1 );
    user_clk : in STD_LOGIC;
    sync_clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    power_down : in STD_LOGIC;
    loopback : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gt_reset : in STD_LOGIC;
    tx_lock : out STD_LOGIC;
    sys_reset_out : out STD_LOGIC;
    init_clk_in : in STD_LOGIC;
    tx_resetdone_out : out STD_LOGIC;
    rx_resetdone_out : out STD_LOGIC;
    link_reset_out : out STD_LOGIC;
    drpclk_in : in STD_LOGIC;
    drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drpen_in : in STD_LOGIC;
    drprdy_out : out STD_LOGIC;
    drpwe_in : in STD_LOGIC;
    drpaddr_in_lane1 : in STD_LOGIC_VECTOR ( 8 downto 0 );
    drpdi_in_lane1 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    drpdo_out_lane1 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drpen_in_lane1 : in STD_LOGIC;
    drprdy_out_lane1 : out STD_LOGIC;
    drpwe_in_lane1 : in STD_LOGIC;
    gt0_qplllock_in : in STD_LOGIC;
    gt0_qpllrefclklost_in : in STD_LOGIC;
    gt0_qpllreset_out : out STD_LOGIC;
    gt_qpllclk_quad1_in : in STD_LOGIC;
    gt_qpllrefclk_quad1_in : in STD_LOGIC;
    tx_out_clk : out STD_LOGIC;
    pll_not_locked : in STD_LOGIC
  );

end video_mgt;

architecture stub of video_mgt is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s_axi_tx_tdata[0:63],s_axi_tx_tvalid,s_axi_tx_tready,s_axi_tx_tkeep[0:7],s_axi_tx_tlast,m_axi_rx_tdata[0:63],m_axi_rx_tvalid,m_axi_rx_tkeep[0:7],m_axi_rx_tlast,rxp[0:1],rxn[0:1],txp[0:1],txn[0:1],gt_refclk1,frame_err,hard_err,soft_err,channel_up,lane_up[0:1],user_clk,sync_clk,reset,power_down,loopback[2:0],gt_reset,tx_lock,sys_reset_out,init_clk_in,tx_resetdone_out,rx_resetdone_out,link_reset_out,drpclk_in,drpaddr_in[8:0],drpdi_in[15:0],drpdo_out[15:0],drpen_in,drprdy_out,drpwe_in,drpaddr_in_lane1[8:0],drpdi_in_lane1[15:0],drpdo_out_lane1[15:0],drpen_in_lane1,drprdy_out_lane1,drpwe_in_lane1,gt0_qplllock_in,gt0_qpllrefclklost_in,gt0_qpllreset_out,gt_qpllclk_quad1_in,gt_qpllrefclk_quad1_in,tx_out_clk,pll_not_locked";
begin
end;
