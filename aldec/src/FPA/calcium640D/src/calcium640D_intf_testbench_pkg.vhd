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
   
   constant PAUSE_SIZE                     : integer := 2*(1);
   constant TAP_NUM                        : integer := 8;
   constant C_FPA_INTCLK_RATE_KHZ          : integer := 35_000;
   constant QWORDS_NUM                     : natural := 76;
   
   constant AW_SERIAL_OP_CMD_RAM_ADD       : integer :=  0;  
   constant AW_SERIAL_ROIC_REG_CMD_RAM_ADD : integer :=  32; 
   constant AW_SERIAL_INT_CMD_RAM_ADD      : integer :=  64;
   constant AW_SERIAL_TEMP_CMD_RAM_ADD     : integer :=  96;
                                                   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned;
   
   
end calcium640D_intf_testbench_pkg;

package body calcium640D_intf_testbench_pkg is
   
   function to_intf_cfg(diag_mode:std_logic; user_xsize:natural; user_ysize:natural; send_id:natural) return unsigned is 
      
      constant FPA_WIDTH_MAX : integer := 1920;
      constant FPA_MCLK_RATE_MHZ : real := real(DEFINE_FPA_MCLK_SOURCE_RATE_KHZ)/1000.0;
      
      variable  comn_fpa_diag_mode                     : unsigned(31 downto 0);
      variable  comn_fpa_diag_type                     : unsigned(31 downto 0);
      variable  comn_fpa_pwr_on                        : unsigned(31 downto 0);
      variable  comn_fpa_acq_trig_mode                 : unsigned(31 downto 0);
      variable  comn_fpa_acq_trig_ctrl_dly             : unsigned(31 downto 0);
      variable  comn_fpa_xtra_trig_mode                : unsigned(31 downto 0);
      variable  comn_fpa_xtra_trig_ctrl_dly            : unsigned(31 downto 0);
      variable  comn_fpa_trig_ctrl_timeout_dly         : unsigned(31 downto 0);
      variable  comn_fpa_stretch_acq_trig              : unsigned(31 downto 0);
      variable  comn_clk100_to_intclk_conv_numerator   : unsigned(31 downto 0);
      variable  comn_intclk_to_clk100_conv_numerator   : unsigned(31 downto 0);
      variable  comn_fpa_intf_data_source              : unsigned(31 downto 0);
      variable  diag_ysize                             : unsigned(31 downto 0);
      variable  diag_xsize_div_tapnum                  : unsigned(31 downto 0);                                           
      variable  diag_lovh_mclk_source                  : unsigned(31 downto 0);
      variable  real_mode_active_pixel_dly             : unsigned(31 downto 0);
      variable  spare                                  : unsigned(31 downto 0);
      variable  aoi_xsize                              : unsigned(31 downto 0);
      variable  aoi_ysize                              : unsigned(31 downto 0);
      variable  aoi_data_sol_pos                       : unsigned(31 downto 0);
      variable  aoi_data_eol_pos                       : unsigned(31 downto 0);
      variable  aoi_flag1_sol_pos                      : unsigned(31 downto 0);
      variable  aoi_flag1_eol_pos                      : unsigned(31 downto 0);                           
      variable  aoi_flag2_sol_pos                      : unsigned(31 downto 0);
      variable  aoi_flag2_eol_pos                      : unsigned(31 downto 0);
      variable  op_xstart                              : unsigned(31 downto 0);
      variable  op_ystart                              : unsigned(31 downto 0);
      variable  op_xsize                               : unsigned(31 downto 0);
      variable  op_ysize                               : unsigned(31 downto 0);
      variable  op_frame_time                          : unsigned(31 downto 0);
      variable  op_gain                                : unsigned(31 downto 0);
      variable  op_int_mode                            : unsigned(31 downto 0);
      variable  op_test_mode                           : unsigned(31 downto 0);
      variable  op_det_vbias                           : unsigned(31 downto 0);
      variable  op_det_ibias                           : unsigned(31 downto 0);
      variable  op_binning                             : unsigned(31 downto 0); 
      variable  op_output_rate                         : unsigned(31 downto 0);
      variable  op_mtx_int_low                            : unsigned(31 downto 0); 
      variable  op_frm_res                                : unsigned(31 downto 0); 
      variable  op_frm_dat                                : unsigned(31 downto 0); 
      variable  op_cfg_num                             : unsigned(31 downto 0);
      variable  roic_reg_cmd_id                        : unsigned(31 downto 0);
      variable  roic_reg_cmd_data_size                 : unsigned(31 downto 0);
      variable  roic_reg_cmd_dlen                      : unsigned(31 downto 0);
      variable  roic_reg_cmd_sof_add                   : unsigned(31 downto 0);
      variable  roic_reg_cmd_eof_add                   : unsigned(31 downto 0);
      variable  int_cmd_id                             : unsigned(31 downto 0);  
      variable  int_cmd_data_size                      : unsigned(31 downto 0);
      variable  int_cmd_dlen                           : unsigned(31 downto 0);
      variable  int_cmd_offs                           : unsigned(31 downto 0);
      variable  int_cmd_sof_add                        : unsigned(31 downto 0);
      variable  int_cmd_eof_add                        : unsigned(31 downto 0);
      variable  int_cmd_sof_add_m1                     : unsigned(31 downto 0);
      variable  int_checksum_add                       : unsigned(31 downto 0);
      variable  frame_dly_cst                          : unsigned(31 downto 0);
      variable  int_dly_cst                            : unsigned(31 downto 0);
      variable  op_cmd_id                              : unsigned(31 downto 0);
      variable  op_cmd_data_size                       : unsigned(31 downto 0);
      variable  op_cmd_dlen                            : unsigned(31 downto 0);
      variable  op_cmd_sof_add                         : unsigned(31 downto 0);
      variable  op_cmd_eof_add                         : unsigned(31 downto 0);
      variable  temp_cmd_id                            : unsigned(31 downto 0);
      variable  temp_cmd_data_size                     : unsigned(31 downto 0);
      variable  temp_cmd_dlen                          : unsigned(31 downto 0);
      variable  temp_cmd_sof_add                       : unsigned(31 downto 0);
      variable  temp_cmd_eof_add                       : unsigned(31 downto 0);
      variable  outgoing_com_hder                      : unsigned(31 downto 0);
      variable  outgoing_com_ovh_len                   : unsigned(31 downto 0);
      variable  incoming_com_hder                      : unsigned(31 downto 0);
      variable  incoming_com_fail_id                   : unsigned(31 downto 0);
      variable  incoming_com_ovh_len                   : unsigned(31 downto 0);
      variable  fpa_serdes_lval_num                    : unsigned(31 downto 0);
      variable  fpa_serdes_lval_len                    : unsigned(31 downto 0);
      variable  int_clk_period_factor                  : unsigned(31 downto 0);
      variable  int_time_offset                        : unsigned(31 downto 0);
      variable  vid_if_bit_en                          : unsigned(31 downto 0);
      
      
      variable y                                       : unsigned(QWORDS_NUM*32-1 downto 0);
      
      -- working variables
      variable number_of_conversions : real;
      variable Line_Readout : real;
      variable Line_Conversion : real;
      variable Frame_Read : real;
      variable Frame_Initialization : real;
      variable pixel_control_time : real;
      variable Frame_Time : real;
      
      
   begin
      
      number_of_conversions := real(user_ysize) / 2.0 +  2.0;
      Line_Readout := (2.0 * real(FPA_WIDTH_MAX) + 18.0) / 2.0 / 4.0 / FPA_MCLK_RATE_MHZ; -- in us
      Line_Conversion :=  (55.0 + 50.0 + 40.0 + 255.0 + 70.0 + 30.0 + 190.0) / FPA_MCLK_RATE_MHZ; -- in us
      if Line_Readout > Line_Conversion then
         Frame_Read :=  number_of_conversions * Line_Readout; -- in us
      else
         Frame_Read :=  number_of_conversions * Line_Conversion; -- in us
      end if;
      
      Frame_Initialization := 28.0 + 14.0 + (10.0/FPA_MCLK_RATE_MHZ); -- in us
      pixel_control_time := (2.0 * 140.0) + 14.0 + 10.0; -- in us
      
      Frame_Time := ((pixel_control_time + Frame_Initialization + Frame_Read)/1_000_000.0) * 1.105; -- en seconde
      
      
      comn_fpa_diag_mode            := (others => diag_mode);
      comn_fpa_diag_type            := resize(unsigned(DEFINE_TELOPS_DIAG_DEGR),32);
      comn_fpa_pwr_on               := (others =>'1');
      comn_fpa_acq_trig_mode        := resize(unsigned(MODE_TRIG_START_TO_TRIG_START),32);
      comn_fpa_xtra_trig_mode       := resize(unsigned(MODE_TRIG_START_TO_TRIG_START),32);
      --      if (diag_mode = '1') then 
      --         comn_fpa_acq_trig_mode    := resize(unsigned(MODE_ITR_TRIG_START_TO_TRIG_START),32);
      --      end if;   
      
      comn_fpa_acq_trig_ctrl_dly    := to_unsigned(integer(Frame_Time * real(DEFINE_FPA_100M_CLK_RATE_KHZ)*1000.0), comn_fpa_acq_trig_ctrl_dly'length);
      comn_fpa_xtra_trig_ctrl_dly   := to_unsigned(integer(Frame_Time * real(DEFINE_FPA_100M_CLK_RATE_KHZ)*1000.0), comn_fpa_xtra_trig_ctrl_dly'length);
      comn_fpa_trig_ctrl_timeout_dly:= resize(comn_fpa_xtra_trig_ctrl_dly, comn_fpa_trig_ctrl_timeout_dly'length);        
      comn_fpa_stretch_acq_trig     := (others =>'0');      
      
      diag_ysize                    := to_unsigned(user_ysize/2, 32);                 
      diag_xsize_div_tapnum         := to_unsigned(FPA_WIDTH_MAX/4, 32);
      diag_lovh_mclk_source         := to_unsigned(0, 32);
      real_mode_active_pixel_dly    := to_unsigned(8, 32);
      
      aoi_xsize                     := to_unsigned(user_xsize, 32);
      aoi_ysize                     := to_unsigned(user_ysize, 32);
      aoi_data_sol_pos              := to_unsigned(((FPA_WIDTH_MAX - user_xsize)/2)/4 + 1, 32); -- /2 a cause du centrage
      aoi_data_eol_pos              := to_unsigned(((FPA_WIDTH_MAX - user_xsize)/2)/4 + user_xsize/4 , 32);
      aoi_flag1_sol_pos             := to_unsigned(1, 32);
      if user_xsize > 4 then 
         aoi_flag1_eol_pos             := to_unsigned(user_xsize/4 - 1, 32);
      end if;
      aoi_flag2_sol_pos             := to_unsigned(FPA_WIDTH_MAX/4, 32); -- on va chercher le dernier flag (eol/eof)
      aoi_flag2_eol_pos             := to_unsigned(FPA_WIDTH_MAX/4, 32); -- on va chercher le dernier flag (eol/eof)
      
      op_xstart                     := to_unsigned(0, 32);
      op_ystart                     := to_unsigned(0, 32); 
      op_xsize                      := to_unsigned(FPA_WIDTH_MAX, 32);  
      op_ysize                      := to_unsigned(user_ysize, 32);  
      op_frame_time                 := to_unsigned(10, 32);  
      op_gain                       := to_unsigned(1, 32);   
      op_int_mode                   := to_unsigned(0, 32);  --ITR=0, IWR=1   
      op_test_mode	               := to_unsigned(0, 32);     
      op_det_vbias                  := to_unsigned(0, 32);    
      op_det_ibias                  := to_unsigned(0, 32);       
      op_binning                    := to_unsigned(0, 32);    
      op_output_rate                := to_unsigned(3, 32);
      op_mtx_int_low               := to_unsigned(9, 32);
      op_frm_res                    := to_unsigned(7, 32);
      op_frm_dat                    := to_unsigned(0, 32);
      op_cfg_num                    := to_unsigned(send_id, 32);
      

      roic_reg_cmd_id               := resize(x"8501", 32);
      roic_reg_cmd_data_size        := to_unsigned(1, 32);
      roic_reg_cmd_dlen             := roic_reg_cmd_data_size + 1;
      roic_reg_cmd_sof_add          := to_unsigned(AW_SERIAL_ROIC_REG_CMD_RAM_ADD, 32);
      roic_reg_cmd_eof_add          := to_unsigned(AW_SERIAL_ROIC_REG_CMD_RAM_ADD + 7, 32);   
      
      int_cmd_id                    := resize(x"8500", 32);
      int_cmd_data_size             := to_unsigned(9, 32);
      int_cmd_dlen                  := int_cmd_data_size + 1; 
      int_cmd_offs                  := to_unsigned(8, 32); 
      int_cmd_sof_add               := to_unsigned(AW_SERIAL_INT_CMD_RAM_ADD, 32); 
      int_cmd_eof_add               := to_unsigned(AW_SERIAL_INT_CMD_RAM_ADD + 15, 32); 
      int_cmd_sof_add_m1            := to_unsigned(63, 32); 
      int_checksum_add              := int_cmd_sof_add + to_unsigned(15, 32); 
      frame_dly_cst                 := to_unsigned(10, 32);         
      int_dly_cst                   := to_unsigned(10, 32);         
      
      op_cmd_id                     := resize(x"8500", 32);
      op_cmd_data_size              := to_unsigned(23, 32);
      op_cmd_dlen                   := op_cmd_data_size + 1;      
      op_cmd_sof_add                := to_unsigned(AW_SERIAL_OP_CMD_RAM_ADD, 32);
      op_cmd_eof_add                := to_unsigned(AW_SERIAL_OP_CMD_RAM_ADD + 29, 32);
      
      temp_cmd_id                   := resize(x"8503", 32);
      temp_cmd_sof_add              := to_unsigned(AW_SERIAL_TEMP_CMD_RAM_ADD, 32); 
      temp_cmd_eof_add              := to_unsigned(AW_SERIAL_TEMP_CMD_RAM_ADD + 7, 32);
      
      outgoing_com_hder             := resize(x"AA", 32);
      outgoing_com_ovh_len          := resize(x"5", 32);
      incoming_com_hder             := resize(x"55", 32);
      incoming_com_fail_id          := resize(x"FFFF", 32);
      incoming_com_ovh_len          := resize(x"5", 32);          
      fpa_serdes_lval_num           := resize(x"5", 32); 
      fpa_serdes_lval_len           := resize(x"5", 32); 
      int_time_offset               := to_unsigned(0, 32); 
      
      spare                         := to_unsigned(0, 32);   
      
      int_clk_period_factor         := to_unsigned(DEFINE_INT_CLK_SOURCE_RATE_KHZ/C_FPA_INTCLK_RATE_KHZ, 32);
      
      comn_clk100_to_intclk_conv_numerator  := to_unsigned(integer(real(C_FPA_INTCLK_RATE_KHZ)*real(2**DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(DEFINE_FPA_100M_CLK_RATE_KHZ)), 32);
      comn_intclk_to_clk100_conv_numerator  := to_unsigned(integer(real(DEFINE_FPA_100M_CLK_RATE_KHZ)*real(2**26)/real(C_FPA_INTCLK_RATE_KHZ)), 32);  
      
      comn_fpa_intf_data_source      := resize(unsigned('0'&DATA_SOURCE_OUTSIDE_FPGA), 32);
      
      vid_if_bit_en                  := to_unsigned(1, 32);  
      
      
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
      & comn_clk100_to_intclk_conv_numerator        
      & comn_intclk_to_clk100_conv_numerator
      & comn_fpa_intf_data_source
      & diag_ysize                                   
      & diag_xsize_div_tapnum                       
      & diag_lovh_mclk_source                       
      & real_mode_active_pixel_dly                  
      & spare                                         
      & aoi_xsize                                    
      & aoi_ysize                                   
      & aoi_data_sol_pos                            
      & aoi_data_eol_pos                            
      & aoi_flag1_sol_pos                           
      & aoi_flag1_eol_pos                           
      & aoi_flag2_sol_pos                            
      & aoi_flag2_eol_pos                           
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
      & op_binning                                  
      & op_output_rate 
      & op_mtx_int_low 
      & op_frm_res 
      & op_frm_dat 
      & op_cfg_num                                                               
      & roic_reg_cmd_id                                 
      & roic_reg_cmd_data_size                         
      & roic_reg_cmd_dlen                              
      & roic_reg_cmd_sof_add                           
      & roic_reg_cmd_eof_add                           
      & int_cmd_id                                  
      & int_cmd_data_size                           
      & int_cmd_dlen                                
      & int_cmd_offs                                
      & int_cmd_sof_add                             
      & int_cmd_eof_add                              
      & int_cmd_sof_add_m1                          
      & int_checksum_add                            
      & frame_dly_cst                               
      & int_dly_cst                                 
      & op_cmd_id                                   
      & op_cmd_data_size                            
      & op_cmd_dlen                                 
      & op_cmd_sof_add                              
      & op_cmd_eof_add                              
      & temp_cmd_id                                 
      & temp_cmd_data_size                          
      & temp_cmd_dlen                               
      & temp_cmd_sof_add                            
      & temp_cmd_eof_add                            
      & outgoing_com_hder                           
      & outgoing_com_ovh_len                        
      & incoming_com_hder                           
      & incoming_com_fail_id                        
      & incoming_com_ovh_len                  
      & fpa_serdes_lval_num                   
      & fpa_serdes_lval_len                   
      & int_clk_period_factor                 
      & int_time_offset
      & vid_if_bit_en;                       
      
      return y;
   end to_intf_cfg;
   
end package body calcium640D_intf_testbench_pkg;
