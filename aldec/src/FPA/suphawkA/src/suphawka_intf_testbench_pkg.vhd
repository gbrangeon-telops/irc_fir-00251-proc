------------------------------------------------------------------
--!   @file suphawkA_intf_testbench_pkgpkg.vhd
--!   @brief Package file for TEL-2000 projects.
--!   @details This file contains the records and constants used in the project.
--!
--!   $Rev: 22986 $
--!   $Author: enofodjie $
--!   $Date: 2019-03-11 22:32:41 -0400 (lun., 11 mars 2019) $
--!   $Id: suphawka_intf_testbench_pkg.vhd 22986 2019-03-12 02:32:41Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/FPA/suphawkA/src/suphawka_intf_testbench_pkg.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.MATH_REAL.all;
use work.fpa_common_pkg.all; 
use work.fpa_define.all;

package suphawkA_intf_testbench_pkg is           
   
   constant PAUSE_SIZE                 : integer := 3;
   constant TAP_NUM                    : integer := 8;
   constant C_ELCORR_ENABLED           : std_logic := '0';
   constant C_elcorr_ref0_image_map_enabled : std_logic := '0';
   constant C_elcorr_ref1_image_map_enabled : std_logic := '0';
   constant ELCORR_REF_DAC_ID          : integer := 5;
   constant C_ROIC_TEST_ROW_EN           : std_logic := '0';
   
   -- Electrical correction : embedded switches control
   constant ELCORR_SW_TO_PATH1             : unsigned(1 downto 0) :=   "01";
   constant ELCORR_SW_TO_PATH2             : unsigned(1 downto 0) :=   "10";
   constant ELCORR_SW_TO_NORMAL_OP         : unsigned(1 downto 0) :=   "11";
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned;
   
   
end suphawkA_intf_testbench_pkg;

package body suphawkA_intf_testbench_pkg is
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned is 
      variable comn_fpa_diag_mode                   : unsigned(31 downto 0);
      variable comn_fpa_diag_type                   : unsigned(31 downto 0);
      variable comn_fpa_pwr_on                      : unsigned(31 downto 0);
      variable comn_fpa_trig_ctrl_mode              : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_ctrl_dly           : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_period_min         : unsigned(31 downto 0);
      variable comn_fpa_xtra_trig_ctrl_dly          : unsigned(31 downto 0);
      variable comn_fpa_xtra_trig_period_min        : unsigned(31 downto 0);                            
      variable xstart                               : unsigned(31 downto 0);
      variable ystart                               : unsigned(31 downto 0);
      variable xsize                                : unsigned(31 downto 0);
      variable ysize                                : unsigned(31 downto 0);
      variable gain                                 : unsigned(31 downto 0);
      variable invert                               : unsigned(31 downto 0);
      variable revert                               : unsigned(31 downto 0);
      variable cbit_en                              : unsigned(31 downto 0);
      variable dig_code                             : unsigned(31 downto 0);
      variable colstart                             : unsigned(31 downto 0);
      variable colstop                              : unsigned(31 downto 0);
      variable rowstart                             : unsigned(31 downto 0);
      variable rowstop                              : unsigned(31 downto 0);
      variable active_subwindow                     : unsigned(31 downto 0);
      variable prv_dac_nominal_value                : unsigned(31 downto 0);
      variable real_mode_active_pixel_dly           : unsigned(31 downto 0);
      variable adc_quad2_en                         : unsigned(31 downto 0);
      variable chn_diversity_en                     : unsigned(31 downto 0);           
      variable readout_pclk_cnt_max                 : unsigned(31 downto 0);
      variable line_period_pclk                     : unsigned(31 downto 0);
      variable active_line_start_num                : unsigned(31 downto 0);
      variable active_line_end_num                  : unsigned(31 downto 0);
      variable pix_samp_num_per_ch                  : unsigned(31 downto 0);
      variable sof_posf_pclk                        : unsigned(31 downto 0);
      variable eof_posf_pclk                        : unsigned(31 downto 0);
      variable sol_posl_pclk                        : unsigned(31 downto 0);
      variable eol_posl_pclk                        : unsigned(31 downto 0);
      variable eol_posl_pclk_p1                     : unsigned(31 downto 0);      
      variable hgood_samp_sum_num                   : unsigned(31 downto 0);
      variable hgood_samp_mean_numerator            : unsigned(31 downto 0);
      variable vgood_samp_sum_num                   : unsigned(31 downto 0);
      variable vgood_samp_mean_numerator            : unsigned(31 downto 0);
      variable good_samp_first_pos_per_ch           : unsigned(31 downto 0);
      variable good_samp_last_pos_per_ch            : unsigned(31 downto 0);  
      variable xsize_div_tapnum                     : unsigned(31 downto 0);
      variable adc_clk_source_phase                 : unsigned(31 downto 0);
      variable adc_clk_pipe_sel                     : unsigned(31 downto 0); 
      variable comn_fpa_stretch_acq_trig            : unsigned(31 downto 0); 
      variable spare1                               : unsigned(31 downto 0); 
      variable spare2                               : unsigned(31 downto 0); 
      variable elcorr_enabled                       : unsigned(31 downto 0); 
      variable elcorr_pix_faked_value_forced        : unsigned(31 downto 0); 
      variable elcorr_pix_faked_value               : unsigned(31 downto 0);
      variable elcorr_ref_cfg_0_ref_enabled         : unsigned(31 downto 0);
      variable elcorr_ref_cfg_0_null_forced         : unsigned(31 downto 0);
      variable elcorr_ref_cfg_0_start_dly_sampclk   : unsigned(31 downto 0);  
      variable elcorr_ref_cfg_0_samp_num_per_ch     : unsigned(31 downto 0);  
      variable elcorr_ref_cfg_0_samp_mean_numerator : unsigned(31 downto 0);  
      variable elcorr_ref_cfg_0_ref_value           : unsigned(31 downto 0);  
      variable elcorr_ref_cfg_1_ref_enabled         : unsigned(31 downto 0);  
      variable elcorr_ref_cfg_1_null_forced         : unsigned(31 downto 0);  
      variable elcorr_ref_cfg_1_start_dly_sampclk   : unsigned(31 downto 0);
      variable elcorr_ref_cfg_1_samp_num_per_ch     : unsigned(31 downto 0);
      variable elcorr_ref_cfg_1_samp_mean_numerator : unsigned(31 downto 0);
      variable elcorr_ref_cfg_1_ref_value           : unsigned(31 downto 0);
      variable elcorr_ref_dac_id                    : unsigned(31 downto 0);
      variable elcorr_atemp_gain                    : unsigned(31 downto 0);
      variable elcorr_atemp_ofs                     : unsigned(31 downto 0);
      variable elcorr_ref0_op_sel                   : unsigned(31 downto 0);
      variable elcorr_ref1_op_sel                   : unsigned(31 downto 0);
      variable elcorr_mult_op_sel                   : unsigned(31 downto 0);
      variable elcorr_div_op_sel                    : unsigned(31 downto 0);
      variable elcorr_add_op_sel                    : unsigned(31 downto 0);
      variable sat_ctrl_en                          : unsigned(31 downto 0);
      variable elcorr_cont_calc_mode                : unsigned(31 downto 0);
      variable roic_cst_output_mode                 : unsigned(31 downto 0) := (others => '0');
      variable cfg_num                              : unsigned(31 downto 0);
      variable fpa_intf_data_source                 : unsigned(31 downto 0) := (others => '0');
      
      variable y                                    : unsigned(76*32-1 downto 0);
      
   begin
      comn_fpa_diag_mode             :=  (others => diag_mode);                                               
      comn_fpa_diag_type             :=  resize(unsigned(DEFINE_TELOPS_DIAG_DEGR),32);                 
      comn_fpa_pwr_on                :=  (others =>'1');                                               
      comn_fpa_trig_ctrl_mode        :=  resize(unsigned(MODE_INT_END_TO_TRIG_START),32);          
      
      xstart                         := to_unsigned(0, 32);  
      ystart                         := to_unsigned(0, 32);  
      xsize                          := to_unsigned(user_xsize, 32);  
      ysize                          := to_unsigned(user_ysize, 32);  
      gain                           := (others => '0');
      invert                         := (others => '0');
      revert                         := (others => '0');
      cbit_en                        := (others => '0');
      dig_code                       := (others => '0');
      
      
      colstart                       := xstart/TAP_NUM;  
      colstop                        := colstart + xsize/TAP_NUM - 1;  
      rowstart                       := ystart;  
      rowstop                        := rowstart + ysize - 1;  
      
      
      
      active_subwindow               := to_unsigned(0, 32); 
      prv_dac_nominal_value          := to_unsigned(1234, 32);  
      real_mode_active_pixel_dly     := to_unsigned(6, 32);
      adc_quad2_en                   := (others => '1');
      --      if comn_fpa_diag_mode = 1 then
      --         adc_quad2_en  := (others => '0');  
      --      end if;
      chn_diversity_en               := (others => '0'); 
      
      line_period_pclk               := to_unsigned(user_xsize/TAP_NUM + PAUSE_SIZE, 32);
      readout_pclk_cnt_max           := to_unsigned((user_xsize/TAP_NUM + PAUSE_SIZE)*(user_ysize) + 164, 32);   
      active_line_start_num          := to_unsigned(1, 32);
      
      if user_ysize > 1 then 
         active_line_end_num         := active_line_start_num + to_unsigned(user_ysize - 1, 32);
      end if;
      
      pix_samp_num_per_ch            := to_unsigned(1, 32);
      sof_posf_pclk                  := to_unsigned(PAUSE_SIZE, 32);
      
      if user_ysize > 1 then 
         eof_posf_pclk                  := to_unsigned(user_ysize * (user_xsize/TAP_NUM + PAUSE_SIZE) - 1, 32);
      end if;
      
      sol_posl_pclk                  := to_unsigned(PAUSE_SIZE, 32);
      eol_posl_pclk                  := line_period_pclk - 1;
      eol_posl_pclk_p1               := eol_posl_pclk + 1;
      
      good_samp_first_pos_per_ch     := to_unsigned(1, 32);
      good_samp_last_pos_per_ch      := to_unsigned(1, 32);   
      hgood_samp_sum_num             := to_unsigned(1, 32); 
      hgood_samp_mean_numerator      := to_unsigned(2**22/1, 32);
      vgood_samp_sum_num             := 1 + chn_diversity_en;
      vgood_samp_mean_numerator      := to_unsigned(2**22/1, 32);      
      xsize_div_tapnum               := to_unsigned(user_xsize/TAP_NUM, 32);
      
      adc_clk_source_phase           :=  to_unsigned(10, 32);
      adc_clk_pipe_sel               :=  to_unsigned(3, 32);
      comn_fpa_stretch_acq_trig      :=  to_unsigned(0, 32);
      
      spare1                         :=  to_unsigned(0, 32);
      spare2                         :=  to_unsigned(0, 32);
      
      -- Electronic chain correction                    
      -- valeurs par defaut (mode normal)                                                                                                                                               
      elcorr_enabled                       := (others => C_ELCORR_ENABLED);
      if (diag_mode = '1') then 
         elcorr_enabled                    := (others => '0');
      end if; 
      
      elcorr_pix_faked_value_forced        := (others => '0');              
      elcorr_pix_faked_value               := (others => '0');                     
      
      elcorr_ref_cfg_0_ref_enabled         := to_unsigned(1, 32);               
      elcorr_ref_cfg_0_null_forced         := (others => '0');              
      elcorr_ref_cfg_0_start_dly_sampclk   := to_unsigned(2, 32);        
      elcorr_ref_cfg_0_samp_num_per_ch     := to_unsigned(4, 32);
      elcorr_ref_cfg_0_samp_mean_numerator := to_unsigned(2**21/4, 32);     
      elcorr_ref_cfg_0_ref_value           := to_unsigned(2000, 32);  --      
      
      elcorr_ref_cfg_1_ref_enabled         := to_unsigned(1, 32);          
      elcorr_ref_cfg_1_null_forced         := (others => '0');             
      elcorr_ref_cfg_1_start_dly_sampclk   := to_unsigned(2, 32);          
      elcorr_ref_cfg_1_samp_num_per_ch     := to_unsigned(4, 32);         
      elcorr_ref_cfg_1_samp_mean_numerator := to_unsigned(2**21/4, 32);      
      elcorr_ref_cfg_1_ref_value           := to_unsigned(4000, 32);  --   
      
      elcorr_ref_dac_id                    := to_unsigned(5, 32);  --       
      elcorr_atemp_gain                    := to_unsigned(1, 32);          
      elcorr_atemp_ofs                     := to_unsigned(540, 32);                     
      sat_ctrl_en                          := (others => '1');                        
      
      elcorr_ref0_op_sel                   := resize(ELCORR_SW_TO_NORMAL_OP, 32);
      elcorr_ref1_op_sel                   := resize(ELCORR_SW_TO_NORMAL_OP, 32);
      elcorr_mult_op_sel                   := resize(ELCORR_SW_TO_PATH1, 32);
      elcorr_div_op_sel                    := resize(ELCORR_SW_TO_PATH1, 32); 
      elcorr_add_op_sel                    := resize(ELCORR_SW_TO_NORMAL_OP, 32);  
      
      -- sortie de la reference0
      if (C_elcorr_ref0_image_map_enabled = '1')  then              -- pour sortir l'image de la reference0
         elcorr_pix_faked_value_forced     := to_unsigned(1, 32);         -- etape 1: on permet de forcer la valeur des pixels à une valeur nulle. 
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
      
      elcorr_cont_calc_mode := (others => '0');
      
      cfg_num  := to_unsigned(send_id, cfg_num'length);
      
      
      comn_fpa_acq_trig_ctrl_dly     :=  to_unsigned(10*to_integer(readout_pclk_cnt_max), comn_fpa_acq_trig_ctrl_dly'length);            
      comn_fpa_acq_trig_period_min   :=  to_unsigned(10*to_integer(readout_pclk_cnt_max), comn_fpa_acq_trig_period_min'length);        
      comn_fpa_xtra_trig_ctrl_dly    :=  to_unsigned(10*to_integer(readout_pclk_cnt_max), comn_fpa_xtra_trig_ctrl_dly'length);         
      comn_fpa_xtra_trig_period_min  :=  to_unsigned(10*to_integer(readout_pclk_cnt_max), comn_fpa_xtra_trig_period_min'length);       
      
      
      
      
      -- cfg usager
      y :=  comn_fpa_diag_mode              
      & comn_fpa_diag_type              
      & comn_fpa_pwr_on                 
      & comn_fpa_trig_ctrl_mode         
      & comn_fpa_acq_trig_ctrl_dly      
      & comn_fpa_acq_trig_period_min    
      & comn_fpa_xtra_trig_ctrl_dly     
      & comn_fpa_xtra_trig_period_min   
      
      & xstart                              
      & ystart                              
      & xsize                               
      & ysize                               
      & gain                                
      & invert                              
      & revert                              
      & cbit_en                             
      & dig_code                            
      & colstart                                
      & colstop                                
      & rowstart                                
      & rowstop                                
      & active_subwindow                             
      & prv_dac_nominal_value                         
      & real_mode_active_pixel_dly          
      & adc_quad2_en                        
      & chn_diversity_en                    
      & readout_pclk_cnt_max                
      & line_period_pclk                    
      & active_line_start_num               
      & active_line_end_num
      & pix_samp_num_per_ch
      & sof_posf_pclk                       
      & eof_posf_pclk                       
      & sol_posl_pclk                       
      & eol_posl_pclk                       
      & eol_posl_pclk_p1                    
      & hgood_samp_sum_num                  
      & hgood_samp_mean_numerator           
      & vgood_samp_sum_num                  
      & vgood_samp_mean_numerator           
      & good_samp_first_pos_per_ch          
      & good_samp_last_pos_per_ch           
      & xsize_div_tapnum                                                              
      & adc_clk_source_phase                       
      & adc_clk_pipe_sel
      & comn_fpa_stretch_acq_trig
      & spare1
      & spare2
      & elcorr_enabled                        
      & elcorr_pix_faked_value_forced         
      & elcorr_pix_faked_value    
      & elcorr_ref_cfg_0_ref_enabled         
      & elcorr_ref_cfg_0_null_forced         
      & elcorr_ref_cfg_0_start_dly_sampclk   
      & elcorr_ref_cfg_0_samp_num_per_ch     
      & elcorr_ref_cfg_0_samp_mean_numerator 
      & elcorr_ref_cfg_0_ref_value      
      & elcorr_ref_cfg_1_ref_enabled         
      & elcorr_ref_cfg_1_null_forced         
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
      & sat_ctrl_en          
      & elcorr_cont_calc_mode
      & roic_cst_output_mode
      & cfg_num
      & fpa_intf_data_source;  
      
      return y;
   end to_intf_cfg;
   
end package body suphawkA_intf_testbench_pkg;