------------------------------------------------------------------
--!   @file : scorpiomwA_mblaze_intf
--!   @brief
--!   @details
--!
--!   $Rev: 27266 $
--!   $Author: enofodjie $
--!   $Date: 2022-03-28 15:39:27 -0400 (lun., 28 mars 2022) $
--!   $Id: scorpiomwA_mblaze_intf.vhd 27266 2022-03-28 19:39:27Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00272-FleG/trunk/src/FPA/scorpiomwA/HDL/scorpiomwA_mblaze_intf.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_misc.all;
use work.tel2000.all;
use work.FPA_define.all;
use work.fpa_common_pkg.all;
use work.fleg_brd_define.all;


entity scorpiomwA_mblaze_intf is
   port(
      
      ARESET                : in std_logic;
      MB_CLK                : in std_logic;
      
      FPA_EXP_INFO          : in exp_info_type;
      
      MB_MOSI               : in t_axi4_lite_mosi;
      MB_MISO               : out t_axi4_lite_miso;
      
      RESET_ERR             : out std_logic;
      STATUS_MOSI           : out t_axi4_lite_mosi;
      STATUS_MISO           : in t_axi4_lite_miso;
      CTRLED_RESET          : out std_logic;
      
      PRIVATE_HDER          : out t_axi4_stream_mosi64;
      
      FPA_DRIVER_STAT       : in std_logic_vector(31 downto 0);
      
      USER_CFG              : out fpa_intf_cfg_type;
      COOLER_STAT           : out fpa_cooler_stat_type;
      
      FPA_SOFTW_STAT        : out fpa_firmw_stat_type
      
      );
end scorpiomwA_mblaze_intf; 

architecture rtl of scorpiomwA_mblaze_intf is  
   
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_26  : natural := DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS + 26; --pour un total de 26 bits pour le temps d'integration de 0207
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1   : natural := DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS - 1;   
   constant C_DIAG_LOVH_MCLK                          : natural := 1;
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   type exp_indx_pipe_type is array (0 to 4) of std_logic_vector(7 downto 0);
   type exp_time_pipe_type is array (0 to 4) of unsigned(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_26 downto 0);
   
   signal exp_time_pipe                : exp_time_pipe_type := ((others => '0'), (others => '0'), (others => '0'), (others => '0'), (others => '0')); 
   signal sreset_mb_clk                : std_logic;
   signal axi_awaddr	                  : std_logic_vector(31 downto 0);
   signal axi_awready	               : std_logic;
   signal axi_wready	                  : std_logic;
   signal axi_bresp	                  : std_logic_vector(1 downto 0);
   signal axi_bvalid	                  : std_logic;
   signal axi_araddr	                  : std_logic_vector(31 downto 0);
   signal axi_arready	               : std_logic;
   signal axi_rdata	                  : std_logic_vector(31 downto 0);
   signal axi_rresp	                  : std_logic_vector(1 downto 0);
   signal axi_rvalid	                  : std_logic;
   signal axi_wstrb                    : std_logic_vector(3 downto 0);  
   signal stat_rd_add                  : std_logic_vector(31 downto 0); 
   signal stat_rd_data                 : std_logic_vector(31 downto 0);
   signal stat_rd_en                   : std_logic := '0';
   signal stat_rd_dval                 : std_logic;
   signal slv_reg_rden                 : std_logic;
   signal slv_reg_wren                 : std_logic;
   signal fpa_intf_cfg_i               : fpa_intf_cfg_type; 
   signal data_i                       : std_logic_vector(31 downto 0);
   --signal permit_inttime_change        : std_logic;
   signal update_cfg                   : std_logic;
   signal user_cfg_in_progress         : std_logic := '0';
   signal user_cfg_i                   : fpa_intf_cfg_type;
   signal int_dval_i                   : std_logic := '0';
   signal int_time_i                   : unsigned(31 downto 0);
   signal int_indx_i                   : std_logic_vector(7 downto 0);
   signal int_signal_high_time_i       : unsigned(31 downto 0);
   signal exp_indx_pipe                : exp_indx_pipe_type;
   signal exp_dval_pipe                : std_logic_vector(7 downto 0) := (others => '0');
   signal fpa_softw_stat_i             : fpa_firmw_stat_type;
   signal ctrled_reset_i               : std_logic;
   signal reset_err_i                  : std_logic;
   signal sreset                       : std_logic;
   signal user_cfg_rdy_pipe            : std_logic_vector(7 downto 0) := (others => '0');
   signal user_cfg_rdy                 : std_logic := '0';
   --signal tri_min                      : integer;
   --signal tri_int_part                 : integer;
   signal exp_time_reg                 : unsigned(30 downto 0);
   signal valid_cfg_received           : std_logic := '0';
   signal mb_ctrled_reset_i            : std_logic := '0';
   signal dac_cfg_in_progress          : std_logic;
   signal abs_int_time_offset_mclk_i   : integer := 0;
   signal subtraction_possible         : std_logic := '0';
   
   signal private_hder_dval            : std_logic;
   signal private_hder_data            : std_logic_vector(31 downto 0);
   signal private_hder_add             : std_logic_vector(7 downto 0);
   
   
   --   -- -- -- attribute dont_touch                         : string;
   --   -- -- -- attribute dont_touch of fpa_softw_stat_i     : signal is "true";
   --   -- -- -- attribute dont_touch of user_cfg_i             : signal is "true";
   --   -- -- -- attribute dont_touch of user_cfg_in_progress : signal is "true";
   --   -- -- -- attribute dont_touch of fpa_intf_cfg_i       : signal is "true";
   --   -- -- -- attribute dont_touch of tri_min              : signal is "true";
   --   -- -- -- attribute dont_touch of tri_int_part         : signal is "true";
   --   -- -- -- attribute dont_touch of exp_time_reg         : signal is "true";
   
begin   
   
   
   CTRLED_RESET            <= ctrled_reset_i;
   RESET_ERR               <= reset_err_i;
   FPA_SOFTW_STAT          <= fpa_softw_stat_i;
   COOLER_STAT.COOLER_ON   <= '1'; 
   
   -- ecriture du private header en bram  
   PRIVATE_HDER.TDATA(39 downto 0)  <= private_hder_add & private_hder_data;
   PRIVATE_HDER.TVALID              <= private_hder_dval;
   
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U1 : sync_reset
   port map(ARESET => ARESET, CLK => MB_CLK, SRESET => sreset); 
   
   --   ------------------------------------------------  
   --   -- sortie de la config                              
   --   -------------------------------------------------  
   U2: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then  
         --permit_inttime_change <= FPA_DRIVER_STAT(7);
         update_cfg <= user_cfg_rdy; --permit_inttime_change and  user_cfg_rdy;
         
         if update_cfg = '1' then -- la config au complet 
            USER_CFG <= user_cfg_i;  
            valid_cfg_received <= '1';         
         end if;
      end if;  
   end process;   
   
   -------------------------------------------------  
   -- liens axil                           
   -------------------------------------------------  
   -- I/O Connections assignments
   MB_MISO.AWREADY     <= axi_awready;
   MB_MISO.WREADY      <= axi_wready;
   MB_MISO.BRESP	     <= axi_bresp;
   MB_MISO.BVALID      <= axi_bvalid;
   MB_MISO.ARREADY     <= axi_arready;
   MB_MISO.RDATA	     <= axi_rdata;
   MB_MISO.RRESP	     <= axi_rresp;
   MB_MISO.RVALID      <= axi_rvalid; 
   
   -- STATUS_MOSI toujours envoyé au fpa_status_gen pour eviter des delais
   STATUS_MOSI.AWVALID <= '0';   -- registres de statut en mode lecture seulement
   STATUS_MOSI.AWADDR  <= (others => '0');   -- registres de statut en mode lecture seulement
   STATUS_MOSI.AWPROT  <= (others => '0'); -- registres de statut en mode lecture seulement
   STATUS_MOSI.WVALID  <= '0'; -- registres de statut en mode lecture seulement    
   STATUS_MOSI.WDATA   <= (others => '0'); -- registres de statut en mode lecture seulement 
   STATUS_MOSI.WSTRB   <= (others => '0'); -- registres de statut en mode lecture seulement 
   STATUS_MOSI.BREADY  <= '0'; -- registres de statut en mode lecture seulement
   STATUS_MOSI.ARVALID <= MB_MOSI.ARVALID;
   STATUS_MOSI.ARADDR  <= resize(MB_MOSI.ARADDR(9 downto 0), 32); -- (9 downto 0) permet d'adresser tous les registres de statuts 
   STATUS_MOSI.ARPROT  <= MB_MOSI.ARPROT; 
   STATUS_MOSI.RREADY  <= MB_MOSI.RREADY;    
   
   -------------------------------------------------  
   -- reception Config                                
   -------------------------------------------------   
   U3: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         if sreset = '1' then
            ctrled_reset_i <= '1';
            reset_err_i <= '0';
            user_cfg_in_progress <= '1'; -- fait expres pour qu'il soit mis à '0' ssi au moins une config rentre  
            dac_cfg_in_progress <= '1'; 
            mb_ctrled_reset_i <= '0';
            user_cfg_i.sat_ctrl_en <= '0';            
            
         else                   
            
            ctrled_reset_i <= mb_ctrled_reset_i or not valid_cfg_received; 
            user_cfg_i.comn.intclk_to_clk100_conv_numerator <= DEFINE_FPA_EXP_TIME_RECONV_NUMERATOR;
            
            -- temps d'exposition  en mclk
            if int_dval_i = '1' then
               user_cfg_i.int_time <= int_time_i;
               user_cfg_i.int_indx <= int_indx_i;
               user_cfg_i.int_signal_high_time <= int_signal_high_time_i;
            end if;
            
            -- 
            user_cfg_i.int_fdbk_dly <= to_unsigned(DEFINE_FPA_INT_FDBK_DLY, user_cfg_i.int_fdbk_dly'length);  -- isc0209A
            
            -- MB: private header
            private_hder_add  <= std_logic_vector(resize(axi_awaddr(7 downto 2),private_hder_add'length));  -- Cela suppose que l'adresse du mB varie par pas de 4 
            private_hder_data <= data_i(31 downto 0); -- pour la partie serielle de la config, seule la partie (7 downto 0) est valide (voir le driver C)                  
            private_hder_dval <= slv_reg_wren and and_reduce(axi_awaddr(11 downto 8)); -- la ram est ecrite lorsque l'adresse de base est x"C00" ou "D00" ou "E00" ou "F00"       
            
            -- reste de la config
            if slv_reg_wren = '1' then  
               case axi_awaddr(11 downto 0) is             
                  
                  -- comn                                                                                              
                  when X"000" =>    user_cfg_i.comn.fpa_diag_mode              <= data_i(0); user_cfg_in_progress <= '1';                       
                  when X"004" =>    user_cfg_i.comn.fpa_diag_type              <= data_i(user_cfg_i.comn.fpa_diag_type'length-1 downto 0); 
                  when X"008" =>    user_cfg_i.comn.fpa_pwr_on                 <= data_i(0);						
                  when X"00C" =>    user_cfg_i.comn.fpa_init_cfg               <= data_i(0);
                  when X"010" =>    user_cfg_i.comn.fpa_init_cfg_received      <= data_i(0);   -- fpa_init_cfg_received en provenance du µBlaze est sans utilité
                  when X"014" =>    user_cfg_i.comn.fpa_acq_trig_mode          <= data_i(user_cfg_i.comn.fpa_acq_trig_mode'length-1 downto 0);                                                                                                                                        
                  when X"018" =>    user_cfg_i.comn.fpa_acq_trig_ctrl_dly      <= unsigned(data_i(user_cfg_i.comn.fpa_acq_trig_ctrl_dly'length-1 downto 0));    --						                                                  
                  when X"01C" =>    user_cfg_i.comn.fpa_xtra_trig_mode         <= data_i(user_cfg_i.comn.fpa_xtra_trig_mode'length-1 downto 0);                 -- 			                                                     
                  when X"020" =>    user_cfg_i.comn.fpa_xtra_trig_ctrl_dly     <= unsigned(data_i(user_cfg_i.comn.fpa_xtra_trig_ctrl_dly'length-1 downto 0));   -- 				                                                     
                  when X"024" =>    user_cfg_i.comn.fpa_trig_ctrl_timeout_dly  <= unsigned(data_i(user_cfg_i.comn.fpa_trig_ctrl_timeout_dly'length-1 downto 0));-- 		                                                     
                  when X"028" =>    user_cfg_i.comn.fpa_stretch_acq_trig       <= data_i(0);                      
                  when X"02C" =>    user_cfg_i.comn.fpa_intf_data_source       <= data_i(0);
                     
                  -- roic
                  when X"030" =>    user_cfg_i.roic.xstart                     <= unsigned(data_i(user_cfg_i.roic.xstart'length-1 downto 0));                                                                                                                                               
                  when X"034" =>    user_cfg_i.roic.ystart                     <= unsigned(data_i(user_cfg_i.roic.ystart'length-1 downto 0));                                                                                                                                               
                  when X"038" =>    user_cfg_i.roic.xsize                      <= unsigned(data_i(user_cfg_i.roic.xsize'length-1 downto 0));                                                                                                                                                
                  when X"03C" =>    user_cfg_i.roic.ysize                      <= unsigned(data_i(user_cfg_i.roic.ysize'length-1 downto 0));                                                                                                                                                
                  when X"040" =>    user_cfg_i.roic.windcfg_part1              <= unsigned(data_i(user_cfg_i.roic.windcfg_part1'length-1 downto 0));                                                                                                                                        
                  when X"044" =>    user_cfg_i.roic.windcfg_part2              <= unsigned(data_i(user_cfg_i.roic.windcfg_part2'length-1 downto 0));                                                                                                                                        
                  when X"048" =>    user_cfg_i.roic.windcfg_part3              <= unsigned(data_i(user_cfg_i.roic.windcfg_part3'length-1 downto 0));                                                                                                                                        
                  when X"04C" =>    user_cfg_i.roic.windcfg_part4              <= unsigned(data_i(user_cfg_i.roic.windcfg_part4'length-1 downto 0));                                                                                                                                        
                  when X"050" =>    user_cfg_i.roic.uprow_upcol                <= data_i(0);                                                                                                                                                                                           
                  when X"054" =>    user_cfg_i.roic.sizea_sizeb                <= data_i(0);                                                                                                                                                                                           
                  when X"058" =>    user_cfg_i.roic.itr                        <= data_i(0);                                                                                                                                                                                           
                  when X"05C" =>    user_cfg_i.roic.gain                       <= data_i(0);                                                                                                                                                                                           
                  when X"060" =>    user_cfg_i.roic.gpol_code                  <= data_i(user_cfg_i.roic.gpol_code'length-1 downto 0);                                                                                                                                                      
                  when X"064" =>    user_cfg_i.roic.reset_time_mclk            <= unsigned(data_i(user_cfg_i.roic.reset_time_mclk'length-1 downto 0));
                     
                  -- diag
                  when X"068" =>    user_cfg_i.diag.ysize                      <= unsigned(data_i(user_cfg_i.diag.ysize'length-1 downto 0));                                 
                  when X"06C" =>    user_cfg_i.diag.xsize_div_tapnum           <= unsigned(data_i(user_cfg_i.diag.xsize_div_tapnum'length-1 downto 0)); 
                  
                  when X"070" =>    user_cfg_i.real_mode_active_pixel_dly      <= unsigned(data_i(user_cfg_i.real_mode_active_pixel_dly'length-1 downto 0));                                                                                                                           
                  when X"074" =>    user_cfg_i.adc_quad2_en                    <= data_i(0);                                                                                                                                                                                           
                  when X"078" =>    user_cfg_i.chn_diversity_en                <= data_i(0);                                                                                                                                                                                           
                     
                  -- raw_area                                                                                                                                                                     
                  when X"07C" =>    user_cfg_i.raw_area.line_start_num         <= unsigned(data_i(user_cfg_i.raw_area.line_start_num'length-1 downto 0));                                                                                                                                                                                                                                                
                  when X"080" =>    user_cfg_i.raw_area.line_end_num           <= unsigned(data_i(user_cfg_i.raw_area.line_end_num'length-1 downto 0));                                                                                                                                         
                  when X"084" =>    user_cfg_i.raw_area.sof_posf_pclk          <= unsigned(data_i(user_cfg_i.raw_area.sof_posf_pclk'length-1 downto 0));                                                                                                                                        
                  when X"088" =>    user_cfg_i.raw_area.eof_posf_pclk          <= unsigned(data_i(user_cfg_i.raw_area.eof_posf_pclk'length-1 downto 0));                                                                                                                                        
                  when X"08C" =>    user_cfg_i.raw_area.sol_posl_pclk          <= unsigned(data_i(user_cfg_i.raw_area.sol_posl_pclk'length-1 downto 0));                                                                                                                                        
                  when X"090" =>    user_cfg_i.raw_area.eol_posl_pclk          <= unsigned(data_i(user_cfg_i.raw_area.eol_posl_pclk'length-1 downto 0));                                                                                                                                        
                  when X"094" =>    user_cfg_i.raw_area.lsync_start_posl_pclk  <= unsigned(data_i(user_cfg_i.raw_area.lsync_start_posl_pclk'length-1 downto 0)); 
                  when X"098" =>    user_cfg_i.raw_area.lsync_end_posl_pclk    <= unsigned(data_i(user_cfg_i.raw_area.lsync_end_posl_pclk'length-1 downto 0));                  
                  when X"09C" =>    user_cfg_i.raw_area.lsync_num              <= unsigned(data_i(user_cfg_i.raw_area.lsync_num'length-1 downto 0));                                                                                  
                  when X"0A0" =>    user_cfg_i.raw_area.clk_id                 <= unsigned(data_i(user_cfg_i.raw_area.clk_id'length-1 downto 0));
                  when X"0A4" =>    user_cfg_i.raw_area.line_period_pclk       <= unsigned(data_i(user_cfg_i.raw_area.line_period_pclk'length-1 downto 0));                                                                                                                                     
                  when X"0A8" =>    user_cfg_i.raw_area.readout_pclk_cnt_max   <= unsigned(data_i(user_cfg_i.raw_area.readout_pclk_cnt_max'length-1 downto 0));                                                                                                                                                                                                                                                                                   
                     
                  -- user_area                                                                                                                                                                    
                  when X"0AC" =>    user_cfg_i.user_area.line_start_num        <= unsigned(data_i(user_cfg_i.user_area.line_start_num'length-1 downto 0));                                                                                                                                                                                                                                                
                  when X"0B0" =>    user_cfg_i.user_area.line_end_num          <= unsigned(data_i(user_cfg_i.user_area.line_end_num'length-1 downto 0));                                                                                                                                           
                  when X"0B4" =>    user_cfg_i.user_area.sol_posl_pclk         <= unsigned(data_i(user_cfg_i.user_area.sol_posl_pclk'length-1 downto 0));                                                                                                                                          
                  when X"0B8" =>    user_cfg_i.user_area.eol_posl_pclk         <= unsigned(data_i(user_cfg_i.user_area.eol_posl_pclk'length-1 downto 0));                                 
                  when X"0BC" =>    user_cfg_i.user_area.clk_id                <= unsigned(data_i(user_cfg_i.user_area.clk_id'length-1 downto 0)); 
                     
                  -- clk_area_a                                                                                                                                                                                                                                                                                                                                                                                                                                                  
                  when X"0C0" =>    user_cfg_i.clk_area_a.line_start_num       <= unsigned(data_i(user_cfg_i.clk_area_a.line_start_num'length-1 downto 0));                                                                                                                                                                                                                                                
                  when X"0C4" =>    user_cfg_i.clk_area_a.line_end_num         <= unsigned(data_i(user_cfg_i.clk_area_a.line_end_num'length-1 downto 0));                                                                                                                                           
                  when X"0C8" =>    user_cfg_i.clk_area_a.sol_posl_pclk        <= unsigned(data_i(user_cfg_i.clk_area_a.sol_posl_pclk'length-1 downto 0));                                                                                                                                          
                  when X"0CC" =>    user_cfg_i.clk_area_a.eol_posl_pclk        <= unsigned(data_i(user_cfg_i.clk_area_a.eol_posl_pclk'length-1 downto 0));                                
                  when X"0D0" =>    user_cfg_i.clk_area_a.clk_id               <= unsigned(data_i(user_cfg_i.clk_area_a.clk_id'length-1 downto 0));                                                                                                                                                               
                  when X"0D4" =>    user_cfg_i.clk_area_a.spare                <= unsigned(data_i(user_cfg_i.clk_area_a.spare'length-1 downto 0));
                     
                  -- clk_area_b                                                                                                                                                                   
                  when X"0D8" =>    user_cfg_i.clk_area_b.line_start_num       <= unsigned(data_i(user_cfg_i.clk_area_b.line_start_num'length-1 downto 0));                               
                  when X"0DC" =>    user_cfg_i.clk_area_b.line_end_num         <= unsigned(data_i(user_cfg_i.clk_area_b.line_end_num'length-1 downto 0));                                 
                  when X"0E0" =>    user_cfg_i.clk_area_b.sol_posl_pclk        <= unsigned(data_i(user_cfg_i.clk_area_b.sol_posl_pclk'length-1 downto 0));                                
                  when X"0E4" =>    user_cfg_i.clk_area_b.eol_posl_pclk        <= unsigned(data_i(user_cfg_i.clk_area_b.eol_posl_pclk'length-1 downto 0));
                  when X"0E8" =>    user_cfg_i.clk_area_b.clk_id               <= unsigned(data_i(user_cfg_i.clk_area_b.clk_id'length-1 downto 0)); 
                  when X"0EC" =>    user_cfg_i.clk_area_b.spare                <= unsigned(data_i(user_cfg_i.clk_area_b.spare'length-1 downto 0));
                     
                  -- data_ctrl param 
                  when X"0F0" =>    user_cfg_i.hgood_samp_sum_num              <= unsigned(data_i(user_cfg_i.hgood_samp_sum_num'length-1 downto 0));                                                                                                                                   
                  when X"0F4" =>    user_cfg_i.hgood_samp_mean_numerator       <= unsigned(data_i(user_cfg_i.hgood_samp_mean_numerator'length-1 downto 0));                                                                                                                            
                  when X"0F8" =>    user_cfg_i.vgood_samp_sum_num              <= unsigned(data_i(user_cfg_i.vgood_samp_sum_num'length-1 downto 0));                                                                                                                                   
                  when X"0FC" =>    user_cfg_i.vgood_samp_mean_numerator       <= unsigned(data_i(user_cfg_i.vgood_samp_mean_numerator'length-1 downto 0));                                                                                                                            
                  when X"100" =>    user_cfg_i.good_samp_first_pos_per_ch      <= unsigned(data_i(user_cfg_i.good_samp_first_pos_per_ch'length-1 downto 0));                                                                                                                           
                  when X"104" =>    user_cfg_i.good_samp_last_pos_per_ch       <= unsigned(data_i(user_cfg_i.good_samp_last_pos_per_ch'length-1 downto 0));                                                                                                                            
                     
                  -- -- misc 
                  when X"108" =>    user_cfg_i.adc_clk_source_phase            <= unsigned(data_i(user_cfg_i.adc_clk_source_phase'length-1 downto 0));      
                  when X"10C" =>    user_cfg_i.adc_clk_pipe_sel                <= unsigned(data_i(user_cfg_i.adc_clk_pipe_sel'length-1 downto 0));          
                  when X"110" =>    user_cfg_i.cfg_num                         <= unsigned(data_i(user_cfg_i.cfg_num'length-1 downto 0));                   
                  when X"114" =>    user_cfg_i.int_time_offset_mclk            <= signed(data_i(user_cfg_i.int_time_offset_mclk'length-1 downto 0));        
                  when X"118" =>    user_cfg_i.nominal_clk_id_sample_pos       <= unsigned(data_i(user_cfg_i.nominal_clk_id_sample_pos'length-1 downto 0)); 
                  when X"11C" =>    user_cfg_i.fast1_clk_id_sample_pos         <= unsigned(data_i(user_cfg_i.fast1_clk_id_sample_pos'length-1 downto 0));                  
                  when X"120" =>    user_cfg_i.fast2_clk_id_sample_pos         <= unsigned(data_i(user_cfg_i.fast2_clk_id_sample_pos'length-1 downto 0));                                                                                                                                 
                  when X"124" =>    user_cfg_i.tir_dly_adc_clk                 <= unsigned(data_i(user_cfg_i.tir_dly_adc_clk'length-1 downto 0));        
                  when X"128" =>    user_cfg_i.single_samp_mode_en             <= data_i(0); user_cfg_in_progress <= '0';                                

                  -- fpa_softw_stat_i qui dit au sequenceur general quel pilote C est en utilisation
                  when X"AE0" =>    fpa_softw_stat_i.fpa_roic                  <= data_i(fpa_softw_stat_i.fpa_roic'length-1 downto 0);
                  when X"AE4" =>    fpa_softw_stat_i.fpa_output                <= data_i(fpa_softw_stat_i.fpa_output'length-1 downto 0);  
                  when X"AE8" =>    fpa_softw_stat_i.fpa_input                 <= data_i(fpa_softw_stat_i.fpa_input'length-1 downto 0); fpa_softw_stat_i.dval <='1';  
                     
                  -- pour effacer erreurs latchées
                  when X"AEC" =>    reset_err_i                                <= data_i(0); 
                     
                  -- pour un reset complet du module FPA
                  when X"AF0" =>   mb_ctrled_reset_i                           <= data_i(0); fpa_softw_stat_i.dval <='0'; -- ENO: 10 juin 2015: ce reset permet de mettre la sortie vers le DDC en 'Z' lorsqu'on etient la carte DDC et permet de faire un reset lorsqu'on allume la carte DDC
                     
                     ----------------------------------------------------------------------------------------------------------------------------------------                  
                     -- EN0 15 janv 2019: la config des DACs passe désormais par l'adresse de base 0xD00 en vue de securiser les tensions du détecteur 
                  ----------------------------------------------------------------------------------------------------------------------------------------
                  when X"D00" =>    user_cfg_i.vdac_value(1)                   <= unsigned(data_i(user_cfg_i.vdac_value(1)'length-1 downto 0)); dac_cfg_in_progress <= '1';                                                                                                                        
                  when X"D04" =>    user_cfg_i.vdac_value(2)                   <= unsigned(data_i(user_cfg_i.vdac_value(2)'length-1 downto 0));                                                                                                                           
                  when X"D08" =>    user_cfg_i.vdac_value(3)                   <= unsigned(data_i(user_cfg_i.vdac_value(3)'length-1 downto 0));                                                                                                                            
                  when X"D0C" =>    user_cfg_i.vdac_value(4)                   <= unsigned(data_i(user_cfg_i.vdac_value(4)'length-1 downto 0));                                                                                                                            
                  when X"D10" =>    user_cfg_i.vdac_value(5)                   <= unsigned(data_i(user_cfg_i.vdac_value(5)'length-1 downto 0));                                                                               
                  when X"D14" =>    user_cfg_i.vdac_value(6)                   <= unsigned(data_i(user_cfg_i.vdac_value(6)'length-1 downto 0));                                  
                  when X"D18" =>    user_cfg_i.vdac_value(7)                   <= unsigned(data_i(user_cfg_i.vdac_value(7)'length-1 downto 0));                                  
                  when X"D1C" =>    user_cfg_i.vdac_value(8)                   <= unsigned(data_i(user_cfg_i.vdac_value(8)'length-1 downto 0)); dac_cfg_in_progress <= '0';  ----
                  
                  when others =>
                  
               end case;     
               
            end if; 
         end if; 
      end if; 
   end process;
   
   ------------------------------------------------  
   -- calcul du temps d'integratuion en coups de MCLK                               
   -------------------------------------------------
   U4: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         
         abs_int_time_offset_mclk_i <= to_integer(abs(user_cfg_i.int_time_offset_mclk));         
         if int_time_i > abs_int_time_offset_mclk_i then 
            subtraction_possible <= '1';
         else
            subtraction_possible <= '0';
         end if;   
         
         -- pipe pour le calcul du temps d'integration en mclk
         exp_time_pipe(0) <= resize(FPA_EXP_INFO.EXP_TIME, exp_time_pipe(0)'length) ;
         exp_time_pipe(1) <= resize(exp_time_pipe(0) * DEFINE_FPA_EXP_TIME_CONV_NUMERATOR, exp_time_pipe(0)'length);          
         exp_time_pipe(2) <= resize(exp_time_pipe(1)(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_26 downto DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS), exp_time_pipe(0)'length);  -- soit une division par 2^EXP_TIME_CONV_DENOMINATOR
         exp_time_pipe(3) <= exp_time_pipe(2) + resize("00"& exp_time_pipe(1)(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1), exp_time_pipe(0)'length);  -- pour l'operation d'arrondi
         int_time_i       <= exp_time_pipe(3)(int_time_i'length-1 downto 0);
         
         if user_cfg_i.int_time_offset_mclk(31) = '0' then 
            exp_time_pipe(4) <= exp_time_pipe(3)+ to_unsigned(abs_int_time_offset_mclk_i, exp_time_pipe(4)'length);
         else
            if subtraction_possible = '1' then
               exp_time_pipe(4) <= exp_time_pipe(3)- to_unsigned(abs_int_time_offset_mclk_i, exp_time_pipe(4)'length);
            else
               exp_time_pipe(4) <= to_unsigned(1, exp_time_pipe(4)'length);
            end if;
         end if; 
         
         int_signal_high_time_i <= exp_time_pipe(4)(int_signal_high_time_i'length-1 downto 0);
         
         -- pipe de synchro pour l'index           
         exp_indx_pipe(0) <= FPA_EXP_INFO.EXP_INDX;
         exp_indx_pipe(1) <= exp_indx_pipe(0); 
         exp_indx_pipe(2) <= exp_indx_pipe(1); 
         exp_indx_pipe(3) <= exp_indx_pipe(2); 
         exp_indx_pipe(4) <= exp_indx_pipe(3);
         int_indx_i       <= exp_indx_pipe(4);    -- precede int_dval_i
         
         -- pipe pour rendre valide la donnée qques CLKs apres sa sortie
         exp_dval_pipe(0) <= FPA_EXP_INFO.EXP_DVAL;
         exp_dval_pipe(1) <= exp_dval_pipe(0); 
         exp_dval_pipe(2) <= exp_dval_pipe(1); 
         exp_dval_pipe(3) <= exp_dval_pipe(2);
         exp_dval_pipe(4) <= exp_dval_pipe(3);
         exp_dval_pipe(5) <= exp_dval_pipe(4);
         exp_dval_pipe(6) <= exp_dval_pipe(5);
         exp_dval_pipe(7) <= exp_dval_pipe(6); 
         int_dval_i       <= exp_dval_pipe(7);
         
      end if;
   end process; 
   
   ------------------------------------------------  
   -- delai
   -------------------------------------------------
   U4B: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         
         if FPA_EXP_INFO.EXP_DVAL = '1' then
            exp_time_reg <= FPA_EXP_INFO.EXP_TIME(exp_time_reg'length-1 downto 0);
         end if;
         
         -- user_cfg_rdy
         user_cfg_rdy_pipe(0) <= not (user_cfg_in_progress or dac_cfg_in_progress);
         user_cfg_rdy_pipe(7 downto 1) <= user_cfg_rdy_pipe(6 downto 0);
         user_cfg_rdy <= not (user_cfg_in_progress or dac_cfg_in_progress) and user_cfg_rdy_pipe(7); 
         
      end if;
   end process;
   
   ----------------------------------------------------------------------------
   -- CFG MB AXI RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U5: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_arready <= '0';
            axi_araddr  <= (others => '1');
            axi_rvalid <= '0';
            axi_rresp  <= "00";
         else
            if axi_arready = '0' and MB_MOSI.ARVALID = '1' then
               -- indicates that the slave has acceped the valid read address
               axi_arready <= '1';
               -- Read Address latching 
               axi_araddr  <= MB_MOSI.ARADDR;
            else
               axi_arready <= '0';
            end if;            
            if axi_arready = '1' and MB_MOSI.ARVALID = '1' and axi_rvalid = '0' then
               -- Valid read data is available at the read data bus
               axi_rvalid <= '1';
               axi_rresp  <= "00"; -- 'OKAY' response
            elsif axi_rvalid = '1' and MB_MOSI.RREADY = '1' then
               -- Read data is accepted by the master
               axi_rvalid <= '0';
            end if;
            
         end if;
      end if;
   end process; 
   slv_reg_rden <= axi_arready and MB_MOSI.ARVALID and (not axi_rvalid);
   
   ---------------------------------------------------------------------------- 
   -- CFG MB AXI RD : données vers µBlaze                                       
   ---------------------------------------------------------------------------- 
   U6: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then         
         
         if  MB_MOSI.ARADDR(10) = '1' and MB_MOSI.ARVALID = '1' then    -- adresse de base pour la lecture des statuts provenant du generateur de statuts
            axi_rdata <= STATUS_MISO.RDATA;    -- la donnée de statut est valide 1CLK après MB_MOSI.ARVALID            
            
         elsif MB_MOSI.ARADDR(11) = '1' and MB_MOSI.ARVALID = '1' then  -- adresse de base pour la lecture des statuts internes/privés (ne provenant pas du generateur de statuts)
            
            case MB_MOSI.ARADDR(7 downto 0) is 
               -- feedback de la config envoyée au MB pour validation visuelle via debug_terminal
               
               when X"00" =>  axi_rdata <= std_logic_vector(to_unsigned(integer(DEFINE_ADC_QUAD_CLK_SOURCE_RATE_KHZ)               , 32));           
               when X"04" =>  axi_rdata <= std_logic_vector(to_unsigned(integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ)             , 32));
               when X"08" =>  axi_rdata <= std_logic_vector(to_unsigned(integer(DEFINE_ADC_QUAD_CLK_RATE_KHZ)                      , 32));
               when X"0C" =>  axi_rdata <= std_logic_vector(to_unsigned(integer(DEFINE_FPA_NOMINAL_MCLK_RATE_HZ)                   , 32));
               
               when others =>                                                       
                  -- axi_rdata <= (others => '0');
               
            end case;
            
         else 
            axi_rdata <= (others =>'1'); 
         end if;
         
      end if;     
   end process;   
   
   ----------------------------------------------------------------------------
   -- CFG MB AXI WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U7: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_awready <= '0'; 
            axi_wready <= '0';
         else            
            
            if (axi_awready = '0' and MB_MOSI.AWVALID = '1' and MB_MOSI.WVALID = '1') then -- 
               axi_awready <= '1';
               axi_awaddr <= MB_MOSI.AWADDR;
            else
               axi_awready <= '0';
            end if;            
            if (axi_wready = '0' and MB_MOSI.WVALID = '1' and MB_MOSI.AWVALID = '1') then
               axi_wready <= '1';
            else
               axi_wready <= '0';
            end if;           			
            
         end if;
      end if;
   end process;
   slv_reg_wren <= axi_wready and MB_MOSI.WVALID and axi_awready and MB_MOSI.AWVALID ;
   data_i <= MB_MOSI.WDATA;
   axi_wstrb <= MB_MOSI.WSTRB;  -- requis car le MB envoie des chmps de header avec des strobes differents de "1111"; 
   
   -----------------------------------------------------
   -- CFG MB AXI WR  : WR feedback envoyé au MB
   -----------------------------------------------------
   U8: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_bvalid  <= '0';
            axi_bresp   <= "00"; -- need to work more on the responses
         else
            if slv_reg_wren = '1' and axi_bvalid = '0' then
               axi_bvalid <= '1';
               axi_bresp  <= "00"; 
            elsif MB_MOSI.BREADY = '1' and axi_bvalid = '1' then   -- check if bready is asserted while bvalid is high)
               axi_bvalid <= '0';                                  -- (there is a possibility that bready is always asserted high)
            end if;
         end if;
      end if;
   end process;
   
end rtl; 
