-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Fri Aug 19 13:56:12 2016
-- Host        : TELOPS229 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               D:/Telops/FIR-00251-Proc/IP/ip_axis32_fanout3/ip_axis32_fanout3_funcsim.vhdl
-- Design      : ip_axis32_fanout3
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axis32_fanout3axis_broadcaster_v1_1_core is
  port (
    s_axis_tready : out STD_LOGIC;
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    aresetn : in STD_LOGIC;
    aclken : in STD_LOGIC;
    m_axis_tready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axis_tvalid : in STD_LOGIC;
    aclk : in STD_LOGIC
  );
end ip_axis32_fanout3axis_broadcaster_v1_1_core;

architecture STRUCTURE of ip_axis32_fanout3axis_broadcaster_v1_1_core is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \n_0_m_ready_d[0]_i_1\ : STD_LOGIC;
  signal \n_0_m_ready_d[0]_i_2\ : STD_LOGIC;
  signal \n_0_m_ready_d[1]_i_1\ : STD_LOGIC;
  signal \n_0_m_ready_d[2]_i_1\ : STD_LOGIC;
  signal \n_0_m_ready_d[2]_i_2\ : STD_LOGIC;
  signal \n_0_m_ready_d_reg[0]\ : STD_LOGIC;
  signal \n_0_m_ready_d_reg[1]\ : STD_LOGIC;
  signal \n_0_m_ready_d_reg[2]\ : STD_LOGIC;
  signal n_0_s_axis_tready_INST_0_i_1 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \m_axis_tvalid[0]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \m_axis_tvalid[1]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \m_axis_tvalid[2]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \m_ready_d[0]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \m_ready_d[2]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of s_axis_tready_INST_0 : label is "soft_lutpair2";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\m_axis_tvalid[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => aresetn,
      I1 => s_axis_tvalid,
      I2 => \n_0_m_ready_d_reg[0]\,
      O => m_axis_tvalid(0)
    );
\m_axis_tvalid[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => aresetn,
      I1 => s_axis_tvalid,
      I2 => \n_0_m_ready_d_reg[1]\,
      O => m_axis_tvalid(1)
    );
\m_axis_tvalid[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => aresetn,
      I1 => s_axis_tvalid,
      I2 => \n_0_m_ready_d_reg[2]\,
      O => m_axis_tvalid(2)
    );
\m_ready_d[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8808880888088888"
    )
    port map (
      I0 => \n_0_m_ready_d[0]_i_2\,
      I1 => aresetn,
      I2 => aclken,
      I3 => n_0_s_axis_tready_INST_0_i_1,
      I4 => \n_0_m_ready_d_reg[1]\,
      I5 => m_axis_tready(1),
      O => \n_0_m_ready_d[0]_i_1\
    );
\m_ready_d[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF8000"
    )
    port map (
      I0 => s_axis_tvalid,
      I1 => aresetn,
      I2 => m_axis_tready(0),
      I3 => aclken,
      I4 => \n_0_m_ready_d_reg[0]\,
      O => \n_0_m_ready_d[0]_i_2\
    );
\m_ready_d[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CC0C8000CC0C0000"
    )
    port map (
      I0 => s_axis_tvalid,
      I1 => aresetn,
      I2 => aclken,
      I3 => n_0_s_axis_tready_INST_0_i_1,
      I4 => \n_0_m_ready_d_reg[1]\,
      I5 => m_axis_tready(1),
      O => \n_0_m_ready_d[1]_i_1\
    );
\m_ready_d[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8808880888088888"
    )
    port map (
      I0 => \n_0_m_ready_d[2]_i_2\,
      I1 => aresetn,
      I2 => aclken,
      I3 => n_0_s_axis_tready_INST_0_i_1,
      I4 => \n_0_m_ready_d_reg[1]\,
      I5 => m_axis_tready(1),
      O => \n_0_m_ready_d[2]_i_1\
    );
\m_ready_d[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF8000"
    )
    port map (
      I0 => s_axis_tvalid,
      I1 => aresetn,
      I2 => m_axis_tready(2),
      I3 => aclken,
      I4 => \n_0_m_ready_d_reg[2]\,
      O => \n_0_m_ready_d[2]_i_2\
    );
\m_ready_d_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_m_ready_d[0]_i_1\,
      Q => \n_0_m_ready_d_reg[0]\,
      R => \<const0>\
    );
\m_ready_d_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_m_ready_d[1]_i_1\,
      Q => \n_0_m_ready_d_reg[1]\,
      R => \<const0>\
    );
\m_ready_d_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_m_ready_d[2]_i_1\,
      Q => \n_0_m_ready_d_reg[2]\,
      R => \<const0>\
    );
s_axis_tready_INST_0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00A8"
    )
    port map (
      I0 => aresetn,
      I1 => m_axis_tready(1),
      I2 => \n_0_m_ready_d_reg[1]\,
      I3 => n_0_s_axis_tready_INST_0_i_1,
      O => s_axis_tready
    );
s_axis_tready_INST_0_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"111F"
    )
    port map (
      I0 => \n_0_m_ready_d_reg[2]\,
      I1 => m_axis_tready(2),
      I2 => \n_0_m_ready_d_reg[0]\,
      I3 => m_axis_tready(0),
      O => n_0_s_axis_tready_INST_0_i_1
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axis_tlast : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 23 downto 0 )
  );
  attribute C_FAMILY : string;
  attribute C_FAMILY of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is "rtl";
  attribute C_NUM_MI_SLOTS : integer;
  attribute C_NUM_MI_SLOTS of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 3;
  attribute C_S_AXIS_TDATA_WIDTH : integer;
  attribute C_S_AXIS_TDATA_WIDTH of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 32;
  attribute C_M_AXIS_TDATA_WIDTH : integer;
  attribute C_M_AXIS_TDATA_WIDTH of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 32;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 1;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 3;
  attribute C_S_AXIS_TUSER_WIDTH : integer;
  attribute C_S_AXIS_TUSER_WIDTH of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 8;
  attribute C_M_AXIS_TUSER_WIDTH : integer;
  attribute C_M_AXIS_TUSER_WIDTH of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 8;
  attribute C_AXIS_SIGNAL_SET : integer;
  attribute C_AXIS_SIGNAL_SET of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 255;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 0;
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 1;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 2;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 4;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 5;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 6;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 7;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 1;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 2;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 4;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 16;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 32;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 64;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 2;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 1;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 0;
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 : entity is 53;
end ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3;

architecture STRUCTURE of ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3 is
  signal \^s_axis_tdata\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^s_axis_tdest\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^s_axis_tid\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^s_axis_tkeep\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^s_axis_tlast\ : STD_LOGIC;
  signal \^s_axis_tstrb\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^s_axis_tuser\ : STD_LOGIC_VECTOR ( 7 downto 0 );
begin
  \^s_axis_tdata\(31 downto 0) <= s_axis_tdata(31 downto 0);
  \^s_axis_tdest\(2 downto 0) <= s_axis_tdest(2 downto 0);
  \^s_axis_tid\(0) <= s_axis_tid(0);
  \^s_axis_tkeep\(3 downto 0) <= s_axis_tkeep(3 downto 0);
  \^s_axis_tlast\ <= s_axis_tlast;
  \^s_axis_tstrb\(3 downto 0) <= s_axis_tstrb(3 downto 0);
  \^s_axis_tuser\(7 downto 0) <= s_axis_tuser(7 downto 0);
  m_axis_tdata(95 downto 64) <= \^s_axis_tdata\(31 downto 0);
  m_axis_tdata(63 downto 32) <= \^s_axis_tdata\(31 downto 0);
  m_axis_tdata(31 downto 0) <= \^s_axis_tdata\(31 downto 0);
  m_axis_tdest(8 downto 6) <= \^s_axis_tdest\(2 downto 0);
  m_axis_tdest(5 downto 3) <= \^s_axis_tdest\(2 downto 0);
  m_axis_tdest(2 downto 0) <= \^s_axis_tdest\(2 downto 0);
  m_axis_tid(2) <= \^s_axis_tid\(0);
  m_axis_tid(1) <= \^s_axis_tid\(0);
  m_axis_tid(0) <= \^s_axis_tid\(0);
  m_axis_tkeep(11 downto 8) <= \^s_axis_tkeep\(3 downto 0);
  m_axis_tkeep(7 downto 4) <= \^s_axis_tkeep\(3 downto 0);
  m_axis_tkeep(3 downto 0) <= \^s_axis_tkeep\(3 downto 0);
  m_axis_tlast(2) <= \^s_axis_tlast\;
  m_axis_tlast(1) <= \^s_axis_tlast\;
  m_axis_tlast(0) <= \^s_axis_tlast\;
  m_axis_tstrb(11 downto 8) <= \^s_axis_tstrb\(3 downto 0);
  m_axis_tstrb(7 downto 4) <= \^s_axis_tstrb\(3 downto 0);
  m_axis_tstrb(3 downto 0) <= \^s_axis_tstrb\(3 downto 0);
  m_axis_tuser(23 downto 16) <= \^s_axis_tuser\(7 downto 0);
  m_axis_tuser(15 downto 8) <= \^s_axis_tuser\(7 downto 0);
  m_axis_tuser(7 downto 0) <= \^s_axis_tuser\(7 downto 0);
broadcaster_core: entity work.ip_axis32_fanout3axis_broadcaster_v1_1_core
    port map (
      aclk => aclk,
      aclken => aclken,
      aresetn => aresetn,
      m_axis_tready(2 downto 0) => m_axis_tready(2 downto 0),
      m_axis_tvalid(2 downto 0) => m_axis_tvalid(2 downto 0),
      s_axis_tready => s_axis_tready,
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axis32_fanout3 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axis_tlast : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 23 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ip_axis32_fanout3 : entity is true;
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of ip_axis32_fanout3 : entity is "axis_broadcaster_v1_1_top_ip_axis32_fanout3,Vivado 2013.4";
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ip_axis32_fanout3 : entity is "ip_axis32_fanout3,axis_broadcaster_v1_1_top_ip_axis32_fanout3,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of ip_axis32_fanout3 : entity is "ip_axis32_fanout3,axis_broadcaster_v1_1_top_ip_axis32_fanout3,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=axis_broadcaster,x_ipVersion=1.1,x_ipCoreRevision=1,x_ipLanguage=VHDL,C_NUM_MI_SLOTS=3,C_S_AXIS_TDATA_WIDTH=32,C_M_AXIS_TDATA_WIDTH=32,C_AXIS_TID_WIDTH=1,C_AXIS_TDEST_WIDTH=3,C_S_AXIS_TUSER_WIDTH=8,C_M_AXIS_TUSER_WIDTH=8,C_AXIS_SIGNAL_SET=0b11111111}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of ip_axis32_fanout3 : entity is "yes";
end ip_axis32_fanout3;

architecture STRUCTURE of ip_axis32_fanout3 is
  signal \<const1>\ : STD_LOGIC;
  attribute C_AXIS_SIGNAL_SET : integer;
  attribute C_AXIS_SIGNAL_SET of inst : label is 255;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of inst : label is 3;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of inst : label is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "rtl";
  attribute C_M_AXIS_TDATA_WIDTH : integer;
  attribute C_M_AXIS_TDATA_WIDTH of inst : label is 32;
  attribute C_M_AXIS_TUSER_WIDTH : integer;
  attribute C_M_AXIS_TUSER_WIDTH of inst : label is 8;
  attribute C_NUM_MI_SLOTS : integer;
  attribute C_NUM_MI_SLOTS of inst : label is 3;
  attribute C_S_AXIS_TDATA_WIDTH : integer;
  attribute C_S_AXIS_TDATA_WIDTH of inst : label is 32;
  attribute C_S_AXIS_TUSER_WIDTH : integer;
  attribute C_S_AXIS_TUSER_WIDTH of inst : label is 8;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of inst : label is true;
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
  attribute P_TPAYLOAD_WIDTH of inst : label is 53;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of inst : label is "xilinx.com:interface:axis:1.0 S_AXIS TREADY";
begin
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
inst: entity work.ip_axis32_fanout3axis_broadcaster_v1_1_top_ip_axis32_fanout3
    port map (
      aclk => aclk,
      aclken => \<const1>\,
      aresetn => aresetn,
      m_axis_tdata(95 downto 0) => m_axis_tdata(95 downto 0),
      m_axis_tdest(8 downto 0) => m_axis_tdest(8 downto 0),
      m_axis_tid(2 downto 0) => m_axis_tid(2 downto 0),
      m_axis_tkeep(11 downto 0) => m_axis_tkeep(11 downto 0),
      m_axis_tlast(2 downto 0) => m_axis_tlast(2 downto 0),
      m_axis_tready(2 downto 0) => m_axis_tready(2 downto 0),
      m_axis_tstrb(11 downto 0) => m_axis_tstrb(11 downto 0),
      m_axis_tuser(23 downto 0) => m_axis_tuser(23 downto 0),
      m_axis_tvalid(2 downto 0) => m_axis_tvalid(2 downto 0),
      s_axis_tdata(31 downto 0) => s_axis_tdata(31 downto 0),
      s_axis_tdest(2 downto 0) => s_axis_tdest(2 downto 0),
      s_axis_tid(0) => s_axis_tid(0),
      s_axis_tkeep(3 downto 0) => s_axis_tkeep(3 downto 0),
      s_axis_tlast => s_axis_tlast,
      s_axis_tready => s_axis_tready,
      s_axis_tstrb(3 downto 0) => s_axis_tstrb(3 downto 0),
      s_axis_tuser(7 downto 0) => s_axis_tuser(7 downto 0),
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
