------------------------------------------------------------------
--!   @file BB1920D_intf_testbench_pkgpkg.vhd
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

package BB1920D_intf_testbench_pkg is           
   
   constant PAUSE_SIZE                 : integer := 2*(1);
   constant TAP_NUM                    : integer := 8;
   constant C_FPA_INTCLK_RATE_KHZ      : integer := 35_000;
   
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned;
   
   
end BB1920D_intf_testbench_pkg;

package body BB1920D_intf_testbench_pkg is
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned is 
      
      variable  comn_fpa_diag_mode                                                : unsigned(31 downto  0);
      variable  comn_fpa_diag_type                                                : unsigned(31 downto  0);
      variable  comn_fpa_pwr_on                                                   : unsigned(31 downto  0);
      variable  comn_fpa_trig_ctrl_mode                                           : unsigned(31 downto  0);
      variable  comn_fpa_acq_trig_ctrl_dly                                        : unsigned(31 downto  0);
      variable  comn_fpa_spare                                                    : unsigned(31 downto  0);
      variable  comn_fpa_xtra_trig_ctrl_dly                                       : unsigned(31 downto  0);
      variable  comn_fpa_trig_ctrl_timeout_dly                                    : unsigned(31 downto  0);
      variable  comn_fpa_stretch_acq_trig                                         : unsigned(31 downto  0);
      variable  comn_clk100_to_intclk_conv_numerator                              : unsigned(31 downto  0);
      variable  comn_intclk_to_clk100_conv_numerator                              : unsigned(31 downto  0);
      variable  op_xstart                                                         : unsigned(31 downto  0);
      variable  op_ystart                                                         : unsigned(31 downto  0);                                           
      variable  op_xsize                                                          : unsigned(31 downto  0);
      variable  op_ysize                                                          : unsigned(31 downto  0);
      variable  op_frame_time                                                     : unsigned(31 downto  0);
      variable  op_gain                                                           : unsigned(31 downto  0);
      variable  op_int_mode                                                       : unsigned(31 downto  0);
      variable  op_test_mode	                                                    : unsigned(31 downto  0);
      variable  op_det_vbias                                                      : unsigned(31 downto  0);
      variable  op_det_ibias                                                      : unsigned(31 downto  0);
      variable  op_det_vsat                                                       : unsigned(31 downto  0);                           
      variable  op_binning                                                        : unsigned(31 downto  0);
      variable  op_output_chn                                                     : unsigned(31 downto  0);
      variable  op_spare1		                                                    : unsigned(31 downto  0);
      variable  op_spare2		                                                    : unsigned(31 downto  0);
      variable  op_spare3		                                                    : unsigned(31 downto  0);
      variable  op_spare4                                                         : unsigned(31 downto  0);
      variable  op_cfg_num                                                        : unsigned(31 downto  0);
      variable  diag_ysize                                                        : unsigned(31 downto  0);
      variable  diag_xsize_div_tapnum                                             : unsigned(31 downto  0);
      variable  diag_lovh_mclk_source                                             : unsigned(31 downto  0);
      variable  frame_dly_cst                                                     : unsigned(31 downto  0);
      variable  int_dly_cst                                                       : unsigned(31 downto  0);
      variable  additional_fpa_int_time_offset                                    : unsigned(31 downto  0); 
      variable  itr                                                               : unsigned(31 downto  0);
      variable  real_mode_active_pixel_dly                                        : unsigned(31 downto  0);
      variable  cmd_hder                                                          : unsigned(31 downto  0);
      variable  int_cmd_id                                                        : unsigned(31 downto  0);
      variable  int_cmd_dlen                                                      : unsigned(31 downto  0);
      variable  int_cmd_offs_add                                                  : unsigned(31 downto  0);
      variable  fpa_serdes_lval_num                                               : unsigned(31 downto  0);
      variable  fpa_serdes_lval_len                                               : unsigned(31 downto  0);
      variable  op_cmd_id                                                         : unsigned(31 downto  0);
      variable  temp_cmd_id                                                       : unsigned(31 downto  0);  
      variable  op_cmd_bram_base_add                                              : unsigned(31 downto  0);
      variable  int_cmd_bram_base_add                                             : unsigned(31 downto  0);
      variable  temp_cmd_bram_base_add                                            : unsigned(31 downto  0);
      variable  int_cmd_bram_base_add_m1                                          : unsigned(31 downto  0);
      variable  int_checksum_base_add                                             : unsigned(31 downto  0);
      variable  cmd_overhead_bytes_num                                            : unsigned(31 downto  0);
      variable  int_clk_period_factor                                             : unsigned(31 downto  0);
      
      variable y                                                                  : unsigned(52*32-1 downto 0);
      
   begin 
      
      
      comn_fpa_diag_mode            := (others => diag_mode);
      comn_fpa_diag_type            := resize(unsigned(DEFINE_TELOPS_DIAG_DEGR),32);
      comn_fpa_pwr_on               := (others =>'1');
      comn_fpa_trig_ctrl_mode       := resize(unsigned(MODE_READOUT_END_TO_TRIG_START),32);
      --      if (diag_mode = '1') then 
      --         comn_fpa_trig_ctrl_mode    := resize(unsigned(MODE_ITR_TRIG_START_TO_TRIG_START),32);
      --      end if;   
      
      comn_fpa_acq_trig_ctrl_dly    := to_unsigned(1000, comn_fpa_acq_trig_ctrl_dly'length);
      comn_fpa_xtra_trig_ctrl_dly   := to_unsigned(1000, comn_fpa_xtra_trig_ctrl_dly'length);
      comn_fpa_trig_ctrl_timeout_dly := to_unsigned(60000, comn_fpa_trig_ctrl_timeout_dly'length);        
      comn_fpa_stretch_acq_trig     := (others =>'0');      
      
      diag_ysize                    := to_unsigned(user_ysize/2, 32);                 
      diag_xsize_div_tapnum         := to_unsigned(user_xsize/4, 32);
      op_xstart                     := to_unsigned(0, 32);
      op_ystart                     := to_unsigned(0, 32);      
      
      real_mode_active_pixel_dly    := to_unsigned(8, 32);   
      
      op_xsize                      := to_unsigned(user_xsize, 32);  
      op_ysize                      := to_unsigned(user_ysize, 32);  
      op_frame_time                 := to_unsigned(10, 32);  
      op_gain                       := to_unsigned(1, 32);   
      op_int_mode                   := to_unsigned(0, 32);   
      op_test_mode	               := to_unsigned(0, 32);     
      op_det_vbias                  := to_unsigned(0, 32);    
      op_det_ibias                  := to_unsigned(0, 32);    
      op_det_vsat                   := to_unsigned(0, 32);    
      op_binning                    := to_unsigned(0, 32);    
      op_output_chn                 := to_unsigned(2, 32);    
      op_spare1		               := to_unsigned(0, 32);   
      op_spare2		               := to_unsigned(0, 32);   
      op_spare3		               := to_unsigned(0, 32);   
      op_spare4                     := to_unsigned(0, 32);  
      op_cfg_num                    := to_unsigned(send_id, 32);  
      
      
      diag_lovh_mclk_source         := to_unsigned(3, 32);    
      frame_dly_cst                 := to_unsigned(10, 32);  
      int_dly_cst                   := to_unsigned(10, 32);   
      additional_fpa_int_time_offset := to_unsigned(0, 32);   
      itr                           := to_unsigned(1, 32);   
      
      cmd_hder                      := x"000000" & x"AA";   
      int_cmd_id                    := x"0000" & x"8500";  
      int_cmd_dlen                  := to_unsigned(10, 32);  
      int_cmd_offs_add              := to_unsigned(0, 32);   
      fpa_serdes_lval_num           := to_unsigned(user_ysize, 32);  
      fpa_serdes_lval_len           := to_unsigned(user_ysize, 32);  
      op_cmd_id                     := to_unsigned(user_xsize/TAP_NUM, 32);  
      temp_cmd_id                   := to_unsigned(0, 32);  
      
      op_cmd_bram_base_add          := to_unsigned(0, 32); 
      int_cmd_bram_base_add         := to_unsigned(64, 32); 
      temp_cmd_bram_base_add        := to_unsigned(192, 32); 
      int_cmd_bram_base_add_m1      := to_unsigned(63, 32); 
      int_checksum_base_add         := int_cmd_dlen + 4; 
      cmd_overhead_bytes_num        := to_unsigned(7, 32);
      
      int_clk_period_factor         := to_unsigned(DEFINE_INT_CLK_SOURCE_RATE_KHZ/C_FPA_INTCLK_RATE_KHZ, 32);
      
      comn_clk100_to_intclk_conv_numerator  := to_unsigned(integer(real(C_FPA_INTCLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(DEFINE_FPA_100M_CLK_RATE_KHZ)), 32);
      comn_intclk_to_clk100_conv_numerator  := to_unsigned(integer(real(DEFINE_FPA_100M_CLK_RATE_KHZ)*real(2**26)/real(C_FPA_INTCLK_RATE_KHZ)), 32);  
      
      
      -- cfg usager
      y :=  comn_fpa_diag_mode              
      & comn_fpa_diag_type             
      & comn_fpa_pwr_on                
      & comn_fpa_trig_ctrl_mode        
      & comn_fpa_acq_trig_ctrl_dly     
      & comn_fpa_spare                 
      & comn_fpa_xtra_trig_ctrl_dly    
      & comn_fpa_trig_ctrl_timeout_dly 
      & comn_fpa_stretch_acq_trig
      & comn_clk100_to_intclk_conv_numerator
      & comn_intclk_to_clk100_conv_numerator      
      & op_xstart                      
      & op_ystart                      
      & op_xsize                       
      & op_ysize                       
      & op_frame_time                  
      & op_gain                        
      & op_int_mode                    
      & op_test_mode	                      
      & op_det_vbias                   
      & op_det_ibias                   
      & op_det_vsat                    
      & op_binning                     
      & op_output_chn                  
      & op_spare1		                 
      & op_spare2		                 
      & op_spare3		                 
      & op_spare4                      
      & op_cfg_num                     
      & diag_ysize                     
      & diag_xsize_div_tapnum          
      & diag_lovh_mclk_source          
      & frame_dly_cst                  
      & int_dly_cst                    
      & additional_fpa_int_time_offset 
      & itr                            
      & real_mode_active_pixel_dly     
      & cmd_hder                       
      & int_cmd_id                     
      & int_cmd_dlen                   
      & int_cmd_offs_add               
      & fpa_serdes_lval_num            
      & fpa_serdes_lval_len            
      & op_cmd_id                      
      & temp_cmd_id                    
      & op_cmd_bram_base_add
      & int_cmd_bram_base_add   
      & temp_cmd_bram_base_add  
      & int_cmd_bram_base_add_m1
      & int_checksum_base_add
      & cmd_overhead_bytes_num
      & int_clk_period_factor;    
      
      return y;
   end to_intf_cfg;
   
end package body BB1920D_intf_testbench_pkg;