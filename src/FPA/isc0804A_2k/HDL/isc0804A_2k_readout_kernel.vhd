------------------------------------------------------------------
--!   @file : isc0804A_2k_readout_kernel
--!   @brief
--!   @details
--!
--!   $Rev: 27310 $
--!   $Author: enofodjie $
--!   $Date: 2022-04-07 16:46:48 -0400 (jeu., 07 avr. 2022) $
--!   $Id: isc0804A_2k_readout_kernel.vhd 27310 2022-04-07 20:46:48Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00272-FleG/trunk/src/FPA/isc0804A_2k/HDL/isc0804A_2k_readout_kernel.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.fpa_define.all;
use work.fpa_common_pkg.all;
use work.fastrd2_define.all;

entity isc0804A_2k_readout_kernel is
   port(
      
      ARESET         : in std_logic;
      CLK            : in std_logic;  
      
      -- statut de l'integrateur
      FPA_INT            : in std_logic;  -- requis pour ScorpioMW puisque les signaux LSYNC et autres sont generés à la fin de la consigne d'integration (Montée de FSYNC)
      ACQ_INT            : in std_logic;  -- requis pour determiner ACQ_DATA
      
      FPA_INTF_CFG       : in fpa_intf_cfg_type; 
      
      
      -- correction electronique
      ELCORR_REF_VALID   : in std_logic_vector(1 downto 0);
      
      -- horloge brute non contrôlée
      NOMINAL_MCLK_RAW   : in std_logic;
      FAST_MCLK_RAW      : in std_logic; 
      
      -- horloge adc    
      ADC_REF_CLK        : in std_logic;
      
      -- fifo des données et horloges      
      AREA_FIFO_EMPTY    : in std_logic;
      AREA_FIFO_RD       : out std_logic;
      AREA_FIFO_DATA     : in area_info_type;
      AREA_FIFO_DVAL     : in std_logic;
      
      -- outputs
      ADC_SYNC_FLAG      : out std_logic_vector(15 downto 0);      
      FPA_MCLK           : out std_logic;
      FPA_PCLK           : out std_logic;
      FPA_LSYNC          : out std_logic;
      READOUT_INFO       : out readout_info_type;
      
      GEN_START          : out std_logic;
      GEN_DONE           : in std_logic;
      GEN_RST            : out std_logic;
      
      RAW_WINDOW         : out area_type;                        
      IMG_IN_PROGRESS    : out std_logic;
      ERR                : out std_logic_vector(1 downto 0)       
      );
end isc0804A_2k_readout_kernel;

architecture rtl of isc0804A_2k_readout_kernel is
   
   constant C_FLAG_PIPE_LEN  : integer := 16;
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
      
   type ctrl_fsm_type is (idle, chck_lsydel_speed_st, speedup_lsydel_clk_st, lsydel_dly_st, wait_flows_st, stop_raw_clk_st, active_flow_st, sync_flow_st, adc_sync_st, raw_clk_en_st, rst_gen_st);   
   type adc_time_stamp_type is
   record
      naoi_stop  : std_logic;
      naoi_start : std_logic;
      aoi_eof    : std_logic;
      aoi_sof    : std_logic;  
      aoi_sol    : std_logic;     
   end record;
   
   signal nominal_mclk_raw_last   : std_logic;  
   signal fpa_mclk_i          : std_logic;
   signal nominal_mclk_raw_en_i    : std_logic;
   signal fast_mclk_raw_en_i       : std_logic;
   signal adc_frame_flag_i    : std_logic;
   signal adc_line_flag_i     : std_logic;
   signal readout_info_i      : readout_info_type;
   signal sreset              : std_logic;
   signal err_i               : std_logic_vector(1 downto 0);
   signal adc_ref_clk_i       : std_logic;
   signal adc_ref_clk_last    : std_logic;
   signal ctrl_fsm            : ctrl_fsm_type;
   signal raw_window_i        : area_type; 
   signal area_fifo_rd_i      : std_logic;
   signal imm_clk_sync_err    : std_logic;
   signal imm_sol_sync_err    : std_logic;
   signal gen_start_i         : std_logic;
   signal fpa_int_i           : std_logic := '0';
   signal fpa_int_last        : std_logic := '0';
   signal pause_cnt           : unsigned(FPA_INTF_CFG.LSYDEL_MCLK'LENGTH-1 downto 0);
   signal fpa_mclk_re         : std_logic;
   signal fpa_mclk_last       : std_logic;
   signal user_area_err       : std_logic;
   signal data_sync_err       : std_logic;
   signal line_pclk_cnt_last  : unsigned(AREA_FIFO_DATA.RAW.LINE_PCLK_CNT'length-1 downto 0);
   signal raw_fval_i          : std_logic := '0';
   signal raw_fval_last       : std_logic := '0';
   signal fpa_lsync_i         : std_logic;
   signal readout_info_valid  : std_logic;
   signal elcorr_ref_start_pipe : std_logic_vector(15 downto 0);
   signal elcorr_ref_end_pipe   : std_logic_vector(15 downto 0);
   signal elcorr_ref_end_i      : std_logic;
   signal elcorr_ref_start_i    : std_logic;
   signal adc_ref_fe_pipe      : std_logic_vector(15 downto 0) := (others => '0');
   signal acq_int_i             : std_logic;
   signal acq_int_last          : std_logic;
   signal elcorr_ref_fval_i     : std_logic;
   signal rst_cnt_i             : unsigned(4 downto 0);
   signal gen_rst_i             : std_logic;
   signal elcorr_ref_enabled    : std_logic;
   signal fpa_mclk_fe           : std_logic;
   signal read_end_last         : std_logic;
   signal read_start_last       : std_logic;
   signal adc_time_stamp        : adc_time_stamp_type;
   signal img_in_progress_i     : std_logic;
   signal acq_data_o            : std_logic;  -- dit si les données associées aux flags sont à envoyer dans la chaine ou pas.
   signal flow_err              : std_logic;
   signal wait_cnt              : unsigned(7 downto 0);
   signal elcorr_tic            : std_logic;
   signal elcorr_tac            : std_logic; 
   
begin
   
   --------------------------------------------------
   -- Outputs map
   --------------------------------------------------
   FPA_MCLK          <= fpa_mclk_i;
   FPA_LSYNC         <= fpa_lsync_i;
   GEN_RST           <= gen_rst_i;
   
   -- ADC_SYNC_FLAG 
   -- Ces flags permettent un timestamping des samples des ADC en vue d'une synchro parfaite avec les flags contenues dans readout_info 
   ADC_SYNC_FLAG(15 downto 6)  <= (others => '0');   -- non utilisé
   ADC_SYNC_FLAG(5)  <= adc_ref_clk_i;               -- clock de reference des ADC. En realité c'est un clock enable
   ADC_SYNC_FLAG(4)  <= adc_time_stamp.aoi_eof;      -- obligatoire
   ADC_SYNC_FLAG(3)  <= adc_time_stamp.naoi_stop;    -- obligatoire
   ADC_SYNC_FLAG(2)  <= adc_time_stamp.naoi_start;   -- adc time stamp obligatoire : naoi_start  (doit durer 1 CLK ADC)
   ADC_SYNC_FLAG(1)  <= adc_time_stamp.aoi_sof;      -- adc time stamp obligatoire : frame_flag  (doit durer 1 CLK ADC)
   ADC_SYNC_FLAG(0)  <= adc_time_stamp.aoi_sol;      -- adc time stamp obligatoire : line flag (doit durer 1 CLK ADC)
   
   READOUT_INFO    <= readout_info_i;
   AREA_FIFO_RD    <= area_fifo_rd_i;
   GEN_START       <= gen_start_i;
   ERR             <= err_i;
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
   
   ----------------  ----------------------------------
   --  lecture des fifos et synchronisation
   --------------------------------------------------
   U3B: process(CLK)
      variable inc : unsigned(1 downto 0);
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then            
            err_i <= (others =>'0');
            area_fifo_rd_i <= '0';
            ctrl_fsm <= idle;
            imm_sol_sync_err <= '0';
            imm_clk_sync_err <= '0';
            user_area_err <= '0';
            gen_start_i <= '0';
            readout_info_valid <= '0';
            gen_rst_i <= '1';
            nominal_mclk_raw_en_i <= '1';     -- 21 mars 2021: on active mclk_raw par defaut en vue d'eviter des bugs
            fast_mclk_raw_en_i <= '0';
            elcorr_ref_enabled <= '0';
            img_in_progress_i <= '0'; 
            acq_data_o <= '0';
            data_sync_err <= '0';
            nominal_mclk_raw_last <= '0';
            line_pclk_cnt_last <= (others => '0'); 
            elcorr_tic <= '0';
            elcorr_tac <= '0';
            fpa_int_i       <= '0';
            fpa_int_last    <= '0';
            
         else  
            
            --inc := '0'& fpa_mclk_re;          
            fpa_int_i       <= FPA_INT;
            fpa_int_last    <= fpa_int_i;
            
            acq_int_i <= ACQ_INT;
            acq_int_last <= acq_int_i;
            
            nominal_mclk_raw_last <= NOMINAL_MCLK_RAW;
            
            fpa_mclk_re <= not fpa_mclk_last and fpa_mclk_i;
            fpa_mclk_fe <= fpa_mclk_last and not fpa_mclk_i; 
            
            -----------------------------------------------------------------
            -- activation des flows de synchronisation                       
            -----------------------------------------------------------------
            case ctrl_fsm is
               
               when idle => 
                  if NOMINAL_MCLK_RAW = '0' and nominal_mclk_raw_last = '1' then -- on s'assure qu'il n y a pas de pulse "tronqué" 
                     nominal_mclk_raw_en_i <= '1';
                  end if;
                  gen_rst_i <= '0';
                  area_fifo_rd_i <= '0';
                  img_in_progress_i <= fpa_int_last;                -- ENO 29 janv 2020: on s'assure que img_in_progress_i ne tombe à zero que si aucune image n'est en transaction
                  acq_data_o <= '0';
                  gen_start_i <= fpa_int_last;                  
                  if fpa_int_last = '1' and  fpa_int_i = '0' then   -- front descendant de int                     
                     acq_data_o <= acq_int_last;
                     ctrl_fsm <= chck_lsydel_speed_st;
                  end if;                               
                  rst_cnt_i <= (others => '0'); 
                  pause_cnt <= (others => '0');
                  flow_err  <= '0';
                  elcorr_tic <= '0';
                  elcorr_tac <= '0';
 
               when chck_lsydel_speed_st =>
                     if NOMINAL_MCLK_RAW = '0' then 
                        nominal_mclk_raw_en_i    <= '0';
                        ctrl_fsm <= speedup_lsydel_clk_st;
                     end if;
               
               when speedup_lsydel_clk_st => 
                  if FAST_MCLK_RAW = '0' then  
                     fast_mclk_raw_en_i <= '1';                    
                     ctrl_fsm <= lsydel_dly_st;
                  end if;
                  
               when lsydel_dly_st => 
                  wait_cnt <= (others => '0');
                  if fpa_mclk_re = '1' then
                     pause_cnt <= pause_cnt + 1;
                     if pause_cnt >= to_integer(FPA_INTF_CFG.LSYDEL_MCLK) then 
                        ctrl_fsm <= wait_flows_st;
                        elcorr_tac <= '1';
                     end if;
                  end if;
               
               when wait_flows_st =>
                  gen_start_i <= '0';
                  elcorr_tac <= '0';
                  if wait_cnt > 30 then    
                     flow_err <= '1';                     -- aucune attente n'est autorisée ici
                  else
                     wait_cnt <= wait_cnt + 1; 
                  end if;
                  if AREA_FIFO_EMPTY = '0' and fpa_mclk_re = '1' then  -- fpa_mclk_re assure une synchro
                     ctrl_fsm <= stop_raw_clk_st;
                  end if;
               
               when stop_raw_clk_st =>
                  flow_err <= '0'; 
                  elcorr_ref_enabled <= FPA_INTF_CFG.ELCORR_ENABLED;
                  if fpa_mclk_fe = '1' then 
                     nominal_mclk_raw_en_i <= '0';    -- arrêt des horloges raw 
                     fast_mclk_raw_en_i    <= '0';    
                     ctrl_fsm <= active_flow_st; 
                  end if;
               
               when active_flow_st =>
                  area_fifo_rd_i <= '1';                                -- lancement du window fifo   
                  readout_info_valid <= '1';
                  ctrl_fsm <= sync_flow_st;
               
               when sync_flow_st =>  -- ne pas changer l'ordre des étapes 1 et 2 car en cas de simulatneité la condition 2 doit prevaloir
                 if AREA_FIFO_DATA.RAW.IMMINENT_AOI = '1'  then        -- etape2: l'entrée dans la zone user se fera à phase constante par rapport à l'horloge des ADCs
                    if adc_ref_fe_pipe(0) = '0' then                              -- si on n'est pas synchro déjà alors on s'en va se synchroniser sur adc_ref_fe_pipe(0) avant de sortir SOL
                        area_fifo_rd_i <= '0';
                        ctrl_fsm <= adc_sync_st;
                     else                                                           -- sinon, c'est qu'on est déjà synchro avec adc_ref_fe_pipe(FASTRD_SYNC_POS), alors on ne fait rien de particulier
                     end if;
                  end if;                     
                  if readout_info_i.aoi.read_end = '1' then                 -- etape3: détecter la fin de la fenetre 
                     ctrl_fsm <= raw_clk_en_st;
                     readout_info_valid <= '0';
                  end if;
               
               when adc_sync_st =>      -- synchro avec adc_ref_clk_i et donc avec l'horloge des ADCs. Attention ne marchera parfiatement que si on prend un échantillon par pixel!!
                  if adc_ref_fe_pipe(0) = '1' then   -- la valeur de delai (x) vient de la simulation en vue de reduire les delais
                     ctrl_fsm <= sync_flow_st;
                     area_fifo_rd_i <= '1';
                  end if;
               
               when raw_clk_en_st =>
                  area_fifo_rd_i <= '0';                        -- le window fifo est arrêté
                  if NOMINAL_MCLK_RAW = '0' and nominal_mclk_raw_last = '1' then -- on s'assure qu'il n y a pas de pulse "tronqué" 
                     nominal_mclk_raw_en_i <= '1';                               
                  end if;
                  if nominal_mclk_raw_en_i = '1' then
                     ctrl_fsm <= rst_gen_st;
                     elcorr_tic <= '1';
                  end if;                  
               
               when rst_gen_st =>    -- 
                  gen_rst_i <= '1';                          -- le upstream subit un reset 
                  rst_cnt_i <= rst_cnt_i + 1;
                  elcorr_tic <= '0';
                  if rst_cnt_i(4) = '1' then
                     ctrl_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
            --------------------------------------------------------------
            -- error
            -------------------------------------------------------------- 
            line_pclk_cnt_last <= AREA_FIFO_DATA.RAW.LINE_PCLK_CNT;
            if AREA_FIFO_DATA.RAW.LINE_PCLK_CNT /= line_pclk_cnt_last and AREA_FIFO_DATA.RAW.LINE_PCLK_CNT(0) = '1' then   -- le CLK_INFO.SOF arrive sur le front montant des pixels impairs 
               data_sync_err <= (area_fifo_rd_i and not AREA_FIFO_DATA.CLK_INFO.SOF);  -- SuperHawk: les changements de LINE_PCLK_CNT se font toujours sur le SOF d'un MCLK 
            end if; 
            err_i <= data_sync_err & flow_err;  -- erreur qui ne doit jamais arriver
            
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
            raw_window_i <= AREA_FIFO_DATA.RAW;          
            readout_info_i.aoi.samp_pulse <= '0';
            readout_info_i.naoi.dval <= '0';
            readout_info_i.naoi.samp_pulse <= '0';
            adc_ref_clk_last <= '0';
            adc_ref_clk_i <= '0';
            adc_ref_fe_pipe <= (others => '0');
            -- pragma translate_on
            
            read_start_last <= '0';
            read_end_last <= '0';
            fpa_mclk_i <= '0'; 
            
         else 
            
            
            -- pragma translate_off 
            raw_window_i <= AREA_FIFO_DATA.RAW; 
            -- pragma translate_on                                                                                                                                   
            
            
            -- Clocks 
            fpa_mclk_i <= (AREA_FIFO_DATA.CLK_INFO.CLK and area_fifo_rd_i) or (NOMINAL_MCLK_RAW and nominal_mclk_raw_en_i) or (FAST_MCLK_RAW and fast_mclk_raw_en_i); 
            fpa_mclk_last <= fpa_mclk_i;
            
            -- LSYNC     
--            if fpa_int_i = '1' then 
--               imminent_well_rst_i <= '0';
--            else
--               if AREA_FIFO_DATA.RAW.EOF = '1' and area_fifo_rd_i = '1' then 
--                  imminent_well_rst_i <= '1';
--               end if;
--            end if;          
--            last_lsync_pipe(C_LSYNC_PIPE_LEN-1 downto 0) <= last_lsync_pipe(C_LSYNC_PIPE_LEN-2 downto 0) & (AREA_FIFO_DATA.RAW.LSYNC and area_fifo_rd_i and imminent_well_rst_i); 
--            last_lsync_i <= last_lsync_pipe(C_LSYNC_PIPE_LEN-2);
--            
--            fpa_lsync_i <= (AREA_FIFO_DATA.RAW.LSYNC and area_fifo_rd_i and not imminent_well_rst_i) or last_lsync_i; 
            
            fpa_lsync_i <= (AREA_FIFO_DATA.RAW.LSYNC and area_fifo_rd_i); 

            
            
            -- 
            read_end_last <= readout_info_i.aoi.read_end;
            read_start_last <= readout_info_i.aoi.sof;
            
            -- elcorr_ref_start_i dure 1 PCLK             
            elcorr_ref_start_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_ref_start_pipe(C_FLAG_PIPE_LEN-2 downto 0) & elcorr_tic; -- Attention! le rd_end = debut de elc_ofs.
            if unsigned(elcorr_ref_start_pipe) /= 0 then
               elcorr_ref_start_i <= '1';
               elcorr_ref_fval_i  <= '1'; 
            else
               elcorr_ref_start_i <= '0';
            end if;
            
            -- elcorr_ref_end_i dure 1 PCLK
            elcorr_ref_end_pipe(C_FLAG_PIPE_LEN-1 downto 0) <= elcorr_ref_end_pipe(C_FLAG_PIPE_LEN-2 downto 0) & elcorr_tac; -- Attention! le sof  = fin de elc_ofs.
            if unsigned(elcorr_ref_end_pipe) /= 0 then
               elcorr_ref_end_i <= '1';
            else
               elcorr_ref_end_i  <= '0';
               if elcorr_ref_end_i = '1' then 
                  elcorr_ref_fval_i <= '0';
               end if;
            end if;
            
            -- samp_pulse_i 
            adc_ref_clk_i <= ADC_REF_CLK;
            adc_ref_clk_last <= adc_ref_clk_i;
            adc_ref_fe_pipe(0) <= adc_ref_clk_last and not adc_ref_clk_i;
            adc_ref_fe_pipe(15 downto 1) <= adc_ref_fe_pipe(14 downto 0);
            
            -- definition de read_end à la fin de RAW.FVAL et non USER.FVAL
            raw_fval_i    <= AREA_FIFO_DATA.RAW.FVAL;
            raw_fval_last <= raw_fval_i;         
            
            -- READOUT_INFO
            -- aoi
            readout_info_i.aoi.sof           <= AREA_FIFO_DATA.USER.SOF and area_fifo_rd_i; 
            readout_info_i.aoi.eof           <= AREA_FIFO_DATA.USER.EOF and area_fifo_rd_i;
            readout_info_i.aoi.sol           <= AREA_FIFO_DATA.USER.SOL and area_fifo_rd_i;
            readout_info_i.aoi.eol           <= AREA_FIFO_DATA.USER.EOL and area_fifo_rd_i;
            readout_info_i.aoi.fval          <= AREA_FIFO_DATA.USER.FVAL and readout_info_valid;                -- pas de area_fifo_rd_i  sur fval sinon pb.
            readout_info_i.aoi.lval          <= AREA_FIFO_DATA.USER.LVAL and area_fifo_rd_i;
            
            -- gestion de dval
            readout_info_i.aoi.dval          <= AREA_FIFO_DATA.USER.DVAL and area_fifo_rd_i;    -- par defaut
            
            readout_info_i.aoi.read_end      <= raw_fval_last and not raw_fval_i;                               -- raw_fval_i pour etre certain d'avoir détecté la fin de la fenetre raw. Sinon, l'offset dynamique pourrait se calculer durant le passage de l'horloge rapide. Et ce sera la catastrophe.
            readout_info_i.aoi.samp_pulse    <= adc_ref_fe_pipe(0) and AREA_FIFO_DATA.USER.FVAL and readout_info_valid;
            readout_info_i.aoi.spare(0)      <= acq_data_o;                     
            
--            if FPA_INTF_CFG.SINGLE_SAMP_MODE_EN = '1' then 
--               if AREA_FIFO_DATA.CLK_INFO.CLK_ID = DEFINE_FPA_NOMINAL_MCLK_ID then
--                  if (AREA_FIFO_DATA.USER.ADC_SAMPLE_NUM /= FPA_INTF_CFG.NOMINAL_CLK_ID_SAMPLE_POS) then     -- on ne considere que le dernier echantillon 
--                     readout_info_i.aoi.dval    <= '0';
--                  end if;
--               end if;
--               
--               
--               if AREA_FIFO_DATA.CLK_INFO.CLK_ID = DEFINE_FPA_MCLK1_ID then
--                  if (AREA_FIFO_DATA.USER.ADC_SAMPLE_NUM /= FPA_INTF_CFG.MCLK1_ID_SAMPLE_POS) then     -- on ne considere que le dernier echantillon 
--                     readout_info_i.aoi.dval    <= '0';
--                  end if;
--               end if;
--               
--               if AREA_FIFO_DATA.CLK_INFO.CLK_ID = DEFINE_FPA_MCLK2_ID then
--                  if (AREA_FIFO_DATA.USER.ADC_SAMPLE_NUM /= FPA_INTF_CFG.MCLK2_ID_SAMPLE_POS) then     -- on ne considere que le dernier echantillon 
--                     readout_info_i.aoi.dval    <= '0';
--                  end if;
--               end if;
--               
--               if AREA_FIFO_DATA.CLK_INFO.CLK_ID = DEFINE_FPA_MCLK3_ID then
--                  if (AREA_FIFO_DATA.USER.ADC_SAMPLE_NUM /= FPA_INTF_CFG.MCLK3_ID_SAMPLE_POS) then     -- on ne considere que le dernier echantillon 
--                     readout_info_i.aoi.dval    <= '0';
--                  end if;
--               end if;
--            end if;
            
            -- naoi (contenu aussi dans readout_info)
            readout_info_i.naoi.ref_valid(1) <= ELCORR_REF_VALID(1);        -- le Rising_edge = start du voltage reference(1) et falling edge = fin du voltage refrence(1)
            readout_info_i.naoi.ref_valid(0) <= ELCORR_REF_VALID(0);        -- le Rising_edge = start du voltage reference(0) et falling edge = fin du voltage refrence(0)
            readout_info_i.naoi.start        <= elcorr_ref_start_i;  -- start global de zone naoi
            readout_info_i.naoi.stop         <= elcorr_ref_end_i;    -- end global de zone naoi
            readout_info_i.naoi.dval         <= elcorr_ref_fval_i;
            readout_info_i.naoi.samp_pulse   <= adc_ref_fe_pipe(0) and elcorr_ref_fval_i;
            
            readout_info_i.samp_pulse        <= adc_ref_fe_pipe(0);    -- ENO: 25 mars 2021: samp_pulse doit toujoursêtre un pulse correspondant au Front Montant ou descendant de ADC_REF_CLK
            
            -- ADC_FLAGS
            -- flags temps reel enovoyés vers le synchronisateur d'adc pour time stamping des données ADC
            adc_time_stamp.aoi_eof           <= AREA_FIFO_DATA.USER.EOF and area_fifo_rd_i;
            adc_time_stamp.naoi_start        <= elcorr_ref_start_i and elcorr_ref_fval_i and DEFINE_GENERATE_ELCORR_CHAIN;
            adc_time_stamp.naoi_stop         <= elcorr_ref_end_i and elcorr_ref_fval_i and DEFINE_GENERATE_ELCORR_CHAIN;
            adc_time_stamp.aoi_sof           <= AREA_FIFO_DATA.USER.SOF and area_fifo_rd_i;
            adc_time_stamp.aoi_sol           <= AREA_FIFO_DATA.USER.SOL and area_fifo_rd_i; 
           
         end if; 
      end if;
   end process;    
   
end rtl;
