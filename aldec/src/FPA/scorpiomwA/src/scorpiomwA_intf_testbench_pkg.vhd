------------------------------------------------------------------
--!   @file scorpiomwA_intf_testbench_pkgpkg.vhd
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

package scorpiomwA_intf_testbench_pkg is           
   
   constant PAUSE_SIZE                 : integer := 0;
   constant TAP_NUM                    : integer := 4;  
   
   -- Electrical correction : embedded switches control
   constant ELCORR_SW_TO_PATH1             : unsigned(1 downto 0) :=   "01";
   constant ELCORR_SW_TO_PATH2             : unsigned(1 downto 0) :=   "10";
   constant ELCORR_SW_TO_NORMAL_OP         : unsigned(1 downto 0) :=   "11";
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned;
   
   
end scorpiomwA_intf_testbench_pkg;

package body scorpiomwA_intf_testbench_pkg is
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned is 
      
      variable comn_fpa_diag_mode                                  : unsigned(31 downto 0);
      variable comn_fpa_diag_type                                  : unsigned(31 downto 0);
      variable comn_fpa_pwr_on                                     : unsigned(31 downto 0);
      variable comn_fpa_init_cfg                                   : unsigned(31 downto 0);
      variable comn_fpa_init_cfg_received                          : unsigned(31 downto 0);
      variable comn_fpa_trig_ctrl_mode                             : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_ctrl_dly                          : unsigned(31 downto 0);
      variable comn_fpa_spare                                      : unsigned(31 downto 0);                            
      variable comn_fpa_xtra_trig_ctrl_dly                         : unsigned(31 downto 0);
      variable comn_fpa_trig_ctrl_timeout_dly                      : unsigned(31 downto 0);
      variable xstart                                              : unsigned(31 downto 0);
      variable ystart                                              : unsigned(31 downto 0);
      variable xsize                                               : unsigned(31 downto 0);
      variable ysize                                               : unsigned(31 downto 0);
      variable windcfg_part1                                       : unsigned(31 downto 0);
      variable windcfg_part2                                       : unsigned(31 downto 0);
      variable windcfg_part3                                       : unsigned(31 downto 0);
      variable windcfg_part4                                       : unsigned(31 downto 0);
      variable uprow_upcol                                         : unsigned(31 downto 0);
      variable sizea_sizeb                                         : unsigned(31 downto 0);
      variable itr                                                 : unsigned(31 downto 0);
      variable gain                                                : unsigned(31 downto 0);           
      variable gpol_code                                           : unsigned(31 downto 0);
      variable real_mode_active_pixel_dly                          : unsigned(31 downto 0);
      variable adc_quad2_en                                        : unsigned(31 downto 0); 
      variable chn_diversity_en                                    : unsigned(31 downto 0);
      variable line_period_pclk                                    : unsigned(31 downto 0);
      variable readout_pclk_cnt_max                                : unsigned(31 downto 0);
      variable active_line_start_num                               : unsigned(31 downto 0);
      variable active_line_end_num                                 : unsigned(31 downto 0);
      variable pix_samp_num_per_ch                                 : unsigned(31 downto 0);
      variable sof_posf_pclk                                       : unsigned(31 downto 0);     
      variable eof_posf_pclk                                       : unsigned(31 downto 0);
      variable sol_posl_pclk                                       : unsigned(31 downto 0);                 
      variable eol_posl_pclk                                       : unsigned(31 downto 0);                 
      variable eol_posl_pclk_p1                                    : unsigned(31 downto 0);                 
      variable hgood_samp_sum_num                                  : unsigned(31 downto 0);                 
      variable hgood_samp_mean_numerator                           : unsigned(31 downto 0);                 
      variable vgood_samp_sum_num                                  : unsigned(31 downto 0);                 
      variable vgood_samp_mean_numerator                           : unsigned(31 downto 0);                                           
      variable good_samp_first_pos_per_ch                          : unsigned(31 downto 0);                                            
      variable good_samp_last_pos_per_ch                           : unsigned(31 downto 0);                  
      variable xsize_div_tapnum                                    : unsigned(31 downto 0);                                  
      variable adc_clk_source_phase                                : unsigned(31 downto 0);                  
      variable adc_clk_pipe_sel                                    : unsigned(31 downto 0);                  
      variable cfg_num                                             : unsigned(31 downto 0);                                            
      variable comn_fpa_stretch_acq_trig                           : unsigned(31 downto 0) := (others => '0');                                            
      variable reorder_column                                      : unsigned(31 downto 0);                 
      variable comn_fpa_intf_data_source                           : unsigned(31 downto 0) := (others => '0'); 
      variable additional_fpa_int_time_offset                      : unsigned(31 downto 0) := (others => '0');
      
      variable y                                                   : unsigned(50*32-1 downto 0);
      
   begin
      comn_fpa_diag_mode               :=  (others => diag_mode);                                               
      comn_fpa_diag_type               :=  resize(unsigned(DEFINE_TELOPS_DIAG_DEGR),32);                 
      comn_fpa_pwr_on                  :=  (others =>'1');                                               
      comn_fpa_trig_ctrl_mode          :=  resize(unsigned(MODE_TRIG_START_TO_TRIG_START),32);
      comn_fpa_acq_trig_ctrl_dly       :=  to_unsigned(480000, comn_fpa_acq_trig_ctrl_dly'length);            
      comn_fpa_trig_ctrl_timeout_dly   :=  to_unsigned(800000, comn_fpa_trig_ctrl_timeout_dly'length);        
      comn_fpa_xtra_trig_ctrl_dly      :=  to_unsigned(480000, comn_fpa_xtra_trig_ctrl_dly'length);
      
      itr                              := (others => '1');      
      if send_id = 3 then 
         itr := (others => '0');   
      end if;
      
      if diag_mode = '1' or itr(0) = '1' then
         comn_fpa_trig_ctrl_mode       :=  resize(unsigned(MODE_READOUT_END_TO_TRIG_START),32);
         comn_fpa_acq_trig_ctrl_dly    :=  to_unsigned(0, comn_fpa_acq_trig_ctrl_dly'length); 
      end if;
      
      xstart                           := to_unsigned(0, 32);  
      ystart                           := to_unsigned(0, 32);  
      xsize                            := to_unsigned(user_xsize, 32);  
      ysize                            := to_unsigned(user_ysize, 32);  
      gain                             := (others => '0');
      
      windcfg_part1                    := to_unsigned(1, windcfg_part1'length);
      windcfg_part2                    := to_unsigned(2, windcfg_part2'length);
      windcfg_part3                    := to_unsigned(3, windcfg_part3'length);
      windcfg_part4                    := to_unsigned(4, windcfg_part4'length);
      
      uprow_upcol                      := (others => '0');
      sizea_sizeb                      := (others => '0');
      
      gain                             := (others => '0');
      
      gpol_code                        := to_unsigned(2, gpol_code'length);
      
      
      real_mode_active_pixel_dly       := to_unsigned(0, real_mode_active_pixel_dly'length);
      adc_quad2_en                     := (others => '0');
      chn_diversity_en                 := (others => '0'); 
      
      line_period_pclk                 := to_unsigned((user_xsize/4 + PAUSE_SIZE), line_period_pclk'length);
      readout_pclk_cnt_max             := to_unsigned((user_xsize/4 + PAUSE_SIZE)*(user_ysize) + 1, readout_pclk_cnt_max'length);
      
      active_line_start_num            := to_unsigned(1, active_line_start_num'length); 
      active_line_end_num              := to_unsigned(user_ysize + to_integer(active_line_start_num) - 1, active_line_end_num'length);
      
      pix_samp_num_per_ch              := to_unsigned(1, pix_samp_num_per_ch'length);
      
      sof_posf_pclk                    := resize(line_period_pclk*(to_integer(active_line_start_num) - 1) + 1, sof_posf_pclk'length);
      eof_posf_pclk                    := resize(active_line_end_num* line_period_pclk - PAUSE_SIZE*2, eof_posf_pclk'length);
      sol_posl_pclk                    := to_unsigned(1, sol_posl_pclk'length);
      eol_posl_pclk                    := to_unsigned((user_xsize/4), eol_posl_pclk'length);
      eol_posl_pclk_p1                 := eol_posl_pclk + 1;    
      
      -- sampling
      hgood_samp_sum_num          		:= to_unsigned(1, hgood_samp_sum_num'length); 
      hgood_samp_mean_numerator   		:= to_unsigned(2**21, hgood_samp_mean_numerator'length); 
      vgood_samp_sum_num          		:= to_unsigned(1, vgood_samp_sum_num'length); 
      vgood_samp_mean_numerator   		:= to_unsigned(2**21, vgood_samp_mean_numerator'length); 
      good_samp_first_pos_per_ch  		:= to_unsigned(1, good_samp_first_pos_per_ch'length); 
      good_samp_last_pos_per_ch   		:= to_unsigned(1, good_samp_last_pos_per_ch'length); 
      xsize_div_tapnum            		:= to_unsigned(user_xsize/4, xsize_div_tapnum'length); 
      
      adc_clk_source_phase             :=  to_unsigned(70, 32);
      adc_clk_pipe_sel                 :=  to_unsigned(3, 32);
      comn_fpa_stretch_acq_trig        :=  to_unsigned(0, 32);
      
      
      
      cfg_num  := to_unsigned(send_id, cfg_num'length);
      
      -- comn_fpa_xtra_trig_period_min  :=  to_unsigned(10*to_integer(raw_area_readout_pclk_cnt_max), comn_fpa_xtra_trig_period_min'length);       
      
      
      
      -- cfg usager
      y := comn_fpa_diag_mode              
      & comn_fpa_diag_type              
      & comn_fpa_pwr_on                 
      & comn_fpa_init_cfg               
      & comn_fpa_init_cfg_received      
      & comn_fpa_trig_ctrl_mode         
      & comn_fpa_acq_trig_ctrl_dly      
      & comn_fpa_spare                  
      & comn_fpa_xtra_trig_ctrl_dly     
      & comn_fpa_trig_ctrl_timeout_dly  
      & xstart                          
      & ystart                          
      & xsize                           
      & ysize                           
      & windcfg_part1                   
      & windcfg_part2                   
      & windcfg_part3                   
      & windcfg_part4                   
      & uprow_upcol                     
      & sizea_sizeb                     
      & itr                             
      & gain                            
      & gpol_code                       
      & real_mode_active_pixel_dly      
      & adc_quad2_en                    
      & chn_diversity_en                
      & line_period_pclk                
      & readout_pclk_cnt_max            
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
      & cfg_num                         
      & comn_fpa_stretch_acq_trig       
      & reorder_column                  
      & comn_fpa_intf_data_source
      & additional_fpa_int_time_offset;
      
      return y;
   end to_intf_cfg;
   
end package body scorpiomwA_intf_testbench_pkg;






































