------------------------------------------------------------------
--!   @file scorpiomwA_300Hz_intf_testbench_pkgpkg.vhd
--!   @brief Package file for TEL-2000 projects.
--!   @details This file contains the records and constants used in the project.
--!
--!   $Rev: 27618 $
--!   $Author: enofodjie $
--!   $Date: 2022-06-27 11:26:52 -0400 (lun., 27 juin 2022) $
--!   $Id: scorpiomwA_300Hz_intf_testbench_pkg.vhd 27618 2022-06-27 15:26:52Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2022-06-27%20-%20scorpiomwA_300Hz%20ENO/aldec/src/FPA/scorpiomwA_300Hz/src/scorpiomwA_300Hz_intf_testbench_pkg.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.MATH_REAL.all;
use work.fpa_common_pkg.all; 
use work.fpa_define.all;

package scorpiomwA_300Hz_intf_testbench_pkg is           
   
   constant LOVH_MCLK                  : integer := 0;
   constant TAP_NUM                    : integer := 4; 
   constant PIXNUM_PER_TAP_PER_MCLK    : integer := 1;
   constant QWORDS_NUM                 : natural := 81-6;
   
   -- Electrical correction : embedded switches control
   constant ELCORR_SW_TO_PATH1             : unsigned(1 downto 0) :=   "01";
   constant ELCORR_SW_TO_PATH2             : unsigned(1 downto 0) :=   "10";
   constant ELCORR_SW_TO_NORMAL_OP         : unsigned(1 downto 0) :=   "11";
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; offsetx:natural; offsety:natural; send_id:natural) return unsigned;
   
   
end scorpiomwA_300Hz_intf_testbench_pkg;

package body scorpiomwA_300Hz_intf_testbench_pkg is
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; offsetx:natural; offsety:natural; send_id:natural) return unsigned is 
      
      variable comn_fpa_diag_mode                                  : unsigned(31 downto 0);
      variable comn_fpa_diag_type                                  : unsigned(31 downto 0);
      variable comn_fpa_pwr_on                                     : unsigned(31 downto 0);
      variable comn_fpa_init_cfg                                   : unsigned(31 downto 0);
      variable comn_fpa_init_cfg_received                          : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_mode                              : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_ctrl_dly                          : unsigned(31 downto 0);
      variable comn_fpa_xtra_trig_mode                             : unsigned(31 downto 0);                            
      variable comn_fpa_xtra_trig_ctrl_dly                         : unsigned(31 downto 0);
      variable comn_fpa_trig_ctrl_timeout_dly                      : unsigned(31 downto 0);
      variable comn_fpa_stretch_acq_trig                           : unsigned(31 downto 0);
      variable comn_fpa_intf_data_source                           : unsigned(31 downto 0);
      variable roic_xstart                                         : unsigned(31 downto 0);
      variable roic_ystart                                         : unsigned(31 downto 0);
      variable roic_xsize                                          : unsigned(31 downto 0);
      variable roic_ysize                                          : unsigned(31 downto 0);
      variable roic_windcfg_part1                                  : unsigned(31 downto 0);
      variable roic_windcfg_part2                                  : unsigned(31 downto 0);
      variable roic_windcfg_part3                                  : unsigned(31 downto 0);
      variable roic_windcfg_part4                                  : unsigned(31 downto 0);
      variable roic_uprow_upcol                                    : unsigned(31 downto 0);
      variable roic_sizea_sizeb                                    : unsigned(31 downto 0);           
      variable roic_itr                                            : unsigned(31 downto 0);
      variable roic_gain                                           : unsigned(31 downto 0);
      variable roic_gpol_code                                      : unsigned(31 downto 0); 
      variable roic_reset_time_mclk                                : unsigned(31 downto 0);
      variable diag_ysize                                          : unsigned(31 downto 0);
      variable diag_xsize_div_tapnum                               : unsigned(31 downto 0);
      variable real_mode_active_pixel_dly                          : unsigned(31 downto 0);
      variable adc_quad2_en                                        : unsigned(31 downto 0);
      variable chn_diversity_en                                    : unsigned(31 downto 0);
      variable raw_area_line_start_num                             : unsigned(31 downto 0);     
      variable raw_area_line_end_num                               : unsigned(31 downto 0);
      variable raw_area_sof_posf_pclk                              : unsigned(31 downto 0);                 
      variable raw_area_eof_posf_pclk                              : unsigned(31 downto 0);                 
      variable raw_area_sol_posl_pclk                              : unsigned(31 downto 0);                 
      variable raw_area_eol_posl_pclk                              : unsigned(31 downto 0);                 
      variable raw_area_lsync_start_posl_pclk                      : unsigned(31 downto 0);                 
      variable raw_area_lsync_end_posl_pclk                        : unsigned(31 downto 0);                 
      variable raw_area_lsync_num                                  : unsigned(31 downto 0);                                           
      variable raw_area_clk_id                                     : unsigned(31 downto 0);                                            
      variable raw_area_line_period_pclk                           : unsigned(31 downto 0);                  
      variable raw_area_readout_pclk_cnt_max                       : unsigned(31 downto 0);                                  
      variable user_area_line_start_num                            : unsigned(31 downto 0);                  
      variable user_area_line_end_num                              : unsigned(31 downto 0);                  
      variable user_area_sol_posl_pclk                             : unsigned(31 downto 0);                                            
      variable user_area_eol_posl_pclk                             : unsigned(31 downto 0) := (others => '0');                                            
      variable user_area_clk_id                                    : unsigned(31 downto 0);                 
      variable clk_area_a_line_start_num                           : unsigned(31 downto 0) := (others => '0'); 
      variable clk_area_a_line_end_num                             : unsigned(31 downto 0) := (others => '0');
      variable clk_area_a_sol_posl_pclk                            : unsigned(31 downto 0);
      variable clk_area_a_eol_posl_pclk                            : unsigned(31 downto 0);
      variable clk_area_a_clk_id                                   : unsigned(31 downto 0);
      variable clk_area_a_spare                                    : unsigned(31 downto 0);
      variable clk_area_b_line_start_num                           : unsigned(31 downto 0);
      variable clk_area_b_line_end_num                             : unsigned(31 downto 0);
      variable clk_area_b_sol_posl_pclk                            : unsigned(31 downto 0);
      variable clk_area_b_eol_posl_pclk                            : unsigned(31 downto 0);
      variable clk_area_b_clk_id                                   : unsigned(31 downto 0);
      variable clk_area_b_spare                                    : unsigned(31 downto 0);
      variable hgood_samp_sum_num                                  : unsigned(31 downto 0);
      variable hgood_samp_mean_numerator                           : unsigned(31 downto 0);
      variable vgood_samp_sum_num                                  : unsigned(31 downto 0);
      variable vgood_samp_mean_numerator                           : unsigned(31 downto 0);
      variable good_samp_first_pos_per_ch                          : unsigned(31 downto 0);
      variable good_samp_last_pos_per_ch                           : unsigned(31 downto 0);
      variable adc_clk_source_phase                                : unsigned(31 downto 0);
      variable adc_clk_pipe_sel                                    : unsigned(31 downto 0);
      variable cfg_num                                             : unsigned(31 downto 0);
      variable int_time_offset_mclk                                : unsigned(31 downto 0);
      variable nominal_clk_id_sample_pos                           : unsigned(31 downto 0);
      variable fast1_clk_id_sample_pos                             : unsigned(31 downto 0);
      variable fast2_clk_id_sample_pos                             : unsigned(31 downto 0);
      variable tir_dly_adc_clk                                     : unsigned(31 downto 0);
      variable single_samp_mode_en                                 : unsigned(31 downto 0);
      
      
      
      
      
      variable y                                                   : unsigned(QWORDS_NUM*32-1 downto 0);
      
      variable ROIC_ADDED_LINES : integer;
      
      
      
   begin
      -- Pour corriger la calibration en sous-fenetre on lit les 2 lignes précédentes
      if offsety < 2 then
         ROIC_ADDED_LINES := 0;
      else
         ROIC_ADDED_LINES := 2;
      end if;
      
      comn_fpa_diag_mode               :=  (others => diag_mode);                                               
      comn_fpa_diag_type               :=  resize(unsigned(DEFINE_TELOPS_DIAG_DEGR),32);                 
      comn_fpa_pwr_on                  :=  (others =>'1');                                               
      comn_fpa_acq_trig_mode           :=  resize(unsigned(MODE_READOUT_END_TO_TRIG_START),32);
      comn_fpa_xtra_trig_mode          :=  resize(unsigned(MODE_READOUT_END_TO_TRIG_START),32);
      comn_fpa_acq_trig_ctrl_dly       :=  to_unsigned(100, comn_fpa_acq_trig_ctrl_dly'length);            
      comn_fpa_trig_ctrl_timeout_dly   :=  to_unsigned(8000, comn_fpa_trig_ctrl_timeout_dly'length);        
      comn_fpa_xtra_trig_ctrl_dly      :=  to_unsigned(100, comn_fpa_xtra_trig_ctrl_dly'length);
      comn_fpa_stretch_acq_trig        :=  to_unsigned(0, 32);
      
      comn_fpa_intf_data_source        := resize(unsigned('0'&DATA_SOURCE_INSIDE_FPGA), 32);
      
      roic_itr                         := (others => '1');      
      
      roic_xstart                      := to_unsigned(offsetx, 32);  
      roic_ystart                      := to_unsigned(offsety - ROIC_ADDED_LINES, 32);  
      roic_xsize                       := to_unsigned(user_xsize, 32);  
      roic_ysize                       := to_unsigned(user_ysize + ROIC_ADDED_LINES, 32);  
      roic_gain                        := (others => '0');
      roic_windcfg_part1               := to_unsigned(1, roic_windcfg_part1'length);
      roic_windcfg_part2               := to_unsigned(2, roic_windcfg_part2'length);
      roic_windcfg_part3               := to_unsigned(3, roic_windcfg_part3'length);
      roic_windcfg_part4               := to_unsigned(4, roic_windcfg_part4'length);
      roic_uprow_upcol                 := (others => '0');
      roic_sizea_sizeb                 := (others => '0');
      roic_gain                        := (others => '0');      
      roic_gpol_code                   := to_unsigned(2, 32);      
      roic_reset_time_mclk             := to_unsigned(3076, 32);
      real_mode_active_pixel_dly       := to_unsigned(0, 32);
      adc_quad2_en                     := (others => '0');
      chn_diversity_en                 := (others => '0');
      diag_ysize                       := to_unsigned(user_ysize, 32);
      diag_xsize_div_tapnum            := to_unsigned(user_xsize/TAP_NUM, 32);
      
      -- raw area (fenetre en provenance du ROIC)
      raw_area_line_start_num        := to_unsigned(1, 32);                   
      raw_area_line_end_num          := raw_area_line_start_num + roic_ysize - 1; 
      raw_area_line_period_pclk      := to_unsigned(to_integer(roic_xsize)/TAP_NUM + LOVH_MCLK*PIXNUM_PER_TAP_PER_MCLK, 32);
      raw_area_sof_posf_pclk         := to_unsigned(LOVH_MCLK * PIXNUM_PER_TAP_PER_MCLK + 1, 32);
      raw_area_eof_posf_pclk         := to_unsigned(to_integer(raw_area_line_end_num) * to_integer(raw_area_line_period_pclk), 32);
      raw_area_sol_posl_pclk         := to_unsigned(LOVH_MCLK * PIXNUM_PER_TAP_PER_MCLK + 1, 32);
      raw_area_eol_posl_pclk         := raw_area_line_period_pclk;
      raw_area_lsync_start_posl_pclk := to_unsigned(1, 32);
      raw_area_lsync_end_posl_pclk   := to_unsigned(2, 32);
      raw_area_lsync_num             := raw_area_line_end_num;   
      raw_area_readout_pclk_cnt_max  := to_unsigned(to_integer(raw_area_line_period_pclk) * to_integer(roic_ysize) + 1, 32);                              -- ligne de reset du suphawk prise en compte
      raw_area_clk_id                := to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32); -- horloge par defaut
      
      -- user area (fenetre à envoyer à l'usager) 
      user_area_line_start_num       := raw_area_line_start_num + ROIC_ADDED_LINES; 
      user_area_line_end_num         := raw_area_line_end_num;
      user_area_sol_posl_pclk        := raw_area_sol_posl_pclk; 
      user_area_eol_posl_pclk        := raw_area_eol_posl_pclk;
      user_area_clk_id               := to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32); 
      
      -- definition de la zone FPA_SLOW_MCLK  
      clk_area_a_line_start_num      := user_area_line_start_num;
      clk_area_a_line_end_num        := user_area_line_end_num;
      clk_area_a_sol_posl_pclk       := user_area_sol_posl_pclk;
      clk_area_a_eol_posl_pclk       := user_area_eol_posl_pclk;   
      clk_area_a_clk_id              := to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32);
      clk_area_a_spare               := (others =>'0');
      
      -- definition de la zone FPA_FAST_MCLK  
      clk_area_b_line_start_num      := user_area_line_start_num;   -- l'origine de la ligne est 1 mais le fait de mettre 0 est correct egalementcar je suis certain de couvrir toute ligne avant 1 
      clk_area_b_line_end_num        := user_area_line_end_num;
      clk_area_b_sol_posl_pclk       := clk_area_a_sol_posl_pclk;
      clk_area_b_eol_posl_pclk       := clk_area_a_eol_posl_pclk; -- juste avant le debut de la zone user  
      clk_area_b_clk_id              := to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32);
      clk_area_b_spare               := (others =>'0');
      
      -- sampling
      hgood_samp_sum_num          		:= to_unsigned(1, hgood_samp_sum_num'length); 
      hgood_samp_mean_numerator   		:= to_unsigned(2**21, hgood_samp_mean_numerator'length); 
      vgood_samp_sum_num          		:= to_unsigned(1, vgood_samp_sum_num'length); 
      vgood_samp_mean_numerator   		:= to_unsigned(2**21, vgood_samp_mean_numerator'length); 
      good_samp_first_pos_per_ch  		:= to_unsigned(1, good_samp_first_pos_per_ch'length); 
      good_samp_last_pos_per_ch   		:= to_unsigned(1, good_samp_last_pos_per_ch'length); 
      
      adc_clk_source_phase             := to_unsigned(1426, 32); -- to_unsigned(70*send_id, 32);
      adc_clk_pipe_sel                 := to_unsigned(0, 32); -- to_unsigned(send_id, 32);     
      cfg_num                          := to_unsigned(send_id, cfg_num'length);        
      int_time_offset_mclk             := roic_reset_time_mclk;
      
      single_samp_mode_en              := to_unsigned(1, 32);  
      
      nominal_clk_id_sample_pos        := to_unsigned(1, 32);  -- 4
      fast1_clk_id_sample_pos          := to_unsigned(1, 32);  -- 1
      fast2_clk_id_sample_pos          := to_unsigned(1, 32);  -- 1
      tir_dly_adc_clk                  := to_unsigned(10, 32); 
      
      -- comn_fpa_xtra_trig_period_min  :=  to_unsigned(10*to_integer(raw_area_readout_pclk_cnt_max), comn_fpa_xtra_trig_period_min'length);       
      
      
      
      -- cfg usager
      y := 
      comn_fpa_diag_mode                   
      & comn_fpa_diag_type                   
      & comn_fpa_pwr_on                      
      & comn_fpa_init_cfg                    
      & comn_fpa_init_cfg_received           
      & comn_fpa_acq_trig_mode               
      & comn_fpa_acq_trig_ctrl_dly           
      & comn_fpa_xtra_trig_mode              
      & comn_fpa_xtra_trig_ctrl_dly          
      & comn_fpa_trig_ctrl_timeout_dly       
      & comn_fpa_stretch_acq_trig            
      & comn_fpa_intf_data_source            
      & roic_xstart                          
      & roic_ystart                          
      & roic_xsize                           
      & roic_ysize                           
      & roic_windcfg_part1                   
      & roic_windcfg_part2                   
      & roic_windcfg_part3                   
      & roic_windcfg_part4                   
      & roic_uprow_upcol                     
      & roic_sizea_sizeb                     
      & roic_itr                             
      & roic_gain                            
      & roic_gpol_code                       
      & roic_reset_time_mclk                 
      & diag_ysize                           
      & diag_xsize_div_tapnum                
      & real_mode_active_pixel_dly           
      & adc_quad2_en                         
      & chn_diversity_en                     
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
      & clk_area_a_clk_id                    
      & clk_area_a_spare                     
      & clk_area_b_line_start_num            
      & clk_area_b_line_end_num              
      & clk_area_b_sol_posl_pclk             
      & clk_area_b_eol_posl_pclk             
      & clk_area_b_clk_id                    
      & clk_area_b_spare                     
      & hgood_samp_sum_num                   
      & hgood_samp_mean_numerator            
      & vgood_samp_sum_num                   
      & vgood_samp_mean_numerator            
      & good_samp_first_pos_per_ch           
      & good_samp_last_pos_per_ch
      & adc_clk_source_phase                 
      & adc_clk_pipe_sel                     
      & cfg_num                              
      & int_time_offset_mclk
      & nominal_clk_id_sample_pos
      & fast1_clk_id_sample_pos  
      & fast2_clk_id_sample_pos  
      & tir_dly_adc_clk
      & single_samp_mode_en;
      
      return y;
   end to_intf_cfg;
   
end package body scorpiomwA_300Hz_intf_testbench_pkg;







































































