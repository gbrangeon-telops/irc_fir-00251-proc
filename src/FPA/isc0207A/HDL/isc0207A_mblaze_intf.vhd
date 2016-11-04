------------------------------------------------------------------
--!   @file : isc0207A_mblaze_intf
--!   @brief
--!   @details
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
use work.tel2000.all;
use work.FPA_define.all;
use work.fpa_common_pkg.all;


entity isc0207A_mblaze_intf is
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
      
      FPA_DRIVER_STAT       : in std_logic_vector(31 downto 0);
      
      FPA_INTF_CFG          : out fpa_intf_cfg_type;
      COOLER_STAT           : out fpa_cooler_stat_type;
      
      FPA_SOFTW_STAT        : out fpa_firmw_stat_type      
      );
end isc0207A_mblaze_intf; 

architecture rtl of isc0207A_mblaze_intf is  
   
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_26  : natural := DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS + 26; --pour un total de 26 bits pour le temps d'integration de 0207
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1   : natural := DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS - 1;   
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   type exp_indx_pipe_type is array (0 to 3) of std_logic_vector(7 downto 0);
   type exp_time_pipe_type is array (0 to 3) of unsigned(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_26 downto 0);
   
   signal exp_time_pipe                : exp_time_pipe_type; 
   signal sreset_mb_clk                : std_logic;
   signal axi_awaddr	                     : std_logic_vector(31 downto 0);
   signal axi_awready	                  : std_logic;
   signal axi_wready	                     : std_logic;
   signal axi_bresp	                     : std_logic_vector(1 downto 0);
   signal axi_bvalid	                     : std_logic;
   signal axi_araddr	                     : std_logic_vector(31 downto 0);
   signal axi_arready	                  : std_logic;
   signal axi_rdata	                     : std_logic_vector(31 downto 0);
   signal axi_rresp	                     : std_logic_vector(1 downto 0);
   signal axi_rvalid	                     : std_logic;
   signal axi_wstrb                       : std_logic_vector(3 downto 0);  
   signal stat_rd_add                  : std_logic_vector(31 downto 0); 
   signal stat_rd_data                 : std_logic_vector(31 downto 0);
   signal stat_rd_en                   : std_logic := '0';
   signal stat_rd_dval                 : std_logic;
   signal slv_reg_rden                    : std_logic;
   signal slv_reg_wren                    : std_logic;
   signal fpa_intf_cfg_i               : fpa_intf_cfg_type; 
   signal data_i                          : std_logic_vector(31 downto 0);
   signal permit_inttime_change        : std_logic;
   signal update_cfg                   : std_logic;
   signal user_cfg_in_progress         : std_logic := '0';
   signal user_cfg                     : fpa_intf_cfg_type;
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
   signal tri_min                      : integer;
   signal tri_int_part                 : integer;
   signal exp_time_reg                 : unsigned(30 downto 0);
   
   attribute dont_touch                         : string;
   attribute dont_touch of fpa_softw_stat_i     : signal is "true";
   attribute dont_touch of user_cfg             : signal is "true";
   attribute dont_touch of user_cfg_in_progress : signal is "true";
   attribute dont_touch of fpa_intf_cfg_i       : signal is "true";
   attribute dont_touch of tri_min              : signal is "true";
   attribute dont_touch of tri_int_part         : signal is "true";
   attribute dont_touch of exp_time_reg         : signal is "true";
   
begin   
   
   
   FPA_INTF_CFG <= fpa_intf_cfg_i; 
   CTRLED_RESET <= ctrled_reset_i;
   RESET_ERR <= reset_err_i;
   FPA_SOFTW_STAT <= fpa_softw_stat_i;
   COOLER_STAT.COOLER_ON <= '1';     
   
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U1 : sync_reset
   port map(ARESET => ARESET, CLK => MB_CLK, SRESET => sreset); 
   
   ------------------------------------------------  
   -- sortie de la config                              
   -------------------------------------------------  
   U2: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then  
         permit_inttime_change <= FPA_DRIVER_STAT(7);
         update_cfg <= permit_inttime_change and  user_cfg_rdy;
         
         if update_cfg = '1' then -- la config au complet 
            fpa_intf_cfg_i <= user_cfg;          
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
            
         else                   
            
            ctrled_reset_i <= '0';            
            
            -- temps d'exposition  en mclk
            if int_dval_i = '1' then
               user_cfg.int_time <= int_time_i;
               user_cfg.int_indx <= int_indx_i;
               user_cfg.int_signal_high_time <= int_signal_high_time_i;
            end if;
            
            -- veritable calcul des delais : seul fpa_acq_trig_ctrl_dly et fpa_xtra_trig_ctrl_dly sont importants pour le mode MODE_INT_END_TO_TRIG_START des detecteurs analogiques
            user_cfg.comn.fpa_acq_trig_ctrl_dly    <=  to_unsigned(to_integer(user_cfg.readout_plus_delay) + tri_min, user_cfg.comn.fpa_acq_trig_ctrl_dly'length);      -- delai entre la fin de l'integration et le debut du prochain trig
            user_cfg.comn.fpa_acq_trig_period_min  <=  user_cfg.comn.fpa_acq_trig_ctrl_dly  ;     --  pas utilisé en mode MODE_INT_END_TO_TRIG_START avec les détecteurs analogiques. Donc n,importe quelle valeur fera l'affaire
            user_cfg.comn.fpa_xtra_trig_ctrl_dly   <=  to_unsigned(to_integer(user_cfg.readout_plus_delay) + tri_min, user_cfg.comn.fpa_xtra_trig_ctrl_dly'length);      -- delai entre la fin de l'integration et le debut du prochain trig
            user_cfg.comn.fpa_xtra_trig_period_min <=  user_cfg.comn.fpa_xtra_trig_ctrl_dly  ;      --  pas utilisé en mode MODE_INT_END_TO_TRIG_START avec les détecteurs analogiques. Donc n,importe quelle valeur fera l'affaire
            
            -- reste de la config
            if slv_reg_wren = '1' and axi_wstrb =  "1111" then  
               case axi_awaddr(7 downto 0) is             
                  
                  -- comn                                                                                              
                  when X"00" =>    user_cfg.comn.fpa_diag_mode               <= data_i(0); user_cfg_in_progress <= '1';                       
                  when X"04" =>    user_cfg.comn.fpa_diag_type               <= data_i(user_cfg.comn.fpa_diag_type'length-1 downto 0); 
                  when X"08" =>    user_cfg.comn.fpa_pwr_on                  <= data_i(0);						
                  when X"0C" =>    user_cfg.comn.fpa_trig_ctrl_mode          <= data_i(user_cfg.comn.fpa_trig_ctrl_mode'length-1 downto 0);
                  when X"10" =>    user_cfg.comn.fpa_acq_trig_ctrl_dly       <= unsigned(data_i(user_cfg.comn.fpa_acq_trig_ctrl_dly'length-1 downto 0));    --ici la valeur que contient le registre est insensée						
                  when X"14" =>    user_cfg.comn.fpa_acq_trig_period_min     <= unsigned(data_i(user_cfg.comn.fpa_acq_trig_period_min'length-1 downto 0));  -- ici la valeur que contient le registre est insensée				                                   
                  when X"18" =>    user_cfg.comn.fpa_xtra_trig_ctrl_dly      <= unsigned(data_i(user_cfg.comn.fpa_xtra_trig_ctrl_dly'length-1 downto 0));   -- ici la valeur que contient le registre est insensée				                                  
                  when X"1C" =>    user_cfg.comn.fpa_xtra_trig_period_min    <= unsigned(data_i(user_cfg.comn.fpa_xtra_trig_period_min'length-1 downto 0)); -- ici la valeur que contient le registre est insensée				                                     
                     
                  -- non comn
                  when X"20" =>    user_cfg.xstart                          <= unsigned(data_i(user_cfg.xstart'length-1 downto 0));
                  when X"24" =>    user_cfg.ystart                          <= unsigned(data_i(user_cfg.ystart'length-1 downto 0));
                  when X"28" =>    user_cfg.xsize                           <= unsigned(data_i(user_cfg.xsize'length-1 downto 0));
                  when X"2C" =>    user_cfg.ysize                           <= unsigned(data_i(user_cfg.ysize'length-1 downto 0));
                  when X"30" =>    user_cfg.gain                            <= data_i(0);
                  when X"34" =>    user_cfg.invert                          <= data_i(0);
                  when X"38" =>    user_cfg.revert                          <= data_i(0);
                  when X"3C" =>    user_cfg.onchip_bin_256                  <= data_i(0);
                  when X"40" =>    user_cfg.onchip_bin_128                  <= data_i(0);
                  when X"44" =>    user_cfg.pix_samp_num_per_ch             <= unsigned(data_i(user_cfg.pix_samp_num_per_ch'length-1 downto 0));
                  when X"48" =>    user_cfg.good_samp_first_pos_per_ch      <= unsigned(data_i(user_cfg.good_samp_first_pos_per_ch'length-1 downto 0));
                  when X"4C" =>    user_cfg.good_samp_last_pos_per_ch       <= unsigned(data_i(user_cfg.good_samp_last_pos_per_ch'length-1 downto 0));
                  when X"50" =>    user_cfg.good_samp_sum_num               <= unsigned(data_i(user_cfg.good_samp_sum_num'length-1 downto 0));
                  when X"54" =>    user_cfg.good_samp_mean_numerator        <= unsigned(data_i(user_cfg.good_samp_mean_numerator'length-1 downto 0));
                  when X"58" =>    user_cfg.good_samp_mean_div_bit_pos      <= unsigned(data_i(user_cfg.good_samp_mean_div_bit_pos'length-1 downto 0));
                  when X"5C" =>    user_cfg.ysize_div2_m1                   <= unsigned(data_i(user_cfg.ysize_div2_m1'length-1 downto 0));
                  when X"60" =>    user_cfg.img_samp_num                    <= unsigned(data_i(user_cfg.img_samp_num'length-1 downto 0));
                  when X"64" =>    user_cfg.img_samp_num_per_ch             <= unsigned(data_i(user_cfg.img_samp_num_per_ch'length-1 downto 0));
                  when X"68" =>    user_cfg.fpa_active_pixel_dly            <= unsigned(data_i(user_cfg.fpa_active_pixel_dly'length-1 downto 0));
                  when X"6C" =>    user_cfg.diag_active_pixel_dly           <= unsigned(data_i(user_cfg.diag_active_pixel_dly'length-1 downto 0));
                  when X"70" =>    user_cfg.sof_samp_pos_start_per_ch       <= unsigned(data_i(user_cfg.sof_samp_pos_start_per_ch'length-1 downto 0));
                  when X"74" =>    user_cfg.sof_samp_pos_end_per_ch         <= unsigned(data_i(user_cfg.sof_samp_pos_end_per_ch'length-1 downto 0));
                  when X"78" =>    user_cfg.eof_samp_pos_start_per_ch       <= unsigned(data_i(user_cfg.eof_samp_pos_start_per_ch'length-1 downto 0));
                  when X"7C" =>    user_cfg.eof_samp_pos_end_per_ch         <= unsigned(data_i(user_cfg.eof_samp_pos_end_per_ch'length-1 downto 0));
                  when X"80" =>    user_cfg.diag_tir                        <= unsigned(data_i(user_cfg.diag_tir'length-1 downto 0));
                  when X"84" =>    user_cfg.xsize_div_tapnum                <= unsigned(data_i(user_cfg.xsize_div_tapnum'length-1 downto 0));  
                  
                  when X"88" =>    user_cfg.readout_plus_delay              <= unsigned(data_i(user_cfg.readout_plus_delay'length-1 downto 0));  
                  when X"8C" =>    user_cfg.tri_window_and_intmode_part     <= unsigned(data_i(user_cfg.tri_window_and_intmode_part'length-1 downto 0));  
                  when X"90" =>    user_cfg.int_time_offset                 <= unsigned(data_i(user_cfg.int_time_offset'length-1 downto 0)); 
                  when X"94" =>    user_cfg.tsh_min                         <= unsigned(data_i(user_cfg.tsh_min'length-1 downto 0));
                  when X"98" =>    user_cfg.tsh_min_minus_int_time_offset   <= unsigned(data_i(user_cfg.tsh_min_minus_int_time_offset'length-1 downto 0)); 
                  when X"9C" =>    user_cfg.adc_clk_phase                   <= unsigned(data_i(user_cfg.adc_clk_phase'length-1 downto 0)); user_cfg_in_progress <= '0';
                  
                     
                  -- fpa_softw_stat_i qui dit au sequenceur general quel pilote C est en utilisation
                  when X"E0" =>    fpa_softw_stat_i.fpa_roic                <= data_i(fpa_softw_stat_i.fpa_roic'length-1 downto 0);
                  when X"E4" =>    fpa_softw_stat_i.fpa_output              <= data_i(fpa_softw_stat_i.fpa_output'length-1 downto 0);  
                  when X"E8" =>    fpa_softw_stat_i.fpa_input               <= data_i(fpa_softw_stat_i.fpa_input'length-1 downto 0); fpa_softw_stat_i.dval <='1';  
                     
                  -- pour effacer erreurs latchées
                  when X"EC" =>    reset_err_i                              <= data_i(0); 
                     
                  -- pour un reset complet du module FPA
                  when X"F0" =>   ctrled_reset_i                            <= data_i(0); fpa_softw_stat_i.dval <='0'; -- ENO: 10 juin 2015: ce reset permet de mettre la sortie vers le DDC en 'Z' lorsqu'on etient la carte DDC et permet de faire un reset lorsqu'on allume la carte DDC
                      
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
         
         -- pipe pour le calcul du temps d'integration en mclk
         exp_time_pipe(0) <= resize(FPA_EXP_INFO.EXP_TIME, exp_time_pipe(0)'length) ;
         exp_time_pipe(1) <= resize(exp_time_pipe(0) * DEFINE_FPA_EXP_TIME_CONV_NUMERATOR, exp_time_pipe(0)'length);          
         exp_time_pipe(2) <= resize(exp_time_pipe(1)(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_26 downto DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS), exp_time_pipe(0)'length);  -- soit une division par 2^EXP_TIME_CONV_DENOMINATOR
         exp_time_pipe(3) <= exp_time_pipe(2) + resize("00"& exp_time_pipe(1)(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1), exp_time_pipe(0)'length);  -- pour l'operation d'arrondi
         int_time_i <= exp_time_pipe(3)(int_time_i'length-1 downto 0);
         int_signal_high_time_i <= exp_time_pipe(3)(int_time_i'length-1 downto 0) + DEFINE_FPA_INT_TIME_OFFSET_FACTOR; -- int_signal_high_time est parfaitement synchrosnié avec in_time_i
         
         -- pipe de synchro pour l'index           
         exp_indx_pipe(0) <= FPA_EXP_INFO.EXP_INDX;
         exp_indx_pipe(1) <= exp_indx_pipe(0); 
         exp_indx_pipe(2) <= exp_indx_pipe(1); 
         exp_indx_pipe(3) <= exp_indx_pipe(2); 
         int_indx_i       <= exp_indx_pipe(3);
         
         -- pipe pour valider la donnée qques CLKs apres sa sortie
         exp_dval_pipe(0) <= FPA_EXP_INFO.EXP_DVAL;
         exp_dval_pipe(1) <= exp_dval_pipe(0); 
         exp_dval_pipe(2) <= exp_dval_pipe(1); 
         exp_dval_pipe(3) <= exp_dval_pipe(2);
         exp_dval_pipe(4) <= exp_dval_pipe(3);
         exp_dval_pipe(5) <= exp_dval_pipe(4);
         int_dval_i       <= exp_dval_pipe(5);         
         
      end if;
   end process; 
   
   ------------------------------------------------  
   -- calcul des parametres de frame rate
   -------------------------------------------------
   U4B: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         
         if FPA_EXP_INFO.EXP_DVAL = '1' then
            exp_time_reg <= FPA_EXP_INFO.EXP_TIME(exp_time_reg'length-1 downto 0);
         end if;
         
         -- calcul de tri_int_part             
         tri_int_part <= to_integer(user_cfg.tsh_min_minus_int_time_offset) - to_integer(exp_time_reg);
         
         -- calcul final du tri_min
         if tri_int_part > to_integer(user_cfg.tri_window_and_intmode_part) then
            tri_min <= tri_int_part;
         else      
            tri_min <= to_integer(user_cfg.tri_window_and_intmode_part); 
         end if;
         
         -- user_cfg_rdy
         user_cfg_rdy_pipe(0) <= not user_cfg_in_progress;
         user_cfg_rdy_pipe(7 downto 1) <= user_cfg_rdy_pipe(6 downto 0);
         user_cfg_rdy <= not user_cfg_in_progress and user_cfg_rdy_pipe(7);
                  
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
         
         --if  MB_MOSI.ARADDR(10) = '1' then    -- adresse de base pour la lecture des statuts
         axi_rdata <= STATUS_MISO.RDATA; -- la donnée de statut est valide 1CLK après MB_MOSI.ARVALID            
         --else 
         --axi_rdata <= (others =>'1'); 
         --end if;
         
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