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

package pelicand_testbench_pkg is                                         

   constant TFPP_CLK_SEC              : real := 1.0/(real(DEFINE_DIAG_CLK_RATE_MAX_KHZ)*1000.0);
   constant T_FRAME_INIT_SEC          : real := 2128.0*TFPP_CLK_SEC;
   constant T_LINE_CONV_SEC           : real := 814.0*TFPP_CLK_SEC;
   constant FIG1_FIG2_T5_MIN_IWR_SEC  : real := (6448.0*TFPP_CLK_SEC)+(2.0*T_LINE_CONV_SEC) + 0.00000888; 
   constant FIG1_FIG2_T5_MIN_ITR_SEC  : real := (6448.0*TFPP_CLK_SEC)+(2.0*T_LINE_CONV_SEC); 

   constant T_RELAX_SEC               : real := 0.000005; 
   constant T_LC2INT_SEC              : real := 0.000005;
   constant T_IWR_DELAY_SEC           : real := T_LC2INT_SEC + T_RELAX_SEC;
   
   constant FPA_VHD_INTF_CLK_RATE_HZ  : real := 100_000_000.0;
   constant FIG1_FIG2_T4_SEC          : real := 0.000001;
   constant OFFSETX                   : integer := 0;      
   constant OFFSETY                   : integer := 0; 
   constant SWD_GAIN                  : integer := 0;     -- 0 : SWD_LowGain, 1:   SWD_HighGain 
   constant BOOST_MODE                : integer := 1;     -- 0 : boost, 1:   normal 
   constant OUT_CHN                   : integer := 0;     -- 0 : SCD_CLINK_2_CHN, 1:   SCD_CLINK_1_CHN
   constant BIAS_DEFAULT              : integer := 2;     -- 100 pA (default)   
   constant PIX_RES                   : integer := 2;     -- 0 : 15 bits, 1: 14 bits, 2 : 13 bits 
   constant STRETCH_ACQ_TRIG          : integer := 0;     -- 0 : fixed wheel, 1: rotating wheel  
   constant VHD_PIXEL_PIPE_DLY_ITR    : real    := 0.0000005;
   constant VHD_PIXEL_PIPE_DLY_IWR    : real    := 0.00000025;
   constant SCD_MIN_OPER_FPS          : integer := 12; 
   
   
   function sec_to_clks(sec:real) return unsigned;
   function clks_to_sec(clks:unsigned) return real;
   function to_intf_cfg(diag_mode:std_logic; int_mode:integer; user_xsize:natural; user_ysize:natural; user_framerate:natural; user_exp_time:real; user_cfg_num:unsigned; cmd_id:unsigned) return unsigned;

end pelicand_testbench_pkg;

package body pelicand_testbench_pkg is

   function to_intf_cfg(diag_mode:std_logic; int_mode:integer; user_xsize:natural; user_ysize:natural; user_framerate:natural;  user_exp_time:real; user_cfg_num:unsigned; cmd_id:unsigned) return unsigned is 
   
      variable comn_fpa_diag_mode             : unsigned(31 downto  0);
      variable comn_fpa_diag_type             : unsigned(31 downto  0);
      variable comn_fpa_pwr_on                : unsigned(31 downto  0);
      variable comn_fpa_trig_ctrl_mode        : unsigned(31 downto  0);
      variable comn_fpa_acq_trig_ctrl_clks    : unsigned(31 downto  0);
      variable comn_fpa_spare                 : unsigned(31 downto  0);
      variable comn_fpa_xtra_trig_ctrl_dly    : unsigned(31 downto  0);
      variable comn_fpa_trig_ctrl_timeout_dly : unsigned(31 downto  0); 
      variable scd_xstart                     : unsigned(31 downto  0);
      variable scd_ystart                     : unsigned(31 downto  0);
      variable scd_xsize                      : unsigned(31 downto  0);
      variable scd_ysize                      : unsigned(31 downto  0);
      variable scd_gain                       : unsigned(31 downto  0);
      variable scd_out_chn                    : unsigned(31 downto  0);
      variable scd_diode_bias                 : unsigned(31 downto  0);
      variable scd_int_mode                   : unsigned(31 downto  0);
      variable scd_boost_mode                 : unsigned(31 downto  0);
      variable scd_pix_res                    : unsigned(31 downto  0);
      variable scd_frame_period_min           : unsigned(31 downto  0);
      variable scd_bit_pattern                : unsigned(31 downto  0);
      variable scd_fig1_or_fig2_t4_clks       : unsigned(31 downto  0);
      variable scd_fig1_or_fig2_t6_clks       : unsigned(31 downto  0);
      variable scd_fig1_or_fig2_t5_clks       : unsigned(31 downto  0);
      variable scd_fig4_t1_clks               : unsigned(31 downto  0);
      variable scd_fig4_t2_clks               : unsigned(31 downto  0);
      variable scd_fig4_t3_clks               : unsigned(31 downto  0);
      variable scd_fig4_t4_clks               : unsigned(31 downto  0);
      variable scd_fig4_t5_clks               : unsigned(31 downto  0);
      variable scd_fig4_t6_clks               : unsigned(31 downto  0);
      variable scd_xsize_div2                 : unsigned(31 downto  0);
      variable scd_cfg_num                    : unsigned(31 downto  0);
      variable fpa_stretch_acq_trig           : unsigned(31 downto  0);
      variable proxy_cmd_to_update_id         : unsigned(31 downto  0);
      
      variable y                              : unsigned(33*32-1 downto 0);  
      
      
      
      --------
      variable fig1_or_fig2_t0_sec                 : real; 
      variable fig1_or_fig2_t3_sec                 : real;
      
   begin
      
      comn_fpa_diag_mode             := (others => diag_mode); 
      comn_fpa_diag_type             := resize(unsigned(x"D2"),32);
      comn_fpa_pwr_on                := (others =>'1');
      
      --comn_fpa_xtra_trig_ctrl_dly    := to_unsigned(integer(FPA_VHD_INTF_CLK_RATE_HZ/real(SCD_MIN_OPER_FPS)), comn_fpa_xtra_trig_ctrl_dly'length);
      comn_fpa_xtra_trig_ctrl_dly    := to_unsigned(1100*200, comn_fpa_xtra_trig_ctrl_dly'length);  -- pour accélérer la simulation

      
      comn_fpa_spare                 := (others =>'0');
      
      
      scd_xstart := to_unsigned(OFFSETX,32);
      scd_ystart := to_unsigned(OFFSETY,32);
      scd_xsize  := to_unsigned(user_xsize,32);
      scd_ysize  := to_unsigned(user_ysize,32);
      
      scd_gain       := to_unsigned(SWD_GAIN,32);  
      scd_out_chn    := to_unsigned(OUT_CHN,32); 
      scd_diode_bias := to_unsigned(BIAS_DEFAULT,32); 
      scd_int_mode   := to_unsigned(int_mode,32); 
      scd_pix_res    := to_unsigned(PIX_RES,32);
      scd_gain       := to_unsigned(SWD_GAIN,32); 
      scd_boost_mode := to_unsigned(BOOST_MODE,32);
      
      scd_frame_period_min := to_unsigned(user_framerate,32);
      if user_framerate < SCD_MIN_OPER_FPS then
         scd_frame_period_min := to_unsigned(SCD_MIN_OPER_FPS,32); 
      end if;
      
      scd_bit_pattern := (others =>'0');
      
      scd_fig1_or_fig2_t4_clks := sec_to_clks(FIG1_FIG2_T4_SEC); 
      scd_fig4_t2_clks         := sec_to_clks(5.0*TFPP_CLK_SEC); 
      
      if int_mode = 0 then 
         comn_fpa_trig_ctrl_timeout_dly := to_unsigned(8*to_integer(comn_fpa_xtra_trig_ctrl_dly)/10, comn_fpa_trig_ctrl_timeout_dly'length);
         
         scd_fig1_or_fig2_t6_clks := sec_to_clks(T_RELAX_SEC); 
         fig1_or_fig2_t0_sec := (user_exp_time + fig1_or_fig2_t3_sec + clks_to_sec(scd_fig1_or_fig2_t6_clks) + clks_to_sec(scd_fig1_or_fig2_t4_clks) + FIG1_FIG2_T5_MIN_ITR_SEC)*(99.9/100.0);
         fig1_or_fig2_t3_sec := T_FRAME_INIT_SEC + (T_LINE_CONV_SEC*(real(user_ysize)/2.0+4.0));
         
         if fig1_or_fig2_t0_sec > 0.09 then -- don't forget that T0 must be < 90msec
            fig1_or_fig2_t0_sec := 0.09;   
         end if;  
         
         scd_fig1_or_fig2_t5_clks := sec_to_clks(0.8*(FIG1_FIG2_T5_MIN_ITR_SEC + (fig1_or_fig2_t0_sec*(0.1/100.0)))); 
         
         comn_fpa_trig_ctrl_mode        := resize(unsigned(MODE_INT_END_TO_TRIG_START),32);         
         comn_fpa_acq_trig_ctrl_clks    := sec_to_clks(fig1_or_fig2_t3_sec) + scd_fig1_or_fig2_t5_clks + scd_fig1_or_fig2_t6_clks - sec_to_clks(VHD_PIXEL_PIPE_DLY_ITR);
         scd_fig4_t1_clks               := scd_fig4_t2_clks; 
      
      elsif int_mode = 1 then 
         comn_fpa_trig_ctrl_timeout_dly := to_unsigned(to_integer(comn_fpa_xtra_trig_ctrl_dly), comn_fpa_trig_ctrl_timeout_dly'length);
         
         fig1_or_fig2_t3_sec := T_FRAME_INIT_SEC + (T_LINE_CONV_SEC*(real(user_ysize)/2.0+3.0)) + T_IWR_DELAY_SEC;

         if user_exp_time <= (T_FRAME_INIT_SEC + T_IWR_DELAY_SEC) then
            scd_fig1_or_fig2_t6_clks := sec_to_clks(0.0000054 + user_exp_time); 
         else 
            scd_fig1_or_fig2_t6_clks := sec_to_clks(0.0000054 + 0.00001); 
         end if; 
         
         if user_exp_time > (fig1_or_fig2_t3_sec + clks_to_sec(scd_fig1_or_fig2_t6_clks)) then
            fig1_or_fig2_t0_sec := (user_exp_time + clks_to_sec(scd_fig1_or_fig2_t4_clks) + FIG1_FIG2_T5_MIN_IWR_SEC)/(99.9/100.0);
         else 
            fig1_or_fig2_t0_sec := (fig1_or_fig2_t3_sec + clks_to_sec(scd_fig1_or_fig2_t6_clks) + clks_to_sec(scd_fig1_or_fig2_t4_clks) + FIG1_FIG2_T5_MIN_IWR_SEC)/(99.9/100.0);
         end if;
         
         if fig1_or_fig2_t0_sec > 0.09 then -- don't forget that T0 must be < 90msec
            fig1_or_fig2_t0_sec := 0.09;   
         end if;
         
         scd_fig1_or_fig2_t5_clks       := sec_to_clks((FIG1_FIG2_T5_MIN_IWR_SEC + (fig1_or_fig2_t0_sec*(0.1/100.0))));
         comn_fpa_trig_ctrl_mode        := resize(unsigned(MODE_ALL_END_TO_TRIG_START),32);         
         comn_fpa_acq_trig_ctrl_clks    := scd_fig1_or_fig2_t5_clks - sec_to_clks(VHD_PIXEL_PIPE_DLY_IWR);  
         scd_fig4_t1_clks               := sec_to_clks(T_LINE_CONV_SEC + 0.000002);
         
      end if;
      
      if comn_fpa_diag_mode > 0 then 
         comn_fpa_trig_ctrl_mode        := resize(unsigned(MODE_READOUT_END_TO_TRIG_START),32);
         comn_fpa_acq_trig_ctrl_clks    := to_unsigned(0, comn_fpa_acq_trig_ctrl_clks'length);
      end if;

      scd_fig4_t3_clks         := sec_to_clks(320.0*TFPP_CLK_SEC);
      scd_fig4_t4_clks         := sec_to_clks(22.0*TFPP_CLK_SEC);
      scd_fig4_t5_clks         := sec_to_clks(0.00008);
      scd_fig4_t6_clks         := sec_to_clks(64.0*TFPP_CLK_SEC);
      scd_xsize_div2           := to_unsigned(user_xsize/2,32);
      scd_cfg_num              := user_cfg_num; 
      
      fpa_stretch_acq_trig := to_unsigned(STRETCH_ACQ_TRIG,32);
      proxy_cmd_to_update_id := cmd_id;
      
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
      & scd_fig1_or_fig2_t6_clks   
      & scd_fig4_t1_clks
      & scd_fig4_t2_clks   
      & scd_fig4_t6_clks
      & scd_fig4_t3_clks
      & scd_fig4_t5_clks
      & scd_fig4_t4_clks  
      & scd_fig1_or_fig2_t5_clks
      & scd_fig1_or_fig2_t4_clks
      & scd_xsize_div2  
      & scd_cfg_num
      & fpa_stretch_acq_trig
      & proxy_cmd_to_update_id
      ;
      return y;
   end to_intf_cfg;
   
   
   
    function sec_to_clks(sec:real) return unsigned is         

       variable y                              : unsigned(31 downto 0); 
    begin   
       y :=  to_unsigned(integer(sec*FPA_VHD_INTF_CLK_RATE_HZ),32);
       
       return y;
    end sec_to_clks;

    function clks_to_sec(clks:unsigned) return real is         

       variable y                              : real; 
    begin   
       y :=  real(to_integer(clks))/FPA_VHD_INTF_CLK_RATE_HZ; 
       return y;
    end clks_to_sec;
end package body pelicand_testbench_pkg;