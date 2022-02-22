------------------------------------------------------------------
--!   @file : scd_proxy2_prog_ctrler
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_misc.all;
use work.fpa_define.all;
use work.Proxy_define.all;
use work.tel2000.all;
use work.fpa_serdes_define.all;


entity scd_proxy2_prog_ctrler is
   port(
      ARESET               : in std_logic;
      CLK                  : in std_logic;
      
      USER_CFG             : in fpa_intf_cfg_type;  -- la cfg valide envoyée par l'usager est ici
      USER_CFG_IN_PROGRESS : in std_logic;          -- à '1' lorsque USER_CFG et son équivalent seriel sont en cours d'envoi
      
      READOUT              : in std_logic;

      PROXY_POWERED        : in std_logic;
      
      FPA_POWER            : in std_logic;
      FPA_DRIVER_EN        : in std_logic;
      DIAG_MODE_ONLY       : in std_logic;
      
      ACQ_TRIG             : in std_logic;   -- ACQ_TRIG et XTRA_TRIG sont genrerés que si le proxy est allumé ou si on est en mode diag.
      XTRA_TRIG            : in std_logic;
      
      FPA_INTF_CFG         : out fpa_intf_cfg_type;
      
      PROXY_RDY            : in std_logic;   -- PROXY_RDY signifie qu'au moins une réponse a été reçue avec succès. 
      
      SERIAL_PARAM         : out serial_param_type;
      
      SERIAL_DONE          : in std_logic;
      SERIAL_FATAL_ERR     : in std_logic;
      
      
      RAM_ERR              : in std_logic;
      
      PROXY_PWR            : out std_logic;
      PROXY_TRIG           : out std_logic;
      PROXY_INTEGRATE      : out std_logic;
      FPA_DRIVER_STAT      : out std_logic_vector(31 downto 0);
      FRAME_ID             : out std_logic_vector(31 downto 0); --  synchronisé avec ACQ_INT
      INT_INDX             : out std_logic_vector(7 downto 0);
      INT_TIME             : out std_logic_vector(31 downto 0);
      ACQ_INT              : out std_logic;  -- feedback d'integration d'une image à envoyer dans la chaine.
      FPA_INT              : out std_logic;  -- feedback d'integration d'une image. (requis pour le module de generation des données en diag)
      RST_CLINK_N          : out std_logic;
      SERDES_RDY           : in std_logic
      
      );                 
end scd_proxy2_prog_ctrler;

architecture rtl of scd_proxy2_prog_ctrler is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;   
   
   component fpa_progr_clk_div   
      port (
         CLK              : in  std_logic; 	
         ARESET           : in  std_logic;
         PULSE_PERIOD     : in  std_logic_vector(7 downto 0);
         PULSE            : out std_logic);
   end component;
   
   component double_sync is
      generic(
         INIT_VALUE : bit := '0'
         );
      port(
         D     : in std_logic;
         Q     : out std_logic := '0';
         RESET : in std_logic;
         CLK   : in std_logic
         );
   end component;
   
   type driver_seq_fsm_type  is (idle, diag_only_st, fpa_prog_rqst_st, fpa_prog_en_st, wait_new_cfg_end_st,
   wait_fpa_prog_end_st, check_fpa_ser_fatal_err_st, check_cfg_st0, check_cfg_st, pause_st1, pause_st2, 
   output_op_cfg_st, output_roic_reg_cfg_st, output_int_cfg_st, output_temp_cfg_st, check_cfg_st1, check_cfg_st2, check_cfg_st3, check_cfg_st4, wait_updater_rdy_st, wait_updater_run_st, wait_updater_end_st);
   type int_gen_fsm_type is (idle, intg_dly_st,int_gen_st1, int_gen_st2, param_st);
   type new_cfg_pending_fsm_type is(init_st, wait_prog_end_st, check_cfg_st0, check_cfg_st1, check_cfg_st2, check_cfg_st3, new_roic_reg_cfg_st, new_op_cfg_st, new_int_cfg_st, new_temp_cfg_st);
   
   signal driver_seq_fsm            : driver_seq_fsm_type;
   signal cfg_updater_fsm           : driver_seq_fsm_type;
   signal int_gen_fsm               : int_gen_fsm_type;
   signal new_cfg_pending_fsm       : new_cfg_pending_fsm_type;
   signal frame_id_i                : unsigned(31 downto 0);
   signal acq_int_i                 : std_logic;
   signal fpa_int_i                 : std_logic;
   signal fpa_powered               : std_logic;
   signal fpa_driver_seq_err        : std_logic;
   signal fpa_cfg_err               : std_logic;
   signal fpa_driver_rqst           : std_logic;
   signal fpa_driver_done           : std_logic;
   signal sreset                    : std_logic;
   signal fpa_new_cfg_pending       : std_logic;
   signal user_cfg_in_progress_i    : std_logic;
   signal new_cfg                   : fpa_intf_cfg_type;
   signal present_cfg               : fpa_intf_cfg_type;
   signal fpa_intf_cfg_i            : fpa_intf_cfg_type;
   signal user_cfg_to_update        : fpa_intf_cfg_type;
   signal ser_param_i               : serial_param_type;
   signal user_cfg_latch            : fpa_intf_cfg_type;
   signal cnt                       : unsigned(USER_CFG.INT.INT_SIGNAL_HIGH_TIME'LENGTH-1 downto 0);
   signal acq_frame                 : std_logic;
   signal user_cfg_in_progress_last : std_logic;
   signal int_indx_i                : std_logic_vector(7 downto 0); 
   signal int_time_i                : std_logic_vector(31 downto 0);
   signal new_cfg_id                : std_logic_vector(7 downto 0);
   signal serial_sof_add_i          : std_logic_vector(7 downto 0);
   signal cfg_ser_param_i           : serial_param_type;
   signal serial_id_i               : std_logic_vector(7 downto 0);
   signal cfg_id_i                  : std_logic_vector(7 downto 0);
   signal fpa_driver_done_last      : std_logic;
   signal reset_clink_n             : std_logic;
   signal update_cfg_i              : std_logic;
   signal cfg_updater_done          : std_logic;
   signal proxy_static_done         : std_logic;
   signal id_cmd_in_err             : std_logic_vector(7 downto 0);
   signal need_prog_rqst            : std_logic;
   signal proxy_pwr_i               : std_logic;
   signal int_clk_pulse_i           : std_logic;
   signal int_i                     : std_logic;
   signal serdes_rdy_i              : std_logic := '0'; 
   signal iddca_rdy_i               : std_logic := '0'; 
   signal ignore_exptime_cmd        : std_logic := '0';
   signal ignore_op_cmd             : std_logic := '1';                                            
   
begin
   
   
   -------------------------------------------------
   -- mappings                                                   
   -------------------------------------------------
   SERIAL_PARAM    <= ser_param_i;
   INT_INDX        <= int_indx_i;                     --  synchronsié avec ACQ_INT et FPA_INT
   FRAME_ID        <= std_logic_vector(frame_id_i);   --  synchronsié avec ACQ_INT
   ACQ_INT         <= acq_int_i;  -- acq_int_i n'existe pas en extraTrig. De plus il signale à coup sûre une integration. Ainsi toute donnée de detecteur ne faisant pas suite à acq_trig, provient de extra_trig
   FPA_INT         <= fpa_int_i;   -- fpa_int_i existe pour toute integration (que l'image soit à envoyer dans la chaine ou non)
   PROXY_TRIG      <= ACQ_TRIG or XTRA_TRIG; -- PROXY_TRIG sera regeneré avec la durée adequate et avec une bascule dans le module scd_proxy2_driver_output 
   PROXY_INTEGRATE <= acq_int_i; 
   
   FPA_INTF_CFG    <= fpa_intf_cfg_i;  -- sortie de la config
   RST_CLINK_N     <= reset_clink_n;
   INT_TIME        <= int_time_i;
   PROXY_PWR       <= proxy_pwr_i;
   
   
   FPA_DRIVER_STAT(31 downto 16) <= (others => '0');
   FPA_DRIVER_STAT(15 downto 8) <= id_cmd_in_err;
   FPA_DRIVER_STAT(7) <= '0'; 
   FPA_DRIVER_STAT(6) <= '0'; 
   FPA_DRIVER_STAT(5) <= RAM_ERR;           -- erreur de collision dans la ram (à éviter)
   FPA_DRIVER_STAT(4) <= fpa_powered; 
   FPA_DRIVER_STAT(3) <= fpa_driver_seq_err;-- 
   FPA_DRIVER_STAT(2) <= fpa_cfg_err;       -- fpa_cfg_err toute erreur de programmation retournée par le détecteur
   FPA_DRIVER_STAT(1) <= fpa_driver_rqst;   --
   FPA_DRIVER_STAT(0) <= fpa_driver_done;   --
   
   
   U1A: double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => SERDES_RDY, CLK => CLK, Q => serdes_rdy_i);

   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1B : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   --------------------------------------------------
   --  Allumage du Proxy 
   --------------------------------------------------
   -- doit être dans un process indépendant 
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            proxy_pwr_i <= '0'; 
            fpa_powered <= '0';
            reset_clink_n <= '0';
         else                  
            proxy_pwr_i <= FPA_POWER;   
            iddca_rdy_i <= USER_CFG.iddca_rdy;
            
            fpa_powered <= PROXY_POWERED and PROXY_RDY;  -- PROXY_POWERED signifie que le proxy est juste allumé. PROXY_RDY signifie qu'au moins une réponse a été reçue avec succès.              
            reset_clink_n <= PROXY_POWERED and PROXY_RDY and proxy_static_done and iddca_rdy_i;  -- il faut que le module clink soit en reset tant que le proxy n'est pas prêt
         end if;               
      end if;          
   end process;
   
   ------------------------------------------------
   -- Voir s'il faut programmer le détecteur
   ------------------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            fpa_new_cfg_pending <= '0';
            user_cfg_in_progress_i <= '0';
            user_cfg_in_progress_last <= '0';
            new_cfg_pending_fsm <= init_st;
            need_prog_rqst <= '0';
            cfg_ser_param_i.run   <= '0';
            cfg_ser_param_i.abort <= '0';
            
         else 
            user_cfg_in_progress_i    <= USER_CFG_IN_PROGRESS;  
            user_cfg_in_progress_last <= user_cfg_in_progress_i; 
            ignore_exptime_cmd        <= USER_CFG.ignore_exptime_cmd;
            ignore_op_cmd             <= USER_CFG.ignore_op_cmd;
            
            -- on retient les champs de la config qui requierent une programmation du détecteur
            -- config entrante synchronisé sur l'horloge local
            new_cfg.op        <= USER_CFG.OP;   
            new_cfg.int       <= USER_CFG.INT;   
            new_cfg.temp      <= USER_CFG.TEMP;
            new_cfg.roic_reg  <= USER_CFG.roic_reg;
                        
            -- détection nouvelle programmation (fsm pour reduire les problèmes de timing)
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings	
            case new_cfg_pending_fsm is
               
               when init_st =>                    -- cet etat donne le temps à new_cfg d'être defini
                  new_cfg_pending_fsm <= check_cfg_st0;					 
               
               when check_cfg_st0 =>
                  if new_cfg.roic_reg /= present_cfg.roic_reg then
                     new_cfg_pending_fsm <= new_roic_reg_cfg_st;	
                  else
                     new_cfg_pending_fsm <= check_cfg_st1;
                  end if;
               
               when check_cfg_st1 => 
                  if new_cfg.op /= present_cfg.op and ignore_op_cmd = '0' then
                     new_cfg_pending_fsm <= new_op_cfg_st;					 
                  else
                     new_cfg_pending_fsm <= check_cfg_st2;
                  end if;
                  
               when check_cfg_st2 =>
                  if new_cfg.int /= present_cfg.int and ignore_exptime_cmd = '0' then
                     new_cfg_pending_fsm <= new_int_cfg_st;	 				 
                  else
                     new_cfg_pending_fsm <= check_cfg_st3;  
                  end if;
               
               when check_cfg_st3 =>
                  if new_cfg.temp /= present_cfg.temp then
                     new_cfg_pending_fsm <= new_temp_cfg_st;					 
                  else
                     new_cfg_pending_fsm <= check_cfg_st0;
                  end if;
               
               when new_roic_reg_cfg_st =>  
                  new_cfg_id <= std_logic_vector(USER_CFG.ROIC_REG_CMD_SOF_ADD(7 downto 0));     -- les 7 derniers bits suffisent largement
                  cfg_ser_param_i.cmd_sof_add    <= USER_CFG.ROIC_REG_CMD_SOF_ADD;
                  cfg_ser_param_i.cmd_eof_add    <= USER_CFG.ROIC_REG_CMD_EOF_ADD;
                  cfg_ser_param_i.prog_trig_mode <= '0';
                  fpa_new_cfg_pending <= '1';              -- pour parfaite synchro avec new_cfg_id et cfg_ser_param_i.cmd_sof_add. Demande de programmation ssi aucune config en progression
                  need_prog_rqst <= '0'; 				       -- op_cfg : requete auprès du fpa_hw_sequencer necessaire afin qu'il arrête les trigs
                  if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st0;
                  else
                     fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ser_param_i.cmd_sof_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
                 
               when new_op_cfg_st =>  
                  new_cfg_id <= std_logic_vector(USER_CFG.OP_CMD_SOF_ADD(7 downto 0));     -- les 7 derniers bits suffisent largement
                  cfg_ser_param_i.cmd_sof_add    <= USER_CFG.OP_CMD_SOF_ADD;
                  cfg_ser_param_i.cmd_eof_add    <= USER_CFG.OP_CMD_EOF_ADD;
                  cfg_ser_param_i.prog_trig_mode <= serdes_rdy_i;
                  need_prog_rqst <= '1'; 				       -- op_cfg : requete auprès du fpa_hw_sequencer necessaire afin qu'il arrête les trigs
                  if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st0;
                  else
                     fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ser_param_i.cmd_sof_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when new_int_cfg_st =>
                  new_cfg_id <= std_logic_vector(USER_CFG.INT_CMD_SOF_ADD(7 downto 0));
                  cfg_ser_param_i.cmd_sof_add    <= USER_CFG.INT_CMD_SOF_ADD;
                  cfg_ser_param_i.cmd_eof_add    <= USER_CFG.INT_CMD_EOF_ADD;
                  cfg_ser_param_i.prog_trig_mode <= '0';
                  fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ser_param_i.cmd_sof_add. Demande de programmation ssi aucune config en progression
                  need_prog_rqst <= '0'; 				         -- int_cfg : requete auprès du fpa_hw_sequencer non necessaire car on peut faire la prog sans arrêter les trigs
                  if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st0;
                  else
                     fpa_new_cfg_pending <= '1';            -- pour parfaite synchro avec new_cfg_id et cfg_ser_param_i.cmd_sof_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when new_temp_cfg_st =>
                  new_cfg_id <= std_logic_vector(USER_CFG.TEMP_CMD_SOF_ADD(7 downto 0));
                  cfg_ser_param_i.cmd_sof_add  <= USER_CFG.TEMP_CMD_SOF_ADD;
                  cfg_ser_param_i.cmd_eof_add <= USER_CFG.TEMP_CMD_EOF_ADD;
                  cfg_ser_param_i.prog_trig_mode <= '0';
                  fpa_new_cfg_pending <= '1';              -- pour parfaite synchro avec new_cfg_id et cfg_ser_param_i.cmd_sof_add. Demande de programmation ssi aucune config en progression
                  need_prog_rqst <= '0'; 				        -- temp_cfg : requete auprès du fpa_hw_sequencer non necessaire car on peut faire la prog sans arrêter les trigs
                  if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st0;
                  else
                     fpa_new_cfg_pending <= '1';           -- pour parfaite synchro avec new_cfg_id et cfg_ser_param_i.cmd_sof_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when wait_prog_end_st =>
                  if fpa_driver_done_last = '0' and fpa_driver_done = '1' then
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st0;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   -----------------------------------------------------------------
   --  Séquençage des operations de programmation du détecteur 
   ----------------------------------------------------------------   
   U4 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            driver_seq_fsm <=  idle;
            fpa_driver_done <= '0';
            fpa_driver_rqst <= '0';
            ser_param_i.run <= '0';
            ser_param_i.abort <= '0';
            fpa_cfg_err <= '0';
            fpa_driver_seq_err <= '0';
            fpa_driver_done_last <= '0';
            update_cfg_i <= '0';
            id_cmd_in_err <= (others => '1'); -- fait express car cette commande id n'existe pas pour le Megalink
            
         else                       
            
            fpa_driver_done_last <= fpa_driver_done;
            -- fsm de contrôle de la partie de config demandant la reprogrammarion du fpa  
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings
            
            if SERIAL_FATAL_ERR = '1' then
               id_cmd_in_err <= serial_id_i;
            end if;
            
            
            case  driver_seq_fsm is 
               
               when idle =>
                  fpa_driver_done <= '1'; 
                  fpa_cfg_err <= '0';
                  fpa_driver_rqst <= '0';
                  update_cfg_i <= '0';
                  fpa_driver_seq_err <= '0';
                  if SERIAL_DONE = '1' and fpa_new_cfg_pending = '1' and PROXY_POWERED = '1' then  -- ne jamais ajouter PROXY_RDY dans les conditions
                     if need_prog_rqst = '1' then
                        driver_seq_fsm <= fpa_prog_rqst_st;
                     else
                        driver_seq_fsm <= fpa_prog_en_st;
                     end if;
                  end if;               
               
               when fpa_prog_rqst_st =>              -- demande pour programmer le fpa. Elle se soldera par l'arrêt du contrôleur de trig
                  fpa_driver_rqst <= '1'; 
                  if FPA_DRIVER_EN = '1' then
                     driver_seq_fsm <= fpa_prog_en_st;                     
                  end if;                  
               
               when fpa_prog_en_st =>        -- ordre de programmation du fpa       
                  fpa_driver_done <= '0';             
                  fpa_driver_rqst <= '0'; 
                  ser_param_i <= cfg_ser_param_i;
                  if fpa_new_cfg_pending = '1' then   -- on reverifie qu'il y a toujours une config en attente car il se pourrait q'une nouvelle config soit rentrée et egale à celle déjà dans le détecteur               
                     ser_param_i.run <= '1';
                     ser_param_i.abort  <= '0';
                     serial_id_i <= new_cfg_id;
                     if SERIAL_DONE = '0' then 
                        ser_param_i.run <= '0';
                        user_cfg_latch <= USER_CFG;   -- la config en cours de programmation est latchée -- à partir de ce moment dans le serializer, la config est copiée tres rapidement de la ram vers le fifo de sortie avant qu'une nouvelle n'arrive.
                        driver_seq_fsm <= wait_fpa_prog_end_st;                        
                     end if;
                  else      -- à ce stade c'est qu'il y a une autre config entrain de rentrer 
                     driver_seq_fsm <= wait_new_cfg_end_st; -- on attend qu'elle rentre pour que user_cfg_pending repasse à '1'
                  end if;
               
               when wait_new_cfg_end_st => 
                  if user_cfg_in_progress_i = '0' and user_cfg_in_progress_last = '0' then   -- assure qu'aucune cfg n'est en progression
                     if fpa_new_cfg_pending = '1' then
                        driver_seq_fsm <= fpa_prog_en_st;
                     else            -- la nouvelle config rentrée n'est pas differente de l'actuelle dans la camera
                        driver_seq_fsm <= idle;
                     end if;    
                  end if;
               
               when wait_fpa_prog_end_st =>  -- attente de la fin de la programmation      
                  if SERIAL_DONE = '1' then 
                     driver_seq_fsm <= check_fpa_ser_fatal_err_st;
                  end if;
               
               when check_fpa_ser_fatal_err_st =>      -- après plusieurs essais de programmation le module serial sortira une erreur fatale                      
                  if SERIAL_FATAL_ERR = '1' then
                     fpa_cfg_err <= '1';               -- en cas d'erreur fatale, on s'en va en idle mais la config n'est pas programmée.Il ne fauit jamais avoir cette erreur 
                     driver_seq_fsm <= idle;
                  else
                     driver_seq_fsm <= wait_updater_rdy_st;
                  end if; 
               
               when wait_updater_rdy_st =>
                  if cfg_updater_done = '1' then
                     update_cfg_i <= '1';               -- on lance la mise à jour des configs
                     driver_seq_fsm <= wait_updater_run_st;                     
                  end if;
               
               when wait_updater_run_st => 
                  if cfg_updater_done = '0' then
                     update_cfg_i <= '0';             
                     driver_seq_fsm <= wait_updater_end_st;                     
                  end if;
               
               when wait_updater_end_st =>
                  if cfg_updater_done = '1' then          
                     driver_seq_fsm <= pause_st1;                     
                  end if;
               
               when pause_st1 =>                                -- fait expres pour donner du temps à new_cfg_pending de tomber
                  fpa_driver_done <= '1';                        -- fait expres pour new_cfg_pending_fsm
                  driver_seq_fsm <= pause_st2;
               
               when pause_st2 => 
                  driver_seq_fsm <= idle;                  
               
               when others =>              
               
            end case;
            
         end if;
      end if;
   end process;   
   
   -----------------------------------------------------------------
   --  mise à jour des configs
   ----------------------------------------------------------------
   -- decouplé du sequenceur pour une mise à jour de trame en trame
   U5 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            cfg_updater_fsm <=  idle;
            cfg_updater_done <= '0';           
            proxy_static_done <= '0';
            present_cfg.op.xsize <= (others => '0');      -- cette initialisation force la reprogrammation du détecteur après un reset de power management
            present_cfg.temp.cfg_num <= (others => '0');  -- cette initialisation force la reprogrammation du détecteur après un reset de power management
            
         else                       
            
            -- ENO 14 juillet 2016: requis pour supporter instabilités de la roue à filtre. Mettre à jour même si détecteur n'est pas reprogrammé
            fpa_intf_cfg_i.comn.fpa_stretch_acq_trig <= USER_CFG.comn.fpa_stretch_acq_trig;
            
            case  cfg_updater_fsm is 
               
               when idle =>
                  cfg_updater_done <= '1'; 
                  if PROXY_POWERED = '0' then 
                     cfg_updater_fsm <= diag_only_st; 
                  else            -- si on n'est pas en mode diag_only, c'est que le ADC/DDC est connecté et allumé                               
                     if update_cfg_i = '1' then 
                        cfg_updater_fsm <= check_cfg_st0;
                        user_cfg_to_update <= user_cfg_latch;
                        cfg_id_i <= serial_id_i;
                     end if;
                  end if;
               
               when diag_only_st =>
                  cfg_updater_done <= '0';                  
                  if PROXY_POWERED = '1' then
                     cfg_updater_fsm <= idle;
                  else
                     if READOUT = '0' then  -- en mode diag effectuer les changements d'etat que si aucune lecture en cours 
                        fpa_intf_cfg_i <= USER_CFG;
                     end if;
                  end if;                
               
               when check_cfg_st0 =>
                  cfg_updater_done <= '0';
                  if cfg_id_i = std_logic_vector(USER_CFG.TEMP_CMD_SOF_ADD(7 downto 0)) then -- pas besoin de trig poour lea temperature. Ainsi on l'aura même en mode trig externe
                     cfg_updater_fsm <= check_cfg_st4; 
                  else
                     cfg_updater_fsm <= check_cfg_st1;    
                  end if;
               
               when check_cfg_st1 =>                           -- 
                  if cfg_id_i = std_logic_vector(USER_CFG.OP_CMD_SOF_ADD(7 downto 0)) then
                     if READOUT = '0' then
                        cfg_updater_fsm <= output_op_cfg_st;
                     end if;
                  else
                     cfg_updater_fsm <= check_cfg_st2;
                  end if;
               
               when check_cfg_st2 =>                           -- 
                  if cfg_id_i = std_logic_vector(USER_CFG.INT_CMD_SOF_ADD(7 downto 0)) then
                     cfg_updater_fsm <= output_int_cfg_st;
                  else
                     cfg_updater_fsm <= check_cfg_st3;
                  end if;
               
               when check_cfg_st3 =>                           -- 
                  if cfg_id_i = std_logic_vector(USER_CFG.ROIC_REG_CMD_SOF_ADD(7 downto 0)) then
                     cfg_updater_fsm <= output_roic_reg_cfg_st;
                  else
                     cfg_updater_fsm <= check_cfg_st4;
                  end if;
               
               when check_cfg_st4 =>                            --
                  cfg_updater_fsm <= output_temp_cfg_st;                
               
               when output_op_cfg_st =>                         --
                  fpa_intf_cfg_i <= user_cfg_to_update;
                  present_cfg.op <= user_cfg_to_update.op;
                  proxy_static_done <= '1';
                  cfg_updater_fsm <= pause_st1;
               
               when output_roic_reg_cfg_st =>                         --
                  fpa_intf_cfg_i.roic_reg <= user_cfg_to_update.roic_reg;
                  present_cfg.roic_reg <= user_cfg_to_update.roic_reg;
                  cfg_updater_fsm <= pause_st1;
               
               when output_int_cfg_st =>                        -- 
                  fpa_intf_cfg_i.int <= user_cfg_to_update.int;
                  fpa_intf_cfg_i.int_time <= resize(user_cfg_to_update.int.int_time, fpa_intf_cfg_i.int_time'length);
                  present_cfg.int <= user_cfg_to_update.int;  
                  cfg_updater_fsm <= pause_st1;
               
               when output_temp_cfg_st =>                       -- 
                  fpa_intf_cfg_i.temp <= user_cfg_to_update.temp;
                  present_cfg.temp <= user_cfg_to_update.temp; 
                  cfg_updater_fsm <= pause_st1;   
               
               when pause_st1 =>                                -- fait expres pour donner du temps à new_cfg_pending de tomber
                  cfg_updater_fsm <= idle;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;   
   
   
   --------------------------------------------------
   --  reference du temps d'integra
   --------------------------------------------------
   U6A : fpa_progr_clk_div
   port map(
      ARESET         => ARESET,
      CLK            => CLK,       -- CLK doit être connecté à INT_CLK_SOURCE)
      PULSE          => int_clk_pulse_i,
      PULSE_PERIOD   => std_logic_vector(USER_CFG.INT_CLK_PERIOD_FACTOR)
      );
   
   
   --------------------------------------------------
   --  generation de acq_int_i et fpa_int_i
   --------------------------------------------------
   -- acq_int_i
   -- acq_int_i est destiné à signifier aux modules externes (TimeStamper, SFW etc...) le véritable instant de l'intégration
   U6B : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            int_gen_fsm <= idle;
            acq_int_i <= '0'; 
            frame_id_i <= (others => '0');
            acq_frame <= '0';
            fpa_int_i <= '0';
            int_i <= '0';
            
         else
            
            
            fpa_int_i <= int_i;
            acq_int_i <= int_i and acq_frame and (fpa_intf_cfg_i.comn.fpa_diag_mode or PROXY_RDY);
            
            
            -- fsm de generation de acq_int_i           
            case  int_gen_fsm is 
               
               when idle =>
                  cnt <= to_unsigned(1, cnt'length);                 
                  int_i <= '0';
                  if ACQ_TRIG = '1' then    -- ACQ_TRIG uniquement car ne jamais envoyer acq_int_i en mode XTRA_TRIG
                     frame_id_i <= frame_id_i + 1;
                     acq_frame <= '1';
                     int_gen_fsm <= param_st;
                  elsif XTRA_TRIG = '1' then    -- 
                     acq_frame <= '0';
                     int_gen_fsm <= param_st;
                  end if;                  
               
               when param_st =>
                  int_indx_i <= fpa_intf_cfg_i.int.int_indx;
                  int_time_i <= std_logic_vector(resize(fpa_intf_cfg_i.int.int_time, 32));                
                  int_gen_fsm <= intg_dly_st; 
                  
               when intg_dly_st =>  
                  if int_clk_pulse_i = '1' then 
                     if cnt >= fpa_intf_cfg_i.int.int_dly then    
                        cnt <= to_unsigned(1, cnt'length);
                        int_gen_fsm <= int_gen_st1;
                     else                        
                        cnt <= cnt + 1;
                     end if;
                  end if;
               
               when int_gen_st1 =>                         -- ainsi on a au minimum une durée egale à la periode de int_clk_pulse_i même si fpa_intf_cfg_i.int.int_signal_high_time = 0 
                  if int_clk_pulse_i = '1' then
                     int_i <= '1';
                     int_gen_fsm <= int_gen_st2;
                  end if;
               
               when int_gen_st2 =>
                  if int_clk_pulse_i = '1' then                     
                     if cnt >= fpa_intf_cfg_i.int.int_signal_high_time then    --
                        int_i <= '0';
                        int_gen_fsm <= idle;
                     else                        
                        cnt <= cnt + 1;
                     end if;
                  end if;                
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process; 
   
end rtl;
