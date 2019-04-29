-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
-- Date        : Mon Apr 01 17:36:44 2019
-- Host        : TELOPS258-7 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/Telops/FIR-00251-Proc/IP/160/histogram_axis_tmi_4pix_0/histogram_axis_tmi_4pix_0_stub.vhdl
-- Design      : histogram_axis_tmi_4pix_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity histogram_axis_tmi_4pix_0 is
  Port ( 
    areset : in STD_LOGIC;
    clear_mem : in STD_LOGIC;
    ext_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ext_data_in2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    msb_pos : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rx_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    rx_tlast : in STD_LOGIC;
    rx_tready : in STD_LOGIC;
    rx_tvalid : in STD_LOGIC;
    tmi_mosi_add : in STD_LOGIC_VECTOR ( 6 downto 0 );
    tmi_mosi_dval : in STD_LOGIC;
    tmi_mosi_rnw : in STD_LOGIC;
    clk : in STD_LOGIC;
    ext_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ext_data_out2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    histogram_rdy : out STD_LOGIC;
    timestamp : out STD_LOGIC_VECTOR ( 31 downto 0 );
    tmi_miso_busy : out STD_LOGIC;
    tmi_miso_error : out STD_LOGIC;
    tmi_miso_idle : out STD_LOGIC;
    tmi_miso_rd_data : out STD_LOGIC_VECTOR ( 20 downto 0 );
    tmi_miso_rd_dval : out STD_LOGIC
  );

end histogram_axis_tmi_4pix_0;

architecture stub of histogram_axis_tmi_4pix_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "areset,clear_mem,ext_data_in[31:0],ext_data_in2[31:0],msb_pos[1:0],rx_tdata[63:0],rx_tlast,rx_tready,rx_tvalid,tmi_mosi_add[6:0],tmi_mosi_dval,tmi_mosi_rnw,clk,ext_data_out[31:0],ext_data_out2[31:0],histogram_rdy,timestamp[31:0],tmi_miso_busy,tmi_miso_error,tmi_miso_idle,tmi_miso_rd_data[20:0],tmi_miso_rd_dval";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "histogram_axis_tmi_4pix,Vivado 2016.3";
begin
end;
