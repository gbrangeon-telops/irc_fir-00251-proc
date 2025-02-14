-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3_AR71948_AR71898 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Thu Feb 22 09:28:50 2024
-- Host        : Telops331 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               D:/Telops/FIR-00251-Proc/IP/325/ip_axis128_fanout2/ip_axis128_fanout2_sim_netlist.vhdl
-- Design      : ip_axis128_fanout2
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k325tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_axis128_fanout2_axis_broadcaster_v1_1_17_core is
  port (
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tready : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_axis128_fanout2_axis_broadcaster_v1_1_17_core : entity is "axis_broadcaster_v1_1_17_core";
end ip_axis128_fanout2_axis_broadcaster_v1_1_17_core;

architecture STRUCTURE of ip_axis128_fanout2_axis_broadcaster_v1_1_17_core is
  signal \m_ready_d[0]_i_1_n_0\ : STD_LOGIC;
  signal \m_ready_d[1]_i_1_n_0\ : STD_LOGIC;
  signal \m_ready_d[1]_i_2_n_0\ : STD_LOGIC;
  signal \m_ready_d_reg_n_0_[0]\ : STD_LOGIC;
  signal \m_ready_d_reg_n_0_[1]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \m_axis_tvalid[0]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \m_axis_tvalid[1]_INST_0\ : label is "soft_lutpair0";
begin
\m_axis_tvalid[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => aresetn,
      I1 => s_axis_tvalid,
      I2 => \m_ready_d_reg_n_0_[0]\,
      O => m_axis_tvalid(0)
    );
\m_axis_tvalid[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => aresetn,
      I1 => s_axis_tvalid,
      I2 => \m_ready_d_reg_n_0_[1]\,
      O => m_axis_tvalid(1)
    );
\m_ready_d[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAAAAAA"
    )
        port map (
      I0 => \m_ready_d_reg_n_0_[0]\,
      I1 => aclken,
      I2 => s_axis_tvalid,
      I3 => aresetn,
      I4 => m_axis_tready(0),
      I5 => \m_ready_d[1]_i_2_n_0\,
      O => \m_ready_d[0]_i_1_n_0\
    );
\m_ready_d[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAAAAAA"
    )
        port map (
      I0 => \m_ready_d_reg_n_0_[1]\,
      I1 => aclken,
      I2 => s_axis_tvalid,
      I3 => aresetn,
      I4 => m_axis_tready(1),
      I5 => \m_ready_d[1]_i_2_n_0\,
      O => \m_ready_d[1]_i_1_n_0\
    );
\m_ready_d[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEE00000FFFFFFFF"
    )
        port map (
      I0 => \m_ready_d_reg_n_0_[1]\,
      I1 => m_axis_tready(1),
      I2 => \m_ready_d_reg_n_0_[0]\,
      I3 => m_axis_tready(0),
      I4 => aclken,
      I5 => aresetn,
      O => \m_ready_d[1]_i_2_n_0\
    );
\m_ready_d_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_ready_d[0]_i_1_n_0\,
      Q => \m_ready_d_reg_n_0_[0]\,
      R => '0'
    );
\m_ready_d_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_ready_d[1]_i_1_n_0\,
      Q => \m_ready_d_reg_n_0_[1]\,
      R => '0'
    );
s_axis_tready_INST_0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EEE00000"
    )
        port map (
      I0 => \m_ready_d_reg_n_0_[1]\,
      I1 => m_axis_tready(1),
      I2 => \m_ready_d_reg_n_0_[0]\,
      I3 => m_axis_tready(0),
      I4 => aresetn,
      O => s_axis_tready
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_axis128_fanout2_top_ip_axis128_fanout2 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tlast : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 63 downto 0 )
  );
  attribute C_AXIS_SIGNAL_SET : integer;
  attribute C_AXIS_SIGNAL_SET of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 255;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 3;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is "kintex7";
  attribute C_M_AXIS_TDATA_WIDTH : integer;
  attribute C_M_AXIS_TDATA_WIDTH of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 128;
  attribute C_M_AXIS_TUSER_WIDTH : integer;
  attribute C_M_AXIS_TUSER_WIDTH of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 32;
  attribute C_NUM_MI_SLOTS : integer;
  attribute C_NUM_MI_SLOTS of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 2;
  attribute C_S_AXIS_TDATA_WIDTH : integer;
  attribute C_S_AXIS_TDATA_WIDTH of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 128;
  attribute C_S_AXIS_TUSER_WIDTH : integer;
  attribute C_S_AXIS_TUSER_WIDTH of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 32;
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is "top_ip_axis128_fanout2";
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of ip_axis128_fanout2_top_ip_axis128_fanout2 : entity is 197;
end ip_axis128_fanout2_top_ip_axis128_fanout2;

architecture STRUCTURE of ip_axis128_fanout2_top_ip_axis128_fanout2 is
  signal \^s_axis_tdata\ : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal \^s_axis_tdest\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^s_axis_tid\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^s_axis_tkeep\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^s_axis_tlast\ : STD_LOGIC;
  signal \^s_axis_tstrb\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^s_axis_tuser\ : STD_LOGIC_VECTOR ( 31 downto 0 );
begin
  \^s_axis_tdata\(127 downto 0) <= s_axis_tdata(127 downto 0);
  \^s_axis_tdest\(2 downto 0) <= s_axis_tdest(2 downto 0);
  \^s_axis_tid\(0) <= s_axis_tid(0);
  \^s_axis_tkeep\(15 downto 0) <= s_axis_tkeep(15 downto 0);
  \^s_axis_tlast\ <= s_axis_tlast;
  \^s_axis_tstrb\(15 downto 0) <= s_axis_tstrb(15 downto 0);
  \^s_axis_tuser\(31 downto 0) <= s_axis_tuser(31 downto 0);
  m_axis_tdata(255 downto 128) <= \^s_axis_tdata\(127 downto 0);
  m_axis_tdata(127 downto 0) <= \^s_axis_tdata\(127 downto 0);
  m_axis_tdest(5 downto 3) <= \^s_axis_tdest\(2 downto 0);
  m_axis_tdest(2 downto 0) <= \^s_axis_tdest\(2 downto 0);
  m_axis_tid(1) <= \^s_axis_tid\(0);
  m_axis_tid(0) <= \^s_axis_tid\(0);
  m_axis_tkeep(31 downto 16) <= \^s_axis_tkeep\(15 downto 0);
  m_axis_tkeep(15 downto 0) <= \^s_axis_tkeep\(15 downto 0);
  m_axis_tlast(1) <= \^s_axis_tlast\;
  m_axis_tlast(0) <= \^s_axis_tlast\;
  m_axis_tstrb(31 downto 16) <= \^s_axis_tstrb\(15 downto 0);
  m_axis_tstrb(15 downto 0) <= \^s_axis_tstrb\(15 downto 0);
  m_axis_tuser(63 downto 32) <= \^s_axis_tuser\(31 downto 0);
  m_axis_tuser(31 downto 0) <= \^s_axis_tuser\(31 downto 0);
broadcaster_core: entity work.ip_axis128_fanout2_axis_broadcaster_v1_1_17_core
     port map (
      aclk => aclk,
      aclken => aclken,
      aresetn => aresetn,
      m_axis_tready(1 downto 0) => m_axis_tready(1 downto 0),
      m_axis_tvalid(1 downto 0) => m_axis_tvalid(1 downto 0),
      s_axis_tready => s_axis_tready,
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_axis128_fanout2 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tlast : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 63 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ip_axis128_fanout2 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ip_axis128_fanout2 : entity is "ip_axis128_fanout2,top_ip_axis128_fanout2,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of ip_axis128_fanout2 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of ip_axis128_fanout2 : entity is "top_ip_axis128_fanout2,Vivado 2018.3_AR71948_AR71898";
end ip_axis128_fanout2;

architecture STRUCTURE of ip_axis128_fanout2 is
  attribute C_AXIS_SIGNAL_SET : integer;
  attribute C_AXIS_SIGNAL_SET of inst : label is 255;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of inst : label is 3;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of inst : label is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "kintex7";
  attribute C_M_AXIS_TDATA_WIDTH : integer;
  attribute C_M_AXIS_TDATA_WIDTH of inst : label is 128;
  attribute C_M_AXIS_TUSER_WIDTH : integer;
  attribute C_M_AXIS_TUSER_WIDTH of inst : label is 32;
  attribute C_NUM_MI_SLOTS : integer;
  attribute C_NUM_MI_SLOTS of inst : label is 2;
  attribute C_S_AXIS_TDATA_WIDTH : integer;
  attribute C_S_AXIS_TDATA_WIDTH of inst : label is 128;
  attribute C_S_AXIS_TUSER_WIDTH : integer;
  attribute C_S_AXIS_TUSER_WIDTH of inst : label is 32;
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of inst : label is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of inst : label is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of inst : label is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of inst : label is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of inst : label is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of inst : label is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of inst : label is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of inst : label is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of inst : label is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of inst : label is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of inst : label is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of inst : label is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of inst : label is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of inst : label is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of inst : label is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of inst : label is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of inst : label is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of inst : label is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of inst : label is 1;
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of inst : label is 197;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of aclk : signal is "xilinx.com:signal:clock:1.0 CLKIF CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of aclk : signal is "XIL_INTERFACENAME CLKIF, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of aresetn : signal is "xilinx.com:signal:reset:1.0 RSTIF RST";
  attribute X_INTERFACE_PARAMETER of aresetn : signal is "XIL_INTERFACENAME RSTIF, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_tlast : signal is "xilinx.com:interface:axis:1.0 S_AXIS TLAST";
  attribute X_INTERFACE_INFO of s_axis_tready : signal is "xilinx.com:interface:axis:1.0 S_AXIS TREADY";
  attribute X_INTERFACE_INFO of s_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 S_AXIS TVALID";
  attribute X_INTERFACE_INFO of m_axis_tdata : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TDATA [127:0] [127:0], xilinx.com:interface:axis:1.0 M01_AXIS TDATA [127:0] [255:128]";
  attribute X_INTERFACE_INFO of m_axis_tdest : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TDEST [2:0] [2:0], xilinx.com:interface:axis:1.0 M01_AXIS TDEST [2:0] [5:3]";
  attribute X_INTERFACE_INFO of m_axis_tid : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TID [0:0] [0:0], xilinx.com:interface:axis:1.0 M01_AXIS TID [0:0] [1:1]";
  attribute X_INTERFACE_INFO of m_axis_tkeep : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TKEEP [15:0] [15:0], xilinx.com:interface:axis:1.0 M01_AXIS TKEEP [15:0] [31:16]";
  attribute X_INTERFACE_INFO of m_axis_tlast : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TLAST [0:0] [0:0], xilinx.com:interface:axis:1.0 M01_AXIS TLAST [0:0] [1:1]";
  attribute X_INTERFACE_INFO of m_axis_tready : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TREADY [0:0] [0:0], xilinx.com:interface:axis:1.0 M01_AXIS TREADY [0:0] [1:1]";
  attribute X_INTERFACE_INFO of m_axis_tstrb : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TSTRB [15:0] [15:0], xilinx.com:interface:axis:1.0 M01_AXIS TSTRB [15:0] [31:16]";
  attribute X_INTERFACE_INFO of m_axis_tuser : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TUSER [31:0] [31:0], xilinx.com:interface:axis:1.0 M01_AXIS TUSER [31:0] [63:32]";
  attribute X_INTERFACE_PARAMETER of m_axis_tuser : signal is "XIL_INTERFACENAME M00_AXIS, TDATA_NUM_BYTES 16, TDEST_WIDTH 3, TID_WIDTH 1, TUSER_WIDTH 32, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0, XIL_INTERFACENAME M01_AXIS, TDATA_NUM_BYTES 16, TDEST_WIDTH 3, TID_WIDTH 1, TUSER_WIDTH 32, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TVALID [0:0] [0:0], xilinx.com:interface:axis:1.0 M01_AXIS TVALID [0:0] [1:1]";
  attribute X_INTERFACE_INFO of s_axis_tdata : signal is "xilinx.com:interface:axis:1.0 S_AXIS TDATA";
  attribute X_INTERFACE_INFO of s_axis_tdest : signal is "xilinx.com:interface:axis:1.0 S_AXIS TDEST";
  attribute X_INTERFACE_INFO of s_axis_tid : signal is "xilinx.com:interface:axis:1.0 S_AXIS TID";
  attribute X_INTERFACE_INFO of s_axis_tkeep : signal is "xilinx.com:interface:axis:1.0 S_AXIS TKEEP";
  attribute X_INTERFACE_INFO of s_axis_tstrb : signal is "xilinx.com:interface:axis:1.0 S_AXIS TSTRB";
  attribute X_INTERFACE_INFO of s_axis_tuser : signal is "xilinx.com:interface:axis:1.0 S_AXIS TUSER";
  attribute X_INTERFACE_PARAMETER of s_axis_tuser : signal is "XIL_INTERFACENAME S_AXIS, TDATA_NUM_BYTES 16, TDEST_WIDTH 3, TID_WIDTH 1, TUSER_WIDTH 32, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0";
begin
inst: entity work.ip_axis128_fanout2_top_ip_axis128_fanout2
     port map (
      aclk => aclk,
      aclken => '1',
      aresetn => aresetn,
      m_axis_tdata(255 downto 0) => m_axis_tdata(255 downto 0),
      m_axis_tdest(5 downto 0) => m_axis_tdest(5 downto 0),
      m_axis_tid(1 downto 0) => m_axis_tid(1 downto 0),
      m_axis_tkeep(31 downto 0) => m_axis_tkeep(31 downto 0),
      m_axis_tlast(1 downto 0) => m_axis_tlast(1 downto 0),
      m_axis_tready(1 downto 0) => m_axis_tready(1 downto 0),
      m_axis_tstrb(31 downto 0) => m_axis_tstrb(31 downto 0),
      m_axis_tuser(63 downto 0) => m_axis_tuser(63 downto 0),
      m_axis_tvalid(1 downto 0) => m_axis_tvalid(1 downto 0),
      s_axis_tdata(127 downto 0) => s_axis_tdata(127 downto 0),
      s_axis_tdest(2 downto 0) => s_axis_tdest(2 downto 0),
      s_axis_tid(0) => s_axis_tid(0),
      s_axis_tkeep(15 downto 0) => s_axis_tkeep(15 downto 0),
      s_axis_tlast => s_axis_tlast,
      s_axis_tready => s_axis_tready,
      s_axis_tstrb(15 downto 0) => s_axis_tstrb(15 downto 0),
      s_axis_tuser(31 downto 0) => s_axis_tuser(31 downto 0),
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
