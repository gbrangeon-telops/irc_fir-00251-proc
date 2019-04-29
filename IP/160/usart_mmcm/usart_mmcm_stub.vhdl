-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
-- Date        : Mon Apr 01 17:52:14 2019
-- Host        : TELOPS258-7 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub D:/Telops/FIR-00251-Proc/IP/160/usart_mmcm/usart_mmcm_stub.vhdl
-- Design      : usart_mmcm
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity usart_mmcm is
  Port ( 
    CLK0 : out STD_LOGIC;
    CLK180 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    CLK : in STD_LOGIC
  );

end usart_mmcm;

architecture stub of usart_mmcm is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK0,CLK180,reset,locked,CLK";
begin
end;
