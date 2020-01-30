------------------------------------------------------------------
--!   @file : isc0804A_readout_kernel
--!   @brief
--!   @details
--!
--!   $Rev: 23158 $
--!   $Author: elarouche $
--!   $Date: 2019-04-02 16:09:55 -0400 (mar., 02 avr. 2019) $
--!   $Id: isc0207A_3k_readout_kernel.vhd 23158 2019-04-02 20:09:55Z elarouche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/FPA/isc0207A_3k/HDL/isc0207A_3k_readout_kernel.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.fpa_define.all;
use work.fpa_common_pkg.all; 

entity isc0207A_3k_readout_kernel is
   port(
      
      ARESET          : in std_logic;
      CLK             : in std_logic;
      
      FPA_INT         : in std_logic;
      START_GEN       : out std_logic; 
      
      FPA_INTF_CFG    : in fpa_intf_cfg_type; 
      
      -- horloges brutes
      SLOW_MCLK_RAW   : in std_logic;
      SLOW_PCLK_RAW   : in std_logic;
      FAST_MCLK_RAW   : in std_logic;
      FAST_PCLK_RAW   : in std_logic;
      
      -- fifos des horloges traitées      
      FAST_CLK_EN    : out std_logic;
      FAST_CLK_DATA   : in std_logic_vector(7 downto 0);
      FAST_CLK_DVAL   : in std_logic;
      
      CLK_FIFO_RDY    : in std_logic;    -- à '1' lorsque le fifo de l'horloge la plus lente est prête. Donc tous les fifoos sont prêts
      
      SLOW_CLK_EN     : out std_logic;
      SLOW_CLK_DATA   : in std_logic_vector(7 downto 0);
      SLOW_CLK_DVAL   : in std_logic;
      
      QUAD_CLK_COPY   : in std_logic;
      ADC_SYNC_FLAG   : out std_logic_vector(15 downto 0); -- ENO : 05 oct 2017: divers flags à synchroniser sur donnnées ADC même si READOUT_INFO est absent. Utile par exemple pour calculer offset dynamique
      
      FPA_MCLK        : out std_logic;
      FPA_PCLK        : out std_logic;
      READOUT_INFO    : out readout_info_type;
      
      ERR             : out std_logic;
      
      WDOW_FIFO_EMPTY : in std_logic;
      WDOW_FIFO_RDY   : in std_logic;
      WDOW_FIFO_EN    : out std_logic;
      WDOW_FIFO_DATA  : in window_info_type;
      WDOW_FIFO_DVAL  : in std_logic;
      
      RST_WDOW_GEN    : out std_logic;
      RAW_WINDOW      : out raw_area_type;
      
      REF_VALID       : in std_logic_vector(1 downto 0);
      IMG_IN_PROGRESS : out std_logic 
      
      );
end isc0207A_3k_readout_kernel;

architecture rtl of isc0207A_3k_readout_kernel is
   
   constant C_FLAG_PIPE_LEN  : integer := DEFINE_ADC_QUAD_CLK_FACTOR;
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component fwft_sfifo_w3_d16
      port (
         clk         : in std_logic;
         srst        : in std_logic;
         din         : in std_logic_vector(2 downto 0);
         wr_en       : in std_logic;
         rd_en       : in std_logic;
         dout        : out std_logic_vector(2 downto 0);
         full        : out std_logic;
         almost_full : out std_logic;
         overflow    : out std_logic;
         empty       : out std_logic;
         valid       : out std_logic
         );
   end component;
   
   type ctrl_fsm_type is (idle, wait_int_fe_st, lsydel_dly_st, wait_flows_st, stop_raw_clk_st, active_flow_st, sync_flow_st, adc_sync_st, prep_slow_clk_st, prep_fast_clk_st, slow_clk_en_st, rst_wdow_gen_st);   
   type adc_time_stamp_type is
   record
      naoi_stop  : std_logic;
      naoi_start : std_logic;  
      aoi_sof    : std_logic;  
      aoi_sol    : std_logic;     
   end record;
   
   signal fpa_pclk_i          : std_logic;
   signal fpa_mclk_i          : std_logic;
   signal adc_frame_flag_i    : std_logic;
   signal adc_line_flag_i     : std_logic;
   signal readout_info_i      : readout_info_type;
   signal fast_clk_fifo_rd_i  : std_logic;
   signal slow_clk_fifo_rd_i  : std_logic;
   signal sreset              : std_logic;
   signal err_i               : std_logic;
   signal slow_mclk_sof       : std_logic;
   signal slow_mclk_eof       : std_logic;
   signal slow_mclk           : std_logic;
   signal slow_pclk_sof       : std_logic;
   signal slow_pclk_eof       : std_logic;
   signal slow_pclk           : std_logic;
   signal fast_mclk_sof       : std_logic;
   signal fast_mclk_eof       : std_logic;
   signal fast_mclk           : std_logic;
   signal fast_pclk_sof       : std_logic;
   signal fast_pclk_eof       : std_logic;
   signal fast_pclk           : std_logic;
   signal quad_clk_copy_i     : std_logic;
   signal quad_clk_copy_last  : std_logic;
   signal ctrl_fsm            : ctrl_fsm_type;
   signal raw_window_i        : raw_area_type; 
   signal window_fifo_rd_i    : std_logic;
   signal imm_clk_sync_err    : std_logic;
   signal imm_sol_sync_err    : std_logic;
   signal start_gen_i         : std_logic;
   signal fpa_int_i           : std_logic := '0';
   signal fpa_int_last        : std_logic := '0';
   signal pause_cnt           : unsigned(FPA_INTF_CFG.LSYDEL_MCLK'LENGTH-1 downto 0);
   signal slow_mclk_raw_en_i  : std_logic := '0';
   signal fast_mclk_raw_en_i  : std_logic := '0';
   signal fpa_mclk_re         : std_logic;
   signal slow_mclk_raw_last  : std_logic;
   signal fast_mclk_raw_last  : std_logic;
   signal fpa_mclk_last       : std_logic;
   signal user_area_err       : std_logic;
   signal data_sync_err       : std_logic;
   signal line_pclk_cnt_last  : unsigned(WDOW_FIFO_DATA.RAW.LINE_PCLK_CNT'length-1 downto 0);
   signal mclk_pause_cnt      : natural range 0 to DEFINE_FPA_PCLK_RATE_FACTOR + 1;
   signal raw_fval_i          : std_logic := '0';
   signal raw_fval_last       : std_logic := '0';
   signal readout_info_valid  : std_logic;
   signal elcorr_ref_start_pipe : std_logic_vector(15 downto 0);
   signal elcorr_ref_end_pipe   : std_logic_vector(15 downto 0);
   signal elcorr_ref_end_i      : std_logic;
   signal elcorr_ref_start_i    : std_logic;
   signal quad_clk_fe_pipe    : std_logic_vector(15 downto 0) := (others => '0');
   --signal active_window_last  : std_logic;
   signal elcorr_ref_fval_i     : std_logic;
   signal rst_cnt_i             : unsigned(4 downto 0);
   signal rst_wdow_gen_i        : std_logic;
   signal elcorr_ref_enabled    : std_logic;
   signal fpa_mclk_fe           : std_logic;
   signal read_end_last         : std_logic;
   signal read_start_last       : std_logic;
   signal adc_time_stamp        : adc_time_stamp_type;
   signal int_fifo_rd           : std_logic;
   signal int_fifo_din          : std_logic_vector(2 downto 0);
   signal int_fifo_wr           : std_logic;
   signal int_fifo_dval         : std_logic;
   signal int_fifo_dout         : std_logic_vector(2 downto 0);
   signal img_in_progress_i     : std_logic;
   
   
   
begin
   
   --------------------------------------------------
   -- Outputs map
   --------------------------------------------------
   FAST_CLK_EN       <= fast_clk_fifo_rd_i;
   SLOW_CLK_EN       <= slow_clk_fifo_rd_i;
   FPA_MCLK          <= fpa_mclk_i;
   FPA_PCLK          <= fpa_pclk_i;
   RST_WDOW_GEN      <= rst_wdow_gen_i;
   
   -- ADC_SYNC_FLAG 
   -- Ces flags permettent un timestamping des samples des ADC en vue d'une synchro parfaite avec les flags contenues dans readout_info 
   ADC_SYNC_FLAG(15 downto 4)  <= (others => '0');   -- non utilisé
   ADC_SYNC_FLAG(3)  <= adc_time_stamp.naoi_stop;    -- pas obligatoire
   ADC_SYNC_FLAG(2)  <= adc_time_stamp.naoi_start;   -- adc time stamp obligatoire : naoi_start  (doit durer 1 CLK ADC)
   ADC_SYNC_FLAG(1)  <= adc_time_stamp.aoi_sof;      -- adc time stamp obligatoire : frame_flag  (doit durer 1 CLK ADC)
   ADC_SYNC_FLAG(0)  <= adc_time_stamp.aoi_sol;      -- adc time stamp obligatoire : line flag (doit durer 1 CLK ADC)
   
   READOUT_INFO  <= readout_info_i;
   WDOW_FIFO_EN <= window_fifo_rd_i;
   START_GEN <= start_gen_i;
   ERR <= err_i;
   IMG_IN_PROGRESS <= img_in_progress_i;
   
   -- pragma translate_off
   RAW_WINDOW <= raw_window_i;
   -- pragma translate_on
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   --------------------------------------------------
   --  decodage de la sortie du fifo des horloges
   --------------------------------------------------
   slow_mclk_sof <= SLOW_CLK_DATA(5); 
   slow_mclk_eof <= SLOW_CLK_DATA(4); 
   slow_mclk     <= SLOW_CLK_DATA(3); 
   slow_pclk_sof <= SLOW_CLK_DATA(2); 
   slow_pclk_eof <= SLOW_CLK_DATA(1); 
   slow_pclk     <= SLOW_CLK_DATA(0); 
   
   fast_mclk_sof <= FAST_CLK_DATA(5); 
   fast_mclk_eof <= FAST_CLK_DATA(4); 
   fast_mclk     <= FAST_CLK_DATA(3); 
   fast_pclk_sof <= FAST_CLK_DATA(2); 
   fast_pclk_eof <= FAST_CLK_DATA(1); 
   fast_pclk     <= FAST_CLK_DATA(0);
   
   --------------------------------------------------
   -- fifo fwft pour edges du signal d'intégration
   --------------------------------------------------   
   U3A : fwft_sfifo_w3_d16
   port map (
      clk         => CLK,
      srst        => sreset,
      din         => int_fifo_din,    -- not used
      wr_en       => int_fifo_wr,
      rd_en       => int_fifo_rd,
      dout        => int_fifo_dout,   -- not used
      full        => open,
      almost_full => open,
      overflow    => open,
      empty       => open,
      valid       => int_fifo_dval
      );
   
   ----------------  ----------------------------------
   --  lecture des fifos et synchronisation
   --------------------------------------------------
   U3B: process(CLK)
      variable inc : unsigned(1 downto 0);
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then            
            err_i <= '0';
            fast_clk_fifo_rd_i <= '0';
            slow_clk_fifo_rd_i <= '0';
            window_fifo_rd_i <= '0';
            ctrl_fsm <= idle;
            imm_sol_sync_err <= '0';
            imm_clk_sync_err <= '0';
            user_area_err <= '0';
            start_gen_i <= '0';
            readout_info_valid <= '0';
            rst_wdow_gen_i <= '1';
            fast_mclk_raw_en_i <= '0';
            elcorr_ref_enabled <= '0';
            int_fifo_wr <= '0';
            int_fifo_rd <= '0';
            img_in_progress_i <= '0'; 
            
         else  
            
            --inc := '0'& fpa_mclk_re;
            fpa_int_i <= FPA_INT;
            fpa_int_last <= fpa_int_i;
            
            int_fifo_din(1) <= not fpa_int_last and fpa_int_i;  -- front montant
            int_fifo_din(0) <= fpa_int_last and not fpa_int_i;  -- front descendant
            int_fifo_wr <= fpa_int_last xor fpa_int_i;          -- on ecrit les edges dans le fifo
            
            slow_mclk_raw_last <= SLOW_MCLK_RAW;            
            fast_mclk_raw_last <= FAST_MCLK_RAW;
            fpa_mclk_re <= not fpa_mclk_last and fpa_mclk_i;
            fpa_mclk_fe <= fpa_mclk_last and not fpa_mclk_i; 
            
            -----------------------------------------------------------------
            -- activation des flows de synchronisation                       
            -----------------------------------------------------------------
            case ctrl_fsm is
               
               when idle => 
                  if SLOW_MCLK_RAW = '0' and slow_mclk_raw_last = '1' then -- on s'assure qu'il n y a pas de pulse "tronqué" 
                     slow_mclk_raw_en_i <= '1';                               
                  end if;
                  rst_wdow_gen_i <= '0';
                  slow_clk_fifo_rd_i <= '0';
                  fast_clk_fifo_rd_i <= '0';
                  mclk_pause_cnt <= 1;
                  img_in_progress_i <= '0';                -- ENO 29 janv 2020: on s'assure que img_in_progress_i ne tombe à zero que si aucune image n'est en transaction
                  if int_fifo_dout(1) = '1' and int_fifo_dval = '1' then  -- front montant de int_signal via fifo. Il n'est pas en temps reel en IWR : il a eu lieu pendant un readout et enregistré dans un fifo.
                     start_gen_i <= '1';
                     int_fifo_rd <= '1';
                     img_in_progress_i <= '1';
                     ctrl_fsm <= wait_int_fe_st;
                  end if;                               
                  rst_cnt_i <= (others => '0'); 
                  pause_cnt <= (others => '0');                 
               
               when wait_int_fe_st =>
                  int_fifo_rd <= '0';
                  if int_fifo_dout(0) = '1' and int_fifo_dval = '1' then  -- front tombant de int_signal, il est quasiment en temps reel.
                     ctrl_fsm <= lsydel_dly_st;
                     int_fifo_rd <= '1';                     
                  end if;               
               
               when lsydel_dly_st =>
                  int_fifo_rd <= '0';
                  start_gen_i <= '0';
                  if fpa_mclk_re = '1' then
                     pause_cnt <= pause_cnt + 1;
                     if pause_cnt >= to_integer(FPA_INTF_CFG.LSYDEL_MCLK) then 
                        ctrl_fsm <= wait_flows_st;
                     end if;
                  end if;
               
               when wait_flows_st =>
                  if WDOW_FIFO_RDY = '1' and CLK_FIFO_RDY = '1' and fpa_mclk_re = '1' then  -- fpa_mclk_re assure une synchro
                     ctrl_fsm <= stop_raw_clk_st;
                  end if;
               
               when stop_raw_clk_st =>
                  elcorr_ref_enabled <= FPA_INTF_CFG.ELCORR_ENABLED;
                  if fpa_mclk_fe = '1' then 
                     slow_mclk_raw_en_i <= '0';    -- arrêt des horloges raw
                     ctrl_fsm <= active_flow_st; 
                  end if;
               
               when active_flow_st =>
                  slow_clk_fifo_rd_i <= not FPA_INTF_CFG.SPEEDUP_LSYNC;   -- lancement des horloges traitées
                  fast_clk_fifo_rd_i <= FPA_INTF_CFG.SPEEDUP_LSYNC;
                  window_fifo_rd_i <= '1';                                -- lancement du window fifo 
                  ctrl_fsm <= sync_flow_st;
               
               when sync_flow_st =>  -- ne pas changer l'ordre des étapes 1 et 2 car en cas de simulatneité la condition 2 doit prevaloir 
                  readout_info_valid <= '1';
                  if WDOW_FIFO_DATA.IMMINENT_CLK_CHANGE = '1' then      -- etape1: voir changement d'horloge
                     fast_clk_fifo_rd_i <= not fast_clk_fifo_rd_i ;
                     slow_clk_fifo_rd_i <= not slow_clk_fifo_rd_i;
                  end if;
                  if WDOW_FIFO_DATA.USER.IMMINENT_SOL = '1'  then        -- etape2: l'entrée dans la zone user se fera à phase constante par rapport à l'horloge des ADCs
                     if quad_clk_fe_pipe(0) = '0' then                              -- si on n'est pas synchro déjà alors on s'en va se synchroniser sur quad_clk_fe_pipe(0) avant de sortir SOL
                        fast_clk_fifo_rd_i    <= '0' ;
                        slow_clk_fifo_rd_i    <= '0';
                        window_fifo_rd_i <= '0';
                        ctrl_fsm <= adc_sync_st;
                     else                                                           -- sinon, c'est qu'on est déjà synchro avec quad_clk_fe_pipe(FASTRD_SYNC_POS), alors on ne fait rien de particulier
                     end if;
                  end if;                     
                  if readout_info_i.aoi.read_end = '1' then                 -- etape3: détecter la fin de la fenetre 
                     ctrl_fsm <= slow_clk_en_st;
                     readout_info_valid <= '0';
                  end if;
               
               when adc_sync_st =>      -- synchro avec quad_clk_copy_i et donc avec l'horloge des ADCs. Attention ne marchera parfiatement que si on prend un échantillon par pixel!!
                  if quad_clk_fe_pipe(0) = '1' then   -- la valeur de delai (x) vient de la simulation en vue de reduire les delais
                     ctrl_fsm <= sync_flow_st;
                     slow_clk_fifo_rd_i <= WDOW_FIFO_DATA.SLOW_CLK_EN;
                     fast_clk_fifo_rd_i <= WDOW_FIFO_DATA.FAST_CLK_EN; -- normalement à '0' dans user_area
                     window_fifo_rd_i <= WDOW_FIFO_DATA.FAST_CLK_EN or WDOW_FIFO_DATA.SLOW_CLK_EN;
                     --readout_info_valid <= '1';
                  end if;
               
               when slow_clk_en_st =>
                  window_fifo_rd_i <= '0';                        -- le window fifo est arrêté
                  if SLOW_MCLK_RAW = '0' and slow_mclk_raw_last = '1' then -- on s'assure qu'il n y a pas de pulse "tronqué" 
                     slow_mclk_raw_en_i <= '1';                               
                  end if;
                  slow_clk_fifo_rd_i <= '0';                     -- on descative les clocks traités
                  fast_clk_fifo_rd_i <= '0';                     -- on descative les clocks traités
                  if slow_mclk_raw_en_i = '1' then
                     ctrl_fsm <= prep_fast_clk_st; 
                  end if;                  
               
               when prep_fast_clk_st =>                  
                  fast_clk_fifo_rd_i <= not fast_mclk_eof;        -- le fast_clk_fifo est préparé pour la prochaine syncronisation.
                  if fast_mclk_eof = '1' then
                     ctrl_fsm <= prep_slow_clk_st;
                  end if;
               
               when prep_slow_clk_st =>                  
                  slow_clk_fifo_rd_i <= not slow_mclk_eof;        -- le slow_clk_fifo est préparé pour la prochaine syncronisation.
                  if slow_mclk_eof = '1' then
                     ctrl_fsm <= rst_wdow_gen_st;
                  end if;
               
               when rst_wdow_gen_st =>    -- 
                  rst_wdow_gen_i <= '1';                          -- le upstream subit un reset 
                  rst_cnt_i <= rst_cnt_i + 1;
                  if rst_cnt_i(3) = '1' then
                     ctrl_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
            --------------------------------------------------------------
            -- misc
            -------------------------------------------------------------- 
            user_area_err <= WDOW_FIFO_DATA.USER.DVAL and WDOW_FIFO_DATA.FAST_CLK_EN; -- erreur grave! 
            imm_sol_sync_err <= not (slow_pclk_eof or fast_pclk_eof) and WDOW_FIFO_DATA.USER.IMMINENT_SOL;
            imm_clk_sync_err <= not (slow_pclk_eof or fast_pclk_eof) and WDOW_FIFO_DATA.IMMINENT_CLK_CHANGE;
            
            err_i <= imm_sol_sync_err or imm_clk_sync_err or user_area_err or data_sync_err;  -- erreur qui ne doit jamais arriver
            
         end if;
      end if;
   end process; 
   
   ----------------------------------------------------
   --  sortie des données
   --------------------------------------------------
   U4: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            elcorr_ref_fval_i <= '0';
            elcorr_ref_start_pipe <= (others => '0');
            elcorr_ref_end_pipe <= (others => '0');
            elcorr_ref_start_i <= '0';
            elcorr_ref_end_i <= '0';
            
            -- pragma translate_off                
            raw_window_i <= WDOW_FIFO_DATA.RAW;
            line_pclk_cnt_last <= WDOW_FIFO_DATA.RAW.LINE_PCLK_CNT;
            if WDOW_FIFO_DATA.RAW.LINE_PCLK_CNT /= line_pclk_cnt_last then
               data_sync_err <= (slow_clk_fifo_rd_i and not slow_pclk_sof) or (fast_clk_fifo_rd_i and not fast_pclk_sof);
            end if;             
            readout_info_i.aoi.samp_pulse <= '0';
            readout_info_i.naoi.dval <= '0';
            readout_info_i.naoi.samp_pulse <= '0';
            quad_clk_copy_last <= '0';
            quad_clk_copy_i <= '0';
            line_pclk_cnt_last <= (others => '0');
            data_sync_err <= '0';
            quad_clk_fe_pipe <= (others => '0');
            -- pragma translate_on
            read_start_last <= '0';
            read_end_last <= '0';
            
         else 
            
            -- Clocks 
            fpa_mclk_i <= (slow_mclk and slow_clk_fifo_rd_i) or (fast_mclk and fast_clk_fifo_rd_i) or (SLOW_MCLK_RAW and slow_mclk_raw_en_i) or (FAST_MCLK_RAW and fast_mclk_raw_en_i); 
            fpa_pclk_i <= (slow_pclk and slow_clk_fifo_rd_i) or (fast_pclk and fast_clk_fifo_rd_i) or (SLOW_PCLK_RAW and slow_mclk_raw_en_i) or (FAST_PCLK_RAW and fast_mclk_raw_en_i) ;
            
            fpa_mclk_last <= fpa_mclk_i;
            
            -- 
            read_end_last <= readout_info_i.aoi.read_end;
            read_start_last <= readout_info_i.aoi.sof;
            
            -- elcorr_ref_start_i dure 1 PCLK             
            elcorr_ref_start_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_ref_start_pipe(C_FLAG_PIPE_LEN-2 downto 0) & (fpa_int_last and not fpa_int_i); -- Attention! le falling de Int = debut de elc_ofs.
            if unsigned(elcorr_ref_start_pipe) /= 0 then
               elcorr_ref_start_i <= '1';
               elcorr_ref_fval_i  <= '1'; 
            else
               elcorr_ref_start_i <= '0';
            end if;
            
            -- elcorr_ref_end_i dure 1 PCLK
            elcorr_ref_end_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_ref_end_pipe(C_FLAG_PIPE_LEN-2 downto 0) & (not read_start_last and readout_info_i.aoi.sof); -- Attention! le sof  = fin de elc_ofs.
            if unsigned(elcorr_ref_end_pipe) /= 0 then
               elcorr_ref_end_i <= '1';
            else
               elcorr_ref_end_i  <= '0';
               if elcorr_ref_end_i = '1' then 
                  elcorr_ref_fval_i <= '0';
               end if;
            end if;
            
            -- samp_pulse_i 
            quad_clk_copy_i <= QUAD_CLK_COPY;
            quad_clk_copy_last <= quad_clk_copy_i;
            quad_clk_fe_pipe(0) <= quad_clk_copy_last and not quad_clk_copy_i;
            quad_clk_fe_pipe(15 downto 1) <= quad_clk_fe_pipe(14 downto 0);
            
            -- definition de read_end à la fin de RAW.FVAL et non USER.FVAL
            raw_fval_i    <= WDOW_FIFO_DATA.RAW.FVAL;
            raw_fval_last <= raw_fval_i;         
            
            -- READOUT_INFO
            -- aoi
            readout_info_i.aoi.sof           <= WDOW_FIFO_DATA.USER.SOF and window_fifo_rd_i;
            readout_info_i.aoi.eof           <= WDOW_FIFO_DATA.USER.EOF and window_fifo_rd_i;
            readout_info_i.aoi.sol           <= WDOW_FIFO_DATA.USER.SOL and window_fifo_rd_i;
            readout_info_i.aoi.eol           <= WDOW_FIFO_DATA.USER.EOL and window_fifo_rd_i;
            readout_info_i.aoi.fval          <= WDOW_FIFO_DATA.USER.FVAL and readout_info_valid;                -- pas de window_fifo_rd_i  sur fval sinon pb.
            readout_info_i.aoi.lval          <= WDOW_FIFO_DATA.USER.LVAL and window_fifo_rd_i;
            readout_info_i.aoi.dval          <= WDOW_FIFO_DATA.USER.DVAL and window_fifo_rd_i;
            readout_info_i.aoi.read_end      <= raw_fval_last and not raw_fval_i;                               -- raw_fval_i pour etre certain d'avoir détecté la fin de la fenetre raw. Sinon, l'offset dynamique pourrait se calculer durant le passage de l'horloge rapide. Et ce sera la catastrophe.
            readout_info_i.aoi.samp_pulse    <= quad_clk_fe_pipe(0) and WDOW_FIFO_DATA.USER.FVAL and readout_info_valid;
            
            -- naoi (contenu aussi dans readout_info)
            readout_info_i.naoi.ref_valid(1) <= REF_VALID(1);        -- le Rising_edge = start du voltage reference(1) et falling edge = fin du voltage refrence(1)
            readout_info_i.naoi.ref_valid(0) <= REF_VALID(0);        -- le Rising_edge = start du voltage reference(0) et falling edge = fin du voltage refrence(0)
            readout_info_i.naoi.start        <= elcorr_ref_start_i;  -- start global de zone naoi
            readout_info_i.naoi.stop         <= elcorr_ref_end_i;    -- end global de zone naoi
            readout_info_i.naoi.dval         <= elcorr_ref_fval_i;
            readout_info_i.naoi.samp_pulse   <= quad_clk_fe_pipe(0) and elcorr_ref_fval_i;
            
            readout_info_i.samp_pulse        <= quad_clk_fe_pipe(0);
            
            -- ADC_FLAGS
            -- flags temps reel enovoyés vers le synchronisateur d'adc pour time stamping des données ADC
            adc_time_stamp.naoi_start        <= elcorr_ref_start_i and elcorr_ref_fval_i and DEFINE_GENERATE_ELCORR_CHAIN;
            adc_time_stamp.naoi_stop         <= elcorr_ref_end_i and elcorr_ref_fval_i and DEFINE_GENERATE_ELCORR_CHAIN;
            adc_time_stamp.aoi_sof           <= WDOW_FIFO_DATA.USER.SOF and window_fifo_rd_i;
            adc_time_stamp.aoi_sol           <= WDOW_FIFO_DATA.USER.SOL and window_fifo_rd_i;
            
         end if; 
      end if;
   end process;    
   
end rtl;
