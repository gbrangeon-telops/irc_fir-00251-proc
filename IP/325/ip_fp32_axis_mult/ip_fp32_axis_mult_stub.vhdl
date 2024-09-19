-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3.1_AR71948_AR71898 (win64) Build 2489853 Tue Mar 26 04:20:25 MDT 2019
-- Date        : Wed Sep 18 15:16:55 2024
-- Host        : TELOPS352 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/Telops/Git/ircam_fir-00251-proc_temp/IP/325/ip_fp32_axis_mult/ip_fp32_axis_mult_stub.vhdl
-- Design      : ip_fp32_axis_mult
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ip_fp32_axis_mult is
  Port ( 
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_a_tvalid : in STD_LOGIC;
    s_axis_a_tready : out STD_LOGIC;
    s_axis_a_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_a_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_a_tlast : in STD_LOGIC;
    s_axis_b_tvalid : in STD_LOGIC;
    s_axis_b_tready : out STD_LOGIC;
    s_axis_b_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_b_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_b_tlast : in STD_LOGIC;
    m_axis_result_tvalid : out STD_LOGIC;
    m_axis_result_tready : in STD_LOGIC;
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_result_tuser : out STD_LOGIC_VECTOR ( 18 downto 0 );
    m_axis_result_tlast : out STD_LOGIC
  );

end ip_fp32_axis_mult;

architecture stub of ip_fp32_axis_mult is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,aresetn,s_axis_a_tvalid,s_axis_a_tready,s_axis_a_tdata[31:0],s_axis_a_tuser[7:0],s_axis_a_tlast,s_axis_b_tvalid,s_axis_b_tready,s_axis_b_tdata[31:0],s_axis_b_tuser[7:0],s_axis_b_tlast,m_axis_result_tvalid,m_axis_result_tready,m_axis_result_tdata[31:0],m_axis_result_tuser[18:0],m_axis_result_tlast";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "floating_point_v7_1_7,Vivado 2018.3.1_AR71948_AR71898";
begin
end;
