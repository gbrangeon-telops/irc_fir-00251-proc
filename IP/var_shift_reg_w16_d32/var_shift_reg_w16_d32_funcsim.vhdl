-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Sun Nov 05 09:51:32 2017
-- Host        : TELOPS228 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Telops/fir-00251-Proc/IP/var_shift_reg_w16_d32/var_shift_reg_w16_d32_funcsim.vhdl
-- Design      : var_shift_reg_w16_d32
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ is
  port (
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    AINIT : in STD_LOGIC;
    ACLR : in STD_LOGIC;
    ASET : in STD_LOGIC;
    SINIT : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    SSET : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 15 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is "c_reg_fd_v12_0_viv";
  attribute C_WIDTH : integer;
  attribute C_WIDTH of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is 16;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is "0000000000000000";
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is "0000000000000000";
  attribute C_SYNC_PRIORITY : integer;
  attribute C_SYNC_PRIORITY of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is 1;
  attribute c_has_aclr : integer;
  attribute c_has_aclr of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is 0;
  attribute c_has_aset : integer;
  attribute c_has_aset of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is 0;
  attribute c_has_ainit : integer;
  attribute c_has_ainit of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is 0;
  attribute c_enable_rlocs : integer;
  attribute c_enable_rlocs of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is "yes";
  attribute shreg_extract : string;
  attribute shreg_extract of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ : entity is "YES";
end \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\;

architecture STRUCTURE of \var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\ is
begin
\i_no_async_controls.output_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(9),
      Q => Q(9),
      R => SCLR
    );
\i_no_async_controls.output_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(10),
      Q => Q(10),
      R => SCLR
    );
\i_no_async_controls.output_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(11),
      Q => Q(11),
      R => SCLR
    );
\i_no_async_controls.output_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(12),
      Q => Q(12),
      R => SCLR
    );
\i_no_async_controls.output_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(13),
      Q => Q(13),
      R => SCLR
    );
\i_no_async_controls.output_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(14),
      Q => Q(14),
      R => SCLR
    );
\i_no_async_controls.output_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(15),
      Q => Q(15),
      R => SCLR
    );
\i_no_async_controls.output_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(0),
      Q => Q(0),
      R => SCLR
    );
\i_no_async_controls.output_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(1),
      Q => Q(1),
      R => SCLR
    );
\i_no_async_controls.output_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(2),
      Q => Q(2),
      R => SCLR
    );
\i_no_async_controls.output_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(3),
      Q => Q(3),
      R => SCLR
    );
\i_no_async_controls.output_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(4),
      Q => Q(4),
      R => SCLR
    );
\i_no_async_controls.output_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(5),
      Q => Q(5),
      R => SCLR
    );
\i_no_async_controls.output_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(6),
      Q => Q(6),
      R => SCLR
    );
\i_no_async_controls.output_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(7),
      Q => Q(7),
      R => SCLR
    );
\i_no_async_controls.output_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => CE,
      D => D(8),
      Q => Q(8),
      R => SCLR
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity var_shift_reg_w16_d32sr is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute addr_width : integer;
  attribute addr_width of var_shift_reg_w16_d32sr : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of var_shift_reg_w16_d32sr : entity is 0;
  attribute srinit : integer;
  attribute srinit of var_shift_reg_w16_d32sr : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of var_shift_reg_w16_d32sr : entity is "yes";
end var_shift_reg_w16_d32sr;

architecture STRUCTURE of var_shift_reg_w16_d32sr is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[15].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[15].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__1\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__1\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__1\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__1\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__1\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__1\ : entity is "yes";
end \var_shift_reg_w16_d32sr__1\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__1\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[0].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[0].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__10\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__10\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__10\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__10\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__10\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__10\ : entity is "yes";
end \var_shift_reg_w16_d32sr__10\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__10\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[9].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[9].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__11\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__11\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__11\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__11\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__11\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__11\ : entity is "yes";
end \var_shift_reg_w16_d32sr__11\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__11\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[10].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[10].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__12\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__12\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__12\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__12\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__12\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__12\ : entity is "yes";
end \var_shift_reg_w16_d32sr__12\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__12\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[11].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[11].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__13\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__13\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__13\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__13\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__13\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__13\ : entity is "yes";
end \var_shift_reg_w16_d32sr__13\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__13\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[12].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[12].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__14\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__14\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__14\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__14\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__14\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__14\ : entity is "yes";
end \var_shift_reg_w16_d32sr__14\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__14\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[13].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[13].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__15\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__15\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__15\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__15\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__15\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__15\ : entity is "yes";
end \var_shift_reg_w16_d32sr__15\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__15\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[14].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[14].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__2\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__2\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__2\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__2\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__2\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__2\ : entity is "yes";
end \var_shift_reg_w16_d32sr__2\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__2\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[1].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[1].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__3\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__3\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__3\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__3\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__3\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__3\ : entity is "yes";
end \var_shift_reg_w16_d32sr__3\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__3\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[2].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[2].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__4\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__4\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__4\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__4\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__4\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__4\ : entity is "yes";
end \var_shift_reg_w16_d32sr__4\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__4\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[3].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[3].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__5\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__5\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__5\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__5\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__5\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__5\ : entity is "yes";
end \var_shift_reg_w16_d32sr__5\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__5\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[4].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[4].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__6\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__6\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__6\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__6\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__6\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__6\ : entity is "yes";
end \var_shift_reg_w16_d32sr__6\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__6\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[5].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[5].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__7\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__7\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__7\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__7\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__7\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__7\ : entity is "yes";
end \var_shift_reg_w16_d32sr__7\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__7\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[6].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[6].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__8\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__8\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__8\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__8\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__8\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__8\ : entity is "yes";
end \var_shift_reg_w16_d32sr__8\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__8\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[7].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[7].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32sr__9\ is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    ce : in STD_LOGIC;
    q : out STD_LOGIC;
    qcarry : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32sr__9\ : entity is "sr";
  attribute addr_width : integer;
  attribute addr_width of \var_shift_reg_w16_d32sr__9\ : entity is 5;
  attribute use_carry : integer;
  attribute use_carry of \var_shift_reg_w16_d32sr__9\ : entity is 0;
  attribute srinit : integer;
  attribute srinit of \var_shift_reg_w16_d32sr__9\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32sr__9\ : entity is "yes";
end \var_shift_reg_w16_d32sr__9\;

architecture STRUCTURE of \var_shift_reg_w16_d32sr__9\ is
  signal \<const0>\ : STD_LOGIC;
  signal \n_1_usecarry32.shreg\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \usecarry32.shreg\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[8].gen_depth ";
  attribute srl_name : string;
  attribute srl_name of \usecarry32.shreg\ : label is "U0/i_synth/i_bb_inst/\lls_speed.s3_v2_v4_v5_lls.gen_width[8].gen_depth[0].gen_only.i_lls_only /\usecarry32.shreg ";
begin
  qcarry <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\usecarry32.shreg\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A(4 downto 0) => a(4 downto 0),
      CE => ce,
      CLK => clk,
      D => d,
      Q => q,
      Q31 => \n_1_usecarry32.shreg\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity var_shift_reg_w16_d32c_shift_ram_v12_0_legacy is
  port (
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    d : in STD_LOGIC_VECTOR ( 15 downto 0 );
    clk : in STD_LOGIC;
    ce : in STD_LOGIC;
    aclr : in STD_LOGIC;
    aset : in STD_LOGIC;
    ainit : in STD_LOGIC;
    sclr : in STD_LOGIC;
    sset : in STD_LOGIC;
    sinit : in STD_LOGIC;
    q : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is "kintex7";
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 0;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 16;
  attribute C_DEPTH : integer;
  attribute C_DEPTH of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 32;
  attribute C_ADDR_WIDTH : integer;
  attribute C_ADDR_WIDTH of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 5;
  attribute C_SHIFT_TYPE : integer;
  attribute C_SHIFT_TYPE of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 1;
  attribute C_OPT_GOAL : integer;
  attribute C_OPT_GOAL of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 1;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is "0";
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is "0000000000000000";
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is "0";
  attribute c_default_data_radix : integer;
  attribute c_default_data_radix of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 1;
  attribute C_HAS_A : integer;
  attribute C_HAS_A of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 1;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 1;
  attribute C_REG_LAST_BIT : integer;
  attribute C_REG_LAST_BIT of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 1;
  attribute C_SYNC_PRIORITY : integer;
  attribute C_SYNC_PRIORITY of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 1;
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 0;
  attribute c_has_aclr : integer;
  attribute c_has_aclr of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 0;
  attribute c_has_aset : integer;
  attribute c_has_aset of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 0;
  attribute c_has_ainit : integer;
  attribute c_has_ainit of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 0;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 1;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 0;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 0;
  attribute C_MEM_INIT_FILE : string;
  attribute C_MEM_INIT_FILE of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is "no_coe_file_loaded";
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is "./";
  attribute c_mem_init_radix : integer;
  attribute c_mem_init_radix of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 1;
  attribute c_generate_mif : integer;
  attribute c_generate_mif of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 0;
  attribute C_READ_MIF : integer;
  attribute C_READ_MIF of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 0;
  attribute c_enable_rlocs : integer;
  attribute c_enable_rlocs of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 0;
  attribute C_PARSER_TYPE : integer;
  attribute C_PARSER_TYPE of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is 0;
  attribute opt_mode : string;
  attribute opt_mode of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is "AREA";
  attribute use_clock_enable : string;
  attribute use_clock_enable of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is "YES";
  attribute optimize_primitives : string;
  attribute optimize_primitives of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is "NO";
  attribute shreg_extract : string;
  attribute shreg_extract of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is "YES";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy : entity is "yes";
end var_shift_reg_w16_d32c_shift_ram_v12_0_legacy;

architecture STRUCTURE of var_shift_reg_w16_d32c_shift_ram_v12_0_legacy is
  signal \mux_in[0,0]\ : STD_LOGIC;
  signal \mux_in[1,0]\ : STD_LOGIC;
  signal \mux_in[10,0]\ : STD_LOGIC;
  signal \mux_in[11,0]\ : STD_LOGIC;
  signal \mux_in[12,0]\ : STD_LOGIC;
  signal \mux_in[13,0]\ : STD_LOGIC;
  signal \mux_in[14,0]\ : STD_LOGIC;
  signal \mux_in[15,0]\ : STD_LOGIC;
  signal \mux_in[2,0]\ : STD_LOGIC;
  signal \mux_in[3,0]\ : STD_LOGIC;
  signal \mux_in[4,0]\ : STD_LOGIC;
  signal \mux_in[5,0]\ : STD_LOGIC;
  signal \mux_in[6,0]\ : STD_LOGIC;
  signal \mux_in[7,0]\ : STD_LOGIC;
  signal \mux_in[8,0]\ : STD_LOGIC;
  signal \mux_in[9,0]\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[0].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[10].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[11].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[12].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[13].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[14].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[15].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[1].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[2].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[3].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[4].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[5].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[6].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[7].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[8].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[9].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\ : STD_LOGIC;
  attribute C_AINIT_VAL of \gen_output_regs.output_regs\ : label is "0000000000000000";
  attribute C_ENABLE_RLOCS of \gen_output_regs.output_regs\ : label is 0;
  attribute C_HAS_ACLR of \gen_output_regs.output_regs\ : label is 0;
  attribute C_HAS_AINIT of \gen_output_regs.output_regs\ : label is 0;
  attribute C_HAS_ASET of \gen_output_regs.output_regs\ : label is 0;
  attribute C_HAS_CE of \gen_output_regs.output_regs\ : label is 1;
  attribute C_HAS_SCLR of \gen_output_regs.output_regs\ : label is 1;
  attribute C_HAS_SINIT of \gen_output_regs.output_regs\ : label is 0;
  attribute C_HAS_SSET of \gen_output_regs.output_regs\ : label is 0;
  attribute C_SINIT_VAL of \gen_output_regs.output_regs\ : label is "0000000000000000";
  attribute C_SYNC_ENABLE of \gen_output_regs.output_regs\ : label is 0;
  attribute C_SYNC_PRIORITY of \gen_output_regs.output_regs\ : label is 1;
  attribute C_WIDTH of \gen_output_regs.output_regs\ : label is 16;
  attribute SHREG_EXTRACT of \gen_output_regs.output_regs\ : label is "YES";
  attribute downgradeipidentifiedwarnings of \gen_output_regs.output_regs\ : label is "yes";
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[0].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width : integer;
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[0].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[0].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit : integer;
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[0].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry : integer;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[0].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[10].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[10].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[10].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[10].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[10].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[11].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[11].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[11].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[11].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[11].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[12].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[12].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[12].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[12].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[12].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[13].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[13].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[13].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[13].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[13].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[14].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[14].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[14].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[14].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[14].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[15].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[15].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[15].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[15].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[15].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[1].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[1].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[1].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[1].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[1].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[2].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[2].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[2].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[2].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[2].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[3].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[3].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[3].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[3].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[3].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[4].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[4].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[4].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[4].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[4].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[5].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[5].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[5].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[5].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[5].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[6].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[6].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[6].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[6].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[6].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[7].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[7].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[7].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[7].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[7].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[8].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[8].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[8].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[8].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[8].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute SHREG_EXTRACT of \lls_speed.s3_v2_v4_v5_lls.gen_width[9].gen_depth[0].gen_only.i_lls_only\ : label is "YES";
  attribute addr_width of \lls_speed.s3_v2_v4_v5_lls.gen_width[9].gen_depth[0].gen_only.i_lls_only\ : label is 5;
  attribute downgradeipidentifiedwarnings of \lls_speed.s3_v2_v4_v5_lls.gen_width[9].gen_depth[0].gen_only.i_lls_only\ : label is "yes";
  attribute srinit of \lls_speed.s3_v2_v4_v5_lls.gen_width[9].gen_depth[0].gen_only.i_lls_only\ : label is 0;
  attribute use_carry of \lls_speed.s3_v2_v4_v5_lls.gen_width[9].gen_depth[0].gen_only.i_lls_only\ : label is 0;
begin
\gen_output_regs.output_regs\: entity work.\var_shift_reg_w16_d32c_reg_fd_v12_0_viv__parameterized0\
    port map (
      ACLR => aclr,
      AINIT => ainit,
      ASET => aset,
      CE => ce,
      CLK => clk,
      D(15) => \mux_in[15,0]\,
      D(14) => \mux_in[14,0]\,
      D(13) => \mux_in[13,0]\,
      D(12) => \mux_in[12,0]\,
      D(11) => \mux_in[11,0]\,
      D(10) => \mux_in[10,0]\,
      D(9) => \mux_in[9,0]\,
      D(8) => \mux_in[8,0]\,
      D(7) => \mux_in[7,0]\,
      D(6) => \mux_in[6,0]\,
      D(5) => \mux_in[5,0]\,
      D(4) => \mux_in[4,0]\,
      D(3) => \mux_in[3,0]\,
      D(2) => \mux_in[2,0]\,
      D(1) => \mux_in[1,0]\,
      D(0) => \mux_in[0,0]\,
      Q(15 downto 0) => q(15 downto 0),
      SCLR => sclr,
      SINIT => sinit,
      SSET => sset
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[0].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__1\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(0),
      q => \mux_in[0,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[0].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[10].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__11\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(10),
      q => \mux_in[10,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[10].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[11].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__12\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(11),
      q => \mux_in[11,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[11].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[12].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__13\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(12),
      q => \mux_in[12,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[12].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[13].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__14\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(13),
      q => \mux_in[13,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[13].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[14].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__15\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(14),
      q => \mux_in[14,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[14].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[15].gen_depth[0].gen_only.i_lls_only\: entity work.var_shift_reg_w16_d32sr
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(15),
      q => \mux_in[15,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[15].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[1].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__2\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(1),
      q => \mux_in[1,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[1].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[2].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__3\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(2),
      q => \mux_in[2,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[2].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[3].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__4\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(3),
      q => \mux_in[3,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[3].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[4].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__5\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(4),
      q => \mux_in[4,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[4].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[5].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__6\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(5),
      q => \mux_in[5,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[5].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[6].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__7\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(6),
      q => \mux_in[6,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[6].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[7].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__8\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(7),
      q => \mux_in[7,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[7].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[8].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__9\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(8),
      q => \mux_in[8,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[8].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
\lls_speed.s3_v2_v4_v5_lls.gen_width[9].gen_depth[0].gen_only.i_lls_only\: entity work.\var_shift_reg_w16_d32sr__10\
    port map (
      a(4 downto 0) => a(4 downto 0),
      ce => ce,
      clk => clk,
      d => d(9),
      q => \mux_in[9,0]\,
      qcarry => \NLW_lls_speed.s3_v2_v4_v5_lls.gen_width[9].gen_depth[0].gen_only.i_lls_only_qcarry_UNCONNECTED\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ is
  port (
    A : in STD_LOGIC_VECTOR ( 4 downto 0 );
    D : in STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    SSET : in STD_LOGIC;
    SINIT : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is "c_shift_ram_v12_0_viv";
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is "kintex7";
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 16;
  attribute C_DEPTH : integer;
  attribute C_DEPTH of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 32;
  attribute C_ADDR_WIDTH : integer;
  attribute C_ADDR_WIDTH of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 5;
  attribute C_SHIFT_TYPE : integer;
  attribute C_SHIFT_TYPE of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_OPT_GOAL : integer;
  attribute C_OPT_GOAL of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is "0";
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is "0000000000000000";
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is "0";
  attribute C_HAS_A : integer;
  attribute C_HAS_A of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_REG_LAST_BIT : integer;
  attribute C_REG_LAST_BIT of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_SYNC_PRIORITY : integer;
  attribute C_SYNC_PRIORITY of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_MEM_INIT_FILE : string;
  attribute C_MEM_INIT_FILE of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is "no_coe_file_loaded";
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is "./";
  attribute C_READ_MIF : integer;
  attribute C_READ_MIF of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 0;
  attribute C_PARSER_TYPE : integer;
  attribute C_PARSER_TYPE of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ : entity is "yes";
end \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\;

architecture STRUCTURE of \var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  attribute C_AINIT_VAL of i_bb_inst : label is "0";
  attribute C_ENABLE_RLOCS : integer;
  attribute C_ENABLE_RLOCS of i_bb_inst : label is 0;
  attribute C_HAS_ACLR : integer;
  attribute C_HAS_ACLR of i_bb_inst : label is 0;
  attribute C_HAS_AINIT : integer;
  attribute C_HAS_AINIT of i_bb_inst : label is 0;
  attribute C_HAS_ASET : integer;
  attribute C_HAS_ASET of i_bb_inst : label is 0;
  attribute C_HAS_CE of i_bb_inst : label is 1;
  attribute C_HAS_SCLR of i_bb_inst : label is 1;
  attribute C_HAS_SINIT of i_bb_inst : label is 0;
  attribute C_HAS_SSET of i_bb_inst : label is 0;
  attribute C_SINIT_VAL of i_bb_inst : label is "0000000000000000";
  attribute C_SYNC_ENABLE of i_bb_inst : label is 0;
  attribute C_SYNC_PRIORITY of i_bb_inst : label is 1;
  attribute C_WIDTH of i_bb_inst : label is 16;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of i_bb_inst : label is "YES";
  attribute c_addr_width of i_bb_inst : label is 5;
  attribute c_default_data of i_bb_inst : label is "0";
  attribute c_default_data_radix : integer;
  attribute c_default_data_radix of i_bb_inst : label is 1;
  attribute c_depth of i_bb_inst : label is 32;
  attribute c_elaboration_dir of i_bb_inst : label is "./";
  attribute c_generate_mif : integer;
  attribute c_generate_mif of i_bb_inst : label is 0;
  attribute c_has_a of i_bb_inst : label is 1;
  attribute c_mem_init_file of i_bb_inst : label is "no_coe_file_loaded";
  attribute c_mem_init_radix : integer;
  attribute c_mem_init_radix of i_bb_inst : label is 1;
  attribute c_opt_goal of i_bb_inst : label is 1;
  attribute c_parser_type of i_bb_inst : label is 0;
  attribute c_read_mif of i_bb_inst : label is 0;
  attribute c_reg_last_bit of i_bb_inst : label is 1;
  attribute c_shift_type of i_bb_inst : label is 1;
  attribute c_verbosity of i_bb_inst : label is 0;
  attribute c_xdevicefamily of i_bb_inst : label is "kintex7";
  attribute downgradeipidentifiedwarnings of i_bb_inst : label is "yes";
  attribute opt_mode : string;
  attribute opt_mode of i_bb_inst : label is "AREA";
  attribute optimize_primitives : string;
  attribute optimize_primitives of i_bb_inst : label is "NO";
  attribute use_clock_enable : string;
  attribute use_clock_enable of i_bb_inst : label is "YES";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
i_bb_inst: entity work.var_shift_reg_w16_d32c_shift_ram_v12_0_legacy
    port map (
      a(4 downto 0) => A(4 downto 0),
      aclr => \<const0>\,
      ainit => \<const0>\,
      aset => \<const0>\,
      ce => CE,
      clk => CLK,
      d(15 downto 0) => D(15 downto 0),
      q(15 downto 0) => Q(15 downto 0),
      sclr => SCLR,
      sinit => SINIT,
      sset => SSET
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ is
  port (
    A : in STD_LOGIC_VECTOR ( 4 downto 0 );
    D : in STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    SSET : in STD_LOGIC;
    SINIT : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is "c_shift_ram_v12_0";
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is "kintex7";
  attribute C_VERBOSITY : integer;
  attribute C_VERBOSITY of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 0;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 16;
  attribute C_DEPTH : integer;
  attribute C_DEPTH of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 32;
  attribute C_ADDR_WIDTH : integer;
  attribute C_ADDR_WIDTH of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 5;
  attribute C_SHIFT_TYPE : integer;
  attribute C_SHIFT_TYPE of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 1;
  attribute C_OPT_GOAL : integer;
  attribute C_OPT_GOAL of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 1;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is "0";
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is "0000000000000000";
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is "0";
  attribute C_HAS_A : integer;
  attribute C_HAS_A of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 1;
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 1;
  attribute C_REG_LAST_BIT : integer;
  attribute C_REG_LAST_BIT of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 1;
  attribute C_SYNC_PRIORITY : integer;
  attribute C_SYNC_PRIORITY of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 1;
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 0;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 1;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 0;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 0;
  attribute C_MEM_INIT_FILE : string;
  attribute C_MEM_INIT_FILE of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is "no_coe_file_loaded";
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is "./";
  attribute C_READ_MIF : integer;
  attribute C_READ_MIF of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 0;
  attribute C_PARSER_TYPE : integer;
  attribute C_PARSER_TYPE of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is 0;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ : entity is "yes";
end \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\;

architecture STRUCTURE of \var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\ is
  attribute C_AINIT_VAL of i_synth : label is "0";
  attribute C_HAS_CE of i_synth : label is 1;
  attribute C_HAS_SCLR of i_synth : label is 1;
  attribute C_HAS_SINIT of i_synth : label is 0;
  attribute C_HAS_SSET of i_synth : label is 0;
  attribute C_SINIT_VAL of i_synth : label is "0000000000000000";
  attribute C_SYNC_ENABLE of i_synth : label is 0;
  attribute C_SYNC_PRIORITY of i_synth : label is 1;
  attribute C_WIDTH of i_synth : label is 16;
  attribute c_addr_width of i_synth : label is 5;
  attribute c_default_data of i_synth : label is "0";
  attribute c_depth of i_synth : label is 32;
  attribute c_elaboration_dir of i_synth : label is "./";
  attribute c_has_a of i_synth : label is 1;
  attribute c_mem_init_file of i_synth : label is "no_coe_file_loaded";
  attribute c_opt_goal of i_synth : label is 1;
  attribute c_parser_type of i_synth : label is 0;
  attribute c_read_mif of i_synth : label is 0;
  attribute c_reg_last_bit of i_synth : label is 1;
  attribute c_shift_type of i_synth : label is 1;
  attribute c_verbosity of i_synth : label is 0;
  attribute c_xdevicefamily of i_synth : label is "kintex7";
  attribute downgradeipidentifiedwarnings of i_synth : label is "yes";
begin
i_synth: entity work.\var_shift_reg_w16_d32c_shift_ram_v12_0_viv__parameterized0\
    port map (
      A(4 downto 0) => A(4 downto 0),
      CE => CE,
      CLK => CLK,
      D(15 downto 0) => D(15 downto 0),
      Q(15 downto 0) => Q(15 downto 0),
      SCLR => SCLR,
      SINIT => SINIT,
      SSET => SSET
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity var_shift_reg_w16_d32 is
  port (
    A : in STD_LOGIC_VECTOR ( 4 downto 0 );
    D : in STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of var_shift_reg_w16_d32 : entity is true;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of var_shift_reg_w16_d32 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of var_shift_reg_w16_d32 : entity is "c_shift_ram_v12_0,Vivado 2013.4";
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of var_shift_reg_w16_d32 : entity is "var_shift_reg_w16_d32,c_shift_ram_v12_0,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of var_shift_reg_w16_d32 : entity is "var_shift_reg_w16_d32,c_shift_ram_v12_0,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=c_shift_ram,x_ipVersion=12.0,x_ipCoreRevision=3,x_ipLanguage=VHDL,C_XDEVICEFAMILY=kintex7,C_VERBOSITY=0,C_WIDTH=16,C_DEPTH=32,C_ADDR_WIDTH=5,C_SHIFT_TYPE=1,C_OPT_GOAL=1,C_AINIT_VAL=0,C_SINIT_VAL=0000000000000000,C_DEFAULT_DATA=0,C_HAS_A=1,C_HAS_CE=1,C_REG_LAST_BIT=1,C_SYNC_PRIORITY=1,C_SYNC_ENABLE=0,C_HAS_SCLR=1,C_HAS_SSET=0,C_HAS_SINIT=0,C_MEM_INIT_FILE=no_coe_file_loaded,C_ELABORATION_DIR=./,C_READ_MIF=0,C_PARSER_TYPE=0}";
end var_shift_reg_w16_d32;

architecture STRUCTURE of var_shift_reg_w16_d32 is
  signal \<const0>\ : STD_LOGIC;
  attribute C_AINIT_VAL : string;
  attribute C_AINIT_VAL of U0 : label is "0";
  attribute C_HAS_CE : integer;
  attribute C_HAS_CE of U0 : label is 1;
  attribute C_HAS_SCLR : integer;
  attribute C_HAS_SCLR of U0 : label is 1;
  attribute C_HAS_SINIT : integer;
  attribute C_HAS_SINIT of U0 : label is 0;
  attribute C_HAS_SSET : integer;
  attribute C_HAS_SSET of U0 : label is 0;
  attribute C_SINIT_VAL : string;
  attribute C_SINIT_VAL of U0 : label is "0000000000000000";
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of U0 : label is 0;
  attribute C_SYNC_PRIORITY : integer;
  attribute C_SYNC_PRIORITY of U0 : label is 1;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of U0 : label is 16;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of U0 : label is true;
  attribute c_addr_width : integer;
  attribute c_addr_width of U0 : label is 5;
  attribute c_default_data : string;
  attribute c_default_data of U0 : label is "0";
  attribute c_depth : integer;
  attribute c_depth of U0 : label is 32;
  attribute c_elaboration_dir : string;
  attribute c_elaboration_dir of U0 : label is "./";
  attribute c_has_a : integer;
  attribute c_has_a of U0 : label is 1;
  attribute c_mem_init_file : string;
  attribute c_mem_init_file of U0 : label is "no_coe_file_loaded";
  attribute c_opt_goal : integer;
  attribute c_opt_goal of U0 : label is 1;
  attribute c_parser_type : integer;
  attribute c_parser_type of U0 : label is 0;
  attribute c_read_mif : integer;
  attribute c_read_mif of U0 : label is 0;
  attribute c_reg_last_bit : integer;
  attribute c_reg_last_bit of U0 : label is 1;
  attribute c_shift_type : integer;
  attribute c_shift_type of U0 : label is 1;
  attribute c_verbosity : integer;
  attribute c_verbosity of U0 : label is 0;
  attribute c_xdevicefamily : string;
  attribute c_xdevicefamily of U0 : label is "kintex7";
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
U0: entity work.\var_shift_reg_w16_d32c_shift_ram_v12_0__parameterized0\
    port map (
      A(4 downto 0) => A(4 downto 0),
      CE => CE,
      CLK => CLK,
      D(15 downto 0) => D(15 downto 0),
      Q(15 downto 0) => Q(15 downto 0),
      SCLR => SCLR,
      SINIT => \<const0>\,
      SSET => \<const0>\
    );
end STRUCTURE;
