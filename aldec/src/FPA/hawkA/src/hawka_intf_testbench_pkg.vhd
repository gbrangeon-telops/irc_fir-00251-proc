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
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned;
   
   
end hawkA_intf_testbench_pkg;

package body hawkA_intf_testbench_pkg is
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned is 
      variable comn_fpa_diag_mode               : unsigned(31 downto 0);
      variable comn_fpa_diag_type               : unsigned(31 downto 0);
      variable comn_fpa_pwr_on                  : unsigned(31 downto 0);
      variable comn_fpa_trig_ctrl_mode          : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_ctrl_dly       : unsigned(31 downto 0);
      variable comn_fpa_spare                   : unsigned(31 downto 0);
      variable comn_fpa_xtra_trig_ctrl_dly      : unsigned(31 downto 0);
      variable comn_fpa_trig_ctrl_timeout_dly   : unsigned(31 downto 0);                                     
      variable xstart                           : unsigned(31 downto 0);
      variable ystart                           : unsigned(31 downto 0);
      variable xsize                            : unsigned(31 downto 0);
      variable ysize                            : unsigned(31 downto 0);
      variable gain                             : unsigned(31 downto 0);
      variable invert                           : unsigned(31 downto 0);
      variable revert                           : unsigned(31 downto 0);
      variable cbit_en                          : unsigned(31 downto 0);
      variable dig_code                         : unsigned(31 downto 0);
      variable jpos                             : unsigned(31 downto 0);
      variable kpos                             : unsigned(31 downto 0);
      variable lpos                             : unsigned(31 downto 0);
      variable mpos                             : unsigned(31 downto 0);
      variable wdr_len                          : unsigned(31 downto 0);
      variable full_window                      : unsigned(31 downto 0);
      variable real_mode_active_pixel_dly       : unsigned(31 downto 0);           
      variable adc_quad2_en                     : unsigned(31 downto 0);
      variable chn_diversity_en                 : unsigned(31 downto 0);
      variable readout_pclk_cnt_max             : unsigned(31 downto 0);
      variable line_period_pclk                 : unsigned(31 downto 0);
      variable active_line_start_num            : unsigned(31 downto 0);
      variable active_line_end_num              : unsigned(31 downto 0);
      variable pix_samp_num_per_ch              : unsigned(31 downto 0);
      variable sof_posf_pclk                    : unsigned(31 downto 0);
      variable eof_posf_pclk                    : unsigned(31 downto 0);
      variable sol_posl_pclk                    : unsigned(31 downto 0);      
      variable eol_posl_pclk                    : unsigned(31 downto 0);
      variable eol_posl_pclk_p1                 : unsigned(31 downto 0);
      variable hgood_samp_sum_num               : unsigned(31 downto 0);
      variable hgood_samp_mean_numerator        : unsigned(31 downto 0);
      variable vgood_samp_sum_num               : unsigned(31 downto 0);
      variable vgood_samp_mean_numerator        : unsigned(31 downto 0);  
      variable good_samp_first_pos_per_ch       : unsigned(31 downto 0);
      variable good_samp_last_pos_per_ch        : unsigned(31 downto 0);
      variable xsize_div_tapnum                 : unsigned(31 downto 0); 
      variable adc_clk_source_phase             : unsigned(31 downto 0); 
      variable adc_clk_pipe_sel                 : unsigned(31 downto 0); 
      variable cfg_num                          : unsigned(31 downto 0); 
      variable comn_fpa_stretch_acq_trig        : unsigned(31 downto 0); 
      variable comn_fpa_intf_data_source        : unsigned(31 downto 0);
      variable cbit_pipe_dly                    : unsigned(31 downto 0);
      
      variable y                                : unsigned(49*32-1 downto 0);
      
   begin
      comn_fpa_diag_mode             :=  (others =>diag_mode);                                               
      comn_fpa_diag_type             :=  resize(unsigned(DEFINE_TELOPS_DIAG_DEGR),32);                 
      comn_fpa_pwr_on                :=  (others =>'1');                                               
      comn_fpa_trig_ctrl_mode        :=  resize(unsigned(MODE_INT_END_TO_TRIG_START),32);
      comn_fpa_acq_trig_ctrl_dly     :=  to_unsigned(862000, comn_fpa_acq_trig_ctrl_dly'length);
      if send_id = 2 then
         comn_fpa_acq_trig_ctrl_dly  :=  to_unsigned(15663, comn_fpa_acq_trig_ctrl_dly'length);   
      end if;
      comn_fpa_spare                 :=  to_unsigned(100, comn_fpa_spare'length);        
      comn_fpa_xtra_trig_ctrl_dly    :=  to_unsigned(862000, comn_fpa_xtra_trig_ctrl_dly'length);         
      comn_fpa_trig_ctrl_timeout_dly :=  to_unsigned(862000, comn_fpa_trig_ctrl_timeout_dly'length);  
      xstart                         := to_unsigned(0, 32);  
      ystart                         := to_unsigned(0, 32);  
      xsize                          := to_unsigned(user_xsize, 32);  
      ysize                          := to_unsigned(user_ysize, 32);  
      gain                           := (others => '0');
      invert                         := (others => '0');
      revert                         := (others => '0');
      cbit_en                        := (others => '0');
      dig_code                       := (others => '0');
      jpos                           := to_unsigned(1257, 32);  
      kpos                           := to_unsigned(1112, 32);  
      lpos                           := to_unsigned(737, 32);  
      mpos                           := to_unsigned(288, 32);  
      wdr_len                        := to_unsigned(1344, 32); 
      full_window                    := (others => '1');
      real_mode_active_pixel_dly     := to_unsigned(3, 32);
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
      comn_fpa_stretch_acq_trig      :=  (others => '0'); 
      
      adc_clk_source_phase           := to_unsigned(680, 32);
      adc_clk_pipe_sel               := to_unsigned(0, 32);
      
      cfg_num                        := to_unsigned(send_id, 32);
      comn_fpa_stretch_acq_trig      := to_unsigned(0, 32); 
      comn_fpa_intf_data_source      := to_unsigned(0, 32);
      
      cbit_pipe_dly                  := to_unsigned(3, 32);
      
      
      -- cfg usager
      y :=  comn_fpa_diag_mode 
      & comn_fpa_diag_type                
      & comn_fpa_pwr_on                   
      & comn_fpa_trig_ctrl_mode           
      & comn_fpa_acq_trig_ctrl_dly        
      & comn_fpa_spare                   
      & comn_fpa_xtra_trig_ctrl_dly       
      & comn_fpa_trig_ctrl_timeout_dly     
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
      & adc_clk_source_phase             
      & adc_clk_pipe_sel                 
      & cfg_num                          
      & comn_fpa_stretch_acq_trig        
      & comn_fpa_intf_data_source
      & cbit_pipe_dly;        
      
      return y;
   end to_intf_cfg;
   
end package body hawkA_intf_testbench_pkg;