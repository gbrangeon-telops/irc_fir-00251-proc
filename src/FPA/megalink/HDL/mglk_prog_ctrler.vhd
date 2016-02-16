------------------------------------------------------------------
--!   @file : mglk_prog_ctrler
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
use work.fpa_define.all;
use work.tel2000.all;
use work.Proxy_define.all;

entity mglk_prog_ctrler is
   port(
      ARESET               : in std_logic;
      CLK                  : in std_logic;
      
      USER_CFG             : in fpa_intf_cfg_type;  -- la cfg valide envoyée par l'usager est ici
      USER_CFG_IN_PROGRESS : in std_logic;          -- à '1' lorsque USER_CFG et son équivalent seriel sont en cours d'envoi par le mblaze
      
      READOUT              : in std_logic;
      
      PROXY_INT_FBK        : in std_logic;
      PROXY_POWERED        : in std_logic;
      
      FPA_POWER            : in std_logic;
      FPA_DRIVER_EN        : in std_logic;
      DIAG_MODE_ONLY       : in std_logic;
      
      ACQ_TRIG             : in std_logic;   -- ACQ_TRIG et XTRA_TRIG sont genrerés que si le proxy est allumé ou si on est en mode diag.
      XTRA_TRIG            : in std_logic;
      
      PROG_TRIG_O          : out std_logic;
      
      FPA_INTF_CFG         : out fpa_intf_cfg_type;
      
      PROXY_RDY            : in std_logic;   -- PROXY_RDY signifie qu'au moins une réponse a été reçue avec succès. 
      SERIAL_EN            : out std_logic;
      SERIAL_ABORT         : out std_logic;   --
      SERIAL_DONE          : in std_logic;
      SERIAL_FATAL_ERR     : in std_logic;
      SERIAL_BASE_ADD      : out std_logic_vector(9 downto 0);
      
      RAM_ERR              : in std_logic;
      
      PROXY_PWR            : out std_logic;
      PROXY_TRIG           : out std_logic;
      FPA_DRIVER_STAT      : out std_logic_vector(15 downto 0);
      FRAME_ID             : out std_logic_vector(31 downto 0); --  synchronisé avec ACQ_INT
      INT_INDX             : out std_logic_vector(7 downto 0);
      ACQ_INT              : out std_logic;  -- feedback d'integration d'une image à envoyer dans la chaine.
      FPA_INT              : out std_logic;  -- feedback d'integration d'une image. (requis pour le module de generation des données en diag)
      RST_CLINK_N          : out std_logic;
      FPA_MCLK             : out std_logic
      
      );                 
end mglk_prog_ctrler;

architecture rtl of mglk_prog_ctrler is
   
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component Clk_Divider is
      Generic(	Factor:		integer := 2);		
      Port ( 
         Clock  : in std_logic;
         Reset  : in std_logic;		
         Clk_div: out std_logic);
   end component;
   
   type driver_seq_fsm_type  is (idle, diag_only_st, fpa_prog_rqst_st, fpa_prog_en_st, wait_new_cfg_end_st,
   wait_fpa_prog_end_st, check_fpa_ser_fatal_err_st, wait_trig_st, check_cfg_st, pause_st1, pause_st2, pause_st3, output_windw_cfg_st, 
   output_op_cfg_st, output_int_cfg_st, output_diag_cfg_st, output_temp_cfg_st, check_cfg_st1, check_cfg_st2, check_cfg_st3,
   check_cfg_st4, check_cfg_st5, output_static_cfg_st, wait_updater_rdy_st, wait_updater_run_st, prog_trig_st, wait_prog_trig_done_st);
   type int_gen_fsm_type is (idle, diag_int_dly_st, check_fpa_st, diag_exp_rst_cnt_st, diag_exp_int_gen_st, diag_int_gen_st);
   type new_cfg_pending_fsm_type is(idle, new_windw_cfg_st, wait_prog_end_st, new_static_cfg_st, check_cfg_st1, check_cfg_st2, 
   check_cfg_st3, check_cfg_st4, new_op_cfg_st, new_int_cfg_st, new_temp_cfg_st, new_diag_cfg_st, check_cfg_st5, check_cfg_st6);
   
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
   signal actual_cfg                : fpa_intf_cfg_type;
   signal fpa_intf_cfg_i            : fpa_intf_cfg_type;
   signal serial_en_i               : std_logic;
   signal fpa_ser_cfg_latch         : fpa_intf_cfg_type;
   signal fpa_ser_cfg_to_update     : fpa_intf_cfg_type;
   signal cnt                       : unsigned(31 downto 0);
   signal int_signal_time_high_time : integer;
   signal proxy_int_feedbk_i        : std_logic;
   signal proxy_int_feedbk_last     : std_logic;
   signal acq_frame                 : std_logic;
   signal user_cfg_in_progress_last : std_logic;
   --signal int_indx_i                : std_logic_vector(7 downto 0);
   signal new_cfg_id                : std_logic_vector(7 downto 0);
   signal serial_base_add_i         : std_logic_vector(9 downto 0);
   signal cfg_ram_base_add          : unsigned(serial_base_add_i'length-1 downto 0);
   signal serial_id_i               : std_logic_vector(7 downto 0); 
   signal cfg_id_i                  : std_logic_vector(7 downto 0);
   signal fpa_driver_done_last      : std_logic;
   signal serial_abort_i            : std_logic;
   signal reset_clink_n             : std_logic;
   signal proxy_static_done         : std_logic;
   signal update_cfg_i              : std_logic;
   signal cfg_updater_done          : std_logic;
   signal fpa_mclk_p                : std_logic_vector(3 downto 0) := (others => '0');
   signal Allow_IntTimeChange       : std_logic;
   signal fpa_mclk_raw              : std_logic;
   signal fpa_mclk_i                : std_logic;
   signal fpa_mclk_last             : std_logic;
   signal fpa_mclk_rising_edge      : std_logic;
   signal fpa_int_latch             : proxy_int_cfg_type;
   signal id_cmd_in_err             : std_logic_vector(7 downto 0);
   
   signal prog_trig_i               : std_logic;
   signal prog_trig_done            : std_logic;
   signal img_cnt                   : natural range 0 to FPA_XTRA_IMAGE_NUM_TO_SKIP;
   signal enable_prog_trig          : std_logic;
   
   type prog_trig_fsm_type is (idle, img_start, img_end, check_done);
   signal prog_trig_state            : prog_trig_fsm_type;
   
   attribute dont_touch                         : string;
   attribute dont_touch of acq_int_i            : signal is "true";
   attribute dont_touch of fpa_int_i            : signal is "true";
   attribute dont_touch of proxy_int_feedbk_i   : signal is "true";
   attribute dont_touch of acq_frame            : signal is "true";
   attribute dont_touch of fpa_mclk_p           : signal is "true";
   attribute dont_touch of Allow_IntTimeChange  : signal is "true";
   attribute dont_touch of enable_prog_trig     : signal is "true";
   attribute dont_touch of prog_trig_i          : signal is "true";
   attribute dont_touch of prog_trig_done       : signal is "true";
   
begin
   
   PROG_TRIG_O <= prog_trig_i;
   
   -------------------------------------------------
   -- mappings                                                   
   -------------------------------------------------
   SERIAL_BASE_ADD <= serial_base_add_i;
   SERIAL_EN <= serial_en_i;
   SERIAL_ABORT <= serial_abort_i;
   INT_INDX <= fpa_int_latch.proxy_int_indx;                     --  synchronsié avec ACQ_INT et FPA_INT
   FRAME_ID <= std_logic_vector(frame_id_i);  --  synchronsié avec ACQ_INT
   ACQ_INT <= acq_int_i;  -- acq_int_i n'existe pas en extraTrig. De plus il signale à coup sûre une integration. Ainsi toute donnée de detecteur ne faisant pas suite à acq_trig, provient de extra_trig
   FPA_INT <= fpa_int_i;   -- fpa_int_i existe pour toute integration (que l'image soit à envoyer dans la chaine ou non)
   PROXY_TRIG <= ACQ_TRIG or XTRA_TRIG; -- PROXY_TRIG sera regeneré avec la durée adequate et avec une bascule dans le module mglk_driver_output 
   FPA_INTF_CFG <= fpa_intf_cfg_i;  -- sortie de la config
   RST_CLINK_N <= reset_clink_n;
   FPA_MCLK <= fpa_mclk_p(2);
   
   
   FPA_DRIVER_STAT(15 downto 8) <= id_cmd_in_err; 
   FPA_DRIVER_STAT(7) <= '0'; 
   FPA_DRIVER_STAT(6) <= '0'; 
   FPA_DRIVER_STAT(5) <= RAM_ERR;           -- erreur de colision dans la ram (à éviter)
   FPA_DRIVER_STAT(4) <= fpa_powered; 
   FPA_DRIVER_STAT(3) <= fpa_driver_seq_err;-- 
   FPA_DRIVER_STAT(2) <= fpa_cfg_err;       -- fpa_cfg_err toute erreur de programmation retournée par le détecteur
   FPA_DRIVER_STAT(1) <= fpa_driver_rqst;   --
   FPA_DRIVER_STAT(0) <= fpa_driver_done;   --
   
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
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
            PROXY_PWR <= '0'; 
            fpa_powered <= '0';
            reset_clink_n <= '0';
         else                  
            PROXY_PWR <= FPA_POWER; 
            fpa_powered <= PROXY_POWERED and PROXY_RDY;  -- PROXY_POWERED signifie que le proxy est juste allumé. PROXY_RDY signifie qu'au moins une réponse a été reçue avec succès.              
            reset_clink_n <= PROXY_POWERED and PROXY_RDY and proxy_static_done;  -- il faut que le module clink soit en reset tant que le proxy n'est pas prêt ou pas configuré correctement avec la bonne commande statique
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
            new_cfg_pending_fsm <= check_cfg_st1;
            
         else 
            
            user_cfg_in_progress_i <= USER_CFG_IN_PROGRESS;  -- user_cfg_in_progress_i est requis pour une sychro parfaite avec new_fpa_word
            user_cfg_in_progress_last <= user_cfg_in_progress_i;
            
            -- config entrante synchronisé sur l'horloge local
            new_cfg.proxy_op <= USER_CFG.PROXY_OP;   
            new_cfg.proxy_int <= USER_CFG.PROXY_INT;  
            new_cfg.proxy_diag <= USER_CFG.PROXY_DIAG; 
            new_cfg.proxy_temp <= USER_CFG.PROXY_TEMP;
            new_cfg.proxy_windw <= USER_CFG.PROXY_WINDW;
            new_cfg.proxy_static <= USER_CFG.PROXY_STATIC;
            
            
            new_cfg.proxy_misc <= USER_CFG.proxy_MISC; 
            
            --fpa_new_cfg_pending <= not user_cfg_in_progress_i; 
            
            -- détection nouvelle programmation (fsm pour reduire les problèmes de timing)
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings	
            case new_cfg_pending_fsm is			  
               
               when check_cfg_st1 =>
                  if new_cfg.proxy_static /= actual_cfg.proxy_static then
                     new_cfg_pending_fsm <= new_static_cfg_st;					 
                  else
                     new_cfg_pending_fsm <= check_cfg_st2;
                  end if;
               
               when check_cfg_st2 =>
                  if new_cfg.proxy_op /= actual_cfg.proxy_op then
                     new_cfg_pending_fsm <= new_op_cfg_st;					 
                  else
                     new_cfg_pending_fsm <= check_cfg_st3;
                  end if;
               
               when check_cfg_st3 =>
                  if MGLK_INT_SIGNAL_IS_EXTERNAL = '1' then
                     new_cfg_pending_fsm <= check_cfg_st4;
                  else                     
                     if new_cfg.proxy_int /= actual_cfg.proxy_int then
                        new_cfg_pending_fsm <= new_int_cfg_st;					 
                     else
                        new_cfg_pending_fsm <= check_cfg_st4;  
                     end if;
                  end if;
               
               when check_cfg_st4 =>
                  if new_cfg.proxy_temp /= actual_cfg.proxy_temp then
                     new_cfg_pending_fsm <= new_temp_cfg_st;					 
                  else
                     new_cfg_pending_fsm <= check_cfg_st5;
                  end if;		
               
               when check_cfg_st5 =>
                  if new_cfg.proxy_windw /= actual_cfg.proxy_windw then
                     new_cfg_pending_fsm <= new_windw_cfg_st;					 
                  else
                     new_cfg_pending_fsm <= check_cfg_st6;
                  end if;		
               
               when check_cfg_st6 =>
                  if new_cfg.proxy_diag /= actual_cfg.proxy_diag then
                     new_cfg_pending_fsm <= new_diag_cfg_st;					 
                  else
                     new_cfg_pending_fsm <= check_cfg_st1;
                  end if;   
               
               when new_op_cfg_st =>
                  new_cfg_id <= PROXY_OP_CMD_ID(7 downto 0);     -- les 7 derniers bits suffisent largement
                  cfg_ram_base_add <= to_unsigned(PROXY_OP_CMD_RAM_BASE_ADD, 10);
                  if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st1;
                  else
                     fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when new_int_cfg_st =>
                  new_cfg_id <= PROXY_INT_CMD_ID(7 downto 0);
                  cfg_ram_base_add <= to_unsigned(PROXY_INT_CMD_RAM_BASE_ADD, 10);
                  fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                  if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st1;
                  else
                     fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when new_diag_cfg_st =>
                  new_cfg_id <= PROXY_DIAG_CMD_ID(7 downto 0);
                  cfg_ram_base_add <= to_unsigned(PROXY_DIAG_CMD_RAM_BASE_ADD, 10);
                  fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                  if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st1;
                  else
                     fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when new_temp_cfg_st =>
                  new_cfg_id <= PROXY_TEMP_CMD_ID(7 downto 0);
                  cfg_ram_base_add <= to_unsigned(PROXY_TEMP_CMD_RAM_BASE_ADD, 10);
                  fpa_new_cfg_pending <= '1';              -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                  if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st1;
                  else
                     fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when new_windw_cfg_st =>
                  new_cfg_id <= PROXY_WINDW_CMD_ID(7 downto 0);
                  cfg_ram_base_add <= to_unsigned(PROXY_WINDW_CMD_RAM_BASE_ADD, 10);
                  fpa_new_cfg_pending <= '1';              -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                  if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st1;
                  else
                     fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when new_static_cfg_st =>
                  new_cfg_id <= PROXY_STATIC_CMD_ID(7 downto 0);
                  cfg_ram_base_add <= to_unsigned(PROXY_STATIC_CMD_RAM_BASE_ADD, 10);
                  fpa_new_cfg_pending <= '1';              -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                  if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st1;
                  else
                     fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when wait_prog_end_st =>
                  if fpa_driver_done_last = '0' and fpa_driver_done = '1' then
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= check_cfg_st1;
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
            serial_en_i <= '0';
            serial_abort_i <= '0';
            fpa_cfg_err <= '0';
            fpa_driver_seq_err <= '0';
            fpa_driver_done_last <= '0';
            --proxy_static_done <= '0';
            update_cfg_i <= '0';
            enable_prog_trig <= '0';
         else                       
            
            fpa_driver_done_last <= fpa_driver_done;  
            
            if SERIAL_FATAL_ERR = '1' then
               id_cmd_in_err <= serial_id_i;
            end if;
            
            --fsm de contrôle de la partie de config demandant la reprogrammarion du fpa  
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings			
            case  driver_seq_fsm is 
               
               when idle =>
                  enable_prog_trig <= '0';
                  fpa_driver_done <= '1'; 
                  fpa_cfg_err <= '0';
                  fpa_driver_rqst <= '0';                
                  update_cfg_i <= '0'; 
                  if SERIAL_DONE = '1' and fpa_new_cfg_pending = '1' and PROXY_POWERED = '1' then  -- ne jamais ajouter PROXY_RDY dans les conditions
                     driver_seq_fsm <= fpa_prog_rqst_st;
                  end if;
               
               when fpa_prog_rqst_st =>              -- demande pour programmer le fpa
                  fpa_driver_rqst <= '1'; 
                  if FPA_DRIVER_EN = '1' then
                     driver_seq_fsm <= fpa_prog_en_st;                     
                  end if;                  
               
               when fpa_prog_en_st =>        -- ordre de programmation du fpa       
                  fpa_driver_done <= '0';             
                  fpa_driver_rqst <= '0';
                  if fpa_new_cfg_pending = '1' then   -- on reverifie qu'il y a toujours une config en attente car il se pourrait q'une nouvelle config soit rentrée et egale à celle déjà dans le détecteur               
                     serial_en_i <= '1';
                     serial_abort_i <= '0';
                     serial_base_add_i <= std_logic_vector(cfg_ram_base_add);
                     serial_id_i <= new_cfg_id;
                     if SERIAL_DONE = '0' then 
                        serial_en_i <= '0';
                        fpa_ser_cfg_latch <= USER_CFG;   -- la config en cours de programmation est latchée -- à partir de ce moment dans le serializer, la config est copiée tres rapidement de la ram vers le fifo de sortie avant qu'une nouvelle n'arrive.
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
                     --else -- abandon seulement si on passe en mode diag
                     --                     if READOUT = '0' and (USER_CFG.COMN.FPA_DIAG_MODE = '1' or DIAG_MODE_ONLY = '1') then  -- si on n'arrive pas à clôturer la prog, C'est qu'il y a un problème. On peut toujors revenir en mode diag si souhaité. 
                     --                        driver_seq_fsm <= idle; 
                     --                        serial_abort_i <= '1';
                     --                     end if;  
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
                     update_cfg_i <= '1';             -- on lance la mise à jour des configs
                     driver_seq_fsm <= wait_updater_run_st;                     
                  end if;
               
               when wait_updater_run_st => 
                  if cfg_updater_done = '0' then
                     update_cfg_i <= '0';             
                     driver_seq_fsm <= pause_st1;                     
                  end if;                                                      
               
               when pause_st1 =>                                -- fait expres pour donner du temps à new_cfg_pending de tomber
                  if reset_clink_n = '1' then                   -- se rappeler que reset_clink_n est la forme contractée de "not reset_clink"
                     driver_seq_fsm <= prog_trig_st;  
                  else
                     driver_seq_fsm <= pause_st2; 
                  end if;      
                  
               when prog_trig_st => 
                  if serial_base_add_i = std_logic_vector(to_unsigned(PROXY_WINDW_CMD_RAM_BASE_ADD,10)) then
                     driver_seq_fsm <= wait_prog_trig_done_st;                  
                     enable_prog_trig <= '1';
                  else
                     driver_seq_fsm <= pause_st2;
                  end if;
                              
               when wait_prog_trig_done_st =>
                  enable_prog_trig <= '0';
                  if prog_trig_done = '1' then
                     driver_seq_fsm <= pause_st2;
                  end if;
               
               when pause_st2 => 
                  fpa_driver_done <= '1';                       -- fait expres pour new_cfg_pending_fsm
                  driver_seq_fsm <= pause_st3;
               
               when pause_st3 =>
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
            actual_cfg.proxy_op.proxy_gpol_mv <= (others => '0'); -- force la reprogrammation après un reset de power management   
            actual_cfg.proxy_int.proxy_int_time <= (others => '0');  
            actual_cfg.proxy_diag.proxy_test_pattern_activ <= '0'; 
            actual_cfg.proxy_windw.proxy_xsize <= (others => '0');
            actual_cfg.proxy_static.proxy_static_cmd_num <= (others => '0');
            
         else                                  
            
            case  cfg_updater_fsm is 
               
               when idle =>
                  cfg_updater_done <= '1'; 
                  if PROXY_POWERED = '0' then 
                     cfg_updater_fsm <= diag_only_st; 
                  else                                           
                     if update_cfg_i = '1' then 
                        cfg_updater_fsm <= wait_trig_st;
                        fpa_ser_cfg_to_update <= fpa_ser_cfg_latch;
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
               
               when wait_trig_st =>
                  cfg_updater_done <= '0';
                  if cfg_id_i = PROXY_TEMP_CMD_ID(7 downto 0) then -- pas besoin de trig pour la temperature. Ainsi on l'aura même en mode trig externe
                     cfg_updater_fsm <= output_temp_cfg_st; 
                  else
                     --if ACQ_TRIG = '1' or XTRA_TRIG = '1' then  -- la config est normalement valide au prochain trig. 
                     cfg_updater_fsm <= check_cfg_st1;    -- Si tel n'est pas le cas, pas grave
                     --end if;
                  end if;
               
               when check_cfg_st1 =>                           -- cet état est crée juste pour ameliorer timing
                  if cfg_id_i = PROXY_OP_CMD_ID(7 downto 0) then
                     cfg_updater_fsm <= output_op_cfg_st;
                  else
                     cfg_updater_fsm <= check_cfg_st2;
                  end if;
               
               when check_cfg_st2 =>                           -- cet état est crée juste pour ameliorer timing
                  if cfg_id_i = PROXY_INT_CMD_ID(7 downto 0) then
                     cfg_updater_fsm <= output_int_cfg_st;
                  else
                     cfg_updater_fsm <= check_cfg_st3;
                  end if;
               
               when check_cfg_st3 =>                           -- cet état est crée juste pour ameliorer timing
                  if cfg_id_i = PROXY_WINDW_CMD_ID(7 downto 0) then
                     cfg_updater_fsm <= output_windw_cfg_st;
                  else
                     cfg_updater_fsm <= check_cfg_st4;
                  end if;
               
               when check_cfg_st4 =>                           -- cet état est crée juste pour ameliorer timing
                  if cfg_id_i = PROXY_STATIC_CMD_ID(7 downto 0) then
                     cfg_updater_fsm <= output_static_cfg_st;
                  else
                     cfg_updater_fsm <= check_cfg_st5;
                  end if;
               
               when check_cfg_st5 =>                            -- cet état est crée juste pour ameliorer timing
                  if cfg_id_i = PROXY_DIAG_CMD_ID(7 downto 0) then
                     cfg_updater_fsm <= output_diag_cfg_st; 
                  else    -- on ne doiyt jamais avoir cette condition
                     --
                  end if;                 
               
               when output_op_cfg_st =>                         -- cet état est crée juste pour ameliorer timing
                  fpa_intf_cfg_i.proxy_op <= fpa_ser_cfg_to_update.proxy_op;
                  actual_cfg.proxy_op <= fpa_ser_cfg_to_update.proxy_op;
                  cfg_updater_fsm <= pause_st1;
               
               when output_int_cfg_st =>                        -- cet état est crée juste pour ameliorer timing
                  fpa_intf_cfg_i.proxy_int <= fpa_ser_cfg_to_update.proxy_int;
                  actual_cfg.proxy_int <= fpa_ser_cfg_to_update.proxy_int;  
                  cfg_updater_fsm <= pause_st1;
               
               when output_diag_cfg_st =>                       -- cet état est crée juste pour ameliorer timing
                  fpa_intf_cfg_i.proxy_diag <= fpa_ser_cfg_to_update.proxy_diag;
                  actual_cfg.proxy_diag <= fpa_ser_cfg_to_update.proxy_diag;  
                  cfg_updater_fsm <= pause_st1;
               
               when output_windw_cfg_st =>                       -- cet état est crée juste pour ameliorer timing
                  fpa_intf_cfg_i.proxy_windw <= fpa_ser_cfg_to_update.proxy_windw;
                  actual_cfg.proxy_windw <= fpa_ser_cfg_to_update.proxy_windw;  
                  cfg_updater_fsm <= pause_st1;
               
               when output_static_cfg_st =>                       -- cet état est crée juste pour ameliorer timing
                  fpa_intf_cfg_i.proxy_static <= fpa_ser_cfg_to_update.proxy_static;
                  actual_cfg.proxy_static <= fpa_ser_cfg_to_update.proxy_static;
                  proxy_static_done <= '1';     -- assure que le proxy est configurée avec la config statique. C'est important pour être certain par exemple qu'on est en mode Clibnk double base et non base.
                  cfg_updater_fsm <= pause_st1;
               
               when output_temp_cfg_st =>                       -- cet état est crée juste pour ameliorer timing
                  fpa_intf_cfg_i.proxy_temp <= fpa_ser_cfg_to_update.proxy_temp;
                  actual_cfg.proxy_temp <= fpa_ser_cfg_to_update.proxy_temp; 
                  cfg_updater_fsm <= pause_st1;   
               
               when pause_st1 =>                                -- fait expres pour donner du temps à new_cfg_pending de tomber
                  fpa_intf_cfg_i.comn <= fpa_ser_cfg_to_update.comn;
                  fpa_intf_cfg_i.proxy_misc <= fpa_ser_cfg_to_update.proxy_misc;
                  cfg_updater_fsm <= idle;
               
               when others =>
               
            end case;
            
            -- en mode full externe, le temps d'integration ci-dessous, surclasse tout temps d'integration 
            if MGLK_INT_SIGNAL_IS_EXTERNAL = '1' then 
               fpa_intf_cfg_i.proxy_int <= fpa_int_latch;
               actual_cfg.proxy_int <= fpa_int_latch;
            end if; 
            
         end if;
      end if;
   end process;   
   
   --------------------------------------------------
   -- Genereteur de l'horloge du FPA
   -------------------------------------------------- 
   UcA: Clk_Divider
   Generic map(Factor=> FPA_MCLK_RATE_FACTOR)
   Port map( Clock => CLK, Reset => sreset, Clk_div => fpa_mclk_raw);
   
   --------------------------------------------------
   -- Pour ameliorer timing
   --------------------------------------------------   
   UcB: process(CLK)
   begin 
      if rising_edge(CLK) then 
         fpa_mclk_i <= fpa_mclk_raw;
         fpa_mclk_p(0) <= fpa_mclk_i;
         fpa_mclk_p(1) <= fpa_mclk_p(0);
         fpa_mclk_p(2) <= fpa_mclk_p(1);          
      end if;    
   end process; 
   
   --------------------------------------------------
   --  generation de acq_int_i et fpa_int_i
   --------------------------------------------------
   -- acq_int_i
   -- acq_int_i est destiné à signifier aux modules externes (TimeStamper, SFW etc...) le véritable instant de l'intégration
   U6 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            int_gen_fsm <= idle;
            acq_int_i <= '0'; 
            proxy_int_feedbk_i <= '0';
            proxy_int_feedbk_last <= '0';
            frame_id_i <= (others => '0');
            acq_frame <= '0';
            --int_indx_i <= (others => '0');
            Allow_IntTimeChange <= '0';
            
         else
            
            proxy_int_feedbk_i <= PROXY_INT_FBK;
            proxy_int_feedbk_last <= proxy_int_feedbk_i;
            
            fpa_mclk_last <= fpa_mclk_i;
            fpa_mclk_rising_edge <= not fpa_mclk_last and fpa_mclk_i;
            
            -- fsm de generation de acq_int_i           
            case  int_gen_fsm is 
               
               when idle =>
                  Allow_IntTimeChange <= '1';
                  acq_int_i <= '0';
                  cnt <= (others => '0');                 
                  acq_frame <= '0';
                  fpa_int_i <= '0';
                  if ACQ_TRIG = '1' then    -- ACQ_TRIG uniquement car ne jamais envoyer acq_int_i en mode XTRA_TRIG
                     frame_id_i <= frame_id_i + 1;
                     --int_indx_i <= fpa_intf_cfg_i.proxy_int.proxy_int_indx;
                     fpa_int_latch <= USER_CFG.PROXY_INT;
                     acq_frame <= '1';
                     if fpa_intf_cfg_i.comn.fpa_diag_mode = '1' then              
                        int_gen_fsm <= diag_int_dly_st;
                     else
                        int_gen_fsm <= check_fpa_st;
                     end if;
                  elsif XTRA_TRIG = '1' then    -- 
                     --frame_id_i <= frame_id_i + 1; -- on ne change pas d'ID en xtraTrig pour que le client ne voit aucune discontinuité dans les ID
                     --int_indx_i <= fpa_intf_cfg_i.proxy_int.proxy_int_indx;
                     fpa_int_latch <= USER_CFG.PROXY_INT;
                     acq_frame <= '0';
                     if fpa_intf_cfg_i.comn.fpa_diag_mode = '1' then              
                        int_gen_fsm <= diag_int_dly_st;
                     else
                        int_gen_fsm <= check_fpa_st;
                     end if;
                  end if;
               
               when check_fpa_st =>                  
                  if FPA_INT_FBK_AVAILABLE = '1' then                  -- FPA_INT_TIME_FBK_AVAILABLE dans fpa_define et dit si le proxy peut nous renvoyer un feedback d'intégration
                     acq_int_i <= PROXY_INT_FBK and acq_frame;
                     fpa_int_i <= PROXY_INT_FBK;
                     if proxy_int_feedbk_i = '0' and proxy_int_feedbk_last = '1' then -- on attend la fin du feedback
                        int_gen_fsm <= idle;
                     end if;
                  else
                     int_gen_fsm <= diag_int_dly_st;           -- sinon, nous generons le feedback comme on le ferait en mode diag
                  end if;
               
               when diag_int_dly_st => 
                  if cnt >= fpa_intf_cfg_i.proxy_misc.proxy_fig2_t4_dly then    -- FPA_INTF_CFG.fpa_fig1_or_fig2_t4_dly est le delai T4 sur les figures 1 et 2 du document Communication protocol appendix A5 (SPEC. NO: DPS3008) dans le dossier du pelicanD
                     int_gen_fsm <= diag_exp_rst_cnt_st;
                  else                        
                     cnt <= cnt + 1;                
                  end if;
                  int_signal_time_high_time <= to_integer(fpa_int_latch.proxy_int_time) + FPA_INT_TIME_OFFSET_MCLK; 
               
               when diag_exp_rst_cnt_st =>
                  cnt <= (others => '0');
                  int_gen_fsm <= diag_int_gen_st;
               
               when diag_int_gen_st =>           
                  Allow_IntTimeChange <= '0';
                  if fpa_mclk_rising_edge = '1' then
                     if cnt >= int_signal_time_high_time then    -- 
                        fpa_int_i <= '0';
                        acq_int_i <= '0';
                        int_gen_fsm <= idle;
                     else                        
                        cnt <= cnt + 1; 
                        fpa_int_i <= '1'; 
                        acq_int_i <= (acq_frame and fpa_intf_cfg_i.comn.fpa_diag_mode) or (acq_frame and PROXY_RDY and not fpa_intf_cfg_i.comn.fpa_diag_mode);              
                     end if;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process; 
   
   U7 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            prog_trig_i <= '0';
            img_cnt <= 0;
            prog_trig_state <= idle;
            prog_trig_done <= '0';
         else
            
            case prog_trig_state is
               when idle =>      
                  
                  prog_trig_i <= '0';
                  prog_trig_done <= '0';
                  img_cnt <= 0;
                  if enable_prog_trig = '1' then
                     prog_trig_state <= img_start;
                  end if;
               
               when img_start =>
                  
                  prog_trig_i <= '1';
                  prog_trig_done <= '0';
                  
                  if READOUT = '1' then
                     prog_trig_state <= img_end;
                  end if;
               
               when img_end =>
                  
                  if READOUT = '0' then
                     img_cnt <= img_cnt + 1;
                     prog_trig_state <= check_done;
                  end if;
               
               when check_done =>
                  
                  if img_cnt = FPA_XTRA_IMAGE_NUM_TO_SKIP then 
                     prog_trig_state <= idle;
                     prog_trig_done <= '1';
                  else
                     prog_trig_state <= img_start;
                  end if;
               
               when others =>
            end case;
         end if;
      end if;
   end process;
   
end rtl;
