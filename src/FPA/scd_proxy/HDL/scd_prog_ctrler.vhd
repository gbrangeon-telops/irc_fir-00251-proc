------------------------------------------------------------------
--!   @file : scd_prog_ctrler
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
use work.Proxy_define.all; 
use work.fpa_common_pkg.all;
use work.tel2000.all;

entity scd_prog_ctrler is
   port(
      ARESET               : in std_logic;
      CLK                  : in std_logic;
      
      USER_CFG             : in fpa_intf_cfg_type;  -- la cfg valide envoy�e par l'usager est ici
      USER_CFG_IN_PROGRESS : in std_logic;          -- � '1' lorsque USER_CFG et son �quivalent seriel sont en cours d'envoi par le mblaze
      
      READOUT              : in std_logic;
      
      PROXY_INT_FBK        : in std_logic;
      PROXY_POWERED        : in std_logic;
      
      FPA_POWER            : in std_logic;
      FPA_DRIVER_EN        : in std_logic;
      DIAG_MODE_ONLY       : in std_logic;
      
      ACQ_TRIG             : in std_logic;   -- ACQ_TRIG et XTRA_TRIG sont genrer�s que si le proxy est allum� ou si on est en mode diag.
      XTRA_TRIG            : in std_logic;
      
      FPA_INTF_CFG         : out fpa_intf_cfg_type;
      
      PROXY_RDY            : in std_logic;   -- PROXY_RDY signifie qu'au moins une r�ponse a �t� re�ue avec succ�s. 
      SERIAL_EN            : out std_logic;
      SERIAL_ABORT         : out std_logic;   --
      SERIAL_DONE          : in std_logic;
      SERIAL_FATAL_ERR     : in std_logic;
      SERIAL_BASE_ADD      : out std_logic_vector(8 downto 0);
      
      RAM_ERR              : in std_logic;
      
      PROXY_PWR            : out std_logic;
      PROXY_TRIG           : out std_logic;
      FPA_DRIVER_STAT      : out std_logic_vector(31 downto 0);
      FRAME_ID             : out std_logic_vector(31 downto 0); --  synchronis� avec ACQ_INT
      INT_INDX             : out std_logic_vector(7 downto 0);
      INT_TIME             : out std_logic_vector(24 downto 0);
      ACQ_INT              : out std_logic;  -- feedback d'integration d'une image � envoyer dans la chaine.
      FPA_INT              : out std_logic;  -- feedback d'integration d'une image. (requis pour le module de generation des donn�es en diag)
      RST_CLINK_N          : out std_logic;
      FAILURE_RESP_MNG     : out std_logic
      
      );                 
end scd_prog_ctrler;

architecture rtl of scd_prog_ctrler is
   
   
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component; 
   
   type driver_seq_fsm_type  is (idle, diag_only_st, fpa_prog_rqst_st, fpa_prog_en_st, wait_new_cfg_end_st,
   wait_fpa_prog_end_st, check_fpa_ser_fatal_err_st, wait_trig_st, check_cfg_st, pause_st1, pause_st2, 
   output_op_cfg_st, output_int_cfg_st, output_diag_cfg_st, output_temp_cfg_st, output_frame_res_cfg_st, check_cfg_st1, check_cfg_st2, check_cfg_st3, check_cfg_st4, wait_updater_rdy_st, wait_updater_run_st);
   type int_gen_fsm_type is (idle, diag_int_dly_st, check_fpa_st, diag_exp_rst_cnt_st, diag_exp_int_gen_st, diag_int_gen_st);
   type new_cfg_pending_fsm_type is(idle, wait_prog_end_st, check_cfg_st1, check_cfg_st2, check_cfg_st3, check_cfg_st4, check_cfg_st5, new_op_cfg_st, new_int_cfg_st, new_temp_cfg_st, new_diag_cfg_st, new_frame_res_cfg_st);
   
   signal driver_seq_fsm            : driver_seq_fsm_type;
   signal cfg_updater_fsm           : driver_seq_fsm_type;
   signal init_cfg_updater_st       : driver_seq_fsm_type;
   signal int_gen_fsm               : int_gen_fsm_type;
   signal new_cfg_pending_fsm       : new_cfg_pending_fsm_type;
   signal init_check_cfg_st         : new_cfg_pending_fsm_type;
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
   signal fpa_ser_cfg_to_update     : fpa_intf_cfg_type;
   signal serial_en_i               : std_logic;
   signal fpa_ser_cfg_latch         : fpa_intf_cfg_type;
   signal cnt                       : unsigned(31 downto 0);
   signal proxy_int_feedbk_i        : std_logic;
   signal proxy_int_feedbk_last     : std_logic;
   signal acq_frame                 : std_logic;
   signal user_cfg_in_progress_last : std_logic;
   signal int_indx_i                : std_logic_vector(7 downto 0); 
   signal int_time_i                : std_logic_vector(FPA_INTF_CFG.SCD_INT.SCD_INT_TIME'LENGTH-1 downto 0);
   signal new_cfg_id                : std_logic_vector(7 downto 0);
   signal serial_base_add_i         : std_logic_vector(SERIAL_BASE_ADD'length-1 downto 0);
   signal cfg_ram_base_add          : unsigned(SERIAL_BASE_ADD'length-1 downto 0);
   signal serial_id_i               : std_logic_vector(7 downto 0);
   signal cfg_id_i                  : std_logic_vector(7 downto 0);
   signal fpa_driver_done_last      : std_logic;
   signal serial_abort_i            : std_logic;
   signal reset_clink_n             : std_logic;
   signal update_cfg_i              : std_logic;
   signal cfg_updater_done          : std_logic;
   signal proxy_static_done         : std_logic;
   signal id_cmd_in_err             : std_logic_vector(7 downto 0);
   signal need_prog_rqst            : std_logic;
   signal enable_serdes_init        : std_logic := '0'; 
   signal enable_serial_exptime_cmd        : std_logic := '0';
   signal enable_failure_resp_management   : std_logic := '0';
   
         
   
   

--   attribute keep                                   : string;
--   attribute keep of driver_seq_fsm                 : signal is "true";
--   attribute keep of cfg_updater_fsm                : signal is "true";
--   attribute keep of int_gen_fsm                    : signal is "true";
--   attribute keep of new_cfg_pending_fsm            : signal is "true"; 
--   attribute keep of acq_int_i                      : signal is "true";
--   attribute keep of fpa_int_i                      : signal is "true";
--   attribute keep of fpa_powered                    : signal is "true";                       
--   attribute keep of fpa_intf_cfg_i                 : signal is "true";   
--   attribute keep of reset_clink_n                  : signal is "true"; 
begin
      
   NO_FRAME_RES_CONFIG_NEEDED : if (PROXY_NEED_FRAME_RES_CONFIG = '0') generate -- PelicanD & HerculeD
   begin  
      init_check_cfg_st    <= check_cfg_st2;
      init_cfg_updater_st  <= check_cfg_st2; 
   end generate;
   
   FRAME_RES_CONFIG_NEEDED : if (PROXY_NEED_FRAME_RES_CONFIG = '1') generate  -- Blackbird1280D
   begin  
      init_check_cfg_st    <= check_cfg_st1;
      init_cfg_updater_st  <= check_cfg_st1;  
   end generate;  
   

   
   -------------------------------------------------
   -- mappings                                                   
   -------------------------------------------------
   SERIAL_BASE_ADD  <= serial_base_add_i;
   SERIAL_EN        <= serial_en_i;
   SERIAL_ABORT     <= serial_abort_i;
   INT_INDX         <= int_indx_i;                     --  synchronsi� avec ACQ_INT et FPA_INT
   FRAME_ID         <= std_logic_vector(frame_id_i);  --  synchronsi� avec ACQ_INT
   ACQ_INT          <= acq_int_i;  -- acq_int_i n'existe pas en extraTrig. De plus il signale � coup s�re une integration. Ainsi toute donn�e de detecteur ne faisant pas suite � acq_trig, provient de extra_trig
   FPA_INT          <= fpa_int_i;   -- fpa_int_i existe pour toute integration (que l'image soit � envoyer dans la chaine ou non)
   PROXY_TRIG       <= ACQ_TRIG or XTRA_TRIG; -- PROXY_TRIG sera regener� avec la dur�e adequate et avec une bascule dans le module scd_driver_output 
   FPA_INTF_CFG     <= fpa_intf_cfg_i;  -- sortie de la config
   RST_CLINK_N      <= reset_clink_n;
   INT_TIME         <= int_time_i; 
   FAILURE_RESP_MNG <= enable_failure_resp_management;
    
                  
   FPA_DRIVER_STAT(31 downto 16) <= (others => '0');
   FPA_DRIVER_STAT(15 downto 8) <= id_cmd_in_err;
   FPA_DRIVER_STAT(7) <= '0'; 
   FPA_DRIVER_STAT(6) <= '0'; 
   FPA_DRIVER_STAT(5) <= RAM_ERR;           -- erreur de colision dans la ram (� �viter)
   FPA_DRIVER_STAT(4) <= fpa_powered; 
   FPA_DRIVER_STAT(3) <= fpa_driver_seq_err;-- 
   FPA_DRIVER_STAT(2) <= fpa_cfg_err;       -- fpa_cfg_err toute erreur de programmation retourn�e par le d�tecteur
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
   -- doit �tre dans un process ind�pendant 
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            PROXY_PWR <= '0'; 
            fpa_powered <= '0';
            reset_clink_n <= '0';
         else                  
            PROXY_PWR <= FPA_POWER; 
            fpa_powered <= PROXY_POWERED and PROXY_RDY;  -- PROXY_POWERED signifie que le proxy est juste allum�. PROXY_RDY signifie qu'au moins une r�ponse a �t� re�ue avec succ�s.              
            reset_clink_n <= PROXY_POWERED and PROXY_RDY and proxy_static_done and enable_serdes_init;  -- il faut que le module clink soit en reset tant que le proxy n'est pas pr�t
         end if;          
      end if;
   end process;
   
   ------------------------------------------------
   -- Voir s'il faut programmer le d�tecteur
   ------------------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            fpa_new_cfg_pending <= '0';
            user_cfg_in_progress_i <= '0';
            user_cfg_in_progress_last <= '0';
            new_cfg_pending_fsm <= init_check_cfg_st;
			   need_prog_rqst <= '0'; 
             
         else 
            
            user_cfg_in_progress_i <= USER_CFG_IN_PROGRESS;  -- user_cfg_in_progress_i est requis pour une sychro parfaite avec new_fpa_word
            user_cfg_in_progress_last <= user_cfg_in_progress_i;
            user_cfg_in_progress_last <= user_cfg_in_progress_i;
            enable_serdes_init <= USER_CFG.enable_serdes_init;
            enable_serial_exptime_cmd <= USER_CFG.enable_serial_exptime_cmd;
            enable_failure_resp_management <= USER_CFG.enable_failure_resp_management;
            
           -- on retient les champs de la config qui requierent une programmation du d�tecteur
            -- config entrante synchronis� sur l'horloge local
            new_cfg.scd_op        <= USER_CFG.SCD_OP;   
            new_cfg.scd_int       <= USER_CFG.SCD_INT;  
            new_cfg.scd_diag      <= USER_CFG.SCD_DIAG; 
            new_cfg.scd_frame_res <= USER_CFG.SCD_FRAME_RES;
            new_cfg.scd_temp      <= USER_CFG.SCD_TEMP; 
            new_cfg.scd_misc      <= USER_CFG.SCD_MISC; 
            new_cfg.aoi_data      <= USER_CFG.AOI_DATA;
            
            -- d�tection nouvelle programmation (fsm pour reduire les probl�mes de timing)
            -- la machine a �tats comporte plusieurs �tats afin d'ameliorer les timings	
            case new_cfg_pending_fsm is			  
                                                                    
               when check_cfg_st1 =>
                  if new_cfg.scd_frame_res /= present_cfg.scd_frame_res and proxy_static_done = '1' then    
                     new_cfg_pending_fsm <= new_frame_res_cfg_st;	
                  else
                     new_cfg_pending_fsm <= check_cfg_st2;
                  end if;
               
               when check_cfg_st2 =>
                  if new_cfg.scd_op /= present_cfg.scd_op then
                     new_cfg_pending_fsm <= new_op_cfg_st;
                  else
                     new_cfg_pending_fsm <= check_cfg_st3;
                  end if;
               
               when check_cfg_st3 =>
                  if new_cfg.scd_int /= present_cfg.scd_int and enable_serial_exptime_cmd = '1' then
                     new_cfg_pending_fsm <= new_int_cfg_st;					 
                  else
                     new_cfg_pending_fsm <= check_cfg_st4;  
                  end if;
               
               when check_cfg_st4 =>
                  if new_cfg.scd_diag /= present_cfg.scd_diag then
                     new_cfg_pending_fsm <= new_diag_cfg_st;
                  else
                     new_cfg_pending_fsm <= check_cfg_st5;
                  end if;
               
               when check_cfg_st5 =>
                  if new_cfg.scd_temp /= present_cfg.scd_temp then
                     new_cfg_pending_fsm <= new_temp_cfg_st;					 
                  else
                     new_cfg_pending_fsm <= init_check_cfg_st;
                  end if;

               when new_op_cfg_st =>
                  new_cfg_id <= SCD_OP_CMD_ID(7 downto 0);     -- les 7 derniers bits suffisent largement
                  cfg_ram_base_add <= to_unsigned(SCD_OP_CMD_RAM_BASE_ADD, SERIAL_BASE_ADD'length);
				      need_prog_rqst <= '1'; 				       -- op_cfg : requete aupr�s du fpa_hw_sequencer necessaire afin qu'il arr�te les trigs
                  if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= init_check_cfg_st;
                  else
				         fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when new_int_cfg_st =>
                  new_cfg_id <= SCD_INT_CMD_ID(7 downto 0);
                  cfg_ram_base_add <= to_unsigned(SCD_INT_CMD_RAM_BASE_ADD, SERIAL_BASE_ADD'length);
                  fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                  need_prog_rqst <= '0'; 				    -- int_cfg : requete aupr�s du fpa_hw_sequencer non necessaire car on peut faire la prog sans arr�ter les trigs
				      if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= init_check_cfg_st;
                  else
				         fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when new_diag_cfg_st =>
                  new_cfg_id <= SCD_DIAG_CMD_ID(7 downto 0);
                  cfg_ram_base_add <= to_unsigned(SCD_DIAG_CMD_RAM_BASE_ADD, SERIAL_BASE_ADD'length);
                  fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                  need_prog_rqst <= '1'; 				    -- diag_cfg : requete aupr�s du fpa_hw_sequencer necessaire afin qu'il arr�te les trigs 
				      if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= init_check_cfg_st;
                  else
				         fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;

               when new_temp_cfg_st =>
                  new_cfg_id <= SCD_TEMP_CMD_ID(7 downto 0);
                  cfg_ram_base_add <= to_unsigned(SCD_TEMP_CMD_RAM_BASE_ADD, SERIAL_BASE_ADD'length);
                  fpa_new_cfg_pending <= '1';              -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                  need_prog_rqst <= '0'; 				   -- temp_cfg : requete aupr�s du fpa_hw_sequencer non necessaire car on peut faire la prog sans arr�ter les trigs
				      if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= init_check_cfg_st;
                  else
				         fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
               
               when new_frame_res_cfg_st =>
                  new_cfg_id <= SCD_FRAME_RES_CMD_ID(7 downto 0);
                  cfg_ram_base_add <= to_unsigned(SCD_FRAME_RES_CMD_RAM_BASE_ADD, SERIAL_BASE_ADD'length);
                  fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                  need_prog_rqst <= '1'; 				         -- frame_res_cfg : requete aupr�s du fpa_hw_sequencer necessaire afin qu'il arr�te les trigs 
				      if user_cfg_in_progress_i = '1' then 
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= init_check_cfg_st;
                  else
				         fpa_new_cfg_pending <= '1';               -- pour parfaite synchro avec new_cfg_id et cfg_ram_base_add. Demande de programmation ssi aucune config en progression
                     new_cfg_pending_fsm <= wait_prog_end_st;
                  end if;
                  
               when wait_prog_end_st =>
                  if fpa_driver_done_last = '0' and fpa_driver_done = '1' then
                     fpa_new_cfg_pending <= '0';
                     new_cfg_pending_fsm <= init_check_cfg_st;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   -----------------------------------------------------------------
   --  S�quen�age des operations de programmation du d�tecteur 
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
            update_cfg_i <= '0';
            id_cmd_in_err <= (others => '1'); -- fait express car cette commande id n'existe pas pour le Megalink
            
         else                       
            
            fpa_driver_done_last <= fpa_driver_done;
            --fsm de contr�le de la partie de config demandant la reprogrammarion du fpa  
            -- la machine a �tats comporte plusieurs �tats afin d'ameliorer les timings
            
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
               
               when fpa_prog_rqst_st =>              -- demande pour programmer le fpa. Elle se soldera par l'arr�t du contr�leur de trig
                  fpa_driver_rqst <= '1'; 
                  if FPA_DRIVER_EN = '1' then
                     driver_seq_fsm <= fpa_prog_en_st;                     
                  end if;                  
               
               when fpa_prog_en_st =>        -- ordre de programmation du fpa       
                  fpa_driver_done <= '0';             
                  fpa_driver_rqst <= '0';
                  if fpa_new_cfg_pending = '1' then   -- on reverifie qu'il y a toujours une config en attente car il se pourrait q'une nouvelle config soit rentr�e et egale � celle d�j� dans le d�tecteur               
                     serial_en_i <= '1';
                     serial_abort_i <= '0';
                     serial_base_add_i <= std_logic_vector(cfg_ram_base_add);
                     serial_id_i <= new_cfg_id;
                     if SERIAL_DONE = '0' then 
                        serial_en_i <= '0';
                        fpa_ser_cfg_latch <= USER_CFG;   -- la config en cours de programmation est latch�e -- � partir de ce moment dans le serializer, la config est copi�e tres rapidement de la ram vers le fifo de sortie avant qu'une nouvelle n'arrive.
                        driver_seq_fsm <= wait_fpa_prog_end_st;                        
                     end if;
                  else      -- � ce stade c'est qu'il y a une autre config entrain de rentrer 
                     driver_seq_fsm <= wait_new_cfg_end_st; -- on attend qu'elle rentre pour que user_cfg_pending repasse � '1'
                  end if;
               
               when wait_new_cfg_end_st => 
                  if user_cfg_in_progress_i = '0' and user_cfg_in_progress_last = '0' then   -- assure qu'aucune cfg n'est en progression
                     if fpa_new_cfg_pending = '1' then
                        driver_seq_fsm <= fpa_prog_en_st;
                     else            -- la nouvelle config rentr�e n'est pas differente de l'actuelle dans la camera
                        driver_seq_fsm <= idle;
                     end if;    
                  end if;
               
               when wait_fpa_prog_end_st =>  -- attente de la fin de la programmation      
                  if SERIAL_DONE = '1' then 
                     driver_seq_fsm <= check_fpa_ser_fatal_err_st;
                  end if;
               
               when check_fpa_ser_fatal_err_st =>      -- apr�s plusieurs essais de programmation le module serial sortira une erreur fatale                      
                  if SERIAL_FATAL_ERR = '1' then
                     fpa_cfg_err <= '1';               -- en cas d'erreur fatale, on s'en va en idle mais la config n'est pas programm�e.Il ne fauit jamais avoir cette erreur 
                     driver_seq_fsm <= idle;
                  else
                     driver_seq_fsm <= wait_updater_rdy_st;
                  end if; 
               
               when wait_updater_rdy_st =>
                  if cfg_updater_done = '1' then
                     update_cfg_i <= '1';             -- on lance la mise � jour des configs
                     driver_seq_fsm <= wait_updater_run_st;                     
                  end if;
               
               when wait_updater_run_st => 
                  if cfg_updater_done = '0' then
                     update_cfg_i <= '0';             
                     driver_seq_fsm <= pause_st1;                     
                  end if;                  
               
               when pause_st1 =>                                -- fait expres pour donner du temps � new_cfg_pending de tomber
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
   --  mise � jour des configs
   ----------------------------------------------------------------
   -- decoupl� du sequenceur pour une mise � jour de trame en trame
   U5 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            cfg_updater_fsm <=  idle;
            cfg_updater_done <= '0';           
            present_cfg.scd_op.scd_xsize <= (others => '0');  -- cette initialisation force la reprogrammation du d�tecteur apr�s un reset de power management
            present_cfg.scd_temp.scd_temp_read_num <= (others => '0');  -- cette initialisation force la reprogrammation du d�tecteur apr�s un reset de power management
            present_cfg.scd_diag.scd_bit_pattern <= (others => '1'); -- cette initialisation force la reprogrammation du d�tecteur apr�s un reset                   
            
         else                       
            
            -- ENO 14 juillet 2016: requis pour supporter instabilit�s de la roue � filtre. Mettre � jour m�me si d�tecteur n'est pas reprogramm�
            fpa_intf_cfg_i.comn.fpa_stretch_acq_trig <= USER_CFG.comn.fpa_stretch_acq_trig;
            
            case  cfg_updater_fsm is 
               
               when idle =>
                  cfg_updater_done <= '1'; 
                  if PROXY_POWERED = '0' then 
                     cfg_updater_fsm <= diag_only_st; 
                  else            -- si on n'est pas en mode diag_only, c'est que le ADC/DDC est connect� et allum�                               
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
                  if cfg_id_i = SCD_TEMP_CMD_ID(7 downto 0) then -- pas besoin de trig poour lea temperature. Ainsi on l'aura m�me en mode trig externe
                     cfg_updater_fsm <= check_cfg_st4; 
                  else
                     cfg_updater_fsm <= init_cfg_updater_st;    -- Si tel n'est pas le cas, pas grave car les parametres mportants du header (Xsize, Ysize, intime etc) proviennent du header de l'image scd
                  end if;
               
               when check_cfg_st1 =>                            -- cet �tat est cr�e juste pour ameliorer timing
                  if cfg_id_i = SCD_FRAME_RES_CMD_ID(7 downto 0) then
                     cfg_updater_fsm <= output_frame_res_cfg_st; 
                  else    
                     cfg_updater_fsm <= check_cfg_st2;
                  end if;
                  
               when check_cfg_st2 =>                           -- cet �tat est cr�e juste pour ameliorer timing
                  if cfg_id_i = SCD_OP_CMD_ID(7 downto 0) then
                     cfg_updater_fsm <= output_op_cfg_st;
                  else
                     cfg_updater_fsm <= check_cfg_st3;
                  end if;
               
               when check_cfg_st3 =>                           -- cet �tat est cr�e juste pour ameliorer timing
                  if cfg_id_i = SCD_INT_CMD_ID(7 downto 0) then
                     cfg_updater_fsm <= output_int_cfg_st;
                  else
                     cfg_updater_fsm <= check_cfg_st4;
                  end if;
               
               when check_cfg_st4 =>                            -- cet �tat est cr�e juste pour ameliorer timing
                  if cfg_id_i = SCD_DIAG_CMD_ID(7 downto 0) then
                     cfg_updater_fsm <= output_diag_cfg_st; 
                  else    -- cfg_id_i = SCD_TEMP_CMD_ID(7 downto 0)
                     cfg_updater_fsm <= output_temp_cfg_st;
                  end if;                 
                  
                  
               when output_op_cfg_st =>                         -- cet �tat est cr�e juste pour ameliorer timing
                  fpa_intf_cfg_i.scd_op <= fpa_ser_cfg_to_update.scd_op;
                  fpa_intf_cfg_i.fpa_serdes_lval_num <= fpa_ser_cfg_to_update.scd_op.scd_ysize;  
                  if SCD_CROPPING_NEEDED = '0' then
                     fpa_intf_cfg_i.fpa_serdes_lval_len <= fpa_ser_cfg_to_update.scd_op.scd_xsize / PROXY_CLINK_PIXEL_NUM; 
                  else
                     fpa_intf_cfg_i.fpa_serdes_lval_len <= to_unsigned(XSIZE_MAX, fpa_intf_cfg_i.fpa_serdes_lval_len'length) / PROXY_CLINK_PIXEL_NUM;
                  end if;
                  
                  present_cfg.scd_op <= fpa_ser_cfg_to_update.scd_op;
                  proxy_static_done <= '1';
                  cfg_updater_fsm <= pause_st1;
                   
               when output_int_cfg_st =>                        -- cet �tat est cr�e juste pour ameliorer timing
                  fpa_intf_cfg_i.scd_int <= fpa_ser_cfg_to_update.scd_int;
				      fpa_intf_cfg_i.int_time <= resize(fpa_ser_cfg_to_update.scd_int.scd_int_time, 32);
                  present_cfg.scd_int <= fpa_ser_cfg_to_update.scd_int;  
                  cfg_updater_fsm <= pause_st1;
                  
               when output_diag_cfg_st =>                       -- cet �tat est cr�e juste pour ameliorer timing
                  fpa_intf_cfg_i.scd_diag <= fpa_ser_cfg_to_update.scd_diag;
                  present_cfg.scd_diag <= fpa_ser_cfg_to_update.scd_diag;  
                  cfg_updater_fsm <= pause_st1;    
                  
               when output_frame_res_cfg_st =>                       -- cet �tat est cr�e juste pour ameliorer timing
                  fpa_intf_cfg_i.scd_frame_res <= fpa_ser_cfg_to_update.scd_frame_res;
                  present_cfg.scd_frame_res <= fpa_ser_cfg_to_update.scd_frame_res;
                  cfg_updater_fsm <= pause_st1; 
                  
               when output_temp_cfg_st =>                       -- cet �tat est cr�e juste pour ameliorer timing
                  fpa_intf_cfg_i.scd_temp <= fpa_ser_cfg_to_update.scd_temp;
                  present_cfg.scd_temp <= fpa_ser_cfg_to_update.scd_temp; 
                  cfg_updater_fsm <= pause_st1;   
               
               when pause_st1 =>                                -- fait expres pour donner du temps � new_cfg_pending de tomber
                  fpa_intf_cfg_i.comn <= fpa_ser_cfg_to_update.comn;
                  fpa_intf_cfg_i.scd_misc <= fpa_ser_cfg_to_update.scd_misc;
                  fpa_intf_cfg_i.aoi_data <= fpa_ser_cfg_to_update.aoi_data;
                  cfg_updater_fsm <= idle;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;   
   
   
   --------------------------------------------------
   --  generation de acq_int_i et fpa_int_i
   --------------------------------------------------
   -- acq_int_i
   -- acq_int_i est destin� � signifier aux modules externes (TimeStamper, SFW etc...) le v�ritable instant de l'int�gration
   U6 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            int_gen_fsm <= idle;
            acq_int_i <= '0';
            fpa_int_i <= '0';
            proxy_int_feedbk_i <= '0';
            proxy_int_feedbk_last <= '0';
            frame_id_i <= (others => '0');
            acq_frame <= '0';
            int_indx_i <= (others => '0');
            int_time_i <= (others => '0');
         else
            
            proxy_int_feedbk_i <= PROXY_INT_FBK;
            proxy_int_feedbk_last <= proxy_int_feedbk_i;
            
            -- fsm de generation de acq_int_i           
            case  int_gen_fsm is 
               
               when idle =>
                  acq_int_i <= '0';
                  cnt <= (others => '0');                 
                  acq_frame <= '0';
                  fpa_int_i <= '0';
                  if ACQ_TRIG = '1' then    -- ACQ_TRIG uniquement car ne jamais envoyer acq_int_i en mode XTRA_TRIG
                     frame_id_i <= frame_id_i + 1;
                     int_indx_i <= fpa_intf_cfg_i.scd_int.scd_int_indx;
                     int_time_i <= std_logic_vector(fpa_intf_cfg_i.scd_int.scd_int_time);
                     acq_frame <= '1';
                     if fpa_intf_cfg_i.comn.fpa_diag_mode = '1' then              
                        int_gen_fsm <= diag_int_dly_st;
                     else
                        int_gen_fsm <= check_fpa_st;
                     end if;
                  elsif XTRA_TRIG = '1' then    -- 
                     --frame_id_i <= frame_id_i + 1; -- on ne change pas d'ID en xtraTrig pour que le client ne voit aucune discontinuit� dans les ID
                     int_indx_i <= fpa_intf_cfg_i.scd_int.scd_int_indx; 
                     int_time_i <= std_logic_vector(fpa_intf_cfg_i.scd_int.scd_int_time);
                     acq_frame <= '0';
                     if fpa_intf_cfg_i.comn.fpa_diag_mode = '1' then              
                        int_gen_fsm <= diag_int_dly_st;
                     else
                        int_gen_fsm <= check_fpa_st; 
                     end if;
                  end if;
               
               when check_fpa_st =>                  
                  if FPA_INT_FBK_AVAILABLE = '1' then                  -- FPA_INT_TIME_FBK_AVAILABLE dans fpa_define et dit si le proxy peut nous renvoyer un feedback d'int�gration
                     acq_int_i <= PROXY_INT_FBK and acq_frame;
                     fpa_int_i <= PROXY_INT_FBK;
                     if proxy_int_feedbk_i = '0' and proxy_int_feedbk_last = '1' then -- on attend la fin du feedback
                        int_gen_fsm <= idle;
                     end if;
                  else
                     int_gen_fsm <= diag_int_dly_st;           -- sinon, nous generons le feedback comme on le ferait en mode diag
                  end if;
               
               when diag_int_dly_st => 
                  if cnt >= fpa_intf_cfg_i.scd_misc.scd_fsync_re_to_intg_start_dly then  
                     int_gen_fsm <= diag_exp_rst_cnt_st;
                  else                        
                     cnt <= cnt + 1;                
                  end if;   
               
               when diag_exp_rst_cnt_st =>
                  cnt <= (others => '0');
                  int_gen_fsm <= diag_int_gen_st;
               
               when diag_int_gen_st =>           
                  fpa_int_i <= '1';
                  if fpa_intf_cfg_i.comn.fpa_diag_mode = '1' then 
                     acq_int_i <= acq_frame;  
                  else
                     acq_int_i <= acq_frame and PROXY_RDY; 
                  end if;
                  
                  if cnt >= fpa_intf_cfg_i.scd_int.scd_int_time then    -- 
                     int_gen_fsm <= idle;
                  else                        
                     cnt <= cnt + 1;                
                  end if;

               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process; 
   
end rtl;
