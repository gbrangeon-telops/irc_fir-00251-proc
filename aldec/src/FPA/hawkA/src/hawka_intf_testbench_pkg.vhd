------------------------------------------------------------------
--!   @file hawkA_intf_testbench_pkgpkg.vhd
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

package hawkA_intf_testbench_pkg is           
   
   constant PAUSE_SIZE                 : integer := 8;
   constant TAP_NUM                    : integer := 4;
   constant C_ELEC_OFS_ENABLED         : std_logic := '0';
   constant C_ELEC_OFS_OFFSET_IMAGE_MAP: std_logic := '0';
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural) return unsigned;
   
   
end hawkA_intf_testbench_pkg;

package body hawkA_intf_testbench_pkg is
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural) return unsigned is 
      variable comn_fpa_diag_mode             : unsigned(31 downto 0);
      variable comn_fpa_diag_type             : unsigned(31 downto 0);
      variable comn_fpa_pwr_on                : unsigned(31 downto 0);
      variable comn_fpa_trig_ctrl_mode        : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_ctrl_dly     : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_period_min   : unsigned(31 downto 0);
      variable comn_fpa_xtra_trig_ctrl_dly    : unsigned(31 downto 0);
      variable comn_fpa_xtra_trig_period_min  : unsigned(31 downto 0);                                     
      variable xstart                         : unsigned(31 downto 0);
      variable ystart                         : unsigned(31 downto 0);
      variable xsize                          : unsigned(31 downto 0);
      variable ysize                          : unsigned(31 downto 0);
      variable gain                           : unsigned(31 downto 0);
      variable invert                         : unsigned(31 downto 0);
      variable revert                         : unsigned(31 downto 0);
      variable cbit_en                        : unsigned(31 downto 0);
      variable dig_code                       : unsigned(31 downto 0);
      variable jpos                           : unsigned(31 downto 0);
      variable kpos                           : unsigned(31 downto 0);
      variable lpos                           : unsigned(31 downto 0);
      variable mpos                           : unsigned(31 downto 0);
      variable wdr_len                        : unsigned(31 downto 0);
      variable full_window                    : unsigned(31 downto 0);
      variable real_mode_active_pixel_dly     : unsigned(31 downto 0);
      variable adc_quad2_en                   : unsigned(31 downto 0);
      variable chn_diversity_en               : unsigned(31 downto 0);           
      variable line_period_pclk               : unsigned(31 downto 0);
      variable readout_pclk_cnt_max           : unsigned(31 downto 0);
      variable active_line_start_num          : unsigned(31 downto 0);
      variable active_line_end_num            : unsigned(31 downto 0);
      variable pix_samp_num_per_ch            : unsigned(31 downto 0);
      variable sof_posf_pclk                  : unsigned(31 downto 0);
      variable eof_posf_pclk                  : unsigned(31 downto 0);
      variable sol_posl_pclk                  : unsigned(31 downto 0);
      variable eol_posl_pclk                  : unsigned(31 downto 0);
      variable eol_posl_pclk_p1               : unsigned(31 downto 0);      
      variable good_samp_first_pos_per_ch     : unsigned(31 downto 0);
      variable good_samp_last_pos_per_ch      : unsigned(31 downto 0);
      variable hgood_samp_sum_num             : unsigned(31 downto 0);
      variable hgood_samp_mean_numerator      : unsigned(31 downto 0);
      variable vgood_samp_sum_num             : unsigned(31 downto 0);
      variable vgood_samp_mean_numerator      : unsigned(31 downto 0);  
      variable xsize_div_tapnum               : unsigned(31 downto 0);
      variable vdac_value_1                   : unsigned(31 downto 0);
      variable vdac_value_2                   : unsigned(31 downto 0); 
      variable vdac_value_3                   : unsigned(31 downto 0); 
      variable vdac_value_4                   : unsigned(31 downto 0); 
      variable vdac_value_5                   : unsigned(31 downto 0); 
      variable vdac_value_6                   : unsigned(31 downto 0); 
      variable vdac_value_7                   : unsigned(31 downto 0); 
      variable vdac_value_8                   : unsigned(31 downto 0); 
      variable adc_clk_phase                  : unsigned(31 downto 0);
      variable comn_fpa_stretch_acq_trig      : unsigned(31 downto 0);
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
      
      variable y                               : unsigned(63*32-1 downto 0);
      
   begin
      comn_fpa_diag_mode             :=  (others =>'1');                                               
      comn_fpa_diag_type             :=  resize(unsigned(DEFINE_TELOPS_DIAG_DEGR),32);                 
      comn_fpa_pwr_on                :=  (others =>'1');                                               
      comn_fpa_trig_ctrl_mode        :=  resize(unsigned(MODE_INT_END_TO_TRIG_START),32);          
      comn_fpa_acq_trig_ctrl_dly     :=  to_unsigned(862000, comn_fpa_acq_trig_ctrl_dly'length);            
      comn_fpa_acq_trig_period_min   :=  to_unsigned(100, comn_fpa_acq_trig_period_min'length);        
      comn_fpa_xtra_trig_ctrl_dly    :=  to_unsigned(862000, comn_fpa_xtra_trig_ctrl_dly'length);         
      comn_fpa_xtra_trig_period_min  :=  to_unsigned(100, comn_fpa_xtra_trig_period_min'length);       
      
      
      xstart                         := to_unsigned(0, 32);  
      ystart                         := to_unsigned(0, 32);  
      xsize                          := to_unsigned(user_xsize, 32);  
      ysize                          := to_unsigned(user_ysize, 32);  
      gain                           := (others => '0');
      invert                         := (others => '0');
      revert                         := (others => '0');
      cbit_en                        := (others => '0');
      dig_code                       := (others => '0');
      jpos                           := to_unsigned(user_xsize/2, 32);  
      kpos                           := to_unsigned(user_ysize/2, 32);  
      lpos                           := to_unsigned(513, 32);  
      mpos                           := to_unsigned(512, 32);  
      wdr_len                        := to_unsigned(1344, 32); 
      full_window                    := (others => '0');
      real_mode_active_pixel_dly     := to_unsigned(6, 32);
      adc_quad2_en                   := (others => '0');
      chn_diversity_en               := (others => '0'); 
      
      line_period_pclk               := to_unsigned(user_xsize/TAP_NUM + PAUSE_SIZE, 32);
      readout_pclk_cnt_max           := to_unsigned((user_xsize/TAP_NUM + PAUSE_SIZE)*(user_ysize + 1) + 3, 32);   
      active_line_start_num          := to_unsigned(1, 32);
      
      if user_ysize > 1 then 
         active_line_end_num            := active_line_start_num + to_unsigned(user_ysize - 1, 32);
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
      
      xsize_div_tapnum               :=  to_unsigned(user_xsize/TAP_NUM, 32);
      vdac_value_1                   :=  (others => '0'); 
      vdac_value_2                   :=  (others => '0'); 
      vdac_value_3                   :=  (others => '0'); 
      vdac_value_4                   :=  (others => '0'); 
      vdac_value_5                   :=  (others => '0'); 
      vdac_value_6                   :=  (others => '0'); 
      vdac_value_7                   :=  (others => '0'); 
      vdac_value_8                   :=  (others => '0'); 
      adc_clk_phase                  :=  (others => '0'); 
      comn_fpa_stretch_acq_trig      :=  (others => '0'); 
      
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
      
      & xstart                              
      & ystart                              
      & xsize                               
      & ysize                               
      & gain                                
      & invert                              
      & revert                              
      & cbit_en                             
      & dig_code                            
      & jpos                                
      & kpos                                
      & lpos                                
      & mpos                                
      & wdr_len                             
      & full_window                         
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
      & vdac_value_1                       
      & vdac_value_2
      & vdac_value_3 
      & vdac_value_4                       
      & vdac_value_5                       
      & vdac_value_6                       
      & vdac_value_7                       
      & vdac_value_8                        
      & adc_clk_phase                       
      & comn_fpa_stretch_acq_trig
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
   
end package body hawkA_intf_testbench_pkg;