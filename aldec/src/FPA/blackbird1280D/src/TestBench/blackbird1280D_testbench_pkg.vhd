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
use work.proxy_define.all;
use work.fpa_define.all;

package blackbird1280D_testbench_pkg is                                         
   
   
   constant OP_CMD_FR_DLY_MIN         : real     := 11.4286E-6;  -- 10us (see SCD FR calculator)
   constant OP_CMD_INTG_DLY_MIN       : real     := 2.85714E-6;  -- 20us (see SCD FR calculator)
--   constant OP_CMD_FR_DLY_MIN         : real     := 20.0E-6;  -- 10us (see SCD FR calculator)
--   constant OP_CMD_INTG_DLY_MIN       : real     := 10.0E-6;  -- 20us (see SCD FR calculator)

   constant FPP_CLK_RATE              : real     := 70.0E6;
   constant CORR_FACTOR               : real     := FPP_CLK_RATE/(real(SCD_MASTER_CLK_RATE_MHZ)*1.0E6);
   constant VIDEO_RATE                : real     := 2.0; -- specific to proxy <-> FPP interface (always to full).  
   constant T_ADC_CONV                : real     := 10.65E-6*CORR_FACTOR; -- 10.65 us typical
   constant T_FRAME_INIT              : real     := 40.0E-6*CORR_FACTOR;  -- 40 us typical
   constant INT_EG_RLX                : real     := 17.2E-6*CORR_FACTOR;  -- 17.2 us typical (pre+pst) 
   constant ALL_END_TO_NEXT_FSYNC_MIN : real     := 315.0E-6*CORR_FACTOR; -- typical
   constant RO                        : real     := T_ADC_CONV/VIDEO_RATE;  
   constant VHD_PIXEL_PIPE_DLY_ITR    : real     := 0.5E-6; -- Define in driver C
   constant VHD_PIXEL_PIPE_DLY_IWR    : real     := 0.25E-6;-- Define in driver C
   constant SCD_MIN_OPER_FPS          : real     := 12.0; -- A définir ! Define in driver C
   constant BIAS_DEFAULT              : std_logic_vector(3 downto 0) := x"5";     -- 100 pA (default)  TODO : A définir !!! 
   
   constant SCD_DISPLAY_MODE_DEFAULT  : std_logic_vector(3 downto 0) := x"0"; 

   --Pixel gain mode (Operational command)
   constant MEDIUM_GAIN_IWR           : std_logic_vector(7 downto 0) := x"00";
   constant HIGH_GAIN_2_IWR           : std_logic_vector(7 downto 0) := x"01";
   constant MEDIUM_GAIN_ITR           : std_logic_vector(7 downto 0) := x"02";
   constant LOW_GAIN_ITR_IWR          : std_logic_vector(7 downto 0) := x"03";
   constant HIGH_GAIN_1_ITR           : std_logic_vector(7 downto 0) := x"04";
   
   -- Number of channels (Num_of_ch in operational command)
   constant CLINK_BASE                : std_logic_vector(7 downto 0) := x"00";
   constant CLINK_MEDIUM              : std_logic_vector(7 downto 0) := x"01";
   constant CLINK_FULL                : std_logic_vector(7 downto 0) := x"02";
   
   constant NB_PARAM_CFG              : integer := 33; 
   

   
   type sim_cfg_type is
   record 
      framerate             : real range 1.0 to 10000.0;
      height                : integer range 2 to 512; -- step of 2 rows 
      width                 : integer range 4 to 320; -- step of 4 pixels
      offsety               : integer range 0 to 511; -- step of 2 rows; for binning 4 rows
      offsetx               : integer range 0 to 320; -- step of 4 pixels
      exp_time              : integer range 0 to 1048575;
      frame_res             : integer range 2 to 127;
      fpa_stretch_acq_trig  : std_logic; 
      test_ptrn_on          : std_logic; 
      cfg_num               : unsigned(7 downto 0);
      cmd_to_update_id      : std_logic_vector(15 downto 0);
   end record;
   function sec_to_clks(sec:real) return unsigned;
   function clks_to_sec(clks:unsigned) return real;
   function to_intf_cfg(cfg:fpa_intf_cfg_type) return unsigned;
   
   function mediumGainIWR_SpecificParams(sim_cfg:sim_cfg_type) return fpa_intf_cfg_type;
   function mediumGainITR_SpecificParams(sim_cfg:sim_cfg_type) return fpa_intf_cfg_type;

end blackbird1280D_testbench_pkg;

package body blackbird1280D_testbench_pkg is
 

 
   function mediumGainIWR_SpecificParams(sim_cfg:sim_cfg_type) return fpa_intf_cfg_type is
   
       ---- Figure 8 D15F0002 REV2 (Clink Full)
      constant TFPP_CLK         : real := 1.0/(real(SCD_MASTER_CLK_RATE_MHZ)*1000000.0);
      constant FIG8_T1          : real := OP_CMD_FR_DLY_MIN + T_FRAME_INIT;
      constant FIG8_T2          : real := 6.0*TFPP_CLK;
      --variable FIG8_T3          : real := (real(XSIZE_MAX)/real(PROXY_CLINK_PIXEL_NUM))*TFPP_CLK; 
      variable fig8_t3          : real;
      constant FIG8_T4          : real := 800.0E-9; -- clink full only   
      constant FIG8_T5          : real := 100.0E-6; -- Under 100 us typical
      constant FIG8_T6          : real := 16.0E-6/real(PROXY_CLINK_PIXEL_NUM); -- Full @1280pixels per row: 4us , non respect de la doc pour cause d'incohérence

   
     -- D15F0002 REV2 -> figure 3  
      variable m                      : real; -- Represents the number of times integration rise or falls within the frame readout duration.
      variable ro_itr                 : real; 
      variable exp_time_s             : real;
      
      variable ro_iwr                 : real;
      variable x                      : real;
      variable dt                     : real;
      variable t4                     : real;
      variable params                 : fpa_intf_cfg_type;
      
      begin   
       

       -- Calculs
       
       dt := real(sim_cfg.frame_res) * (1.0/FPP_CLK_RATE);
       exp_time_s := real(sim_cfg.exp_time) * dt;
       ro_itr :=  RO*(2.0 + (real(sim_cfg.height)*2.0)) + T_FRAME_INIT; -- height unit is in step of 2 rows
       if (OP_CMD_FR_DLY_MIN <= OP_CMD_INTG_DLY_MIN) and (OP_CMD_FR_DLY_MIN + ro_itr) > (OP_CMD_INTG_DLY_MIN + exp_time_s) then 
          m := 2.0;
       else
         if (OP_CMD_FR_DLY_MIN <= OP_CMD_INTG_DLY_MIN) then   
            m := 1.0;   
         else
            m := 0.0;
         end if;
       end if;
       
       if T_ADC_CONV > dt then
          x :=  T_ADC_CONV;
       else
          x :=  dt;
       end if;
          
       ro_iwr :=  ro_itr +  m*(INT_EG_RLX + x);                                             
       params.comn.fpa_acq_trig_ctrl_dly     := resize(sec_to_clks((1.0/sim_cfg.framerate) - OP_CMD_INTG_DLY_MIN ),params.comn.fpa_acq_trig_ctrl_dly'length);      
       
       t4 := ALL_END_TO_NEXT_FSYNC_MIN;
       --fig8_t3 := ((real(sim_cfg.width)*4.0)/real(PROXY_CLINK_PIXEL_NUM))*TFPP_CLK;
       fig8_t3 := ((real(XSIZE_MAX))/real(PROXY_CLINK_PIXEL_NUM))*TFPP_CLK;
      
      -- Assignation
      params.comn.fpa_diag_mode             := sim_cfg.test_ptrn_on; 
      params.comn.fpa_diag_type             := TELOPS_DIAG_DEGR;  
      params.comn.fpa_pwr_on                := '1';
      params.comn.fpa_trig_ctrl_mode        := MODE_TRIG_START_TO_TRIG_START; 
      
      
      params.comn.fpa_spare                 := (others =>'0');
      --params.comn.fpa_xtra_trig_ctrl_dly    :=  resize(sec_to_clks(1.0/SCD_MIN_OPER_FPS), params.comn.fpa_xtra_trig_ctrl_dly'length);
      params.comn.fpa_xtra_trig_ctrl_dly    :=  to_unsigned(25000,32); -- pour accélérer la simulation
      params.comn.fpa_trig_ctrl_timeout_dly := params.comn.fpa_xtra_trig_ctrl_dly;  -- pour accélérer la simulation   
      params.scd_op.scd_xstart              := to_unsigned(integer(real(sim_cfg.offsetx)*4.0),params.scd_op.scd_xstart'length); -- Offsetx unit is in step of 4 pixels 
      params.scd_op.scd_ystart              := to_unsigned(integer(real(sim_cfg.offsetx)*2.0),params.scd_op.scd_ystart'length); -- Offsety unit is in step of 2 pixels (4 for binning)
      params.scd_op.scd_xsize               := to_unsigned(integer(real(sim_cfg.width)*4.0),params.scd_op.scd_xsize'length);    -- width unit is in step of 4 pixel
      params.scd_op.scd_ysize               := to_unsigned(integer(real(sim_cfg.height)*2.0),params.scd_op.scd_ysize'length);   -- height unit is in step of 2 rows
      params.scd_op.scd_gain                := MEDIUM_GAIN_IWR;   
      params.scd_op.scd_out_chn             := '0'; -- Pas utilise dans le vhd  
      params.scd_op.scd_diode_bias          := BIAS_DEFAULT; 
      params.scd_op.scd_int_mode            := x"01";  -- IWR
      params.scd_op.scd_boost_mode          :=  '0'; -- Boost mode is on (delays are added to prevent image obstruction) 
      params.scd_op.scd_pix_res             :=  SCD_PIX_RES_13B;     
      
      if SCD_MIN_OPER_FPS > sim_cfg.framerate then
         params.scd_op.scd_frame_period_min    := resize(sec_to_clks(1.0/SCD_MIN_OPER_FPS),params.scd_op.scd_frame_period_min'length);
      else
         params.scd_op.scd_frame_period_min    := resize(sec_to_clks(1.0/sim_cfg.framerate),params.scd_op.scd_frame_period_min'length);
      end if;
      
      params.scd_diag.scd_bit_pattern                         := (others =>'0');  -- Normal output         
      params.scd_misc.scd_fsync_re_to_intg_start_dly          := resize(sec_to_clks(OP_CMD_INTG_DLY_MIN),params.scd_misc.scd_fsync_re_to_intg_start_dly'length);     
      params.scd_misc.scd_x_to_readout_start_dly              := resize(sec_to_clks(FIG8_T1),params.scd_misc.scd_x_to_readout_start_dly'length);  
      -- On met le délai a 0 pour générer un fval cohérent avec la doc. 
      --params.scd_misc.scd_x_to_next_fsync_re_dly              := resize(sec_to_clks(0.0),params.scd_misc.scd_x_to_next_fsync_re_dly'length);
      params.scd_misc.scd_x_to_next_fsync_re_dly              := resize(sec_to_clks(ALL_END_TO_NEXT_FSYNC_MIN),params.scd_misc.scd_x_to_next_fsync_re_dly'length);
      params.scd_misc.scd_fsync_re_to_fval_re_dly             := resize(sec_to_clks(FIG8_T1),params.scd_misc.scd_fsync_re_to_fval_re_dly'length);
      params.scd_misc.scd_fval_re_to_dval_re_dly              := resize(sec_to_clks(FIG8_T2),params.scd_misc.scd_fval_re_to_dval_re_dly'length);
      params.scd_misc.scd_lval_high_duration                  := resize(sec_to_clks(fig8_t3),params.scd_misc.scd_lval_high_duration'length);
      params.scd_misc.scd_lval_pause_dly                      := resize(sec_to_clks(FIG8_T4),params.scd_misc.scd_lval_pause_dly'length);   
      params.scd_misc.scd_hdr_start_to_lval_re_dly            := resize(sec_to_clks(FIG8_T5),params.scd_misc.scd_hdr_start_to_lval_re_dly'length);
      --params.scd_misc.scd_hdr_high_duration                   := resize(sec_to_clks(FIG8_T6),params.scd_misc.scd_hdr_high_duration'length);
      params.scd_misc.scd_hdr_high_duration                   := resize(sec_to_clks(FIG8_T6),params.scd_misc.scd_hdr_high_duration'length);
      params.scd_misc.scd_xsize_div_per_pixel_num             := to_unsigned(integer((real(sim_cfg.width)*4.0)/real(PROXY_CLINK_PIXEL_NUM)),params.scd_misc.scd_xsize_div_per_pixel_num'length);
      params.scd_op.cfg_num                                   := sim_cfg.cfg_num;
      params.comn.fpa_stretch_acq_trig                        := sim_cfg.fpa_stretch_acq_trig;
      params.cmd_to_update_id                                 := sim_cfg.cmd_to_update_id;
      params.scd_int.scd_int_time                             := to_unsigned(integer(exp_time_s*(real(FPA_INTF_CLK_RATE_MHZ)*1000000.0)),params.scd_int.scd_int_time'length);--! temps d'integration en coups de 80Mhz
      --params.scd_int.diag_int_time                            :=resize(sec_to_clks(real(exp_time_s)),params.scd_int.diag_int_time'length);     --! temps d'integration en coups de 100Mhz
      params.scd_int.scd_int_indx                             :=(others =>'0');
      params.int_time                                         :=resize(params.scd_int.scd_int_time,params.int_time'length);
      
      return params;
   end mediumGainIWR_SpecificParams;
    
   function mediumGainITR_SpecificParams(sim_cfg:sim_cfg_type) return fpa_intf_cfg_type is
      variable params                              : fpa_intf_cfg_type;
   begin   
      --TODO
      return params;
   end mediumGainITR_SpecificParams;
   
   function to_intf_cfg(cfg:fpa_intf_cfg_type) return unsigned is 
   
      variable comn_fpa_diag_mode                       : unsigned(31 downto  0);
      variable comn_fpa_diag_type                       : unsigned(31 downto  0);
      variable comn_fpa_pwr_on                          : unsigned(31 downto  0);
      variable comn_fpa_trig_ctrl_mode                  : unsigned(31 downto  0);
      variable comn_fpa_acq_trig_ctrl_clks              : unsigned(31 downto  0);
      variable comn_fpa_spare                           : unsigned(31 downto  0);
      variable comn_fpa_xtra_trig_ctrl_dly              : unsigned(31 downto  0);
      variable comn_fpa_trig_ctrl_timeout_dly           : unsigned(31 downto  0); 
      variable scd_xstart                               : unsigned(31 downto  0);
      variable scd_ystart                               : unsigned(31 downto  0);
      variable scd_xsize                                : unsigned(31 downto  0);
      variable scd_ysize                                : unsigned(31 downto  0);
      variable scd_gain                                 : unsigned(31 downto  0);
      variable scd_out_chn                              : unsigned(31 downto  0);
      variable scd_diode_bias                           : unsigned(31 downto  0);
      variable scd_int_mode                             : unsigned(31 downto  0);
      variable scd_boost_mode                           : unsigned(31 downto  0);
      variable scd_pix_res                              : unsigned(31 downto  0);
      variable scd_frame_period_min                     : unsigned(31 downto  0);
      variable scd_bit_pattern                          : unsigned(31 downto  0);
      variable scd_fsync_re_to_intg_start_dly           : unsigned(31 downto  0);
      variable scd_x_to_readout_start_dly               : unsigned(31 downto  0);
      variable scd_x_to_next_fsync_re_dly               : unsigned(31 downto  0);
      variable scd_fsync_re_to_fval_re_dly              : unsigned(31 downto  0);
      variable scd_fval_re_to_dval_re_dly               : unsigned(31 downto  0);
      variable scd_lval_high_duration                   : unsigned(31 downto  0);
      variable scd_lval_pause_dly                       : unsigned(31 downto  0);
      variable scd_hdr_start_to_lval_re_dly             : unsigned(31 downto  0);
      variable scd_hdr_high_duration                    : unsigned(31 downto  0);
      variable scd_xsize_div_per_pixel_num              : unsigned(31 downto  0);
      variable scd_cfg_num                              : unsigned(31 downto  0);
      variable fpa_stretch_acq_trig                     : unsigned(31 downto  0);
      variable proxy_cmd_to_update_id                   : unsigned(31 downto  0);
      
      variable y                              : unsigned(NB_PARAM_CFG*32-1 downto 0);  
      
   begin
      
      comn_fpa_diag_mode                                     := (others => cfg.comn.fpa_diag_mode);
      comn_fpa_diag_type                                     := resize(unsigned(cfg.comn.fpa_diag_type),32);
      comn_fpa_pwr_on                                        := (others => cfg.comn.fpa_pwr_on);
      comn_fpa_trig_ctrl_mode                                := resize(unsigned(cfg.comn.fpa_trig_ctrl_mode),32);
      comn_fpa_acq_trig_ctrl_clks                            := resize(cfg.comn.fpa_acq_trig_ctrl_dly,32);
      comn_fpa_spare                                         := resize(cfg.comn.fpa_spare,32);
      comn_fpa_xtra_trig_ctrl_dly                            := resize(cfg.comn.fpa_xtra_trig_ctrl_dly,32);
      comn_fpa_trig_ctrl_timeout_dly                         := resize(cfg.comn.fpa_trig_ctrl_timeout_dly,32); 
      scd_xstart                                             := resize(cfg.scd_op.scd_xstart,32);
      scd_ystart                                             := resize(cfg.scd_op.scd_ystart,32);
      scd_xsize                                              := resize(cfg.scd_op.scd_xsize,32);
      scd_ysize                                              := resize(cfg.scd_op.scd_ysize,32);
      scd_gain                                               := resize(unsigned(cfg.scd_op.scd_gain),32);
      scd_out_chn                                            := (others => cfg.scd_op.scd_out_chn);
      scd_diode_bias                                         := resize(unsigned(cfg.scd_op.scd_diode_bias),32);
      scd_int_mode                                           := resize(unsigned(cfg.scd_op.scd_int_mode),32);
      scd_boost_mode                                         := (others => cfg.scd_op.scd_boost_mode);
      scd_pix_res                                            := resize(unsigned(cfg.scd_op.scd_pix_res),32);
      scd_frame_period_min                                   := resize(cfg.scd_op.scd_frame_period_min,32);
      scd_bit_pattern                                        := resize(unsigned(cfg.scd_diag.scd_bit_pattern),32);
      scd_fsync_re_to_intg_start_dly                         := resize(cfg.scd_misc.scd_fsync_re_to_intg_start_dly,32);
      scd_x_to_readout_start_dly                             := resize(cfg.scd_misc.scd_x_to_readout_start_dly,32);
      scd_x_to_next_fsync_re_dly                             := resize(cfg.scd_misc.scd_x_to_next_fsync_re_dly,32);
      scd_fsync_re_to_fval_re_dly                            := resize(cfg.scd_misc.scd_fsync_re_to_fval_re_dly,32);
      scd_fval_re_to_dval_re_dly                             := resize(cfg.scd_misc.scd_fval_re_to_dval_re_dly,32);
      scd_lval_high_duration                                 := resize(cfg.scd_misc.scd_lval_high_duration,32);
      scd_lval_pause_dly                                     := resize(cfg.scd_misc.scd_lval_pause_dly,32);
      scd_hdr_start_to_lval_re_dly                           := resize(cfg.scd_misc.scd_hdr_start_to_lval_re_dly,32);
      scd_hdr_high_duration                                  := resize(cfg.scd_misc.scd_hdr_high_duration,32);
      scd_xsize_div_per_pixel_num                            := resize(cfg.scd_misc.scd_xsize_div_per_pixel_num,32);
      scd_cfg_num                                            := resize(cfg.scd_op.cfg_num,32);
      fpa_stretch_acq_trig                                   := (others => cfg.comn.fpa_stretch_acq_trig);
      proxy_cmd_to_update_id                                 := resize(unsigned(cfg.cmd_to_update_id),32);  
      
      -- cfg usager
      y :=  comn_fpa_diag_mode              
      & comn_fpa_diag_type              
      & comn_fpa_pwr_on                 
      & comn_fpa_trig_ctrl_mode         
      & comn_fpa_acq_trig_ctrl_clks
      & comn_fpa_spare      
      & comn_fpa_xtra_trig_ctrl_dly
      & comn_fpa_trig_ctrl_timeout_dly
      & scd_xstart  
      & scd_ystart  
      & scd_xsize
      & scd_ysize
      & scd_gain
      & scd_out_chn
      & scd_diode_bias
      & scd_int_mode
      & scd_boost_mode
      & scd_pix_res
      & scd_frame_period_min
      & scd_bit_pattern
      & scd_x_to_readout_start_dly   
      & scd_fsync_re_to_fval_re_dly
      & scd_fval_re_to_dval_re_dly   
      & scd_hdr_high_duration
      & scd_lval_high_duration
      & scd_hdr_start_to_lval_re_dly
      & scd_lval_pause_dly  
      & scd_x_to_next_fsync_re_dly
      & scd_fsync_re_to_intg_start_dly
      & scd_xsize_div_per_pixel_num  
      & scd_cfg_num
      & fpa_stretch_acq_trig
      & proxy_cmd_to_update_id
      ;
      return y;
   end to_intf_cfg;
   
   
   
    function sec_to_clks(sec:real) return unsigned is         

       variable y                              : unsigned(31 downto 0); 
    begin   
       y :=  to_unsigned(integer(sec*(real(FPA_INTF_CLK_RATE_MHZ)*1000000.0)),32);
       
       return y;
    end sec_to_clks;

    function clks_to_sec(clks:unsigned) return real is         

       variable y                              : real; 
    begin   
       y :=  real(to_integer(clks))/(real(FPA_INTF_CLK_RATE_MHZ)*1000000.0); 
       return y;
    end clks_to_sec;
end package body blackbird1280D_testbench_pkg;