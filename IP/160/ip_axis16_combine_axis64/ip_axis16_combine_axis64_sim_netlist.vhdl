-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3.1_AR71948_AR71898 (win64) Build 2489853 Tue Mar 26 04:20:25 MDT 2019
-- Date        : Tue Sep 17 13:58:25 2024
-- Host        : TELOPS352 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               D:/Telops/Git/ircam_fir-00251-proc_temp/IP/160/ip_axis16_combine_axis64/ip_axis16_combine_axis64_sim_netlist.vhdl
-- Design      : ip_axis16_combine_axis64
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_axis16_combine_axis64_axis_combiner_v1_1_16_top is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tready : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tlast : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 15 downto 0 );
    s_cmd_err : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute C_AXIS_SIGNAL_SET : integer;
  attribute C_AXIS_SIGNAL_SET of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 255;
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 16;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 3;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 4;
  attribute C_FAMILY : string;
  attribute C_FAMILY of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is "kintex7";
  attribute C_MASTER_PORT_NUM : integer;
  attribute C_MASTER_PORT_NUM of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 0;
  attribute C_NUM_SI_SLOTS : integer;
  attribute C_NUM_SI_SLOTS of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 4;
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is "axis_combiner_v1_1_16_top";
  attribute P_MASTER_PORT_NUM : integer;
  attribute P_MASTER_PORT_NUM of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 0;
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top : entity is 101;
end ip_axis16_combine_axis64_axis_combiner_v1_1_16_top;

architecture STRUCTURE of ip_axis16_combine_axis64_axis_combiner_v1_1_16_top is
  signal \<const0>\ : STD_LOGIC;
  signal aresetn_q : STD_LOGIC;
  signal aresetn_q_i_1_n_0 : STD_LOGIC;
  signal \^m_axis_tvalid\ : STD_LOGIC;
  signal m_ready_d_i_1_n_0 : STD_LOGIC;
  signal m_ready_d_reg_n_0 : STD_LOGIC;
  signal \^s_axis_tdata\ : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal \^s_axis_tdest\ : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \^s_axis_tid\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^s_axis_tkeep\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^s_axis_tlast\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^s_axis_tready\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \s_axis_tready[0]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \^s_axis_tstrb\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^s_axis_tuser\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^s_cmd_err\ : STD_LOGIC_VECTOR ( 11 downto 3 );
  signal tdest_xor_1 : STD_LOGIC;
  signal tdest_xor_2 : STD_LOGIC;
  signal tdest_xor_3 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of aresetn_q_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of m_ready_d_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \s_cmd_err[10]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \s_cmd_err[3]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \s_cmd_err[4]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \s_cmd_err[5]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \s_cmd_err[6]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \s_cmd_err[7]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \s_cmd_err[8]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \s_cmd_err[9]_INST_0\ : label is "soft_lutpair4";
begin
  \^s_axis_tdata\(63 downto 0) <= s_axis_tdata(63 downto 0);
  \^s_axis_tdest\(11 downto 0) <= s_axis_tdest(11 downto 0);
  \^s_axis_tid\(3 downto 0) <= s_axis_tid(3 downto 0);
  \^s_axis_tkeep\(7 downto 0) <= s_axis_tkeep(7 downto 0);
  \^s_axis_tlast\(3 downto 0) <= s_axis_tlast(3 downto 0);
  \^s_axis_tstrb\(7 downto 0) <= s_axis_tstrb(7 downto 0);
  \^s_axis_tuser\(15 downto 0) <= s_axis_tuser(15 downto 0);
  m_axis_tdata(63 downto 0) <= \^s_axis_tdata\(63 downto 0);
  m_axis_tdest(2 downto 0) <= \^s_axis_tdest\(2 downto 0);
  m_axis_tid(0) <= \^s_axis_tid\(0);
  m_axis_tkeep(7 downto 0) <= \^s_axis_tkeep\(7 downto 0);
  m_axis_tlast <= \^s_axis_tlast\(0);
  m_axis_tstrb(7 downto 0) <= \^s_axis_tstrb\(7 downto 0);
  m_axis_tuser(15 downto 0) <= \^s_axis_tuser\(15 downto 0);
  m_axis_tvalid <= \^m_axis_tvalid\;
  s_axis_tready(3) <= \^s_axis_tready\(0);
  s_axis_tready(2) <= \^s_axis_tready\(0);
  s_axis_tready(1) <= \^s_axis_tready\(0);
  s_axis_tready(0) <= \^s_axis_tready\(0);
  s_cmd_err(11 downto 3) <= \^s_cmd_err\(11 downto 3);
  s_cmd_err(2) <= \<const0>\;
  s_cmd_err(1) <= \<const0>\;
  s_cmd_err(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
aresetn_q_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
        port map (
      I0 => aresetn,
      I1 => aresetn_q,
      I2 => aclken,
      O => aresetn_q_i_1_n_0
    );
aresetn_q_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => aresetn_q_i_1_n_0,
      Q => aresetn_q,
      R => '0'
    );
m_axis_tvalid_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000080000000"
    )
        port map (
      I0 => s_axis_tvalid(1),
      I1 => s_axis_tvalid(0),
      I2 => s_axis_tvalid(3),
      I3 => s_axis_tvalid(2),
      I4 => aresetn_q,
      I5 => m_ready_d_reg_n_0,
      O => \^m_axis_tvalid\
    );
m_ready_d_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => aresetn_q,
      I1 => m_ready_d_reg_n_0,
      I2 => aclken,
      O => m_ready_d_i_1_n_0
    );
m_ready_d_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => m_ready_d_i_1_n_0,
      Q => m_ready_d_reg_n_0,
      R => '0'
    );
\s_axis_tready[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
        port map (
      I0 => \s_axis_tready[0]_INST_0_i_1_n_0\,
      I1 => m_axis_tready,
      I2 => m_ready_d_reg_n_0,
      O => \^s_axis_tready\(0)
    );
\s_axis_tready[0]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => aresetn_q,
      I1 => s_axis_tvalid(2),
      I2 => s_axis_tvalid(3),
      I3 => s_axis_tvalid(0),
      I4 => s_axis_tvalid(1),
      O => \s_axis_tready[0]_INST_0_i_1_n_0\
    );
\s_cmd_err[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => \^m_axis_tvalid\,
      I1 => \^s_axis_tid\(3),
      I2 => \^s_axis_tid\(0),
      O => \^s_cmd_err\(10)
    );
\s_cmd_err[11]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^m_axis_tvalid\,
      I1 => tdest_xor_3,
      O => \^s_cmd_err\(11)
    );
\s_cmd_err[11]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6FF6FFFFFFFF6FF6"
    )
        port map (
      I0 => \^s_axis_tdest\(9),
      I1 => \^s_axis_tdest\(0),
      I2 => \^s_axis_tdest\(2),
      I3 => \^s_axis_tdest\(11),
      I4 => \^s_axis_tdest\(1),
      I5 => \^s_axis_tdest\(10),
      O => tdest_xor_3
    );
\s_cmd_err[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => \^m_axis_tvalid\,
      I1 => \^s_axis_tlast\(1),
      I2 => \^s_axis_tlast\(0),
      O => \^s_cmd_err\(3)
    );
\s_cmd_err[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => \^m_axis_tvalid\,
      I1 => \^s_axis_tid\(1),
      I2 => \^s_axis_tid\(0),
      O => \^s_cmd_err\(4)
    );
\s_cmd_err[5]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^m_axis_tvalid\,
      I1 => tdest_xor_1,
      O => \^s_cmd_err\(5)
    );
\s_cmd_err[5]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6FF6FFFFFFFF6FF6"
    )
        port map (
      I0 => \^s_axis_tdest\(3),
      I1 => \^s_axis_tdest\(0),
      I2 => \^s_axis_tdest\(2),
      I3 => \^s_axis_tdest\(5),
      I4 => \^s_axis_tdest\(1),
      I5 => \^s_axis_tdest\(4),
      O => tdest_xor_1
    );
\s_cmd_err[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => \^m_axis_tvalid\,
      I1 => \^s_axis_tlast\(2),
      I2 => \^s_axis_tlast\(0),
      O => \^s_cmd_err\(6)
    );
\s_cmd_err[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => \^m_axis_tvalid\,
      I1 => \^s_axis_tid\(2),
      I2 => \^s_axis_tid\(0),
      O => \^s_cmd_err\(7)
    );
\s_cmd_err[8]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^m_axis_tvalid\,
      I1 => tdest_xor_2,
      O => \^s_cmd_err\(8)
    );
\s_cmd_err[8]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6FF6FFFFFFFF6FF6"
    )
        port map (
      I0 => \^s_axis_tdest\(6),
      I1 => \^s_axis_tdest\(0),
      I2 => \^s_axis_tdest\(2),
      I3 => \^s_axis_tdest\(8),
      I4 => \^s_axis_tdest\(1),
      I5 => \^s_axis_tdest\(7),
      O => tdest_xor_2
    );
\s_cmd_err[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => \^m_axis_tvalid\,
      I1 => \^s_axis_tlast\(3),
      I2 => \^s_axis_tlast\(0),
      O => \^s_cmd_err\(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_axis16_combine_axis64 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tready : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tlast : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 15 downto 0 );
    s_cmd_err : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ip_axis16_combine_axis64 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ip_axis16_combine_axis64 : entity is "ip_axis16_combine_axis64,axis_combiner_v1_1_16_top,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of ip_axis16_combine_axis64 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of ip_axis16_combine_axis64 : entity is "axis_combiner_v1_1_16_top,Vivado 2018.3.1_AR71948_AR71898";
end ip_axis16_combine_axis64;

architecture STRUCTURE of ip_axis16_combine_axis64 is
  attribute C_AXIS_SIGNAL_SET : integer;
  attribute C_AXIS_SIGNAL_SET of inst : label is 255;
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of inst : label is 16;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of inst : label is 3;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of inst : label is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of inst : label is 4;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "kintex7";
  attribute C_MASTER_PORT_NUM : integer;
  attribute C_MASTER_PORT_NUM of inst : label is 0;
  attribute C_NUM_SI_SLOTS : integer;
  attribute C_NUM_SI_SLOTS of inst : label is 4;
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
  attribute P_MASTER_PORT_NUM : integer;
  attribute P_MASTER_PORT_NUM of inst : label is 0;
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of inst : label is 101;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of aclk : signal is "xilinx.com:signal:clock:1.0 CLKIF CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of aclk : signal is "XIL_INTERFACENAME CLKIF, FREQ_HZ 10000000, PHASE 0.000, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of aresetn : signal is "xilinx.com:signal:reset:1.0 RSTIF RST";
  attribute X_INTERFACE_PARAMETER of aresetn : signal is "XIL_INTERFACENAME RSTIF, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axis_tlast : signal is "xilinx.com:interface:axis:1.0 M_AXIS TLAST";
  attribute X_INTERFACE_INFO of m_axis_tready : signal is "xilinx.com:interface:axis:1.0 M_AXIS TREADY";
  attribute X_INTERFACE_INFO of m_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 M_AXIS TVALID";
  attribute X_INTERFACE_INFO of m_axis_tdata : signal is "xilinx.com:interface:axis:1.0 M_AXIS TDATA";
  attribute X_INTERFACE_INFO of m_axis_tdest : signal is "xilinx.com:interface:axis:1.0 M_AXIS TDEST";
  attribute X_INTERFACE_INFO of m_axis_tid : signal is "xilinx.com:interface:axis:1.0 M_AXIS TID";
  attribute X_INTERFACE_INFO of m_axis_tkeep : signal is "xilinx.com:interface:axis:1.0 M_AXIS TKEEP";
  attribute X_INTERFACE_INFO of m_axis_tstrb : signal is "xilinx.com:interface:axis:1.0 M_AXIS TSTRB";
  attribute X_INTERFACE_INFO of m_axis_tuser : signal is "xilinx.com:interface:axis:1.0 M_AXIS TUSER";
  attribute X_INTERFACE_PARAMETER of m_axis_tuser : signal is "XIL_INTERFACENAME M_AXIS, TDATA_NUM_BYTES 8, TDEST_WIDTH 3, TID_WIDTH 1, TUSER_WIDTH 16, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_tdata : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TDATA [15:0] [15:0], xilinx.com:interface:axis:1.0 S01_AXIS TDATA [15:0] [31:16], xilinx.com:interface:axis:1.0 S02_AXIS TDATA [15:0] [47:32], xilinx.com:interface:axis:1.0 S03_AXIS TDATA [15:0] [63:48]";
  attribute X_INTERFACE_INFO of s_axis_tdest : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TDEST [2:0] [2:0], xilinx.com:interface:axis:1.0 S01_AXIS TDEST [2:0] [5:3], xilinx.com:interface:axis:1.0 S02_AXIS TDEST [2:0] [8:6], xilinx.com:interface:axis:1.0 S03_AXIS TDEST [2:0] [11:9]";
  attribute X_INTERFACE_INFO of s_axis_tid : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TID [0:0] [0:0], xilinx.com:interface:axis:1.0 S01_AXIS TID [0:0] [1:1], xilinx.com:interface:axis:1.0 S02_AXIS TID [0:0] [2:2], xilinx.com:interface:axis:1.0 S03_AXIS TID [0:0] [3:3]";
  attribute X_INTERFACE_INFO of s_axis_tkeep : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TKEEP [1:0] [1:0], xilinx.com:interface:axis:1.0 S01_AXIS TKEEP [1:0] [3:2], xilinx.com:interface:axis:1.0 S02_AXIS TKEEP [1:0] [5:4], xilinx.com:interface:axis:1.0 S03_AXIS TKEEP [1:0] [7:6]";
  attribute X_INTERFACE_INFO of s_axis_tlast : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TLAST [0:0] [0:0], xilinx.com:interface:axis:1.0 S01_AXIS TLAST [0:0] [1:1], xilinx.com:interface:axis:1.0 S02_AXIS TLAST [0:0] [2:2], xilinx.com:interface:axis:1.0 S03_AXIS TLAST [0:0] [3:3]";
  attribute X_INTERFACE_INFO of s_axis_tready : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TREADY [0:0] [0:0], xilinx.com:interface:axis:1.0 S01_AXIS TREADY [0:0] [1:1], xilinx.com:interface:axis:1.0 S02_AXIS TREADY [0:0] [2:2], xilinx.com:interface:axis:1.0 S03_AXIS TREADY [0:0] [3:3]";
  attribute X_INTERFACE_INFO of s_axis_tstrb : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TSTRB [1:0] [1:0], xilinx.com:interface:axis:1.0 S01_AXIS TSTRB [1:0] [3:2], xilinx.com:interface:axis:1.0 S02_AXIS TSTRB [1:0] [5:4], xilinx.com:interface:axis:1.0 S03_AXIS TSTRB [1:0] [7:6]";
  attribute X_INTERFACE_INFO of s_axis_tuser : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TUSER [3:0] [3:0], xilinx.com:interface:axis:1.0 S01_AXIS TUSER [3:0] [7:4], xilinx.com:interface:axis:1.0 S02_AXIS TUSER [3:0] [11:8], xilinx.com:interface:axis:1.0 S03_AXIS TUSER [3:0] [15:12]";
  attribute X_INTERFACE_PARAMETER of s_axis_tuser : signal is "XIL_INTERFACENAME S00_AXIS, TDATA_NUM_BYTES 2, TDEST_WIDTH 3, TID_WIDTH 1, TUSER_WIDTH 4, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0, XIL_INTERFACENAME S01_AXIS, TDATA_NUM_BYTES 2, TDEST_WIDTH 3, TID_WIDTH 1, TUSER_WIDTH 4, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0, XIL_INTERFACENAME S02_AXIS, TDATA_NUM_BYTES 2, TDEST_WIDTH 3, TID_WIDTH 1, TUSER_WIDTH 4, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0, XIL_INTERFACENAME S03_AXIS, TDATA_NUM_BYTES 2, TDEST_WIDTH 3, TID_WIDTH 1, TUSER_WIDTH 4, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TVALID [0:0] [0:0], xilinx.com:interface:axis:1.0 S01_AXIS TVALID [0:0] [1:1], xilinx.com:interface:axis:1.0 S02_AXIS TVALID [0:0] [2:2], xilinx.com:interface:axis:1.0 S03_AXIS TVALID [0:0] [3:3]";
begin
inst: entity work.ip_axis16_combine_axis64_axis_combiner_v1_1_16_top
     port map (
      aclk => aclk,
      aclken => '1',
      aresetn => aresetn,
      m_axis_tdata(63 downto 0) => m_axis_tdata(63 downto 0),
      m_axis_tdest(2 downto 0) => m_axis_tdest(2 downto 0),
      m_axis_tid(0) => m_axis_tid(0),
      m_axis_tkeep(7 downto 0) => m_axis_tkeep(7 downto 0),
      m_axis_tlast => m_axis_tlast,
      m_axis_tready => m_axis_tready,
      m_axis_tstrb(7 downto 0) => m_axis_tstrb(7 downto 0),
      m_axis_tuser(15 downto 0) => m_axis_tuser(15 downto 0),
      m_axis_tvalid => m_axis_tvalid,
      s_axis_tdata(63 downto 0) => s_axis_tdata(63 downto 0),
      s_axis_tdest(11 downto 0) => s_axis_tdest(11 downto 0),
      s_axis_tid(3 downto 0) => s_axis_tid(3 downto 0),
      s_axis_tkeep(7 downto 0) => s_axis_tkeep(7 downto 0),
      s_axis_tlast(3 downto 0) => s_axis_tlast(3 downto 0),
      s_axis_tready(3 downto 0) => s_axis_tready(3 downto 0),
      s_axis_tstrb(7 downto 0) => s_axis_tstrb(7 downto 0),
      s_axis_tuser(15 downto 0) => s_axis_tuser(15 downto 0),
      s_axis_tvalid(3 downto 0) => s_axis_tvalid(3 downto 0),
      s_cmd_err(11 downto 0) => s_cmd_err(11 downto 0)
    );
end STRUCTURE;
