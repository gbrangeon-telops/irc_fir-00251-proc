------------------------------------------------------------------
--!   @file isc0804A_intf_testbench_pkgpkg.vhd
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
use work.fpa_define.all;

package isc0804A_intf_testbench_pkg is           
   
   constant PAUSE_SIZE                 : integer := 2*1;
   constant TAP_NUM                    : integer := 16;
   constant USER_FIRST_LINE_NUM        : integer := 2;
   constant STRETCH_LINE_LENGTH_MCLK   : integer := 1;
   constant C_ELEC_OFS_ENABLED         : std_logic := '1';
   constant C_ELEC_OFS_OFFSET_IMAGE_MAP: std_logic := '0';
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural) return unsigned;
   
   
end isc0804A_intf_testbench_pkg;

package body isc0804A_intf_testbench_pkg is
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural) return unsigned is 
      variable comn_fpa_diag_mode             : unsigned(31 downto  0);
      variable comn_fpa_diag_type             : unsigned(31 downto  0);
      variable comn_fpa_pwr_on                : unsigned(31 downto  0);
      variable comn_fpa_trig_ctrl_mode        : unsigned(31 downto  0);
      variable comn_fpa_acq_trig_ctrl_dly     : unsigned(31 downto  0);
      variable comn_fpa_acq_trig_period_min   : unsigned(31 downto  0);
      variable comn_fpa_xtra_trig_ctrl_dly    : unsigned(31 downto  0);
      variable comn_fpa_xtra_trig_period_min  : unsigned(31 downto  0);
      variable comn_fpa_stretch_acq_trig      : unsigned(31 downto  0);                 
      variable diag_ysize                     : unsigned(31 downto  0);
      variable diag_xsize_div_tapnum          : unsigned(31 downto  0);                                         
      variable roic_ystart                    : unsigned(31 downto  0);
      variable roic_ysize_div4_m1             : unsigned(31 downto  0);                                           
      variable vdet_code                      : unsigned(31 downto  0);
      variable ref_mode_en                    : unsigned(31 downto  0);
      variable ref_chn_en                     : unsigned(31 downto  0);
      variable itr                            : unsigned(31 downto  0);
      variable real_mode_active_pixel_dly     : unsigned(31 downto  0);
      variable speedup_lsydel                 : unsigned(31 downto  0);
      variable speedup_lsync                  : unsigned(31 downto  0);
      variable speedup_sample_row             : unsigned(31 downto  0);
      variable speedup_unused_area            : unsigned(31 downto  0);                           
      variable raw_area_line_start_num        : unsigned(31 downto  0);
      variable raw_area_line_end_num          : unsigned(31 downto  0);
      variable raw_area_sof_posf_pclk         : unsigned(31 downto  0);
      variable raw_area_eof_posf_pclk         : unsigned(31 downto  0);
      variable raw_area_sol_posl_pclk         : unsigned(31 downto  0);
      variable raw_area_eol_posl_pclk         : unsigned(31 downto  0);
      variable raw_area_eol_posl_pclk_p1      : unsigned(31 downto  0);
      variable raw_area_window_lsync_num      : unsigned(31 downto  0);
      variable raw_area_line_period_pclk      : unsigned(31 downto  0);
      variable raw_area_readout_pclk_cnt_max  : unsigned(31 downto  0);
      variable user_area_line_start_num       : unsigned(31 downto  0);
      variable user_area_line_end_num         : unsigned(31 downto  0);
      variable user_area_sol_posl_pclk        : unsigned(31 downto  0);
      variable user_area_eol_posl_pclk        : unsigned(31 downto  0);
      variable stretch_area_sol_posl_pclk     : unsigned(31 downto  0);
      variable stretch_area_eol_posl_pclk     : unsigned(31 downto  0);
      variable user_area_eol_posl_pclk_p1     : unsigned(31 downto  0);
      variable pix_samp_num_per_ch            : unsigned(31 downto  0);
      variable hgood_samp_sum_num             : unsigned(31 downto  0);
      variable hgood_samp_mean_numerator      : unsigned(31 downto  0);
      variable vgood_samp_sum_num             : unsigned(31 downto  0);
      variable vgood_samp_mean_numerator      : unsigned(31 downto  0);
      variable good_samp_first_pos_per_ch     : unsigned(31 downto  0);
      variable good_samp_last_pos_per_ch      : unsigned(31 downto  0);
      variable adc_clk_source_phase           : unsigned(31 downto  0);
      variable adc_clk_pipe_sel               : unsigned(31 downto  0); 
      variable spare1                         : unsigned(31 downto  0); 
      variable adc_clk_phase_4                : unsigned(31 downto  0); 
      variable lsydel_mclk                    : unsigned(31 downto  0);
      variable boost_mode                     : unsigned(31 downto  0);
      variable adc_clk_pipe_sync_pos          : unsigned(31 downto  0);
      variable elec_ofs_enabled               : unsigned(31 downto  0);
      variable elec_ofs_offset_null_forced     : unsigned(31 downto  0);  
      variable elec_ofs_pix_faked_value_forced : unsigned(31 downto  0);  
      variable elec_ofs_pix_faked_value        : unsigned(31 downto  0);  
      variable elec_ofs_offset_minus_pix_value : unsigned(31 downto  0);  
      variable elec_ofs_add_const              : unsigned(31 downto  0);  
      variable elec_ofs_start_dly_sampclk      : unsigned(31 downto  0);  
      variable elec_ofs_samp_num_per_ch        : unsigned(31 downto  0);
      variable elec_ofs_samp_mean_numerator    : unsigned(31 downto  0);
      variable elec_ofs_second_lane_enabled    : unsigned(31 downto  0);
      
      variable roic_xsize : natural            := 640;                                    -- pas utilisé dans la config 
      variable roic_ysize : natural            := user_ysize;                             -- pas utilisé dans la config
      variable user_sol_posl_pclk : natural    := ((roic_xsize - user_xsize)/2)/TAP_NUM + 1; 
      
      
      variable y                               : unsigned(62*32-1 downto 0);
      
   begin
      comn_fpa_diag_mode            := (others => diag_mode);
      comn_fpa_diag_type            := resize(unsigned(DEFINE_TELOPS_DIAG_DEGR),32);
      comn_fpa_pwr_on               := (others =>'1');
      comn_fpa_trig_ctrl_mode       := resize(unsigned(MODE_INT_END_TO_TRIG_START),32);
      comn_fpa_acq_trig_ctrl_dly    := to_unsigned(100000, comn_fpa_acq_trig_ctrl_dly'length);
      comn_fpa_acq_trig_period_min  := to_unsigned(100, comn_fpa_acq_trig_period_min'length);
      comn_fpa_xtra_trig_ctrl_dly   := to_unsigned(600, comn_fpa_xtra_trig_ctrl_dly'length);
      comn_fpa_xtra_trig_period_min := to_unsigned(100, comn_fpa_xtra_trig_period_min'length);        
      comn_fpa_stretch_acq_trig     := (others =>'0');
      
      
      diag_ysize                    := to_unsigned(user_ysize, 32);                 
      diag_xsize_div_tapnum         := to_unsigned(user_xsize/16, 32);
      roic_ystart                   := to_unsigned(0, 32);                 
      roic_ysize_div4_m1            := to_unsigned(0, 32);          
      
      vdet_code                     := (others => '0');
      ref_mode_en                   := (others => '0');
      ref_chn_en                    := (others => '0');
      itr                           := (others => '0'); 
      
      real_mode_active_pixel_dly    := to_unsigned(5, 32);   
      
      speedup_lsydel                := (others =>'0');
      speedup_lsync                 := (others =>'0');            
      speedup_sample_row            := (others =>'0');         
      speedup_unused_area           := (others =>'1'); 
      
      raw_area_line_start_num            := to_unsigned(USER_FIRST_LINE_NUM, 32); 
      raw_area_line_end_num              := to_unsigned(roic_ysize + to_integer(raw_area_line_start_num) - 1, 32);
      raw_area_window_lsync_num          := to_unsigned(roic_ysize + USER_FIRST_LINE_NUM, 32);
      raw_area_line_period_pclk          := to_unsigned((roic_xsize/TAP_NUM + PAUSE_SIZE), 32);
      raw_area_readout_pclk_cnt_max      := to_unsigned((roic_xsize/TAP_NUM + PAUSE_SIZE)*(roic_ysize + USER_FIRST_LINE_NUM) + 1, 32);
      raw_area_sof_posf_pclk             := resize(raw_area_line_period_pclk *(to_integer(raw_area_line_start_num) - 1) + 1, 32);
      raw_area_eof_posf_pclk             := resize(raw_area_line_end_num * raw_area_line_period_pclk-PAUSE_SIZE, 32);
      raw_area_sol_posl_pclk             := to_unsigned(1, 32);
      raw_area_eol_posl_pclk             := to_unsigned(roic_xsize/TAP_NUM, 32);
      raw_area_eol_posl_pclk_p1          := raw_area_eol_posl_pclk + 1;   
      
      user_area_line_start_num           := to_unsigned(USER_FIRST_LINE_NUM, 32); 
      user_area_line_end_num             := to_unsigned(user_ysize + to_integer(user_area_line_start_num) - 1, 32);
      user_area_sol_posl_pclk            := to_unsigned(user_sol_posl_pclk, 32);
      user_area_eol_posl_pclk            := to_unsigned((to_integer(user_area_sol_posl_pclk) + user_xsize/TAP_NUM - 1), 32);
      user_area_eol_posl_pclk_p1         := user_area_eol_posl_pclk + 1;   
      
      stretch_area_sol_posl_pclk         := user_area_eol_posl_pclk_p1;
      stretch_area_eol_posl_pclk         := to_unsigned(((to_integer(user_area_sol_posl_pclk) + user_xsize/TAP_NUM - 1) + 1 + 2*stretch_line_length_mclk - 1), 32);
      
      
      pix_samp_num_per_ch           := to_unsigned(DEFINE_FPA_PIX_SAMPLE_NUM_PER_CH, 32);
      
      hgood_samp_sum_num            := to_unsigned(1, 32);                                      
      hgood_samp_mean_numerator     := to_unsigned(2**21, 32);                           
      vgood_samp_sum_num            := to_unsigned(1, 32);                                      
      vgood_samp_mean_numerator     := to_unsigned(2**21, 32);                           
      good_samp_first_pos_per_ch    := pix_samp_num_per_ch;
      good_samp_last_pos_per_ch     := pix_samp_num_per_ch; 
      
      adc_clk_source_phase          := to_unsigned(90000, 32);
      adc_clk_pipe_sel              := to_unsigned(1, 32);
      spare1                        := to_unsigned(1, 32);
      
      lsydel_mclk                   := to_unsigned(143,32);
      boost_mode                    := to_unsigned(0,32);
      adc_clk_pipe_sync_pos         := to_unsigned(2,32);
      
      -- valeurs par defaut
      elec_ofs_enabled                   := (others => '1');  
      elec_ofs_offset_null_forced        := (others => '0');  
      elec_ofs_pix_faked_value_forced    := (others => '0');
      elec_ofs_pix_faked_value           := (others => '0');
      elec_ofs_offset_minus_pix_value    := (others => '0');
      
      elec_ofs_add_const                 := to_unsigned(600, 32);
      elec_ofs_start_dly_sampclk                 := to_unsigned(5, 32);
      elec_ofs_samp_num_per_ch           := to_unsigned(60,32);
      if elec_ofs_samp_num_per_ch > 0 then 
         elec_ofs_samp_mean_numerator       := to_unsigned(2**21, 32)/elec_ofs_samp_num_per_ch;
      end if;
      
      
      -- conditions         
      if C_ELEC_OFS_ENABLED = '0' then
         elec_ofs_offset_null_forced := (others => '1');    
         elec_ofs_add_const          := (others => '0');  
      else
         if C_ELEC_OFS_OFFSET_IMAGE_MAP = '1' then
            elec_ofs_pix_faked_value_forced    := (others => '1');
            elec_ofs_pix_faked_value           := (others => '0');
            elec_ofs_add_const                 := (others => '0');
            elec_ofs_offset_minus_pix_value    := (others => '1');
         end if;            
      end if;
      
      elec_ofs_second_lane_enabled := (others => '1');
      
      if comn_fpa_diag_mode(0) = '1' then   
         elec_ofs_offset_null_forced := (others => '1');    
         elec_ofs_add_const          := (others => '0');             
      end if;              
      
      -- cfg usager
      y :=  comn_fpa_diag_mode              
      & comn_fpa_diag_type              
      & comn_fpa_pwr_on                 
      & comn_fpa_trig_ctrl_mode         
      & comn_fpa_acq_trig_ctrl_dly      
      & comn_fpa_acq_trig_period_min    
      & comn_fpa_xtra_trig_ctrl_dly     
      & comn_fpa_xtra_trig_period_min   
      & comn_fpa_stretch_acq_trig       
      & diag_ysize                      
      & diag_xsize_div_tapnum           
      & roic_ystart                     
      & roic_ysize_div4_m1              
      & vdet_code                       
      & ref_mode_en                     
      & ref_chn_en                      
      & itr                             
      & real_mode_active_pixel_dly      
      & speedup_lsync                   
      & speedup_sample_row              
      & speedup_unused_area             
      & raw_area_line_start_num         
      & raw_area_line_end_num           
      & raw_area_sof_posf_pclk          
      & raw_area_eof_posf_pclk          
      & raw_area_sol_posl_pclk          
      & raw_area_eol_posl_pclk          
      & raw_area_eol_posl_pclk_p1       
      & raw_area_window_lsync_num       
      & raw_area_line_period_pclk       
      & raw_area_readout_pclk_cnt_max   
      & user_area_line_start_num        
      & user_area_line_end_num          
      & user_area_sol_posl_pclk         
      & user_area_eol_posl_pclk         
      & user_area_eol_posl_pclk_p1
      & stretch_area_sol_posl_pclk         
      & stretch_area_eol_posl_pclk    
      & pix_samp_num_per_ch             
      & hgood_samp_sum_num              
      & hgood_samp_mean_numerator       
      & vgood_samp_sum_num              
      & vgood_samp_mean_numerator       
      & good_samp_first_pos_per_ch      
      & good_samp_last_pos_per_ch       
      & adc_clk_source_phase
      & adc_clk_pipe_sel
      & spare1
      & lsydel_mclk                     
      & boost_mode
      & speedup_lsydel 
      & adc_clk_pipe_sync_pos
      & elec_ofs_enabled
      & elec_ofs_offset_null_forced    
      & elec_ofs_pix_faked_value_forced  
      & elec_ofs_pix_faked_value         
      & elec_ofs_offset_minus_pix_value  
      & elec_ofs_add_const               
      & elec_ofs_start_dly_sampclk               
      & elec_ofs_samp_num_per_ch          
      & elec_ofs_samp_mean_numerator
      & elec_ofs_second_lane_enabled;   
      
      return y;
   end to_intf_cfg;
   
end package body isc0804A_intf_testbench_pkg;