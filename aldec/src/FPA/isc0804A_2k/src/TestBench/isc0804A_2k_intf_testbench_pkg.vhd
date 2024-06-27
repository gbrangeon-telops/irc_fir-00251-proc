------------------------------------------------------------------
--!   @file isc0804A_2k_intf_testbench_pkgpkg_vhd
--!   @brief Package file for TEL-2000 projects_
--!   @details This file contains the records and constants used in the project_
--!
--!   $Rev: 23346 $
--!   $Author: enofodjie $
--!   $Date: 2019-04-20 19:13:47 -0400 (sam_, 20 avr_ 2019) $
--!   $Id: isc0804A_2k_intf_testbench_pkg_vhd 23346 2019-04-20 23:13:47Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/FPA/isc0804A_2k/src/TestBench/isc0804A_2k_intf_testbench_pkg_vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.MATH_REAL.all;
use work.fpa_common_pkg.all; 
use work.fpa_define.all;

package isc0804A_2k_intf_testbench_pkg is           
   
   constant QWORDS_NUM                 : natural := 119;
   constant PIXNUM_PER_TAP_PER_MCLK    : natural := 2;
   constant FOVH_LINE                  : natural := 1;
   constant PAUSE_SIZE                 : integer := 1;
   constant TAP_NUM                    : integer := 16;
   constant USER_FIRST_LINE_NUM        : integer := 3;
   constant STRETCH_LINE_LENGTH_MCLK   : integer := 1;
   constant C_ELCORR_ENABLED           : std_logic := '0';
   constant C_elcorr_ref0_image_map_enabled : std_logic := '0';
   constant C_elcorr_ref1_image_map_enabled : std_logic := '0';
   constant C_ROIC_DBG_REG             : integer := 322131831;
   
   -- Electrical correction : embedded switches control
   constant ELCORR_SW_TO_PATH1             : unsigned(1 downto 0) :=   "01";
   constant ELCORR_SW_TO_PATH2             : unsigned(1 downto 0) :=   "10";
   constant ELCORR_SW_TO_NORMAL_OP         : unsigned(1 downto 0) :=   "11";
   
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned;
   
   
end isc0804A_2k_intf_testbench_pkg;

package body isc0804A_2k_intf_testbench_pkg is
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned is 
      variable  comn_fpa_diag_mode                     : unsigned(31 downto 0);
      variable  comn_fpa_diag_type                     : unsigned(31 downto 0);
      variable  comn_fpa_pwr_on                        : unsigned(31 downto 0);
      variable  comn_fpa_acq_trig_mode                 : unsigned(31 downto 0);
      variable  comn_fpa_acq_trig_ctrl_dly             : unsigned(31 downto 0);
      variable  comn_fpa_xtra_trig_mode                : unsigned(31 downto 0);
      variable  comn_fpa_xtra_trig_ctrl_dly            : unsigned(31 downto 0);
      variable  comn_fpa_trig_ctrl_timeout_dly         : unsigned(31 downto 0);
      variable  comn_fpa_stretch_acq_trig              : unsigned(31 downto 0);                 
      variable  comn_fpa_intf_data_source              : unsigned(31 downto 0);
      variable  diag_ysize                             : unsigned(31 downto 0);                                         
      variable  diag_xsize_div_tapnum                  : unsigned(31 downto 0);
      variable  roic_ystart                            : unsigned(31 downto 0);                                           
      variable  roic_ysize_div4_m1                     : unsigned(31 downto 0);
      variable  vdet_code                              : unsigned(31 downto 0);
      variable  ref_mode_en                            : unsigned(31 downto 0);
      variable  ref_chn_en                             : unsigned(31 downto 0);
      variable  clamping_level                         : unsigned(31 downto 0);
      variable  real_mode_active_pixel_dly             : unsigned(31 downto 0);
      variable  user_area_line_start_num_m1            : unsigned(31 downto 0);
      variable  proxim_is_flegx                        : unsigned(31 downto 0);
      variable  raw_area_line_start_num                : unsigned(31 downto 0);                           
      variable  raw_area_line_end_num                  : unsigned(31 downto 0);
      variable  raw_area_sof_posf_pclk                 : unsigned(31 downto 0);
      variable  raw_area_eof_posf_pclk                 : unsigned(31 downto 0);
      variable  raw_area_sol_posl_pclk                 : unsigned(31 downto 0);
      variable  raw_area_eol_posl_pclk                 : unsigned(31 downto 0);
      variable  raw_area_lsync_start_posl_pclk         : unsigned(31 downto 0);
      variable  raw_area_lsync_end_posl_pclk           : unsigned(31 downto 0);
      variable  raw_area_lsync_num                     : unsigned(31 downto 0);
      variable  raw_area_clk_id                        : unsigned(31 downto 0);
      variable  raw_area_line_period_pclk              : unsigned(31 downto 0);
      variable  raw_area_readout_pclk_cnt_max          : unsigned(31 downto 0);
      variable  user_area_line_start_num               : unsigned(31 downto 0);
      variable  user_area_line_end_num                 : unsigned(31 downto 0);
      variable  user_area_sol_posl_pclk                : unsigned(31 downto 0); 
      variable  user_area_eol_posl_pclk                : unsigned(31 downto 0);
      variable  user_area_clk_id                       : unsigned(31 downto 0);
      variable  clk_area_a_line_start_num              : unsigned(31 downto 0);
      variable  clk_area_a_line_end_num                : unsigned(31 downto 0);
      variable  clk_area_a_sol_posl_pclk               : unsigned(31 downto 0);
      variable  clk_area_a_eol_posl_pclk               : unsigned(31 downto 0);
      variable  clk_area_a_spare                       : unsigned(31 downto 0);
      variable  clk_area_a_clk_id                      : unsigned(31 downto 0);
      variable  clk_area_b_line_start_num              : unsigned(31 downto 0);
      variable  clk_area_b_line_end_num                : unsigned(31 downto 0);
      variable  clk_area_b_sol_posl_pclk               : unsigned(31 downto 0);
      variable  clk_area_b_eol_posl_pclk               : unsigned(31 downto 0); 
      variable  clk_area_b_spare                       : unsigned(31 downto 0); 
      variable  clk_area_b_clk_id                      : unsigned(31 downto 0); 
      variable  pix_samp_num_per_ch                    : unsigned(31 downto 0);
      variable  hgood_samp_sum_num                     : unsigned(31 downto 0);
      variable  hgood_samp_mean_numerator              : unsigned(31 downto 0);      
      variable  vgood_samp_sum_num                     : unsigned(31 downto 0);
      variable  vgood_samp_mean_numerator              : unsigned(31 downto 0);  
      variable  good_samp_first_pos_per_ch             : unsigned(31 downto 0);      
      variable  good_samp_last_pos_per_ch              : unsigned(31 downto 0);  
      variable  adc_clk_source_phase1                  : unsigned(31 downto 0);  
      variable  adc_clk_pipe_sel1                      : unsigned(31 downto 0);  
      variable  adc_clk_source_phase3                  : unsigned(31 downto 0);
      variable  adc_clk_pipe_sel3                      : unsigned(31 downto 0);
      variable  spare3c                                : unsigned(31 downto 0);
      variable  lsydel_mclk                            : unsigned(31 downto 0);
      variable  boost_mode                             : unsigned(31 downto 0);       
      variable  speedup_lsydel                         : unsigned(31 downto 0);
      variable  elcorr_enabled                         : unsigned(31 downto 0);
      variable  elcorr_spare1                          : unsigned(31 downto 0);
      variable  elcorr_spare2                          : unsigned(31 downto 0);      
      variable  elcorr_ref_cfg_0_ref_enabled           : unsigned(31 downto 0);
      variable  elcorr_ref_cfg_0_ref_cont_meas_mode    : unsigned(31 downto 0);
      variable  elcorr_ref_cfg_0_start_dly_sampclk     : unsigned(31 downto 0);
      variable  elcorr_ref_cfg_0_samp_num_per_ch       : unsigned(31 downto 0); 
      variable  elcorr_ref_cfg_0_samp_mean_numerator   : unsigned(31 downto 0); 
      variable  elcorr_ref_cfg_0_ref_value             : unsigned(31 downto 0); 
      variable  elcorr_ref_cfg_1_ref_enabled           : unsigned(31 downto 0); 
      variable  elcorr_ref_cfg_1_ref_cont_meas_mode    : unsigned(31 downto 0); 
      variable  elcorr_ref_cfg_1_start_dly_sampclk     : unsigned(31 downto 0);
      variable  elcorr_ref_cfg_1_samp_num_per_ch       : unsigned(31 downto 0);
      variable  elcorr_ref_cfg_1_samp_mean_numerator   : unsigned(31 downto 0);         
      variable  elcorr_ref_cfg_1_ref_value             : unsigned(31 downto 0);   
      variable  elcorr_ref_dac_id                      : unsigned(31 downto 0);
      variable  elcorr_atemp_gain                      : unsigned(31 downto 0);                     
      variable  elcorr_atemp_ofs                       : unsigned(31 downto 0) := (others => '0');
      variable  elcorr_ref0_op_sel                     : unsigned(31 downto 0);
      variable  elcorr_ref1_op_sel                     : unsigned(31 downto 0) := (others => '0');
      variable  elcorr_mult_op_sel                     : unsigned(31 downto 0) := (others => '0');
      variable  elcorr_div_op_sel                      : unsigned(31 downto 0);
      variable  elcorr_add_op_sel                      : unsigned(31 downto 0);
      variable  elcorr_spare3                          : unsigned(31 downto 0);
      variable  sat_ctrl_en                            : unsigned(31 downto 0);
      variable  cfg_num                                : unsigned(31 downto 0);
      variable  elcorr_spare4                          : unsigned(31 downto 0);
      variable  roic_cst_output_mode                   : unsigned(31 downto 0);
      variable  spare2a                                : unsigned(31 downto 0);
      variable  adc_clk_source_phase2                  : unsigned(31 downto 0);
      variable  adc_clk_pipe_sel2                      : unsigned(31 downto 0);
      variable  roic_dbg_reg                           : unsigned(31 downto 0);
      variable  roic_test_row_en                       : unsigned(31 downto 0);
      variable  adc_clk_source_phase4                  : unsigned(31 downto 0);
      variable  adc_clk_pipe_sel4                      : unsigned(31 downto 0);
      variable  single_samp_mode_en                    : unsigned(31 downto 0);
      variable  nominal_clk_id_sample_pos              : unsigned(31 downto 0);
      variable  mclk1_id_sample_pos                    : unsigned(31 downto 0);
      variable  mclk2_id_sample_pos                    : unsigned(31 downto 0);
      variable  mclk3_id_sample_pos                    : unsigned(31 downto 0);
      variable  elcorr_ref_cfg_0_forced_val_enabled    : unsigned(31 downto 0);
      variable  elcorr_ref_cfg_0_forced_val            : unsigned(31 downto 0);
      variable  elcorr_ref_cfg_1_forced_val_enabled    : unsigned(31 downto 0);
      variable  elcorr_ref_cfg_1_forced_val            : unsigned(31 downto 0);
      variable  dynrange_scaling_numerator             : unsigned(31 downto 0);
      variable  dynrange_clipping_level                : unsigned(31 downto 0);
      variable  dynrange_global_offset                 : unsigned(31 downto 0);
      variable  dynrange_op_sel                        : unsigned(31 downto 0);
	  variable  clk_area_c_line_start_num              : unsigned(31 downto 0);
      variable  clk_area_c_line_end_num                : unsigned(31 downto 0);
      variable  clk_area_c_sol_posl_pclk               : unsigned(31 downto 0);
      variable  clk_area_c_eol_posl_pclk               : unsigned(31 downto 0); 
      variable  clk_area_c_spare                       : unsigned(31 downto 0); 
      variable  clk_area_c_clk_id                      : unsigned(31 downto 0); 
	  variable  roic_xsize : natural                   := 640;
      variable  roic_ysize : natural                   := user_ysize;                             -- pas utilisé dans la config
      variable  user_sol_posl_pclk : natural           := ((roic_xsize - user_xsize)/2)/TAP_NUM + 1;
      variable y                                       : unsigned(QWORDS_NUM*32-1 downto 0);
      
   begin 
      
      comn_fpa_diag_mode                   := (others => diag_mode);
      comn_fpa_diag_type                   := resize(unsigned(DEFINE_TELOPS_DIAG_DEGR),32);
      comn_fpa_pwr_on                      := (others =>'1');
      comn_fpa_acq_trig_mode               := resize(unsigned(MODE_ITR_INT_END_TO_TRIG_START),32);
      comn_fpa_xtra_trig_mode              := resize(unsigned(MODE_READOUT_END_TO_TRIG_START),32);                   
      									                      
      comn_fpa_acq_trig_ctrl_dly           := to_unsigned(57484, comn_fpa_acq_trig_ctrl_dly'length);
      comn_fpa_xtra_trig_ctrl_dly          := to_unsigned(57484, comn_fpa_xtra_trig_ctrl_dly'length);
      comn_fpa_trig_ctrl_timeout_dly       := to_unsigned(57420, comn_fpa_trig_ctrl_timeout_dly'length);        
      comn_fpa_stretch_acq_trig            := (others =>'0');      
      
      diag_ysize                           := to_unsigned(user_ysize, 32);                 
      diag_xsize_div_tapnum                := to_unsigned(user_xsize/16, 32);
      roic_ystart                          := to_unsigned(0, 32);
      if user_ysize > 0 then               
         roic_ysize_div4_m1                := to_unsigned(user_ysize/4 - 1, 32);
      end if;                              
      
      vdet_code                            := to_unsigned(40, 32);
      ref_mode_en                          := (others => '0');
      ref_chn_en                           := (others => '0');
      clamping_level                       := to_unsigned(4, 32);
      real_mode_active_pixel_dly           := to_unsigned(16, 32);   
      
      speedup_lsydel                       := (others =>'1'); 
      
      raw_area_line_start_num              := to_unsigned(USER_FIRST_LINE_NUM, 32); 
      raw_area_line_end_num                := to_unsigned(roic_ysize + to_integer(raw_area_line_start_num) - 1, 32);
      raw_area_lsync_num                   := to_unsigned(roic_ysize + 2, 32);
      raw_area_line_period_pclk            := to_unsigned((roic_xsize/(TAP_NUM*PIXNUM_PER_TAP_PER_MCLK) + PAUSE_SIZE)*PIXNUM_PER_TAP_PER_MCLK,32);
      raw_area_readout_pclk_cnt_max        := to_unsigned(to_integer(raw_area_line_period_pclk) * (roic_ysize + FOVH_LINE + USER_FIRST_LINE_NUM - 1) + 1,32);
      raw_area_sof_posf_pclk               := to_unsigned(to_integer(raw_area_line_period_pclk) * (USER_FIRST_LINE_NUM - 1) + 1,32);
      raw_area_eof_posf_pclk               := to_unsigned(to_integer(raw_area_line_end_num) * to_integer(raw_area_line_period_pclk) - PAUSE_SIZE * PIXNUM_PER_TAP_PER_MCLK,32);
      raw_area_sol_posl_pclk               := to_unsigned(1, 32);
      raw_area_eol_posl_pclk               := to_unsigned(roic_xsize / (TAP_NUM * PIXNUM_PER_TAP_PER_MCLK) * PIXNUM_PER_TAP_PER_MCLK,32);
      raw_area_lsync_start_posl_pclk       := to_unsigned(39, 32);
      raw_area_lsync_end_posl_pclk         := to_unsigned(40, 32);
      raw_area_clk_id                      := to_unsigned(DEFINE_FPA_MCLK2_ID, 32);      
      
      user_area_line_start_num             := to_unsigned(USER_FIRST_LINE_NUM, 32);
	  user_area_line_start_num_m1          := to_unsigned(0, 32); --to_unsigned(USER_FIRST_LINE_NUM - 1, 32);
      --if USER_FIRST_LINE_NUM > 0 then
      --   user_area_line_start_num_m1       := to_unsigned(USER_FIRST_LINE_NUM - 1, 32);
      --end if;
      user_area_line_end_num               := to_unsigned(user_ysize + to_integer(user_area_line_start_num) - 1, 32);
      user_area_sol_posl_pclk              := to_unsigned(user_sol_posl_pclk, 32);
      user_area_eol_posl_pclk              := to_unsigned(user_sol_posl_pclk + user_xsize/(TAP_NUM*PIXNUM_PER_TAP_PER_MCLK)*PIXNUM_PER_TAP_PER_MCLK - 1,32);
      user_area_clk_id                     := to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32);   
      
      clk_area_a_line_start_num            := user_area_line_start_num; 
      clk_area_a_line_end_num              := user_area_line_end_num; 
	  clk_area_a_sol_posl_pclk             := minimum(user_area_eol_posl_pclk + 1 , raw_area_line_period_pclk - 1); --user_area_sol_posl_pclk;
      clk_area_a_eol_posl_pclk             := minimum(clk_area_a_sol_posl_pclk + 1, raw_area_line_period_pclk); --to_unsigned(to_integer(clk_area_a_sol_posl_pclk) + 1,32);
	  clk_area_a_spare                     := (others => '0');
      clk_area_a_clk_id                    := to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32); 
      
      clk_area_b_line_start_num            := to_unsigned(to_integer(raw_area_line_start_num) - 1,32); --user_area_line_start_num;                    
      clk_area_b_line_end_num              := to_unsigned(to_integer(raw_area_line_end_num) + 1,32);  --user_area_line_end_num;                       
	  clk_area_b_sol_posl_pclk             := raw_area_lsync_start_posl_pclk - 2;--raw_area_lsync_start_posl_pclk; --user_area_sol_posl_pclk;                     
      clk_area_b_eol_posl_pclk             := raw_area_lsync_end_posl_pclk + 2; --user_area_eol_posl_pclk;                     
	  clk_area_b_spare                     := (others => '0');                             
      clk_area_b_clk_id                    := to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32);
	  
	  clk_area_c_line_start_num			   := clk_area_b_line_start_num;
	  clk_area_c_line_end_num              := clk_area_b_line_end_num;
	  if (to_integer(user_area_sol_posl_pclk) - 6) <= 1 then
			clk_area_c_sol_posl_pclk := to_unsigned(1,32);	  	
	  else
		  	clk_area_c_sol_posl_pclk := user_area_sol_posl_pclk - 6;
	  end if;
	  if (to_integer(user_area_sol_posl_pclk) - 1) <= 2 then
			clk_area_c_eol_posl_pclk := to_unsigned(2,32);	  	
	  else
		  	clk_area_c_eol_posl_pclk := user_area_sol_posl_pclk - 1;
	  end if;
	  clk_area_c_spare                     := (others => '0');
	  clk_area_c_clk_id                    := to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32);	   

	  pix_samp_num_per_ch                  := to_unsigned(1, 32);
      
      hgood_samp_sum_num                   := to_unsigned(1, 32);                                      
      hgood_samp_mean_numerator            := to_unsigned(2**21, 32);                           
      vgood_samp_sum_num                   := to_unsigned(1, 32);                                      
      vgood_samp_mean_numerator            := to_unsigned(2**21, 32);                           
      good_samp_first_pos_per_ch           := pix_samp_num_per_ch;
      good_samp_last_pos_per_ch            := pix_samp_num_per_ch; 
      
      adc_clk_source_phase1                := to_unsigned(0, 32);
      adc_clk_pipe_sel1                    := to_unsigned(0, 32);
      
      proxim_is_flegx                      := to_unsigned(1, 32);
      
      lsydel_mclk                          := to_unsigned(143,32);
      boost_mode                           := to_unsigned(23,32);
      
      spare2a                              := to_unsigned(0,32);
      adc_clk_source_phase2                := to_unsigned(0, 32);
      adc_clk_pipe_sel2                    := to_unsigned(0, 32);
      adc_clk_source_phase3                := to_unsigned(0, 32);
      adc_clk_pipe_sel3                    := to_unsigned(0,32);
      spare3c                              := to_unsigned(0,32);
      adc_clk_source_phase4                := to_unsigned(0, 32);
      adc_clk_pipe_sel4                    := to_unsigned(0,32);
      
      -- Electronic chain correction                    
      -- valeurs par defaut (mode normal)                                                                                                                                               
      elcorr_enabled                       := (others => C_ELCORR_ENABLED);
      if (diag_mode = '1') then 
         elcorr_enabled                    := (others => '0');
      end if;
      
      elcorr_spare1                        := to_unsigned(0, 32);
      elcorr_spare2                        := to_unsigned(0, 32);
      elcorr_spare3                        := to_unsigned(0, 32);
      elcorr_spare4                        := to_unsigned(0, 32);
      
      elcorr_ref_cfg_0_ref_enabled         := to_unsigned(0, 32); 
      elcorr_ref_cfg_0_ref_cont_meas_mode  := to_unsigned(0, 32); 
      elcorr_ref_cfg_0_start_dly_sampclk   := to_unsigned(6, 32);        
      elcorr_ref_cfg_0_samp_num_per_ch     := to_unsigned(120, 32);
      elcorr_ref_cfg_0_samp_mean_numerator := to_unsigned(17476, 32);     
      elcorr_ref_cfg_0_ref_value           := to_unsigned(5829, 32);     
      
      elcorr_ref_cfg_1_ref_enabled         := to_unsigned(1, 32);          
      elcorr_ref_cfg_1_ref_cont_meas_mode  := (others => '0');             
      elcorr_ref_cfg_1_start_dly_sampclk   := to_unsigned(6, 32);          
      elcorr_ref_cfg_1_samp_num_per_ch     := to_unsigned(120, 32);         
      elcorr_ref_cfg_1_samp_mean_numerator := to_unsigned(17476, 32);      
      elcorr_ref_cfg_1_ref_value           := to_unsigned(2360, 32);  --   
      
      elcorr_ref_dac_id                    := to_unsigned(5,32);
      elcorr_atemp_gain                    := to_unsigned(1, 32);          
      elcorr_atemp_ofs                     := to_unsigned(7930, 32);                     
      sat_ctrl_en                          := (others => '0');                        
      
      elcorr_ref0_op_sel                   := resize(ELCORR_SW_TO_NORMAL_OP, 32);
      elcorr_ref1_op_sel                   := resize(ELCORR_SW_TO_NORMAL_OP, 32);
      elcorr_mult_op_sel                   := resize(ELCORR_SW_TO_NORMAL_OP, 32);
      elcorr_div_op_sel                    := resize(ELCORR_SW_TO_NORMAL_OP, 32); 
      elcorr_add_op_sel                    := resize(ELCORR_SW_TO_NORMAL_OP, 32);  
      
      -- sortie de la reference0
      if (C_elcorr_ref0_image_map_enabled = '1')  then              -- pour sortir l'image de la reference0
         elcorr_ref0_op_sel                := resize(ELCORR_SW_TO_PATH2, 32);
         elcorr_ref1_op_sel                := resize(ELCORR_SW_TO_PATH1, 32);  -- pas necessaire
         elcorr_mult_op_sel                := resize(ELCORR_SW_TO_PATH1, 32);
         elcorr_div_op_sel                 := resize(ELCORR_SW_TO_PATH1, 32); 
         elcorr_add_op_sel                 := resize(ELCORR_SW_TO_PATH1, 32); 
      end if;
      
      -- sortie de la reference1
      if (C_elcorr_ref1_image_map_enabled = '1')  then              -- pour sortir l'image de la reference1
         elcorr_ref0_op_sel                := resize(ELCORR_SW_TO_PATH1, 32); -- pas necessaire
         elcorr_ref1_op_sel                := resize(ELCORR_SW_TO_PATH2, 32);  
         elcorr_mult_op_sel                := resize(ELCORR_SW_TO_PATH1, 32);
         elcorr_div_op_sel                 := resize(ELCORR_SW_TO_PATH2, 32); 
         elcorr_add_op_sel                 := resize(ELCORR_SW_TO_PATH1, 32); 
      end if;
      
      -- desactivation de la correction electronique
      if (elcorr_enabled = 0)  then
         elcorr_ref0_op_sel                := resize(ELCORR_SW_TO_PATH1, 32); 
         elcorr_ref1_op_sel                := resize(ELCORR_SW_TO_PATH2, 32); -- pas necessaire 
         elcorr_mult_op_sel                := resize(ELCORR_SW_TO_PATH1, 32);
         elcorr_div_op_sel                 := resize(ELCORR_SW_TO_PATH1, 32); 
         elcorr_add_op_sel                 := resize(ELCORR_SW_TO_PATH1, 32);   
      end if; 
      
      roic_dbg_reg := to_unsigned(C_ROIC_DBG_REG, 32);
      
      
      roic_test_row_en := (others => '0');
      roic_cst_output_mode := (others => '0');
      --elcorr_gain_cont_calc_mode := (others => '0');
      
      cfg_num  := to_unsigned(send_id, cfg_num'length);                   
      -- dac_free_running_mode  := (others => '0');
      if user_xsize <= 320 then
         --dac_free_running_mode  := (others => '1');
         --elcorr_gain_cont_calc_mode := (others => '1');
      end if; 
      
      comn_fpa_intf_data_source :=  (others => '0');
      
      single_samp_mode_en           := to_unsigned(1, 32);  
      nominal_clk_id_sample_pos     := to_unsigned(1, 32);  
      mclk1_id_sample_pos           := to_unsigned(1, 32);  
      mclk2_id_sample_pos           := to_unsigned(1, 32);  
      mclk3_id_sample_pos           := to_unsigned(1, 32);
      
      -- elcorr en mode référence constante
      elcorr_ref_cfg_0_forced_val_enabled := (others => '0');
      elcorr_ref_cfg_0_forced_val         := (others => '0');
      elcorr_ref_cfg_1_forced_val_enabled := (others => '0');
      elcorr_ref_cfg_1_forced_val         := (others => '0');
      
      -- clipper de range dynamique
      dynrange_scaling_numerator := to_unsigned(2097152, 32);
      dynrange_clipping_level    := to_unsigned(8191, 32);
      dynrange_global_offset     := to_unsigned(0, 32);
      dynrange_op_sel            := to_unsigned(3, 32);      
      
      -- cfg usager
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
      & diag_ysize                              
      & diag_xsize_div_tapnum                   
      & roic_ystart                             
      & roic_ysize_div4_m1                      
      & vdet_code                               
      & ref_mode_en                             
      & ref_chn_en                              
      & clamping_level                          
      & real_mode_active_pixel_dly              
      & user_area_line_start_num_m1                                 
      & proxim_is_flegx                                 
      & raw_area_line_start_num                 
      & raw_area_line_end_num                   
      & raw_area_sof_posf_pclk                  
      & raw_area_eof_posf_pclk                  
      & raw_area_sol_posl_pclk                  
      & raw_area_eol_posl_pclk                  
      & raw_area_lsync_start_posl_pclk          
      & raw_area_lsync_end_posl_pclk            
      & raw_area_lsync_num                      
      & raw_area_clk_id                         
      & raw_area_line_period_pclk               
      & raw_area_readout_pclk_cnt_max           
      & user_area_line_start_num                
      & user_area_line_end_num                  
      & user_area_sol_posl_pclk                 
      & user_area_eol_posl_pclk                 
      & user_area_clk_id                        
      & clk_area_a_line_start_num               
      & clk_area_a_line_end_num                 
      & clk_area_a_sol_posl_pclk                
      & clk_area_a_eol_posl_pclk                
      & clk_area_a_spare                        
      & clk_area_a_clk_id                       
      & clk_area_b_line_start_num               
      & clk_area_b_line_end_num                 
      & clk_area_b_sol_posl_pclk                
      & clk_area_b_eol_posl_pclk                
      & clk_area_b_spare                        
      & clk_area_b_clk_id                       
      & pix_samp_num_per_ch                     
      & hgood_samp_sum_num                      
      & hgood_samp_mean_numerator               
      & vgood_samp_sum_num                      
      & vgood_samp_mean_numerator               
      & good_samp_first_pos_per_ch              
      & good_samp_last_pos_per_ch               
      & adc_clk_source_phase1
      & adc_clk_pipe_sel1
      & spare2a                                 
      & lsydel_mclk                             
      & boost_mode                              
      & speedup_lsydel                          
      & adc_clk_source_phase2                                 
      & adc_clk_pipe_sel2                                 
      & elcorr_enabled                          
      & elcorr_spare1                           
      & elcorr_spare2                           
      & elcorr_ref_cfg_0_ref_enabled            
      & elcorr_ref_cfg_0_ref_cont_meas_mode     
      & elcorr_ref_cfg_0_start_dly_sampclk      
      & elcorr_ref_cfg_0_samp_num_per_ch        
      & elcorr_ref_cfg_0_samp_mean_numerator    
      & elcorr_ref_cfg_0_ref_value              
      & elcorr_ref_cfg_1_ref_enabled            
      & elcorr_ref_cfg_1_ref_cont_meas_mode     
      & elcorr_ref_cfg_1_start_dly_sampclk      
      & elcorr_ref_cfg_1_samp_num_per_ch        
      & elcorr_ref_cfg_1_samp_mean_numerator    
      & elcorr_ref_cfg_1_ref_value              
      & elcorr_ref_dac_id                       
      & elcorr_atemp_gain                       
      & elcorr_atemp_ofs                        
      & elcorr_ref0_op_sel                      
      & elcorr_ref1_op_sel                      
      & elcorr_mult_op_sel                      
      & elcorr_div_op_sel                       
      & elcorr_add_op_sel                       
      & elcorr_spare3                           
      & sat_ctrl_en                             
      & cfg_num                                 
      & elcorr_spare4                          
      & roic_cst_output_mode
      & adc_clk_source_phase3                                
      & adc_clk_pipe_sel3                                
      & spare3c                                
      & roic_dbg_reg                           
      & roic_test_row_en                       
      & adc_clk_source_phase4                   
      & adc_clk_pipe_sel4
      & single_samp_mode_en      
      & nominal_clk_id_sample_pos
      & mclk1_id_sample_pos      
      & mclk2_id_sample_pos      
      & mclk3_id_sample_pos
      & elcorr_ref_cfg_0_forced_val_enabled
      & elcorr_ref_cfg_0_forced_val
      & elcorr_ref_cfg_1_forced_val_enabled
      & elcorr_ref_cfg_1_forced_val
      & dynrange_scaling_numerator
      & dynrange_clipping_level
      & dynrange_global_offset
      & dynrange_op_sel
      & clk_area_c_line_start_num               
      & clk_area_c_line_end_num                 
      & clk_area_c_sol_posl_pclk                
      & clk_area_c_eol_posl_pclk                
      & clk_area_c_spare                        
      & clk_area_c_clk_id;
      return y;
   end to_intf_cfg;
   
end package body isc0804A_2k_intf_testbench_pkg;
