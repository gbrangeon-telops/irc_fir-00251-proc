------------------------------------------------------------------
--!   @file suphawkA_intf_testbench_pkgpkg.vhd
--!   @brief Package file for TEL-2000 projects.
--!   @details This file contains the records and constants used in the project.
--!
--!   $Rev: 23893 $
--!   $Author: enofodjie $
--!   $Date: 2019-07-07 19:35:42 -0400 (dim., 07 juil. 2019) $
--!   $Id: suphawka_intf_testbench_pkg.vhd 23893 2019-07-07 23:35:42Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-03-12%20-%202.7.x.100%20Bugfix/aldec/src/FPA/suphawkA/src/suphawka_intf_testbench_pkg.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.MATH_REAL.all;
use work.fpa_common_pkg.all; 
use work.fpa_define.all;

package suphawkA_intf_testbench_pkg is           
   
   constant USER_CFG_VECTOR_SIZE       : natural := 106;  -- number of variables to write in the USER_CFG
   
   constant PAUSE_SIZE                 : integer := 3;
   constant TAP_NUM                    : integer := 8;
   constant FPA_RST_DLY_MCLK		   : integer := 165;
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
      variable comn_fpa_diag_mode                     : unsigned(31 downto 0);
      variable comn_fpa_diag_type                     : unsigned(31 downto 0);
      variable comn_fpa_pwr_on                        : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_mode                 : unsigned(31 downto 0);
      variable comn_fpa_acq_trig_ctrl_dly             : unsigned(31 downto 0);
      variable comn_fpa_xtra_trig_mode                : unsigned(31 downto 0);
      variable comn_fpa_xtra_trig_ctrl_dly            : unsigned(31 downto 0);
      variable comn_fpa_trig_ctrl_timeout_dly         : unsigned(31 downto 0);                            
      variable xstart                                 : unsigned(31 downto 0);
      variable ystart                                 : unsigned(31 downto 0);
      variable xsize                                  : unsigned(31 downto 0);
      variable ysize                                  : unsigned(31 downto 0);
      variable gain                                   : unsigned(31 downto 0);
      variable invert                                 : unsigned(31 downto 0);
      variable revert                                 : unsigned(31 downto 0);
      variable cbit_en                                : unsigned(31 downto 0);
      variable dig_code                               : unsigned(31 downto 0);
      variable colstart                               : unsigned(31 downto 0);
      variable colstop                                : unsigned(31 downto 0);
      variable rowstart                               : unsigned(31 downto 0);
      variable rowstop                                : unsigned(31 downto 0);
      variable active_subwindow                       : unsigned(31 downto 0);
      variable prv_dac_nominal_value                  : unsigned(31 downto 0);
      variable real_mode_active_pixel_dly             : unsigned(31 downto 0);           
      variable adc_quad2_en                           : unsigned(31 downto 0);
      variable chn_diversity_en                       : unsigned(31 downto 0);
      variable pix_samp_num_per_ch                    : unsigned(31 downto 0); 
      variable hgood_samp_sum_num                     : unsigned(31 downto 0);
      variable hgood_samp_mean_numerator              : unsigned(31 downto 0);
      variable vgood_samp_sum_num                     : unsigned(31 downto 0);
      variable vgood_samp_mean_numerator              : unsigned(31 downto 0);
      variable good_samp_first_pos_per_ch             : unsigned(31 downto 0);
      variable good_samp_last_pos_per_ch              : unsigned(31 downto 0);
      variable xsize_div_tapnum                       : unsigned(31 downto 0);     
      variable adc_clk_source_phase                   : unsigned(31 downto 0);
      variable adc_clk_pipe_sel                       : unsigned(31 downto 0);                 
      variable comn_fpa_stretch_acq_trig              : unsigned(31 downto 0);                 
      variable spare1                                 : unsigned(31 downto 0);                 
      variable spare2                                 : unsigned(31 downto 0);                 
      variable elcorr_enabled                         : unsigned(31 downto 0);                 
      variable elcorr_spare1                          : unsigned(31 downto 0);                 
      variable elcorr_spare2                          : unsigned(31 downto 0);                                           
      variable elcorr_ref_cfg_0_ref_enabled           : unsigned(31 downto 0);                                            
      variable elcorr_ref_cfg_0_ref_cont_meas_mode    : unsigned(31 downto 0);                  
      variable elcorr_ref_cfg_0_start_dly_sampclk     : unsigned(31 downto 0);                  
      variable elcorr_ref_cfg_0_samp_num_per_ch       : unsigned(31 downto 0);                  
      variable elcorr_ref_cfg_0_samp_mean_numerator   : unsigned(31 downto 0);                  
      variable elcorr_ref_cfg_0_ref_value             : unsigned(31 downto 0);                  
      variable elcorr_ref_cfg_1_ref_enabled           : unsigned(31 downto 0);                                            
      variable elcorr_ref_cfg_1_ref_cont_meas_mode    : unsigned(31 downto 0);                                            
      variable elcorr_ref_cfg_1_start_dly_sampclk     : unsigned(31 downto 0);                 
      variable elcorr_ref_cfg_1_samp_num_per_ch       : unsigned(31 downto 0);                 
      variable elcorr_ref_cfg_1_samp_mean_numerator   : unsigned(31 downto 0);                
      variable elcorr_ref_cfg_1_ref_value             : unsigned(31 downto 0);                
      variable elcorr_ref_dac_id                      : unsigned(31 downto 0);               
      variable elcorr_atemp_gain                      : unsigned(31 downto 0);               
      variable elcorr_atemp_ofs                       : unsigned(31 downto 0);                                          
      variable elcorr_ref0_op_sel                     : unsigned(31 downto 0);                                          
      variable elcorr_ref1_op_sel                     : unsigned(31 downto 0);                 
      variable elcorr_mult_op_sel                     : unsigned(31 downto 0);               
      variable elcorr_div_op_sel                      : unsigned(31 downto 0);               
      variable elcorr_add_op_sel                      : unsigned(31 downto 0);                      
      variable sat_ctrl_en                            : unsigned(31 downto 0);                      
      variable elcorr_spare3                          : unsigned(31 downto 0);                      
      variable roic_cst_output_mode                   : unsigned(31 downto 0);                      
      variable comn_fpa_intf_data_source              : unsigned(31 downto 0);  
      variable additional_fpa_int_time_offset         : unsigned(31 downto 0);
	  variable aoi_data_sol_pos 				      : unsigned(31 downto 0);
	  variable aoi_data_eol_pos 				      : unsigned(31 downto 0);
	  variable aoi_flag1_sol_pos 				      : unsigned(31 downto 0);
	  variable aoi_flag1_eol_pos 				      : unsigned(31 downto 0);
	  variable aoi_flag2_sol_pos 				      : unsigned(31 downto 0);
	  variable aoi_flag2_eol_pos 				      : unsigned(31 downto 0);
	  variable raw_area_line_start_num 			      : unsigned(31 downto 0);
	  variable raw_area_line_end_num 			      : unsigned(31 downto 0);
	  variable raw_area_sof_posf_pclk 			      : unsigned(31 downto 0);
	  variable raw_area_eof_posf_pclk 			      : unsigned(31 downto 0);
	  variable raw_area_sol_posl_pclk 			      : unsigned(31 downto 0);
	  variable raw_area_eol_posl_pclk 			      : unsigned(31 downto 0);
	  variable raw_area_lsync_start_posl_pclk	      : unsigned(31 downto 0);
	  variable raw_area_lsync_end_posl_pclk		      : unsigned(31 downto 0);
	  variable raw_area_lsync_num		 			  : unsigned(31 downto 0);
	  variable raw_area_clk_id			 			  : unsigned(31 downto 0);
	  variable raw_area_line_period_pclk			  : unsigned(31 downto 0);
	  variable raw_area_readout_pclk_cnt_max		  : unsigned(31 downto 0);
	  variable user_area_line_start_num				  : unsigned(31 downto 0);
	  variable user_area_line_end_num				  : unsigned(31 downto 0);
	  variable user_area_sol_posl_pclk				  : unsigned(31 downto 0);
	  variable user_area_eol_posl_pclk				  : unsigned(31 downto 0);
	  variable user_area_clk_id						  : unsigned(31 downto 0);
	  variable clk_area_a_line_start_num			  : unsigned(31 downto 0);
	  variable clk_area_a_line_end_num			 	  : unsigned(31 downto 0);
	  variable clk_area_a_sol_posl_pclk			 	  : unsigned(31 downto 0);
	  variable clk_area_a_eol_posl_pclk			 	  : unsigned(31 downto 0);
	  variable clk_area_a_clk_id				 	  : unsigned(31 downto 0);
	  variable clk_area_a_spare					 	  : unsigned(31 downto 0);
	  variable clk_area_b_line_start_num			  : unsigned(31 downto 0);
	  variable clk_area_b_line_end_num			 	  : unsigned(31 downto 0);
	  variable clk_area_b_sol_posl_pclk			 	  : unsigned(31 downto 0);
	  variable clk_area_b_eol_posl_pclk			 	  : unsigned(31 downto 0);
	  variable clk_area_b_clk_id				 	  : unsigned(31 downto 0);
	  variable clk_area_b_spare					 	  : unsigned(31 downto 0);
	  variable roic_rst_time_mclk				 	  : unsigned(31 downto 0);
	  variable sideband_cancel_en				 	  : unsigned(31 downto 0);
	  variable spare4							 	  : unsigned(31 downto 0);
      variable cfg_num                                : unsigned(31 downto 0);
      variable y                                      : unsigned(USER_CFG_VECTOR_SIZE*32-1 downto 0);
      
   begin
      comn_fpa_diag_mode                    := (others => diag_mode);                                               
      comn_fpa_diag_type                    := resize(unsigned(DEFINE_TELOPS_DIAG_DEGR),32);                 
      comn_fpa_pwr_on                       := to_unsigned(1, 32);                                               
      comn_fpa_acq_trig_mode                := resize(unsigned(MODE_INT_END_TO_TRIG_START),32);
      comn_fpa_xtra_trig_mode               := resize(unsigned(MODE_INT_END_TO_TRIG_START),32);
      
      xstart                                := to_unsigned(0, 32);  
      ystart                                := to_unsigned(0, 32);  
      xsize                                 := to_unsigned(user_xsize, 32);  
      ysize                                 := to_unsigned(user_ysize, 32);  
      gain                                  := (others => '0');
      invert                                := (others => '0');
      revert                                := (others => '0');
      cbit_en                               := to_unsigned(1, 32);
      dig_code                              := resize(x"00D3", 32);      
      colstart                              := xstart/TAP_NUM;  
      colstop                               := colstart + xsize/TAP_NUM - 1;  
      rowstart                              := ystart;  
      rowstop                               := rowstart + ysize - 1;
      
      active_subwindow                      := to_unsigned(0, 32); 
      prv_dac_nominal_value                 := to_unsigned(1234, 32);  
      real_mode_active_pixel_dly            := to_unsigned(5, 32);
      adc_quad2_en                          := to_unsigned(1, 32);  
      chn_diversity_en                      := to_unsigned(0, 32);
      
      pix_samp_num_per_ch                   := to_unsigned(1, 32);
      
      -- sampling
      good_samp_first_pos_per_ch            := to_unsigned(1, 32);
      good_samp_last_pos_per_ch             := to_unsigned(1, 32);   
      hgood_samp_sum_num                    := to_unsigned(1, 32); 
      hgood_samp_mean_numerator             := to_unsigned(2**21 / to_integer(hgood_samp_sum_num), 32);
      vgood_samp_sum_num                    := 1 + chn_diversity_en;
      vgood_samp_mean_numerator             := to_unsigned(2**21 / to_integer(vgood_samp_sum_num), 32);      
      xsize_div_tapnum                      := to_unsigned(user_xsize/TAP_NUM, 32);
      
      adc_clk_source_phase                  :=  to_unsigned(400, 32);
      adc_clk_pipe_sel                      :=  to_unsigned(3, 32);
      comn_fpa_stretch_acq_trig             :=  to_unsigned(0, 32);
      spare1                                :=  to_unsigned(0, 32);
      spare2                                :=  to_unsigned(0, 32);
      
      -- Electronic chain correction                    
      -- valeurs par defaut (mode normal)                                                                                                                                               
      elcorr_enabled                        := (others => C_ELCORR_ENABLED);
      if (diag_mode = '1') then 
         elcorr_enabled                     := (others => '0');
      end if; 
      
      elcorr_spare1                         := (others => '0');              
      elcorr_spare2                         := (others => '0');                     
      
      elcorr_ref_cfg_0_ref_enabled          := to_unsigned(1, 32);               
      elcorr_ref_cfg_0_ref_cont_meas_mode   := (others => '0');              
      elcorr_ref_cfg_0_start_dly_sampclk    := to_unsigned(2, 32);        
      elcorr_ref_cfg_0_samp_num_per_ch      := to_unsigned(4, 32);
      elcorr_ref_cfg_0_samp_mean_numerator  := to_unsigned(2**21/4, 32);     
      elcorr_ref_cfg_0_ref_value            := to_unsigned(2000, 32);  --      
      
      elcorr_ref_cfg_1_ref_enabled          := to_unsigned(1, 32);          
      elcorr_ref_cfg_1_ref_cont_meas_mode   := (others => '0');             
      elcorr_ref_cfg_1_start_dly_sampclk    := to_unsigned(2, 32);          
      elcorr_ref_cfg_1_samp_num_per_ch      := to_unsigned(4, 32);         
      elcorr_ref_cfg_1_samp_mean_numerator  := to_unsigned(2**21/4, 32);      
      elcorr_ref_cfg_1_ref_value            := to_unsigned(4000, 32);  --   
      
      elcorr_ref_dac_id                     := to_unsigned(5, 32);  --       
      elcorr_atemp_gain                     := to_unsigned(1, 32);          
      elcorr_atemp_ofs                      := to_unsigned(540, 32);
      
      elcorr_ref0_op_sel                    := resize(ELCORR_SW_TO_NORMAL_OP, 32);
      elcorr_ref1_op_sel                    := resize(ELCORR_SW_TO_NORMAL_OP, 32);
      elcorr_mult_op_sel                    := resize(ELCORR_SW_TO_PATH1, 32);
      elcorr_div_op_sel                     := resize(ELCORR_SW_TO_PATH1, 32); 
      elcorr_add_op_sel                     := resize(ELCORR_SW_TO_NORMAL_OP, 32);  
      
      -- sortie de la reference0
      if (C_elcorr_ref0_image_map_enabled = '1')  then              -- pour sortir l'image de la reference0
         elcorr_ref0_op_sel                 := resize(ELCORR_SW_TO_PATH2, 32);
         elcorr_ref1_op_sel                 := resize(ELCORR_SW_TO_PATH1, 32);  -- pas necessaire
         elcorr_mult_op_sel                 := resize(ELCORR_SW_TO_PATH1, 32);
         elcorr_div_op_sel                  := resize(ELCORR_SW_TO_PATH1, 32); 
         elcorr_add_op_sel                  := resize(ELCORR_SW_TO_PATH1, 32); 
      end if;
      
      -- sortie de la reference1
      if (C_elcorr_ref1_image_map_enabled = '1')  then              -- pour sortir l'image de la reference1
         elcorr_ref0_op_sel                 := resize(ELCORR_SW_TO_PATH1, 32); -- pas necessaire
         elcorr_ref1_op_sel                 := resize(ELCORR_SW_TO_PATH2, 32);  
         elcorr_mult_op_sel                 := resize(ELCORR_SW_TO_PATH1, 32);
         elcorr_div_op_sel                  := resize(ELCORR_SW_TO_PATH2, 32); 
         elcorr_add_op_sel                  := resize(ELCORR_SW_TO_PATH1, 32); 
      end if;
      
      -- desactivation de la correction electronique
      if (elcorr_enabled = 0)  then
         elcorr_ref0_op_sel                 := resize(ELCORR_SW_TO_PATH1, 32); 
         elcorr_ref1_op_sel                 := resize(ELCORR_SW_TO_PATH2, 32); -- pas necessaire 
         elcorr_mult_op_sel                 := resize(ELCORR_SW_TO_PATH1, 32);
         elcorr_div_op_sel                  := resize(ELCORR_SW_TO_PATH1, 32); 
         elcorr_add_op_sel                  := resize(ELCORR_SW_TO_PATH1, 32);   
      end if; 
      
      sat_ctrl_en                           := (others => '0');
      elcorr_spare3                         := (others => '0');
      roic_cst_output_mode                  := (others => '0');
           
      comn_fpa_intf_data_source             := (others => '0');
      additional_fpa_int_time_offset        := (others => '0');   
	  
	  -- cropping
  	  aoi_data_sol_pos         				:= (others => '0');
	  aoi_data_eol_pos         				:= (others => '0');
	  aoi_flag1_sol_pos        				:= (others => '0');
	  aoi_flag1_eol_pos        				:= (others => '0');
	  aoi_flag2_sol_pos        				:= (others => '0');
	  aoi_flag2_eol_pos        				:= (others => '0');

	  -- raw_area
	  raw_area_line_start_num        		:= to_unsigned(1, 32);      
      if user_ysize > 1 then 
        raw_area_line_end_num		        := raw_area_line_start_num + to_unsigned(user_ysize - 1, 32);
      end if;
      raw_area_line_period_pclk 		    := to_unsigned(user_xsize/TAP_NUM + PAUSE_SIZE, 32);	  
      raw_area_readout_pclk_cnt_max  		:= to_unsigned((user_xsize/TAP_NUM + PAUSE_SIZE)*(user_ysize) + FPA_RST_DLY_MCLK, 32);   
	  raw_area_sof_posf_pclk         		:= to_unsigned(PAUSE_SIZE + 1, 32);      
      if user_ysize > 1 then 
         raw_area_eof_posf_pclk  		    := to_unsigned(user_ysize * (user_xsize/TAP_NUM + PAUSE_SIZE), 32);
      end if;      
      raw_area_sol_posl_pclk         		:= to_unsigned(PAUSE_SIZE + 1, 32);
      raw_area_eol_posl_pclk         		:= raw_area_line_period_pclk;
	  raw_area_lsync_start_posl_pclk 		:= to_unsigned(1, 32);
	  raw_area_lsync_end_posl_pclk 		 	:= to_unsigned(1, 32);
	  raw_area_lsync_num 		 	 		:= raw_area_line_end_num;
	  raw_area_clk_id						:= to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32);

      -- user_area
      user_area_line_start_num        		:= raw_area_line_start_num;      
	  user_area_line_end_num          		:= raw_area_line_end_num;  
      user_area_sol_posl_pclk         		:= raw_area_sol_posl_pclk;
      user_area_eol_posl_pclk         		:= raw_area_eol_posl_pclk;
	  user_area_clk_id						:= to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32);
	  
      -- clk_area_a
	  clk_area_a_line_start_num		     	:= user_area_line_start_num; 
	  clk_area_a_line_end_num      			:= user_area_line_end_num;
	  clk_area_a_sol_posl_pclk 				:= to_unsigned(PAUSE_SIZE  + 1, 32);
	  clk_area_a_eol_posl_pclk      		:= to_unsigned(PAUSE_SIZE + 1, 32);
	  clk_area_a_clk_id					 	:= to_unsigned(DEFINE_FPA_SIDEBAND_MCLK_ID, 32);
	  clk_area_a_spare	     		 		:= (others => '0');

	  -- clk_area_b
	  clk_area_b_line_start_num	      		:= (others => '0');
	  clk_area_b_line_end_num				:= user_area_line_end_num;
	  clk_area_b_sol_posl_pclk 				:= to_unsigned(1, 32);
	  clk_area_b_eol_posl_pclk	        	:= to_unsigned(3, 32);
	  clk_area_b_clk_id						:= to_unsigned(DEFINE_FPA_LINEPAUSE_MCLK_ID, 32);
	  clk_area_b_spare						:= (others => '0');
	  
	  -- others
	  roic_rst_time_mclk				  	:= to_unsigned(FPA_RST_DLY_MCLK, 32);
	  
      sideband_cancel_en             		:= to_unsigned(1, 32);
	  --sideband_cancel_en             		:= to_unsigned(0, 32);
      if sideband_cancel_en = 0 then 
         clk_area_a_clk_id           		:= to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32);
         clk_area_b_clk_id           		:= to_unsigned(DEFINE_FPA_NOMINAL_MCLK_ID, 32);
      end if;

	  spare4								 := (others => '0');
	  
	  cfg_num                                := to_unsigned(send_id, cfg_num'length);
	  
	  
	  comn_fpa_acq_trig_ctrl_dly     	 :=  to_unsigned(to_integer(raw_area_readout_pclk_cnt_max)*DEFINE_FPA_100M_CLK_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ, comn_fpa_acq_trig_ctrl_dly'length);
	  comn_fpa_xtra_trig_ctrl_dly			 :=  to_unsigned(to_integer(raw_area_readout_pclk_cnt_max)*DEFINE_FPA_100M_CLK_RATE_KHZ/DEFINE_FPA_MCLK_RATE_KHZ, comn_fpa_xtra_trig_ctrl_dly'length);
	  comn_fpa_trig_ctrl_timeout_dly		 :=  to_unsigned(2*1*DEFINE_FPA_100M_CLK_RATE_KHZ*1000, comn_fpa_trig_ctrl_timeout_dly'length); --ENO: 11 juillet 2022: le delai de timeout est egale à 2 fois la durée du temps d'exposition max pour securiser le mode MODE_READOUT_END_TO_TRIG_START.
      
      
      -- cfg usager
      y :=  comn_fpa_diag_mode              
      & comn_fpa_diag_type                       
      & comn_fpa_pwr_on                          
      & comn_fpa_acq_trig_mode                  
      & comn_fpa_acq_trig_ctrl_dly               
      & comn_fpa_xtra_trig_mode                           
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
      & colstart                                 
      & colstop                                  
      & rowstart                                 
      & rowstop                                  
      & active_subwindow                         
      & prv_dac_nominal_value                    
      & real_mode_active_pixel_dly               
      & adc_quad2_en                             
      & chn_diversity_en
	  & pix_samp_num_per_ch                      
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
      & sat_ctrl_en                              
      & elcorr_spare3                            
      & roic_cst_output_mode                     
      & comn_fpa_intf_data_source                
      & additional_fpa_int_time_offset
	  & aoi_data_sol_pos
	  & aoi_data_eol_pos
	  & aoi_flag1_sol_pos
	  & aoi_flag1_eol_pos
	  & aoi_flag2_sol_pos
	  & aoi_flag2_eol_pos
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
	  & roic_rst_time_mclk
	  & sideband_cancel_en
	  & spare4
	  & cfg_num;
      
      return y;
   end to_intf_cfg;
   
end package body suphawkA_intf_testbench_pkg;
