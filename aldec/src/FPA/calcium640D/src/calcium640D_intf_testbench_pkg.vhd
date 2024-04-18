------------------------------------------------------------------
--!   @file calcium640D_intf_testbench_pkg.vhd
--!   @brief Package file for TEL-2000 projects.
--!   @details This file contains the records and constants used in the project.
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.MATH_REAL.all;
use work.fpa_common_pkg.all;
use work.proxy_define.all;
use work.fpa_define.all;

package calcium640D_intf_testbench_pkg is
   
   constant USER_CFG_VECTOR_SIZE             : natural := 36;  -- number of variables to write in the USER_CFG
   constant C_FPA_INTCLK_RATE_KHZ            : integer := 10_000;
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned;
   
end calcium640D_intf_testbench_pkg;

package body calcium640D_intf_testbench_pkg is
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned is
      
      -- USER_CFG variables
      variable comn_fpa_diag_mode : unsigned(31 downto 0);
      variable comn_fpa_diag_type : unsigned(31 downto 0);
      variable comn_fpa_pwr_on : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_mode : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_ctrl_dly : unsigned(31 downto 0);
      variable comn_fpa_xtra_trig_mode : unsigned(31 downto 0);
      variable comn_fpa_xtra_trig_ctrl_dly : unsigned(31 downto 0);
      variable comn_fpa_trig_ctrl_timeout_dly : unsigned(31 downto 0);
      variable comn_fpa_stretch_acq_trig : unsigned(31 downto 0);
      variable comn_fpa_intf_data_source : unsigned(31 downto 0);
      variable comn_fpa_xtra_trig_int_time : unsigned(31 downto 0);
      variable comn_fpa_prog_trig_int_time : unsigned(31 downto 0);
      variable comn_intclk_to_clk100_conv_numerator : unsigned(31 downto 0);
      variable comn_clk100_to_intclk_conv_numerator : unsigned(31 downto 0);
      variable offsetx : unsigned(31 downto 0);
      variable offsety : unsigned(31 downto 0);
      variable width : unsigned(31 downto 0);
      variable height : unsigned(31 downto 0);
      variable active_line_start_num : unsigned(31 downto 0);
      variable active_line_end_num : unsigned(31 downto 0);
      variable active_line_width_div4 : unsigned(31 downto 0);
      variable diag_x_to_readout_start_dly : unsigned(31 downto 0);
      variable diag_fval_re_to_dval_re_dly : unsigned(31 downto 0);
      variable diag_lval_pause_dly : unsigned(31 downto 0);
      variable diag_x_to_next_fsync_re_dly : unsigned(31 downto 0);
      variable diag_xsize_div_per_pixel_num : unsigned(31 downto 0);
      variable u_fpa_int_time_offset : unsigned(31 downto 0);
      variable int_fdbk_dly : unsigned(31 downto 0);
      variable kpix_pgen_value : unsigned(31 downto 0);
      variable kpix_mean_value : unsigned(31 downto 0);
      variable use_ext_pixqnb : unsigned(31 downto 0);
      variable clk_frm_pulse_width : unsigned(31 downto 0);
      variable fpa_serdes_lval_num : unsigned(31 downto 0);
      variable fpa_serdes_lval_len : unsigned(31 downto 0);
      variable compr_ratio_fp32 : unsigned(31 downto 0);
      variable cfg_num : unsigned(31 downto 0);
      
      -- Return variable
      variable y : unsigned(USER_CFG_VECTOR_SIZE*32-1 downto 0);
      
      -- Working variables
      variable int_end_to_trig_start_delay : integer;    -- [in ClkCore]
      variable readout_end_to_trig_start_delay : integer;   -- [in ClkCore]
      variable s_fpa_int_time_offset : signed(31 downto 0);
      
   begin
      
      -- Minimum time to wait for int_end_to_trig_start_delay is in IWR
      --                    delay  = (bPixRstHCnt + 1) + (bPixXferCnt + 1) + 2*(bPixOHCnt + 1) + (bPixOH2Cnt + 1) + (bPixRstBECnt + 1) + (bRODelayCnt + 1) [in ClkCore]
      int_end_to_trig_start_delay := (0 + 1)           + (0 + 1)           + 2*(0 + 1)         + (0 + 1)          + (0 + 1)            + (0 + 1);
      
      -- Minimum time to wait for readout_end_to_trig_start_delay is in ITR
      --                        delay  = (bPixRstBECnt + 1) [in ClkCore]
      readout_end_to_trig_start_delay := (0 + 1);
      
      comn_fpa_diag_mode                     := (others => diag_mode);
      comn_fpa_diag_type                     := resize(unsigned(TELOPS_DIAG_DEGR), 32);
      comn_fpa_pwr_on                        := (others => '1');
      comn_fpa_acq_trig_mode                 := resize(unsigned(MODE_INT_END_TO_TRIG_START), 32);  -- to support IWR
      comn_fpa_acq_trig_ctrl_dly             := to_unsigned(integer(real(int_end_to_trig_start_delay) * real(DEFINE_FPA_100M_CLK_RATE_KHZ) / real(C_FPA_INTCLK_RATE_KHZ)), 32);
      comn_fpa_xtra_trig_mode                := resize(unsigned(MODE_READOUT_END_TO_TRIG_START), 32);    -- use ITR for PROG and XTRA trigs
      comn_fpa_xtra_trig_ctrl_dly            := to_unsigned(integer(real(readout_end_to_trig_start_delay) * real(DEFINE_FPA_100M_CLK_RATE_KHZ) / real(C_FPA_INTCLK_RATE_KHZ)), 32);
      comn_fpa_trig_ctrl_timeout_dly         := (others => '1');  -- we don't want the timeout to interfere
      comn_fpa_stretch_acq_trig              := (others => '0');
      comn_fpa_intf_data_source              := (others => DATA_SOURCE_OUTSIDE_FPGA);
      comn_fpa_xtra_trig_int_time            := to_unsigned(100, 32);   -- 1us
      comn_fpa_prog_trig_int_time            := to_unsigned(100, 32);   -- 1us
      comn_intclk_to_clk100_conv_numerator   := to_unsigned(integer(real(DEFINE_FPA_100M_CLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(C_FPA_INTCLK_RATE_KHZ)), 32);
      comn_clk100_to_intclk_conv_numerator   := to_unsigned(integer(real(C_FPA_INTCLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(DEFINE_FPA_100M_CLK_RATE_KHZ)), 32);
      
      offsetx     := to_unsigned(0, 32);
      offsety     := to_unsigned(0, 32);
      width       := to_unsigned(user_xsize, 32);
      height      := to_unsigned(user_ysize, 32);
      
      active_line_start_num      := to_unsigned(1, 32);
      active_line_end_num        := to_unsigned(to_integer(active_line_start_num) + user_ysize - 1, 32);
      active_line_width_div4     := to_unsigned(user_xsize/4, 32);
      
      diag_x_to_readout_start_dly      := to_unsigned(0, 32);
      diag_fval_re_to_dval_re_dly      := to_unsigned(0, 32);
      diag_lval_pause_dly              := to_unsigned(1, 32);
      diag_x_to_next_fsync_re_dly      := to_unsigned(0, 32);
      diag_xsize_div_per_pixel_num     := to_unsigned(user_xsize/4, 32);
      
      s_fpa_int_time_offset := to_signed(-1, 32);
      u_fpa_int_time_offset := unsigned(std_logic_vector(s_fpa_int_time_offset));
      
      int_fdbk_dly := to_unsigned(3, 32);    -- 3 clk_100M entre FPA_INT et CLK_FRM
      
      kpix_pgen_value   := to_unsigned(0, 32);
      kpix_mean_value   := to_unsigned(0, 32);
      
      use_ext_pixqnb          := (others => '1');
      clk_frm_pulse_width     := to_unsigned(50, 32);
      
      fpa_serdes_lval_num     := to_unsigned(user_ysize, 32);
      fpa_serdes_lval_len     := to_unsigned(user_xsize/8, 32);
      
      compr_ratio_fp32 := unsigned'(x"3F321643");   -- 16/23 in float
      
      cfg_num := to_unsigned(send_id, 32);
      
      
      -- Concatenate USER_CFG variables
      y := comn_fpa_diag_mode
      & comn_fpa_diag_type
      & comn_fpa_pwr_on
      & comn_fpa_acq_trig_mode
      & comn_fpa_acq_trig_ctrl_dly
      & comn_fpa_xtra_trig_mode
      & comn_fpa_xtra_trig_ctrl_dly
      & comn_fpa_trig_ctrl_timeout_dly
      & comn_fpa_stretch_acq_trig
      & comn_fpa_intf_data_source
      & comn_fpa_xtra_trig_int_time
      & comn_fpa_prog_trig_int_time
      & comn_intclk_to_clk100_conv_numerator
      & comn_clk100_to_intclk_conv_numerator
      & offsetx
      & offsety
      & width
      & height
      & active_line_start_num
      & active_line_end_num
      & active_line_width_div4
      & diag_x_to_readout_start_dly
      & diag_fval_re_to_dval_re_dly
      & diag_lval_pause_dly
      & diag_x_to_next_fsync_re_dly
      & diag_xsize_div_per_pixel_num
      & u_fpa_int_time_offset
      & int_fdbk_dly
      & kpix_pgen_value
      & kpix_mean_value
      & use_ext_pixqnb
      & clk_frm_pulse_width
      & fpa_serdes_lval_num
      & fpa_serdes_lval_len
      & compr_ratio_fp32
      & cfg_num;
      
      return y;
   end to_intf_cfg;
   
end package body calcium640D_intf_testbench_pkg;
