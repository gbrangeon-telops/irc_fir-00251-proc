-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Fri Apr 08 04:33:17 2016
-- Host        : TELOPS177 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Telops/fir-00251-Proc/IP/t_axi4_lite32_w_afifo_d64/t_axi4_lite32_w_afifo_d64_funcsim.vhdl
-- Design      : t_axi4_lite32_w_afifo_d64
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64dmem is
  port (
    D : out STD_LOGIC_VECTOR ( 34 downto 0 );
    I1 : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    DI : in STD_LOGIC_VECTOR ( 34 downto 0 );
    s_aclk : in STD_LOGIC;
    ADDRA : in STD_LOGIC_VECTOR ( 5 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 )
  );
end t_axi4_lite32_w_afifo_d64dmem;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64dmem is
  signal \<const0>\ : STD_LOGIC;
  signal p_0_out : STD_LOGIC_VECTOR ( 34 downto 0 );
  signal NLW_RAM_reg_0_63_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_12_14_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_15_17_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_18_20_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_21_23_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_24_26_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_27_29_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_30_32_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_33_34_DOC_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_33_34_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_6_8_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_9_11_DOD_UNCONNECTED : STD_LOGIC;
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
RAM_reg_0_63_0_2: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(0),
      DIB => DI(1),
      DIC => DI(2),
      DID => \<const0>\,
      DOA => p_0_out(0),
      DOB => p_0_out(1),
      DOC => p_0_out(2),
      DOD => NLW_RAM_reg_0_63_0_2_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_12_14: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(12),
      DIB => DI(13),
      DIC => DI(14),
      DID => \<const0>\,
      DOA => p_0_out(12),
      DOB => p_0_out(13),
      DOC => p_0_out(14),
      DOD => NLW_RAM_reg_0_63_12_14_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_15_17: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(15),
      DIB => DI(16),
      DIC => DI(17),
      DID => \<const0>\,
      DOA => p_0_out(15),
      DOB => p_0_out(16),
      DOC => p_0_out(17),
      DOD => NLW_RAM_reg_0_63_15_17_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_18_20: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(18),
      DIB => DI(19),
      DIC => DI(20),
      DID => \<const0>\,
      DOA => p_0_out(18),
      DOB => p_0_out(19),
      DOC => p_0_out(20),
      DOD => NLW_RAM_reg_0_63_18_20_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_21_23: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(21),
      DIB => DI(22),
      DIC => DI(23),
      DID => \<const0>\,
      DOA => p_0_out(21),
      DOB => p_0_out(22),
      DOC => p_0_out(23),
      DOD => NLW_RAM_reg_0_63_21_23_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_24_26: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(24),
      DIB => DI(25),
      DIC => DI(26),
      DID => \<const0>\,
      DOA => p_0_out(24),
      DOB => p_0_out(25),
      DOC => p_0_out(26),
      DOD => NLW_RAM_reg_0_63_24_26_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_27_29: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(27),
      DIB => DI(28),
      DIC => DI(29),
      DID => \<const0>\,
      DOA => p_0_out(27),
      DOB => p_0_out(28),
      DOC => p_0_out(29),
      DOD => NLW_RAM_reg_0_63_27_29_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_30_32: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(30),
      DIB => DI(31),
      DIC => DI(32),
      DID => \<const0>\,
      DOA => p_0_out(30),
      DOB => p_0_out(31),
      DOC => p_0_out(32),
      DOD => NLW_RAM_reg_0_63_30_32_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_33_34: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(33),
      DIB => DI(34),
      DIC => \<const0>\,
      DID => \<const0>\,
      DOA => p_0_out(33),
      DOB => p_0_out(34),
      DOC => NLW_RAM_reg_0_63_33_34_DOC_UNCONNECTED,
      DOD => NLW_RAM_reg_0_63_33_34_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_3_5: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(3),
      DIB => DI(4),
      DIC => DI(5),
      DID => \<const0>\,
      DOA => p_0_out(3),
      DOB => p_0_out(4),
      DOC => p_0_out(5),
      DOD => NLW_RAM_reg_0_63_3_5_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_6_8: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(6),
      DIB => DI(7),
      DIC => DI(8),
      DID => \<const0>\,
      DOA => p_0_out(6),
      DOB => p_0_out(7),
      DOC => p_0_out(8),
      DOD => NLW_RAM_reg_0_63_6_8_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_9_11: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => DI(9),
      DIB => DI(10),
      DIC => DI(11),
      DID => \<const0>\,
      DOA => p_0_out(9),
      DOB => p_0_out(10),
      DOC => p_0_out(11),
      DOD => NLW_RAM_reg_0_63_9_11_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
\gpr1.dout_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(0),
      Q => D(0),
      R => \<const0>\
    );
\gpr1.dout_i_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(10),
      Q => D(10),
      R => \<const0>\
    );
\gpr1.dout_i_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(11),
      Q => D(11),
      R => \<const0>\
    );
\gpr1.dout_i_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(12),
      Q => D(12),
      R => \<const0>\
    );
\gpr1.dout_i_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(13),
      Q => D(13),
      R => \<const0>\
    );
\gpr1.dout_i_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(14),
      Q => D(14),
      R => \<const0>\
    );
\gpr1.dout_i_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(15),
      Q => D(15),
      R => \<const0>\
    );
\gpr1.dout_i_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(16),
      Q => D(16),
      R => \<const0>\
    );
\gpr1.dout_i_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(17),
      Q => D(17),
      R => \<const0>\
    );
\gpr1.dout_i_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(18),
      Q => D(18),
      R => \<const0>\
    );
\gpr1.dout_i_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(19),
      Q => D(19),
      R => \<const0>\
    );
\gpr1.dout_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(1),
      Q => D(1),
      R => \<const0>\
    );
\gpr1.dout_i_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(20),
      Q => D(20),
      R => \<const0>\
    );
\gpr1.dout_i_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(21),
      Q => D(21),
      R => \<const0>\
    );
\gpr1.dout_i_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(22),
      Q => D(22),
      R => \<const0>\
    );
\gpr1.dout_i_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(23),
      Q => D(23),
      R => \<const0>\
    );
\gpr1.dout_i_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(24),
      Q => D(24),
      R => \<const0>\
    );
\gpr1.dout_i_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(25),
      Q => D(25),
      R => \<const0>\
    );
\gpr1.dout_i_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(26),
      Q => D(26),
      R => \<const0>\
    );
\gpr1.dout_i_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(27),
      Q => D(27),
      R => \<const0>\
    );
\gpr1.dout_i_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(28),
      Q => D(28),
      R => \<const0>\
    );
\gpr1.dout_i_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(29),
      Q => D(29),
      R => \<const0>\
    );
\gpr1.dout_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(2),
      Q => D(2),
      R => \<const0>\
    );
\gpr1.dout_i_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(30),
      Q => D(30),
      R => \<const0>\
    );
\gpr1.dout_i_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(31),
      Q => D(31),
      R => \<const0>\
    );
\gpr1.dout_i_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(32),
      Q => D(32),
      R => \<const0>\
    );
\gpr1.dout_i_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(33),
      Q => D(33),
      R => \<const0>\
    );
\gpr1.dout_i_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(34),
      Q => D(34),
      R => \<const0>\
    );
\gpr1.dout_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(3),
      Q => D(3),
      R => \<const0>\
    );
\gpr1.dout_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(4),
      Q => D(4),
      R => \<const0>\
    );
\gpr1.dout_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(5),
      Q => D(5),
      R => \<const0>\
    );
\gpr1.dout_i_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(6),
      Q => D(6),
      R => \<const0>\
    );
\gpr1.dout_i_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(7),
      Q => D(7),
      R => \<const0>\
    );
\gpr1.dout_i_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(8),
      Q => D(8),
      R => \<const0>\
    );
\gpr1.dout_i_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(9),
      Q => D(9),
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \t_axi4_lite32_w_afifo_d64dmem__parameterized0\ is
  port (
    D : out STD_LOGIC_VECTOR ( 35 downto 0 );
    I1 : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    I6 : in STD_LOGIC_VECTOR ( 35 downto 0 );
    s_aclk : in STD_LOGIC;
    ADDRA : in STD_LOGIC_VECTOR ( 5 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \t_axi4_lite32_w_afifo_d64dmem__parameterized0\ : entity is "dmem";
end \t_axi4_lite32_w_afifo_d64dmem__parameterized0\;

architecture STRUCTURE of \t_axi4_lite32_w_afifo_d64dmem__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal p_0_out : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal NLW_RAM_reg_0_63_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_12_14_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_15_17_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_18_20_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_21_23_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_24_26_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_27_29_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_30_32_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_33_35_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_6_8_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_9_11_DOD_UNCONNECTED : STD_LOGIC;
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
RAM_reg_0_63_0_2: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(0),
      DIB => I6(1),
      DIC => I6(2),
      DID => \<const0>\,
      DOA => p_0_out(0),
      DOB => p_0_out(1),
      DOC => p_0_out(2),
      DOD => NLW_RAM_reg_0_63_0_2_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_12_14: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(12),
      DIB => I6(13),
      DIC => I6(14),
      DID => \<const0>\,
      DOA => p_0_out(12),
      DOB => p_0_out(13),
      DOC => p_0_out(14),
      DOD => NLW_RAM_reg_0_63_12_14_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_15_17: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(15),
      DIB => I6(16),
      DIC => I6(17),
      DID => \<const0>\,
      DOA => p_0_out(15),
      DOB => p_0_out(16),
      DOC => p_0_out(17),
      DOD => NLW_RAM_reg_0_63_15_17_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_18_20: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(18),
      DIB => I6(19),
      DIC => I6(20),
      DID => \<const0>\,
      DOA => p_0_out(18),
      DOB => p_0_out(19),
      DOC => p_0_out(20),
      DOD => NLW_RAM_reg_0_63_18_20_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_21_23: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(21),
      DIB => I6(22),
      DIC => I6(23),
      DID => \<const0>\,
      DOA => p_0_out(21),
      DOB => p_0_out(22),
      DOC => p_0_out(23),
      DOD => NLW_RAM_reg_0_63_21_23_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_24_26: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(24),
      DIB => I6(25),
      DIC => I6(26),
      DID => \<const0>\,
      DOA => p_0_out(24),
      DOB => p_0_out(25),
      DOC => p_0_out(26),
      DOD => NLW_RAM_reg_0_63_24_26_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_27_29: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(27),
      DIB => I6(28),
      DIC => I6(29),
      DID => \<const0>\,
      DOA => p_0_out(27),
      DOB => p_0_out(28),
      DOC => p_0_out(29),
      DOD => NLW_RAM_reg_0_63_27_29_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_30_32: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(30),
      DIB => I6(31),
      DIC => I6(32),
      DID => \<const0>\,
      DOA => p_0_out(30),
      DOB => p_0_out(31),
      DOC => p_0_out(32),
      DOD => NLW_RAM_reg_0_63_30_32_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_33_35: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(33),
      DIB => I6(34),
      DIC => I6(35),
      DID => \<const0>\,
      DOA => p_0_out(33),
      DOB => p_0_out(34),
      DOC => p_0_out(35),
      DOD => NLW_RAM_reg_0_63_33_35_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_3_5: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(3),
      DIB => I6(4),
      DIC => I6(5),
      DID => \<const0>\,
      DOA => p_0_out(3),
      DOB => p_0_out(4),
      DOC => p_0_out(5),
      DOD => NLW_RAM_reg_0_63_3_5_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_6_8: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(6),
      DIB => I6(7),
      DIC => I6(8),
      DID => \<const0>\,
      DOA => p_0_out(6),
      DOB => p_0_out(7),
      DOC => p_0_out(8),
      DOD => NLW_RAM_reg_0_63_6_8_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
RAM_reg_0_63_9_11: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => I6(9),
      DIB => I6(10),
      DIC => I6(11),
      DID => \<const0>\,
      DOA => p_0_out(9),
      DOB => p_0_out(10),
      DOC => p_0_out(11),
      DOD => NLW_RAM_reg_0_63_9_11_DOD_UNCONNECTED,
      WCLK => s_aclk,
      WE => E(0)
    );
\gpr1.dout_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(0),
      Q => D(0),
      R => \<const0>\
    );
\gpr1.dout_i_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(10),
      Q => D(10),
      R => \<const0>\
    );
\gpr1.dout_i_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(11),
      Q => D(11),
      R => \<const0>\
    );
\gpr1.dout_i_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(12),
      Q => D(12),
      R => \<const0>\
    );
\gpr1.dout_i_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(13),
      Q => D(13),
      R => \<const0>\
    );
\gpr1.dout_i_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(14),
      Q => D(14),
      R => \<const0>\
    );
\gpr1.dout_i_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(15),
      Q => D(15),
      R => \<const0>\
    );
\gpr1.dout_i_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(16),
      Q => D(16),
      R => \<const0>\
    );
\gpr1.dout_i_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(17),
      Q => D(17),
      R => \<const0>\
    );
\gpr1.dout_i_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(18),
      Q => D(18),
      R => \<const0>\
    );
\gpr1.dout_i_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(19),
      Q => D(19),
      R => \<const0>\
    );
\gpr1.dout_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(1),
      Q => D(1),
      R => \<const0>\
    );
\gpr1.dout_i_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(20),
      Q => D(20),
      R => \<const0>\
    );
\gpr1.dout_i_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(21),
      Q => D(21),
      R => \<const0>\
    );
\gpr1.dout_i_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(22),
      Q => D(22),
      R => \<const0>\
    );
\gpr1.dout_i_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(23),
      Q => D(23),
      R => \<const0>\
    );
\gpr1.dout_i_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(24),
      Q => D(24),
      R => \<const0>\
    );
\gpr1.dout_i_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(25),
      Q => D(25),
      R => \<const0>\
    );
\gpr1.dout_i_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(26),
      Q => D(26),
      R => \<const0>\
    );
\gpr1.dout_i_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(27),
      Q => D(27),
      R => \<const0>\
    );
\gpr1.dout_i_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(28),
      Q => D(28),
      R => \<const0>\
    );
\gpr1.dout_i_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(29),
      Q => D(29),
      R => \<const0>\
    );
\gpr1.dout_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(2),
      Q => D(2),
      R => \<const0>\
    );
\gpr1.dout_i_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(30),
      Q => D(30),
      R => \<const0>\
    );
\gpr1.dout_i_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(31),
      Q => D(31),
      R => \<const0>\
    );
\gpr1.dout_i_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(32),
      Q => D(32),
      R => \<const0>\
    );
\gpr1.dout_i_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(33),
      Q => D(33),
      R => \<const0>\
    );
\gpr1.dout_i_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(34),
      Q => D(34),
      R => \<const0>\
    );
\gpr1.dout_i_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(35),
      Q => D(35),
      R => \<const0>\
    );
\gpr1.dout_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(3),
      Q => D(3),
      R => \<const0>\
    );
\gpr1.dout_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(4),
      Q => D(4),
      R => \<const0>\
    );
\gpr1.dout_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(5),
      Q => D(5),
      R => \<const0>\
    );
\gpr1.dout_i_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(6),
      Q => D(6),
      R => \<const0>\
    );
\gpr1.dout_i_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(7),
      Q => D(7),
      R => \<const0>\
    );
\gpr1.dout_i_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(8),
      Q => D(8),
      R => \<const0>\
    );
\gpr1.dout_i_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I1,
      D => p_0_out(9),
      Q => D(9),
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \t_axi4_lite32_w_afifo_d64dmem__parameterized1\ is
  port (
    p_0_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    p_0_out_0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_aclk : in STD_LOGIC;
    ADDRA : in STD_LOGIC_VECTOR ( 5 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 );
    I1 : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    I2 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \t_axi4_lite32_w_afifo_d64dmem__parameterized1\ : entity is "dmem";
end \t_axi4_lite32_w_afifo_d64dmem__parameterized1\;

architecture STRUCTURE of \t_axi4_lite32_w_afifo_d64dmem__parameterized1\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal NLW_RAM_reg_0_63_0_1_DOC_UNCONNECTED : STD_LOGIC;
  signal NLW_RAM_reg_0_63_0_1_DOD_UNCONNECTED : STD_LOGIC;
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
RAM_reg_0_63_0_1: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      ADDRB(5 downto 0) => ADDRA(5 downto 0),
      ADDRC(5 downto 0) => ADDRA(5 downto 0),
      ADDRD(5 downto 0) => Q(5 downto 0),
      DIA => m_axi_bresp(0),
      DIB => m_axi_bresp(1),
      DIC => \<const0>\,
      DID => \<const0>\,
      DOA => p_0_out(0),
      DOB => p_0_out(1),
      DOC => NLW_RAM_reg_0_63_0_1_DOC_UNCONNECTED,
      DOD => NLW_RAM_reg_0_63_0_1_DOD_UNCONNECTED,
      WCLK => m_aclk,
      WE => E(0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gpr1.dout_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => I2,
      Q => p_0_out_0(0),
      R => \<const0>\
    );
\gpr1.dout_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => I1,
      Q => p_0_out_0(1),
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_bin_cntr is
  port (
    Q : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O1 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O3 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_aclk : in STD_LOGIC;
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end t_axi4_lite32_w_afifo_d64rd_bin_cntr;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_bin_cntr is
  signal \^d\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \^o3\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \^q\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \n_0_ram_empty_fb_i_i_2__0\ : STD_LOGIC;
  signal \plusOp__0\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rd_pntr_plus1 : STD_LOGIC_VECTOR ( 5 downto 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gc0.count[1]_i_1__0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \gc0.count[2]_i_1__0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \gc0.count[3]_i_1__0\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \gc0.count[4]_i_1__0\ : label is "soft_lutpair29";
  attribute counter : integer;
  attribute counter of \gc0.count_reg[0]\ : label is 4;
  attribute counter of \gc0.count_reg[1]\ : label is 4;
  attribute counter of \gc0.count_reg[2]\ : label is 4;
  attribute counter of \gc0.count_reg[3]\ : label is 4;
  attribute counter of \gc0.count_reg[4]\ : label is 4;
  attribute counter of \gc0.count_reg[5]\ : label is 4;
  attribute SOFT_HLUTNM of \rd_pntr_gc[0]_i_1__0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \rd_pntr_gc[1]_i_1__0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \rd_pntr_gc[3]_i_1__0\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \rd_pntr_gc[4]_i_1__0\ : label is "soft_lutpair32";
begin
  D(5 downto 0) <= \^d\(5 downto 0);
  O3(4 downto 0) <= \^o3\(4 downto 0);
  Q(2 downto 0) <= \^q\(2 downto 0);
\gc0.count[0]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \^q\(0),
      O => \plusOp__0\(0)
    );
\gc0.count[1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => \plusOp__0\(1)
    );
\gc0.count[2]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \plusOp__0\(2)
    );
\gc0.count[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => rd_pntr_plus1(3),
      I1 => \^q\(0),
      I2 => \^q\(1),
      I3 => \^q\(2),
      O => \plusOp__0\(3)
    );
\gc0.count[4]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => rd_pntr_plus1(4),
      I1 => \^q\(1),
      I2 => \^q\(0),
      I3 => \^q\(2),
      I4 => rd_pntr_plus1(3),
      O => \plusOp__0\(4)
    );
\gc0.count[5]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => rd_pntr_plus1(5),
      I1 => rd_pntr_plus1(3),
      I2 => \^q\(2),
      I3 => \^q\(0),
      I4 => \^q\(1),
      I5 => rd_pntr_plus1(4),
      O => \plusOp__0\(5)
    );
\gc0.count_d1_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \^q\(0),
      Q => \^o3\(0)
    );
\gc0.count_d1_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \^q\(1),
      Q => \^o3\(1)
    );
\gc0.count_d1_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \^q\(2),
      Q => \^o3\(2)
    );
\gc0.count_d1_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => rd_pntr_plus1(3),
      Q => \^o3\(3)
    );
\gc0.count_d1_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => rd_pntr_plus1(4),
      Q => \^o3\(4)
    );
\gc0.count_d1_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => rd_pntr_plus1(5),
      Q => \^d\(5)
    );
\gc0.count_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      D => \plusOp__0\(0),
      PRE => I5(0),
      Q => \^q\(0)
    );
\gc0.count_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \plusOp__0\(1),
      Q => \^q\(1)
    );
\gc0.count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \plusOp__0\(2),
      Q => \^q\(2)
    );
\gc0.count_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \plusOp__0\(3),
      Q => rd_pntr_plus1(3)
    );
\gc0.count_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \plusOp__0\(4),
      Q => rd_pntr_plus1(4)
    );
\gc0.count_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \plusOp__0\(5),
      Q => rd_pntr_plus1(5)
    );
\ram_empty_fb_i_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF90"
    )
    port map (
      I0 => rd_pntr_plus1(4),
      I1 => I1(1),
      I2 => \n_0_ram_empty_fb_i_i_2__0\,
      I3 => I4,
      O => O1
    );
\ram_empty_fb_i_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000000000"
    )
    port map (
      I0 => rd_pntr_plus1(3),
      I1 => I1(0),
      I2 => rd_pntr_plus1(5),
      I3 => I1(2),
      I4 => I2,
      I5 => I3,
      O => \n_0_ram_empty_fb_i_i_2__0\
    );
\rd_pntr_gc[0]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(1),
      I1 => \^o3\(0),
      O => \^d\(0)
    );
\rd_pntr_gc[1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(1),
      I1 => \^o3\(2),
      O => \^d\(1)
    );
\rd_pntr_gc[2]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(2),
      I1 => \^o3\(3),
      O => \^d\(2)
    );
\rd_pntr_gc[3]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(3),
      I1 => \^o3\(4),
      O => \^d\(3)
    );
\rd_pntr_gc[4]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(4),
      I1 => \^d\(5),
      O => \^d\(4)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_bin_cntr_14 is
  port (
    Q : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O1 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O3 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_aclk : in STD_LOGIC;
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64rd_bin_cntr_14 : entity is "rd_bin_cntr";
end t_axi4_lite32_w_afifo_d64rd_bin_cntr_14;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_bin_cntr_14 is
  signal \^d\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \^o3\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \^q\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \n_0_ram_empty_fb_i_i_2__1\ : STD_LOGIC;
  signal \plusOp__4\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rd_pntr_plus1 : STD_LOGIC_VECTOR ( 5 downto 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gc0.count[1]_i_1__1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gc0.count[2]_i_1__1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gc0.count[3]_i_1__1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gc0.count[4]_i_1__1\ : label is "soft_lutpair15";
  attribute counter : integer;
  attribute counter of \gc0.count_reg[0]\ : label is 6;
  attribute counter of \gc0.count_reg[1]\ : label is 6;
  attribute counter of \gc0.count_reg[2]\ : label is 6;
  attribute counter of \gc0.count_reg[3]\ : label is 6;
  attribute counter of \gc0.count_reg[4]\ : label is 6;
  attribute counter of \gc0.count_reg[5]\ : label is 6;
  attribute SOFT_HLUTNM of \rd_pntr_gc[0]_i_1__1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \rd_pntr_gc[1]_i_1__1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \rd_pntr_gc[3]_i_1__1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \rd_pntr_gc[4]_i_1__1\ : label is "soft_lutpair18";
begin
  D(5 downto 0) <= \^d\(5 downto 0);
  O3(4 downto 0) <= \^o3\(4 downto 0);
  Q(2 downto 0) <= \^q\(2 downto 0);
\gc0.count[0]_i_1__1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \^q\(0),
      O => \plusOp__4\(0)
    );
\gc0.count[1]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => \plusOp__4\(1)
    );
\gc0.count[2]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \plusOp__4\(2)
    );
\gc0.count[3]_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => rd_pntr_plus1(3),
      I1 => \^q\(0),
      I2 => \^q\(1),
      I3 => \^q\(2),
      O => \plusOp__4\(3)
    );
\gc0.count[4]_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => rd_pntr_plus1(4),
      I1 => \^q\(1),
      I2 => \^q\(0),
      I3 => \^q\(2),
      I4 => rd_pntr_plus1(3),
      O => \plusOp__4\(4)
    );
\gc0.count[5]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => rd_pntr_plus1(5),
      I1 => rd_pntr_plus1(3),
      I2 => \^q\(2),
      I3 => \^q\(0),
      I4 => \^q\(1),
      I5 => rd_pntr_plus1(4),
      O => \plusOp__4\(5)
    );
\gc0.count_d1_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \^q\(0),
      Q => \^o3\(0)
    );
\gc0.count_d1_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \^q\(1),
      Q => \^o3\(1)
    );
\gc0.count_d1_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \^q\(2),
      Q => \^o3\(2)
    );
\gc0.count_d1_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I5(0),
      D => rd_pntr_plus1(3),
      Q => \^o3\(3)
    );
\gc0.count_d1_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I5(0),
      D => rd_pntr_plus1(4),
      Q => \^o3\(4)
    );
\gc0.count_d1_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I5(0),
      D => rd_pntr_plus1(5),
      Q => \^d\(5)
    );
\gc0.count_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      D => \plusOp__4\(0),
      PRE => I5(0),
      Q => \^q\(0)
    );
\gc0.count_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \plusOp__4\(1),
      Q => \^q\(1)
    );
\gc0.count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \plusOp__4\(2),
      Q => \^q\(2)
    );
\gc0.count_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \plusOp__4\(3),
      Q => rd_pntr_plus1(3)
    );
\gc0.count_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \plusOp__4\(4),
      Q => rd_pntr_plus1(4)
    );
\gc0.count_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \plusOp__4\(5),
      Q => rd_pntr_plus1(5)
    );
\ram_empty_fb_i_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF90"
    )
    port map (
      I0 => rd_pntr_plus1(4),
      I1 => I1(1),
      I2 => \n_0_ram_empty_fb_i_i_2__1\,
      I3 => I4,
      O => O1
    );
\ram_empty_fb_i_i_2__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000000000"
    )
    port map (
      I0 => rd_pntr_plus1(3),
      I1 => I1(0),
      I2 => rd_pntr_plus1(5),
      I3 => I1(2),
      I4 => I2,
      I5 => I3,
      O => \n_0_ram_empty_fb_i_i_2__1\
    );
\rd_pntr_gc[0]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(1),
      I1 => \^o3\(0),
      O => \^d\(0)
    );
\rd_pntr_gc[1]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(1),
      I1 => \^o3\(2),
      O => \^d\(1)
    );
\rd_pntr_gc[2]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(2),
      I1 => \^o3\(3),
      O => \^d\(2)
    );
\rd_pntr_gc[3]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(3),
      I1 => \^o3\(4),
      O => \^d\(3)
    );
\rd_pntr_gc[4]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(4),
      I1 => \^d\(5),
      O => \^d\(4)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_bin_cntr_28 is
  port (
    Q : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O1 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O3 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_aclk : in STD_LOGIC;
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64rd_bin_cntr_28 : entity is "rd_bin_cntr";
end t_axi4_lite32_w_afifo_d64rd_bin_cntr_28;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_bin_cntr_28 is
  signal \^d\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \^o3\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \^q\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal n_0_ram_empty_fb_i_i_2 : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rd_pntr_plus1 : STD_LOGIC_VECTOR ( 5 downto 1 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gc0.count[1]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gc0.count[2]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gc0.count[3]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \gc0.count[4]_i_1\ : label is "soft_lutpair0";
  attribute counter : integer;
  attribute counter of \gc0.count_reg[0]\ : label is 2;
  attribute counter of \gc0.count_reg[1]\ : label is 2;
  attribute counter of \gc0.count_reg[2]\ : label is 2;
  attribute counter of \gc0.count_reg[3]\ : label is 2;
  attribute counter of \gc0.count_reg[4]\ : label is 2;
  attribute counter of \gc0.count_reg[5]\ : label is 2;
  attribute SOFT_HLUTNM of \rd_pntr_gc[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \rd_pntr_gc[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \rd_pntr_gc[3]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \rd_pntr_gc[4]_i_1\ : label is "soft_lutpair3";
begin
  D(5 downto 0) <= \^d\(5 downto 0);
  O3(4 downto 0) <= \^o3\(4 downto 0);
  Q(2 downto 0) <= \^q\(2 downto 0);
\gc0.count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \^q\(0),
      O => plusOp(0)
    );
\gc0.count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^q\(0),
      I1 => rd_pntr_plus1(1),
      O => plusOp(1)
    );
\gc0.count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => \^q\(0),
      I1 => rd_pntr_plus1(1),
      I2 => \^q\(1),
      O => plusOp(2)
    );
\gc0.count[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => \^q\(2),
      I1 => \^q\(0),
      I2 => rd_pntr_plus1(1),
      I3 => \^q\(1),
      O => plusOp(3)
    );
\gc0.count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => rd_pntr_plus1(4),
      I1 => rd_pntr_plus1(1),
      I2 => \^q\(0),
      I3 => \^q\(1),
      I4 => \^q\(2),
      O => plusOp(4)
    );
\gc0.count[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => rd_pntr_plus1(5),
      I1 => \^q\(2),
      I2 => \^q\(1),
      I3 => \^q\(0),
      I4 => rd_pntr_plus1(1),
      I5 => rd_pntr_plus1(4),
      O => plusOp(5)
    );
\gc0.count_d1_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \^q\(0),
      Q => \^o3\(0)
    );
\gc0.count_d1_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => rd_pntr_plus1(1),
      Q => \^o3\(1)
    );
\gc0.count_d1_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \^q\(1),
      Q => \^o3\(2)
    );
\gc0.count_d1_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => \^q\(2),
      Q => \^o3\(3)
    );
\gc0.count_d1_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => rd_pntr_plus1(4),
      Q => \^o3\(4)
    );
\gc0.count_d1_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => rd_pntr_plus1(5),
      Q => \^d\(5)
    );
\gc0.count_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      D => plusOp(0),
      PRE => I5(0),
      Q => \^q\(0)
    );
\gc0.count_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => plusOp(1),
      Q => rd_pntr_plus1(1)
    );
\gc0.count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => plusOp(2),
      Q => \^q\(1)
    );
\gc0.count_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => plusOp(3),
      Q => \^q\(2)
    );
\gc0.count_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => plusOp(4),
      Q => rd_pntr_plus1(4)
    );
\gc0.count_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I5(0),
      D => plusOp(5),
      Q => rd_pntr_plus1(5)
    );
ram_empty_fb_i_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF90"
    )
    port map (
      I0 => rd_pntr_plus1(4),
      I1 => I1(1),
      I2 => n_0_ram_empty_fb_i_i_2,
      I3 => I4,
      O => O1
    );
ram_empty_fb_i_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000000000"
    )
    port map (
      I0 => rd_pntr_plus1(1),
      I1 => I1(0),
      I2 => rd_pntr_plus1(5),
      I3 => I1(2),
      I4 => I2,
      I5 => I3,
      O => n_0_ram_empty_fb_i_i_2
    );
\rd_pntr_gc[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(1),
      I1 => \^o3\(0),
      O => \^d\(0)
    );
\rd_pntr_gc[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(1),
      I1 => \^o3\(2),
      O => \^d\(1)
    );
\rd_pntr_gc[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(2),
      I1 => \^o3\(3),
      O => \^d\(2)
    );
\rd_pntr_gc[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(3),
      I1 => \^o3\(4),
      O => \^d\(3)
    );
\rd_pntr_gc[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o3\(4),
      I1 => \^d\(5),
      O => \^d\(4)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_fwft is
  port (
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    O3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wready : in STD_LOGIC;
    p_17_out : in STD_LOGIC;
    I1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end t_axi4_lite32_w_afifo_d64rd_fwft;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_fwft is
  signal \<const1>\ : STD_LOGIC;
  signal curr_fwft_state : STD_LOGIC_VECTOR ( 0 to 0 );
  signal empty_fwft_fb : STD_LOGIC;
  signal empty_fwft_i0 : STD_LOGIC;
  signal n_0_empty_fwft_i_reg : STD_LOGIC;
  signal \n_0_gpregsm1.curr_fwft_state[1]_i_1__0\ : STD_LOGIC;
  signal \n_0_gpregsm1.curr_fwft_state_reg[1]\ : STD_LOGIC;
  signal next_fwft_state : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \empty_fwft_fb_i_1__0\ : label is "soft_lutpair35";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of empty_fwft_fb_reg : label is "no";
  attribute equivalent_register_removal of empty_fwft_i_reg : label is "no";
  attribute SOFT_HLUTNM of \gc0.count_d1[5]_i_1__0\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \goreg_dm.dout_i[35]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \gpr1.dout_i[35]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \gpregsm1.curr_fwft_state[0]_i_1__0\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \gpregsm1.curr_fwft_state[1]_i_1__0\ : label is "soft_lutpair34";
  attribute equivalent_register_removal of \gpregsm1.curr_fwft_state_reg[0]\ : label is "no";
  attribute equivalent_register_removal of \gpregsm1.curr_fwft_state_reg[1]\ : label is "no";
begin
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\empty_fwft_fb_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CF08"
    )
    port map (
      I0 => m_axi_wready,
      I1 => curr_fwft_state(0),
      I2 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      I3 => empty_fwft_fb,
      O => empty_fwft_i0
    );
empty_fwft_fb_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => empty_fwft_i0,
      PRE => Q(1),
      Q => empty_fwft_fb
    );
empty_fwft_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => empty_fwft_i0,
      PRE => Q(1),
      Q => n_0_empty_fwft_i_reg
    );
\gc0.count_d1[5]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4555"
    )
    port map (
      I0 => p_17_out,
      I1 => m_axi_wready,
      I2 => curr_fwft_state(0),
      I3 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      O => E(0)
    );
\goreg_dm.dout_i[35]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00D0"
    )
    port map (
      I0 => curr_fwft_state(0),
      I1 => m_axi_wready,
      I2 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      I3 => Q(0),
      O => O3(0)
    );
\gpr1.dout_i[35]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4555"
    )
    port map (
      I0 => p_17_out,
      I1 => m_axi_wready,
      I2 => curr_fwft_state(0),
      I3 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      O => O2
    );
\gpregsm1.curr_fwft_state[0]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AE"
    )
    port map (
      I0 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      I1 => curr_fwft_state(0),
      I2 => m_axi_wready,
      O => next_fwft_state(0)
    );
\gpregsm1.curr_fwft_state[1]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"40FF"
    )
    port map (
      I0 => m_axi_wready,
      I1 => curr_fwft_state(0),
      I2 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      I3 => p_17_out,
      O => \n_0_gpregsm1.curr_fwft_state[1]_i_1__0\
    );
\gpregsm1.curr_fwft_state_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => Q(1),
      D => next_fwft_state(0),
      Q => curr_fwft_state(0)
    );
\gpregsm1.curr_fwft_state_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => Q(1),
      D => \n_0_gpregsm1.curr_fwft_state[1]_i_1__0\,
      Q => \n_0_gpregsm1.curr_fwft_state_reg[1]\
    );
m_axi_wvalid_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => n_0_empty_fwft_i_reg,
      O => m_axi_wvalid
    );
\ram_empty_fb_i_i_4__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F70000000000F7"
    )
    port map (
      I0 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      I1 => curr_fwft_state(0),
      I2 => m_axi_wready,
      I3 => p_17_out,
      I4 => I1(0),
      I5 => I2(0),
      O => O1
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_fwft_15 is
  port (
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bvalid : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    s_aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC;
    p_17_out : in STD_LOGIC;
    I1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_0_out : in STD_LOGIC_VECTOR ( 1 downto 0 );
    p_0_out_0 : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64rd_fwft_15 : entity is "rd_fwft";
end t_axi4_lite32_w_afifo_d64rd_fwft_15;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_fwft_15 is
  signal \<const1>\ : STD_LOGIC;
  signal \^o2\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal empty_fwft_fb : STD_LOGIC;
  signal empty_fwft_i0 : STD_LOGIC;
  signal n_0_empty_fwft_i_reg : STD_LOGIC;
  signal \n_0_gpregsm1.curr_fwft_state[1]_i_1__1\ : STD_LOGIC;
  signal next_fwft_state : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \empty_fwft_fb_i_1__1\ : label is "soft_lutpair20";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of empty_fwft_fb_reg : label is "no";
  attribute equivalent_register_removal of empty_fwft_i_reg : label is "no";
  attribute SOFT_HLUTNM of \gc0.count_d1[5]_i_1__1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \gpregsm1.curr_fwft_state[0]_i_1__1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \gpregsm1.curr_fwft_state[1]_i_1__1\ : label is "soft_lutpair19";
  attribute equivalent_register_removal of \gpregsm1.curr_fwft_state_reg[0]\ : label is "no";
  attribute equivalent_register_removal of \gpregsm1.curr_fwft_state_reg[1]\ : label is "no";
begin
  O2(1 downto 0) <= \^o2\(1 downto 0);
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\empty_fwft_fb_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CF08"
    )
    port map (
      I0 => s_axi_bready,
      I1 => \^o2\(0),
      I2 => \^o2\(1),
      I3 => empty_fwft_fb,
      O => empty_fwft_i0
    );
empty_fwft_fb_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => empty_fwft_i0,
      PRE => Q(0),
      Q => empty_fwft_fb
    );
empty_fwft_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => empty_fwft_i0,
      PRE => Q(0),
      Q => n_0_empty_fwft_i_reg
    );
\gc0.count_d1[5]_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4555"
    )
    port map (
      I0 => p_17_out,
      I1 => s_axi_bready,
      I2 => \^o2\(0),
      I3 => \^o2\(1),
      O => E(0)
    );
\gpr1.dout_i[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFEEEEEE20222222"
    )
    port map (
      I0 => p_0_out(0),
      I1 => p_17_out,
      I2 => s_axi_bready,
      I3 => \^o2\(0),
      I4 => \^o2\(1),
      I5 => p_0_out_0(0),
      O => O5
    );
\gpr1.dout_i[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFEEEEEE20222222"
    )
    port map (
      I0 => p_0_out(1),
      I1 => p_17_out,
      I2 => s_axi_bready,
      I3 => \^o2\(0),
      I4 => \^o2\(1),
      I5 => p_0_out_0(1),
      O => O4
    );
\gpregsm1.curr_fwft_state[0]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AE"
    )
    port map (
      I0 => \^o2\(1),
      I1 => \^o2\(0),
      I2 => s_axi_bready,
      O => next_fwft_state(0)
    );
\gpregsm1.curr_fwft_state[1]_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"40FF"
    )
    port map (
      I0 => s_axi_bready,
      I1 => \^o2\(0),
      I2 => \^o2\(1),
      I3 => p_17_out,
      O => \n_0_gpregsm1.curr_fwft_state[1]_i_1__1\
    );
\gpregsm1.curr_fwft_state_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => Q(0),
      D => next_fwft_state(0),
      Q => \^o2\(0)
    );
\gpregsm1.curr_fwft_state_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => Q(0),
      D => \n_0_gpregsm1.curr_fwft_state[1]_i_1__1\,
      Q => \^o2\(1)
    );
\ram_empty_fb_i_i_4__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F70000000000F7"
    )
    port map (
      I0 => \^o2\(1),
      I1 => \^o2\(0),
      I2 => s_axi_bready,
      I3 => p_17_out,
      I4 => I1(0),
      I5 => I2(0),
      O => O1
    );
s_axi_bvalid_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => n_0_empty_fwft_i_reg,
      O => s_axi_bvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_fwft_29 is
  port (
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    O3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awready : in STD_LOGIC;
    p_17_out : in STD_LOGIC;
    I1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64rd_fwft_29 : entity is "rd_fwft";
end t_axi4_lite32_w_afifo_d64rd_fwft_29;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_fwft_29 is
  signal \<const1>\ : STD_LOGIC;
  signal curr_fwft_state : STD_LOGIC_VECTOR ( 0 to 0 );
  signal empty_fwft_fb : STD_LOGIC;
  signal empty_fwft_i : STD_LOGIC;
  signal empty_fwft_i0 : STD_LOGIC;
  signal \n_0_gpregsm1.curr_fwft_state[1]_i_1\ : STD_LOGIC;
  signal \n_0_gpregsm1.curr_fwft_state_reg[1]\ : STD_LOGIC;
  signal next_fwft_state : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of empty_fwft_fb_i_1 : label is "soft_lutpair6";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of empty_fwft_fb_reg : label is "no";
  attribute equivalent_register_removal of empty_fwft_i_reg : label is "no";
  attribute SOFT_HLUTNM of \gc0.count_d1[5]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \goreg_dm.dout_i[34]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gpr1.dout_i[34]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gpregsm1.curr_fwft_state[0]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gpregsm1.curr_fwft_state[1]_i_1\ : label is "soft_lutpair5";
  attribute equivalent_register_removal of \gpregsm1.curr_fwft_state_reg[0]\ : label is "no";
  attribute equivalent_register_removal of \gpregsm1.curr_fwft_state_reg[1]\ : label is "no";
begin
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
empty_fwft_fb_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CF08"
    )
    port map (
      I0 => m_axi_awready,
      I1 => curr_fwft_state(0),
      I2 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      I3 => empty_fwft_fb,
      O => empty_fwft_i0
    );
empty_fwft_fb_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => empty_fwft_i0,
      PRE => Q(1),
      Q => empty_fwft_fb
    );
empty_fwft_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => empty_fwft_i0,
      PRE => Q(1),
      Q => empty_fwft_i
    );
\gc0.count_d1[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4555"
    )
    port map (
      I0 => p_17_out,
      I1 => m_axi_awready,
      I2 => curr_fwft_state(0),
      I3 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      O => E(0)
    );
\goreg_dm.dout_i[34]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00D0"
    )
    port map (
      I0 => curr_fwft_state(0),
      I1 => m_axi_awready,
      I2 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      I3 => Q(0),
      O => O3(0)
    );
\gpr1.dout_i[34]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4555"
    )
    port map (
      I0 => p_17_out,
      I1 => m_axi_awready,
      I2 => curr_fwft_state(0),
      I3 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      O => O2
    );
\gpregsm1.curr_fwft_state[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AE"
    )
    port map (
      I0 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      I1 => curr_fwft_state(0),
      I2 => m_axi_awready,
      O => next_fwft_state(0)
    );
\gpregsm1.curr_fwft_state[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"40FF"
    )
    port map (
      I0 => m_axi_awready,
      I1 => curr_fwft_state(0),
      I2 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      I3 => p_17_out,
      O => \n_0_gpregsm1.curr_fwft_state[1]_i_1\
    );
\gpregsm1.curr_fwft_state_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => Q(1),
      D => next_fwft_state(0),
      Q => curr_fwft_state(0)
    );
\gpregsm1.curr_fwft_state_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => Q(1),
      D => \n_0_gpregsm1.curr_fwft_state[1]_i_1\,
      Q => \n_0_gpregsm1.curr_fwft_state_reg[1]\
    );
m_axi_awvalid_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => empty_fwft_i,
      O => m_axi_awvalid
    );
ram_empty_fb_i_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F70000000000F7"
    )
    port map (
      I0 => \n_0_gpregsm1.curr_fwft_state_reg[1]\,
      I1 => curr_fwft_state(0),
      I2 => m_axi_awready,
      I3 => p_17_out,
      I4 => I1(0),
      I5 => I2(0),
      O => O1
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_status_flags_as is
  port (
    p_17_out : out STD_LOGIC;
    I1 : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end t_axi4_lite32_w_afifo_d64rd_status_flags_as;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_status_flags_as is
  signal \<const1>\ : STD_LOGIC;
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of ram_empty_fb_i_reg : label is "no";
begin
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
ram_empty_fb_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => I1,
      PRE => Q(0),
      Q => p_17_out
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_status_flags_as_16 is
  port (
    p_17_out : out STD_LOGIC;
    I1 : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64rd_status_flags_as_16 : entity is "rd_status_flags_as";
end t_axi4_lite32_w_afifo_d64rd_status_flags_as_16;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_status_flags_as_16 is
  signal \<const1>\ : STD_LOGIC;
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of ram_empty_fb_i_reg : label is "no";
begin
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
ram_empty_fb_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => I1,
      PRE => Q(0),
      Q => p_17_out
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_status_flags_as_30 is
  port (
    p_17_out : out STD_LOGIC;
    I1 : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64rd_status_flags_as_30 : entity is "rd_status_flags_as";
end t_axi4_lite32_w_afifo_d64rd_status_flags_as_30;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_status_flags_as_30 is
  signal \<const1>\ : STD_LOGIC;
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of ram_empty_fb_i_reg : label is "no";
begin
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
ram_empty_fb_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => I1,
      PRE => Q(0),
      Q => p_17_out
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64reset_blk_ramfifo is
  port (
    Q : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O1 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_aclk : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    inverted_reset : in STD_LOGIC
  );
end t_axi4_lite32_w_afifo_d64reset_blk_ramfifo;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64reset_blk_ramfifo is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1__0\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__0\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1__0\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1__0\ : STD_LOGIC;
  signal rd_rst_asreg : STD_LOGIC;
  signal rd_rst_asreg_d2 : STD_LOGIC;
  signal wr_rst_asreg : STD_LOGIC;
  signal wr_rst_asreg_d2 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\ : label is true;
  attribute msgon : string;
  attribute msgon of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.rd_rst_asreg_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.rd_rst_asreg_reg\ : label is "true";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0]\ : label is "no";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1]\ : label is "no";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[2]\ : label is "no";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.wr_rst_asreg_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.wr_rst_asreg_reg\ : label is "true";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0]\ : label is "no";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1]\ : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => rd_rst_asreg,
      Q => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\,
      Q => rd_rst_asreg_d2,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => rd_rst_asreg,
      I1 => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\,
      O => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1__0\
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_reg\: unisim.vcomponents.FDPE
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1__0\,
      PRE => inverted_reset,
      Q => rd_rst_asreg
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => rd_rst_asreg,
      I1 => rd_rst_asreg_d2,
      O => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__0\
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__0\,
      Q => Q(0)
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__0\,
      Q => Q(1)
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[2]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__0\,
      Q => Q(2)
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => wr_rst_asreg,
      Q => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\,
      Q => wr_rst_asreg_d2,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_rst_asreg,
      I1 => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\,
      O => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1__0\
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_reg\: unisim.vcomponents.FDPE
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1__0\,
      PRE => inverted_reset,
      Q => wr_rst_asreg
    );
\ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_rst_asreg,
      I1 => wr_rst_asreg_d2,
      O => \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1__0\
    );
\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1__0\,
      Q => O1(0)
    );
\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1__0\,
      Q => O1(1)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64reset_blk_ramfifo_20 is
  port (
    rst_full_gen_i : out STD_LOGIC;
    O1 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O2 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_aclk : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    inverted_reset : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64reset_blk_ramfifo_20 : entity is "reset_blk_ramfifo";
end t_axi4_lite32_w_afifo_d64reset_blk_ramfifo_20;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64reset_blk_ramfifo_20 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1\ : STD_LOGIC;
  signal rd_rst_asreg : STD_LOGIC;
  signal rd_rst_asreg_d1 : STD_LOGIC;
  signal rd_rst_asreg_d2 : STD_LOGIC;
  signal rst_d1 : STD_LOGIC;
  signal rst_d3 : STD_LOGIC;
  signal wr_rst_asreg : STD_LOGIC;
  signal wr_rst_asreg_d1 : STD_LOGIC;
  signal wr_rst_asreg_d2 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \grstd1.grst_full.grst_f.rst_d1_reg\ : label is true;
  attribute msgon : string;
  attribute msgon of \grstd1.grst_full.grst_f.rst_d1_reg\ : label is "true";
  attribute ASYNC_REG of \grstd1.grst_full.grst_f.rst_d2_reg\ : label is true;
  attribute msgon of \grstd1.grst_full.grst_f.rst_d2_reg\ : label is "true";
  attribute ASYNC_REG of \grstd1.grst_full.grst_f.rst_d3_reg\ : label is true;
  attribute msgon of \grstd1.grst_full.grst_f.rst_d3_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.rd_rst_asreg_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.rd_rst_asreg_reg\ : label is "true";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0]\ : label is "no";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1]\ : label is "no";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[2]\ : label is "no";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.wr_rst_asreg_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.wr_rst_asreg_reg\ : label is "true";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0]\ : label is "no";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1]\ : label is "no";
begin
  O1 <= \^o1\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\grstd1.grst_full.grst_f.RST_FULL_GEN_reg\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => inverted_reset,
      D => rst_d3,
      Q => rst_full_gen_i
    );
\grstd1.grst_full.grst_f.rst_d1_reg\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => inverted_reset,
      Q => rst_d1
    );
\grstd1.grst_full.grst_f.rst_d2_reg\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => rst_d1,
      PRE => inverted_reset,
      Q => \^o1\
    );
\grstd1.grst_full.grst_f.rst_d3_reg\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \^o1\,
      PRE => inverted_reset,
      Q => rst_d3
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => rd_rst_asreg,
      Q => rd_rst_asreg_d1,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => rd_rst_asreg_d1,
      Q => rd_rst_asreg_d2,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => rd_rst_asreg,
      I1 => rd_rst_asreg_d1,
      O => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1\
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_reg\: unisim.vcomponents.FDPE
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1\,
      PRE => inverted_reset,
      Q => rd_rst_asreg
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => rd_rst_asreg,
      I1 => rd_rst_asreg_d2,
      O => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1\
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1\,
      Q => Q(0)
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1\,
      Q => Q(1)
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[2]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1\,
      Q => Q(2)
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => wr_rst_asreg,
      Q => wr_rst_asreg_d1,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => wr_rst_asreg_d1,
      Q => wr_rst_asreg_d2,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_rst_asreg,
      I1 => wr_rst_asreg_d1,
      O => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1\
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_reg\: unisim.vcomponents.FDPE
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1\,
      PRE => inverted_reset,
      Q => wr_rst_asreg
    );
\ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_rst_asreg,
      I1 => wr_rst_asreg_d2,
      O => \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1\
    );
\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1\,
      Q => O2(0)
    );
\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1\,
      Q => O2(1)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64reset_blk_ramfifo_6 is
  port (
    rst_full_gen_i : out STD_LOGIC;
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O3 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_aclk : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64reset_blk_ramfifo_6 : entity is "reset_blk_ramfifo";
end t_axi4_lite32_w_afifo_d64reset_blk_ramfifo_6;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64reset_blk_ramfifo_6 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal \^o2\ : STD_LOGIC;
  signal \n_0_grstd1.grst_full.grst_f.rst_d1_reg\ : STD_LOGIC;
  signal \n_0_grstd1.grst_full.grst_f.rst_d3_reg\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1__1\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__1\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1__1\ : STD_LOGIC;
  signal \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1__1\ : STD_LOGIC;
  signal rd_rst_asreg : STD_LOGIC;
  signal rd_rst_asreg_d2 : STD_LOGIC;
  signal wr_rst_asreg : STD_LOGIC;
  signal wr_rst_asreg_d2 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \grstd1.grst_full.grst_f.rst_d1_reg\ : label is true;
  attribute msgon : string;
  attribute msgon of \grstd1.grst_full.grst_f.rst_d1_reg\ : label is "true";
  attribute ASYNC_REG of \grstd1.grst_full.grst_f.rst_d2_reg\ : label is true;
  attribute msgon of \grstd1.grst_full.grst_f.rst_d2_reg\ : label is "true";
  attribute ASYNC_REG of \grstd1.grst_full.grst_f.rst_d3_reg\ : label is true;
  attribute msgon of \grstd1.grst_full.grst_f.rst_d3_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.rd_rst_asreg_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.rd_rst_asreg_reg\ : label is "true";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0]\ : label is "no";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1]\ : label is "no";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[2]\ : label is "no";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg\ : label is "true";
  attribute ASYNC_REG of \ngwrdrst.grst.g7serrst.wr_rst_asreg_reg\ : label is true;
  attribute msgon of \ngwrdrst.grst.g7serrst.wr_rst_asreg_reg\ : label is "true";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0]\ : label is "no";
  attribute equivalent_register_removal of \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1]\ : label is "no";
begin
  O1 <= \^o1\;
  O2 <= \^o2\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\grstd1.grst_full.grst_f.RST_FULL_GEN_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => s_aresetn,
      O => \^o1\
    );
\grstd1.grst_full.grst_f.RST_FULL_GEN_reg\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => \^o1\,
      D => \n_0_grstd1.grst_full.grst_f.rst_d3_reg\,
      Q => rst_full_gen_i
    );
\grstd1.grst_full.grst_f.rst_d1_reg\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \^o1\,
      Q => \n_0_grstd1.grst_full.grst_f.rst_d1_reg\
    );
\grstd1.grst_full.grst_f.rst_d2_reg\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \n_0_grstd1.grst_full.grst_f.rst_d1_reg\,
      PRE => \^o1\,
      Q => \^o2\
    );
\grstd1.grst_full.grst_f.rst_d3_reg\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \^o2\,
      PRE => \^o1\,
      Q => \n_0_grstd1.grst_full.grst_f.rst_d3_reg\
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => rd_rst_asreg,
      Q => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\,
      Q => rd_rst_asreg_d2,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => rd_rst_asreg,
      I1 => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg\,
      O => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1__1\
    );
\ngwrdrst.grst.g7serrst.rd_rst_asreg_reg\: unisim.vcomponents.FDPE
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1__1\,
      PRE => \^o1\,
      Q => rd_rst_asreg
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => rd_rst_asreg,
      I1 => rd_rst_asreg_d2,
      O => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__1\
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__1\,
      Q => Q(0)
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__1\,
      Q => Q(1)
    );
\ngwrdrst.grst.g7serrst.rd_rst_reg_reg[2]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1__1\,
      Q => Q(2)
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => wr_rst_asreg,
      Q => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\,
      Q => wr_rst_asreg_d2,
      R => \<const0>\
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_rst_asreg,
      I1 => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg\,
      O => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1__1\
    );
\ngwrdrst.grst.g7serrst.wr_rst_asreg_reg\: unisim.vcomponents.FDPE
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1__1\,
      PRE => \^o1\,
      Q => wr_rst_asreg
    );
\ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_rst_asreg,
      I1 => wr_rst_asreg_d2,
      O => \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1__1\
    );
\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1__1\,
      Q => O3(0)
    );
\ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1__1\,
      Q => O3(1)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff is
  port (
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_aclk : in STD_LOGIC;
    I6 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end t_axi4_lite32_w_afifo_d64synchronizer_ff;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff is
  signal \<const1>\ : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
begin
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => I1(0),
      Q => Q(0)
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => I1(1),
      Q => Q(1)
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => I1(2),
      Q => Q(2)
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => I1(3),
      Q => Q(3)
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => I1(4),
      Q => Q(4)
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => I1(5),
      Q => Q(5)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff_0 is
  port (
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_aclk : in STD_LOGIC;
    I7 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64synchronizer_ff_0 : entity is "synchronizer_ff";
end t_axi4_lite32_w_afifo_d64synchronizer_ff_0;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff_0 is
  signal \<const1>\ : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
begin
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => I1(0),
      Q => Q(0)
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => I1(1),
      Q => Q(1)
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => I1(2),
      Q => Q(2)
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => I1(3),
      Q => Q(3)
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => I1(4),
      Q => Q(4)
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => I1(5),
      Q => Q(5)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff_1 is
  port (
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    O1 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    D : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_aclk : in STD_LOGIC;
    I6 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64synchronizer_ff_1 : entity is "synchronizer_ff";
end t_axi4_lite32_w_afifo_d64synchronizer_ff_1;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff_1 is
  signal \<const1>\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \n_0_Q_reg_reg[0]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[1]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[2]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[3]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[4]\ : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \wr_pntr_bin[1]_i_1__0\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \wr_pntr_bin[2]_i_1__0\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \wr_pntr_bin[3]_i_1__0\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \wr_pntr_bin[4]_i_1__0\ : label is "soft_lutpair37";
begin
  Q(0) <= \^q\(0);
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => D(0),
      Q => \n_0_Q_reg_reg[0]\
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => D(1),
      Q => \n_0_Q_reg_reg[1]\
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => D(2),
      Q => \n_0_Q_reg_reg[2]\
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => D(3),
      Q => \n_0_Q_reg_reg[3]\
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => D(4),
      Q => \n_0_Q_reg_reg[4]\
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => D(5),
      Q => \^q\(0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\wr_pntr_bin[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[2]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \n_0_Q_reg_reg[0]\,
      I3 => \n_0_Q_reg_reg[1]\,
      I4 => \^q\(0),
      I5 => \n_0_Q_reg_reg[4]\,
      O => O1(0)
    );
\wr_pntr_bin[1]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[4]\,
      I2 => \n_0_Q_reg_reg[1]\,
      I3 => \n_0_Q_reg_reg[2]\,
      I4 => \^q\(0),
      O => O1(1)
    );
\wr_pntr_bin[2]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[2]\,
      I2 => \^q\(0),
      I3 => \n_0_Q_reg_reg[4]\,
      O => O1(2)
    );
\wr_pntr_bin[3]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \^q\(0),
      O => O1(3)
    );
\wr_pntr_bin[4]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \^q\(0),
      O => O1(4)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff_10 is
  port (
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_aclk : in STD_LOGIC;
    I4 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64synchronizer_ff_10 : entity is "synchronizer_ff";
end t_axi4_lite32_w_afifo_d64synchronizer_ff_10;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff_10 is
  signal \<const1>\ : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
begin
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(0),
      Q => Q(0)
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(1),
      Q => Q(1)
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(2),
      Q => Q(2)
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(3),
      Q => Q(3)
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(4),
      Q => Q(4)
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(5),
      Q => Q(5)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff_11 is
  port (
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_aclk : in STD_LOGIC;
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64synchronizer_ff_11 : entity is "synchronizer_ff";
end t_axi4_lite32_w_afifo_d64synchronizer_ff_11;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff_11 is
  signal \<const1>\ : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
begin
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(0),
      Q => Q(0)
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(1),
      Q => Q(1)
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(2),
      Q => Q(2)
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(3),
      Q => Q(3)
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(4),
      Q => Q(4)
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(5),
      Q => Q(5)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff_12 is
  port (
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    O1 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    D : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_aclk : in STD_LOGIC;
    I4 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64synchronizer_ff_12 : entity is "synchronizer_ff";
end t_axi4_lite32_w_afifo_d64synchronizer_ff_12;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff_12 is
  signal \<const1>\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \n_0_Q_reg_reg[0]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[1]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[2]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[3]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[4]\ : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \wr_pntr_bin[1]_i_1__1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \wr_pntr_bin[2]_i_1__1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \wr_pntr_bin[3]_i_1__1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \wr_pntr_bin[4]_i_1__1\ : label is "soft_lutpair22";
begin
  Q(0) <= \^q\(0);
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(0),
      Q => \n_0_Q_reg_reg[0]\
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(1),
      Q => \n_0_Q_reg_reg[1]\
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(2),
      Q => \n_0_Q_reg_reg[2]\
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(3),
      Q => \n_0_Q_reg_reg[3]\
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(4),
      Q => \n_0_Q_reg_reg[4]\
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(5),
      Q => \^q\(0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\wr_pntr_bin[0]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[2]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \n_0_Q_reg_reg[0]\,
      I3 => \n_0_Q_reg_reg[1]\,
      I4 => \^q\(0),
      I5 => \n_0_Q_reg_reg[4]\,
      O => O1(0)
    );
\wr_pntr_bin[1]_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[4]\,
      I2 => \n_0_Q_reg_reg[1]\,
      I3 => \n_0_Q_reg_reg[2]\,
      I4 => \^q\(0),
      O => O1(1)
    );
\wr_pntr_bin[2]_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[2]\,
      I2 => \^q\(0),
      I3 => \n_0_Q_reg_reg[4]\,
      O => O1(2)
    );
\wr_pntr_bin[3]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \^q\(0),
      O => O1(3)
    );
\wr_pntr_bin[4]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \^q\(0),
      O => O1(4)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff_13 is
  port (
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    O1 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    D : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_aclk : in STD_LOGIC;
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64synchronizer_ff_13 : entity is "synchronizer_ff";
end t_axi4_lite32_w_afifo_d64synchronizer_ff_13;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff_13 is
  signal \<const1>\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \n_0_Q_reg_reg[0]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[1]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[2]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[3]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[4]\ : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \rd_pntr_bin[1]_i_1__1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \rd_pntr_bin[2]_i_1__1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \rd_pntr_bin[3]_i_1__1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \rd_pntr_bin[4]_i_1__1\ : label is "soft_lutpair24";
begin
  Q(0) <= \^q\(0);
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(0),
      Q => \n_0_Q_reg_reg[0]\
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(1),
      Q => \n_0_Q_reg_reg[1]\
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(2),
      Q => \n_0_Q_reg_reg[2]\
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(3),
      Q => \n_0_Q_reg_reg[3]\
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(4),
      Q => \n_0_Q_reg_reg[4]\
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(5),
      Q => \^q\(0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\rd_pntr_bin[0]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[2]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \n_0_Q_reg_reg[0]\,
      I3 => \n_0_Q_reg_reg[1]\,
      I4 => \^q\(0),
      I5 => \n_0_Q_reg_reg[4]\,
      O => O1(0)
    );
\rd_pntr_bin[1]_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[4]\,
      I2 => \n_0_Q_reg_reg[1]\,
      I3 => \n_0_Q_reg_reg[2]\,
      I4 => \^q\(0),
      O => O1(1)
    );
\rd_pntr_bin[2]_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[2]\,
      I2 => \^q\(0),
      I3 => \n_0_Q_reg_reg[4]\,
      O => O1(2)
    );
\rd_pntr_bin[3]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \^q\(0),
      O => O1(3)
    );
\rd_pntr_bin[4]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \^q\(0),
      O => O1(4)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff_2 is
  port (
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    O1 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    D : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_aclk : in STD_LOGIC;
    I7 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64synchronizer_ff_2 : entity is "synchronizer_ff";
end t_axi4_lite32_w_afifo_d64synchronizer_ff_2;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff_2 is
  signal \<const1>\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \n_0_Q_reg_reg[0]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[1]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[2]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[3]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[4]\ : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \rd_pntr_bin[1]_i_1__0\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \rd_pntr_bin[2]_i_1__0\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \rd_pntr_bin[3]_i_1__0\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \rd_pntr_bin[4]_i_1__0\ : label is "soft_lutpair39";
begin
  Q(0) <= \^q\(0);
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => D(0),
      Q => \n_0_Q_reg_reg[0]\
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => D(1),
      Q => \n_0_Q_reg_reg[1]\
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => D(2),
      Q => \n_0_Q_reg_reg[2]\
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => D(3),
      Q => \n_0_Q_reg_reg[3]\
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => D(4),
      Q => \n_0_Q_reg_reg[4]\
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => D(5),
      Q => \^q\(0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\rd_pntr_bin[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[2]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \n_0_Q_reg_reg[0]\,
      I3 => \n_0_Q_reg_reg[1]\,
      I4 => \^q\(0),
      I5 => \n_0_Q_reg_reg[4]\,
      O => O1(0)
    );
\rd_pntr_bin[1]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[4]\,
      I2 => \n_0_Q_reg_reg[1]\,
      I3 => \n_0_Q_reg_reg[2]\,
      I4 => \^q\(0),
      O => O1(1)
    );
\rd_pntr_bin[2]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[2]\,
      I2 => \^q\(0),
      I3 => \n_0_Q_reg_reg[4]\,
      O => O1(2)
    );
\rd_pntr_bin[3]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \^q\(0),
      O => O1(3)
    );
\rd_pntr_bin[4]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \^q\(0),
      O => O1(4)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff_24 is
  port (
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_aclk : in STD_LOGIC;
    I4 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64synchronizer_ff_24 : entity is "synchronizer_ff";
end t_axi4_lite32_w_afifo_d64synchronizer_ff_24;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff_24 is
  signal \<const1>\ : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
begin
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(0),
      Q => Q(0)
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(1),
      Q => Q(1)
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(2),
      Q => Q(2)
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(3),
      Q => Q(3)
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(4),
      Q => Q(4)
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => I1(5),
      Q => Q(5)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff_25 is
  port (
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_aclk : in STD_LOGIC;
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64synchronizer_ff_25 : entity is "synchronizer_ff";
end t_axi4_lite32_w_afifo_d64synchronizer_ff_25;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff_25 is
  signal \<const1>\ : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
begin
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(0),
      Q => Q(0)
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(1),
      Q => Q(1)
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(2),
      Q => Q(2)
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(3),
      Q => Q(3)
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(4),
      Q => Q(4)
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I1(5),
      Q => Q(5)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff_26 is
  port (
    p_0_in : out STD_LOGIC_VECTOR ( 5 downto 0 );
    D : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_aclk : in STD_LOGIC;
    I4 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64synchronizer_ff_26 : entity is "synchronizer_ff";
end t_axi4_lite32_w_afifo_d64synchronizer_ff_26;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff_26 is
  signal \<const1>\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[0]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[1]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[2]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[3]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[4]\ : STD_LOGIC;
  signal \^p_0_in\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \wr_pntr_bin[1]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \wr_pntr_bin[2]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \wr_pntr_bin[3]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \wr_pntr_bin[4]_i_1\ : label is "soft_lutpair8";
begin
  p_0_in(5 downto 0) <= \^p_0_in\(5 downto 0);
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(0),
      Q => \n_0_Q_reg_reg[0]\
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(1),
      Q => \n_0_Q_reg_reg[1]\
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(2),
      Q => \n_0_Q_reg_reg[2]\
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(3),
      Q => \n_0_Q_reg_reg[3]\
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(4),
      Q => \n_0_Q_reg_reg[4]\
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(5),
      Q => \^p_0_in\(5)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\wr_pntr_bin[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[2]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \n_0_Q_reg_reg[0]\,
      I3 => \n_0_Q_reg_reg[1]\,
      I4 => \^p_0_in\(5),
      I5 => \n_0_Q_reg_reg[4]\,
      O => \^p_0_in\(0)
    );
\wr_pntr_bin[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[4]\,
      I2 => \n_0_Q_reg_reg[1]\,
      I3 => \n_0_Q_reg_reg[2]\,
      I4 => \^p_0_in\(5),
      O => \^p_0_in\(1)
    );
\wr_pntr_bin[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[2]\,
      I2 => \^p_0_in\(5),
      I3 => \n_0_Q_reg_reg[4]\,
      O => \^p_0_in\(2)
    );
\wr_pntr_bin[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \^p_0_in\(5),
      O => \^p_0_in\(3)
    );
\wr_pntr_bin[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \^p_0_in\(5),
      O => \^p_0_in\(4)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64synchronizer_ff_27 is
  port (
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    O1 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    D : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_aclk : in STD_LOGIC;
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64synchronizer_ff_27 : entity is "synchronizer_ff";
end t_axi4_lite32_w_afifo_d64synchronizer_ff_27;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64synchronizer_ff_27 is
  signal \<const1>\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \n_0_Q_reg_reg[0]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[1]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[2]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[3]\ : STD_LOGIC;
  signal \n_0_Q_reg_reg[4]\ : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \Q_reg_reg[0]\ : label is true;
  attribute msgon : string;
  attribute msgon of \Q_reg_reg[0]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[1]\ : label is true;
  attribute msgon of \Q_reg_reg[1]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[2]\ : label is true;
  attribute msgon of \Q_reg_reg[2]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[3]\ : label is true;
  attribute msgon of \Q_reg_reg[3]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[4]\ : label is true;
  attribute msgon of \Q_reg_reg[4]\ : label is "true";
  attribute ASYNC_REG of \Q_reg_reg[5]\ : label is true;
  attribute msgon of \Q_reg_reg[5]\ : label is "true";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \rd_pntr_bin[1]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \rd_pntr_bin[2]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \rd_pntr_bin[3]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \rd_pntr_bin[4]_i_1\ : label is "soft_lutpair10";
begin
  Q(0) <= \^q\(0);
\Q_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(0),
      Q => \n_0_Q_reg_reg[0]\
    );
\Q_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(1),
      Q => \n_0_Q_reg_reg[1]\
    );
\Q_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(2),
      Q => \n_0_Q_reg_reg[2]\
    );
\Q_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(3),
      Q => \n_0_Q_reg_reg[3]\
    );
\Q_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(4),
      Q => \n_0_Q_reg_reg[4]\
    );
\Q_reg_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => D(5),
      Q => \^q\(0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\rd_pntr_bin[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[2]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \n_0_Q_reg_reg[0]\,
      I3 => \n_0_Q_reg_reg[1]\,
      I4 => \^q\(0),
      I5 => \n_0_Q_reg_reg[4]\,
      O => O1(0)
    );
\rd_pntr_bin[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[4]\,
      I2 => \n_0_Q_reg_reg[1]\,
      I3 => \n_0_Q_reg_reg[2]\,
      I4 => \^q\(0),
      O => O1(1)
    );
\rd_pntr_bin[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_Q_reg_reg[3]\,
      I1 => \n_0_Q_reg_reg[2]\,
      I2 => \^q\(0),
      I3 => \n_0_Q_reg_reg[4]\,
      O => O1(2)
    );
\rd_pntr_bin[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \n_0_Q_reg_reg[3]\,
      I2 => \^q\(0),
      O => O1(3)
    );
\rd_pntr_bin[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_Q_reg_reg[4]\,
      I1 => \^q\(0),
      O => O1(4)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_bin_cntr is
  port (
    O1 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    O2 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O4 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O3 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    p_0_out : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_aclk : in STD_LOGIC;
    I2 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end t_axi4_lite32_w_afifo_d64wr_bin_cntr;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_bin_cntr is
  signal \^o4\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \plusOp__3\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal wr_pntr_plus2 : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute RETAIN_INVERTER : boolean;
  attribute RETAIN_INVERTER of \gic0.gc0.count[0]_i_1__1\ : label is true;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gic0.gc0.count[0]_i_1__1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \gic0.gc0.count[2]_i_1__1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \gic0.gc0.count[3]_i_1__1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \gic0.gc0.count[4]_i_1__1\ : label is "soft_lutpair42";
  attribute counter : integer;
  attribute counter of \gic0.gc0.count_reg[0]\ : label is 5;
  attribute counter of \gic0.gc0.count_reg[1]\ : label is 5;
  attribute counter of \gic0.gc0.count_reg[2]\ : label is 5;
  attribute counter of \gic0.gc0.count_reg[3]\ : label is 5;
  attribute counter of \gic0.gc0.count_reg[4]\ : label is 5;
  attribute counter of \gic0.gc0.count_reg[5]\ : label is 5;
begin
  O4(5 downto 0) <= \^o4\(5 downto 0);
  Q(3 downto 0) <= \^q\(3 downto 0);
\gic0.gc0.count[0]_i_1__1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => wr_pntr_plus2(0),
      O => \plusOp__3\(0)
    );
\gic0.gc0.count[1]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => wr_pntr_plus2(0),
      I1 => wr_pntr_plus2(1),
      O => \plusOp__3\(1)
    );
\gic0.gc0.count[2]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => wr_pntr_plus2(0),
      I1 => wr_pntr_plus2(1),
      I2 => \^q\(0),
      O => \plusOp__3\(2)
    );
\gic0.gc0.count[3]_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => \^q\(1),
      I1 => wr_pntr_plus2(0),
      I2 => wr_pntr_plus2(1),
      I3 => \^q\(0),
      O => \plusOp__3\(3)
    );
\gic0.gc0.count[4]_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => \^q\(2),
      I1 => wr_pntr_plus2(1),
      I2 => wr_pntr_plus2(0),
      I3 => \^q\(0),
      I4 => \^q\(1),
      O => \plusOp__3\(4)
    );
\gic0.gc0.count[5]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => \^q\(3),
      I1 => \^q\(1),
      I2 => \^q\(0),
      I3 => wr_pntr_plus2(0),
      I4 => wr_pntr_plus2(1),
      I5 => \^q\(2),
      O => \plusOp__3\(5)
    );
\gic0.gc0.count_d1_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      D => wr_pntr_plus2(0),
      PRE => I2(0),
      Q => \^o4\(0)
    );
\gic0.gc0.count_d1_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => wr_pntr_plus2(1),
      Q => \^o4\(1)
    );
\gic0.gc0.count_d1_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \^q\(0),
      Q => \^o4\(2)
    );
\gic0.gc0.count_d1_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \^q\(1),
      Q => \^o4\(3)
    );
\gic0.gc0.count_d1_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \^q\(2),
      Q => \^o4\(4)
    );
\gic0.gc0.count_d1_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \^q\(3),
      Q => \^o4\(5)
    );
\gic0.gc0.count_d2_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \^o4\(0),
      Q => O2(0)
    );
\gic0.gc0.count_d2_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \^o4\(1),
      Q => O2(1)
    );
\gic0.gc0.count_d2_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \^o4\(2),
      Q => O2(2)
    );
\gic0.gc0.count_d2_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \^o4\(3),
      Q => O2(3)
    );
\gic0.gc0.count_d2_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \^o4\(4),
      Q => O2(4)
    );
\gic0.gc0.count_d2_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \^o4\(5),
      Q => O2(5)
    );
\gic0.gc0.count_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \plusOp__3\(0),
      Q => wr_pntr_plus2(0)
    );
\gic0.gc0.count_reg[1]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      D => \plusOp__3\(1),
      PRE => I2(0),
      Q => wr_pntr_plus2(1)
    );
\gic0.gc0.count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \plusOp__3\(2),
      Q => \^q\(0)
    );
\gic0.gc0.count_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \plusOp__3\(3),
      Q => \^q\(1)
    );
\gic0.gc0.count_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \plusOp__3\(4),
      Q => \^q\(2)
    );
\gic0.gc0.count_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I2(0),
      D => \plusOp__3\(5),
      Q => \^q\(3)
    );
\ram_full_fb_i_i_3__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F6FFFFFFFFFFF6FF"
    )
    port map (
      I0 => O3(0),
      I1 => wr_pntr_plus2(0),
      I2 => p_0_out,
      I3 => s_axi_wvalid,
      I4 => wr_pntr_plus2(1),
      I5 => O3(1),
      O => O1
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_bin_cntr_21 is
  port (
    O1 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O2 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    rst_full_gen_i : in STD_LOGIC;
    O5 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    I2 : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    p_0_out : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_aclk : in STD_LOGIC;
    I3 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64wr_bin_cntr_21 : entity is "wr_bin_cntr";
end t_axi4_lite32_w_afifo_d64wr_bin_cntr_21;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_bin_cntr_21 is
  signal \^o2\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \n_0_ram_full_fb_i_i_2__1\ : STD_LOGIC;
  signal \n_0_ram_full_fb_i_i_3__0\ : STD_LOGIC;
  signal \plusOp__2\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal wr_pntr_plus2 : STD_LOGIC_VECTOR ( 5 downto 0 );
  attribute RETAIN_INVERTER : boolean;
  attribute RETAIN_INVERTER of \gic0.gc0.count[0]_i_1__0\ : label is true;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gic0.gc0.count[0]_i_1__0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gic0.gc0.count[2]_i_1__0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gic0.gc0.count[3]_i_1__0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gic0.gc0.count[4]_i_1__0\ : label is "soft_lutpair13";
  attribute counter : integer;
  attribute counter of \gic0.gc0.count_reg[0]\ : label is 3;
  attribute counter of \gic0.gc0.count_reg[1]\ : label is 3;
  attribute counter of \gic0.gc0.count_reg[2]\ : label is 3;
  attribute counter of \gic0.gc0.count_reg[3]\ : label is 3;
  attribute counter of \gic0.gc0.count_reg[4]\ : label is 3;
  attribute counter of \gic0.gc0.count_reg[5]\ : label is 3;
begin
  O2(5 downto 0) <= \^o2\(5 downto 0);
\gic0.gc0.count[0]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => wr_pntr_plus2(0),
      O => \plusOp__2\(0)
    );
\gic0.gc0.count[1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => wr_pntr_plus2(0),
      I1 => wr_pntr_plus2(1),
      O => \plusOp__2\(1)
    );
\gic0.gc0.count[2]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => wr_pntr_plus2(0),
      I1 => wr_pntr_plus2(1),
      I2 => wr_pntr_plus2(2),
      O => \plusOp__2\(2)
    );
\gic0.gc0.count[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => wr_pntr_plus2(3),
      I1 => wr_pntr_plus2(0),
      I2 => wr_pntr_plus2(1),
      I3 => wr_pntr_plus2(2),
      O => \plusOp__2\(3)
    );
\gic0.gc0.count[4]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => wr_pntr_plus2(4),
      I1 => wr_pntr_plus2(1),
      I2 => wr_pntr_plus2(0),
      I3 => wr_pntr_plus2(2),
      I4 => wr_pntr_plus2(3),
      O => \plusOp__2\(4)
    );
\gic0.gc0.count[5]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => wr_pntr_plus2(5),
      I1 => wr_pntr_plus2(3),
      I2 => wr_pntr_plus2(2),
      I3 => wr_pntr_plus2(0),
      I4 => wr_pntr_plus2(1),
      I5 => wr_pntr_plus2(4),
      O => \plusOp__2\(5)
    );
\gic0.gc0.count_d1_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      D => wr_pntr_plus2(0),
      PRE => I3(0),
      Q => \^o2\(0)
    );
\gic0.gc0.count_d1_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => wr_pntr_plus2(1),
      Q => \^o2\(1)
    );
\gic0.gc0.count_d1_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => wr_pntr_plus2(2),
      Q => \^o2\(2)
    );
\gic0.gc0.count_d1_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => wr_pntr_plus2(3),
      Q => \^o2\(3)
    );
\gic0.gc0.count_d1_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => wr_pntr_plus2(4),
      Q => \^o2\(4)
    );
\gic0.gc0.count_d1_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => wr_pntr_plus2(5),
      Q => \^o2\(5)
    );
\gic0.gc0.count_d2_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o2\(0),
      Q => Q(0)
    );
\gic0.gc0.count_d2_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o2\(1),
      Q => Q(1)
    );
\gic0.gc0.count_d2_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o2\(2),
      Q => Q(2)
    );
\gic0.gc0.count_d2_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o2\(3),
      Q => Q(3)
    );
\gic0.gc0.count_d2_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o2\(4),
      Q => Q(4)
    );
\gic0.gc0.count_d2_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o2\(5),
      Q => Q(5)
    );
\gic0.gc0.count_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \plusOp__2\(0),
      Q => wr_pntr_plus2(0)
    );
\gic0.gc0.count_reg[1]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      D => \plusOp__2\(1),
      PRE => I3(0),
      Q => wr_pntr_plus2(1)
    );
\gic0.gc0.count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \plusOp__2\(2),
      Q => wr_pntr_plus2(2)
    );
\gic0.gc0.count_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \plusOp__2\(3),
      Q => wr_pntr_plus2(3)
    );
\gic0.gc0.count_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \plusOp__2\(4),
      Q => wr_pntr_plus2(4)
    );
\gic0.gc0.count_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \plusOp__2\(5),
      Q => wr_pntr_plus2(5)
    );
\ram_full_fb_i_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4000004055555555"
    )
    port map (
      I0 => rst_full_gen_i,
      I1 => \n_0_ram_full_fb_i_i_2__1\,
      I2 => \n_0_ram_full_fb_i_i_3__0\,
      I3 => O5(4),
      I4 => wr_pntr_plus2(4),
      I5 => I2,
      O => O1
    );
\ram_full_fb_i_i_2__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0090000000000090"
    )
    port map (
      I0 => wr_pntr_plus2(0),
      I1 => O5(0),
      I2 => s_axi_awvalid,
      I3 => p_0_out,
      I4 => O5(1),
      I5 => wr_pntr_plus2(1),
      O => \n_0_ram_full_fb_i_i_2__1\
    );
\ram_full_fb_i_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => wr_pntr_plus2(2),
      I1 => O5(2),
      I2 => wr_pntr_plus2(3),
      I3 => O5(3),
      I4 => O5(5),
      I5 => wr_pntr_plus2(5),
      O => \n_0_ram_full_fb_i_i_3__0\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_bin_cntr_7 is
  port (
    ram_full_i : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O1 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O3 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    p_0_out : in STD_LOGIC;
    I2 : in STD_LOGIC;
    rst_full_gen_i : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_aclk : in STD_LOGIC;
    I3 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64wr_bin_cntr_7 : entity is "wr_bin_cntr";
end t_axi4_lite32_w_afifo_d64wr_bin_cntr_7;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_bin_cntr_7 is
  signal \^o1\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal n_0_ram_full_fb_i_i_3 : STD_LOGIC;
  signal \n_0_ram_full_fb_i_i_4__0\ : STD_LOGIC;
  signal \plusOp__1\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal wr_pntr_plus2 : STD_LOGIC_VECTOR ( 5 downto 0 );
  attribute RETAIN_INVERTER : boolean;
  attribute RETAIN_INVERTER of \gic0.gc0.count[0]_i_1\ : label is true;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gic0.gc0.count[0]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \gic0.gc0.count[2]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \gic0.gc0.count[3]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \gic0.gc0.count[4]_i_1\ : label is "soft_lutpair27";
  attribute counter : integer;
  attribute counter of \gic0.gc0.count_reg[0]\ : label is 7;
  attribute counter of \gic0.gc0.count_reg[1]\ : label is 7;
  attribute counter of \gic0.gc0.count_reg[2]\ : label is 7;
  attribute counter of \gic0.gc0.count_reg[3]\ : label is 7;
  attribute counter of \gic0.gc0.count_reg[4]\ : label is 7;
  attribute counter of \gic0.gc0.count_reg[5]\ : label is 7;
begin
  O1(5 downto 0) <= \^o1\(5 downto 0);
\gic0.gc0.count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => wr_pntr_plus2(0),
      O => \plusOp__1\(0)
    );
\gic0.gc0.count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => wr_pntr_plus2(0),
      I1 => wr_pntr_plus2(1),
      O => \plusOp__1\(1)
    );
\gic0.gc0.count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => wr_pntr_plus2(0),
      I1 => wr_pntr_plus2(1),
      I2 => wr_pntr_plus2(2),
      O => \plusOp__1\(2)
    );
\gic0.gc0.count[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => wr_pntr_plus2(3),
      I1 => wr_pntr_plus2(0),
      I2 => wr_pntr_plus2(1),
      I3 => wr_pntr_plus2(2),
      O => \plusOp__1\(3)
    );
\gic0.gc0.count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => wr_pntr_plus2(4),
      I1 => wr_pntr_plus2(1),
      I2 => wr_pntr_plus2(0),
      I3 => wr_pntr_plus2(2),
      I4 => wr_pntr_plus2(3),
      O => \plusOp__1\(4)
    );
\gic0.gc0.count[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => wr_pntr_plus2(5),
      I1 => wr_pntr_plus2(3),
      I2 => wr_pntr_plus2(2),
      I3 => wr_pntr_plus2(0),
      I4 => wr_pntr_plus2(1),
      I5 => wr_pntr_plus2(4),
      O => \plusOp__1\(5)
    );
\gic0.gc0.count_d1_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      D => wr_pntr_plus2(0),
      PRE => I3(0),
      Q => \^o1\(0)
    );
\gic0.gc0.count_d1_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => wr_pntr_plus2(1),
      Q => \^o1\(1)
    );
\gic0.gc0.count_d1_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => wr_pntr_plus2(2),
      Q => \^o1\(2)
    );
\gic0.gc0.count_d1_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => wr_pntr_plus2(3),
      Q => \^o1\(3)
    );
\gic0.gc0.count_d1_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => wr_pntr_plus2(4),
      Q => \^o1\(4)
    );
\gic0.gc0.count_d1_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => wr_pntr_plus2(5),
      Q => \^o1\(5)
    );
\gic0.gc0.count_d2_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o1\(0),
      Q => Q(0)
    );
\gic0.gc0.count_d2_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o1\(1),
      Q => Q(1)
    );
\gic0.gc0.count_d2_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o1\(2),
      Q => Q(2)
    );
\gic0.gc0.count_d2_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o1\(3),
      Q => Q(3)
    );
\gic0.gc0.count_d2_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o1\(4),
      Q => Q(4)
    );
\gic0.gc0.count_d2_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \^o1\(5),
      Q => Q(5)
    );
\gic0.gc0.count_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \plusOp__1\(0),
      Q => wr_pntr_plus2(0)
    );
\gic0.gc0.count_reg[1]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      D => \plusOp__1\(1),
      PRE => I3(0),
      Q => wr_pntr_plus2(1)
    );
\gic0.gc0.count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \plusOp__1\(2),
      Q => wr_pntr_plus2(2)
    );
\gic0.gc0.count_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \plusOp__1\(3),
      Q => wr_pntr_plus2(3)
    );
\gic0.gc0.count_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \plusOp__1\(4),
      Q => wr_pntr_plus2(4)
    );
\gic0.gc0.count_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => E(0),
      CLR => I3(0),
      D => \plusOp__1\(5),
      Q => wr_pntr_plus2(5)
    );
ram_full_fb_i_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000D55555D5"
    )
    port map (
      I0 => I2,
      I1 => n_0_ram_full_fb_i_i_3,
      I2 => \n_0_ram_full_fb_i_i_4__0\,
      I3 => O3(4),
      I4 => wr_pntr_plus2(4),
      I5 => rst_full_gen_i,
      O => ram_full_i
    );
ram_full_fb_i_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0090000000000090"
    )
    port map (
      I0 => wr_pntr_plus2(1),
      I1 => O3(1),
      I2 => m_axi_bvalid,
      I3 => p_0_out,
      I4 => O3(0),
      I5 => wr_pntr_plus2(0),
      O => n_0_ram_full_fb_i_i_3
    );
\ram_full_fb_i_i_4__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => wr_pntr_plus2(2),
      I1 => O3(2),
      I2 => wr_pntr_plus2(3),
      I3 => O3(3),
      I4 => O3(5),
      I5 => wr_pntr_plus2(5),
      O => \n_0_ram_full_fb_i_i_4__0\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_handshaking_flags is
  port (
    axi_w_overflow : out STD_LOGIC;
    I1 : in STD_LOGIC;
    s_aclk : in STD_LOGIC
  );
end t_axi4_lite32_w_afifo_d64wr_handshaking_flags;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_handshaking_flags is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gof.gof1.overflow_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => I1,
      Q => axi_w_overflow,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_handshaking_flags_23 is
  port (
    axi_aw_overflow : out STD_LOGIC;
    I1 : in STD_LOGIC;
    s_aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64wr_handshaking_flags_23 : entity is "wr_handshaking_flags";
end t_axi4_lite32_w_afifo_d64wr_handshaking_flags_23;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_handshaking_flags_23 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gof.gof1.overflow_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => I1,
      Q => axi_aw_overflow,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_handshaking_flags_9 is
  port (
    axi_b_overflow : out STD_LOGIC;
    I1 : in STD_LOGIC;
    m_aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64wr_handshaking_flags_9 : entity is "wr_handshaking_flags";
end t_axi4_lite32_w_afifo_d64wr_handshaking_flags_9;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_handshaking_flags_9 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gof.gof1.overflow_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => I1,
      Q => axi_b_overflow,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_status_flags_as is
  port (
    p_0_out : out STD_LOGIC;
    O1 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC;
    I1 : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    rst_d2 : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC
  );
end t_axi4_lite32_w_afifo_d64wr_status_flags_as;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_status_flags_as is
  signal \<const1>\ : STD_LOGIC;
  signal n_0_ram_full_i_reg : STD_LOGIC;
  signal \^p_0_out\ : STD_LOGIC;
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of ram_full_fb_i_reg : label is "no";
  attribute equivalent_register_removal of ram_full_i_reg : label is "no";
begin
  p_0_out <= \^p_0_out\;
\RAM_reg_0_63_0_2_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => s_axi_wvalid,
      I1 => \^p_0_out\,
      O => E(0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gof.gof1.overflow_i_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^p_0_out\,
      I1 => s_axi_wvalid,
      O => O1
    );
ram_full_fb_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => I1,
      PRE => rst_d2,
      Q => \^p_0_out\
    );
ram_full_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => I1,
      PRE => rst_d2,
      Q => n_0_ram_full_i_reg
    );
s_axi_wready_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => n_0_ram_full_i_reg,
      O => s_axi_wready
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_status_flags_as_22 is
  port (
    p_0_out : out STD_LOGIC;
    O1 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC;
    I1 : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    I2 : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64wr_status_flags_as_22 : entity is "wr_status_flags_as";
end t_axi4_lite32_w_afifo_d64wr_status_flags_as_22;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_status_flags_as_22 is
  signal \<const1>\ : STD_LOGIC;
  signal \^p_0_out\ : STD_LOGIC;
  signal ram_full_i : STD_LOGIC;
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of ram_full_fb_i_reg : label is "no";
  attribute equivalent_register_removal of ram_full_i_reg : label is "no";
begin
  p_0_out <= \^p_0_out\;
RAM_reg_0_63_0_2_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => s_axi_awvalid,
      I1 => \^p_0_out\,
      O => E(0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gof.gof1.overflow_i_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^p_0_out\,
      I1 => s_axi_awvalid,
      O => O1
    );
ram_full_fb_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => I1,
      PRE => I2,
      Q => \^p_0_out\
    );
ram_full_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => I1,
      PRE => I2,
      Q => ram_full_i
    );
s_axi_awready_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => ram_full_i,
      O => s_axi_awready
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_status_flags_as_8 is
  port (
    p_0_out : out STD_LOGIC;
    O1 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bready : out STD_LOGIC;
    ram_full_i : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    I1 : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64wr_status_flags_as_8 : entity is "wr_status_flags_as";
end t_axi4_lite32_w_afifo_d64wr_status_flags_as_8;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_status_flags_as_8 is
  signal \<const1>\ : STD_LOGIC;
  signal n_0_ram_full_i_reg : STD_LOGIC;
  signal \^p_0_out\ : STD_LOGIC;
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of ram_full_fb_i_reg : label is "no";
  attribute equivalent_register_removal of ram_full_i_reg : label is "no";
begin
  p_0_out <= \^p_0_out\;
RAM_reg_0_63_0_1_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => m_axi_bvalid,
      I1 => \^p_0_out\,
      O => E(0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gof.gof1.overflow_i_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^p_0_out\,
      I1 => m_axi_bvalid,
      O => O1
    );
m_axi_bready_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => n_0_ram_full_i_reg,
      O => m_axi_bready
    );
ram_full_fb_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => ram_full_i,
      PRE => I1,
      Q => \^p_0_out\
    );
ram_full_i_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      D => ram_full_i,
      PRE => I1,
      Q => n_0_ram_full_i_reg
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64clk_x_pntrs is
  port (
    O1 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    O4 : out STD_LOGIC;
    I1 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rst_full_gen_i : in STD_LOGIC;
    I2 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I3 : in STD_LOGIC;
    ADDRA : in STD_LOGIC_VECTOR ( 5 downto 0 );
    I4 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    I5 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_aclk : in STD_LOGIC;
    I6 : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_aclk : in STD_LOGIC;
    I7 : in STD_LOGIC_VECTOR ( 0 to 0 );
    D : in STD_LOGIC_VECTOR ( 4 downto 0 )
  );
end t_axi4_lite32_w_afifo_d64clk_x_pntrs;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64clk_x_pntrs is
  signal \<const1>\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \n_0_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_0_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_0_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_0_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_0_ram_empty_fb_i_i_6__0\ : STD_LOGIC;
  signal \n_0_ram_empty_fb_i_i_7__0\ : STD_LOGIC;
  signal \n_0_ram_full_fb_i_i_2__0\ : STD_LOGIC;
  signal \n_0_ram_full_fb_i_i_4__1\ : STD_LOGIC;
  signal \n_0_ram_full_fb_i_i_5__1\ : STD_LOGIC;
  signal \n_0_ram_full_fb_i_i_6__1\ : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[0]\ : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[1]\ : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[2]\ : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[3]\ : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[4]\ : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[5]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[0]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[1]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[2]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[3]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[4]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[5]\ : STD_LOGIC;
  signal \n_1_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_1_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_1_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_1_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_2_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_2_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_2_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_2_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_3_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_3_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_3_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_3_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_4_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_4_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_4_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_4_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_5_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_5_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_5_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_5_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal p_0_in3_out : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal p_0_out : STD_LOGIC_VECTOR ( 5 downto 2 );
  signal p_1_out : STD_LOGIC_VECTOR ( 2 downto 1 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \wr_pntr_gc[0]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \wr_pntr_gc[1]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \wr_pntr_gc[2]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \wr_pntr_gc[3]_i_1\ : label is "soft_lutpair41";
begin
  O3(1 downto 0) <= \^o3\(1 downto 0);
  Q(3 downto 0) <= \^q\(3 downto 0);
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gsync_stage[1].rd_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff
    port map (
      I1(5) => \n_0_wr_pntr_gc_reg[5]\,
      I1(4) => \n_0_wr_pntr_gc_reg[4]\,
      I1(3) => \n_0_wr_pntr_gc_reg[3]\,
      I1(2) => \n_0_wr_pntr_gc_reg[2]\,
      I1(1) => \n_0_wr_pntr_gc_reg[1]\,
      I1(0) => \n_0_wr_pntr_gc_reg[0]\,
      I6(0) => I6(0),
      Q(5) => \n_0_gsync_stage[1].rd_stg_inst\,
      Q(4) => \n_1_gsync_stage[1].rd_stg_inst\,
      Q(3) => \n_2_gsync_stage[1].rd_stg_inst\,
      Q(2) => \n_3_gsync_stage[1].rd_stg_inst\,
      Q(1) => \n_4_gsync_stage[1].rd_stg_inst\,
      Q(0) => \n_5_gsync_stage[1].rd_stg_inst\,
      m_aclk => m_aclk
    );
\gsync_stage[1].wr_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff_0
    port map (
      I1(5) => \n_0_rd_pntr_gc_reg[5]\,
      I1(4) => \n_0_rd_pntr_gc_reg[4]\,
      I1(3) => \n_0_rd_pntr_gc_reg[3]\,
      I1(2) => \n_0_rd_pntr_gc_reg[2]\,
      I1(1) => \n_0_rd_pntr_gc_reg[1]\,
      I1(0) => \n_0_rd_pntr_gc_reg[0]\,
      I7(0) => I7(0),
      Q(5) => \n_0_gsync_stage[1].wr_stg_inst\,
      Q(4) => \n_1_gsync_stage[1].wr_stg_inst\,
      Q(3) => \n_2_gsync_stage[1].wr_stg_inst\,
      Q(2) => \n_3_gsync_stage[1].wr_stg_inst\,
      Q(1) => \n_4_gsync_stage[1].wr_stg_inst\,
      Q(0) => \n_5_gsync_stage[1].wr_stg_inst\,
      s_aclk => s_aclk
    );
\gsync_stage[2].rd_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff_1
    port map (
      D(5) => \n_0_gsync_stage[1].rd_stg_inst\,
      D(4) => \n_1_gsync_stage[1].rd_stg_inst\,
      D(3) => \n_2_gsync_stage[1].rd_stg_inst\,
      D(2) => \n_3_gsync_stage[1].rd_stg_inst\,
      D(1) => \n_4_gsync_stage[1].rd_stg_inst\,
      D(0) => \n_5_gsync_stage[1].rd_stg_inst\,
      I6(0) => I6(0),
      O1(4) => \n_1_gsync_stage[2].rd_stg_inst\,
      O1(3) => \n_2_gsync_stage[2].rd_stg_inst\,
      O1(2) => \n_3_gsync_stage[2].rd_stg_inst\,
      O1(1) => \n_4_gsync_stage[2].rd_stg_inst\,
      O1(0) => \n_5_gsync_stage[2].rd_stg_inst\,
      Q(0) => \n_0_gsync_stage[2].rd_stg_inst\,
      m_aclk => m_aclk
    );
\gsync_stage[2].wr_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff_2
    port map (
      D(5) => \n_0_gsync_stage[1].wr_stg_inst\,
      D(4) => \n_1_gsync_stage[1].wr_stg_inst\,
      D(3) => \n_2_gsync_stage[1].wr_stg_inst\,
      D(2) => \n_3_gsync_stage[1].wr_stg_inst\,
      D(1) => \n_4_gsync_stage[1].wr_stg_inst\,
      D(0) => \n_5_gsync_stage[1].wr_stg_inst\,
      I7(0) => I7(0),
      O1(4) => \n_1_gsync_stage[2].wr_stg_inst\,
      O1(3) => \n_2_gsync_stage[2].wr_stg_inst\,
      O1(2) => \n_3_gsync_stage[2].wr_stg_inst\,
      O1(1) => \n_4_gsync_stage[2].wr_stg_inst\,
      O1(0) => \n_5_gsync_stage[2].wr_stg_inst\,
      Q(0) => \n_0_gsync_stage[2].wr_stg_inst\,
      s_aclk => s_aclk
    );
\ram_empty_fb_i_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000009009"
    )
    port map (
      I0 => ADDRA(4),
      I1 => \^q\(2),
      I2 => ADDRA(5),
      I3 => \^q\(3),
      I4 => \n_0_ram_empty_fb_i_i_6__0\,
      I5 => \n_0_ram_empty_fb_i_i_7__0\,
      O => O4
    );
\ram_empty_fb_i_i_5__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(2),
      I1 => I1(1),
      I2 => p_1_out(1),
      I3 => I1(0),
      O => O1
    );
\ram_empty_fb_i_i_6__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => \^q\(1),
      I1 => ADDRA(3),
      I2 => p_1_out(2),
      I3 => ADDRA(2),
      O => \n_0_ram_empty_fb_i_i_6__0\
    );
\ram_empty_fb_i_i_7__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => p_1_out(1),
      I1 => ADDRA(1),
      I2 => \^q\(0),
      I3 => ADDRA(0),
      O => \n_0_ram_empty_fb_i_i_7__0\
    );
\ram_full_fb_i_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444444444445445"
    )
    port map (
      I0 => rst_full_gen_i,
      I1 => \n_0_ram_full_fb_i_i_2__0\,
      I2 => p_0_out(4),
      I3 => I2(2),
      I4 => I3,
      I5 => \n_0_ram_full_fb_i_i_4__1\,
      O => O2
    );
\ram_full_fb_i_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000009009"
    )
    port map (
      I0 => I4(5),
      I1 => p_0_out(5),
      I2 => I4(4),
      I3 => p_0_out(4),
      I4 => \n_0_ram_full_fb_i_i_5__1\,
      I5 => \n_0_ram_full_fb_i_i_6__1\,
      O => \n_0_ram_full_fb_i_i_2__0\
    );
\ram_full_fb_i_i_4__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6FF6FFFFFFFF6FF6"
    )
    port map (
      I0 => p_0_out(5),
      I1 => I2(3),
      I2 => I2(1),
      I3 => p_0_out(3),
      I4 => I2(0),
      I5 => p_0_out(2),
      O => \n_0_ram_full_fb_i_i_4__1\
    );
\ram_full_fb_i_i_5__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => \^o3\(1),
      I1 => I4(1),
      I2 => \^o3\(0),
      I3 => I4(0),
      O => \n_0_ram_full_fb_i_i_5__1\
    );
\ram_full_fb_i_i_6__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => p_0_out(2),
      I1 => I4(2),
      I2 => p_0_out(3),
      I3 => I4(3),
      O => \n_0_ram_full_fb_i_i_6__1\
    );
\rd_pntr_bin_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => \n_5_gsync_stage[2].wr_stg_inst\,
      Q => \^o3\(0)
    );
\rd_pntr_bin_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => \n_4_gsync_stage[2].wr_stg_inst\,
      Q => \^o3\(1)
    );
\rd_pntr_bin_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => \n_3_gsync_stage[2].wr_stg_inst\,
      Q => p_0_out(2)
    );
\rd_pntr_bin_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => \n_2_gsync_stage[2].wr_stg_inst\,
      Q => p_0_out(3)
    );
\rd_pntr_bin_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => \n_1_gsync_stage[2].wr_stg_inst\,
      Q => p_0_out(4)
    );
\rd_pntr_bin_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => \n_0_gsync_stage[2].wr_stg_inst\,
      Q => p_0_out(5)
    );
\rd_pntr_gc_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => D(0),
      Q => \n_0_rd_pntr_gc_reg[0]\
    );
\rd_pntr_gc_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => D(1),
      Q => \n_0_rd_pntr_gc_reg[1]\
    );
\rd_pntr_gc_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => D(2),
      Q => \n_0_rd_pntr_gc_reg[2]\
    );
\rd_pntr_gc_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => D(3),
      Q => \n_0_rd_pntr_gc_reg[3]\
    );
\rd_pntr_gc_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => D(4),
      Q => \n_0_rd_pntr_gc_reg[4]\
    );
\rd_pntr_gc_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => ADDRA(5),
      Q => \n_0_rd_pntr_gc_reg[5]\
    );
\wr_pntr_bin_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => \n_5_gsync_stage[2].rd_stg_inst\,
      Q => \^q\(0)
    );
\wr_pntr_bin_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => \n_4_gsync_stage[2].rd_stg_inst\,
      Q => p_1_out(1)
    );
\wr_pntr_bin_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => \n_3_gsync_stage[2].rd_stg_inst\,
      Q => p_1_out(2)
    );
\wr_pntr_bin_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => \n_2_gsync_stage[2].rd_stg_inst\,
      Q => \^q\(1)
    );
\wr_pntr_bin_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => \n_1_gsync_stage[2].rd_stg_inst\,
      Q => \^q\(2)
    );
\wr_pntr_bin_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I6(0),
      D => \n_0_gsync_stage[2].rd_stg_inst\,
      Q => \^q\(3)
    );
\wr_pntr_gc[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I5(0),
      I1 => I5(1),
      O => p_0_in3_out(0)
    );
\wr_pntr_gc[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I5(1),
      I1 => I5(2),
      O => p_0_in3_out(1)
    );
\wr_pntr_gc[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I5(2),
      I1 => I5(3),
      O => p_0_in3_out(2)
    );
\wr_pntr_gc[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I5(3),
      I1 => I5(4),
      O => p_0_in3_out(3)
    );
\wr_pntr_gc[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I5(4),
      I1 => I5(5),
      O => p_0_in3_out(4)
    );
\wr_pntr_gc_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => p_0_in3_out(0),
      Q => \n_0_wr_pntr_gc_reg[0]\
    );
\wr_pntr_gc_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => p_0_in3_out(1),
      Q => \n_0_wr_pntr_gc_reg[1]\
    );
\wr_pntr_gc_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => p_0_in3_out(2),
      Q => \n_0_wr_pntr_gc_reg[2]\
    );
\wr_pntr_gc_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => p_0_in3_out(3),
      Q => \n_0_wr_pntr_gc_reg[3]\
    );
\wr_pntr_gc_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => p_0_in3_out(4),
      Q => \n_0_wr_pntr_gc_reg[4]\
    );
\wr_pntr_gc_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I7(0),
      D => I5(5),
      Q => \n_0_wr_pntr_gc_reg[5]\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64clk_x_pntrs_18 is
  port (
    O1 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    O2 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    D : in STD_LOGIC_VECTOR ( 5 downto 0 );
    O3 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    I2 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    I3 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_aclk : in STD_LOGIC;
    I4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_aclk : in STD_LOGIC;
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64clk_x_pntrs_18 : entity is "clk_x_pntrs";
end t_axi4_lite32_w_afifo_d64clk_x_pntrs_18;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64clk_x_pntrs_18 is
  signal \<const1>\ : STD_LOGIC;
  signal \^o5\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \n_0_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_0_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_0_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal n_0_ram_empty_fb_i_i_6 : STD_LOGIC;
  signal n_0_ram_empty_fb_i_i_7 : STD_LOGIC;
  signal \n_0_ram_full_fb_i_i_5__0\ : STD_LOGIC;
  signal \n_0_ram_full_fb_i_i_6__0\ : STD_LOGIC;
  signal \n_1_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_1_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_1_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_2_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_2_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_2_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_3_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_3_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_3_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_4_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_4_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_4_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_5_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_5_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_5_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal p_0_in3_out : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal p_1_out : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal rd_pntr_gc : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal wr_pntr_gc : STD_LOGIC_VECTOR ( 5 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \wr_pntr_gc[0]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \wr_pntr_gc[1]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \wr_pntr_gc[2]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \wr_pntr_gc[3]_i_1\ : label is "soft_lutpair12";
begin
  O5(5 downto 0) <= \^o5\(5 downto 0);
  Q(3 downto 0) <= \^q\(3 downto 0);
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gsync_stage[1].rd_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff_24
    port map (
      I1(5 downto 0) => wr_pntr_gc(5 downto 0),
      I4(0) => I4(0),
      Q(5) => \n_0_gsync_stage[1].rd_stg_inst\,
      Q(4) => \n_1_gsync_stage[1].rd_stg_inst\,
      Q(3) => \n_2_gsync_stage[1].rd_stg_inst\,
      Q(2) => \n_3_gsync_stage[1].rd_stg_inst\,
      Q(1) => \n_4_gsync_stage[1].rd_stg_inst\,
      Q(0) => \n_5_gsync_stage[1].rd_stg_inst\,
      m_aclk => m_aclk
    );
\gsync_stage[1].wr_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff_25
    port map (
      I1(5 downto 0) => rd_pntr_gc(5 downto 0),
      I5(0) => I5(0),
      Q(5) => \n_0_gsync_stage[1].wr_stg_inst\,
      Q(4) => \n_1_gsync_stage[1].wr_stg_inst\,
      Q(3) => \n_2_gsync_stage[1].wr_stg_inst\,
      Q(2) => \n_3_gsync_stage[1].wr_stg_inst\,
      Q(1) => \n_4_gsync_stage[1].wr_stg_inst\,
      Q(0) => \n_5_gsync_stage[1].wr_stg_inst\,
      s_aclk => s_aclk
    );
\gsync_stage[2].rd_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff_26
    port map (
      D(5) => \n_0_gsync_stage[1].rd_stg_inst\,
      D(4) => \n_1_gsync_stage[1].rd_stg_inst\,
      D(3) => \n_2_gsync_stage[1].rd_stg_inst\,
      D(2) => \n_3_gsync_stage[1].rd_stg_inst\,
      D(1) => \n_4_gsync_stage[1].rd_stg_inst\,
      D(0) => \n_5_gsync_stage[1].rd_stg_inst\,
      I4(0) => I4(0),
      m_aclk => m_aclk,
      p_0_in(5 downto 0) => p_0_in(5 downto 0)
    );
\gsync_stage[2].wr_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff_27
    port map (
      D(5) => \n_0_gsync_stage[1].wr_stg_inst\,
      D(4) => \n_1_gsync_stage[1].wr_stg_inst\,
      D(3) => \n_2_gsync_stage[1].wr_stg_inst\,
      D(2) => \n_3_gsync_stage[1].wr_stg_inst\,
      D(1) => \n_4_gsync_stage[1].wr_stg_inst\,
      D(0) => \n_5_gsync_stage[1].wr_stg_inst\,
      I5(0) => I5(0),
      O1(4) => \n_1_gsync_stage[2].wr_stg_inst\,
      O1(3) => \n_2_gsync_stage[2].wr_stg_inst\,
      O1(2) => \n_3_gsync_stage[2].wr_stg_inst\,
      O1(1) => \n_4_gsync_stage[2].wr_stg_inst\,
      O1(0) => \n_5_gsync_stage[2].wr_stg_inst\,
      Q(0) => \n_0_gsync_stage[2].wr_stg_inst\,
      s_aclk => s_aclk
    );
ram_empty_fb_i_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000009009"
    )
    port map (
      I0 => D(5),
      I1 => \^q\(3),
      I2 => O3(0),
      I3 => p_1_out(0),
      I4 => n_0_ram_empty_fb_i_i_6,
      I5 => n_0_ram_empty_fb_i_i_7,
      O => O2
    );
ram_empty_fb_i_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(0),
      I1 => I1(0),
      I2 => p_1_out(2),
      I3 => I1(1),
      O => O1
    );
ram_empty_fb_i_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => \^q\(0),
      I1 => O3(1),
      I2 => \^q\(2),
      I3 => O3(4),
      O => n_0_ram_empty_fb_i_i_6
    );
ram_empty_fb_i_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => p_1_out(2),
      I1 => O3(2),
      I2 => \^q\(1),
      I3 => O3(3),
      O => n_0_ram_empty_fb_i_i_7
    );
ram_full_fb_i_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF6FF6"
    )
    port map (
      I0 => I2(5),
      I1 => \^o5\(5),
      I2 => I2(4),
      I3 => \^o5\(4),
      I4 => \n_0_ram_full_fb_i_i_5__0\,
      I5 => \n_0_ram_full_fb_i_i_6__0\,
      O => O4
    );
\ram_full_fb_i_i_5__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => \^o5\(1),
      I1 => I2(1),
      I2 => \^o5\(0),
      I3 => I2(0),
      O => \n_0_ram_full_fb_i_i_5__0\
    );
\ram_full_fb_i_i_6__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => \^o5\(2),
      I1 => I2(2),
      I2 => \^o5\(3),
      I3 => I2(3),
      O => \n_0_ram_full_fb_i_i_6__0\
    );
\rd_pntr_bin_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_5_gsync_stage[2].wr_stg_inst\,
      Q => \^o5\(0)
    );
\rd_pntr_bin_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_4_gsync_stage[2].wr_stg_inst\,
      Q => \^o5\(1)
    );
\rd_pntr_bin_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_3_gsync_stage[2].wr_stg_inst\,
      Q => \^o5\(2)
    );
\rd_pntr_bin_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_2_gsync_stage[2].wr_stg_inst\,
      Q => \^o5\(3)
    );
\rd_pntr_bin_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_1_gsync_stage[2].wr_stg_inst\,
      Q => \^o5\(4)
    );
\rd_pntr_bin_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_0_gsync_stage[2].wr_stg_inst\,
      Q => \^o5\(5)
    );
\rd_pntr_gc_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(0),
      Q => rd_pntr_gc(0)
    );
\rd_pntr_gc_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(1),
      Q => rd_pntr_gc(1)
    );
\rd_pntr_gc_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(2),
      Q => rd_pntr_gc(2)
    );
\rd_pntr_gc_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(3),
      Q => rd_pntr_gc(3)
    );
\rd_pntr_gc_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(4),
      Q => rd_pntr_gc(4)
    );
\rd_pntr_gc_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(5),
      Q => rd_pntr_gc(5)
    );
\wr_pntr_bin_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => p_0_in(0),
      Q => p_1_out(0)
    );
\wr_pntr_bin_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => p_0_in(1),
      Q => \^q\(0)
    );
\wr_pntr_bin_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => p_0_in(2),
      Q => p_1_out(2)
    );
\wr_pntr_bin_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => p_0_in(3),
      Q => \^q\(1)
    );
\wr_pntr_bin_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => p_0_in(4),
      Q => \^q\(2)
    );
\wr_pntr_bin_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => p_0_in(5),
      Q => \^q\(3)
    );
\wr_pntr_gc[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I3(0),
      I1 => I3(1),
      O => p_0_in3_out(0)
    );
\wr_pntr_gc[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I3(1),
      I1 => I3(2),
      O => p_0_in3_out(1)
    );
\wr_pntr_gc[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I3(2),
      I1 => I3(3),
      O => p_0_in3_out(2)
    );
\wr_pntr_gc[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I3(3),
      I1 => I3(4),
      O => p_0_in3_out(3)
    );
\wr_pntr_gc[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I3(4),
      I1 => I3(5),
      O => p_0_in3_out(4)
    );
\wr_pntr_gc_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => p_0_in3_out(0),
      Q => wr_pntr_gc(0)
    );
\wr_pntr_gc_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => p_0_in3_out(1),
      Q => wr_pntr_gc(1)
    );
\wr_pntr_gc_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => p_0_in3_out(2),
      Q => wr_pntr_gc(2)
    );
\wr_pntr_gc_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => p_0_in3_out(3),
      Q => wr_pntr_gc(3)
    );
\wr_pntr_gc_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => p_0_in3_out(4),
      Q => wr_pntr_gc(4)
    );
\wr_pntr_gc_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I3(5),
      Q => wr_pntr_gc(5)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64clk_x_pntrs_4 is
  port (
    O1 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O4 : out STD_LOGIC;
    I1 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I2 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    ADDRA : in STD_LOGIC_VECTOR ( 5 downto 0 );
    I3 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_aclk : in STD_LOGIC;
    I4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_aclk : in STD_LOGIC;
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    D : in STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64clk_x_pntrs_4 : entity is "clk_x_pntrs";
end t_axi4_lite32_w_afifo_d64clk_x_pntrs_4;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64clk_x_pntrs_4 is
  signal \<const1>\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \n_0_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_0_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_0_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_0_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_0_ram_empty_fb_i_i_6__1\ : STD_LOGIC;
  signal \n_0_ram_empty_fb_i_i_7__1\ : STD_LOGIC;
  signal n_0_ram_full_fb_i_i_5 : STD_LOGIC;
  signal n_0_ram_full_fb_i_i_6 : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[0]\ : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[1]\ : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[2]\ : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[3]\ : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[4]\ : STD_LOGIC;
  signal \n_0_rd_pntr_gc_reg[5]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[0]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[1]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[2]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[3]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[4]\ : STD_LOGIC;
  signal \n_0_wr_pntr_gc_reg[5]\ : STD_LOGIC;
  signal \n_1_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_1_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_1_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_1_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_2_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_2_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_2_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_2_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_3_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_3_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_3_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_3_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_4_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_4_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_4_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_4_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal \n_5_gsync_stage[1].rd_stg_inst\ : STD_LOGIC;
  signal \n_5_gsync_stage[1].wr_stg_inst\ : STD_LOGIC;
  signal \n_5_gsync_stage[2].rd_stg_inst\ : STD_LOGIC;
  signal \n_5_gsync_stage[2].wr_stg_inst\ : STD_LOGIC;
  signal p_0_in3_out : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal p_1_out : STD_LOGIC_VECTOR ( 2 downto 1 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \wr_pntr_gc[0]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \wr_pntr_gc[1]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \wr_pntr_gc[2]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \wr_pntr_gc[3]_i_1\ : label is "soft_lutpair26";
begin
  O3(5 downto 0) <= \^o3\(5 downto 0);
  Q(3 downto 0) <= \^q\(3 downto 0);
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gsync_stage[1].rd_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff_10
    port map (
      I1(5) => \n_0_wr_pntr_gc_reg[5]\,
      I1(4) => \n_0_wr_pntr_gc_reg[4]\,
      I1(3) => \n_0_wr_pntr_gc_reg[3]\,
      I1(2) => \n_0_wr_pntr_gc_reg[2]\,
      I1(1) => \n_0_wr_pntr_gc_reg[1]\,
      I1(0) => \n_0_wr_pntr_gc_reg[0]\,
      I4(0) => I4(0),
      Q(5) => \n_0_gsync_stage[1].rd_stg_inst\,
      Q(4) => \n_1_gsync_stage[1].rd_stg_inst\,
      Q(3) => \n_2_gsync_stage[1].rd_stg_inst\,
      Q(2) => \n_3_gsync_stage[1].rd_stg_inst\,
      Q(1) => \n_4_gsync_stage[1].rd_stg_inst\,
      Q(0) => \n_5_gsync_stage[1].rd_stg_inst\,
      s_aclk => s_aclk
    );
\gsync_stage[1].wr_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff_11
    port map (
      I1(5) => \n_0_rd_pntr_gc_reg[5]\,
      I1(4) => \n_0_rd_pntr_gc_reg[4]\,
      I1(3) => \n_0_rd_pntr_gc_reg[3]\,
      I1(2) => \n_0_rd_pntr_gc_reg[2]\,
      I1(1) => \n_0_rd_pntr_gc_reg[1]\,
      I1(0) => \n_0_rd_pntr_gc_reg[0]\,
      I5(0) => I5(0),
      Q(5) => \n_0_gsync_stage[1].wr_stg_inst\,
      Q(4) => \n_1_gsync_stage[1].wr_stg_inst\,
      Q(3) => \n_2_gsync_stage[1].wr_stg_inst\,
      Q(2) => \n_3_gsync_stage[1].wr_stg_inst\,
      Q(1) => \n_4_gsync_stage[1].wr_stg_inst\,
      Q(0) => \n_5_gsync_stage[1].wr_stg_inst\,
      m_aclk => m_aclk
    );
\gsync_stage[2].rd_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff_12
    port map (
      D(5) => \n_0_gsync_stage[1].rd_stg_inst\,
      D(4) => \n_1_gsync_stage[1].rd_stg_inst\,
      D(3) => \n_2_gsync_stage[1].rd_stg_inst\,
      D(2) => \n_3_gsync_stage[1].rd_stg_inst\,
      D(1) => \n_4_gsync_stage[1].rd_stg_inst\,
      D(0) => \n_5_gsync_stage[1].rd_stg_inst\,
      I4(0) => I4(0),
      O1(4) => \n_1_gsync_stage[2].rd_stg_inst\,
      O1(3) => \n_2_gsync_stage[2].rd_stg_inst\,
      O1(2) => \n_3_gsync_stage[2].rd_stg_inst\,
      O1(1) => \n_4_gsync_stage[2].rd_stg_inst\,
      O1(0) => \n_5_gsync_stage[2].rd_stg_inst\,
      Q(0) => \n_0_gsync_stage[2].rd_stg_inst\,
      s_aclk => s_aclk
    );
\gsync_stage[2].wr_stg_inst\: entity work.t_axi4_lite32_w_afifo_d64synchronizer_ff_13
    port map (
      D(5) => \n_0_gsync_stage[1].wr_stg_inst\,
      D(4) => \n_1_gsync_stage[1].wr_stg_inst\,
      D(3) => \n_2_gsync_stage[1].wr_stg_inst\,
      D(2) => \n_3_gsync_stage[1].wr_stg_inst\,
      D(1) => \n_4_gsync_stage[1].wr_stg_inst\,
      D(0) => \n_5_gsync_stage[1].wr_stg_inst\,
      I5(0) => I5(0),
      O1(4) => \n_1_gsync_stage[2].wr_stg_inst\,
      O1(3) => \n_2_gsync_stage[2].wr_stg_inst\,
      O1(2) => \n_3_gsync_stage[2].wr_stg_inst\,
      O1(1) => \n_4_gsync_stage[2].wr_stg_inst\,
      O1(0) => \n_5_gsync_stage[2].wr_stg_inst\,
      Q(0) => \n_0_gsync_stage[2].wr_stg_inst\,
      m_aclk => m_aclk
    );
\ram_empty_fb_i_i_3__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000009009"
    )
    port map (
      I0 => ADDRA(4),
      I1 => \^q\(2),
      I2 => ADDRA(5),
      I3 => \^q\(3),
      I4 => \n_0_ram_empty_fb_i_i_6__1\,
      I5 => \n_0_ram_empty_fb_i_i_7__1\,
      O => O4
    );
\ram_empty_fb_i_i_5__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => p_1_out(2),
      I1 => I1(1),
      I2 => p_1_out(1),
      I3 => I1(0),
      O => O1
    );
\ram_empty_fb_i_i_6__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => \^q\(1),
      I1 => ADDRA(3),
      I2 => p_1_out(2),
      I3 => ADDRA(2),
      O => \n_0_ram_empty_fb_i_i_6__1\
    );
\ram_empty_fb_i_i_7__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => p_1_out(1),
      I1 => ADDRA(1),
      I2 => \^q\(0),
      I3 => ADDRA(0),
      O => \n_0_ram_empty_fb_i_i_7__1\
    );
ram_full_fb_i_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF6FF6"
    )
    port map (
      I0 => I2(4),
      I1 => \^o3\(4),
      I2 => I2(5),
      I3 => \^o3\(5),
      I4 => n_0_ram_full_fb_i_i_5,
      I5 => n_0_ram_full_fb_i_i_6,
      O => O2
    );
ram_full_fb_i_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => \^o3\(0),
      I1 => I2(0),
      I2 => \^o3\(1),
      I3 => I2(1),
      O => n_0_ram_full_fb_i_i_5
    );
ram_full_fb_i_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => \^o3\(2),
      I1 => I2(2),
      I2 => \^o3\(3),
      I3 => I2(3),
      O => n_0_ram_full_fb_i_i_6
    );
\rd_pntr_bin_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_5_gsync_stage[2].wr_stg_inst\,
      Q => \^o3\(0)
    );
\rd_pntr_bin_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_4_gsync_stage[2].wr_stg_inst\,
      Q => \^o3\(1)
    );
\rd_pntr_bin_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_3_gsync_stage[2].wr_stg_inst\,
      Q => \^o3\(2)
    );
\rd_pntr_bin_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_2_gsync_stage[2].wr_stg_inst\,
      Q => \^o3\(3)
    );
\rd_pntr_bin_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_1_gsync_stage[2].wr_stg_inst\,
      Q => \^o3\(4)
    );
\rd_pntr_bin_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => \n_0_gsync_stage[2].wr_stg_inst\,
      Q => \^o3\(5)
    );
\rd_pntr_gc_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(0),
      Q => \n_0_rd_pntr_gc_reg[0]\
    );
\rd_pntr_gc_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(1),
      Q => \n_0_rd_pntr_gc_reg[1]\
    );
\rd_pntr_gc_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(2),
      Q => \n_0_rd_pntr_gc_reg[2]\
    );
\rd_pntr_gc_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(3),
      Q => \n_0_rd_pntr_gc_reg[3]\
    );
\rd_pntr_gc_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => D(4),
      Q => \n_0_rd_pntr_gc_reg[4]\
    );
\rd_pntr_gc_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => ADDRA(5),
      Q => \n_0_rd_pntr_gc_reg[5]\
    );
\wr_pntr_bin_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => \n_5_gsync_stage[2].rd_stg_inst\,
      Q => \^q\(0)
    );
\wr_pntr_bin_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => \n_4_gsync_stage[2].rd_stg_inst\,
      Q => p_1_out(1)
    );
\wr_pntr_bin_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => \n_3_gsync_stage[2].rd_stg_inst\,
      Q => p_1_out(2)
    );
\wr_pntr_bin_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => \n_2_gsync_stage[2].rd_stg_inst\,
      Q => \^q\(1)
    );
\wr_pntr_bin_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => \n_1_gsync_stage[2].rd_stg_inst\,
      Q => \^q\(2)
    );
\wr_pntr_bin_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      CLR => I4(0),
      D => \n_0_gsync_stage[2].rd_stg_inst\,
      Q => \^q\(3)
    );
\wr_pntr_gc[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I3(0),
      I1 => I3(1),
      O => p_0_in3_out(0)
    );
\wr_pntr_gc[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I3(1),
      I1 => I3(2),
      O => p_0_in3_out(1)
    );
\wr_pntr_gc[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I3(2),
      I1 => I3(3),
      O => p_0_in3_out(2)
    );
\wr_pntr_gc[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I3(3),
      I1 => I3(4),
      O => p_0_in3_out(3)
    );
\wr_pntr_gc[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => I3(4),
      I1 => I3(5),
      O => p_0_in3_out(4)
    );
\wr_pntr_gc_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => p_0_in3_out(0),
      Q => \n_0_wr_pntr_gc_reg[0]\
    );
\wr_pntr_gc_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => p_0_in3_out(1),
      Q => \n_0_wr_pntr_gc_reg[1]\
    );
\wr_pntr_gc_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => p_0_in3_out(2),
      Q => \n_0_wr_pntr_gc_reg[2]\
    );
\wr_pntr_gc_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => p_0_in3_out(3),
      Q => \n_0_wr_pntr_gc_reg[3]\
    );
\wr_pntr_gc_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => p_0_in3_out(4),
      Q => \n_0_wr_pntr_gc_reg[4]\
    );
\wr_pntr_gc_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => \<const1>\,
      CLR => I5(0),
      D => I3(5),
      Q => \n_0_wr_pntr_gc_reg[5]\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64memory is
  port (
    O1 : out STD_LOGIC_VECTOR ( 34 downto 0 );
    I1 : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    DI : in STD_LOGIC_VECTOR ( 34 downto 0 );
    s_aclk : in STD_LOGIC;
    ADDRA : in STD_LOGIC_VECTOR ( 5 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 );
    I2 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end t_axi4_lite32_w_afifo_d64memory;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64memory is
  signal \<const0>\ : STD_LOGIC;
  signal p_0_out : STD_LOGIC_VECTOR ( 34 downto 0 );
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\gdm.dm\: entity work.t_axi4_lite32_w_afifo_d64dmem
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      D(34 downto 0) => p_0_out(34 downto 0),
      DI(34 downto 0) => DI(34 downto 0),
      E(0) => E(0),
      I1 => I1,
      Q(5 downto 0) => Q(5 downto 0),
      m_aclk => m_aclk,
      s_aclk => s_aclk
    );
\goreg_dm.dout_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(0),
      Q => O1(0),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(10),
      Q => O1(10),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(11),
      Q => O1(11),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(12),
      Q => O1(12),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(13),
      Q => O1(13),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(14),
      Q => O1(14),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(15),
      Q => O1(15),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(16),
      Q => O1(16),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(17),
      Q => O1(17),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(18),
      Q => O1(18),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(19),
      Q => O1(19),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(1),
      Q => O1(1),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(20),
      Q => O1(20),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(21),
      Q => O1(21),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(22),
      Q => O1(22),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(23),
      Q => O1(23),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(24),
      Q => O1(24),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(25),
      Q => O1(25),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(26),
      Q => O1(26),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(27),
      Q => O1(27),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(28),
      Q => O1(28),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(29),
      Q => O1(29),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(2),
      Q => O1(2),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(30),
      Q => O1(30),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(31),
      Q => O1(31),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(32),
      Q => O1(32),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(33),
      Q => O1(33),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(34),
      Q => O1(34),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(3),
      Q => O1(3),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(4),
      Q => O1(4),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(5),
      Q => O1(5),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(6),
      Q => O1(6),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(7),
      Q => O1(7),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(8),
      Q => O1(8),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(9),
      Q => O1(9),
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \t_axi4_lite32_w_afifo_d64memory__parameterized0\ is
  port (
    O1 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    I1 : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    I6 : in STD_LOGIC_VECTOR ( 35 downto 0 );
    s_aclk : in STD_LOGIC;
    ADDRA : in STD_LOGIC_VECTOR ( 5 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 );
    I2 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \t_axi4_lite32_w_afifo_d64memory__parameterized0\ : entity is "memory";
end \t_axi4_lite32_w_afifo_d64memory__parameterized0\;

architecture STRUCTURE of \t_axi4_lite32_w_afifo_d64memory__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal p_0_out : STD_LOGIC_VECTOR ( 35 downto 0 );
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\gdm.dm\: entity work.\t_axi4_lite32_w_afifo_d64dmem__parameterized0\
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      D(35 downto 0) => p_0_out(35 downto 0),
      E(0) => E(0),
      I1 => I1,
      I6(35 downto 0) => I6(35 downto 0),
      Q(5 downto 0) => Q(5 downto 0),
      m_aclk => m_aclk,
      s_aclk => s_aclk
    );
\goreg_dm.dout_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(0),
      Q => O1(0),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(10),
      Q => O1(10),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(11),
      Q => O1(11),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(12),
      Q => O1(12),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(13),
      Q => O1(13),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(14),
      Q => O1(14),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(15),
      Q => O1(15),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(16),
      Q => O1(16),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(17),
      Q => O1(17),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(18),
      Q => O1(18),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(19),
      Q => O1(19),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(1),
      Q => O1(1),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(20),
      Q => O1(20),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(21),
      Q => O1(21),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(22),
      Q => O1(22),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(23),
      Q => O1(23),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(24),
      Q => O1(24),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(25),
      Q => O1(25),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(26),
      Q => O1(26),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(27),
      Q => O1(27),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(28),
      Q => O1(28),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(29),
      Q => O1(29),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(2),
      Q => O1(2),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(30),
      Q => O1(30),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(31),
      Q => O1(31),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(32),
      Q => O1(32),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(33),
      Q => O1(33),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(34),
      Q => O1(34),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(35),
      Q => O1(35),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(3),
      Q => O1(3),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(4),
      Q => O1(4),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(5),
      Q => O1(5),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(6),
      Q => O1(6),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(7),
      Q => O1(7),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(8),
      Q => O1(8),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => m_aclk,
      CE => I2(0),
      D => p_0_out(9),
      Q => O1(9),
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \t_axi4_lite32_w_afifo_d64memory__parameterized1\ is
  port (
    p_0_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    p_0_out_0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_aclk : in STD_LOGIC;
    ADDRA : in STD_LOGIC_VECTOR ( 5 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 );
    I1 : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    I2 : in STD_LOGIC;
    O2 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bready : in STD_LOGIC;
    I3 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \t_axi4_lite32_w_afifo_d64memory__parameterized1\ : entity is "memory";
end \t_axi4_lite32_w_afifo_d64memory__parameterized1\;

architecture STRUCTURE of \t_axi4_lite32_w_afifo_d64memory__parameterized1\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \n_0_goreg_dm.dout_i[0]_i_1\ : STD_LOGIC;
  signal \n_0_goreg_dm.dout_i[1]_i_1\ : STD_LOGIC;
  signal \^p_0_out_0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^s_axi_bresp\ : STD_LOGIC_VECTOR ( 1 downto 0 );
begin
  p_0_out_0(1 downto 0) <= \^p_0_out_0\(1 downto 0);
  s_axi_bresp(1 downto 0) <= \^s_axi_bresp\(1 downto 0);
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gdm.dm\: entity work.\t_axi4_lite32_w_afifo_d64dmem__parameterized1\
    port map (
      ADDRA(5 downto 0) => ADDRA(5 downto 0),
      E(0) => E(0),
      I1 => I1,
      I2 => I2,
      Q(5 downto 0) => Q(5 downto 0),
      m_aclk => m_aclk,
      m_axi_bresp(1 downto 0) => m_axi_bresp(1 downto 0),
      p_0_out(1 downto 0) => p_0_out(1 downto 0),
      p_0_out_0(1 downto 0) => \^p_0_out_0\(1 downto 0),
      s_aclk => s_aclk
    );
\goreg_dm.dout_i[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAEFF0000A200"
    )
    port map (
      I0 => \^p_0_out_0\(0),
      I1 => O2(0),
      I2 => s_axi_bready,
      I3 => O2(1),
      I4 => I3(0),
      I5 => \^s_axi_bresp\(0),
      O => \n_0_goreg_dm.dout_i[0]_i_1\
    );
\goreg_dm.dout_i[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAEFF0000A200"
    )
    port map (
      I0 => \^p_0_out_0\(1),
      I1 => O2(0),
      I2 => s_axi_bready,
      I3 => O2(1),
      I4 => I3(0),
      I5 => \^s_axi_bresp\(1),
      O => \n_0_goreg_dm.dout_i[1]_i_1\
    );
\goreg_dm.dout_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \n_0_goreg_dm.dout_i[0]_i_1\,
      Q => \^s_axi_bresp\(0),
      R => \<const0>\
    );
\goreg_dm.dout_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => s_aclk,
      CE => \<const1>\,
      D => \n_0_goreg_dm.dout_i[1]_i_1\,
      Q => \^s_axi_bresp\(1),
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_logic is
  port (
    O1 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    O2 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O3 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I2 : in STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    I3 : in STD_LOGIC
  );
end t_axi4_lite32_w_afifo_d64rd_logic;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_logic is
  signal \n_0_gr1.rfwft\ : STD_LOGIC;
  signal \n_2_gr1.rfwft\ : STD_LOGIC;
  signal n_3_rpntr : STD_LOGIC;
  signal p_17_out : STD_LOGIC;
  signal rd_pntr_plus1 : STD_LOGIC_VECTOR ( 0 to 0 );
begin
\gr1.rfwft\: entity work.t_axi4_lite32_w_afifo_d64rd_fwft
    port map (
      E(0) => \n_2_gr1.rfwft\,
      I1(0) => I1(0),
      I2(0) => rd_pntr_plus1(0),
      O1 => \n_0_gr1.rfwft\,
      O2 => O2,
      O3(0) => E(0),
      Q(1 downto 0) => Q(1 downto 0),
      m_aclk => m_aclk,
      m_axi_wready => m_axi_wready,
      m_axi_wvalid => m_axi_wvalid,
      p_17_out => p_17_out
    );
\gras.rsts\: entity work.t_axi4_lite32_w_afifo_d64rd_status_flags_as
    port map (
      I1 => n_3_rpntr,
      Q(0) => Q(1),
      m_aclk => m_aclk,
      p_17_out => p_17_out
    );
rpntr: entity work.t_axi4_lite32_w_afifo_d64rd_bin_cntr
    port map (
      D(5 downto 0) => D(5 downto 0),
      E(0) => \n_2_gr1.rfwft\,
      I1(2 downto 0) => I1(3 downto 1),
      I2 => \n_0_gr1.rfwft\,
      I3 => I2,
      I4 => I3,
      I5(0) => Q(1),
      O1 => n_3_rpntr,
      O3(4 downto 0) => O3(4 downto 0),
      Q(2 downto 1) => O1(1 downto 0),
      Q(0) => rd_pntr_plus1(0),
      m_aclk => m_aclk
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_logic_17 is
  port (
    O1 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    O2 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O3 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I2 : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    I3 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64rd_logic_17 : entity is "rd_logic";
end t_axi4_lite32_w_afifo_d64rd_logic_17;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_logic_17 is
  signal \n_0_gr1.rfwft\ : STD_LOGIC;
  signal \n_2_gr1.rfwft\ : STD_LOGIC;
  signal n_3_rpntr : STD_LOGIC;
  signal p_17_out : STD_LOGIC;
  signal rd_pntr_plus1 : STD_LOGIC_VECTOR ( 3 to 3 );
begin
\gr1.rfwft\: entity work.t_axi4_lite32_w_afifo_d64rd_fwft_29
    port map (
      E(0) => \n_2_gr1.rfwft\,
      I1(0) => I1(1),
      I2(0) => rd_pntr_plus1(3),
      O1 => \n_0_gr1.rfwft\,
      O2 => O2,
      O3(0) => E(0),
      Q(1 downto 0) => Q(1 downto 0),
      m_aclk => m_aclk,
      m_axi_awready => m_axi_awready,
      m_axi_awvalid => m_axi_awvalid,
      p_17_out => p_17_out
    );
\gras.rsts\: entity work.t_axi4_lite32_w_afifo_d64rd_status_flags_as_30
    port map (
      I1 => n_3_rpntr,
      Q(0) => Q(1),
      m_aclk => m_aclk,
      p_17_out => p_17_out
    );
rpntr: entity work.t_axi4_lite32_w_afifo_d64rd_bin_cntr_28
    port map (
      D(5 downto 0) => D(5 downto 0),
      E(0) => \n_2_gr1.rfwft\,
      I1(2 downto 1) => I1(3 downto 2),
      I1(0) => I1(0),
      I2 => \n_0_gr1.rfwft\,
      I3 => I2,
      I4 => I3,
      I5(0) => Q(1),
      O1 => n_3_rpntr,
      O3(4 downto 0) => O3(4 downto 0),
      Q(2) => rd_pntr_plus1(3),
      Q(1 downto 0) => O1(1 downto 0),
      m_aclk => m_aclk
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64rd_logic_3 is
  port (
    O1 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    O2 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    D : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O3 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    s_aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I2 : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    I3 : in STD_LOGIC;
    p_0_out : in STD_LOGIC_VECTOR ( 1 downto 0 );
    p_0_out_0 : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64rd_logic_3 : entity is "rd_logic";
end t_axi4_lite32_w_afifo_d64rd_logic_3;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64rd_logic_3 is
  signal \n_0_gr1.rfwft\ : STD_LOGIC;
  signal \n_3_gr1.rfwft\ : STD_LOGIC;
  signal n_3_rpntr : STD_LOGIC;
  signal p_17_out : STD_LOGIC;
  signal rd_pntr_plus1 : STD_LOGIC_VECTOR ( 0 to 0 );
begin
\gr1.rfwft\: entity work.t_axi4_lite32_w_afifo_d64rd_fwft_15
    port map (
      E(0) => \n_3_gr1.rfwft\,
      I1(0) => I1(0),
      I2(0) => rd_pntr_plus1(0),
      O1 => \n_0_gr1.rfwft\,
      O2(1 downto 0) => O2(1 downto 0),
      O4 => O4,
      O5 => O5,
      Q(0) => Q(0),
      p_0_out(1 downto 0) => p_0_out(1 downto 0),
      p_0_out_0(1 downto 0) => p_0_out_0(1 downto 0),
      p_17_out => p_17_out,
      s_aclk => s_aclk,
      s_axi_bready => s_axi_bready,
      s_axi_bvalid => s_axi_bvalid
    );
\gras.rsts\: entity work.t_axi4_lite32_w_afifo_d64rd_status_flags_as_16
    port map (
      I1 => n_3_rpntr,
      Q(0) => Q(0),
      p_17_out => p_17_out,
      s_aclk => s_aclk
    );
rpntr: entity work.t_axi4_lite32_w_afifo_d64rd_bin_cntr_14
    port map (
      D(5 downto 0) => D(5 downto 0),
      E(0) => \n_3_gr1.rfwft\,
      I1(2 downto 0) => I1(3 downto 1),
      I2 => \n_0_gr1.rfwft\,
      I3 => I2,
      I4 => I3,
      I5(0) => Q(0),
      O1 => n_3_rpntr,
      O3(4 downto 0) => O3(4 downto 0),
      Q(2 downto 1) => O1(1 downto 0),
      Q(0) => rd_pntr_plus1(0),
      s_aclk => s_aclk
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_logic is
  port (
    axi_w_overflow : out STD_LOGIC;
    O1 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC;
    O2 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O4 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    I1 : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    rst_d2 : in STD_LOGIC;
    O3 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    I2 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end t_axi4_lite32_w_afifo_d64wr_logic;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_logic is
  signal \^e\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \n_1_gwas.wsts\ : STD_LOGIC;
  signal p_0_out : STD_LOGIC;
begin
  E(0) <= \^e\(0);
\gwas.wsts\: entity work.t_axi4_lite32_w_afifo_d64wr_status_flags_as
    port map (
      E(0) => \^e\(0),
      I1 => I1,
      O1 => \n_1_gwas.wsts\,
      p_0_out => p_0_out,
      rst_d2 => rst_d2,
      s_aclk => s_aclk,
      s_axi_wready => s_axi_wready,
      s_axi_wvalid => s_axi_wvalid
    );
\gwhf.whf\: entity work.t_axi4_lite32_w_afifo_d64wr_handshaking_flags
    port map (
      I1 => \n_1_gwas.wsts\,
      axi_w_overflow => axi_w_overflow,
      s_aclk => s_aclk
    );
wpntr: entity work.t_axi4_lite32_w_afifo_d64wr_bin_cntr
    port map (
      E(0) => \^e\(0),
      I2(0) => I2(0),
      O1 => O1,
      O2(5 downto 0) => O2(5 downto 0),
      O3(1 downto 0) => O3(1 downto 0),
      O4(5 downto 0) => O4(5 downto 0),
      Q(3 downto 0) => Q(3 downto 0),
      p_0_out => p_0_out,
      s_aclk => s_aclk,
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_logic_19 is
  port (
    axi_aw_overflow : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O1 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    s_aclk : in STD_LOGIC;
    I1 : in STD_LOGIC;
    rst_full_gen_i : in STD_LOGIC;
    O5 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    I2 : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    I3 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64wr_logic_19 : entity is "wr_logic";
end t_axi4_lite32_w_afifo_d64wr_logic_19;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_logic_19 is
  signal \^e\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal n_0_wpntr : STD_LOGIC;
  signal \n_1_gwas.wsts\ : STD_LOGIC;
  signal p_0_out : STD_LOGIC;
begin
  E(0) <= \^e\(0);
\gwas.wsts\: entity work.t_axi4_lite32_w_afifo_d64wr_status_flags_as_22
    port map (
      E(0) => \^e\(0),
      I1 => n_0_wpntr,
      I2 => I1,
      O1 => \n_1_gwas.wsts\,
      p_0_out => p_0_out,
      s_aclk => s_aclk,
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid
    );
\gwhf.whf\: entity work.t_axi4_lite32_w_afifo_d64wr_handshaking_flags_23
    port map (
      I1 => \n_1_gwas.wsts\,
      axi_aw_overflow => axi_aw_overflow,
      s_aclk => s_aclk
    );
wpntr: entity work.t_axi4_lite32_w_afifo_d64wr_bin_cntr_21
    port map (
      E(0) => \^e\(0),
      I2 => I2,
      I3(0) => I3(0),
      O1 => n_0_wpntr,
      O2(5 downto 0) => O1(5 downto 0),
      O5(5 downto 0) => O5(5 downto 0),
      Q(5 downto 0) => Q(5 downto 0),
      p_0_out => p_0_out,
      rst_full_gen_i => rst_full_gen_i,
      s_aclk => s_aclk,
      s_axi_awvalid => s_axi_awvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64wr_logic_5 is
  port (
    axi_b_overflow : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bready : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    O1 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_aclk : in STD_LOGIC;
    I1 : in STD_LOGIC;
    O3 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    I2 : in STD_LOGIC;
    rst_full_gen_i : in STD_LOGIC;
    I3 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of t_axi4_lite32_w_afifo_d64wr_logic_5 : entity is "wr_logic";
end t_axi4_lite32_w_afifo_d64wr_logic_5;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64wr_logic_5 is
  signal \^e\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \n_1_gwas.wsts\ : STD_LOGIC;
  signal p_0_out : STD_LOGIC;
  signal ram_full_i : STD_LOGIC;
begin
  E(0) <= \^e\(0);
\gwas.wsts\: entity work.t_axi4_lite32_w_afifo_d64wr_status_flags_as_8
    port map (
      E(0) => \^e\(0),
      I1 => I1,
      O1 => \n_1_gwas.wsts\,
      m_aclk => m_aclk,
      m_axi_bready => m_axi_bready,
      m_axi_bvalid => m_axi_bvalid,
      p_0_out => p_0_out,
      ram_full_i => ram_full_i
    );
\gwhf.whf\: entity work.t_axi4_lite32_w_afifo_d64wr_handshaking_flags_9
    port map (
      I1 => \n_1_gwas.wsts\,
      axi_b_overflow => axi_b_overflow,
      m_aclk => m_aclk
    );
wpntr: entity work.t_axi4_lite32_w_afifo_d64wr_bin_cntr_7
    port map (
      E(0) => \^e\(0),
      I2 => I2,
      I3(0) => I3(0),
      O1(5 downto 0) => O1(5 downto 0),
      O3(5 downto 0) => O3(5 downto 0),
      Q(5 downto 0) => Q(5 downto 0),
      m_aclk => m_aclk,
      m_axi_bvalid => m_axi_bvalid,
      p_0_out => p_0_out,
      ram_full_i => ram_full_i,
      rst_full_gen_i => rst_full_gen_i
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo is
  port (
    rst_full_gen_i : out STD_LOGIC;
    O1 : out STD_LOGIC;
    axi_aw_overflow : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 34 downto 0 );
    s_aclk : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    inverted_reset : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    DI : in STD_LOGIC_VECTOR ( 34 downto 0 )
  );
end t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo is
  signal \^o1\ : STD_LOGIC;
  signal RD_RST : STD_LOGIC;
  signal RST : STD_LOGIC;
  signal \n_0_gntv_or_sync_fifo.gcx.clkx\ : STD_LOGIC;
  signal \n_2_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal n_2_rstblk : STD_LOGIC;
  signal \n_3_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_5_gntv_or_sync_fifo.gcx.clkx\ : STD_LOGIC;
  signal \n_5_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_6_gntv_or_sync_fifo.gcx.clkx\ : STD_LOGIC;
  signal \n_6_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal n_6_rstblk : STD_LOGIC;
  signal \n_7_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_8_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_9_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal p_0_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal p_19_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal p_1_out : STD_LOGIC_VECTOR ( 5 downto 1 );
  signal p_3_out : STD_LOGIC;
  signal p_8_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rd_pntr_plus1 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal rd_rst_i : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^rst_full_gen_i\ : STD_LOGIC;
  signal wr_pntr_plus1 : STD_LOGIC_VECTOR ( 5 downto 0 );
begin
  O1 <= \^o1\;
  rst_full_gen_i <= \^rst_full_gen_i\;
\gntv_or_sync_fifo.gcx.clkx\: entity work.t_axi4_lite32_w_afifo_d64clk_x_pntrs_18
    port map (
      D(5) => p_19_out(5),
      D(4) => \n_5_gntv_or_sync_fifo.gl0.rd\,
      D(3) => \n_6_gntv_or_sync_fifo.gl0.rd\,
      D(2) => \n_7_gntv_or_sync_fifo.gl0.rd\,
      D(1) => \n_8_gntv_or_sync_fifo.gl0.rd\,
      D(0) => \n_9_gntv_or_sync_fifo.gl0.rd\,
      I1(1) => rd_pntr_plus1(2),
      I1(0) => rd_pntr_plus1(0),
      I2(5 downto 0) => wr_pntr_plus1(5 downto 0),
      I3(5 downto 0) => p_8_out(5 downto 0),
      I4(0) => RD_RST,
      I5(0) => n_6_rstblk,
      O1 => \n_0_gntv_or_sync_fifo.gcx.clkx\,
      O2 => \n_5_gntv_or_sync_fifo.gcx.clkx\,
      O3(4 downto 0) => p_19_out(4 downto 0),
      O4 => \n_6_gntv_or_sync_fifo.gcx.clkx\,
      O5(5 downto 0) => p_0_out(5 downto 0),
      Q(3 downto 1) => p_1_out(5 downto 3),
      Q(0) => p_1_out(1),
      m_aclk => m_aclk,
      s_aclk => s_aclk
    );
\gntv_or_sync_fifo.gl0.rd\: entity work.t_axi4_lite32_w_afifo_d64rd_logic_17
    port map (
      D(5) => p_19_out(5),
      D(4) => \n_5_gntv_or_sync_fifo.gl0.rd\,
      D(3) => \n_6_gntv_or_sync_fifo.gl0.rd\,
      D(2) => \n_7_gntv_or_sync_fifo.gl0.rd\,
      D(1) => \n_8_gntv_or_sync_fifo.gl0.rd\,
      D(0) => \n_9_gntv_or_sync_fifo.gl0.rd\,
      E(0) => \n_3_gntv_or_sync_fifo.gl0.rd\,
      I1(3 downto 1) => p_1_out(5 downto 3),
      I1(0) => p_1_out(1),
      I2 => \n_0_gntv_or_sync_fifo.gcx.clkx\,
      I3 => \n_5_gntv_or_sync_fifo.gcx.clkx\,
      O1(1) => rd_pntr_plus1(2),
      O1(0) => rd_pntr_plus1(0),
      O2 => \n_2_gntv_or_sync_fifo.gl0.rd\,
      O3(4 downto 0) => p_19_out(4 downto 0),
      Q(1) => n_2_rstblk,
      Q(0) => rd_rst_i(0),
      m_aclk => m_aclk,
      m_axi_awready => m_axi_awready,
      m_axi_awvalid => m_axi_awvalid
    );
\gntv_or_sync_fifo.gl0.wr\: entity work.t_axi4_lite32_w_afifo_d64wr_logic_19
    port map (
      E(0) => p_3_out,
      I1 => \^o1\,
      I2 => \n_6_gntv_or_sync_fifo.gcx.clkx\,
      I3(0) => RST,
      O1(5 downto 0) => wr_pntr_plus1(5 downto 0),
      O5(5 downto 0) => p_0_out(5 downto 0),
      Q(5 downto 0) => p_8_out(5 downto 0),
      axi_aw_overflow => axi_aw_overflow,
      rst_full_gen_i => \^rst_full_gen_i\,
      s_aclk => s_aclk,
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid
    );
\gntv_or_sync_fifo.mem\: entity work.t_axi4_lite32_w_afifo_d64memory
    port map (
      ADDRA(5 downto 0) => p_19_out(5 downto 0),
      DI(34 downto 0) => DI(34 downto 0),
      E(0) => p_3_out,
      I1 => \n_2_gntv_or_sync_fifo.gl0.rd\,
      I2(0) => \n_3_gntv_or_sync_fifo.gl0.rd\,
      O1(34 downto 0) => Q(34 downto 0),
      Q(5 downto 0) => p_8_out(5 downto 0),
      m_aclk => m_aclk,
      s_aclk => s_aclk
    );
rstblk: entity work.t_axi4_lite32_w_afifo_d64reset_blk_ramfifo_20
    port map (
      O1 => \^o1\,
      O2(1) => RST,
      O2(0) => n_6_rstblk,
      Q(2) => n_2_rstblk,
      Q(1) => RD_RST,
      Q(0) => rd_rst_i(0),
      inverted_reset => inverted_reset,
      m_aclk => m_aclk,
      rst_full_gen_i => \^rst_full_gen_i\,
      s_aclk => s_aclk
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo__parameterized0\ is
  port (
    axi_w_overflow : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    O1 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    s_aclk : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    rst_d2 : in STD_LOGIC;
    inverted_reset : in STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    rst_full_gen_i : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    I6 : in STD_LOGIC_VECTOR ( 35 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo__parameterized0\ : entity is "fifo_generator_ramfifo";
end \t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo__parameterized0\;

architecture STRUCTURE of \t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo__parameterized0\ is
  signal \n_0_gntv_or_sync_fifo.gcx.clkx\ : STD_LOGIC;
  signal n_0_rstblk : STD_LOGIC;
  signal \n_1_gntv_or_sync_fifo.gl0.wr\ : STD_LOGIC;
  signal n_1_rstblk : STD_LOGIC;
  signal \n_2_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_3_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal n_3_rstblk : STD_LOGIC;
  signal n_4_rstblk : STD_LOGIC;
  signal \n_5_gntv_or_sync_fifo.gcx.clkx\ : STD_LOGIC;
  signal \n_5_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_6_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_7_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_8_gntv_or_sync_fifo.gcx.clkx\ : STD_LOGIC;
  signal \n_8_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_9_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal p_0_out : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal p_19_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal p_1_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal p_3_out : STD_LOGIC;
  signal p_8_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rd_pntr_plus1 : STD_LOGIC_VECTOR ( 2 downto 1 );
  signal rd_rst_i : STD_LOGIC_VECTOR ( 0 to 0 );
  signal wr_pntr_plus1 : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal wr_pntr_plus2 : STD_LOGIC_VECTOR ( 5 downto 2 );
begin
\gntv_or_sync_fifo.gcx.clkx\: entity work.t_axi4_lite32_w_afifo_d64clk_x_pntrs
    port map (
      ADDRA(5 downto 0) => p_19_out(5 downto 0),
      D(4) => \n_5_gntv_or_sync_fifo.gl0.rd\,
      D(3) => \n_6_gntv_or_sync_fifo.gl0.rd\,
      D(2) => \n_7_gntv_or_sync_fifo.gl0.rd\,
      D(1) => \n_8_gntv_or_sync_fifo.gl0.rd\,
      D(0) => \n_9_gntv_or_sync_fifo.gl0.rd\,
      I1(1 downto 0) => rd_pntr_plus1(2 downto 1),
      I2(3 downto 0) => wr_pntr_plus2(5 downto 2),
      I3 => \n_1_gntv_or_sync_fifo.gl0.wr\,
      I4(5 downto 0) => wr_pntr_plus1(5 downto 0),
      I5(5 downto 0) => p_8_out(5 downto 0),
      I6(0) => n_1_rstblk,
      I7(0) => n_4_rstblk,
      O1 => \n_0_gntv_or_sync_fifo.gcx.clkx\,
      O2 => \n_5_gntv_or_sync_fifo.gcx.clkx\,
      O3(1 downto 0) => p_0_out(1 downto 0),
      O4 => \n_8_gntv_or_sync_fifo.gcx.clkx\,
      Q(3 downto 1) => p_1_out(5 downto 3),
      Q(0) => p_1_out(0),
      m_aclk => m_aclk,
      rst_full_gen_i => rst_full_gen_i,
      s_aclk => s_aclk
    );
\gntv_or_sync_fifo.gl0.rd\: entity work.t_axi4_lite32_w_afifo_d64rd_logic
    port map (
      D(5) => p_19_out(5),
      D(4) => \n_5_gntv_or_sync_fifo.gl0.rd\,
      D(3) => \n_6_gntv_or_sync_fifo.gl0.rd\,
      D(2) => \n_7_gntv_or_sync_fifo.gl0.rd\,
      D(1) => \n_8_gntv_or_sync_fifo.gl0.rd\,
      D(0) => \n_9_gntv_or_sync_fifo.gl0.rd\,
      E(0) => \n_3_gntv_or_sync_fifo.gl0.rd\,
      I1(3 downto 1) => p_1_out(5 downto 3),
      I1(0) => p_1_out(0),
      I2 => \n_0_gntv_or_sync_fifo.gcx.clkx\,
      I3 => \n_8_gntv_or_sync_fifo.gcx.clkx\,
      O1(1 downto 0) => rd_pntr_plus1(2 downto 1),
      O2 => \n_2_gntv_or_sync_fifo.gl0.rd\,
      O3(4 downto 0) => p_19_out(4 downto 0),
      Q(1) => n_0_rstblk,
      Q(0) => rd_rst_i(0),
      m_aclk => m_aclk,
      m_axi_wready => m_axi_wready,
      m_axi_wvalid => m_axi_wvalid
    );
\gntv_or_sync_fifo.gl0.wr\: entity work.t_axi4_lite32_w_afifo_d64wr_logic
    port map (
      E(0) => p_3_out,
      I1 => \n_5_gntv_or_sync_fifo.gcx.clkx\,
      I2(0) => n_3_rstblk,
      O1 => \n_1_gntv_or_sync_fifo.gl0.wr\,
      O2(5 downto 0) => p_8_out(5 downto 0),
      O3(1 downto 0) => p_0_out(1 downto 0),
      O4(5 downto 0) => wr_pntr_plus1(5 downto 0),
      Q(3 downto 0) => wr_pntr_plus2(5 downto 2),
      axi_w_overflow => axi_w_overflow,
      rst_d2 => rst_d2,
      s_aclk => s_aclk,
      s_axi_wready => s_axi_wready,
      s_axi_wvalid => s_axi_wvalid
    );
\gntv_or_sync_fifo.mem\: entity work.\t_axi4_lite32_w_afifo_d64memory__parameterized0\
    port map (
      ADDRA(5 downto 0) => p_19_out(5 downto 0),
      E(0) => p_3_out,
      I1 => \n_2_gntv_or_sync_fifo.gl0.rd\,
      I2(0) => \n_3_gntv_or_sync_fifo.gl0.rd\,
      I6(35 downto 0) => I6(35 downto 0),
      O1(35 downto 0) => O1(35 downto 0),
      Q(5 downto 0) => p_8_out(5 downto 0),
      m_aclk => m_aclk,
      s_aclk => s_aclk
    );
rstblk: entity work.t_axi4_lite32_w_afifo_d64reset_blk_ramfifo
    port map (
      O1(1) => n_3_rstblk,
      O1(0) => n_4_rstblk,
      Q(2) => n_0_rstblk,
      Q(1) => n_1_rstblk,
      Q(0) => rd_rst_i(0),
      inverted_reset => inverted_reset,
      m_aclk => m_aclk,
      s_aclk => s_aclk
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo__parameterized1\ is
  port (
    O1 : out STD_LOGIC;
    axi_b_overflow : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_aclk : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_aresetn : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo__parameterized1\ : entity is "fifo_generator_ramfifo";
end \t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo__parameterized1\;

architecture STRUCTURE of \t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo__parameterized1\ is
  signal \gdm.dm/p_0_out\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \gr1.rfwft/curr_fwft_state\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \n_0_gntv_or_sync_fifo.gcx.clkx\ : STD_LOGIC;
  signal \n_12_gntv_or_sync_fifo.gcx.clkx\ : STD_LOGIC;
  signal \n_16_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_17_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_2_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal n_2_rstblk : STD_LOGIC;
  signal n_3_rstblk : STD_LOGIC;
  signal n_4_rstblk : STD_LOGIC;
  signal \n_5_gntv_or_sync_fifo.gcx.clkx\ : STD_LOGIC;
  signal \n_5_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_6_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal n_6_rstblk : STD_LOGIC;
  signal \n_7_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal n_7_rstblk : STD_LOGIC;
  signal \n_8_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal \n_9_gntv_or_sync_fifo.gl0.rd\ : STD_LOGIC;
  signal p_0_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal p_0_out_0 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal p_19_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal p_1_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal p_3_out : STD_LOGIC;
  signal p_8_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rd_pntr_plus1 : STD_LOGIC_VECTOR ( 2 downto 1 );
  signal rd_rst_i : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rst_full_gen_i : STD_LOGIC;
  signal wr_pntr_plus1 : STD_LOGIC_VECTOR ( 5 downto 0 );
begin
\gntv_or_sync_fifo.gcx.clkx\: entity work.t_axi4_lite32_w_afifo_d64clk_x_pntrs_4
    port map (
      ADDRA(5 downto 0) => p_19_out(5 downto 0),
      D(4) => \n_5_gntv_or_sync_fifo.gl0.rd\,
      D(3) => \n_6_gntv_or_sync_fifo.gl0.rd\,
      D(2) => \n_7_gntv_or_sync_fifo.gl0.rd\,
      D(1) => \n_8_gntv_or_sync_fifo.gl0.rd\,
      D(0) => \n_9_gntv_or_sync_fifo.gl0.rd\,
      I1(1 downto 0) => rd_pntr_plus1(2 downto 1),
      I2(5 downto 0) => wr_pntr_plus1(5 downto 0),
      I3(5 downto 0) => p_8_out(5 downto 0),
      I4(0) => n_4_rstblk,
      I5(0) => n_7_rstblk,
      O1 => \n_0_gntv_or_sync_fifo.gcx.clkx\,
      O2 => \n_5_gntv_or_sync_fifo.gcx.clkx\,
      O3(5 downto 0) => p_0_out(5 downto 0),
      O4 => \n_12_gntv_or_sync_fifo.gcx.clkx\,
      Q(3 downto 1) => p_1_out(5 downto 3),
      Q(0) => p_1_out(0),
      m_aclk => m_aclk,
      s_aclk => s_aclk
    );
\gntv_or_sync_fifo.gl0.rd\: entity work.t_axi4_lite32_w_afifo_d64rd_logic_3
    port map (
      D(5) => p_19_out(5),
      D(4) => \n_5_gntv_or_sync_fifo.gl0.rd\,
      D(3) => \n_6_gntv_or_sync_fifo.gl0.rd\,
      D(2) => \n_7_gntv_or_sync_fifo.gl0.rd\,
      D(1) => \n_8_gntv_or_sync_fifo.gl0.rd\,
      D(0) => \n_9_gntv_or_sync_fifo.gl0.rd\,
      I1(3 downto 1) => p_1_out(5 downto 3),
      I1(0) => p_1_out(0),
      I2 => \n_0_gntv_or_sync_fifo.gcx.clkx\,
      I3 => \n_12_gntv_or_sync_fifo.gcx.clkx\,
      O1(1 downto 0) => rd_pntr_plus1(2 downto 1),
      O2(1) => \n_2_gntv_or_sync_fifo.gl0.rd\,
      O2(0) => \gr1.rfwft/curr_fwft_state\(0),
      O3(4 downto 0) => p_19_out(4 downto 0),
      O4 => \n_16_gntv_or_sync_fifo.gl0.rd\,
      O5 => \n_17_gntv_or_sync_fifo.gl0.rd\,
      Q(0) => n_3_rstblk,
      p_0_out(1 downto 0) => \gdm.dm/p_0_out\(1 downto 0),
      p_0_out_0(1 downto 0) => p_0_out_0(1 downto 0),
      s_aclk => s_aclk,
      s_axi_bready => s_axi_bready,
      s_axi_bvalid => s_axi_bvalid
    );
\gntv_or_sync_fifo.gl0.wr\: entity work.t_axi4_lite32_w_afifo_d64wr_logic_5
    port map (
      E(0) => p_3_out,
      I1 => n_2_rstblk,
      I2 => \n_5_gntv_or_sync_fifo.gcx.clkx\,
      I3(0) => n_6_rstblk,
      O1(5 downto 0) => wr_pntr_plus1(5 downto 0),
      O3(5 downto 0) => p_0_out(5 downto 0),
      Q(5 downto 0) => p_8_out(5 downto 0),
      axi_b_overflow => axi_b_overflow,
      m_aclk => m_aclk,
      m_axi_bready => m_axi_bready,
      m_axi_bvalid => m_axi_bvalid,
      rst_full_gen_i => rst_full_gen_i
    );
\gntv_or_sync_fifo.mem\: entity work.\t_axi4_lite32_w_afifo_d64memory__parameterized1\
    port map (
      ADDRA(5 downto 0) => p_19_out(5 downto 0),
      E(0) => p_3_out,
      I1 => \n_16_gntv_or_sync_fifo.gl0.rd\,
      I2 => \n_17_gntv_or_sync_fifo.gl0.rd\,
      I3(0) => rd_rst_i(0),
      O2(1) => \n_2_gntv_or_sync_fifo.gl0.rd\,
      O2(0) => \gr1.rfwft/curr_fwft_state\(0),
      Q(5 downto 0) => p_8_out(5 downto 0),
      m_aclk => m_aclk,
      m_axi_bresp(1 downto 0) => m_axi_bresp(1 downto 0),
      p_0_out(1 downto 0) => \gdm.dm/p_0_out\(1 downto 0),
      p_0_out_0(1 downto 0) => p_0_out_0(1 downto 0),
      s_aclk => s_aclk,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0)
    );
rstblk: entity work.t_axi4_lite32_w_afifo_d64reset_blk_ramfifo_6
    port map (
      O1 => O1,
      O2 => n_2_rstblk,
      O3(1) => n_6_rstblk,
      O3(0) => n_7_rstblk,
      Q(2) => n_3_rstblk,
      Q(1) => n_4_rstblk,
      Q(0) => rd_rst_i(0),
      m_aclk => m_aclk,
      rst_full_gen_i => rst_full_gen_i,
      s_aclk => s_aclk,
      s_aresetn => s_aresetn
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64fifo_generator_top is
  port (
    rst_full_gen_i : out STD_LOGIC;
    rst_d2 : out STD_LOGIC;
    axi_aw_overflow : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 34 downto 0 );
    s_aclk : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    inverted_reset : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    DI : in STD_LOGIC_VECTOR ( 34 downto 0 )
  );
end t_axi4_lite32_w_afifo_d64fifo_generator_top;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64fifo_generator_top is
begin
\grf.rf\: entity work.t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo
    port map (
      DI(34 downto 0) => DI(34 downto 0),
      O1 => rst_d2,
      Q(34 downto 0) => Q(34 downto 0),
      axi_aw_overflow => axi_aw_overflow,
      inverted_reset => inverted_reset,
      m_aclk => m_aclk,
      m_axi_awready => m_axi_awready,
      m_axi_awvalid => m_axi_awvalid,
      rst_full_gen_i => rst_full_gen_i,
      s_aclk => s_aclk,
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \t_axi4_lite32_w_afifo_d64fifo_generator_top__parameterized0\ is
  port (
    axi_w_overflow : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    O1 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    s_aclk : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    rst_d2 : in STD_LOGIC;
    inverted_reset : in STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    rst_full_gen_i : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    I6 : in STD_LOGIC_VECTOR ( 35 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \t_axi4_lite32_w_afifo_d64fifo_generator_top__parameterized0\ : entity is "fifo_generator_top";
end \t_axi4_lite32_w_afifo_d64fifo_generator_top__parameterized0\;

architecture STRUCTURE of \t_axi4_lite32_w_afifo_d64fifo_generator_top__parameterized0\ is
begin
\grf.rf\: entity work.\t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo__parameterized0\
    port map (
      I6(35 downto 0) => I6(35 downto 0),
      O1(35 downto 0) => O1(35 downto 0),
      axi_w_overflow => axi_w_overflow,
      inverted_reset => inverted_reset,
      m_aclk => m_aclk,
      m_axi_wready => m_axi_wready,
      m_axi_wvalid => m_axi_wvalid,
      rst_d2 => rst_d2,
      rst_full_gen_i => rst_full_gen_i,
      s_aclk => s_aclk,
      s_axi_wready => s_axi_wready,
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \t_axi4_lite32_w_afifo_d64fifo_generator_top__parameterized1\ is
  port (
    inverted_reset : out STD_LOGIC;
    axi_b_overflow : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_aclk : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_aresetn : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \t_axi4_lite32_w_afifo_d64fifo_generator_top__parameterized1\ : entity is "fifo_generator_top";
end \t_axi4_lite32_w_afifo_d64fifo_generator_top__parameterized1\;

architecture STRUCTURE of \t_axi4_lite32_w_afifo_d64fifo_generator_top__parameterized1\ is
begin
\grf.rf\: entity work.\t_axi4_lite32_w_afifo_d64fifo_generator_ramfifo__parameterized1\
    port map (
      O1 => inverted_reset,
      axi_b_overflow => axi_b_overflow,
      m_aclk => m_aclk,
      m_axi_bready => m_axi_bready,
      m_axi_bresp(1 downto 0) => m_axi_bresp(1 downto 0),
      m_axi_bvalid => m_axi_bvalid,
      s_aclk => s_aclk,
      s_aresetn => s_aresetn,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid => s_axi_bvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64fifo_generator_v11_0_synth is
  port (
    Q : out STD_LOGIC_VECTOR ( 34 downto 0 );
    axi_aw_overflow : out STD_LOGIC;
    O1 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    axi_w_overflow : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_b_overflow : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    DI : in STD_LOGIC_VECTOR ( 34 downto 0 );
    I6 : in STD_LOGIC_VECTOR ( 35 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_aresetn : in STD_LOGIC
  );
end t_axi4_lite32_w_afifo_d64fifo_generator_v11_0_synth;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64fifo_generator_v11_0_synth is
  signal \grf.rf/rst_full_gen_i\ : STD_LOGIC;
  signal inverted_reset : STD_LOGIC;
  signal rst_d2 : STD_LOGIC;
begin
\gaxi_full_lite.gwrite_ch.gwach2.axi_wach\: entity work.t_axi4_lite32_w_afifo_d64fifo_generator_top
    port map (
      DI(34 downto 0) => DI(34 downto 0),
      Q(34 downto 0) => Q(34 downto 0),
      axi_aw_overflow => axi_aw_overflow,
      inverted_reset => inverted_reset,
      m_aclk => m_aclk,
      m_axi_awready => m_axi_awready,
      m_axi_awvalid => m_axi_awvalid,
      rst_d2 => rst_d2,
      rst_full_gen_i => \grf.rf/rst_full_gen_i\,
      s_aclk => s_aclk,
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid
    );
\gaxi_full_lite.gwrite_ch.gwdch2.axi_wdch\: entity work.\t_axi4_lite32_w_afifo_d64fifo_generator_top__parameterized0\
    port map (
      I6(35 downto 0) => I6(35 downto 0),
      O1(35 downto 0) => O1(35 downto 0),
      axi_w_overflow => axi_w_overflow,
      inverted_reset => inverted_reset,
      m_aclk => m_aclk,
      m_axi_wready => m_axi_wready,
      m_axi_wvalid => m_axi_wvalid,
      rst_d2 => rst_d2,
      rst_full_gen_i => \grf.rf/rst_full_gen_i\,
      s_aclk => s_aclk,
      s_axi_wready => s_axi_wready,
      s_axi_wvalid => s_axi_wvalid
    );
\gaxi_full_lite.gwrite_ch.gwrch2.axi_wrch\: entity work.\t_axi4_lite32_w_afifo_d64fifo_generator_top__parameterized1\
    port map (
      axi_b_overflow => axi_b_overflow,
      inverted_reset => inverted_reset,
      m_aclk => m_aclk,
      m_axi_bready => m_axi_bready,
      m_axi_bresp(1 downto 0) => m_axi_bresp(1 downto 0),
      m_axi_bvalid => m_axi_bvalid,
      s_aclk => s_aclk,
      s_aresetn => s_aresetn,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid => s_axi_bvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ is
  port (
    backup : in STD_LOGIC;
    backup_marker : in STD_LOGIC;
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    srst : in STD_LOGIC;
    wr_clk : in STD_LOGIC;
    wr_rst : in STD_LOGIC;
    rd_clk : in STD_LOGIC;
    rd_rst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 17 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    prog_empty_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    prog_empty_thresh_assert : in STD_LOGIC_VECTOR ( 9 downto 0 );
    prog_empty_thresh_negate : in STD_LOGIC_VECTOR ( 9 downto 0 );
    prog_full_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    prog_full_thresh_assert : in STD_LOGIC_VECTOR ( 9 downto 0 );
    prog_full_thresh_negate : in STD_LOGIC_VECTOR ( 9 downto 0 );
    int_clk : in STD_LOGIC;
    injectdbiterr : in STD_LOGIC;
    injectsbiterr : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 17 downto 0 );
    full : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    wr_ack : out STD_LOGIC;
    overflow : out STD_LOGIC;
    empty : out STD_LOGIC;
    almost_empty : out STD_LOGIC;
    valid : out STD_LOGIC;
    underflow : out STD_LOGIC;
    data_count : out STD_LOGIC_VECTOR ( 9 downto 0 );
    rd_data_count : out STD_LOGIC_VECTOR ( 9 downto 0 );
    wr_data_count : out STD_LOGIC_VECTOR ( 9 downto 0 );
    prog_full : out STD_LOGIC;
    prog_empty : out STD_LOGIC;
    sbiterr : out STD_LOGIC;
    dbiterr : out STD_LOGIC;
    wr_rst_busy : out STD_LOGIC;
    rd_rst_busy : out STD_LOGIC;
    m_aclk : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC;
    m_aclk_en : in STD_LOGIC;
    s_aclk_en : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_buser : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    m_axi_awid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_wuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_buser : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_aruser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_ruser : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_arid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_aruser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_ruser : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_aw_injectsbiterr : in STD_LOGIC;
    axi_aw_injectdbiterr : in STD_LOGIC;
    axi_aw_prog_full_thresh : in STD_LOGIC_VECTOR ( 5 downto 0 );
    axi_aw_prog_empty_thresh : in STD_LOGIC_VECTOR ( 5 downto 0 );
    axi_aw_data_count : out STD_LOGIC_VECTOR ( 6 downto 0 );
    axi_aw_wr_data_count : out STD_LOGIC_VECTOR ( 6 downto 0 );
    axi_aw_rd_data_count : out STD_LOGIC_VECTOR ( 6 downto 0 );
    axi_aw_sbiterr : out STD_LOGIC;
    axi_aw_dbiterr : out STD_LOGIC;
    axi_aw_overflow : out STD_LOGIC;
    axi_aw_underflow : out STD_LOGIC;
    axi_aw_prog_full : out STD_LOGIC;
    axi_aw_prog_empty : out STD_LOGIC;
    axi_w_injectsbiterr : in STD_LOGIC;
    axi_w_injectdbiterr : in STD_LOGIC;
    axi_w_prog_full_thresh : in STD_LOGIC_VECTOR ( 5 downto 0 );
    axi_w_prog_empty_thresh : in STD_LOGIC_VECTOR ( 5 downto 0 );
    axi_w_data_count : out STD_LOGIC_VECTOR ( 6 downto 0 );
    axi_w_wr_data_count : out STD_LOGIC_VECTOR ( 6 downto 0 );
    axi_w_rd_data_count : out STD_LOGIC_VECTOR ( 6 downto 0 );
    axi_w_sbiterr : out STD_LOGIC;
    axi_w_dbiterr : out STD_LOGIC;
    axi_w_overflow : out STD_LOGIC;
    axi_w_underflow : out STD_LOGIC;
    axi_w_prog_full : out STD_LOGIC;
    axi_w_prog_empty : out STD_LOGIC;
    axi_b_injectsbiterr : in STD_LOGIC;
    axi_b_injectdbiterr : in STD_LOGIC;
    axi_b_prog_full_thresh : in STD_LOGIC_VECTOR ( 5 downto 0 );
    axi_b_prog_empty_thresh : in STD_LOGIC_VECTOR ( 5 downto 0 );
    axi_b_data_count : out STD_LOGIC_VECTOR ( 6 downto 0 );
    axi_b_wr_data_count : out STD_LOGIC_VECTOR ( 6 downto 0 );
    axi_b_rd_data_count : out STD_LOGIC_VECTOR ( 6 downto 0 );
    axi_b_sbiterr : out STD_LOGIC;
    axi_b_dbiterr : out STD_LOGIC;
    axi_b_overflow : out STD_LOGIC;
    axi_b_underflow : out STD_LOGIC;
    axi_b_prog_full : out STD_LOGIC;
    axi_b_prog_empty : out STD_LOGIC;
    axi_ar_injectsbiterr : in STD_LOGIC;
    axi_ar_injectdbiterr : in STD_LOGIC;
    axi_ar_prog_full_thresh : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_ar_prog_empty_thresh : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_ar_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_ar_wr_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_ar_rd_data_count : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_ar_sbiterr : out STD_LOGIC;
    axi_ar_dbiterr : out STD_LOGIC;
    axi_ar_overflow : out STD_LOGIC;
    axi_ar_underflow : out STD_LOGIC;
    axi_ar_prog_full : out STD_LOGIC;
    axi_ar_prog_empty : out STD_LOGIC;
    axi_r_injectsbiterr : in STD_LOGIC;
    axi_r_injectdbiterr : in STD_LOGIC;
    axi_r_prog_full_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    axi_r_prog_empty_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    axi_r_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axi_r_wr_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axi_r_rd_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axi_r_sbiterr : out STD_LOGIC;
    axi_r_dbiterr : out STD_LOGIC;
    axi_r_overflow : out STD_LOGIC;
    axi_r_underflow : out STD_LOGIC;
    axi_r_prog_full : out STD_LOGIC;
    axi_r_prog_empty : out STD_LOGIC;
    axis_injectsbiterr : in STD_LOGIC;
    axis_injectdbiterr : in STD_LOGIC;
    axis_prog_full_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    axis_prog_empty_thresh : in STD_LOGIC_VECTOR ( 9 downto 0 );
    axis_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axis_wr_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axis_rd_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 );
    axis_sbiterr : out STD_LOGIC;
    axis_dbiterr : out STD_LOGIC;
    axis_overflow : out STD_LOGIC;
    axis_underflow : out STD_LOGIC;
    axis_prog_full : out STD_LOGIC;
    axis_prog_empty : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "fifo_generator_v11_0";
  attribute C_COMMON_CLOCK : integer;
  attribute C_COMMON_CLOCK of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_COUNT_TYPE : integer;
  attribute C_COUNT_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_DATA_COUNT_WIDTH : integer;
  attribute C_DATA_COUNT_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 10;
  attribute C_DEFAULT_VALUE : string;
  attribute C_DEFAULT_VALUE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "BlankString";
  attribute C_DIN_WIDTH : integer;
  attribute C_DIN_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 18;
  attribute C_DOUT_RST_VAL : string;
  attribute C_DOUT_RST_VAL of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "0";
  attribute C_DOUT_WIDTH : integer;
  attribute C_DOUT_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 18;
  attribute C_ENABLE_RLOCS : integer;
  attribute C_ENABLE_RLOCS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "kintex7";
  attribute C_FULL_FLAGS_RST_VAL : integer;
  attribute C_FULL_FLAGS_RST_VAL of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_HAS_ALMOST_EMPTY : integer;
  attribute C_HAS_ALMOST_EMPTY of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_ALMOST_FULL : integer;
  attribute C_HAS_ALMOST_FULL of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_BACKUP : integer;
  attribute C_HAS_BACKUP of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_DATA_COUNT : integer;
  attribute C_HAS_DATA_COUNT of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_INT_CLK : integer;
  attribute C_HAS_INT_CLK of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_MEMINIT_FILE : integer;
  attribute C_HAS_MEMINIT_FILE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_HAS_RD_DATA_COUNT : integer;
  attribute C_HAS_RD_DATA_COUNT of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_RD_RST : integer;
  attribute C_HAS_RD_RST of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_RST : integer;
  attribute C_HAS_RST of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_HAS_SRST : integer;
  attribute C_HAS_SRST of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_VALID : integer;
  attribute C_HAS_VALID of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_WR_ACK : integer;
  attribute C_HAS_WR_ACK of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_WR_DATA_COUNT : integer;
  attribute C_HAS_WR_DATA_COUNT of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_WR_RST : integer;
  attribute C_HAS_WR_RST of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_IMPLEMENTATION_TYPE : integer;
  attribute C_IMPLEMENTATION_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_INIT_WR_PNTR_VAL : integer;
  attribute C_INIT_WR_PNTR_VAL of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_MEMORY_TYPE : integer;
  attribute C_MEMORY_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_MIF_FILE_NAME : string;
  attribute C_MIF_FILE_NAME of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "BlankString";
  attribute C_OPTIMIZATION_MODE : integer;
  attribute C_OPTIMIZATION_MODE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_OVERFLOW_LOW : integer;
  attribute C_OVERFLOW_LOW of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PRELOAD_LATENCY : integer;
  attribute C_PRELOAD_LATENCY of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_PRELOAD_REGS : integer;
  attribute C_PRELOAD_REGS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PRIM_FIFO_TYPE : string;
  attribute C_PRIM_FIFO_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "4kx4";
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 2;
  attribute C_PROG_EMPTY_THRESH_NEGATE_VAL : integer;
  attribute C_PROG_EMPTY_THRESH_NEGATE_VAL of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 3;
  attribute C_PROG_EMPTY_TYPE : integer;
  attribute C_PROG_EMPTY_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1022;
  attribute C_PROG_FULL_THRESH_NEGATE_VAL : integer;
  attribute C_PROG_FULL_THRESH_NEGATE_VAL of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1021;
  attribute C_PROG_FULL_TYPE : integer;
  attribute C_PROG_FULL_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_RD_DATA_COUNT_WIDTH : integer;
  attribute C_RD_DATA_COUNT_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 10;
  attribute C_RD_DEPTH : integer;
  attribute C_RD_DEPTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1024;
  attribute C_RD_FREQ : integer;
  attribute C_RD_FREQ of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_RD_PNTR_WIDTH : integer;
  attribute C_RD_PNTR_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 10;
  attribute C_UNDERFLOW_LOW : integer;
  attribute C_UNDERFLOW_LOW of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_DOUT_RST : integer;
  attribute C_USE_DOUT_RST of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_EMBEDDED_REG : integer;
  attribute C_USE_EMBEDDED_REG of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_FIFO16_FLAGS : integer;
  attribute C_USE_FIFO16_FLAGS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_FWFT_DATA_COUNT : integer;
  attribute C_USE_FWFT_DATA_COUNT of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_VALID_LOW : integer;
  attribute C_VALID_LOW of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_WR_ACK_LOW : integer;
  attribute C_WR_ACK_LOW of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_WR_DATA_COUNT_WIDTH : integer;
  attribute C_WR_DATA_COUNT_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 10;
  attribute C_WR_DEPTH : integer;
  attribute C_WR_DEPTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1024;
  attribute C_WR_FREQ : integer;
  attribute C_WR_FREQ of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_WR_PNTR_WIDTH : integer;
  attribute C_WR_PNTR_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 10;
  attribute C_WR_RESPONSE_LATENCY : integer;
  attribute C_WR_RESPONSE_LATENCY of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_MSGON_VAL : integer;
  attribute C_MSGON_VAL of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_ENABLE_RST_SYNC : integer;
  attribute C_ENABLE_RST_SYNC of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_ERROR_INJECTION_TYPE : integer;
  attribute C_ERROR_INJECTION_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_SYNCHRONIZER_STAGE : integer;
  attribute C_SYNCHRONIZER_STAGE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 2;
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 2;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 2;
  attribute C_HAS_AXI_WR_CHANNEL : integer;
  attribute C_HAS_AXI_WR_CHANNEL of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_HAS_AXI_RD_CHANNEL : integer;
  attribute C_HAS_AXI_RD_CHANNEL of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_SLAVE_CE : integer;
  attribute C_HAS_SLAVE_CE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_MASTER_CE : integer;
  attribute C_HAS_MASTER_CE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_ADD_NGC_CONSTRAINT : integer;
  attribute C_ADD_NGC_CONSTRAINT of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_COMMON_OVERFLOW : integer;
  attribute C_USE_COMMON_OVERFLOW of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_COMMON_UNDERFLOW : integer;
  attribute C_USE_COMMON_UNDERFLOW of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_DEFAULT_SETTINGS : integer;
  attribute C_USE_DEFAULT_SETTINGS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_AXI_ADDR_WIDTH : integer;
  attribute C_AXI_ADDR_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 32;
  attribute C_AXI_DATA_WIDTH : integer;
  attribute C_AXI_DATA_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 32;
  attribute C_AXI_LEN_WIDTH : integer;
  attribute C_AXI_LEN_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 4;
  attribute C_AXI_LOCK_WIDTH : integer;
  attribute C_AXI_LOCK_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 2;
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_AXI_AWUSER : integer;
  attribute C_HAS_AXI_AWUSER of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_AXI_WUSER : integer;
  attribute C_HAS_AXI_WUSER of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_AXI_BUSER : integer;
  attribute C_HAS_AXI_BUSER of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_AXI_ARUSER : integer;
  attribute C_HAS_AXI_ARUSER of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_AXI_RUSER : integer;
  attribute C_HAS_AXI_RUSER of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_AXI_ARUSER_WIDTH : integer;
  attribute C_AXI_ARUSER_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_AXI_AWUSER_WIDTH : integer;
  attribute C_AXI_AWUSER_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_AXI_WUSER_WIDTH : integer;
  attribute C_AXI_WUSER_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_AXI_BUSER_WIDTH : integer;
  attribute C_AXI_BUSER_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_AXI_RUSER_WIDTH : integer;
  attribute C_AXI_RUSER_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_HAS_AXIS_TDATA : integer;
  attribute C_HAS_AXIS_TDATA of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_HAS_AXIS_TID : integer;
  attribute C_HAS_AXIS_TID of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_AXIS_TDEST : integer;
  attribute C_HAS_AXIS_TDEST of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_AXIS_TUSER : integer;
  attribute C_HAS_AXIS_TUSER of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_HAS_AXIS_TREADY : integer;
  attribute C_HAS_AXIS_TREADY of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_HAS_AXIS_TLAST : integer;
  attribute C_HAS_AXIS_TLAST of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_AXIS_TSTRB : integer;
  attribute C_HAS_AXIS_TSTRB of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_AXIS_TKEEP : integer;
  attribute C_HAS_AXIS_TKEEP of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 8;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 4;
  attribute C_AXIS_TSTRB_WIDTH : integer;
  attribute C_AXIS_TSTRB_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_AXIS_TKEEP_WIDTH : integer;
  attribute C_AXIS_TKEEP_WIDTH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_WACH_TYPE : integer;
  attribute C_WACH_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_WDCH_TYPE : integer;
  attribute C_WDCH_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_WRCH_TYPE : integer;
  attribute C_WRCH_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_RACH_TYPE : integer;
  attribute C_RACH_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_RDCH_TYPE : integer;
  attribute C_RDCH_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_AXIS_TYPE : integer;
  attribute C_AXIS_TYPE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_IMPLEMENTATION_TYPE_WACH : integer;
  attribute C_IMPLEMENTATION_TYPE_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 12;
  attribute C_IMPLEMENTATION_TYPE_WDCH : integer;
  attribute C_IMPLEMENTATION_TYPE_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 12;
  attribute C_IMPLEMENTATION_TYPE_WRCH : integer;
  attribute C_IMPLEMENTATION_TYPE_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 12;
  attribute C_IMPLEMENTATION_TYPE_RACH : integer;
  attribute C_IMPLEMENTATION_TYPE_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 12;
  attribute C_IMPLEMENTATION_TYPE_RDCH : integer;
  attribute C_IMPLEMENTATION_TYPE_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 11;
  attribute C_IMPLEMENTATION_TYPE_AXIS : integer;
  attribute C_IMPLEMENTATION_TYPE_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 11;
  attribute C_APPLICATION_TYPE_WACH : integer;
  attribute C_APPLICATION_TYPE_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_APPLICATION_TYPE_WDCH : integer;
  attribute C_APPLICATION_TYPE_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_APPLICATION_TYPE_WRCH : integer;
  attribute C_APPLICATION_TYPE_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_APPLICATION_TYPE_RACH : integer;
  attribute C_APPLICATION_TYPE_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_APPLICATION_TYPE_RDCH : integer;
  attribute C_APPLICATION_TYPE_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_APPLICATION_TYPE_AXIS : integer;
  attribute C_APPLICATION_TYPE_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PRIM_FIFO_TYPE_WACH : string;
  attribute C_PRIM_FIFO_TYPE_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "512x36";
  attribute C_PRIM_FIFO_TYPE_WDCH : string;
  attribute C_PRIM_FIFO_TYPE_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "512x36";
  attribute C_PRIM_FIFO_TYPE_WRCH : string;
  attribute C_PRIM_FIFO_TYPE_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "512x36";
  attribute C_PRIM_FIFO_TYPE_RACH : string;
  attribute C_PRIM_FIFO_TYPE_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "512x36";
  attribute C_PRIM_FIFO_TYPE_RDCH : string;
  attribute C_PRIM_FIFO_TYPE_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "1kx36";
  attribute C_PRIM_FIFO_TYPE_AXIS : string;
  attribute C_PRIM_FIFO_TYPE_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is "1kx18";
  attribute C_USE_ECC_WACH : integer;
  attribute C_USE_ECC_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_ECC_WDCH : integer;
  attribute C_USE_ECC_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_ECC_WRCH : integer;
  attribute C_USE_ECC_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_ECC_RACH : integer;
  attribute C_USE_ECC_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_ECC_RDCH : integer;
  attribute C_USE_ECC_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_USE_ECC_AXIS : integer;
  attribute C_USE_ECC_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_WACH : integer;
  attribute C_ERROR_INJECTION_TYPE_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_WDCH : integer;
  attribute C_ERROR_INJECTION_TYPE_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_WRCH : integer;
  attribute C_ERROR_INJECTION_TYPE_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_RACH : integer;
  attribute C_ERROR_INJECTION_TYPE_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_RDCH : integer;
  attribute C_ERROR_INJECTION_TYPE_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_ERROR_INJECTION_TYPE_AXIS : integer;
  attribute C_ERROR_INJECTION_TYPE_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_DIN_WIDTH_WACH : integer;
  attribute C_DIN_WIDTH_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 35;
  attribute C_DIN_WIDTH_WDCH : integer;
  attribute C_DIN_WIDTH_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 36;
  attribute C_DIN_WIDTH_WRCH : integer;
  attribute C_DIN_WIDTH_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 2;
  attribute C_DIN_WIDTH_RACH : integer;
  attribute C_DIN_WIDTH_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 35;
  attribute C_DIN_WIDTH_RDCH : integer;
  attribute C_DIN_WIDTH_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 34;
  attribute C_DIN_WIDTH_AXIS : integer;
  attribute C_DIN_WIDTH_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1;
  attribute C_WR_DEPTH_WACH : integer;
  attribute C_WR_DEPTH_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 64;
  attribute C_WR_DEPTH_WDCH : integer;
  attribute C_WR_DEPTH_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 64;
  attribute C_WR_DEPTH_WRCH : integer;
  attribute C_WR_DEPTH_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 64;
  attribute C_WR_DEPTH_RACH : integer;
  attribute C_WR_DEPTH_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 16;
  attribute C_WR_DEPTH_RDCH : integer;
  attribute C_WR_DEPTH_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1024;
  attribute C_WR_DEPTH_AXIS : integer;
  attribute C_WR_DEPTH_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1024;
  attribute C_WR_PNTR_WIDTH_WACH : integer;
  attribute C_WR_PNTR_WIDTH_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 6;
  attribute C_WR_PNTR_WIDTH_WDCH : integer;
  attribute C_WR_PNTR_WIDTH_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 6;
  attribute C_WR_PNTR_WIDTH_WRCH : integer;
  attribute C_WR_PNTR_WIDTH_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 6;
  attribute C_WR_PNTR_WIDTH_RACH : integer;
  attribute C_WR_PNTR_WIDTH_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 4;
  attribute C_WR_PNTR_WIDTH_RDCH : integer;
  attribute C_WR_PNTR_WIDTH_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 10;
  attribute C_WR_PNTR_WIDTH_AXIS : integer;
  attribute C_WR_PNTR_WIDTH_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 10;
  attribute C_HAS_DATA_COUNTS_WACH : integer;
  attribute C_HAS_DATA_COUNTS_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_DATA_COUNTS_WDCH : integer;
  attribute C_HAS_DATA_COUNTS_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_DATA_COUNTS_WRCH : integer;
  attribute C_HAS_DATA_COUNTS_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_DATA_COUNTS_RACH : integer;
  attribute C_HAS_DATA_COUNTS_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_DATA_COUNTS_RDCH : integer;
  attribute C_HAS_DATA_COUNTS_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_DATA_COUNTS_AXIS : integer;
  attribute C_HAS_DATA_COUNTS_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_PROG_FLAGS_WACH : integer;
  attribute C_HAS_PROG_FLAGS_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_PROG_FLAGS_WDCH : integer;
  attribute C_HAS_PROG_FLAGS_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_PROG_FLAGS_WRCH : integer;
  attribute C_HAS_PROG_FLAGS_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_PROG_FLAGS_RACH : integer;
  attribute C_HAS_PROG_FLAGS_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_PROG_FLAGS_RDCH : integer;
  attribute C_HAS_PROG_FLAGS_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_HAS_PROG_FLAGS_AXIS : integer;
  attribute C_HAS_PROG_FLAGS_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_FULL_TYPE_WACH : integer;
  attribute C_PROG_FULL_TYPE_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_FULL_TYPE_WDCH : integer;
  attribute C_PROG_FULL_TYPE_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_FULL_TYPE_WRCH : integer;
  attribute C_PROG_FULL_TYPE_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_FULL_TYPE_RACH : integer;
  attribute C_PROG_FULL_TYPE_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_FULL_TYPE_RDCH : integer;
  attribute C_PROG_FULL_TYPE_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_FULL_TYPE_AXIS : integer;
  attribute C_PROG_FULL_TYPE_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WACH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 63;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WDCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 63;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WRCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 63;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RACH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 15;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RDCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_AXIS : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1023;
  attribute C_PROG_EMPTY_TYPE_WACH : integer;
  attribute C_PROG_EMPTY_TYPE_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_EMPTY_TYPE_WDCH : integer;
  attribute C_PROG_EMPTY_TYPE_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_EMPTY_TYPE_WRCH : integer;
  attribute C_PROG_EMPTY_TYPE_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_EMPTY_TYPE_RACH : integer;
  attribute C_PROG_EMPTY_TYPE_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_EMPTY_TYPE_RDCH : integer;
  attribute C_PROG_EMPTY_TYPE_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_EMPTY_TYPE_AXIS : integer;
  attribute C_PROG_EMPTY_TYPE_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 61;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 61;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 61;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 13;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1021;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 1021;
  attribute C_REG_SLICE_MODE_WACH : integer;
  attribute C_REG_SLICE_MODE_WACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_REG_SLICE_MODE_WDCH : integer;
  attribute C_REG_SLICE_MODE_WDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_REG_SLICE_MODE_WRCH : integer;
  attribute C_REG_SLICE_MODE_WRCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_REG_SLICE_MODE_RACH : integer;
  attribute C_REG_SLICE_MODE_RACH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_REG_SLICE_MODE_RDCH : integer;
  attribute C_REG_SLICE_MODE_RDCH of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
  attribute C_REG_SLICE_MODE_AXIS : integer;
  attribute C_REG_SLICE_MODE_AXIS of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ : entity is 0;
end \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\;

architecture STRUCTURE of \t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
begin
  almost_empty <= \<const1>\;
  almost_full <= \<const0>\;
  axi_ar_data_count(4) <= \<const0>\;
  axi_ar_data_count(3) <= \<const0>\;
  axi_ar_data_count(2) <= \<const0>\;
  axi_ar_data_count(1) <= \<const0>\;
  axi_ar_data_count(0) <= \<const0>\;
  axi_ar_dbiterr <= \<const0>\;
  axi_ar_overflow <= \<const0>\;
  axi_ar_prog_empty <= \<const1>\;
  axi_ar_prog_full <= \<const0>\;
  axi_ar_rd_data_count(4) <= \<const0>\;
  axi_ar_rd_data_count(3) <= \<const0>\;
  axi_ar_rd_data_count(2) <= \<const0>\;
  axi_ar_rd_data_count(1) <= \<const0>\;
  axi_ar_rd_data_count(0) <= \<const0>\;
  axi_ar_sbiterr <= \<const0>\;
  axi_ar_underflow <= \<const0>\;
  axi_ar_wr_data_count(4) <= \<const0>\;
  axi_ar_wr_data_count(3) <= \<const0>\;
  axi_ar_wr_data_count(2) <= \<const0>\;
  axi_ar_wr_data_count(1) <= \<const0>\;
  axi_ar_wr_data_count(0) <= \<const0>\;
  axi_aw_data_count(6) <= \<const0>\;
  axi_aw_data_count(5) <= \<const0>\;
  axi_aw_data_count(4) <= \<const0>\;
  axi_aw_data_count(3) <= \<const0>\;
  axi_aw_data_count(2) <= \<const0>\;
  axi_aw_data_count(1) <= \<const0>\;
  axi_aw_data_count(0) <= \<const0>\;
  axi_aw_dbiterr <= \<const0>\;
  axi_aw_prog_empty <= \<const0>\;
  axi_aw_prog_full <= \<const0>\;
  axi_aw_rd_data_count(6) <= \<const0>\;
  axi_aw_rd_data_count(5) <= \<const0>\;
  axi_aw_rd_data_count(4) <= \<const0>\;
  axi_aw_rd_data_count(3) <= \<const0>\;
  axi_aw_rd_data_count(2) <= \<const0>\;
  axi_aw_rd_data_count(1) <= \<const0>\;
  axi_aw_rd_data_count(0) <= \<const0>\;
  axi_aw_sbiterr <= \<const0>\;
  axi_aw_underflow <= \<const0>\;
  axi_aw_wr_data_count(6) <= \<const0>\;
  axi_aw_wr_data_count(5) <= \<const0>\;
  axi_aw_wr_data_count(4) <= \<const0>\;
  axi_aw_wr_data_count(3) <= \<const0>\;
  axi_aw_wr_data_count(2) <= \<const0>\;
  axi_aw_wr_data_count(1) <= \<const0>\;
  axi_aw_wr_data_count(0) <= \<const0>\;
  axi_b_data_count(6) <= \<const0>\;
  axi_b_data_count(5) <= \<const0>\;
  axi_b_data_count(4) <= \<const0>\;
  axi_b_data_count(3) <= \<const0>\;
  axi_b_data_count(2) <= \<const0>\;
  axi_b_data_count(1) <= \<const0>\;
  axi_b_data_count(0) <= \<const0>\;
  axi_b_dbiterr <= \<const0>\;
  axi_b_prog_empty <= \<const0>\;
  axi_b_prog_full <= \<const0>\;
  axi_b_rd_data_count(6) <= \<const0>\;
  axi_b_rd_data_count(5) <= \<const0>\;
  axi_b_rd_data_count(4) <= \<const0>\;
  axi_b_rd_data_count(3) <= \<const0>\;
  axi_b_rd_data_count(2) <= \<const0>\;
  axi_b_rd_data_count(1) <= \<const0>\;
  axi_b_rd_data_count(0) <= \<const0>\;
  axi_b_sbiterr <= \<const0>\;
  axi_b_underflow <= \<const0>\;
  axi_b_wr_data_count(6) <= \<const0>\;
  axi_b_wr_data_count(5) <= \<const0>\;
  axi_b_wr_data_count(4) <= \<const0>\;
  axi_b_wr_data_count(3) <= \<const0>\;
  axi_b_wr_data_count(2) <= \<const0>\;
  axi_b_wr_data_count(1) <= \<const0>\;
  axi_b_wr_data_count(0) <= \<const0>\;
  axi_r_data_count(10) <= \<const0>\;
  axi_r_data_count(9) <= \<const0>\;
  axi_r_data_count(8) <= \<const0>\;
  axi_r_data_count(7) <= \<const0>\;
  axi_r_data_count(6) <= \<const0>\;
  axi_r_data_count(5) <= \<const0>\;
  axi_r_data_count(4) <= \<const0>\;
  axi_r_data_count(3) <= \<const0>\;
  axi_r_data_count(2) <= \<const0>\;
  axi_r_data_count(1) <= \<const0>\;
  axi_r_data_count(0) <= \<const0>\;
  axi_r_dbiterr <= \<const0>\;
  axi_r_overflow <= \<const0>\;
  axi_r_prog_empty <= \<const1>\;
  axi_r_prog_full <= \<const0>\;
  axi_r_rd_data_count(10) <= \<const0>\;
  axi_r_rd_data_count(9) <= \<const0>\;
  axi_r_rd_data_count(8) <= \<const0>\;
  axi_r_rd_data_count(7) <= \<const0>\;
  axi_r_rd_data_count(6) <= \<const0>\;
  axi_r_rd_data_count(5) <= \<const0>\;
  axi_r_rd_data_count(4) <= \<const0>\;
  axi_r_rd_data_count(3) <= \<const0>\;
  axi_r_rd_data_count(2) <= \<const0>\;
  axi_r_rd_data_count(1) <= \<const0>\;
  axi_r_rd_data_count(0) <= \<const0>\;
  axi_r_sbiterr <= \<const0>\;
  axi_r_underflow <= \<const0>\;
  axi_r_wr_data_count(10) <= \<const0>\;
  axi_r_wr_data_count(9) <= \<const0>\;
  axi_r_wr_data_count(8) <= \<const0>\;
  axi_r_wr_data_count(7) <= \<const0>\;
  axi_r_wr_data_count(6) <= \<const0>\;
  axi_r_wr_data_count(5) <= \<const0>\;
  axi_r_wr_data_count(4) <= \<const0>\;
  axi_r_wr_data_count(3) <= \<const0>\;
  axi_r_wr_data_count(2) <= \<const0>\;
  axi_r_wr_data_count(1) <= \<const0>\;
  axi_r_wr_data_count(0) <= \<const0>\;
  axi_w_data_count(6) <= \<const0>\;
  axi_w_data_count(5) <= \<const0>\;
  axi_w_data_count(4) <= \<const0>\;
  axi_w_data_count(3) <= \<const0>\;
  axi_w_data_count(2) <= \<const0>\;
  axi_w_data_count(1) <= \<const0>\;
  axi_w_data_count(0) <= \<const0>\;
  axi_w_dbiterr <= \<const0>\;
  axi_w_prog_empty <= \<const0>\;
  axi_w_prog_full <= \<const0>\;
  axi_w_rd_data_count(6) <= \<const0>\;
  axi_w_rd_data_count(5) <= \<const0>\;
  axi_w_rd_data_count(4) <= \<const0>\;
  axi_w_rd_data_count(3) <= \<const0>\;
  axi_w_rd_data_count(2) <= \<const0>\;
  axi_w_rd_data_count(1) <= \<const0>\;
  axi_w_rd_data_count(0) <= \<const0>\;
  axi_w_sbiterr <= \<const0>\;
  axi_w_underflow <= \<const0>\;
  axi_w_wr_data_count(6) <= \<const0>\;
  axi_w_wr_data_count(5) <= \<const0>\;
  axi_w_wr_data_count(4) <= \<const0>\;
  axi_w_wr_data_count(3) <= \<const0>\;
  axi_w_wr_data_count(2) <= \<const0>\;
  axi_w_wr_data_count(1) <= \<const0>\;
  axi_w_wr_data_count(0) <= \<const0>\;
  axis_data_count(10) <= \<const0>\;
  axis_data_count(9) <= \<const0>\;
  axis_data_count(8) <= \<const0>\;
  axis_data_count(7) <= \<const0>\;
  axis_data_count(6) <= \<const0>\;
  axis_data_count(5) <= \<const0>\;
  axis_data_count(4) <= \<const0>\;
  axis_data_count(3) <= \<const0>\;
  axis_data_count(2) <= \<const0>\;
  axis_data_count(1) <= \<const0>\;
  axis_data_count(0) <= \<const0>\;
  axis_dbiterr <= \<const0>\;
  axis_overflow <= \<const0>\;
  axis_prog_empty <= \<const1>\;
  axis_prog_full <= \<const0>\;
  axis_rd_data_count(10) <= \<const0>\;
  axis_rd_data_count(9) <= \<const0>\;
  axis_rd_data_count(8) <= \<const0>\;
  axis_rd_data_count(7) <= \<const0>\;
  axis_rd_data_count(6) <= \<const0>\;
  axis_rd_data_count(5) <= \<const0>\;
  axis_rd_data_count(4) <= \<const0>\;
  axis_rd_data_count(3) <= \<const0>\;
  axis_rd_data_count(2) <= \<const0>\;
  axis_rd_data_count(1) <= \<const0>\;
  axis_rd_data_count(0) <= \<const0>\;
  axis_sbiterr <= \<const0>\;
  axis_underflow <= \<const0>\;
  axis_wr_data_count(10) <= \<const0>\;
  axis_wr_data_count(9) <= \<const0>\;
  axis_wr_data_count(8) <= \<const0>\;
  axis_wr_data_count(7) <= \<const0>\;
  axis_wr_data_count(6) <= \<const0>\;
  axis_wr_data_count(5) <= \<const0>\;
  axis_wr_data_count(4) <= \<const0>\;
  axis_wr_data_count(3) <= \<const0>\;
  axis_wr_data_count(2) <= \<const0>\;
  axis_wr_data_count(1) <= \<const0>\;
  axis_wr_data_count(0) <= \<const0>\;
  data_count(9) <= \<const0>\;
  data_count(8) <= \<const0>\;
  data_count(7) <= \<const0>\;
  data_count(6) <= \<const0>\;
  data_count(5) <= \<const0>\;
  data_count(4) <= \<const0>\;
  data_count(3) <= \<const0>\;
  data_count(2) <= \<const0>\;
  data_count(1) <= \<const0>\;
  data_count(0) <= \<const0>\;
  dbiterr <= \<const0>\;
  dout(17) <= \<const0>\;
  dout(16) <= \<const0>\;
  dout(15) <= \<const0>\;
  dout(14) <= \<const0>\;
  dout(13) <= \<const0>\;
  dout(12) <= \<const0>\;
  dout(11) <= \<const0>\;
  dout(10) <= \<const0>\;
  dout(9) <= \<const0>\;
  dout(8) <= \<const0>\;
  dout(7) <= \<const0>\;
  dout(6) <= \<const0>\;
  dout(5) <= \<const0>\;
  dout(4) <= \<const0>\;
  dout(3) <= \<const0>\;
  dout(2) <= \<const0>\;
  dout(1) <= \<const0>\;
  dout(0) <= \<const0>\;
  empty <= \<const1>\;
  full <= \<const0>\;
  m_axi_araddr(31) <= \<const0>\;
  m_axi_araddr(30) <= \<const0>\;
  m_axi_araddr(29) <= \<const0>\;
  m_axi_araddr(28) <= \<const0>\;
  m_axi_araddr(27) <= \<const0>\;
  m_axi_araddr(26) <= \<const0>\;
  m_axi_araddr(25) <= \<const0>\;
  m_axi_araddr(24) <= \<const0>\;
  m_axi_araddr(23) <= \<const0>\;
  m_axi_araddr(22) <= \<const0>\;
  m_axi_araddr(21) <= \<const0>\;
  m_axi_araddr(20) <= \<const0>\;
  m_axi_araddr(19) <= \<const0>\;
  m_axi_araddr(18) <= \<const0>\;
  m_axi_araddr(17) <= \<const0>\;
  m_axi_araddr(16) <= \<const0>\;
  m_axi_araddr(15) <= \<const0>\;
  m_axi_araddr(14) <= \<const0>\;
  m_axi_araddr(13) <= \<const0>\;
  m_axi_araddr(12) <= \<const0>\;
  m_axi_araddr(11) <= \<const0>\;
  m_axi_araddr(10) <= \<const0>\;
  m_axi_araddr(9) <= \<const0>\;
  m_axi_araddr(8) <= \<const0>\;
  m_axi_araddr(7) <= \<const0>\;
  m_axi_araddr(6) <= \<const0>\;
  m_axi_araddr(5) <= \<const0>\;
  m_axi_araddr(4) <= \<const0>\;
  m_axi_araddr(3) <= \<const0>\;
  m_axi_araddr(2) <= \<const0>\;
  m_axi_araddr(1) <= \<const0>\;
  m_axi_araddr(0) <= \<const0>\;
  m_axi_arburst(1) <= \<const0>\;
  m_axi_arburst(0) <= \<const0>\;
  m_axi_arcache(3) <= \<const0>\;
  m_axi_arcache(2) <= \<const0>\;
  m_axi_arcache(1) <= \<const0>\;
  m_axi_arcache(0) <= \<const0>\;
  m_axi_arid(0) <= \<const0>\;
  m_axi_arlen(3) <= \<const0>\;
  m_axi_arlen(2) <= \<const0>\;
  m_axi_arlen(1) <= \<const0>\;
  m_axi_arlen(0) <= \<const0>\;
  m_axi_arlock(1) <= \<const0>\;
  m_axi_arlock(0) <= \<const0>\;
  m_axi_arprot(2) <= \<const0>\;
  m_axi_arprot(1) <= \<const0>\;
  m_axi_arprot(0) <= \<const0>\;
  m_axi_arqos(3) <= \<const0>\;
  m_axi_arqos(2) <= \<const0>\;
  m_axi_arqos(1) <= \<const0>\;
  m_axi_arqos(0) <= \<const0>\;
  m_axi_arregion(3) <= \<const0>\;
  m_axi_arregion(2) <= \<const0>\;
  m_axi_arregion(1) <= \<const0>\;
  m_axi_arregion(0) <= \<const0>\;
  m_axi_arsize(2) <= \<const0>\;
  m_axi_arsize(1) <= \<const0>\;
  m_axi_arsize(0) <= \<const0>\;
  m_axi_aruser(0) <= \<const0>\;
  m_axi_arvalid <= \<const0>\;
  m_axi_awburst(1) <= \<const0>\;
  m_axi_awburst(0) <= \<const0>\;
  m_axi_awcache(3) <= \<const0>\;
  m_axi_awcache(2) <= \<const0>\;
  m_axi_awcache(1) <= \<const0>\;
  m_axi_awcache(0) <= \<const0>\;
  m_axi_awid(0) <= \<const0>\;
  m_axi_awlen(3) <= \<const0>\;
  m_axi_awlen(2) <= \<const0>\;
  m_axi_awlen(1) <= \<const0>\;
  m_axi_awlen(0) <= \<const0>\;
  m_axi_awlock(1) <= \<const0>\;
  m_axi_awlock(0) <= \<const0>\;
  m_axi_awqos(3) <= \<const0>\;
  m_axi_awqos(2) <= \<const0>\;
  m_axi_awqos(1) <= \<const0>\;
  m_axi_awqos(0) <= \<const0>\;
  m_axi_awregion(3) <= \<const0>\;
  m_axi_awregion(2) <= \<const0>\;
  m_axi_awregion(1) <= \<const0>\;
  m_axi_awregion(0) <= \<const0>\;
  m_axi_awsize(2) <= \<const0>\;
  m_axi_awsize(1) <= \<const0>\;
  m_axi_awsize(0) <= \<const0>\;
  m_axi_awuser(0) <= \<const0>\;
  m_axi_rready <= \<const0>\;
  m_axi_wid(0) <= \<const0>\;
  m_axi_wlast <= \<const0>\;
  m_axi_wuser(0) <= \<const0>\;
  m_axis_tdata(7) <= \<const0>\;
  m_axis_tdata(6) <= \<const0>\;
  m_axis_tdata(5) <= \<const0>\;
  m_axis_tdata(4) <= \<const0>\;
  m_axis_tdata(3) <= \<const0>\;
  m_axis_tdata(2) <= \<const0>\;
  m_axis_tdata(1) <= \<const0>\;
  m_axis_tdata(0) <= \<const0>\;
  m_axis_tdest(0) <= \<const0>\;
  m_axis_tid(0) <= \<const0>\;
  m_axis_tkeep(0) <= \<const0>\;
  m_axis_tlast <= \<const0>\;
  m_axis_tstrb(0) <= \<const0>\;
  m_axis_tuser(3) <= \<const0>\;
  m_axis_tuser(2) <= \<const0>\;
  m_axis_tuser(1) <= \<const0>\;
  m_axis_tuser(0) <= \<const0>\;
  m_axis_tvalid <= \<const0>\;
  overflow <= \<const0>\;
  prog_empty <= \<const1>\;
  prog_full <= \<const0>\;
  rd_data_count(9) <= \<const0>\;
  rd_data_count(8) <= \<const0>\;
  rd_data_count(7) <= \<const0>\;
  rd_data_count(6) <= \<const0>\;
  rd_data_count(5) <= \<const0>\;
  rd_data_count(4) <= \<const0>\;
  rd_data_count(3) <= \<const0>\;
  rd_data_count(2) <= \<const0>\;
  rd_data_count(1) <= \<const0>\;
  rd_data_count(0) <= \<const0>\;
  rd_rst_busy <= \<const0>\;
  s_axi_arready <= \<const0>\;
  s_axi_bid(0) <= \<const0>\;
  s_axi_buser(0) <= \<const0>\;
  s_axi_rdata(31) <= \<const0>\;
  s_axi_rdata(30) <= \<const0>\;
  s_axi_rdata(29) <= \<const0>\;
  s_axi_rdata(28) <= \<const0>\;
  s_axi_rdata(27) <= \<const0>\;
  s_axi_rdata(26) <= \<const0>\;
  s_axi_rdata(25) <= \<const0>\;
  s_axi_rdata(24) <= \<const0>\;
  s_axi_rdata(23) <= \<const0>\;
  s_axi_rdata(22) <= \<const0>\;
  s_axi_rdata(21) <= \<const0>\;
  s_axi_rdata(20) <= \<const0>\;
  s_axi_rdata(19) <= \<const0>\;
  s_axi_rdata(18) <= \<const0>\;
  s_axi_rdata(17) <= \<const0>\;
  s_axi_rdata(16) <= \<const0>\;
  s_axi_rdata(15) <= \<const0>\;
  s_axi_rdata(14) <= \<const0>\;
  s_axi_rdata(13) <= \<const0>\;
  s_axi_rdata(12) <= \<const0>\;
  s_axi_rdata(11) <= \<const0>\;
  s_axi_rdata(10) <= \<const0>\;
  s_axi_rdata(9) <= \<const0>\;
  s_axi_rdata(8) <= \<const0>\;
  s_axi_rdata(7) <= \<const0>\;
  s_axi_rdata(6) <= \<const0>\;
  s_axi_rdata(5) <= \<const0>\;
  s_axi_rdata(4) <= \<const0>\;
  s_axi_rdata(3) <= \<const0>\;
  s_axi_rdata(2) <= \<const0>\;
  s_axi_rdata(1) <= \<const0>\;
  s_axi_rdata(0) <= \<const0>\;
  s_axi_rid(0) <= \<const0>\;
  s_axi_rlast <= \<const0>\;
  s_axi_rresp(1) <= \<const0>\;
  s_axi_rresp(0) <= \<const0>\;
  s_axi_ruser(0) <= \<const0>\;
  s_axi_rvalid <= \<const0>\;
  s_axis_tready <= \<const0>\;
  sbiterr <= \<const0>\;
  underflow <= \<const0>\;
  valid <= \<const0>\;
  wr_ack <= \<const0>\;
  wr_data_count(9) <= \<const0>\;
  wr_data_count(8) <= \<const0>\;
  wr_data_count(7) <= \<const0>\;
  wr_data_count(6) <= \<const0>\;
  wr_data_count(5) <= \<const0>\;
  wr_data_count(4) <= \<const0>\;
  wr_data_count(3) <= \<const0>\;
  wr_data_count(2) <= \<const0>\;
  wr_data_count(1) <= \<const0>\;
  wr_data_count(0) <= \<const0>\;
  wr_rst_busy <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
inst_fifo_gen: entity work.t_axi4_lite32_w_afifo_d64fifo_generator_v11_0_synth
    port map (
      DI(34 downto 3) => s_axi_awaddr(31 downto 0),
      DI(2 downto 0) => s_axi_awprot(2 downto 0),
      I6(35 downto 4) => s_axi_wdata(31 downto 0),
      I6(3 downto 0) => s_axi_wstrb(3 downto 0),
      O1(35 downto 4) => m_axi_wdata(31 downto 0),
      O1(3 downto 0) => m_axi_wstrb(3 downto 0),
      Q(34 downto 3) => m_axi_awaddr(31 downto 0),
      Q(2 downto 0) => m_axi_awprot(2 downto 0),
      axi_aw_overflow => axi_aw_overflow,
      axi_b_overflow => axi_b_overflow,
      axi_w_overflow => axi_w_overflow,
      m_aclk => m_aclk,
      m_axi_awready => m_axi_awready,
      m_axi_awvalid => m_axi_awvalid,
      m_axi_bready => m_axi_bready,
      m_axi_bresp(1 downto 0) => m_axi_bresp(1 downto 0),
      m_axi_bvalid => m_axi_bvalid,
      m_axi_wready => m_axi_wready,
      m_axi_wvalid => m_axi_wvalid,
      s_aclk => s_aclk,
      s_aresetn => s_aresetn,
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid => s_axi_bvalid,
      s_axi_wready => s_axi_wready,
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity t_axi4_lite32_w_afifo_d64 is
  port (
    m_aclk : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    axi_aw_overflow : out STD_LOGIC;
    axi_w_overflow : out STD_LOGIC;
    axi_b_overflow : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of t_axi4_lite32_w_afifo_d64 : entity is true;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of t_axi4_lite32_w_afifo_d64 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of t_axi4_lite32_w_afifo_d64 : entity is "fifo_generator_v11_0,Vivado 2013.4";
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of t_axi4_lite32_w_afifo_d64 : entity is "t_axi4_lite32_w_afifo_d64,fifo_generator_v11_0,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of t_axi4_lite32_w_afifo_d64 : entity is "t_axi4_lite32_w_afifo_d64,fifo_generator_v11_0,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=fifo_generator,x_ipVersion=11.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,C_COMMON_CLOCK=0,C_COUNT_TYPE=0,C_DATA_COUNT_WIDTH=10,C_DEFAULT_VALUE=BlankString,C_DIN_WIDTH=18,C_DOUT_RST_VAL=0,C_DOUT_WIDTH=18,C_ENABLE_RLOCS=0,C_FAMILY=kintex7,C_FULL_FLAGS_RST_VAL=1,C_HAS_ALMOST_EMPTY=0,C_HAS_ALMOST_FULL=0,C_HAS_BACKUP=0,C_HAS_DATA_COUNT=0,C_HAS_INT_CLK=0,C_HAS_MEMINIT_FILE=0,C_HAS_OVERFLOW=1,C_HAS_RD_DATA_COUNT=0,C_HAS_RD_RST=0,C_HAS_RST=1,C_HAS_SRST=0,C_HAS_UNDERFLOW=0,C_HAS_VALID=0,C_HAS_WR_ACK=0,C_HAS_WR_DATA_COUNT=0,C_HAS_WR_RST=0,C_IMPLEMENTATION_TYPE=0,C_INIT_WR_PNTR_VAL=0,C_MEMORY_TYPE=1,C_MIF_FILE_NAME=BlankString,C_OPTIMIZATION_MODE=0,C_OVERFLOW_LOW=0,C_PRELOAD_LATENCY=1,C_PRELOAD_REGS=0,C_PRIM_FIFO_TYPE=4kx4,C_PROG_EMPTY_THRESH_ASSERT_VAL=2,C_PROG_EMPTY_THRESH_NEGATE_VAL=3,C_PROG_EMPTY_TYPE=0,C_PROG_FULL_THRESH_ASSERT_VAL=1022,C_PROG_FULL_THRESH_NEGATE_VAL=1021,C_PROG_FULL_TYPE=0,C_RD_DATA_COUNT_WIDTH=10,C_RD_DEPTH=1024,C_RD_FREQ=1,C_RD_PNTR_WIDTH=10,C_UNDERFLOW_LOW=0,C_USE_DOUT_RST=1,C_USE_ECC=0,C_USE_EMBEDDED_REG=0,C_USE_FIFO16_FLAGS=0,C_USE_FWFT_DATA_COUNT=0,C_VALID_LOW=0,C_WR_ACK_LOW=0,C_WR_DATA_COUNT_WIDTH=10,C_WR_DEPTH=1024,C_WR_FREQ=1,C_WR_PNTR_WIDTH=10,C_WR_RESPONSE_LATENCY=1,C_MSGON_VAL=1,C_ENABLE_RST_SYNC=1,C_ERROR_INJECTION_TYPE=0,C_SYNCHRONIZER_STAGE=2,C_INTERFACE_TYPE=2,C_AXI_TYPE=2,C_HAS_AXI_WR_CHANNEL=1,C_HAS_AXI_RD_CHANNEL=0,C_HAS_SLAVE_CE=0,C_HAS_MASTER_CE=0,C_ADD_NGC_CONSTRAINT=0,C_USE_COMMON_OVERFLOW=0,C_USE_COMMON_UNDERFLOW=0,C_USE_DEFAULT_SETTINGS=0,C_AXI_ID_WIDTH=1,C_AXI_ADDR_WIDTH=32,C_AXI_DATA_WIDTH=32,C_HAS_AXI_AWUSER=0,C_HAS_AXI_WUSER=0,C_HAS_AXI_BUSER=0,C_HAS_AXI_ARUSER=0,C_HAS_AXI_RUSER=0,C_AXI_ARUSER_WIDTH=1,C_AXI_AWUSER_WIDTH=1,C_AXI_WUSER_WIDTH=1,C_AXI_BUSER_WIDTH=1,C_AXI_RUSER_WIDTH=1,C_HAS_AXI_ID=0,C_HAS_AXIS_TDATA=1,C_HAS_AXIS_TID=0,C_HAS_AXIS_TDEST=0,C_HAS_AXIS_TUSER=1,C_HAS_AXIS_TREADY=1,C_HAS_AXIS_TLAST=0,C_HAS_AXIS_TSTRB=0,C_HAS_AXIS_TKEEP=0,C_AXIS_TDATA_WIDTH=8,C_AXIS_TID_WIDTH=1,C_AXIS_TDEST_WIDTH=1,C_AXIS_TUSER_WIDTH=4,C_AXIS_TSTRB_WIDTH=1,C_AXIS_TKEEP_WIDTH=1,C_WACH_TYPE=0,C_WDCH_TYPE=0,C_WRCH_TYPE=0,C_RACH_TYPE=0,C_RDCH_TYPE=0,C_AXIS_TYPE=0,C_IMPLEMENTATION_TYPE_WACH=12,C_IMPLEMENTATION_TYPE_WDCH=12,C_IMPLEMENTATION_TYPE_WRCH=12,C_IMPLEMENTATION_TYPE_RACH=12,C_IMPLEMENTATION_TYPE_RDCH=11,C_IMPLEMENTATION_TYPE_AXIS=11,C_APPLICATION_TYPE_WACH=0,C_APPLICATION_TYPE_WDCH=0,C_APPLICATION_TYPE_WRCH=0,C_APPLICATION_TYPE_RACH=0,C_APPLICATION_TYPE_RDCH=0,C_APPLICATION_TYPE_AXIS=0,C_PRIM_FIFO_TYPE_WACH=512x36,C_PRIM_FIFO_TYPE_WDCH=512x36,C_PRIM_FIFO_TYPE_WRCH=512x36,C_PRIM_FIFO_TYPE_RACH=512x36,C_PRIM_FIFO_TYPE_RDCH=1kx36,C_PRIM_FIFO_TYPE_AXIS=1kx18,C_USE_ECC_WACH=0,C_USE_ECC_WDCH=0,C_USE_ECC_WRCH=0,C_USE_ECC_RACH=0,C_USE_ECC_RDCH=0,C_USE_ECC_AXIS=0,C_ERROR_INJECTION_TYPE_WACH=0,C_ERROR_INJECTION_TYPE_WDCH=0,C_ERROR_INJECTION_TYPE_WRCH=0,C_ERROR_INJECTION_TYPE_RACH=0,C_ERROR_INJECTION_TYPE_RDCH=0,C_ERROR_INJECTION_TYPE_AXIS=0,C_DIN_WIDTH_WACH=35,C_DIN_WIDTH_WDCH=36,C_DIN_WIDTH_WRCH=2,C_DIN_WIDTH_RACH=35,C_DIN_WIDTH_RDCH=34,C_DIN_WIDTH_AXIS=1,C_WR_DEPTH_WACH=64,C_WR_DEPTH_WDCH=64,C_WR_DEPTH_WRCH=64,C_WR_DEPTH_RACH=16,C_WR_DEPTH_RDCH=1024,C_WR_DEPTH_AXIS=1024,C_WR_PNTR_WIDTH_WACH=6,C_WR_PNTR_WIDTH_WDCH=6,C_WR_PNTR_WIDTH_WRCH=6,C_WR_PNTR_WIDTH_RACH=4,C_WR_PNTR_WIDTH_RDCH=10,C_WR_PNTR_WIDTH_AXIS=10,C_HAS_DATA_COUNTS_WACH=0,C_HAS_DATA_COUNTS_WDCH=0,C_HAS_DATA_COUNTS_WRCH=0,C_HAS_DATA_COUNTS_RACH=0,C_HAS_DATA_COUNTS_RDCH=0,C_HAS_DATA_COUNTS_AXIS=0,C_HAS_PROG_FLAGS_WACH=0,C_HAS_PROG_FLAGS_WDCH=0,C_HAS_PROG_FLAGS_WRCH=0,C_HAS_PROG_FLAGS_RACH=0,C_HAS_PROG_FLAGS_RDCH=0,C_HAS_PROG_FLAGS_AXIS=0,C_PROG_FULL_TYPE_WACH=0,C_PROG_FULL_TYPE_WDCH=0,C_PROG_FULL_TYPE_WRCH=0,C_PROG_FULL_TYPE_RACH=0,C_PROG_FULL_TYPE_RDCH=0,C_PROG_FULL_TYPE_AXIS=0,C_PROG_FULL_THRESH_ASSERT_VAL_WACH=63,C_PROG_FULL_THRESH_ASSERT_VAL_WDCH=63,C_PROG_FULL_THRESH_ASSERT_VAL_WRCH=63,C_PROG_FULL_THRESH_ASSERT_VAL_RACH=15,C_PROG_FULL_THRESH_ASSERT_VAL_RDCH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_AXIS=1023,C_PROG_EMPTY_TYPE_WACH=0,C_PROG_EMPTY_TYPE_WDCH=0,C_PROG_EMPTY_TYPE_WRCH=0,C_PROG_EMPTY_TYPE_RACH=0,C_PROG_EMPTY_TYPE_RDCH=0,C_PROG_EMPTY_TYPE_AXIS=0,C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH=61,C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH=61,C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH=61,C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH=13,C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH=1021,C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS=1021,C_REG_SLICE_MODE_WACH=0,C_REG_SLICE_MODE_WDCH=0,C_REG_SLICE_MODE_WRCH=0,C_REG_SLICE_MODE_RACH=0,C_REG_SLICE_MODE_RDCH=0,C_REG_SLICE_MODE_AXIS=0,C_AXI_LEN_WIDTH=4,C_AXI_LOCK_WIDTH=2}";
end t_axi4_lite32_w_afifo_d64;

architecture STRUCTURE of t_axi4_lite32_w_afifo_d64 is
  signal \<const0>\ : STD_LOGIC;
  signal NLW_U0_almost_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_almost_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_overflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_aw_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_aw_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_aw_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_aw_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_aw_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_b_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_b_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_b_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_b_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_b_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_overflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_r_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_w_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_w_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_w_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_w_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_w_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_overflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axis_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axi_arvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axi_rready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axi_wlast_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axis_tlast_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_m_axis_tvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_overflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_rd_rst_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_arready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rlast_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axis_tready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_valid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_wr_ack_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_wr_rst_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_axi_ar_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_ar_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_ar_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_U0_axi_aw_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_U0_axi_aw_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_U0_axi_aw_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_U0_axi_b_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_U0_axi_b_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_U0_axi_b_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_U0_axi_r_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axi_r_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axi_r_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axi_w_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_U0_axi_w_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_U0_axi_w_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_U0_axis_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axis_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_axis_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal NLW_U0_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal NLW_U0_dout_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_U0_m_axi_araddr_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_m_axi_arburst_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_m_axi_arcache_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_arid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_arlen_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_arlock_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_m_axi_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_U0_m_axi_arqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_arregion_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_arsize_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_U0_m_axi_aruser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_awburst_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_m_axi_awcache_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_awid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_awlen_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_awlock_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_m_axi_awqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_awregion_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_m_axi_awsize_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_U0_m_axi_awuser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_wid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axi_wuser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axis_tdata_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_U0_m_axis_tdest_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axis_tid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axis_tkeep_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axis_tstrb_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_m_axis_tuser_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal NLW_U0_s_axi_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_s_axi_buser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_s_axi_rdata_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_s_axi_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_s_axi_rresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_s_axi_ruser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 9 downto 0 );
  attribute C_ADD_NGC_CONSTRAINT : integer;
  attribute C_ADD_NGC_CONSTRAINT of U0 : label is 0;
  attribute C_APPLICATION_TYPE_AXIS : integer;
  attribute C_APPLICATION_TYPE_AXIS of U0 : label is 0;
  attribute C_APPLICATION_TYPE_RACH : integer;
  attribute C_APPLICATION_TYPE_RACH of U0 : label is 0;
  attribute C_APPLICATION_TYPE_RDCH : integer;
  attribute C_APPLICATION_TYPE_RDCH of U0 : label is 0;
  attribute C_APPLICATION_TYPE_WACH : integer;
  attribute C_APPLICATION_TYPE_WACH of U0 : label is 0;
  attribute C_APPLICATION_TYPE_WDCH : integer;
  attribute C_APPLICATION_TYPE_WDCH of U0 : label is 0;
  attribute C_APPLICATION_TYPE_WRCH : integer;
  attribute C_APPLICATION_TYPE_WRCH of U0 : label is 0;
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of U0 : label is 8;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of U0 : label is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of U0 : label is 1;
  attribute C_AXIS_TKEEP_WIDTH : integer;
  attribute C_AXIS_TKEEP_WIDTH of U0 : label is 1;
  attribute C_AXIS_TSTRB_WIDTH : integer;
  attribute C_AXIS_TSTRB_WIDTH of U0 : label is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of U0 : label is 4;
  attribute C_AXIS_TYPE : integer;
  attribute C_AXIS_TYPE of U0 : label is 0;
  attribute C_AXI_ADDR_WIDTH : integer;
  attribute C_AXI_ADDR_WIDTH of U0 : label is 32;
  attribute C_AXI_ARUSER_WIDTH : integer;
  attribute C_AXI_ARUSER_WIDTH of U0 : label is 1;
  attribute C_AXI_AWUSER_WIDTH : integer;
  attribute C_AXI_AWUSER_WIDTH of U0 : label is 1;
  attribute C_AXI_BUSER_WIDTH : integer;
  attribute C_AXI_BUSER_WIDTH of U0 : label is 1;
  attribute C_AXI_DATA_WIDTH : integer;
  attribute C_AXI_DATA_WIDTH of U0 : label is 32;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of U0 : label is 1;
  attribute C_AXI_LEN_WIDTH : integer;
  attribute C_AXI_LEN_WIDTH of U0 : label is 4;
  attribute C_AXI_LOCK_WIDTH : integer;
  attribute C_AXI_LOCK_WIDTH of U0 : label is 2;
  attribute C_AXI_RUSER_WIDTH : integer;
  attribute C_AXI_RUSER_WIDTH of U0 : label is 1;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of U0 : label is 2;
  attribute C_AXI_WUSER_WIDTH : integer;
  attribute C_AXI_WUSER_WIDTH of U0 : label is 1;
  attribute C_COMMON_CLOCK : integer;
  attribute C_COMMON_CLOCK of U0 : label is 0;
  attribute C_COUNT_TYPE : integer;
  attribute C_COUNT_TYPE of U0 : label is 0;
  attribute C_DATA_COUNT_WIDTH : integer;
  attribute C_DATA_COUNT_WIDTH of U0 : label is 10;
  attribute C_DEFAULT_VALUE : string;
  attribute C_DEFAULT_VALUE of U0 : label is "BlankString";
  attribute C_DIN_WIDTH : integer;
  attribute C_DIN_WIDTH of U0 : label is 18;
  attribute C_DIN_WIDTH_AXIS : integer;
  attribute C_DIN_WIDTH_AXIS of U0 : label is 1;
  attribute C_DIN_WIDTH_RACH : integer;
  attribute C_DIN_WIDTH_RACH of U0 : label is 35;
  attribute C_DIN_WIDTH_RDCH : integer;
  attribute C_DIN_WIDTH_RDCH of U0 : label is 34;
  attribute C_DIN_WIDTH_WACH : integer;
  attribute C_DIN_WIDTH_WACH of U0 : label is 35;
  attribute C_DIN_WIDTH_WDCH : integer;
  attribute C_DIN_WIDTH_WDCH of U0 : label is 36;
  attribute C_DIN_WIDTH_WRCH : integer;
  attribute C_DIN_WIDTH_WRCH of U0 : label is 2;
  attribute C_DOUT_RST_VAL : string;
  attribute C_DOUT_RST_VAL of U0 : label is "0";
  attribute C_DOUT_WIDTH : integer;
  attribute C_DOUT_WIDTH of U0 : label is 18;
  attribute C_ENABLE_RLOCS : integer;
  attribute C_ENABLE_RLOCS of U0 : label is 0;
  attribute C_ENABLE_RST_SYNC : integer;
  attribute C_ENABLE_RST_SYNC of U0 : label is 1;
  attribute C_ERROR_INJECTION_TYPE : integer;
  attribute C_ERROR_INJECTION_TYPE of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_AXIS : integer;
  attribute C_ERROR_INJECTION_TYPE_AXIS of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_RACH : integer;
  attribute C_ERROR_INJECTION_TYPE_RACH of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_RDCH : integer;
  attribute C_ERROR_INJECTION_TYPE_RDCH of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_WACH : integer;
  attribute C_ERROR_INJECTION_TYPE_WACH of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_WDCH : integer;
  attribute C_ERROR_INJECTION_TYPE_WDCH of U0 : label is 0;
  attribute C_ERROR_INJECTION_TYPE_WRCH : integer;
  attribute C_ERROR_INJECTION_TYPE_WRCH of U0 : label is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "kintex7";
  attribute C_FULL_FLAGS_RST_VAL : integer;
  attribute C_FULL_FLAGS_RST_VAL of U0 : label is 1;
  attribute C_HAS_ALMOST_EMPTY : integer;
  attribute C_HAS_ALMOST_EMPTY of U0 : label is 0;
  attribute C_HAS_ALMOST_FULL : integer;
  attribute C_HAS_ALMOST_FULL of U0 : label is 0;
  attribute C_HAS_AXIS_TDATA : integer;
  attribute C_HAS_AXIS_TDATA of U0 : label is 1;
  attribute C_HAS_AXIS_TDEST : integer;
  attribute C_HAS_AXIS_TDEST of U0 : label is 0;
  attribute C_HAS_AXIS_TID : integer;
  attribute C_HAS_AXIS_TID of U0 : label is 0;
  attribute C_HAS_AXIS_TKEEP : integer;
  attribute C_HAS_AXIS_TKEEP of U0 : label is 0;
  attribute C_HAS_AXIS_TLAST : integer;
  attribute C_HAS_AXIS_TLAST of U0 : label is 0;
  attribute C_HAS_AXIS_TREADY : integer;
  attribute C_HAS_AXIS_TREADY of U0 : label is 1;
  attribute C_HAS_AXIS_TSTRB : integer;
  attribute C_HAS_AXIS_TSTRB of U0 : label is 0;
  attribute C_HAS_AXIS_TUSER : integer;
  attribute C_HAS_AXIS_TUSER of U0 : label is 1;
  attribute C_HAS_AXI_ARUSER : integer;
  attribute C_HAS_AXI_ARUSER of U0 : label is 0;
  attribute C_HAS_AXI_AWUSER : integer;
  attribute C_HAS_AXI_AWUSER of U0 : label is 0;
  attribute C_HAS_AXI_BUSER : integer;
  attribute C_HAS_AXI_BUSER of U0 : label is 0;
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of U0 : label is 0;
  attribute C_HAS_AXI_RD_CHANNEL : integer;
  attribute C_HAS_AXI_RD_CHANNEL of U0 : label is 0;
  attribute C_HAS_AXI_RUSER : integer;
  attribute C_HAS_AXI_RUSER of U0 : label is 0;
  attribute C_HAS_AXI_WR_CHANNEL : integer;
  attribute C_HAS_AXI_WR_CHANNEL of U0 : label is 1;
  attribute C_HAS_AXI_WUSER : integer;
  attribute C_HAS_AXI_WUSER of U0 : label is 0;
  attribute C_HAS_BACKUP : integer;
  attribute C_HAS_BACKUP of U0 : label is 0;
  attribute C_HAS_DATA_COUNT : integer;
  attribute C_HAS_DATA_COUNT of U0 : label is 0;
  attribute C_HAS_DATA_COUNTS_AXIS : integer;
  attribute C_HAS_DATA_COUNTS_AXIS of U0 : label is 0;
  attribute C_HAS_DATA_COUNTS_RACH : integer;
  attribute C_HAS_DATA_COUNTS_RACH of U0 : label is 0;
  attribute C_HAS_DATA_COUNTS_RDCH : integer;
  attribute C_HAS_DATA_COUNTS_RDCH of U0 : label is 0;
  attribute C_HAS_DATA_COUNTS_WACH : integer;
  attribute C_HAS_DATA_COUNTS_WACH of U0 : label is 0;
  attribute C_HAS_DATA_COUNTS_WDCH : integer;
  attribute C_HAS_DATA_COUNTS_WDCH of U0 : label is 0;
  attribute C_HAS_DATA_COUNTS_WRCH : integer;
  attribute C_HAS_DATA_COUNTS_WRCH of U0 : label is 0;
  attribute C_HAS_INT_CLK : integer;
  attribute C_HAS_INT_CLK of U0 : label is 0;
  attribute C_HAS_MASTER_CE : integer;
  attribute C_HAS_MASTER_CE of U0 : label is 0;
  attribute C_HAS_MEMINIT_FILE : integer;
  attribute C_HAS_MEMINIT_FILE of U0 : label is 0;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of U0 : label is 1;
  attribute C_HAS_PROG_FLAGS_AXIS : integer;
  attribute C_HAS_PROG_FLAGS_AXIS of U0 : label is 0;
  attribute C_HAS_PROG_FLAGS_RACH : integer;
  attribute C_HAS_PROG_FLAGS_RACH of U0 : label is 0;
  attribute C_HAS_PROG_FLAGS_RDCH : integer;
  attribute C_HAS_PROG_FLAGS_RDCH of U0 : label is 0;
  attribute C_HAS_PROG_FLAGS_WACH : integer;
  attribute C_HAS_PROG_FLAGS_WACH of U0 : label is 0;
  attribute C_HAS_PROG_FLAGS_WDCH : integer;
  attribute C_HAS_PROG_FLAGS_WDCH of U0 : label is 0;
  attribute C_HAS_PROG_FLAGS_WRCH : integer;
  attribute C_HAS_PROG_FLAGS_WRCH of U0 : label is 0;
  attribute C_HAS_RD_DATA_COUNT : integer;
  attribute C_HAS_RD_DATA_COUNT of U0 : label is 0;
  attribute C_HAS_RD_RST : integer;
  attribute C_HAS_RD_RST of U0 : label is 0;
  attribute C_HAS_RST : integer;
  attribute C_HAS_RST of U0 : label is 1;
  attribute C_HAS_SLAVE_CE : integer;
  attribute C_HAS_SLAVE_CE of U0 : label is 0;
  attribute C_HAS_SRST : integer;
  attribute C_HAS_SRST of U0 : label is 0;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of U0 : label is 0;
  attribute C_HAS_VALID : integer;
  attribute C_HAS_VALID of U0 : label is 0;
  attribute C_HAS_WR_ACK : integer;
  attribute C_HAS_WR_ACK of U0 : label is 0;
  attribute C_HAS_WR_DATA_COUNT : integer;
  attribute C_HAS_WR_DATA_COUNT of U0 : label is 0;
  attribute C_HAS_WR_RST : integer;
  attribute C_HAS_WR_RST of U0 : label is 0;
  attribute C_IMPLEMENTATION_TYPE : integer;
  attribute C_IMPLEMENTATION_TYPE of U0 : label is 0;
  attribute C_IMPLEMENTATION_TYPE_AXIS : integer;
  attribute C_IMPLEMENTATION_TYPE_AXIS of U0 : label is 11;
  attribute C_IMPLEMENTATION_TYPE_RACH : integer;
  attribute C_IMPLEMENTATION_TYPE_RACH of U0 : label is 12;
  attribute C_IMPLEMENTATION_TYPE_RDCH : integer;
  attribute C_IMPLEMENTATION_TYPE_RDCH of U0 : label is 11;
  attribute C_IMPLEMENTATION_TYPE_WACH : integer;
  attribute C_IMPLEMENTATION_TYPE_WACH of U0 : label is 12;
  attribute C_IMPLEMENTATION_TYPE_WDCH : integer;
  attribute C_IMPLEMENTATION_TYPE_WDCH of U0 : label is 12;
  attribute C_IMPLEMENTATION_TYPE_WRCH : integer;
  attribute C_IMPLEMENTATION_TYPE_WRCH of U0 : label is 12;
  attribute C_INIT_WR_PNTR_VAL : integer;
  attribute C_INIT_WR_PNTR_VAL of U0 : label is 0;
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of U0 : label is 2;
  attribute C_MEMORY_TYPE : integer;
  attribute C_MEMORY_TYPE of U0 : label is 1;
  attribute C_MIF_FILE_NAME : string;
  attribute C_MIF_FILE_NAME of U0 : label is "BlankString";
  attribute C_MSGON_VAL : integer;
  attribute C_MSGON_VAL of U0 : label is 1;
  attribute C_OPTIMIZATION_MODE : integer;
  attribute C_OPTIMIZATION_MODE of U0 : label is 0;
  attribute C_OVERFLOW_LOW : integer;
  attribute C_OVERFLOW_LOW of U0 : label is 0;
  attribute C_PRELOAD_LATENCY : integer;
  attribute C_PRELOAD_LATENCY of U0 : label is 1;
  attribute C_PRELOAD_REGS : integer;
  attribute C_PRELOAD_REGS of U0 : label is 0;
  attribute C_PRIM_FIFO_TYPE : string;
  attribute C_PRIM_FIFO_TYPE of U0 : label is "4kx4";
  attribute C_PRIM_FIFO_TYPE_AXIS : string;
  attribute C_PRIM_FIFO_TYPE_AXIS of U0 : label is "1kx18";
  attribute C_PRIM_FIFO_TYPE_RACH : string;
  attribute C_PRIM_FIFO_TYPE_RACH of U0 : label is "512x36";
  attribute C_PRIM_FIFO_TYPE_RDCH : string;
  attribute C_PRIM_FIFO_TYPE_RDCH of U0 : label is "1kx36";
  attribute C_PRIM_FIFO_TYPE_WACH : string;
  attribute C_PRIM_FIFO_TYPE_WACH of U0 : label is "512x36";
  attribute C_PRIM_FIFO_TYPE_WDCH : string;
  attribute C_PRIM_FIFO_TYPE_WDCH of U0 : label is "512x36";
  attribute C_PRIM_FIFO_TYPE_WRCH : string;
  attribute C_PRIM_FIFO_TYPE_WRCH of U0 : label is "512x36";
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL of U0 : label is 2;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS of U0 : label is 1021;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH of U0 : label is 13;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH of U0 : label is 1021;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH of U0 : label is 61;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH of U0 : label is 61;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH : integer;
  attribute C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH of U0 : label is 61;
  attribute C_PROG_EMPTY_THRESH_NEGATE_VAL : integer;
  attribute C_PROG_EMPTY_THRESH_NEGATE_VAL of U0 : label is 3;
  attribute C_PROG_EMPTY_TYPE : integer;
  attribute C_PROG_EMPTY_TYPE of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_AXIS : integer;
  attribute C_PROG_EMPTY_TYPE_AXIS of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_RACH : integer;
  attribute C_PROG_EMPTY_TYPE_RACH of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_RDCH : integer;
  attribute C_PROG_EMPTY_TYPE_RDCH of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_WACH : integer;
  attribute C_PROG_EMPTY_TYPE_WACH of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_WDCH : integer;
  attribute C_PROG_EMPTY_TYPE_WDCH of U0 : label is 0;
  attribute C_PROG_EMPTY_TYPE_WRCH : integer;
  attribute C_PROG_EMPTY_TYPE_WRCH of U0 : label is 0;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL of U0 : label is 1022;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_AXIS : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_AXIS of U0 : label is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RACH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RACH of U0 : label is 15;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RDCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_RDCH of U0 : label is 1023;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WACH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WACH of U0 : label is 63;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WDCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WDCH of U0 : label is 63;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WRCH : integer;
  attribute C_PROG_FULL_THRESH_ASSERT_VAL_WRCH of U0 : label is 63;
  attribute C_PROG_FULL_THRESH_NEGATE_VAL : integer;
  attribute C_PROG_FULL_THRESH_NEGATE_VAL of U0 : label is 1021;
  attribute C_PROG_FULL_TYPE : integer;
  attribute C_PROG_FULL_TYPE of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_AXIS : integer;
  attribute C_PROG_FULL_TYPE_AXIS of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_RACH : integer;
  attribute C_PROG_FULL_TYPE_RACH of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_RDCH : integer;
  attribute C_PROG_FULL_TYPE_RDCH of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_WACH : integer;
  attribute C_PROG_FULL_TYPE_WACH of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_WDCH : integer;
  attribute C_PROG_FULL_TYPE_WDCH of U0 : label is 0;
  attribute C_PROG_FULL_TYPE_WRCH : integer;
  attribute C_PROG_FULL_TYPE_WRCH of U0 : label is 0;
  attribute C_RACH_TYPE : integer;
  attribute C_RACH_TYPE of U0 : label is 0;
  attribute C_RDCH_TYPE : integer;
  attribute C_RDCH_TYPE of U0 : label is 0;
  attribute C_RD_DATA_COUNT_WIDTH : integer;
  attribute C_RD_DATA_COUNT_WIDTH of U0 : label is 10;
  attribute C_RD_DEPTH : integer;
  attribute C_RD_DEPTH of U0 : label is 1024;
  attribute C_RD_FREQ : integer;
  attribute C_RD_FREQ of U0 : label is 1;
  attribute C_RD_PNTR_WIDTH : integer;
  attribute C_RD_PNTR_WIDTH of U0 : label is 10;
  attribute C_REG_SLICE_MODE_AXIS : integer;
  attribute C_REG_SLICE_MODE_AXIS of U0 : label is 0;
  attribute C_REG_SLICE_MODE_RACH : integer;
  attribute C_REG_SLICE_MODE_RACH of U0 : label is 0;
  attribute C_REG_SLICE_MODE_RDCH : integer;
  attribute C_REG_SLICE_MODE_RDCH of U0 : label is 0;
  attribute C_REG_SLICE_MODE_WACH : integer;
  attribute C_REG_SLICE_MODE_WACH of U0 : label is 0;
  attribute C_REG_SLICE_MODE_WDCH : integer;
  attribute C_REG_SLICE_MODE_WDCH of U0 : label is 0;
  attribute C_REG_SLICE_MODE_WRCH : integer;
  attribute C_REG_SLICE_MODE_WRCH of U0 : label is 0;
  attribute C_SYNCHRONIZER_STAGE : integer;
  attribute C_SYNCHRONIZER_STAGE of U0 : label is 2;
  attribute C_UNDERFLOW_LOW : integer;
  attribute C_UNDERFLOW_LOW of U0 : label is 0;
  attribute C_USE_COMMON_OVERFLOW : integer;
  attribute C_USE_COMMON_OVERFLOW of U0 : label is 0;
  attribute C_USE_COMMON_UNDERFLOW : integer;
  attribute C_USE_COMMON_UNDERFLOW of U0 : label is 0;
  attribute C_USE_DEFAULT_SETTINGS : integer;
  attribute C_USE_DEFAULT_SETTINGS of U0 : label is 0;
  attribute C_USE_DOUT_RST : integer;
  attribute C_USE_DOUT_RST of U0 : label is 1;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of U0 : label is 0;
  attribute C_USE_ECC_AXIS : integer;
  attribute C_USE_ECC_AXIS of U0 : label is 0;
  attribute C_USE_ECC_RACH : integer;
  attribute C_USE_ECC_RACH of U0 : label is 0;
  attribute C_USE_ECC_RDCH : integer;
  attribute C_USE_ECC_RDCH of U0 : label is 0;
  attribute C_USE_ECC_WACH : integer;
  attribute C_USE_ECC_WACH of U0 : label is 0;
  attribute C_USE_ECC_WDCH : integer;
  attribute C_USE_ECC_WDCH of U0 : label is 0;
  attribute C_USE_ECC_WRCH : integer;
  attribute C_USE_ECC_WRCH of U0 : label is 0;
  attribute C_USE_EMBEDDED_REG : integer;
  attribute C_USE_EMBEDDED_REG of U0 : label is 0;
  attribute C_USE_FIFO16_FLAGS : integer;
  attribute C_USE_FIFO16_FLAGS of U0 : label is 0;
  attribute C_USE_FWFT_DATA_COUNT : integer;
  attribute C_USE_FWFT_DATA_COUNT of U0 : label is 0;
  attribute C_VALID_LOW : integer;
  attribute C_VALID_LOW of U0 : label is 0;
  attribute C_WACH_TYPE : integer;
  attribute C_WACH_TYPE of U0 : label is 0;
  attribute C_WDCH_TYPE : integer;
  attribute C_WDCH_TYPE of U0 : label is 0;
  attribute C_WRCH_TYPE : integer;
  attribute C_WRCH_TYPE of U0 : label is 0;
  attribute C_WR_ACK_LOW : integer;
  attribute C_WR_ACK_LOW of U0 : label is 0;
  attribute C_WR_DATA_COUNT_WIDTH : integer;
  attribute C_WR_DATA_COUNT_WIDTH of U0 : label is 10;
  attribute C_WR_DEPTH : integer;
  attribute C_WR_DEPTH of U0 : label is 1024;
  attribute C_WR_DEPTH_AXIS : integer;
  attribute C_WR_DEPTH_AXIS of U0 : label is 1024;
  attribute C_WR_DEPTH_RACH : integer;
  attribute C_WR_DEPTH_RACH of U0 : label is 16;
  attribute C_WR_DEPTH_RDCH : integer;
  attribute C_WR_DEPTH_RDCH of U0 : label is 1024;
  attribute C_WR_DEPTH_WACH : integer;
  attribute C_WR_DEPTH_WACH of U0 : label is 64;
  attribute C_WR_DEPTH_WDCH : integer;
  attribute C_WR_DEPTH_WDCH of U0 : label is 64;
  attribute C_WR_DEPTH_WRCH : integer;
  attribute C_WR_DEPTH_WRCH of U0 : label is 64;
  attribute C_WR_FREQ : integer;
  attribute C_WR_FREQ of U0 : label is 1;
  attribute C_WR_PNTR_WIDTH : integer;
  attribute C_WR_PNTR_WIDTH of U0 : label is 10;
  attribute C_WR_PNTR_WIDTH_AXIS : integer;
  attribute C_WR_PNTR_WIDTH_AXIS of U0 : label is 10;
  attribute C_WR_PNTR_WIDTH_RACH : integer;
  attribute C_WR_PNTR_WIDTH_RACH of U0 : label is 4;
  attribute C_WR_PNTR_WIDTH_RDCH : integer;
  attribute C_WR_PNTR_WIDTH_RDCH of U0 : label is 10;
  attribute C_WR_PNTR_WIDTH_WACH : integer;
  attribute C_WR_PNTR_WIDTH_WACH of U0 : label is 6;
  attribute C_WR_PNTR_WIDTH_WDCH : integer;
  attribute C_WR_PNTR_WIDTH_WDCH of U0 : label is 6;
  attribute C_WR_PNTR_WIDTH_WRCH : integer;
  attribute C_WR_PNTR_WIDTH_WRCH of U0 : label is 6;
  attribute C_WR_RESPONSE_LATENCY : integer;
  attribute C_WR_RESPONSE_LATENCY of U0 : label is 1;
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
U0: entity work.\t_axi4_lite32_w_afifo_d64fifo_generator_v11_0__parameterized0\
    port map (
      almost_empty => NLW_U0_almost_empty_UNCONNECTED,
      almost_full => NLW_U0_almost_full_UNCONNECTED,
      axi_ar_data_count(4 downto 0) => NLW_U0_axi_ar_data_count_UNCONNECTED(4 downto 0),
      axi_ar_dbiterr => NLW_U0_axi_ar_dbiterr_UNCONNECTED,
      axi_ar_injectdbiterr => \<const0>\,
      axi_ar_injectsbiterr => \<const0>\,
      axi_ar_overflow => NLW_U0_axi_ar_overflow_UNCONNECTED,
      axi_ar_prog_empty => NLW_U0_axi_ar_prog_empty_UNCONNECTED,
      axi_ar_prog_empty_thresh(3) => \<const0>\,
      axi_ar_prog_empty_thresh(2) => \<const0>\,
      axi_ar_prog_empty_thresh(1) => \<const0>\,
      axi_ar_prog_empty_thresh(0) => \<const0>\,
      axi_ar_prog_full => NLW_U0_axi_ar_prog_full_UNCONNECTED,
      axi_ar_prog_full_thresh(3) => \<const0>\,
      axi_ar_prog_full_thresh(2) => \<const0>\,
      axi_ar_prog_full_thresh(1) => \<const0>\,
      axi_ar_prog_full_thresh(0) => \<const0>\,
      axi_ar_rd_data_count(4 downto 0) => NLW_U0_axi_ar_rd_data_count_UNCONNECTED(4 downto 0),
      axi_ar_sbiterr => NLW_U0_axi_ar_sbiterr_UNCONNECTED,
      axi_ar_underflow => NLW_U0_axi_ar_underflow_UNCONNECTED,
      axi_ar_wr_data_count(4 downto 0) => NLW_U0_axi_ar_wr_data_count_UNCONNECTED(4 downto 0),
      axi_aw_data_count(6 downto 0) => NLW_U0_axi_aw_data_count_UNCONNECTED(6 downto 0),
      axi_aw_dbiterr => NLW_U0_axi_aw_dbiterr_UNCONNECTED,
      axi_aw_injectdbiterr => \<const0>\,
      axi_aw_injectsbiterr => \<const0>\,
      axi_aw_overflow => axi_aw_overflow,
      axi_aw_prog_empty => NLW_U0_axi_aw_prog_empty_UNCONNECTED,
      axi_aw_prog_empty_thresh(5) => \<const0>\,
      axi_aw_prog_empty_thresh(4) => \<const0>\,
      axi_aw_prog_empty_thresh(3) => \<const0>\,
      axi_aw_prog_empty_thresh(2) => \<const0>\,
      axi_aw_prog_empty_thresh(1) => \<const0>\,
      axi_aw_prog_empty_thresh(0) => \<const0>\,
      axi_aw_prog_full => NLW_U0_axi_aw_prog_full_UNCONNECTED,
      axi_aw_prog_full_thresh(5) => \<const0>\,
      axi_aw_prog_full_thresh(4) => \<const0>\,
      axi_aw_prog_full_thresh(3) => \<const0>\,
      axi_aw_prog_full_thresh(2) => \<const0>\,
      axi_aw_prog_full_thresh(1) => \<const0>\,
      axi_aw_prog_full_thresh(0) => \<const0>\,
      axi_aw_rd_data_count(6 downto 0) => NLW_U0_axi_aw_rd_data_count_UNCONNECTED(6 downto 0),
      axi_aw_sbiterr => NLW_U0_axi_aw_sbiterr_UNCONNECTED,
      axi_aw_underflow => NLW_U0_axi_aw_underflow_UNCONNECTED,
      axi_aw_wr_data_count(6 downto 0) => NLW_U0_axi_aw_wr_data_count_UNCONNECTED(6 downto 0),
      axi_b_data_count(6 downto 0) => NLW_U0_axi_b_data_count_UNCONNECTED(6 downto 0),
      axi_b_dbiterr => NLW_U0_axi_b_dbiterr_UNCONNECTED,
      axi_b_injectdbiterr => \<const0>\,
      axi_b_injectsbiterr => \<const0>\,
      axi_b_overflow => axi_b_overflow,
      axi_b_prog_empty => NLW_U0_axi_b_prog_empty_UNCONNECTED,
      axi_b_prog_empty_thresh(5) => \<const0>\,
      axi_b_prog_empty_thresh(4) => \<const0>\,
      axi_b_prog_empty_thresh(3) => \<const0>\,
      axi_b_prog_empty_thresh(2) => \<const0>\,
      axi_b_prog_empty_thresh(1) => \<const0>\,
      axi_b_prog_empty_thresh(0) => \<const0>\,
      axi_b_prog_full => NLW_U0_axi_b_prog_full_UNCONNECTED,
      axi_b_prog_full_thresh(5) => \<const0>\,
      axi_b_prog_full_thresh(4) => \<const0>\,
      axi_b_prog_full_thresh(3) => \<const0>\,
      axi_b_prog_full_thresh(2) => \<const0>\,
      axi_b_prog_full_thresh(1) => \<const0>\,
      axi_b_prog_full_thresh(0) => \<const0>\,
      axi_b_rd_data_count(6 downto 0) => NLW_U0_axi_b_rd_data_count_UNCONNECTED(6 downto 0),
      axi_b_sbiterr => NLW_U0_axi_b_sbiterr_UNCONNECTED,
      axi_b_underflow => NLW_U0_axi_b_underflow_UNCONNECTED,
      axi_b_wr_data_count(6 downto 0) => NLW_U0_axi_b_wr_data_count_UNCONNECTED(6 downto 0),
      axi_r_data_count(10 downto 0) => NLW_U0_axi_r_data_count_UNCONNECTED(10 downto 0),
      axi_r_dbiterr => NLW_U0_axi_r_dbiterr_UNCONNECTED,
      axi_r_injectdbiterr => \<const0>\,
      axi_r_injectsbiterr => \<const0>\,
      axi_r_overflow => NLW_U0_axi_r_overflow_UNCONNECTED,
      axi_r_prog_empty => NLW_U0_axi_r_prog_empty_UNCONNECTED,
      axi_r_prog_empty_thresh(9) => \<const0>\,
      axi_r_prog_empty_thresh(8) => \<const0>\,
      axi_r_prog_empty_thresh(7) => \<const0>\,
      axi_r_prog_empty_thresh(6) => \<const0>\,
      axi_r_prog_empty_thresh(5) => \<const0>\,
      axi_r_prog_empty_thresh(4) => \<const0>\,
      axi_r_prog_empty_thresh(3) => \<const0>\,
      axi_r_prog_empty_thresh(2) => \<const0>\,
      axi_r_prog_empty_thresh(1) => \<const0>\,
      axi_r_prog_empty_thresh(0) => \<const0>\,
      axi_r_prog_full => NLW_U0_axi_r_prog_full_UNCONNECTED,
      axi_r_prog_full_thresh(9) => \<const0>\,
      axi_r_prog_full_thresh(8) => \<const0>\,
      axi_r_prog_full_thresh(7) => \<const0>\,
      axi_r_prog_full_thresh(6) => \<const0>\,
      axi_r_prog_full_thresh(5) => \<const0>\,
      axi_r_prog_full_thresh(4) => \<const0>\,
      axi_r_prog_full_thresh(3) => \<const0>\,
      axi_r_prog_full_thresh(2) => \<const0>\,
      axi_r_prog_full_thresh(1) => \<const0>\,
      axi_r_prog_full_thresh(0) => \<const0>\,
      axi_r_rd_data_count(10 downto 0) => NLW_U0_axi_r_rd_data_count_UNCONNECTED(10 downto 0),
      axi_r_sbiterr => NLW_U0_axi_r_sbiterr_UNCONNECTED,
      axi_r_underflow => NLW_U0_axi_r_underflow_UNCONNECTED,
      axi_r_wr_data_count(10 downto 0) => NLW_U0_axi_r_wr_data_count_UNCONNECTED(10 downto 0),
      axi_w_data_count(6 downto 0) => NLW_U0_axi_w_data_count_UNCONNECTED(6 downto 0),
      axi_w_dbiterr => NLW_U0_axi_w_dbiterr_UNCONNECTED,
      axi_w_injectdbiterr => \<const0>\,
      axi_w_injectsbiterr => \<const0>\,
      axi_w_overflow => axi_w_overflow,
      axi_w_prog_empty => NLW_U0_axi_w_prog_empty_UNCONNECTED,
      axi_w_prog_empty_thresh(5) => \<const0>\,
      axi_w_prog_empty_thresh(4) => \<const0>\,
      axi_w_prog_empty_thresh(3) => \<const0>\,
      axi_w_prog_empty_thresh(2) => \<const0>\,
      axi_w_prog_empty_thresh(1) => \<const0>\,
      axi_w_prog_empty_thresh(0) => \<const0>\,
      axi_w_prog_full => NLW_U0_axi_w_prog_full_UNCONNECTED,
      axi_w_prog_full_thresh(5) => \<const0>\,
      axi_w_prog_full_thresh(4) => \<const0>\,
      axi_w_prog_full_thresh(3) => \<const0>\,
      axi_w_prog_full_thresh(2) => \<const0>\,
      axi_w_prog_full_thresh(1) => \<const0>\,
      axi_w_prog_full_thresh(0) => \<const0>\,
      axi_w_rd_data_count(6 downto 0) => NLW_U0_axi_w_rd_data_count_UNCONNECTED(6 downto 0),
      axi_w_sbiterr => NLW_U0_axi_w_sbiterr_UNCONNECTED,
      axi_w_underflow => NLW_U0_axi_w_underflow_UNCONNECTED,
      axi_w_wr_data_count(6 downto 0) => NLW_U0_axi_w_wr_data_count_UNCONNECTED(6 downto 0),
      axis_data_count(10 downto 0) => NLW_U0_axis_data_count_UNCONNECTED(10 downto 0),
      axis_dbiterr => NLW_U0_axis_dbiterr_UNCONNECTED,
      axis_injectdbiterr => \<const0>\,
      axis_injectsbiterr => \<const0>\,
      axis_overflow => NLW_U0_axis_overflow_UNCONNECTED,
      axis_prog_empty => NLW_U0_axis_prog_empty_UNCONNECTED,
      axis_prog_empty_thresh(9) => \<const0>\,
      axis_prog_empty_thresh(8) => \<const0>\,
      axis_prog_empty_thresh(7) => \<const0>\,
      axis_prog_empty_thresh(6) => \<const0>\,
      axis_prog_empty_thresh(5) => \<const0>\,
      axis_prog_empty_thresh(4) => \<const0>\,
      axis_prog_empty_thresh(3) => \<const0>\,
      axis_prog_empty_thresh(2) => \<const0>\,
      axis_prog_empty_thresh(1) => \<const0>\,
      axis_prog_empty_thresh(0) => \<const0>\,
      axis_prog_full => NLW_U0_axis_prog_full_UNCONNECTED,
      axis_prog_full_thresh(9) => \<const0>\,
      axis_prog_full_thresh(8) => \<const0>\,
      axis_prog_full_thresh(7) => \<const0>\,
      axis_prog_full_thresh(6) => \<const0>\,
      axis_prog_full_thresh(5) => \<const0>\,
      axis_prog_full_thresh(4) => \<const0>\,
      axis_prog_full_thresh(3) => \<const0>\,
      axis_prog_full_thresh(2) => \<const0>\,
      axis_prog_full_thresh(1) => \<const0>\,
      axis_prog_full_thresh(0) => \<const0>\,
      axis_rd_data_count(10 downto 0) => NLW_U0_axis_rd_data_count_UNCONNECTED(10 downto 0),
      axis_sbiterr => NLW_U0_axis_sbiterr_UNCONNECTED,
      axis_underflow => NLW_U0_axis_underflow_UNCONNECTED,
      axis_wr_data_count(10 downto 0) => NLW_U0_axis_wr_data_count_UNCONNECTED(10 downto 0),
      backup => \<const0>\,
      backup_marker => \<const0>\,
      clk => \<const0>\,
      data_count(9 downto 0) => NLW_U0_data_count_UNCONNECTED(9 downto 0),
      dbiterr => NLW_U0_dbiterr_UNCONNECTED,
      din(17) => \<const0>\,
      din(16) => \<const0>\,
      din(15) => \<const0>\,
      din(14) => \<const0>\,
      din(13) => \<const0>\,
      din(12) => \<const0>\,
      din(11) => \<const0>\,
      din(10) => \<const0>\,
      din(9) => \<const0>\,
      din(8) => \<const0>\,
      din(7) => \<const0>\,
      din(6) => \<const0>\,
      din(5) => \<const0>\,
      din(4) => \<const0>\,
      din(3) => \<const0>\,
      din(2) => \<const0>\,
      din(1) => \<const0>\,
      din(0) => \<const0>\,
      dout(17 downto 0) => NLW_U0_dout_UNCONNECTED(17 downto 0),
      empty => NLW_U0_empty_UNCONNECTED,
      full => NLW_U0_full_UNCONNECTED,
      injectdbiterr => \<const0>\,
      injectsbiterr => \<const0>\,
      int_clk => \<const0>\,
      m_aclk => m_aclk,
      m_aclk_en => \<const0>\,
      m_axi_araddr(31 downto 0) => NLW_U0_m_axi_araddr_UNCONNECTED(31 downto 0),
      m_axi_arburst(1 downto 0) => NLW_U0_m_axi_arburst_UNCONNECTED(1 downto 0),
      m_axi_arcache(3 downto 0) => NLW_U0_m_axi_arcache_UNCONNECTED(3 downto 0),
      m_axi_arid(0) => NLW_U0_m_axi_arid_UNCONNECTED(0),
      m_axi_arlen(3 downto 0) => NLW_U0_m_axi_arlen_UNCONNECTED(3 downto 0),
      m_axi_arlock(1 downto 0) => NLW_U0_m_axi_arlock_UNCONNECTED(1 downto 0),
      m_axi_arprot(2 downto 0) => NLW_U0_m_axi_arprot_UNCONNECTED(2 downto 0),
      m_axi_arqos(3 downto 0) => NLW_U0_m_axi_arqos_UNCONNECTED(3 downto 0),
      m_axi_arready => \<const0>\,
      m_axi_arregion(3 downto 0) => NLW_U0_m_axi_arregion_UNCONNECTED(3 downto 0),
      m_axi_arsize(2 downto 0) => NLW_U0_m_axi_arsize_UNCONNECTED(2 downto 0),
      m_axi_aruser(0) => NLW_U0_m_axi_aruser_UNCONNECTED(0),
      m_axi_arvalid => NLW_U0_m_axi_arvalid_UNCONNECTED,
      m_axi_awaddr(31 downto 0) => m_axi_awaddr(31 downto 0),
      m_axi_awburst(1 downto 0) => NLW_U0_m_axi_awburst_UNCONNECTED(1 downto 0),
      m_axi_awcache(3 downto 0) => NLW_U0_m_axi_awcache_UNCONNECTED(3 downto 0),
      m_axi_awid(0) => NLW_U0_m_axi_awid_UNCONNECTED(0),
      m_axi_awlen(3 downto 0) => NLW_U0_m_axi_awlen_UNCONNECTED(3 downto 0),
      m_axi_awlock(1 downto 0) => NLW_U0_m_axi_awlock_UNCONNECTED(1 downto 0),
      m_axi_awprot(2 downto 0) => m_axi_awprot(2 downto 0),
      m_axi_awqos(3 downto 0) => NLW_U0_m_axi_awqos_UNCONNECTED(3 downto 0),
      m_axi_awready => m_axi_awready,
      m_axi_awregion(3 downto 0) => NLW_U0_m_axi_awregion_UNCONNECTED(3 downto 0),
      m_axi_awsize(2 downto 0) => NLW_U0_m_axi_awsize_UNCONNECTED(2 downto 0),
      m_axi_awuser(0) => NLW_U0_m_axi_awuser_UNCONNECTED(0),
      m_axi_awvalid => m_axi_awvalid,
      m_axi_bid(0) => \<const0>\,
      m_axi_bready => m_axi_bready,
      m_axi_bresp(1 downto 0) => m_axi_bresp(1 downto 0),
      m_axi_buser(0) => \<const0>\,
      m_axi_bvalid => m_axi_bvalid,
      m_axi_rdata(31) => \<const0>\,
      m_axi_rdata(30) => \<const0>\,
      m_axi_rdata(29) => \<const0>\,
      m_axi_rdata(28) => \<const0>\,
      m_axi_rdata(27) => \<const0>\,
      m_axi_rdata(26) => \<const0>\,
      m_axi_rdata(25) => \<const0>\,
      m_axi_rdata(24) => \<const0>\,
      m_axi_rdata(23) => \<const0>\,
      m_axi_rdata(22) => \<const0>\,
      m_axi_rdata(21) => \<const0>\,
      m_axi_rdata(20) => \<const0>\,
      m_axi_rdata(19) => \<const0>\,
      m_axi_rdata(18) => \<const0>\,
      m_axi_rdata(17) => \<const0>\,
      m_axi_rdata(16) => \<const0>\,
      m_axi_rdata(15) => \<const0>\,
      m_axi_rdata(14) => \<const0>\,
      m_axi_rdata(13) => \<const0>\,
      m_axi_rdata(12) => \<const0>\,
      m_axi_rdata(11) => \<const0>\,
      m_axi_rdata(10) => \<const0>\,
      m_axi_rdata(9) => \<const0>\,
      m_axi_rdata(8) => \<const0>\,
      m_axi_rdata(7) => \<const0>\,
      m_axi_rdata(6) => \<const0>\,
      m_axi_rdata(5) => \<const0>\,
      m_axi_rdata(4) => \<const0>\,
      m_axi_rdata(3) => \<const0>\,
      m_axi_rdata(2) => \<const0>\,
      m_axi_rdata(1) => \<const0>\,
      m_axi_rdata(0) => \<const0>\,
      m_axi_rid(0) => \<const0>\,
      m_axi_rlast => \<const0>\,
      m_axi_rready => NLW_U0_m_axi_rready_UNCONNECTED,
      m_axi_rresp(1) => \<const0>\,
      m_axi_rresp(0) => \<const0>\,
      m_axi_ruser(0) => \<const0>\,
      m_axi_rvalid => \<const0>\,
      m_axi_wdata(31 downto 0) => m_axi_wdata(31 downto 0),
      m_axi_wid(0) => NLW_U0_m_axi_wid_UNCONNECTED(0),
      m_axi_wlast => NLW_U0_m_axi_wlast_UNCONNECTED,
      m_axi_wready => m_axi_wready,
      m_axi_wstrb(3 downto 0) => m_axi_wstrb(3 downto 0),
      m_axi_wuser(0) => NLW_U0_m_axi_wuser_UNCONNECTED(0),
      m_axi_wvalid => m_axi_wvalid,
      m_axis_tdata(7 downto 0) => NLW_U0_m_axis_tdata_UNCONNECTED(7 downto 0),
      m_axis_tdest(0) => NLW_U0_m_axis_tdest_UNCONNECTED(0),
      m_axis_tid(0) => NLW_U0_m_axis_tid_UNCONNECTED(0),
      m_axis_tkeep(0) => NLW_U0_m_axis_tkeep_UNCONNECTED(0),
      m_axis_tlast => NLW_U0_m_axis_tlast_UNCONNECTED,
      m_axis_tready => \<const0>\,
      m_axis_tstrb(0) => NLW_U0_m_axis_tstrb_UNCONNECTED(0),
      m_axis_tuser(3 downto 0) => NLW_U0_m_axis_tuser_UNCONNECTED(3 downto 0),
      m_axis_tvalid => NLW_U0_m_axis_tvalid_UNCONNECTED,
      overflow => NLW_U0_overflow_UNCONNECTED,
      prog_empty => NLW_U0_prog_empty_UNCONNECTED,
      prog_empty_thresh(9) => \<const0>\,
      prog_empty_thresh(8) => \<const0>\,
      prog_empty_thresh(7) => \<const0>\,
      prog_empty_thresh(6) => \<const0>\,
      prog_empty_thresh(5) => \<const0>\,
      prog_empty_thresh(4) => \<const0>\,
      prog_empty_thresh(3) => \<const0>\,
      prog_empty_thresh(2) => \<const0>\,
      prog_empty_thresh(1) => \<const0>\,
      prog_empty_thresh(0) => \<const0>\,
      prog_empty_thresh_assert(9) => \<const0>\,
      prog_empty_thresh_assert(8) => \<const0>\,
      prog_empty_thresh_assert(7) => \<const0>\,
      prog_empty_thresh_assert(6) => \<const0>\,
      prog_empty_thresh_assert(5) => \<const0>\,
      prog_empty_thresh_assert(4) => \<const0>\,
      prog_empty_thresh_assert(3) => \<const0>\,
      prog_empty_thresh_assert(2) => \<const0>\,
      prog_empty_thresh_assert(1) => \<const0>\,
      prog_empty_thresh_assert(0) => \<const0>\,
      prog_empty_thresh_negate(9) => \<const0>\,
      prog_empty_thresh_negate(8) => \<const0>\,
      prog_empty_thresh_negate(7) => \<const0>\,
      prog_empty_thresh_negate(6) => \<const0>\,
      prog_empty_thresh_negate(5) => \<const0>\,
      prog_empty_thresh_negate(4) => \<const0>\,
      prog_empty_thresh_negate(3) => \<const0>\,
      prog_empty_thresh_negate(2) => \<const0>\,
      prog_empty_thresh_negate(1) => \<const0>\,
      prog_empty_thresh_negate(0) => \<const0>\,
      prog_full => NLW_U0_prog_full_UNCONNECTED,
      prog_full_thresh(9) => \<const0>\,
      prog_full_thresh(8) => \<const0>\,
      prog_full_thresh(7) => \<const0>\,
      prog_full_thresh(6) => \<const0>\,
      prog_full_thresh(5) => \<const0>\,
      prog_full_thresh(4) => \<const0>\,
      prog_full_thresh(3) => \<const0>\,
      prog_full_thresh(2) => \<const0>\,
      prog_full_thresh(1) => \<const0>\,
      prog_full_thresh(0) => \<const0>\,
      prog_full_thresh_assert(9) => \<const0>\,
      prog_full_thresh_assert(8) => \<const0>\,
      prog_full_thresh_assert(7) => \<const0>\,
      prog_full_thresh_assert(6) => \<const0>\,
      prog_full_thresh_assert(5) => \<const0>\,
      prog_full_thresh_assert(4) => \<const0>\,
      prog_full_thresh_assert(3) => \<const0>\,
      prog_full_thresh_assert(2) => \<const0>\,
      prog_full_thresh_assert(1) => \<const0>\,
      prog_full_thresh_assert(0) => \<const0>\,
      prog_full_thresh_negate(9) => \<const0>\,
      prog_full_thresh_negate(8) => \<const0>\,
      prog_full_thresh_negate(7) => \<const0>\,
      prog_full_thresh_negate(6) => \<const0>\,
      prog_full_thresh_negate(5) => \<const0>\,
      prog_full_thresh_negate(4) => \<const0>\,
      prog_full_thresh_negate(3) => \<const0>\,
      prog_full_thresh_negate(2) => \<const0>\,
      prog_full_thresh_negate(1) => \<const0>\,
      prog_full_thresh_negate(0) => \<const0>\,
      rd_clk => \<const0>\,
      rd_data_count(9 downto 0) => NLW_U0_rd_data_count_UNCONNECTED(9 downto 0),
      rd_en => \<const0>\,
      rd_rst => \<const0>\,
      rd_rst_busy => NLW_U0_rd_rst_busy_UNCONNECTED,
      rst => \<const0>\,
      s_aclk => s_aclk,
      s_aclk_en => \<const0>\,
      s_aresetn => s_aresetn,
      s_axi_araddr(31) => \<const0>\,
      s_axi_araddr(30) => \<const0>\,
      s_axi_araddr(29) => \<const0>\,
      s_axi_araddr(28) => \<const0>\,
      s_axi_araddr(27) => \<const0>\,
      s_axi_araddr(26) => \<const0>\,
      s_axi_araddr(25) => \<const0>\,
      s_axi_araddr(24) => \<const0>\,
      s_axi_araddr(23) => \<const0>\,
      s_axi_araddr(22) => \<const0>\,
      s_axi_araddr(21) => \<const0>\,
      s_axi_araddr(20) => \<const0>\,
      s_axi_araddr(19) => \<const0>\,
      s_axi_araddr(18) => \<const0>\,
      s_axi_araddr(17) => \<const0>\,
      s_axi_araddr(16) => \<const0>\,
      s_axi_araddr(15) => \<const0>\,
      s_axi_araddr(14) => \<const0>\,
      s_axi_araddr(13) => \<const0>\,
      s_axi_araddr(12) => \<const0>\,
      s_axi_araddr(11) => \<const0>\,
      s_axi_araddr(10) => \<const0>\,
      s_axi_araddr(9) => \<const0>\,
      s_axi_araddr(8) => \<const0>\,
      s_axi_araddr(7) => \<const0>\,
      s_axi_araddr(6) => \<const0>\,
      s_axi_araddr(5) => \<const0>\,
      s_axi_araddr(4) => \<const0>\,
      s_axi_araddr(3) => \<const0>\,
      s_axi_araddr(2) => \<const0>\,
      s_axi_araddr(1) => \<const0>\,
      s_axi_araddr(0) => \<const0>\,
      s_axi_arburst(1) => \<const0>\,
      s_axi_arburst(0) => \<const0>\,
      s_axi_arcache(3) => \<const0>\,
      s_axi_arcache(2) => \<const0>\,
      s_axi_arcache(1) => \<const0>\,
      s_axi_arcache(0) => \<const0>\,
      s_axi_arid(0) => \<const0>\,
      s_axi_arlen(3) => \<const0>\,
      s_axi_arlen(2) => \<const0>\,
      s_axi_arlen(1) => \<const0>\,
      s_axi_arlen(0) => \<const0>\,
      s_axi_arlock(1) => \<const0>\,
      s_axi_arlock(0) => \<const0>\,
      s_axi_arprot(2) => \<const0>\,
      s_axi_arprot(1) => \<const0>\,
      s_axi_arprot(0) => \<const0>\,
      s_axi_arqos(3) => \<const0>\,
      s_axi_arqos(2) => \<const0>\,
      s_axi_arqos(1) => \<const0>\,
      s_axi_arqos(0) => \<const0>\,
      s_axi_arready => NLW_U0_s_axi_arready_UNCONNECTED,
      s_axi_arregion(3) => \<const0>\,
      s_axi_arregion(2) => \<const0>\,
      s_axi_arregion(1) => \<const0>\,
      s_axi_arregion(0) => \<const0>\,
      s_axi_arsize(2) => \<const0>\,
      s_axi_arsize(1) => \<const0>\,
      s_axi_arsize(0) => \<const0>\,
      s_axi_aruser(0) => \<const0>\,
      s_axi_arvalid => \<const0>\,
      s_axi_awaddr(31 downto 0) => s_axi_awaddr(31 downto 0),
      s_axi_awburst(1) => \<const0>\,
      s_axi_awburst(0) => \<const0>\,
      s_axi_awcache(3) => \<const0>\,
      s_axi_awcache(2) => \<const0>\,
      s_axi_awcache(1) => \<const0>\,
      s_axi_awcache(0) => \<const0>\,
      s_axi_awid(0) => \<const0>\,
      s_axi_awlen(3) => \<const0>\,
      s_axi_awlen(2) => \<const0>\,
      s_axi_awlen(1) => \<const0>\,
      s_axi_awlen(0) => \<const0>\,
      s_axi_awlock(1) => \<const0>\,
      s_axi_awlock(0) => \<const0>\,
      s_axi_awprot(2 downto 0) => s_axi_awprot(2 downto 0),
      s_axi_awqos(3) => \<const0>\,
      s_axi_awqos(2) => \<const0>\,
      s_axi_awqos(1) => \<const0>\,
      s_axi_awqos(0) => \<const0>\,
      s_axi_awready => s_axi_awready,
      s_axi_awregion(3) => \<const0>\,
      s_axi_awregion(2) => \<const0>\,
      s_axi_awregion(1) => \<const0>\,
      s_axi_awregion(0) => \<const0>\,
      s_axi_awsize(2) => \<const0>\,
      s_axi_awsize(1) => \<const0>\,
      s_axi_awsize(0) => \<const0>\,
      s_axi_awuser(0) => \<const0>\,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(0) => NLW_U0_s_axi_bid_UNCONNECTED(0),
      s_axi_bready => s_axi_bready,
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_buser(0) => NLW_U0_s_axi_buser_UNCONNECTED(0),
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata(31 downto 0) => NLW_U0_s_axi_rdata_UNCONNECTED(31 downto 0),
      s_axi_rid(0) => NLW_U0_s_axi_rid_UNCONNECTED(0),
      s_axi_rlast => NLW_U0_s_axi_rlast_UNCONNECTED,
      s_axi_rready => \<const0>\,
      s_axi_rresp(1 downto 0) => NLW_U0_s_axi_rresp_UNCONNECTED(1 downto 0),
      s_axi_ruser(0) => NLW_U0_s_axi_ruser_UNCONNECTED(0),
      s_axi_rvalid => NLW_U0_s_axi_rvalid_UNCONNECTED,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wid(0) => \<const0>\,
      s_axi_wlast => \<const0>\,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wuser(0) => \<const0>\,
      s_axi_wvalid => s_axi_wvalid,
      s_axis_tdata(7) => \<const0>\,
      s_axis_tdata(6) => \<const0>\,
      s_axis_tdata(5) => \<const0>\,
      s_axis_tdata(4) => \<const0>\,
      s_axis_tdata(3) => \<const0>\,
      s_axis_tdata(2) => \<const0>\,
      s_axis_tdata(1) => \<const0>\,
      s_axis_tdata(0) => \<const0>\,
      s_axis_tdest(0) => \<const0>\,
      s_axis_tid(0) => \<const0>\,
      s_axis_tkeep(0) => \<const0>\,
      s_axis_tlast => \<const0>\,
      s_axis_tready => NLW_U0_s_axis_tready_UNCONNECTED,
      s_axis_tstrb(0) => \<const0>\,
      s_axis_tuser(3) => \<const0>\,
      s_axis_tuser(2) => \<const0>\,
      s_axis_tuser(1) => \<const0>\,
      s_axis_tuser(0) => \<const0>\,
      s_axis_tvalid => \<const0>\,
      sbiterr => NLW_U0_sbiterr_UNCONNECTED,
      srst => \<const0>\,
      underflow => NLW_U0_underflow_UNCONNECTED,
      valid => NLW_U0_valid_UNCONNECTED,
      wr_ack => NLW_U0_wr_ack_UNCONNECTED,
      wr_clk => \<const0>\,
      wr_data_count(9 downto 0) => NLW_U0_wr_data_count_UNCONNECTED(9 downto 0),
      wr_en => \<const0>\,
      wr_rst => \<const0>\,
      wr_rst_busy => NLW_U0_wr_rst_busy_UNCONNECTED
    );
end STRUCTURE;
