-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Fri Aug 19 13:57:40 2016
-- Host        : TELOPS229 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               D:/Telops/FIR-00251-Proc/IP/ip_axis_fp32tofi32/ip_axis_fp32tofi32_funcsim.vhdl
-- Design      : ip_axis_fp32tofi32
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_a_tvalid : in STD_LOGIC;
    s_axis_a_tready : out STD_LOGIC;
    s_axis_a_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_a_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_a_tlast : in STD_LOGIC;
    s_axis_b_tvalid : in STD_LOGIC;
    s_axis_b_tready : out STD_LOGIC;
    s_axis_b_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_b_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_b_tlast : in STD_LOGIC;
    s_axis_c_tvalid : in STD_LOGIC;
    s_axis_c_tready : out STD_LOGIC;
    s_axis_c_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_c_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_c_tlast : in STD_LOGIC;
    s_axis_operation_tvalid : in STD_LOGIC;
    s_axis_operation_tready : out STD_LOGIC;
    s_axis_operation_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_operation_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_operation_tlast : in STD_LOGIC;
    m_axis_result_tvalid : out STD_LOGIC;
    m_axis_result_tready : in STD_LOGIC;
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_result_tuser : out STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axis_result_tlast : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is "floating_point_v7_0_viv";
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is "kintex7";
  attribute C_HAS_ADD : integer;
  attribute C_HAS_ADD of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SUBTRACT : integer;
  attribute C_HAS_SUBTRACT of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_MULTIPLY : integer;
  attribute C_HAS_MULTIPLY of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_DIVIDE : integer;
  attribute C_HAS_DIVIDE of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_SQRT : integer;
  attribute C_HAS_SQRT of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_COMPARE : integer;
  attribute C_HAS_COMPARE of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FIX_TO_FLT : integer;
  attribute C_HAS_FIX_TO_FLT of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FIX : integer;
  attribute C_HAS_FLT_TO_FIX of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_FLT_TO_FLT : integer;
  attribute C_HAS_FLT_TO_FLT of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP : integer;
  attribute C_HAS_RECIP of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP_SQRT : integer;
  attribute C_HAS_RECIP_SQRT of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ABSOLUTE : integer;
  attribute C_HAS_ABSOLUTE of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_LOGARITHM : integer;
  attribute C_HAS_LOGARITHM of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_EXPONENTIAL : integer;
  attribute C_HAS_EXPONENTIAL of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FMA : integer;
  attribute C_HAS_FMA of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_FMS : integer;
  attribute C_HAS_FMS of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_A : integer;
  attribute C_HAS_ACCUMULATOR_A of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_S : integer;
  attribute C_HAS_ACCUMULATOR_S of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_A_FRACTION_WIDTH : integer;
  attribute C_A_FRACTION_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_B_FRACTION_WIDTH : integer;
  attribute C_B_FRACTION_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_C_WIDTH : integer;
  attribute C_C_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_C_FRACTION_WIDTH : integer;
  attribute C_C_FRACTION_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 24;
  attribute C_RESULT_WIDTH : integer;
  attribute C_RESULT_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_RESULT_FRACTION_WIDTH : integer;
  attribute C_RESULT_FRACTION_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_COMPARE_OPERATION : integer;
  attribute C_COMPARE_OPERATION of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 7;
  attribute C_OPTIMIZATION : integer;
  attribute C_OPTIMIZATION of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_MULT_USAGE : integer;
  attribute C_MULT_USAGE of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_BRAM_USAGE : integer;
  attribute C_BRAM_USAGE of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_RATE : integer;
  attribute C_RATE of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_ACCUM_INPUT_MSB : integer;
  attribute C_ACCUM_INPUT_MSB of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_ACCUM_MSB : integer;
  attribute C_ACCUM_MSB of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_ACCUM_LSB : integer;
  attribute C_ACCUM_LSB of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is -31;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_INVALID_OP : integer;
  attribute C_HAS_INVALID_OP of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_DIVIDE_BY_ZERO : integer;
  attribute C_HAS_DIVIDE_BY_ZERO of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_OVERFLOW : integer;
  attribute C_HAS_ACCUM_OVERFLOW of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW : integer;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ACLKEN : integer;
  attribute C_HAS_ACLKEN of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_ARESETN : integer;
  attribute C_HAS_ARESETN of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_THROTTLE_SCHEME : integer;
  attribute C_THROTTLE_SCHEME of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_A_TUSER : integer;
  attribute C_HAS_A_TUSER of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_A_TLAST : integer;
  attribute C_HAS_A_TLAST of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_B : integer;
  attribute C_HAS_B of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_B_TUSER : integer;
  attribute C_HAS_B_TUSER of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_B_TLAST : integer;
  attribute C_HAS_B_TLAST of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_C : integer;
  attribute C_HAS_C of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_C_TUSER : integer;
  attribute C_HAS_C_TUSER of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_C_TLAST : integer;
  attribute C_HAS_C_TLAST of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION : integer;
  attribute C_HAS_OPERATION of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TUSER : integer;
  attribute C_HAS_OPERATION_TUSER of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TLAST : integer;
  attribute C_HAS_OPERATION_TLAST of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 0;
  attribute C_HAS_RESULT_TUSER : integer;
  attribute C_HAS_RESULT_TUSER of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_HAS_RESULT_TLAST : integer;
  attribute C_HAS_RESULT_TLAST of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_TLAST_RESOLUTION : integer;
  attribute C_TLAST_RESOLUTION of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_A_TDATA_WIDTH : integer;
  attribute C_A_TDATA_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_A_TUSER_WIDTH : integer;
  attribute C_A_TUSER_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_B_TDATA_WIDTH : integer;
  attribute C_B_TDATA_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_B_TUSER_WIDTH : integer;
  attribute C_B_TUSER_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_C_TDATA_WIDTH : integer;
  attribute C_C_TDATA_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_C_TUSER_WIDTH : integer;
  attribute C_C_TUSER_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_OPERATION_TDATA_WIDTH : integer;
  attribute C_OPERATION_TDATA_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 8;
  attribute C_OPERATION_TUSER_WIDTH : integer;
  attribute C_OPERATION_TUSER_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 1;
  attribute C_RESULT_TDATA_WIDTH : integer;
  attribute C_RESULT_TDATA_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 32;
  attribute C_RESULT_TUSER_WIDTH : integer;
  attribute C_RESULT_TUSER_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is 10;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ : entity is "yes";
end \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\;

architecture STRUCTURE of \ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CI\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/D\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/chunk_det\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/I0\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/O\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/ext_del_distance\ : STD_LOGIC_VECTOR ( 5 downto 4 );
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in10_in\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in13_in\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in16_in\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in4_in\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in7_in\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/A_MANT_ALL_ZERO_P0_DEL/i_pipe/first_q\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\ : signal is "true";
  signal \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\ : signal is "true";
  signal \FLT_TO_FIX_OP.SPD.OP/DEL_SIGN/i_pipe/first_q\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/first_q\ : signal is "true";
  signal \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 22 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/NEG_MANT_OVER_P0_DEL/i_pipe/first_q\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/OVERFLOW0\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/first_q\ : signal is "true";
  signal \FLT_TO_FIX_OP.SPD.OP/ROUND/O\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 33 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/SIGN_DEL/i_pipe/first_q\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/SIGN_P0_REG/i_pipe/first_q\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \FLT_TO_FIX_OP.SPD.OP/overflow_p1_updated2\ : STD_LOGIC;
  signal \FLT_TO_FIX_OP.SPD.OP/overflow_pr\ : STD_LOGIC;
  signal GND_2 : STD_LOGIC;
  signal ce_internal_core : STD_LOGIC;
  signal combiner_data_valid : STD_LOGIC;
  signal \i_nd_to_rdy/first_q\ : STD_LOGIC;
  attribute RTL_KEEP of \i_nd_to_rdy/first_q\ : signal is "true";
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal lopt_10 : STD_LOGIC;
  signal lopt_2 : STD_LOGIC;
  signal lopt_3 : STD_LOGIC;
  signal lopt_4 : STD_LOGIC;
  signal lopt_5 : STD_LOGIC;
  signal lopt_6 : STD_LOGIC;
  signal lopt_7 : STD_LOGIC;
  signal lopt_8 : STD_LOGIC;
  signal lopt_9 : STD_LOGIC;
  signal \^m_axis_result_tdata\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^m_axis_result_tvalid\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[10].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[11].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[12].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[13].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[14].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[15].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[16].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[17].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[18].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[19].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[20].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[21].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[22].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[23].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[24].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[25].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[26].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[27].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[28].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[29].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[30].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[31].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__0\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[8].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_CHAIN_GEN[9].C_MUX.CARRY_MUX_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[1].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[2].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[3].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].OTHER_LEVELS.DO_CHUNKS[0].LUT6_STRUCT_MUX.MUX1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[0]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[10]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[11]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[12]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[13]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[14]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[15]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[16]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[17]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[18]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[19]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[1]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[20]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[21]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[22]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[23]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[24]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[25]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[26]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[27]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[28]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[29]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[2]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[30]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[31]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[3]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[4]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[5]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[6]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[7]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[8]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[9]_i_1\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[0].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[10].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[10].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[11].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[11].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[12].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[12].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[13].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[13].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[14].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[14].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[15].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[15].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[16].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[16].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[17].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[17].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[18].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[18].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[19].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[19].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[1].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[1].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[20].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[20].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[21].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[21].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[22].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[22].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[23].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[23].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[24].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[24].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[25].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[25].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[26].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[26].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[27].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[27].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[28].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[28].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[29].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[29].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[2].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[2].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[30].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[30].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[31].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[31].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[33].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[3].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[3].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[4].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[4].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[5].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[5].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[6].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[6].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[7].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[7].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[8].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[8].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[9].C_MUX.CARRY_MUX\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[9].Q_XOR.SUM_XOR\ : STD_LOGIC;
  signal \n_0_FLT_TO_FIX_OP.SPD.OP/SIGN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\ : STD_LOGIC;
  signal \n_0_HAS_ARESETN.sclr_i_i_1\ : STD_LOGIC;
  signal \n_0_RESULT[30]_i_2\ : STD_LOGIC;
  signal \n_0_RESULT[31]_i_2\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg1_a_ready_i_2\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg1_a_ready_i_3\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg1_a_ready_i_4\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg1_a_tlast_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[0]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[10]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[11]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[12]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[13]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[14]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[15]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[16]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[17]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[18]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[19]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[1]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[20]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[21]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[22]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[23]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[24]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[25]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[26]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[27]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[28]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[29]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[2]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[30]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[31]_i_2\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[3]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[4]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[5]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[6]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[7]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[8]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tdata[9]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tlast_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[0]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[1]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[2]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[3]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[4]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[5]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[6]_i_1\ : STD_LOGIC;
  signal \n_0_gen_has_z_tready.reg2_a_tuser[7]_i_1\ : STD_LOGIC;
  signal \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\ : STD_LOGIC;
  signal \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[3].pipe_reg[3][0]\ : STD_LOGIC;
  signal \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\ : STD_LOGIC;
  signal \n_0_need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]_srl4\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]_srl4\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]_srl4\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]_srl4\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]_srl4\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]_srl4\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]_srl4\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]_srl4\ : STD_LOGIC;
  signal \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][8]_srl4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__10\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__11\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__12\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__5\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__6\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__7\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__8\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_1__9\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_2__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_3__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_3__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_4__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_4__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_5\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_5__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[0]_i_6\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[10]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[10]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[10]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[11]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[11]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[11]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[12]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[12]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[12]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[13]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[13]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[13]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[14]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[14]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[14]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[15]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[15]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[15]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[16]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[16]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[16]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[17]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[17]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[17]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[18]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[18]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[18]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[19]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[19]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[19]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_1__4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[1]_i_2__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[20]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[20]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[20]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[21]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[21]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[21]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[22]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[22]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[22]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[23]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[23]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[23]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[24]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[24]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[24]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[25]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[25]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[25]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[26]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[26]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[26]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[27]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[27]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[27]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[28]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[28]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[28]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[29]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[29]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[29]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_1__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[2]_i_1__4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[30]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[30]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[30]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[31]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[31]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[31]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_1__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[3]_i_1__4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[4]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[4]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[4]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[4]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[4]_i_1__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[4]_i_1__4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[5]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[5]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[5]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[5]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[5]_i_1__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[5]_i_1__4\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[6]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[6]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[6]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[6]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[6]_i_1__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[7]_i_1__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[8]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[8]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[8]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[9]_i_1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[9]_i_1__0\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[9]_i_1__1\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[9]_i_1__2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[9]_i_1__3\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[9]_i_2\ : STD_LOGIC;
  signal \n_0_opt_has_pipe.first_q[9]_i_2__0\ : STD_LOGIC;
  signal \n_1_opt_has_pipe.first_q_reg[0]_i_2\ : STD_LOGIC;
  signal \n_2_opt_has_pipe.first_q_reg[0]_i_2\ : STD_LOGIC;
  signal \n_3_opt_has_pipe.first_q_reg[0]_i_2\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/b_tx\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/p_2_out\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_ready_nxt\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid_nxt\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_ready_nxt\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid_nxt\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid_nxt\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\ : STD_LOGIC;
  signal \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\ : STD_LOGIC;
  signal \need_user_delay.user_pipe/i_pipe/first_q\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal p_2_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \pipe[5]\ : STD_LOGIC;
  signal reg1_a_tdata : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal reg1_a_tuser : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal reg2_a_tlast : STD_LOGIC;
  signal reg2_a_tuser : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^s_axis_a_tready\ : STD_LOGIC;
  signal sclr_i : STD_LOGIC;
  signal \NLW_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_opt_has_pipe.first_q_reg[0]_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[0].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type : string;
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[0].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[1].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[1].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[2].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[2].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[5].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "FDE";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[5].CARRYS_DEL.NEED_DEL.CARRYS_FD\ : label is "PRIMITIVE";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].OTHER_LEVELS.DO_CHUNKS[0].LUT6_STRUCT_MUX.MUX0\ : label is "PRIMITIVE";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].OTHER_LEVELS.DO_CHUNKS[0].LUT6_STRUCT_MUX.MUX1\ : label is "PRIMITIVE";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].OTHER_LEVELS.DO_CHUNKS[0].LUT6_STRUCT_MUX.MUX2\ : label is "PRIMITIVE";
  attribute keep : string;
  attribute keep of \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\ : label is "U0/i_synth/\FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4] ";
  attribute srl_name : string;
  attribute srl_name of \FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\ : label is "U0/i_synth/\FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3 ";
  attribute keep of \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute keep of \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.first_q_reg[1]\ : label is "yes";
  attribute srl_bus_name of \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2 ";
  attribute srl_bus_name of \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : label is "U0/i_synth/\FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\ : label is "U0/i_synth/\FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2 ";
  attribute keep of \FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute srl_bus_name of \FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3] ";
  attribute srl_name of \FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\ : label is "U0/i_synth/\FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2 ";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[16].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[16].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[20].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[20].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[24].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[24].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[28].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[28].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute box_type of \FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\ : label is "PRIMITIVE";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg1_a_ready_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg1_a_ready_i_4\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg1_a_tlast_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg1_b_ready_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[0]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[10]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[11]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[12]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[13]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[14]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[15]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[16]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[17]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[18]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[19]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[1]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[20]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[21]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[22]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[23]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[24]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[25]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[26]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[27]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[28]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[29]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[2]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[30]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[31]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[3]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[4]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[5]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[6]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[7]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[8]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tdata[9]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[0]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[1]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[2]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[3]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[4]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[5]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[6]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_tuser[7]_i_1\ : label is "soft_lutpair22";
  attribute RETAIN_INVERTER : boolean;
  attribute RETAIN_INVERTER of \gen_has_z_tready.reg2_a_valid_i_1\ : label is true;
  attribute SOFT_HLUTNM of \gen_has_z_tready.reg2_a_valid_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \gen_has_z_tready.z_valid_i_1\ : label is "soft_lutpair21";
  attribute keep of \i_nd_to_rdy/opt_has_pipe.first_q_reg[0]\ : label is "yes";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]_srl4 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]_srl4 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]_srl4 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]_srl4 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]_srl4 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]_srl4 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]_srl4 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]_srl4 ";
  attribute srl_bus_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][8]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5] ";
  attribute srl_name of \need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][8]_srl4\ : label is "U0/i_synth/\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][8]_srl4 ";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[0]_i_2__1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[3]_i_1__4\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[4]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[4]_i_1__4\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[5]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[5]_i_1__0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[7]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[9]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[9]_i_2\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \opt_has_pipe.first_q[9]_i_2__0\ : label is "soft_lutpair4";
begin
  m_axis_result_tdata(31 downto 0) <= \^m_axis_result_tdata\(31 downto 0);
  m_axis_result_tvalid <= \^m_axis_result_tvalid\;
  s_axis_a_tready <= \^s_axis_a_tready\;
  s_axis_b_tready <= \<const1>\;
  s_axis_c_tready <= \<const1>\;
  s_axis_operation_tready <= \<const1>\;
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(3),
      I1 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(1),
      I3 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(2),
      O => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/chunk_det\(0)
    );
\CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"59AA"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(1),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(0),
      O => \n_0_CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[10].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(10),
      O => \n_0_CHAIN_GEN[10].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[11].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(11),
      O => \n_0_CHAIN_GEN[11].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[12].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(12),
      O => \n_0_CHAIN_GEN[12].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[13].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(13),
      O => \n_0_CHAIN_GEN[13].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[14].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(14),
      O => \n_0_CHAIN_GEN[14].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[15].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(15),
      O => \n_0_CHAIN_GEN[15].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[16].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(16),
      O => \n_0_CHAIN_GEN[16].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[17].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(17),
      O => \n_0_CHAIN_GEN[17].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[18].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(18),
      O => \n_0_CHAIN_GEN[18].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[19].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(19),
      O => \n_0_CHAIN_GEN[19].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(7),
      I1 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(4),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(5),
      I3 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(6),
      O => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/chunk_det\(1)
    );
\CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(1),
      O => \n_0_CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[20].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(20),
      O => \n_0_CHAIN_GEN[20].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[21].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(21),
      O => \n_0_CHAIN_GEN[21].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[22].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(22),
      O => \n_0_CHAIN_GEN[22].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[23].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(23),
      O => \n_0_CHAIN_GEN[23].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[24].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(24),
      O => \n_0_CHAIN_GEN[24].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[25].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(25),
      O => \n_0_CHAIN_GEN[25].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[26].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(26),
      O => \n_0_CHAIN_GEN[26].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[27].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(27),
      O => \n_0_CHAIN_GEN[27].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[28].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(28),
      O => \n_0_CHAIN_GEN[28].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[29].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(29),
      O => \n_0_CHAIN_GEN[29].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(11),
      I1 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(8),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(9),
      I3 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(10),
      O => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/chunk_det\(2)
    );
\CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(2),
      O => \n_0_CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[30].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(30),
      O => \n_0_CHAIN_GEN[30].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[31].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(31),
      O => \n_0_CHAIN_GEN[31].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(15),
      I1 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(12),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(13),
      I3 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(14),
      O => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/chunk_det\(3)
    );
\CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(3),
      O => \n_0_CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(19),
      I1 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(16),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(17),
      I3 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(18),
      O => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/chunk_det\(4)
    );
\CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(4),
      O => \n_0_CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__0\
    );
\CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(5),
      O => \n_0_CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(6),
      O => \n_0_CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(7),
      O => \n_0_CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[8].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(8),
      O => \n_0_CHAIN_GEN[8].C_MUX.CARRY_MUX_i_1\
    );
\CHAIN_GEN[9].C_MUX.CARRY_MUX_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(9),
      O => \n_0_CHAIN_GEN[9].C_MUX.CARRY_MUX_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__6\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(24),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[2]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[3]_i_1__4\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[4]_i_1__4\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[5]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[6]_i_1__2\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[7]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[9]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(8),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[9]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(9),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__8\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[10]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(10),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[11]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(11),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[12]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(12),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[13]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(13),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[14]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(14),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[15]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(15),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[16]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(16),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[17]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(17),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[18]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(18),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[19]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(19),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[1]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[20]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(20),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[21]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(21),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[22]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(22),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[23]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(23),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[24]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(24),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[25]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(25),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[26]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(26),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[27]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(27),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[28]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(28),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[29]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(29),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[2]_i_1__2\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(2),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[30]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(30),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[31]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(31),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[3]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(3),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[4]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(4),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[5]_i_1__2\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(5),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[6]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(6),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[7]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(7),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[8]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(8),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[9]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(9),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__9\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[10]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(10),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[11]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(11),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[12]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(12),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[13]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(13),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[14]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(14),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[15]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(15),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[16]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(16),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[17]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(17),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[18]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(18),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[19]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(19),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[1]_i_1__2\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[20]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(20),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[21]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(21),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[22]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(22),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[23]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(23),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[24]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(24),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[25]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(25),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[26]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(26),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[27]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(27),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[28]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(28),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[29]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(29),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[2]_i_1__3\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(2),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[30]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(30),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[31]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(31),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[3]_i_1__2\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(3),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[4]_i_1__2\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(4),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[5]_i_1__3\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(5),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[6]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(6),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[7]_i_1__2\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(7),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[8]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(8),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[9]_i_1__2\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(9),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(2),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(3),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__10\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[10]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(10),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[11]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(11),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[12]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(12),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[13]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(13),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[14]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(14),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[15]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(15),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[16]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(16),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[17]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(17),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[18]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(18),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[19]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(19),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[1]_i_1__3\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[20]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(20),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[21]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(21),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[22]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(22),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[23]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(23),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[24]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(24),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[25]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(25),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[26]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(26),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[27]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(27),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[28]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(28),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[29]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(29),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[2]_i_1__4\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(2),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[30]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(30),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[31]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(31),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[3]_i_1__3\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(3),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[4]_i_1__3\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(4),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[5]_i_1__4\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(5),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[6]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(6),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[7]_i_1__3\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(7),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[8]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(8),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[9]_i_1__3\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(9),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(0),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(1),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      Q => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      Q => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[0].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CI\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in16_in\,
      R => GND_2
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[2].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[1].C_MUX.CARRY_MUX\,
      CO(0) => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CI\,
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3 downto 0) => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/chunk_det\(3 downto 0)
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[1].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[1].C_MUX.CARRY_MUX\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in13_in\,
      R => GND_2
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[2].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[2].C_MUX.CARRY_MUX\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in10_in\,
      R => GND_2
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      Q => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\,
      R => GND_2
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in7_in\,
      R => GND_2
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(3 downto 2) => \NLW_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/D\,
      CO(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      CYINIT => lopt_1,
      DI(3 downto 2) => \NLW_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\(3 downto 2),
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 0),
      S(3 downto 2) => \NLW_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\(3 downto 2),
      S(1) => \<const0>\,
      S(0) => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/chunk_det\(4)
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[5].CARRYS_DEL.NEED_DEL.CARRYS_FD\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/D\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in4_in\,
      R => GND_2
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__5\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(10),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(10),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(11),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(11),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(12),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(12),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(13),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(13),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(14),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(14),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(15),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(15),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[1]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[2]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(2),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[3]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(3),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[4]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(4),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[5]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(5),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(6),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(6),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(7),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(7),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(8),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(8),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(9),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(9),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__7\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(10),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(10),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(11),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(11),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(12),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(12),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(13),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(13),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(14),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(14),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(15),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(15),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[1]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(2),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(2),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(3),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(3),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(4),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(4),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(5),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(5),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(6),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(6),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(7),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(7),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(8),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(8),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(9),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(9),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(2),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(3),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/O\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(10),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(10),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(11),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(11),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(12),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(12),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(13),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(13),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(14),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(14),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(15),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(15),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(1),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(1),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(2),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(2),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(3),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(3),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(4),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(4),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(5),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(5),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(6),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(6),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(7),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(7),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(8),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(8),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(9),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].DEL_Z_D/i_pipe/first_q\(9),
      S => ce_internal_core
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].OTHER_LEVELS.DO_CHUNKS[0].LUT6_STRUCT_MUX.MUX0\: unisim.vcomponents.MUXF7
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(0),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(1),
      O => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/I0\,
      S => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/ext_del_distance\(4)
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].OTHER_LEVELS.DO_CHUNKS[0].LUT6_STRUCT_MUX.MUX1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(2),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].DEL_Z_D/i_pipe/first_q\(3),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].OTHER_LEVELS.DO_CHUNKS[0].LUT6_STRUCT_MUX.MUX1\,
      S => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/ext_del_distance\(4)
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].OTHER_LEVELS.DO_CHUNKS[0].LUT6_STRUCT_MUX.MUX2\: unisim.vcomponents.MUXF8
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/I0\,
      I1 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].OTHER_LEVELS.DO_CHUNKS[0].LUT6_STRUCT_MUX.MUX1\,
      O => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/O\,
      S => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/ext_del_distance\(5)
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(4),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \<const0>\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/ext_del_distance\(4),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      Q => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/ext_del_distance\(5),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/A_MANT_ALL_ZERO_P0_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__11\,
      Q => \FLT_TO_FIX_OP.SPD.OP/A_MANT_ALL_ZERO_P0_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__12\,
      Q => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/DEL_SIGN/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      Q => \FLT_TO_FIX_OP.SPD.OP/DEL_SIGN/i_pipe/first_q\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__4\,
      Q => \FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/first_q\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/first_q\,
      Q => \n_0_FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\
    );
\FLT_TO_FIX_OP.SPD.OP/INVALID_OP_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/INVALID_OP_P1_REG/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]_srl3\,
      Q => m_axis_result_tuser(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(0),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(10),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(10),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(11),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(11),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(12),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(12),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(13),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(13),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(14),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(14),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(15),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(15),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(16),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(16),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(17),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(17),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(18),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(18),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(19),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(19),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(1),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(20),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(20),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(21),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(21),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(22),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(22),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(2),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(2),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(3),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(3),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(4),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(4),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(5),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(5),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(6),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(6),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(7),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(7),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(8),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(8),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(9),
      Q => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(9),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/NEG_MANT_OVER_P0_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[0]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/NEG_MANT_OVER_P0_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[1]_i_1__4\,
      Q => \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/first_q\(0),
      Q => \n_0_FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\
    );
\FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/first_q\(1),
      Q => \n_0_FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\
    );
\FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\,
      Q => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][1]_srl2\,
      Q => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__3\,
      Q => \FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/first_q\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/first_q\,
      Q => \n_0_FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\
    );
\FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/OVERFLOW_P1_REG/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]_srl2\,
      Q => \FLT_TO_FIX_OP.SPD.OP/overflow_pr\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/OVERFLOW_reg\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/OVERFLOW0\,
      Q => m_axis_result_tuser(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(0),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(1),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[0]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(10),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(11),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[10]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(11),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(12),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[11]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(12),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(13),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[12]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(13),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(14),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[13]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(14),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(15),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[14]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(15),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(16),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[15]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(16),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(17),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[16]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(17),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(18),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[17]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(18),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(19),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[18]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(19),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(20),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[19]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(1),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(2),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[1]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(20),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(21),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[20]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(21),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(22),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[21]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(22),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(23),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[22]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(23),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(24),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[23]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(24),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(25),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[24]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(25),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(26),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[25]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(26),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(27),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[26]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(27),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(28),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[27]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(28),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(29),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[28]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(29),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(30),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[29]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(2),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(3),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[2]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(30),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(31),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[30]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B88BB888B888B888"
    )
    port map (
      I0 => \^m_axis_result_tdata\(31),
      I1 => \n_0_RESULT[31]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(1),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(32),
      I5 => \FLT_TO_FIX_OP.SPD.OP/DEL_SIGN/i_pipe/first_q\,
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[31]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(3),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(4),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[3]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(4),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(5),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[4]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(5),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(6),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[5]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(6),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(7),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[6]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(7),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(8),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[7]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(8),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(9),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[8]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AA00FCFCAAFC"
    )
    port map (
      I0 => \^m_axis_result_tdata\(9),
      I1 => \n_0_RESULT[30]_i_2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(10),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[9]_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[0]_i_1\,
      Q => \^m_axis_result_tdata\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[10]_i_1\,
      Q => \^m_axis_result_tdata\(10),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[11]_i_1\,
      Q => \^m_axis_result_tdata\(11),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[12]_i_1\,
      Q => \^m_axis_result_tdata\(12),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[13]_i_1\,
      Q => \^m_axis_result_tdata\(13),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[14]_i_1\,
      Q => \^m_axis_result_tdata\(14),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[15]_i_1\,
      Q => \^m_axis_result_tdata\(15),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[16]_i_1\,
      Q => \^m_axis_result_tdata\(16),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[17]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[17]_i_1\,
      Q => \^m_axis_result_tdata\(17),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[18]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[18]_i_1\,
      Q => \^m_axis_result_tdata\(18),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[19]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[19]_i_1\,
      Q => \^m_axis_result_tdata\(19),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[1]_i_1\,
      Q => \^m_axis_result_tdata\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[20]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[20]_i_1\,
      Q => \^m_axis_result_tdata\(20),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[21]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[21]_i_1\,
      Q => \^m_axis_result_tdata\(21),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[22]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[22]_i_1\,
      Q => \^m_axis_result_tdata\(22),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[23]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[23]_i_1\,
      Q => \^m_axis_result_tdata\(23),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[24]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[24]_i_1\,
      Q => \^m_axis_result_tdata\(24),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[25]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[25]_i_1\,
      Q => \^m_axis_result_tdata\(25),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[26]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[26]_i_1\,
      Q => \^m_axis_result_tdata\(26),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[27]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[27]_i_1\,
      Q => \^m_axis_result_tdata\(27),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[28]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[28]_i_1\,
      Q => \^m_axis_result_tdata\(28),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[29]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[29]_i_1\,
      Q => \^m_axis_result_tdata\(29),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[2]_i_1\,
      Q => \^m_axis_result_tdata\(2),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[30]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[30]_i_1\,
      Q => \^m_axis_result_tdata\(30),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[31]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[31]_i_1\,
      Q => \^m_axis_result_tdata\(31),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[3]_i_1\,
      Q => \^m_axis_result_tdata\(3),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[4]_i_1\,
      Q => \^m_axis_result_tdata\(4),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[5]_i_1\,
      Q => \^m_axis_result_tdata\(5),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[6]_i_1\,
      Q => \^m_axis_result_tdata\(6),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[7]_i_1\,
      Q => \^m_axis_result_tdata\(7),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[8]_i_1\,
      Q => \^m_axis_result_tdata\(8),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/RESULT_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/RESULT[9]_i_1\,
      Q => \^m_axis_result_tdata\(9),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => lopt_2,
      CO(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[2].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[1].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[0].C_MUX.CARRY_MUX\,
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[3].Q_XOR.SUM_XOR\,
      O(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[2].Q_XOR.SUM_XOR\,
      O(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[1].Q_XOR.SUM_XOR\,
      O(0) => \FLT_TO_FIX_OP.SPD.OP/ROUND/O\,
      S(3) => \n_0_CHAIN_GEN[3].C_MUX.CARRY_MUX_i_1__0\,
      S(2) => \n_0_CHAIN_GEN[2].C_MUX.CARRY_MUX_i_1__0\,
      S(1) => \n_0_CHAIN_GEN[1].C_MUX.CARRY_MUX_i_1__0\,
      S(0) => \n_0_CHAIN_GEN[0].C_MUX.CARRY_MUX_i_1__0\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[0].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_2
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[11].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[15].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[14].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[13].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[12].C_MUX.CARRY_MUX\,
      CYINIT => lopt_5,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[15].Q_XOR.SUM_XOR\,
      O(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[14].Q_XOR.SUM_XOR\,
      O(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[13].Q_XOR.SUM_XOR\,
      O(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[12].Q_XOR.SUM_XOR\,
      S(3) => \n_0_CHAIN_GEN[15].C_MUX.CARRY_MUX_i_1\,
      S(2) => \n_0_CHAIN_GEN[14].C_MUX.CARRY_MUX_i_1\,
      S(1) => \n_0_CHAIN_GEN[13].C_MUX.CARRY_MUX_i_1\,
      S(0) => \n_0_CHAIN_GEN[12].C_MUX.CARRY_MUX_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[12].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_5
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[16].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[15].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[19].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[18].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[17].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[16].C_MUX.CARRY_MUX\,
      CYINIT => lopt_6,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[19].Q_XOR.SUM_XOR\,
      O(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[18].Q_XOR.SUM_XOR\,
      O(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[17].Q_XOR.SUM_XOR\,
      O(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[16].Q_XOR.SUM_XOR\,
      S(3) => \n_0_CHAIN_GEN[19].C_MUX.CARRY_MUX_i_1\,
      S(2) => \n_0_CHAIN_GEN[18].C_MUX.CARRY_MUX_i_1\,
      S(1) => \n_0_CHAIN_GEN[17].C_MUX.CARRY_MUX_i_1\,
      S(0) => \n_0_CHAIN_GEN[16].C_MUX.CARRY_MUX_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[16].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_6
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[20].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[19].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[23].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[22].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[21].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[20].C_MUX.CARRY_MUX\,
      CYINIT => lopt_7,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[23].Q_XOR.SUM_XOR\,
      O(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[22].Q_XOR.SUM_XOR\,
      O(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[21].Q_XOR.SUM_XOR\,
      O(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[20].Q_XOR.SUM_XOR\,
      S(3) => \n_0_CHAIN_GEN[23].C_MUX.CARRY_MUX_i_1\,
      S(2) => \n_0_CHAIN_GEN[22].C_MUX.CARRY_MUX_i_1\,
      S(1) => \n_0_CHAIN_GEN[21].C_MUX.CARRY_MUX_i_1\,
      S(0) => \n_0_CHAIN_GEN[20].C_MUX.CARRY_MUX_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[20].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_7
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[24].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[23].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[27].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[26].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[25].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[24].C_MUX.CARRY_MUX\,
      CYINIT => lopt_8,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[27].Q_XOR.SUM_XOR\,
      O(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[26].Q_XOR.SUM_XOR\,
      O(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[25].Q_XOR.SUM_XOR\,
      O(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[24].Q_XOR.SUM_XOR\,
      S(3) => \n_0_CHAIN_GEN[27].C_MUX.CARRY_MUX_i_1\,
      S(2) => \n_0_CHAIN_GEN[26].C_MUX.CARRY_MUX_i_1\,
      S(1) => \n_0_CHAIN_GEN[25].C_MUX.CARRY_MUX_i_1\,
      S(0) => \n_0_CHAIN_GEN[24].C_MUX.CARRY_MUX_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[24].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_8
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[28].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[27].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[31].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[30].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[29].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[28].C_MUX.CARRY_MUX\,
      CYINIT => lopt_9,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[31].Q_XOR.SUM_XOR\,
      O(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[30].Q_XOR.SUM_XOR\,
      O(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[29].Q_XOR.SUM_XOR\,
      O(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[28].Q_XOR.SUM_XOR\,
      S(3) => \n_0_CHAIN_GEN[31].C_MUX.CARRY_MUX_i_1\,
      S(2) => \n_0_CHAIN_GEN[30].C_MUX.CARRY_MUX_i_1\,
      S(1) => \n_0_CHAIN_GEN[29].C_MUX.CARRY_MUX_i_1\,
      S(0) => \n_0_CHAIN_GEN[28].C_MUX.CARRY_MUX_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[28].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_9
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[31].C_MUX.CARRY_MUX\,
      CO(3 downto 0) => \NLW_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4_CO_UNCONNECTED\(3 downto 0),
      CYINIT => lopt_10,
      DI(3 downto 1) => \NLW_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4_DI_UNCONNECTED\(3 downto 1),
      DI(0) => \<const0>\,
      O(3 downto 2) => \NLW_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4_O_UNCONNECTED\(3 downto 2),
      O(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[33].Q_XOR.SUM_XOR\,
      O(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].Q_XOR.SUM_XOR\,
      S(3 downto 2) => \NLW_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4_S_UNCONNECTED\(3 downto 2),
      S(1) => \<const0>\,
      S(0) => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_10
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[3].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[6].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[5].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[4].C_MUX.CARRY_MUX\,
      CYINIT => lopt_3,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[7].Q_XOR.SUM_XOR\,
      O(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[6].Q_XOR.SUM_XOR\,
      O(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[5].Q_XOR.SUM_XOR\,
      O(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[4].Q_XOR.SUM_XOR\,
      S(3) => \n_0_CHAIN_GEN[7].C_MUX.CARRY_MUX_i_1\,
      S(2) => \n_0_CHAIN_GEN[6].C_MUX.CARRY_MUX_i_1\,
      S(1) => \n_0_CHAIN_GEN[5].C_MUX.CARRY_MUX_i_1\,
      S(0) => \n_0_CHAIN_GEN[4].C_MUX.CARRY_MUX_i_1__0\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[4].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_3
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[7].C_MUX.CARRY_MUX\,
      CO(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[11].C_MUX.CARRY_MUX\,
      CO(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[10].C_MUX.CARRY_MUX\,
      CO(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[9].C_MUX.CARRY_MUX\,
      CO(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[8].C_MUX.CARRY_MUX\,
      CYINIT => lopt_4,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[11].Q_XOR.SUM_XOR\,
      O(2) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[10].Q_XOR.SUM_XOR\,
      O(1) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[9].Q_XOR.SUM_XOR\,
      O(0) => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[8].Q_XOR.SUM_XOR\,
      S(3) => \n_0_CHAIN_GEN[11].C_MUX.CARRY_MUX_i_1\,
      S(2) => \n_0_CHAIN_GEN[10].C_MUX.CARRY_MUX_i_1\,
      S(1) => \n_0_CHAIN_GEN[9].C_MUX.CARRY_MUX_i_1\,
      S(0) => \n_0_CHAIN_GEN[8].C_MUX.CARRY_MUX_i_1\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[8].C_MUX.CARRY_MUX_CARRY4_GND\: unisim.vcomponents.GND
    port map (
      G => lopt_4
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ROUND/O\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[10].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(10),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[11].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(11),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[12].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(12),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[13].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(13),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[14].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(14),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[15].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(15),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[16].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(16),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[17].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(17),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[18].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(18),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[19].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(19),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[1].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[20].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(20),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[21].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(21),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[22].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(22),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[23].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(23),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[24].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(24),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[25].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(25),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[26].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(26),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[27].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(27),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[28].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(28),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[29].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(29),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[2].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[30].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(30),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[31].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(31),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[32].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(32),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[33].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(33),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[3].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[4].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[5].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[6].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[7].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[8].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(8),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/ROUND/CHAIN_GEN[9].Q_XOR.SUM_XOR\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(9),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(1),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(11),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(10),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(12),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(11),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(13),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(12),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(14),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(13),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(15),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(14),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(16),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(15),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(17),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(16),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(18),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(17),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(19),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(18),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(20),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(19),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(2),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(21),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(20),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(22),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(21),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(23),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(22),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(24),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(23),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(25),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(24),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(26),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(25),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(27),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(26),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(28),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(27),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(29),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(28),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(30),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(29),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(3),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(31),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(30),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(31),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(4),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(5),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(6),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(7),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(8),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(9),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(8),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].DEL_SHIFT/i_pipe/first_q\(10),
      Q => \FLT_TO_FIX_OP.SPD.OP/ROUND_BYPASS_DEL/i_pipe/first_q\(9),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/SIGN_DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/SIGN_P0_REG/i_pipe/first_q\,
      Q => \FLT_TO_FIX_OP.SPD.OP/SIGN_DEL/i_pipe/first_q\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/SIGN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \FLT_TO_FIX_OP.SPD.OP/SIGN_DEL/i_pipe/first_q\,
      Q => \n_0_FLT_TO_FIX_OP.SPD.OP/SIGN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/SIGN_DEL/i_pipe/opt_has_pipe.i_pipe[3].pipe_reg[3][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_FLT_TO_FIX_OP.SPD.OP/SIGN_DEL/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      Q => \FLT_TO_FIX_OP.SPD.OP/a_sign_pza\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/SIGN_P0_REG/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(31),
      Q => \FLT_TO_FIX_OP.SPD.OP/SIGN_P0_REG/i_pipe/first_q\,
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__6\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(0),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => p_2_out(24),
      Q => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(1),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[2]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(2),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[3]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(3),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[4]_i_1\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(4),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[5]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(5),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[6]_i_1__3\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(6),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[7]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(7),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[9]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(8),
      R => \<const0>\
    );
\FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/opt_has_pipe.first_q_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_opt_has_pipe.first_q[9]_i_1__0\,
      Q => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(9),
      R => \<const0>\
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
GND_1: unisim.vcomponents.GND
    port map (
      G => GND_2
    );
\HAS_ARESETN.sclr_i_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => aresetn,
      O => \n_0_HAS_ARESETN.sclr_i_i_1\
    );
\HAS_ARESETN.sclr_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_HAS_ARESETN.sclr_i_i_1\,
      Q => sclr_i,
      R => \<const0>\
    );
OVERFLOW_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAFAAAAAAEFFAEAE"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/overflow_pr\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(1),
      I2 => \n_0_RESULT[31]_i_2\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/DEL_SIGN/i_pipe/first_q\,
      I4 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(32),
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      O => \FLT_TO_FIX_OP.SPD.OP/OVERFLOW0\
    );
\RESULT[30]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"550C5555040C0404"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(0),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ROUND/Q_DEL/i_pipe/first_q\(32),
      I2 => \FLT_TO_FIX_OP.SPD.OP/DEL_SIGN/i_pipe/first_q\,
      I3 => m_axis_result_tready,
      I4 => \^m_axis_result_tvalid\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/op_state_pcntrl\(1),
      O => \n_0_RESULT[30]_i_2\
    );
\RESULT[31]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^m_axis_result_tvalid\,
      I1 => m_axis_result_tready,
      O => \n_0_RESULT[31]_i_2\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\gen_has_z_tready.reg1_a_ready_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => \n_0_gen_has_z_tready.reg1_a_ready_i_2\,
      I1 => \n_0_gen_has_z_tready.reg1_a_ready_i_3\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_ready_nxt\
    );
\gen_has_z_tready.reg1_a_ready_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F000007FFF7F7F"
    )
    port map (
      I0 => \^s_axis_a_tready\,
      I1 => s_axis_a_tvalid,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      I3 => \n_0_RESULT[31]_i_2\,
      I4 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      I5 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      O => \n_0_gen_has_z_tready.reg1_a_ready_i_2\
    );
\gen_has_z_tready.reg1_a_ready_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00001F0011111111"
    )
    port map (
      I0 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I1 => \n_0_gen_has_z_tready.reg1_a_ready_i_4\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      I3 => combiner_data_valid,
      I4 => \n_0_RESULT[31]_i_2\,
      I5 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      O => \n_0_gen_has_z_tready.reg1_a_ready_i_3\
    );
\gen_has_z_tready.reg1_a_ready_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^s_axis_a_tready\,
      I1 => s_axis_a_tvalid,
      O => \n_0_gen_has_z_tready.reg1_a_ready_i_4\
    );
\gen_has_z_tready.reg1_a_tdata[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080808000800080"
    )
    port map (
      I0 => s_axis_a_tvalid,
      I1 => \^s_axis_a_tready\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      I4 => m_axis_result_tready,
      I5 => \^m_axis_result_tvalid\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\
    );
\gen_has_z_tready.reg1_a_tlast_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFBF0080"
    )
    port map (
      I0 => s_axis_a_tlast,
      I1 => s_axis_a_tvalid,
      I2 => \^s_axis_a_tready\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      I4 => \n_0_need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\,
      O => \n_0_gen_has_z_tready.reg1_a_tlast_i_1\
    );
\gen_has_z_tready.reg1_a_valid_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F3AAA2AAA2AAA2AA"
    )
    port map (
      I0 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      I2 => \n_0_RESULT[31]_i_2\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      I4 => s_axis_a_tvalid,
      I5 => \^s_axis_a_tready\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid_nxt\
    );
\gen_has_z_tready.reg1_b_ready_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"07"
    )
    port map (
      I0 => \n_0_gen_has_z_tready.reg1_a_ready_i_3\,
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid_nxt\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_ready_nxt\
    );
\gen_has_z_tready.reg1_b_valid_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4FFF004F00FF00"
    )
    port map (
      I0 => m_axis_result_tready,
      I1 => \^m_axis_result_tvalid\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I4 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      I5 => \need_combiner.use_2to1.skid_buffer_combiner/b_tx\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid_nxt\
    );
\gen_has_z_tready.reg2_a_tdata[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(0),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(0),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[0]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(10),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(10),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[10]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(11),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(11),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[11]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(12),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(12),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[12]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(13),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(13),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[13]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(14),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(14),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[14]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(15),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(15),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[15]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(16),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(16),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[16]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(17),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(17),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[17]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(18),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(18),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[18]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(19),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(19),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[19]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(1),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(1),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[1]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(20),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(20),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[20]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(21),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(21),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[21]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(22),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(22),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[22]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(23),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(23),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[23]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(24),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(24),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[24]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(25),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(25),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[25]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(26),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(26),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[26]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(27),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(27),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[27]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(28),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(28),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[28]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(29),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(29),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[29]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(2),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(2),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[2]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(30),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(30),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[30]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"D0FF"
    )
    port map (
      I0 => \^m_axis_result_tvalid\,
      I1 => m_axis_result_tready,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\
    );
\gen_has_z_tready.reg2_a_tdata[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(31),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(31),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[31]_i_2\
    );
\gen_has_z_tready.reg2_a_tdata[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(3),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(3),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[3]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(4),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(4),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[4]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(5),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(5),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[5]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(6),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(6),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[6]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(7),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(7),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[7]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(8),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(8),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[8]_i_1\
    );
\gen_has_z_tready.reg2_a_tdata[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tdata(9),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tdata(9),
      O => \n_0_gen_has_z_tready.reg2_a_tdata[9]_i_1\
    );
\gen_has_z_tready.reg2_a_tlast_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
    port map (
      I0 => \n_0_need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\,
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tlast,
      I3 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      I4 => reg2_a_tlast,
      O => \n_0_gen_has_z_tready.reg2_a_tlast_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(0),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(0),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[0]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(1),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(1),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[1]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(2),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(2),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[2]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(3),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(3),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[3]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(4),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(4),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[4]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(5),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(5),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[5]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(6),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(6),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[6]_i_1\
    );
\gen_has_z_tready.reg2_a_tuser[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reg1_a_tuser(7),
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      I2 => s_axis_a_tuser(7),
      O => \n_0_gen_has_z_tready.reg2_a_tuser[7]_i_1\
    );
\gen_has_z_tready.reg2_a_valid_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_gen_has_z_tready.reg1_a_ready_i_3\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid_nxt\
    );
\gen_has_z_tready.reg2_b_valid_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFA8FFFCFCFCFC"
    )
    port map (
      I0 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      I1 => \need_combiner.use_2to1.skid_buffer_combiner/b_tx\,
      I2 => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      I3 => combiner_data_valid,
      I4 => \n_0_RESULT[31]_i_2\,
      I5 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\
    );
\gen_has_z_tready.z_valid_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\,
      I1 => \n_0_gen_has_z_tready.reg1_a_ready_i_3\,
      O => \need_combiner.use_2to1.skid_buffer_combiner/p_2_out\
    );
\i_nd_to_rdy/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_opt_has_pipe.first_q[0]_i_1__2\,
      Q => \i_nd_to_rdy/first_q\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \i_nd_to_rdy/first_q\,
      Q => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[3].pipe_reg[3][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      Q => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[3].pipe_reg[3][0]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[3].pipe_reg[3][0]\,
      Q => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[5].pipe_reg[5][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_i_nd_to_rdy/opt_has_pipe.i_pipe[4].pipe_reg[4][0]\,
      Q => \pipe[5]\,
      R => sclr_i
    );
\i_nd_to_rdy/opt_has_pipe.i_pipe[6].pipe_reg[6][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \pipe[5]\,
      Q => \^m_axis_result_tvalid\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_ready_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_ready_nxt\,
      Q => \^s_axis_a_tready\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(0),
      Q => reg1_a_tdata(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(10),
      Q => reg1_a_tdata(10),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(11),
      Q => reg1_a_tdata(11),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(12),
      Q => reg1_a_tdata(12),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(13),
      Q => reg1_a_tdata(13),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(14),
      Q => reg1_a_tdata(14),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(15),
      Q => reg1_a_tdata(15),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(16),
      Q => reg1_a_tdata(16),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(17),
      Q => reg1_a_tdata(17),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(18),
      Q => reg1_a_tdata(18),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(19),
      Q => reg1_a_tdata(19),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(1),
      Q => reg1_a_tdata(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(20),
      Q => reg1_a_tdata(20),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(21),
      Q => reg1_a_tdata(21),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(22),
      Q => reg1_a_tdata(22),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(23),
      Q => reg1_a_tdata(23),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(24),
      Q => reg1_a_tdata(24),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(25),
      Q => reg1_a_tdata(25),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(26),
      Q => reg1_a_tdata(26),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(27),
      Q => reg1_a_tdata(27),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(28),
      Q => reg1_a_tdata(28),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(29),
      Q => reg1_a_tdata(29),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(2),
      Q => reg1_a_tdata(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(30),
      Q => reg1_a_tdata(30),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(31),
      Q => reg1_a_tdata(31),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(3),
      Q => reg1_a_tdata(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(4),
      Q => reg1_a_tdata(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(5),
      Q => reg1_a_tdata(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(6),
      Q => reg1_a_tdata(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(7),
      Q => reg1_a_tdata(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(8),
      Q => reg1_a_tdata(8),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tdata_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tdata(9),
      Q => reg1_a_tdata(9),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_gen_has_z_tready.reg1_a_tlast_i_1\,
      Q => \n_0_need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tlast_reg\,
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(0),
      Q => reg1_a_tuser(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(1),
      Q => reg1_a_tuser(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(2),
      Q => reg1_a_tuser(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(3),
      Q => reg1_a_tuser(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(4),
      Q => reg1_a_tuser(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(5),
      Q => reg1_a_tuser(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(6),
      Q => reg1_a_tuser(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_tuser_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_tlast\,
      D => s_axis_a_tuser(7),
      Q => reg1_a_tuser(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_a_valid_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid_nxt\,
      Q => \need_combiner.use_2to1.skid_buffer_combiner/reg1_a_valid\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_ready_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_ready_nxt\,
      Q => \need_combiner.use_2to1.skid_buffer_combiner/b_tx\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg1_b_valid_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid_nxt\,
      Q => \need_combiner.use_2to1.skid_buffer_combiner/reg1_b_valid\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[0]_i_1\,
      Q => p_2_out(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[10]_i_1\,
      Q => p_2_out(10),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[11]_i_1\,
      Q => p_2_out(11),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[12]_i_1\,
      Q => p_2_out(12),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[13]_i_1\,
      Q => p_2_out(13),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[14]_i_1\,
      Q => p_2_out(14),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[15]_i_1\,
      Q => p_2_out(15),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[16]_i_1\,
      Q => p_2_out(16),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[17]_i_1\,
      Q => p_2_out(17),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[18]_i_1\,
      Q => p_2_out(18),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[19]_i_1\,
      Q => p_2_out(19),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[1]_i_1\,
      Q => p_2_out(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[20]_i_1\,
      Q => p_2_out(20),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[21]_i_1\,
      Q => p_2_out(21),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[22]_i_1\,
      Q => p_2_out(22),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[23]_i_1\,
      Q => p_2_out(23),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[24]_i_1\,
      Q => p_2_out(24),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[25]_i_1\,
      Q => p_2_out(25),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[26]_i_1\,
      Q => p_2_out(26),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[27]_i_1\,
      Q => p_2_out(27),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[28]_i_1\,
      Q => p_2_out(28),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[29]_i_1\,
      Q => p_2_out(29),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[2]_i_1\,
      Q => p_2_out(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[30]_i_1\,
      Q => p_2_out(30),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[31]_i_2\,
      Q => p_2_out(31),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[3]_i_1\,
      Q => p_2_out(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[4]_i_1\,
      Q => p_2_out(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[5]_i_1\,
      Q => p_2_out(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[6]_i_1\,
      Q => p_2_out(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[7]_i_1\,
      Q => p_2_out(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[8]_i_1\,
      Q => p_2_out(8),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tdata_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tdata[9]_i_1\,
      Q => p_2_out(9),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tlast_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \n_0_gen_has_z_tready.reg2_a_tlast_i_1\,
      Q => reg2_a_tlast,
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[0]_i_1\,
      Q => reg2_a_tuser(0),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[1]_i_1\,
      Q => reg2_a_tuser(1),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[2]_i_1\,
      Q => reg2_a_tuser(2),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[3]_i_1\,
      Q => reg2_a_tuser(3),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[4]_i_1\,
      Q => reg2_a_tuser(4),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[5]_i_1\,
      Q => reg2_a_tuser(5),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[6]_i_1\,
      Q => reg2_a_tuser(6),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_tuser_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_tlast\,
      D => \n_0_gen_has_z_tready.reg2_a_tuser[7]_i_1\,
      Q => reg2_a_tuser(7),
      R => \<const0>\
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_a_valid_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid_nxt\,
      Q => \need_combiner.use_2to1.skid_buffer_combiner/reg2_a_valid\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.reg2_b_valid_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid_nxt\,
      Q => \need_combiner.use_2to1.skid_buffer_combiner/reg2_b_valid\,
      R => sclr_i
    );
\need_combiner.use_2to1.skid_buffer_combiner/gen_has_z_tready.z_valid_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => \<const1>\,
      D => \need_combiner.use_2to1.skid_buffer_combiner/p_2_out\,
      Q => combiner_data_valid,
      R => sclr_i
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => reg2_a_tuser(0),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(0),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => reg2_a_tuser(1),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(1),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => reg2_a_tuser(2),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(2),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => reg2_a_tuser(3),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(3),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => reg2_a_tuser(4),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(4),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => reg2_a_tuser(5),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(5),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => reg2_a_tuser(6),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(6),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => reg2_a_tuser(7),
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(7),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.first_q_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => reg2_a_tlast,
      Q => \need_user_delay.user_pipe/i_pipe/first_q\(8),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]_srl4\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(0),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]_srl4\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]_srl4\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(1),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]_srl4\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]_srl4\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(2),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]_srl4\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]_srl4\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(3),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]_srl4\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]_srl4\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(4),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]_srl4\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]_srl4\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(5),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]_srl4\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]_srl4\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(6),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]_srl4\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]_srl4\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(7),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]_srl4\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][8]_srl4\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => ce_internal_core,
      CLK => aclk,
      D => \need_user_delay.user_pipe/i_pipe/first_q\(8),
      Q => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][8]_srl4\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][0]_srl4\,
      Q => m_axis_result_tuser(2),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][1]_srl4\,
      Q => m_axis_result_tuser(3),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][2]_srl4\,
      Q => m_axis_result_tuser(4),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][3]_srl4\,
      Q => m_axis_result_tuser(5),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][4]_srl4\,
      Q => m_axis_result_tuser(6),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][5]_srl4\,
      Q => m_axis_result_tuser(7),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][6]_srl4\,
      Q => m_axis_result_tuser(8),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][7]_srl4\,
      Q => m_axis_result_tuser(9),
      R => \<const0>\
    );
\need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[6].pipe_reg[6][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => aclk,
      CE => ce_internal_core,
      D => \n_0_need_user_delay.user_pipe/i_pipe/opt_has_pipe.i_pipe[5].pipe_reg[5][8]_srl4\,
      Q => m_axis_result_tlast,
      R => \<const0>\
    );
\opt_has_pipe.first_q[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5D51"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[0]_i_1__11\,
      I1 => \^m_axis_result_tvalid\,
      I2 => m_axis_result_tready,
      I3 => \FLT_TO_FIX_OP.SPD.OP/NEG_MANT_OVER_P0_DEL/i_pipe/first_q\,
      O => \n_0_opt_has_pipe.first_q[0]_i_1\
    );
\opt_has_pipe.first_q[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0000FFD0FFD0"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[0]_i_2\,
      I1 => \n_0_opt_has_pipe.first_q[0]_i_3\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/SIGN_P0_REG/i_pipe/first_q\,
      I3 => \n_0_opt_has_pipe.first_q[0]_i_4__0\,
      I4 => \FLT_TO_FIX_OP.SPD.OP/OP_STATE_P1_REG/i_pipe/first_q\(0),
      I5 => \n_0_RESULT[31]_i_2\,
      O => \n_0_opt_has_pipe.first_q[0]_i_1__0\
    );
\opt_has_pipe.first_q[0]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B888888888888888"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I1 => \n_0_RESULT[31]_i_2\,
      I2 => p_2_out(29),
      I3 => p_2_out(23),
      I4 => p_2_out(30),
      I5 => \n_0_opt_has_pipe.first_q[0]_i_2__1\,
      O => \n_0_opt_has_pipe.first_q[0]_i_1__1\
    );
\opt_has_pipe.first_q[0]_i_1__10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(3),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(1),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(2),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[0]_i_1__10\
    );
\opt_has_pipe.first_q[0]_i_1__11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[0]_i_2__2\,
      I1 => \n_0_opt_has_pipe.first_q[0]_i_3__0\,
      I2 => \n_0_opt_has_pipe.first_q[0]_i_4__1\,
      I3 => \n_0_opt_has_pipe.first_q[0]_i_5__0\,
      O => \n_0_opt_has_pipe.first_q[0]_i_1__11\
    );
\opt_has_pipe.first_q[0]_i_1__12\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => p_2_out(25),
      I1 => p_2_out(24),
      I2 => \n_0_opt_has_pipe.first_q[0]_i_2__3\,
      O => \n_0_opt_has_pipe.first_q[0]_i_1__12\
    );
\opt_has_pipe.first_q[0]_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
    port map (
      I0 => \i_nd_to_rdy/first_q\,
      I1 => \^m_axis_result_tvalid\,
      I2 => m_axis_result_tready,
      I3 => combiner_data_valid,
      O => \n_0_opt_has_pipe.first_q[0]_i_1__2\
    );
\opt_has_pipe.first_q[0]_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA2AAA2AAA2AFFFF"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[0]_i_3\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/overflow_p1_updated2\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/SIGN_P0_REG/i_pipe/first_q\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/NEG_MANT_OVER_P0_DEL/i_pipe/first_q\,
      I4 => \n_0_opt_has_pipe.first_q[0]_i_2\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      O => \n_0_opt_has_pipe.first_q[0]_i_1__3\
    );
\opt_has_pipe.first_q[0]_i_1__4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"2A"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/A_MANT_ALL_ZERO_P0_DEL/i_pipe/first_q\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      O => \n_0_opt_has_pipe.first_q[0]_i_1__4\
    );
\opt_has_pipe.first_q[0]_i_1__5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000755FF"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(0),
      I1 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(2),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(1),
      I3 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(0),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[0]_i_1__5\
    );
\opt_has_pipe.first_q[0]_i_1__6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => p_2_out(23),
      O => \n_0_opt_has_pipe.first_q[0]_i_1__6\
    );
\opt_has_pipe.first_q[0]_i_1__7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B888BBBBB8888888"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[0]_i_2__0\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in13_in\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(2),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[0]_i_1__7\
    );
\opt_has_pipe.first_q[0]_i_1__8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(8),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[0]_i_1__8\
    );
\opt_has_pipe.first_q[0]_i_1__9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(12),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(4),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(8),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[0]_i_1__9\
    );
\opt_has_pipe.first_q[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/A_MANT_ALL_ZERO_P0_DEL/i_pipe/first_q\,
      O => \n_0_opt_has_pipe.first_q[0]_i_2\
    );
\opt_has_pipe.first_q[0]_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8F808080"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in10_in\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(3),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in16_in\,
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__0\
    );
\opt_has_pipe.first_q[0]_i_2__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
    port map (
      I0 => p_2_out(27),
      I1 => p_2_out(25),
      I2 => p_2_out(24),
      I3 => p_2_out(26),
      I4 => p_2_out(28),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__1\
    );
\opt_has_pipe.first_q[0]_i_2__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_2_out(6),
      I1 => p_2_out(5),
      I2 => p_2_out(9),
      I3 => p_2_out(10),
      I4 => p_2_out(7),
      I5 => p_2_out(8),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__2\
    );
\opt_has_pipe.first_q[0]_i_2__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_2_out(27),
      I1 => p_2_out(26),
      I2 => p_2_out(30),
      I3 => p_2_out(29),
      I4 => p_2_out(28),
      I5 => p_2_out(23),
      O => \n_0_opt_has_pipe.first_q[0]_i_2__3\
    );
\opt_has_pipe.first_q[0]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0070"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/A_MANT_ALL_ZERO_P0_DEL/i_pipe/first_q\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(9),
      I3 => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      O => \n_0_opt_has_pipe.first_q[0]_i_3\
    );
\opt_has_pipe.first_q[0]_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => p_2_out(3),
      I1 => p_2_out(4),
      I2 => p_2_out(1),
      I3 => p_2_out(2),
      I4 => p_2_out(0),
      O => \n_0_opt_has_pipe.first_q[0]_i_3__0\
    );
\opt_has_pipe.first_q[0]_i_3__1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(9),
      O => \n_0_opt_has_pipe.first_q[0]_i_3__1\
    );
\opt_has_pipe.first_q[0]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(7),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(6),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(8),
      O => \n_0_opt_has_pipe.first_q[0]_i_4\
    );
\opt_has_pipe.first_q[0]_i_4__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF4C4F4"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(9),
      I1 => \n_0_opt_has_pipe.first_q[1]_i_2__0\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/A_MANT_ALL_ZERO_P0_DEL/i_pipe/first_q\,
      I4 => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      O => \n_0_opt_has_pipe.first_q[0]_i_4__0\
    );
\opt_has_pipe.first_q[0]_i_4__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_2_out(18),
      I1 => p_2_out(17),
      I2 => p_2_out(21),
      I3 => p_2_out(22),
      I4 => p_2_out(19),
      I5 => p_2_out(20),
      O => \n_0_opt_has_pipe.first_q[0]_i_4__1\
    );
\opt_has_pipe.first_q[0]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(3),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(5),
      O => \n_0_opt_has_pipe.first_q[0]_i_5\
    );
\opt_has_pipe.first_q[0]_i_5__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_2_out(12),
      I1 => p_2_out(11),
      I2 => p_2_out(15),
      I3 => p_2_out(16),
      I4 => p_2_out(13),
      I5 => p_2_out(14),
      O => \n_0_opt_has_pipe.first_q[0]_i_5__0\
    );
\opt_has_pipe.first_q[0]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(1),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(2),
      O => \n_0_opt_has_pipe.first_q[0]_i_6\
    );
\opt_has_pipe.first_q[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(18),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(2),
      O => \n_0_opt_has_pipe.first_q[10]_i_1\
    );
\opt_has_pipe.first_q[10]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(22),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(14),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(18),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(10),
      O => \n_0_opt_has_pipe.first_q[10]_i_1__0\
    );
\opt_has_pipe.first_q[10]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(13),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(11),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(12),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(10),
      O => \n_0_opt_has_pipe.first_q[10]_i_1__1\
    );
\opt_has_pipe.first_q[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(19),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(3),
      O => \n_0_opt_has_pipe.first_q[11]_i_1\
    );
\opt_has_pipe.first_q[11]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(23),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(15),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(19),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(11),
      O => \n_0_opt_has_pipe.first_q[11]_i_1__0\
    );
\opt_has_pipe.first_q[11]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(14),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(12),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(13),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(11),
      O => \n_0_opt_has_pipe.first_q[11]_i_1__1\
    );
\opt_has_pipe.first_q[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(20),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[12]_i_1\
    );
\opt_has_pipe.first_q[12]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(24),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(16),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(20),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(12),
      O => \n_0_opt_has_pipe.first_q[12]_i_1__0\
    );
\opt_has_pipe.first_q[12]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(15),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(13),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(14),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(12),
      O => \n_0_opt_has_pipe.first_q[12]_i_1__1\
    );
\opt_has_pipe.first_q[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(21),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(5),
      O => \n_0_opt_has_pipe.first_q[13]_i_1\
    );
\opt_has_pipe.first_q[13]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(25),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(17),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(21),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(13),
      O => \n_0_opt_has_pipe.first_q[13]_i_1__0\
    );
\opt_has_pipe.first_q[13]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(16),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(14),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(15),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(13),
      O => \n_0_opt_has_pipe.first_q[13]_i_1__1\
    );
\opt_has_pipe.first_q[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(22),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(6),
      O => \n_0_opt_has_pipe.first_q[14]_i_1\
    );
\opt_has_pipe.first_q[14]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(26),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(18),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(22),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(14),
      O => \n_0_opt_has_pipe.first_q[14]_i_1__0\
    );
\opt_has_pipe.first_q[14]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(17),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(15),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(16),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(14),
      O => \n_0_opt_has_pipe.first_q[14]_i_1__1\
    );
\opt_has_pipe.first_q[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(7),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[15]_i_1\
    );
\opt_has_pipe.first_q[15]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(27),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(19),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(23),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(15),
      O => \n_0_opt_has_pipe.first_q[15]_i_1__0\
    );
\opt_has_pipe.first_q[15]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(18),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(16),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(17),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(15),
      O => \n_0_opt_has_pipe.first_q[15]_i_1__1\
    );
\opt_has_pipe.first_q[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(8),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[16]_i_1\
    );
\opt_has_pipe.first_q[16]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(28),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(20),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(24),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(16),
      O => \n_0_opt_has_pipe.first_q[16]_i_1__0\
    );
\opt_has_pipe.first_q[16]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(19),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(17),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(18),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(16),
      O => \n_0_opt_has_pipe.first_q[16]_i_1__1\
    );
\opt_has_pipe.first_q[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(9),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[17]_i_1\
    );
\opt_has_pipe.first_q[17]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(29),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(21),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(25),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(17),
      O => \n_0_opt_has_pipe.first_q[17]_i_1__0\
    );
\opt_has_pipe.first_q[17]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(20),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(18),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(19),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(17),
      O => \n_0_opt_has_pipe.first_q[17]_i_1__1\
    );
\opt_has_pipe.first_q[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(10),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[18]_i_1\
    );
\opt_has_pipe.first_q[18]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(30),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(22),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(26),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(18),
      O => \n_0_opt_has_pipe.first_q[18]_i_1__0\
    );
\opt_has_pipe.first_q[18]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(21),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(19),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(20),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(18),
      O => \n_0_opt_has_pipe.first_q[18]_i_1__1\
    );
\opt_has_pipe.first_q[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(11),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[19]_i_1\
    );
\opt_has_pipe.first_q[19]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(31),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(23),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(27),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(19),
      O => \n_0_opt_has_pipe.first_q[19]_i_1__0\
    );
\opt_has_pipe.first_q[19]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(22),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(20),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(21),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(19),
      O => \n_0_opt_has_pipe.first_q[19]_i_1__1\
    );
\opt_has_pipe.first_q[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000755FF"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(0),
      I1 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(6),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(5),
      I3 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(4),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[1]_i_1\
    );
\opt_has_pipe.first_q[1]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DFD5D5D555555555"
    )
    port map (
      I0 => \n_0_opt_has_pipe.first_q[1]_i_2\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(7),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in7_in\,
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(5),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[1]_i_1__0\
    );
\opt_has_pipe.first_q[1]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(9),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[1]_i_1__1\
    );
\opt_has_pipe.first_q[1]_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(13),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(5),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(9),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[1]_i_1__2\
    );
\opt_has_pipe.first_q[1]_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(4),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(2),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(3),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[1]_i_1__3\
    );
\opt_has_pipe.first_q[1]_i_1__4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"02220EEE"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(9),
      I1 => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ONE_DEL/i_pipe/first_q\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/A_MANT_ALL_ZERO_P0_DEL/i_pipe/first_q\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/COND_DET/EXP_DET_LUT.EXP_ALL_ZERO_DEL/i_pipe/first_q\,
      I4 => \n_0_opt_has_pipe.first_q[1]_i_2__0\,
      O => \n_0_opt_has_pipe.first_q[1]_i_1__4\
    );
\opt_has_pipe.first_q[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AABFFFBFFFBFFFBF"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(4),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/EQ_ZERO/CARRY_ZERO_DET/CHAIN_GEN[3].CARRYS_DEL.NEED_DEL.CARRYS_FD\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/MUX_LOOP[0].DEL_Z_D/i_pipe/first_q\(6),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_Z_D/p_0_in4_in\,
      O => \n_0_opt_has_pipe.first_q[1]_i_2\
    );
\opt_has_pipe.first_q[1]_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55555554"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(9),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(8),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(7),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(6),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(5),
      O => \n_0_opt_has_pipe.first_q[1]_i_2__0\
    );
\opt_has_pipe.first_q[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(12),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[20]_i_1\
    );
\opt_has_pipe.first_q[20]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(24),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(28),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(20),
      O => \n_0_opt_has_pipe.first_q[20]_i_1__0\
    );
\opt_has_pipe.first_q[20]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(23),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(21),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(22),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(20),
      O => \n_0_opt_has_pipe.first_q[20]_i_1__1\
    );
\opt_has_pipe.first_q[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(13),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[21]_i_1\
    );
\opt_has_pipe.first_q[21]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(25),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(29),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(21),
      O => \n_0_opt_has_pipe.first_q[21]_i_1__0\
    );
\opt_has_pipe.first_q[21]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(24),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(22),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(23),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(21),
      O => \n_0_opt_has_pipe.first_q[21]_i_1__1\
    );
\opt_has_pipe.first_q[22]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(14),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[22]_i_1\
    );
\opt_has_pipe.first_q[22]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(26),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(30),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(22),
      O => \n_0_opt_has_pipe.first_q[22]_i_1__0\
    );
\opt_has_pipe.first_q[22]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(25),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(23),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(24),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(22),
      O => \n_0_opt_has_pipe.first_q[22]_i_1__1\
    );
\opt_has_pipe.first_q[23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(15),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[23]_i_1\
    );
\opt_has_pipe.first_q[23]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(27),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(31),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(23),
      O => \n_0_opt_has_pipe.first_q[23]_i_1__0\
    );
\opt_has_pipe.first_q[23]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(26),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(24),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(25),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(23),
      O => \n_0_opt_has_pipe.first_q[23]_i_1__1\
    );
\opt_has_pipe.first_q[24]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(16),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[24]_i_1\
    );
\opt_has_pipe.first_q[24]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(24),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(28),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[24]_i_1__0\
    );
\opt_has_pipe.first_q[24]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(27),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(25),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(26),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(24),
      O => \n_0_opt_has_pipe.first_q[24]_i_1__1\
    );
\opt_has_pipe.first_q[25]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(17),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[25]_i_1\
    );
\opt_has_pipe.first_q[25]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(25),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(29),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[25]_i_1__0\
    );
\opt_has_pipe.first_q[25]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(28),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(26),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(27),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(25),
      O => \n_0_opt_has_pipe.first_q[25]_i_1__1\
    );
\opt_has_pipe.first_q[26]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(18),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[26]_i_1\
    );
\opt_has_pipe.first_q[26]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(26),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(30),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[26]_i_1__0\
    );
\opt_has_pipe.first_q[26]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(29),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(27),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(28),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(26),
      O => \n_0_opt_has_pipe.first_q[26]_i_1__1\
    );
\opt_has_pipe.first_q[27]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(19),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[27]_i_1\
    );
\opt_has_pipe.first_q[27]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(27),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(31),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[27]_i_1__0\
    );
\opt_has_pipe.first_q[27]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(30),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(28),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(29),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(27),
      O => \n_0_opt_has_pipe.first_q[27]_i_1__1\
    );
\opt_has_pipe.first_q[28]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(20),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[28]_i_1\
    );
\opt_has_pipe.first_q[28]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(31),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(29),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(30),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(28),
      O => \n_0_opt_has_pipe.first_q[28]_i_1__0\
    );
\opt_has_pipe.first_q[28]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(28),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[28]_i_1__1\
    );
\opt_has_pipe.first_q[29]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(21),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[29]_i_1\
    );
\opt_has_pipe.first_q[29]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(30),
      I1 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(31),
      I3 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(29),
      O => \n_0_opt_has_pipe.first_q[29]_i_1__0\
    );
\opt_has_pipe.first_q[29]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(29),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[29]_i_1__1\
    );
\opt_has_pipe.first_q[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"99F99909"
    )
    port map (
      I0 => p_2_out(24),
      I1 => p_2_out(25),
      I2 => \^m_axis_result_tvalid\,
      I3 => m_axis_result_tready,
      I4 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(2),
      O => \n_0_opt_has_pipe.first_q[2]_i_1\
    );
\opt_has_pipe.first_q[2]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C3C3AAC3"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(2),
      I1 => p_2_out(24),
      I2 => p_2_out(25),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      O => \n_0_opt_has_pipe.first_q[2]_i_1__0\
    );
\opt_has_pipe.first_q[2]_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000755FF"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(0),
      I1 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(10),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(9),
      I3 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(8),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[2]_i_1__1\
    );
\opt_has_pipe.first_q[2]_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(10),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[2]_i_1__2\
    );
\opt_has_pipe.first_q[2]_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(14),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(6),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(10),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(2),
      O => \n_0_opt_has_pipe.first_q[2]_i_1__3\
    );
\opt_has_pipe.first_q[2]_i_1__4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(5),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(3),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(4),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(2),
      O => \n_0_opt_has_pipe.first_q[2]_i_1__4\
    );
\opt_has_pipe.first_q[30]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(22),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[30]_i_1\
    );
\opt_has_pipe.first_q[30]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(30),
      I1 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(31),
      I3 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      O => \n_0_opt_has_pipe.first_q[30]_i_1__0\
    );
\opt_has_pipe.first_q[30]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(30),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[30]_i_1__1\
    );
\opt_has_pipe.first_q[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08FB"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(31),
      I1 => \^m_axis_result_tvalid\,
      I2 => m_axis_result_tready,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[31]_i_1\
    );
\opt_has_pipe.first_q[31]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(31),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      O => \n_0_opt_has_pipe.first_q[31]_i_1__0\
    );
\opt_has_pipe.first_q[31]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(31),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[31]_i_1__1\
    );
\opt_has_pipe.first_q[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6A6AFF6A6A6A006A"
    )
    port map (
      I0 => p_2_out(26),
      I1 => p_2_out(25),
      I2 => p_2_out(24),
      I3 => \^m_axis_result_tvalid\,
      I4 => m_axis_result_tready,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(3),
      O => \n_0_opt_has_pipe.first_q[3]_i_1\
    );
\opt_has_pipe.first_q[3]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000755FF"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(0),
      I1 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(14),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(13),
      I3 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(12),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[3]_i_1__0\
    );
\opt_has_pipe.first_q[3]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(11),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[3]_i_1__1\
    );
\opt_has_pipe.first_q[3]_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(15),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(7),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(11),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(3),
      O => \n_0_opt_has_pipe.first_q[3]_i_1__2\
    );
\opt_has_pipe.first_q[3]_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(6),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(4),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(5),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(3),
      O => \n_0_opt_has_pipe.first_q[3]_i_1__3\
    );
\opt_has_pipe.first_q[3]_i_1__4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"95"
    )
    port map (
      I0 => p_2_out(26),
      I1 => p_2_out(25),
      I2 => p_2_out(24),
      O => \n_0_opt_has_pipe.first_q[3]_i_1__4\
    );
\opt_has_pipe.first_q[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA95"
    )
    port map (
      I0 => p_2_out(27),
      I1 => p_2_out(24),
      I2 => p_2_out(25),
      I3 => p_2_out(26),
      O => \n_0_opt_has_pipe.first_q[4]_i_1\
    );
\opt_has_pipe.first_q[4]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000755FF"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(0),
      I1 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(18),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(17),
      I3 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(16),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[4]_i_1__0\
    );
\opt_has_pipe.first_q[4]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(12),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[4]_i_1__1\
    );
\opt_has_pipe.first_q[4]_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(16),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(8),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(12),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[4]_i_1__2\
    );
\opt_has_pipe.first_q[4]_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(7),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(5),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(6),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[4]_i_1__3\
    );
\opt_has_pipe.first_q[4]_i_1__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9555"
    )
    port map (
      I0 => p_2_out(27),
      I1 => p_2_out(26),
      I2 => p_2_out(24),
      I3 => p_2_out(25),
      O => \n_0_opt_has_pipe.first_q[4]_i_1__4\
    );
\opt_has_pipe.first_q[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => p_2_out(28),
      I1 => p_2_out(27),
      I2 => p_2_out(25),
      I3 => p_2_out(24),
      I4 => p_2_out(26),
      O => \n_0_opt_has_pipe.first_q[5]_i_1\
    );
\opt_has_pipe.first_q[5]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"5666AAAA"
    )
    port map (
      I0 => p_2_out(28),
      I1 => p_2_out(26),
      I2 => p_2_out(25),
      I3 => p_2_out(24),
      I4 => p_2_out(27),
      O => \n_0_opt_has_pipe.first_q[5]_i_1__0\
    );
\opt_has_pipe.first_q[5]_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00157777"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(20),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(0),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(22),
      I3 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(21),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ZERO_DET_DIST_DEL/DEL/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[5]_i_1__1\
    );
\opt_has_pipe.first_q[5]_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(13),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[5]_i_1__2\
    );
\opt_has_pipe.first_q[5]_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(17),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(9),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(13),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(5),
      O => \n_0_opt_has_pipe.first_q[5]_i_1__3\
    );
\opt_has_pipe.first_q[5]_i_1__4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(8),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(6),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(7),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(5),
      O => \n_0_opt_has_pipe.first_q[5]_i_1__4\
    );
\opt_has_pipe.first_q[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(14),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[6]_i_1\
    );
\opt_has_pipe.first_q[6]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(18),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(10),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(14),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(6),
      O => \n_0_opt_has_pipe.first_q[6]_i_1__0\
    );
\opt_has_pipe.first_q[6]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(9),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(7),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(8),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(6),
      O => \n_0_opt_has_pipe.first_q[6]_i_1__1\
    );
\opt_has_pipe.first_q[6]_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"555555556AAAAAAA"
    )
    port map (
      I0 => p_2_out(29),
      I1 => p_2_out(26),
      I2 => p_2_out(24),
      I3 => p_2_out(25),
      I4 => p_2_out(27),
      I5 => p_2_out(28),
      O => \n_0_opt_has_pipe.first_q[6]_i_1__2\
    );
\opt_has_pipe.first_q[6]_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555566666AAA"
    )
    port map (
      I0 => p_2_out(29),
      I1 => p_2_out(27),
      I2 => p_2_out(24),
      I3 => p_2_out(25),
      I4 => p_2_out(26),
      I5 => p_2_out(28),
      O => \n_0_opt_has_pipe.first_q[6]_i_1__3\
    );
\opt_has_pipe.first_q[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA9"
    )
    port map (
      I0 => p_2_out(30),
      I1 => p_2_out(29),
      I2 => p_2_out(28),
      I3 => \n_0_opt_has_pipe.first_q[9]_i_2__0\,
      O => \n_0_opt_has_pipe.first_q[7]_i_1\
    );
\opt_has_pipe.first_q[7]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAA9A9A9A9A9"
    )
    port map (
      I0 => p_2_out(30),
      I1 => p_2_out(29),
      I2 => p_2_out(28),
      I3 => p_2_out(26),
      I4 => \n_0_opt_has_pipe.first_q[9]_i_2\,
      I5 => p_2_out(27),
      O => \n_0_opt_has_pipe.first_q[7]_i_1__0\
    );
\opt_has_pipe.first_q[7]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(15),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      O => \n_0_opt_has_pipe.first_q[7]_i_1__1\
    );
\opt_has_pipe.first_q[7]_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(19),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(11),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(15),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(7),
      O => \n_0_opt_has_pipe.first_q[7]_i_1__2\
    );
\opt_has_pipe.first_q[7]_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(10),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(8),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(9),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(7),
      O => \n_0_opt_has_pipe.first_q[7]_i_1__3\
    );
\opt_has_pipe.first_q[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(16),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(0),
      O => \n_0_opt_has_pipe.first_q[8]_i_1\
    );
\opt_has_pipe.first_q[8]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(20),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(12),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(16),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(8),
      O => \n_0_opt_has_pipe.first_q[8]_i_1__0\
    );
\opt_has_pipe.first_q[8]_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(11),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(9),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(10),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(8),
      O => \n_0_opt_has_pipe.first_q[8]_i_1__1\
    );
\opt_has_pipe.first_q[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => p_2_out(30),
      I1 => p_2_out(29),
      I2 => p_2_out(28),
      I3 => \n_0_opt_has_pipe.first_q[9]_i_2__0\,
      O => \n_0_opt_has_pipe.first_q[9]_i_1\
    );
\opt_has_pipe.first_q[9]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAA8A8A8A8A8"
    )
    port map (
      I0 => p_2_out(30),
      I1 => p_2_out(29),
      I2 => p_2_out(28),
      I3 => p_2_out(26),
      I4 => \n_0_opt_has_pipe.first_q[9]_i_2\,
      I5 => p_2_out(27),
      O => \n_0_opt_has_pipe.first_q[9]_i_1__0\
    );
\opt_has_pipe.first_q[9]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(17),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_DIST_DEL/DEL/i_pipe/first_q\(4),
      I2 => \FLT_TO_FIX_OP.SPD.OP/MANT_P0_REG/i_pipe/first_q\(1),
      O => \n_0_opt_has_pipe.first_q[9]_i_1__1\
    );
\opt_has_pipe.first_q[9]_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(21),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(13),
      I2 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(0),
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(17),
      I4 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].SKEW_DIST_DEL.DEL_DIST/i_pipe/first_q\(1),
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[0].DEL_SHIFT/i_pipe/first_q\(9),
      O => \n_0_opt_has_pipe.first_q[9]_i_1__2\
    );
\opt_has_pipe.first_q[9]_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(12),
      I1 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(10),
      I2 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][0]\,
      I3 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(11),
      I4 => \n_0_FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[2].SKEW_DIST_DEL.DEL_DIST/i_pipe/opt_has_pipe.i_pipe[2].pipe_reg[2][1]\,
      I5 => \FLT_TO_FIX_OP.SPD.OP/ALIGN_SHIFT/MUX_LOOP[1].DEL_SHIFT/i_pipe/first_q\(9),
      O => \n_0_opt_has_pipe.first_q[9]_i_1__3\
    );
\opt_has_pipe.first_q[9]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => p_2_out(24),
      I1 => p_2_out(25),
      O => \n_0_opt_has_pipe.first_q[9]_i_2\
    );
\opt_has_pipe.first_q[9]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => p_2_out(26),
      I1 => p_2_out(24),
      I2 => p_2_out(25),
      I3 => p_2_out(27),
      O => \n_0_opt_has_pipe.first_q[9]_i_2__0\
    );
\opt_has_pipe.first_q_reg[0]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \FLT_TO_FIX_OP.SPD.OP/overflow_p1_updated2\,
      CO(2) => \n_1_opt_has_pipe.first_q_reg[0]_i_2\,
      CO(1) => \n_2_opt_has_pipe.first_q_reg[0]_i_2\,
      CO(0) => \n_3_opt_has_pipe.first_q_reg[0]_i_2\,
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => \NLW_opt_has_pipe.first_q_reg[0]_i_2_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_opt_has_pipe.first_q[0]_i_3__1\,
      S(2) => \n_0_opt_has_pipe.first_q[0]_i_4\,
      S(1) => \n_0_opt_has_pipe.first_q[0]_i_5\,
      S(0) => \n_0_opt_has_pipe.first_q[0]_i_6\
    );
\opt_has_pipe.i_pipe[6].pipe[6][0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => m_axis_result_tready,
      I1 => \^m_axis_result_tvalid\,
      O => ce_internal_core
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_a_tvalid : in STD_LOGIC;
    s_axis_a_tready : out STD_LOGIC;
    s_axis_a_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_a_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_a_tlast : in STD_LOGIC;
    s_axis_b_tvalid : in STD_LOGIC;
    s_axis_b_tready : out STD_LOGIC;
    s_axis_b_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_b_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_b_tlast : in STD_LOGIC;
    s_axis_c_tvalid : in STD_LOGIC;
    s_axis_c_tready : out STD_LOGIC;
    s_axis_c_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_c_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_c_tlast : in STD_LOGIC;
    s_axis_operation_tvalid : in STD_LOGIC;
    s_axis_operation_tready : out STD_LOGIC;
    s_axis_operation_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_operation_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_operation_tlast : in STD_LOGIC;
    m_axis_result_tvalid : out STD_LOGIC;
    m_axis_result_tready : in STD_LOGIC;
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_result_tuser : out STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axis_result_tlast : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is "floating_point_v7_0";
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is "kintex7";
  attribute C_HAS_ADD : integer;
  attribute C_HAS_ADD of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_SUBTRACT : integer;
  attribute C_HAS_SUBTRACT of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_MULTIPLY : integer;
  attribute C_HAS_MULTIPLY of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_DIVIDE : integer;
  attribute C_HAS_DIVIDE of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_SQRT : integer;
  attribute C_HAS_SQRT of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_COMPARE : integer;
  attribute C_HAS_COMPARE of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FIX_TO_FLT : integer;
  attribute C_HAS_FIX_TO_FLT of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FLT_TO_FIX : integer;
  attribute C_HAS_FLT_TO_FIX of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_FLT_TO_FLT : integer;
  attribute C_HAS_FLT_TO_FLT of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP : integer;
  attribute C_HAS_RECIP of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RECIP_SQRT : integer;
  attribute C_HAS_RECIP_SQRT of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ABSOLUTE : integer;
  attribute C_HAS_ABSOLUTE of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_LOGARITHM : integer;
  attribute C_HAS_LOGARITHM of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_EXPONENTIAL : integer;
  attribute C_HAS_EXPONENTIAL of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FMA : integer;
  attribute C_HAS_FMA of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_FMS : integer;
  attribute C_HAS_FMS of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_A : integer;
  attribute C_HAS_ACCUMULATOR_A of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUMULATOR_S : integer;
  attribute C_HAS_ACCUMULATOR_S of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_A_FRACTION_WIDTH : integer;
  attribute C_A_FRACTION_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_B_FRACTION_WIDTH : integer;
  attribute C_B_FRACTION_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_C_WIDTH : integer;
  attribute C_C_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_C_FRACTION_WIDTH : integer;
  attribute C_C_FRACTION_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 24;
  attribute C_RESULT_WIDTH : integer;
  attribute C_RESULT_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_RESULT_FRACTION_WIDTH : integer;
  attribute C_RESULT_FRACTION_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_COMPARE_OPERATION : integer;
  attribute C_COMPARE_OPERATION of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 7;
  attribute C_OPTIMIZATION : integer;
  attribute C_OPTIMIZATION of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_MULT_USAGE : integer;
  attribute C_MULT_USAGE of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_BRAM_USAGE : integer;
  attribute C_BRAM_USAGE of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_RATE : integer;
  attribute C_RATE of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_ACCUM_INPUT_MSB : integer;
  attribute C_ACCUM_INPUT_MSB of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_ACCUM_MSB : integer;
  attribute C_ACCUM_MSB of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_ACCUM_LSB : integer;
  attribute C_ACCUM_LSB of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is -31;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_INVALID_OP : integer;
  attribute C_HAS_INVALID_OP of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_DIVIDE_BY_ZERO : integer;
  attribute C_HAS_DIVIDE_BY_ZERO of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_OVERFLOW : integer;
  attribute C_HAS_ACCUM_OVERFLOW of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW : integer;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ACLKEN : integer;
  attribute C_HAS_ACLKEN of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_ARESETN : integer;
  attribute C_HAS_ARESETN of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_THROTTLE_SCHEME : integer;
  attribute C_THROTTLE_SCHEME of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_A_TUSER : integer;
  attribute C_HAS_A_TUSER of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_A_TLAST : integer;
  attribute C_HAS_A_TLAST of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_B : integer;
  attribute C_HAS_B of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_B_TUSER : integer;
  attribute C_HAS_B_TUSER of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_B_TLAST : integer;
  attribute C_HAS_B_TLAST of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_C : integer;
  attribute C_HAS_C of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_C_TUSER : integer;
  attribute C_HAS_C_TUSER of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_C_TLAST : integer;
  attribute C_HAS_C_TLAST of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION : integer;
  attribute C_HAS_OPERATION of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TUSER : integer;
  attribute C_HAS_OPERATION_TUSER of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_OPERATION_TLAST : integer;
  attribute C_HAS_OPERATION_TLAST of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 0;
  attribute C_HAS_RESULT_TUSER : integer;
  attribute C_HAS_RESULT_TUSER of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_HAS_RESULT_TLAST : integer;
  attribute C_HAS_RESULT_TLAST of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_TLAST_RESOLUTION : integer;
  attribute C_TLAST_RESOLUTION of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_A_TDATA_WIDTH : integer;
  attribute C_A_TDATA_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_A_TUSER_WIDTH : integer;
  attribute C_A_TUSER_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_B_TDATA_WIDTH : integer;
  attribute C_B_TDATA_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_B_TUSER_WIDTH : integer;
  attribute C_B_TUSER_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_C_TDATA_WIDTH : integer;
  attribute C_C_TDATA_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_C_TUSER_WIDTH : integer;
  attribute C_C_TUSER_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_OPERATION_TDATA_WIDTH : integer;
  attribute C_OPERATION_TDATA_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 8;
  attribute C_OPERATION_TUSER_WIDTH : integer;
  attribute C_OPERATION_TUSER_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 1;
  attribute C_RESULT_TDATA_WIDTH : integer;
  attribute C_RESULT_TDATA_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 32;
  attribute C_RESULT_TUSER_WIDTH : integer;
  attribute C_RESULT_TUSER_WIDTH of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is 10;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ : entity is "yes";
end \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\;

architecture STRUCTURE of \ip_axis_fp32tofi32floating_point_v7_0__parameterized0\ is
  attribute C_ACCUM_INPUT_MSB of i_synth : label is 32;
  attribute C_ACCUM_LSB of i_synth : label is -31;
  attribute C_ACCUM_MSB of i_synth : label is 32;
  attribute C_A_FRACTION_WIDTH of i_synth : label is 24;
  attribute C_A_TDATA_WIDTH of i_synth : label is 32;
  attribute C_A_TUSER_WIDTH of i_synth : label is 8;
  attribute C_A_WIDTH of i_synth : label is 32;
  attribute C_BRAM_USAGE of i_synth : label is 0;
  attribute C_B_FRACTION_WIDTH of i_synth : label is 24;
  attribute C_B_TDATA_WIDTH of i_synth : label is 32;
  attribute C_B_TUSER_WIDTH of i_synth : label is 1;
  attribute C_B_WIDTH of i_synth : label is 32;
  attribute C_COMPARE_OPERATION of i_synth : label is 8;
  attribute C_C_FRACTION_WIDTH of i_synth : label is 24;
  attribute C_C_TDATA_WIDTH of i_synth : label is 32;
  attribute C_C_TUSER_WIDTH of i_synth : label is 1;
  attribute C_C_WIDTH of i_synth : label is 32;
  attribute C_HAS_ABSOLUTE of i_synth : label is 0;
  attribute C_HAS_ACCUMULATOR_A of i_synth : label is 0;
  attribute C_HAS_ACCUMULATOR_S of i_synth : label is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of i_synth : label is 0;
  attribute C_HAS_ACCUM_OVERFLOW of i_synth : label is 0;
  attribute C_HAS_ACLKEN of i_synth : label is 0;
  attribute C_HAS_ADD of i_synth : label is 0;
  attribute C_HAS_ARESETN of i_synth : label is 1;
  attribute C_HAS_A_TLAST of i_synth : label is 1;
  attribute C_HAS_A_TUSER of i_synth : label is 1;
  attribute C_HAS_B of i_synth : label is 0;
  attribute C_HAS_B_TLAST of i_synth : label is 0;
  attribute C_HAS_B_TUSER of i_synth : label is 0;
  attribute C_HAS_C of i_synth : label is 0;
  attribute C_HAS_COMPARE of i_synth : label is 0;
  attribute C_HAS_C_TLAST of i_synth : label is 0;
  attribute C_HAS_C_TUSER of i_synth : label is 0;
  attribute C_HAS_DIVIDE of i_synth : label is 0;
  attribute C_HAS_DIVIDE_BY_ZERO of i_synth : label is 0;
  attribute C_HAS_EXPONENTIAL of i_synth : label is 0;
  attribute C_HAS_FIX_TO_FLT of i_synth : label is 0;
  attribute C_HAS_FLT_TO_FIX of i_synth : label is 1;
  attribute C_HAS_FLT_TO_FLT of i_synth : label is 0;
  attribute C_HAS_FMA of i_synth : label is 0;
  attribute C_HAS_FMS of i_synth : label is 0;
  attribute C_HAS_INVALID_OP of i_synth : label is 1;
  attribute C_HAS_LOGARITHM of i_synth : label is 0;
  attribute C_HAS_MULTIPLY of i_synth : label is 0;
  attribute C_HAS_OPERATION of i_synth : label is 0;
  attribute C_HAS_OPERATION_TLAST of i_synth : label is 0;
  attribute C_HAS_OPERATION_TUSER of i_synth : label is 0;
  attribute C_HAS_OVERFLOW of i_synth : label is 1;
  attribute C_HAS_RECIP of i_synth : label is 0;
  attribute C_HAS_RECIP_SQRT of i_synth : label is 0;
  attribute C_HAS_RESULT_TLAST of i_synth : label is 1;
  attribute C_HAS_RESULT_TUSER of i_synth : label is 1;
  attribute C_HAS_SQRT of i_synth : label is 0;
  attribute C_HAS_SUBTRACT of i_synth : label is 0;
  attribute C_HAS_UNDERFLOW of i_synth : label is 0;
  attribute C_LATENCY of i_synth : label is 7;
  attribute C_MULT_USAGE of i_synth : label is 0;
  attribute C_OPERATION_TDATA_WIDTH of i_synth : label is 8;
  attribute C_OPERATION_TUSER_WIDTH of i_synth : label is 1;
  attribute C_OPTIMIZATION of i_synth : label is 1;
  attribute C_RATE of i_synth : label is 1;
  attribute C_RESULT_FRACTION_WIDTH of i_synth : label is 0;
  attribute C_RESULT_TDATA_WIDTH of i_synth : label is 32;
  attribute C_RESULT_TUSER_WIDTH of i_synth : label is 10;
  attribute C_RESULT_WIDTH of i_synth : label is 32;
  attribute C_THROTTLE_SCHEME of i_synth : label is 1;
  attribute C_TLAST_RESOLUTION of i_synth : label is 1;
  attribute C_XDEVICEFAMILY of i_synth : label is "kintex7";
  attribute downgradeipidentifiedwarnings of i_synth : label is "yes";
begin
i_synth: entity work.\ip_axis_fp32tofi32floating_point_v7_0_viv__parameterized0\
    port map (
      aclk => aclk,
      aclken => aclken,
      aresetn => aresetn,
      m_axis_result_tdata(31 downto 0) => m_axis_result_tdata(31 downto 0),
      m_axis_result_tlast => m_axis_result_tlast,
      m_axis_result_tready => m_axis_result_tready,
      m_axis_result_tuser(9 downto 0) => m_axis_result_tuser(9 downto 0),
      m_axis_result_tvalid => m_axis_result_tvalid,
      s_axis_a_tdata(31 downto 0) => s_axis_a_tdata(31 downto 0),
      s_axis_a_tlast => s_axis_a_tlast,
      s_axis_a_tready => s_axis_a_tready,
      s_axis_a_tuser(7 downto 0) => s_axis_a_tuser(7 downto 0),
      s_axis_a_tvalid => s_axis_a_tvalid,
      s_axis_b_tdata(31 downto 0) => s_axis_b_tdata(31 downto 0),
      s_axis_b_tlast => s_axis_b_tlast,
      s_axis_b_tready => s_axis_b_tready,
      s_axis_b_tuser(0) => s_axis_b_tuser(0),
      s_axis_b_tvalid => s_axis_b_tvalid,
      s_axis_c_tdata(31 downto 0) => s_axis_c_tdata(31 downto 0),
      s_axis_c_tlast => s_axis_c_tlast,
      s_axis_c_tready => s_axis_c_tready,
      s_axis_c_tuser(0) => s_axis_c_tuser(0),
      s_axis_c_tvalid => s_axis_c_tvalid,
      s_axis_operation_tdata(7 downto 0) => s_axis_operation_tdata(7 downto 0),
      s_axis_operation_tlast => s_axis_operation_tlast,
      s_axis_operation_tready => s_axis_operation_tready,
      s_axis_operation_tuser(0) => s_axis_operation_tuser(0),
      s_axis_operation_tvalid => s_axis_operation_tvalid
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity ip_axis_fp32tofi32 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_a_tvalid : in STD_LOGIC;
    s_axis_a_tready : out STD_LOGIC;
    s_axis_a_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_a_tuser : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_a_tlast : in STD_LOGIC;
    m_axis_result_tvalid : out STD_LOGIC;
    m_axis_result_tready : in STD_LOGIC;
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_result_tuser : out STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axis_result_tlast : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ip_axis_fp32tofi32 : entity is true;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of ip_axis_fp32tofi32 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of ip_axis_fp32tofi32 : entity is "floating_point_v7_0,Vivado 2013.4";
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ip_axis_fp32tofi32 : entity is "ip_axis_fp32tofi32,floating_point_v7_0,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of ip_axis_fp32tofi32 : entity is "ip_axis_fp32tofi32,floating_point_v7_0,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=floating_point,x_ipVersion=7.0,x_ipCoreRevision=3,x_ipLanguage=VHDL,C_XDEVICEFAMILY=kintex7,C_HAS_ADD=0,C_HAS_SUBTRACT=0,C_HAS_MULTIPLY=0,C_HAS_DIVIDE=0,C_HAS_SQRT=0,C_HAS_COMPARE=0,C_HAS_FIX_TO_FLT=0,C_HAS_FLT_TO_FIX=1,C_HAS_FLT_TO_FLT=0,C_HAS_RECIP=0,C_HAS_RECIP_SQRT=0,C_HAS_ABSOLUTE=0,C_HAS_LOGARITHM=0,C_HAS_EXPONENTIAL=0,C_HAS_FMA=0,C_HAS_FMS=0,C_HAS_ACCUMULATOR_A=0,C_HAS_ACCUMULATOR_S=0,C_A_WIDTH=32,C_A_FRACTION_WIDTH=24,C_B_WIDTH=32,C_B_FRACTION_WIDTH=24,C_C_WIDTH=32,C_C_FRACTION_WIDTH=24,C_RESULT_WIDTH=32,C_RESULT_FRACTION_WIDTH=0,C_COMPARE_OPERATION=8,C_LATENCY=7,C_OPTIMIZATION=1,C_MULT_USAGE=0,C_BRAM_USAGE=0,C_RATE=1,C_ACCUM_INPUT_MSB=32,C_ACCUM_MSB=32,C_ACCUM_LSB=-31,C_HAS_UNDERFLOW=0,C_HAS_OVERFLOW=1,C_HAS_INVALID_OP=1,C_HAS_DIVIDE_BY_ZERO=0,C_HAS_ACCUM_OVERFLOW=0,C_HAS_ACCUM_INPUT_OVERFLOW=0,C_HAS_ACLKEN=0,C_HAS_ARESETN=1,C_THROTTLE_SCHEME=1,C_HAS_A_TUSER=1,C_HAS_A_TLAST=1,C_HAS_B=0,C_HAS_B_TUSER=0,C_HAS_B_TLAST=0,C_HAS_C=0,C_HAS_C_TUSER=0,C_HAS_C_TLAST=0,C_HAS_OPERATION=0,C_HAS_OPERATION_TUSER=0,C_HAS_OPERATION_TLAST=0,C_HAS_RESULT_TUSER=1,C_HAS_RESULT_TLAST=1,C_TLAST_RESOLUTION=1,C_A_TDATA_WIDTH=32,C_A_TUSER_WIDTH=8,C_B_TDATA_WIDTH=32,C_B_TUSER_WIDTH=1,C_C_TDATA_WIDTH=32,C_C_TUSER_WIDTH=1,C_OPERATION_TDATA_WIDTH=8,C_OPERATION_TUSER_WIDTH=1,C_RESULT_TDATA_WIDTH=32,C_RESULT_TUSER_WIDTH=10}";
end ip_axis_fp32tofi32;

architecture STRUCTURE of ip_axis_fp32tofi32 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal NLW_U0_s_axis_b_tready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axis_c_tready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axis_operation_tready_UNCONNECTED : STD_LOGIC;
  attribute C_ACCUM_INPUT_MSB : integer;
  attribute C_ACCUM_INPUT_MSB of U0 : label is 32;
  attribute C_ACCUM_LSB : integer;
  attribute C_ACCUM_LSB of U0 : label is -31;
  attribute C_ACCUM_MSB : integer;
  attribute C_ACCUM_MSB of U0 : label is 32;
  attribute C_A_FRACTION_WIDTH : integer;
  attribute C_A_FRACTION_WIDTH of U0 : label is 24;
  attribute C_A_TDATA_WIDTH : integer;
  attribute C_A_TDATA_WIDTH of U0 : label is 32;
  attribute C_A_TUSER_WIDTH : integer;
  attribute C_A_TUSER_WIDTH of U0 : label is 8;
  attribute C_A_WIDTH : integer;
  attribute C_A_WIDTH of U0 : label is 32;
  attribute C_BRAM_USAGE : integer;
  attribute C_BRAM_USAGE of U0 : label is 0;
  attribute C_B_FRACTION_WIDTH : integer;
  attribute C_B_FRACTION_WIDTH of U0 : label is 24;
  attribute C_B_TDATA_WIDTH : integer;
  attribute C_B_TDATA_WIDTH of U0 : label is 32;
  attribute C_B_TUSER_WIDTH : integer;
  attribute C_B_TUSER_WIDTH of U0 : label is 1;
  attribute C_B_WIDTH : integer;
  attribute C_B_WIDTH of U0 : label is 32;
  attribute C_COMPARE_OPERATION : integer;
  attribute C_COMPARE_OPERATION of U0 : label is 8;
  attribute C_C_FRACTION_WIDTH : integer;
  attribute C_C_FRACTION_WIDTH of U0 : label is 24;
  attribute C_C_TDATA_WIDTH : integer;
  attribute C_C_TDATA_WIDTH of U0 : label is 32;
  attribute C_C_TUSER_WIDTH : integer;
  attribute C_C_TUSER_WIDTH of U0 : label is 1;
  attribute C_C_WIDTH : integer;
  attribute C_C_WIDTH of U0 : label is 32;
  attribute C_HAS_ABSOLUTE : integer;
  attribute C_HAS_ABSOLUTE of U0 : label is 0;
  attribute C_HAS_ACCUMULATOR_A : integer;
  attribute C_HAS_ACCUMULATOR_A of U0 : label is 0;
  attribute C_HAS_ACCUMULATOR_S : integer;
  attribute C_HAS_ACCUMULATOR_S of U0 : label is 0;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW : integer;
  attribute C_HAS_ACCUM_INPUT_OVERFLOW of U0 : label is 0;
  attribute C_HAS_ACCUM_OVERFLOW : integer;
  attribute C_HAS_ACCUM_OVERFLOW of U0 : label is 0;
  attribute C_HAS_ACLKEN : integer;
  attribute C_HAS_ACLKEN of U0 : label is 0;
  attribute C_HAS_ADD : integer;
  attribute C_HAS_ADD of U0 : label is 0;
  attribute C_HAS_ARESETN : integer;
  attribute C_HAS_ARESETN of U0 : label is 1;
  attribute C_HAS_A_TLAST : integer;
  attribute C_HAS_A_TLAST of U0 : label is 1;
  attribute C_HAS_A_TUSER : integer;
  attribute C_HAS_A_TUSER of U0 : label is 1;
  attribute C_HAS_B : integer;
  attribute C_HAS_B of U0 : label is 0;
  attribute C_HAS_B_TLAST : integer;
  attribute C_HAS_B_TLAST of U0 : label is 0;
  attribute C_HAS_B_TUSER : integer;
  attribute C_HAS_B_TUSER of U0 : label is 0;
  attribute C_HAS_C : integer;
  attribute C_HAS_C of U0 : label is 0;
  attribute C_HAS_COMPARE : integer;
  attribute C_HAS_COMPARE of U0 : label is 0;
  attribute C_HAS_C_TLAST : integer;
  attribute C_HAS_C_TLAST of U0 : label is 0;
  attribute C_HAS_C_TUSER : integer;
  attribute C_HAS_C_TUSER of U0 : label is 0;
  attribute C_HAS_DIVIDE : integer;
  attribute C_HAS_DIVIDE of U0 : label is 0;
  attribute C_HAS_DIVIDE_BY_ZERO : integer;
  attribute C_HAS_DIVIDE_BY_ZERO of U0 : label is 0;
  attribute C_HAS_EXPONENTIAL : integer;
  attribute C_HAS_EXPONENTIAL of U0 : label is 0;
  attribute C_HAS_FIX_TO_FLT : integer;
  attribute C_HAS_FIX_TO_FLT of U0 : label is 0;
  attribute C_HAS_FLT_TO_FIX : integer;
  attribute C_HAS_FLT_TO_FIX of U0 : label is 1;
  attribute C_HAS_FLT_TO_FLT : integer;
  attribute C_HAS_FLT_TO_FLT of U0 : label is 0;
  attribute C_HAS_FMA : integer;
  attribute C_HAS_FMA of U0 : label is 0;
  attribute C_HAS_FMS : integer;
  attribute C_HAS_FMS of U0 : label is 0;
  attribute C_HAS_INVALID_OP : integer;
  attribute C_HAS_INVALID_OP of U0 : label is 1;
  attribute C_HAS_LOGARITHM : integer;
  attribute C_HAS_LOGARITHM of U0 : label is 0;
  attribute C_HAS_MULTIPLY : integer;
  attribute C_HAS_MULTIPLY of U0 : label is 0;
  attribute C_HAS_OPERATION : integer;
  attribute C_HAS_OPERATION of U0 : label is 0;
  attribute C_HAS_OPERATION_TLAST : integer;
  attribute C_HAS_OPERATION_TLAST of U0 : label is 0;
  attribute C_HAS_OPERATION_TUSER : integer;
  attribute C_HAS_OPERATION_TUSER of U0 : label is 0;
  attribute C_HAS_OVERFLOW : integer;
  attribute C_HAS_OVERFLOW of U0 : label is 1;
  attribute C_HAS_RECIP : integer;
  attribute C_HAS_RECIP of U0 : label is 0;
  attribute C_HAS_RECIP_SQRT : integer;
  attribute C_HAS_RECIP_SQRT of U0 : label is 0;
  attribute C_HAS_RESULT_TLAST : integer;
  attribute C_HAS_RESULT_TLAST of U0 : label is 1;
  attribute C_HAS_RESULT_TUSER : integer;
  attribute C_HAS_RESULT_TUSER of U0 : label is 1;
  attribute C_HAS_SQRT : integer;
  attribute C_HAS_SQRT of U0 : label is 0;
  attribute C_HAS_SUBTRACT : integer;
  attribute C_HAS_SUBTRACT of U0 : label is 0;
  attribute C_HAS_UNDERFLOW : integer;
  attribute C_HAS_UNDERFLOW of U0 : label is 0;
  attribute C_LATENCY : integer;
  attribute C_LATENCY of U0 : label is 7;
  attribute C_MULT_USAGE : integer;
  attribute C_MULT_USAGE of U0 : label is 0;
  attribute C_OPERATION_TDATA_WIDTH : integer;
  attribute C_OPERATION_TDATA_WIDTH of U0 : label is 8;
  attribute C_OPERATION_TUSER_WIDTH : integer;
  attribute C_OPERATION_TUSER_WIDTH of U0 : label is 1;
  attribute C_OPTIMIZATION : integer;
  attribute C_OPTIMIZATION of U0 : label is 1;
  attribute C_RATE : integer;
  attribute C_RATE of U0 : label is 1;
  attribute C_RESULT_FRACTION_WIDTH : integer;
  attribute C_RESULT_FRACTION_WIDTH of U0 : label is 0;
  attribute C_RESULT_TDATA_WIDTH : integer;
  attribute C_RESULT_TDATA_WIDTH of U0 : label is 32;
  attribute C_RESULT_TUSER_WIDTH : integer;
  attribute C_RESULT_TUSER_WIDTH of U0 : label is 10;
  attribute C_RESULT_WIDTH : integer;
  attribute C_RESULT_WIDTH of U0 : label is 32;
  attribute C_THROTTLE_SCHEME : integer;
  attribute C_THROTTLE_SCHEME of U0 : label is 1;
  attribute C_TLAST_RESOLUTION : integer;
  attribute C_TLAST_RESOLUTION of U0 : label is 1;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of U0 : label is "kintex7";
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of U0 : label is true;
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
U0: entity work.\ip_axis_fp32tofi32floating_point_v7_0__parameterized0\
    port map (
      aclk => aclk,
      aclken => \<const1>\,
      aresetn => aresetn,
      m_axis_result_tdata(31 downto 0) => m_axis_result_tdata(31 downto 0),
      m_axis_result_tlast => m_axis_result_tlast,
      m_axis_result_tready => m_axis_result_tready,
      m_axis_result_tuser(9 downto 0) => m_axis_result_tuser(9 downto 0),
      m_axis_result_tvalid => m_axis_result_tvalid,
      s_axis_a_tdata(31 downto 0) => s_axis_a_tdata(31 downto 0),
      s_axis_a_tlast => s_axis_a_tlast,
      s_axis_a_tready => s_axis_a_tready,
      s_axis_a_tuser(7 downto 0) => s_axis_a_tuser(7 downto 0),
      s_axis_a_tvalid => s_axis_a_tvalid,
      s_axis_b_tdata(31) => \<const0>\,
      s_axis_b_tdata(30) => \<const0>\,
      s_axis_b_tdata(29) => \<const0>\,
      s_axis_b_tdata(28) => \<const0>\,
      s_axis_b_tdata(27) => \<const0>\,
      s_axis_b_tdata(26) => \<const0>\,
      s_axis_b_tdata(25) => \<const0>\,
      s_axis_b_tdata(24) => \<const0>\,
      s_axis_b_tdata(23) => \<const0>\,
      s_axis_b_tdata(22) => \<const0>\,
      s_axis_b_tdata(21) => \<const0>\,
      s_axis_b_tdata(20) => \<const0>\,
      s_axis_b_tdata(19) => \<const0>\,
      s_axis_b_tdata(18) => \<const0>\,
      s_axis_b_tdata(17) => \<const0>\,
      s_axis_b_tdata(16) => \<const0>\,
      s_axis_b_tdata(15) => \<const0>\,
      s_axis_b_tdata(14) => \<const0>\,
      s_axis_b_tdata(13) => \<const0>\,
      s_axis_b_tdata(12) => \<const0>\,
      s_axis_b_tdata(11) => \<const0>\,
      s_axis_b_tdata(10) => \<const0>\,
      s_axis_b_tdata(9) => \<const0>\,
      s_axis_b_tdata(8) => \<const0>\,
      s_axis_b_tdata(7) => \<const0>\,
      s_axis_b_tdata(6) => \<const0>\,
      s_axis_b_tdata(5) => \<const0>\,
      s_axis_b_tdata(4) => \<const0>\,
      s_axis_b_tdata(3) => \<const0>\,
      s_axis_b_tdata(2) => \<const0>\,
      s_axis_b_tdata(1) => \<const0>\,
      s_axis_b_tdata(0) => \<const0>\,
      s_axis_b_tlast => \<const0>\,
      s_axis_b_tready => NLW_U0_s_axis_b_tready_UNCONNECTED,
      s_axis_b_tuser(0) => \<const0>\,
      s_axis_b_tvalid => \<const0>\,
      s_axis_c_tdata(31) => \<const0>\,
      s_axis_c_tdata(30) => \<const0>\,
      s_axis_c_tdata(29) => \<const0>\,
      s_axis_c_tdata(28) => \<const0>\,
      s_axis_c_tdata(27) => \<const0>\,
      s_axis_c_tdata(26) => \<const0>\,
      s_axis_c_tdata(25) => \<const0>\,
      s_axis_c_tdata(24) => \<const0>\,
      s_axis_c_tdata(23) => \<const0>\,
      s_axis_c_tdata(22) => \<const0>\,
      s_axis_c_tdata(21) => \<const0>\,
      s_axis_c_tdata(20) => \<const0>\,
      s_axis_c_tdata(19) => \<const0>\,
      s_axis_c_tdata(18) => \<const0>\,
      s_axis_c_tdata(17) => \<const0>\,
      s_axis_c_tdata(16) => \<const0>\,
      s_axis_c_tdata(15) => \<const0>\,
      s_axis_c_tdata(14) => \<const0>\,
      s_axis_c_tdata(13) => \<const0>\,
      s_axis_c_tdata(12) => \<const0>\,
      s_axis_c_tdata(11) => \<const0>\,
      s_axis_c_tdata(10) => \<const0>\,
      s_axis_c_tdata(9) => \<const0>\,
      s_axis_c_tdata(8) => \<const0>\,
      s_axis_c_tdata(7) => \<const0>\,
      s_axis_c_tdata(6) => \<const0>\,
      s_axis_c_tdata(5) => \<const0>\,
      s_axis_c_tdata(4) => \<const0>\,
      s_axis_c_tdata(3) => \<const0>\,
      s_axis_c_tdata(2) => \<const0>\,
      s_axis_c_tdata(1) => \<const0>\,
      s_axis_c_tdata(0) => \<const0>\,
      s_axis_c_tlast => \<const0>\,
      s_axis_c_tready => NLW_U0_s_axis_c_tready_UNCONNECTED,
      s_axis_c_tuser(0) => \<const0>\,
      s_axis_c_tvalid => \<const0>\,
      s_axis_operation_tdata(7) => \<const0>\,
      s_axis_operation_tdata(6) => \<const0>\,
      s_axis_operation_tdata(5) => \<const0>\,
      s_axis_operation_tdata(4) => \<const0>\,
      s_axis_operation_tdata(3) => \<const0>\,
      s_axis_operation_tdata(2) => \<const0>\,
      s_axis_operation_tdata(1) => \<const0>\,
      s_axis_operation_tdata(0) => \<const0>\,
      s_axis_operation_tlast => \<const0>\,
      s_axis_operation_tready => NLW_U0_s_axis_operation_tready_UNCONNECTED,
      s_axis_operation_tuser(0) => \<const0>\,
      s_axis_operation_tvalid => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
