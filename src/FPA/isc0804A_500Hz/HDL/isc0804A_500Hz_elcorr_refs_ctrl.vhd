------------------------------------------------------------------
--!   @file : isc0207A_elcorr_references_ctrl
--!   @brief
--!   @details
--!
--!   $Rev: 23409 $
--!   $Author: elarouche $
--!   $Date: 2019-04-29 11:34:38 -0400 (lun., 29 avr. 2019) $
--!   $Id: isc0804A_500Hz_elcorr_refs_ctrl.vhd 23409 2019-04-29 15:34:38Z elarouche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/FPA/isc0804A_500Hz/HDL/isc0804A_500Hz_elcorr_refs_ctrl.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.Fpa_Common_Pkg.all;
use work.fpa_define.all;

entity isc0804A_500Hz_elcorr_refs_ctrl is
   generic(    
      G_REF_CHANGE_PERIOD_SEC : natural := 100     
      );   
   
   port( 		 
      ARESET            : in std_logic;
      CLK               : in std_logic;
      
      USER_CFG_IN       : in fpa_intf_cfg_type;
      USER_CFG_OUT      : out fpa_intf_cfg_type;
      
      FPA_INTF_CFG      : in fpa_intf_cfg_type;
      
      REF_VALID         : out std_logic_vector(1 downto 0);
      REF_FEEDBK        : in std_logic_vector(1 downto 0);
      
      HW_CFG_IN_PROGRESS: in std_logic;
      
      PROG_TRIG         : out std_logic      
      );
   
end isc0804A_500Hz_elcorr_refs_ctrl;

architecture rtl of isc0804A_500Hz_elcorr_refs_ctrl is
   
   constant C_ONE_SEC_FACTOR : integer := 1000*integer(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_KHZ);
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   component double_sync_vector is
      port(
         D     : in std_logic_vector;
         Q     : out std_logic_vector;
         CLK   : in std_logic
         );
   end component;
   
   component Clk_Divider is
      Generic(	
         Factor : integer := 2);		
      Port ( 
         Clock     : in std_logic;
         Reset     : in std_logic;		
         Clk_div   : out std_logic);
   end component;
   
   type ctrl_fsm_type is (idle, slct_ref_st, check_value_st, change_ref_st, wait_done_st, pause_st, ref_valid_st, wait_fdbk_st, default_ref_st); 
   
   signal ctrl_fsm                  : ctrl_fsm_type;
   signal sreset                    : std_logic;
   signal one_sec_signal            : std_logic;
   signal one_sec_signal_last       : std_logic;
   signal elcorr_ref_dac_id         : natural range 1 to 8; -- pour identification du dac qui sort les references de tension pour la correction des gains et offsets electroniques
   signal user_cfg_o                : fpa_intf_cfg_type;
   signal elcorr_ref_value_reg      : unsigned(13 downto 0);
   signal one_sec_pulse             : std_logic;
   signal pause_cnt                 : natural range 0 to DEFINE_ELCORR_REF_DAC_SETUP_FACTOR + 2;
   signal ref_id                    : natural range 0 to 1;
   signal ref_valid_i               : std_logic_vector(1 downto 0);
   signal prog_timer_pulse          : std_logic;
   signal sec_counter               : integer range -5 to G_REF_CHANGE_PERIOD_SEC + 2;
   signal prog_event_pulse          : std_logic;
   signal actual_cfg_num            : unsigned(USER_CFG_IN.CFG_NUM'LENGTH-1 downto 0);
   signal prog_trig_i               : std_logic;
   signal areset_i                  : std_logic;
   signal ref_feedbk_i              : std_logic_vector(1 downto 0);
   -- signal elcorr_init_done_i        : std_logic;
   
begin
   
   USER_CFG_OUT <= user_cfg_o;
   REF_VALID <= ref_valid_i;
   PROG_TRIG <= prog_trig_i;   
   
   areset_i <= ARESET or FPA_INTF_CFG.COMN.FPA_DIAG_MODE;
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1A : sync_reset
   port map(
      ARESET => areset_i,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   --------------------------------------------------
   -- synchro feedback 
   --------------------------------------------------    
   U1B : double_sync_vector
   port map(
      CLK => CLK,
      D   => REF_FEEDBK,
      Q   => ref_feedbk_i
      );
   
   --------------------------------------------------------
   -- cadence des changements de reference pour l'elcorr
   -------------------------------------------------------- 
   U2A: Clk_Divider
   Generic map(
      Factor=> C_ONE_SEC_FACTOR
      -- pragma translate_off
      /1000
      -- pragma translate_on
      )
   Port map( 
      Clock   => CLK,    
      Reset   => sreset, 
      Clk_div => one_sec_signal  
      );
   
   U2B: process(CLK)
      variable incr  : std_logic_vector(1 downto 0);
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            one_sec_pulse <= '0';
            one_sec_signal_last <= '0';
            sec_counter <= G_REF_CHANGE_PERIOD_SEC - 3;  -- permet d'avoir un premier pulse 3 sec apres le reset
            prog_timer_pulse <= '0';
            prog_event_pulse <= '1';
            
         else
            
            -- pulse de 1sec
            one_sec_signal_last <= one_sec_signal;
            one_sec_pulse <= not one_sec_signal_last and one_sec_signal;
            
            -- compteur de sec
            incr :=  '0'& one_sec_pulse;            
            
            -- mode continuel : pulse de prog de type timer
            if sec_counter > G_REF_CHANGE_PERIOD_SEC then
               prog_timer_pulse <= USER_CFG_IN.ELCORR_GAIN_CONT_CALC_MODE;
               sec_counter <= 0;
            else
               prog_timer_pulse <= '0';
               sec_counter <= sec_counter + to_integer(unsigned(incr));  
            end if;
            
            -- mode evenementiel : pulse de pog dès qu'une nouvelle cmd rentre (ce qui n'arrive qu'en mode non acquisition). On profite pour calculer le gain
            if USER_CFG_IN.CFG_NUM /= actual_cfg_num then 
               prog_event_pulse <= '1';
            else
               prog_event_pulse <= '0';
            end if;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------------
   -- changements de reference
   -------------------------------------------------------- 
   U3: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            --elcorr_ref_dac_id <= to_integer(USER_CFG_IN.ELCORR_REF_DAC_ID);   -- pour une bonne initialisation et evitrer ainsi des bugs
            user_cfg_o <= USER_CFG_IN;                                         -- pour une bonne initialisation et evitrer ainsi des bugs
            elcorr_ref_value_reg <= USER_CFG_IN.VDAC_VALUE(elcorr_ref_dac_id); -- pour une bonne initialisation et evitrer ainsi des bugs
            ctrl_fsm <= idle;
            ref_valid_i <= (others => '0');
            actual_cfg_num <= not USER_CFG_IN.CFG_NUM;
            prog_trig_i <= '0'; 
            -- elcorr_init_done_i <= '0';
            
         else
            
            elcorr_ref_dac_id <= to_integer(FPA_INTF_CFG.ELCORR_REF_DAC_ID);            
            user_cfg_o <= USER_CFG_IN;
            user_cfg_o.vdac_value(elcorr_ref_dac_id) <= elcorr_ref_value_reg;
            
            case ctrl_fsm is
               
               when idle =>
                  prog_trig_i <= '0';
                  if (prog_timer_pulse = '1' or prog_event_pulse = '1') and USER_CFG_IN.ELCORR_REF_CFG(0).REF_ENABLED = '1' then  
                     ctrl_fsm <= slct_ref_st;
                  end if;
               
               when slct_ref_st =>
                  if USER_CFG_IN.ELCORR_REF_CFG(1).REF_ENABLED = '1' then
                     ref_id <= 1;
                  else
                     ref_id <= 0;       -- si REF1 n'est pas activée, alors on se contente de REF0 uniqument
                  end if;                                     
                  ctrl_fsm <= check_value_st;
               
               when check_value_st =>     -- s'assurer que la valeur à changer n'est pas déjà celle qui a cours dans le dac
                  if USER_CFG_IN.ELCORR_REF_CFG(ref_id).REF_VALUE = FPA_INTF_CFG.VDAC_VALUE(elcorr_ref_dac_id) and ref_valid_i(ref_id) = '1' then
                     ctrl_fsm <= idle;
                  else
                     ctrl_fsm <= change_ref_st;
                  end if;
               
               when change_ref_st =>      -- on demande une programmation du dac des ref avec la valeur de ref correspondant à l'id actif 
                  elcorr_ref_value_reg <= USER_CFG_IN.ELCORR_REF_CFG(ref_id).REF_VALUE;
                  ref_valid_i <= "00"; -- plus aucune reference n'est valide puisqu'on s'apprête à reprogrammer les dacs
                  ctrl_fsm <= wait_done_st;
               
               when wait_done_st =>       -- on attend que la programmation soit terminée
                  pause_cnt <= 0;
                  if FPA_INTF_CFG.VDAC_VALUE(elcorr_ref_dac_id) = elcorr_ref_value_reg then
                     ctrl_fsm <= pause_st;
                  end if;
               
               when pause_st =>           -- on donne du temps à la sortie du dac programmé de se stabiliser
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt > DEFINE_ELCORR_REF_DAC_SETUP_FACTOR then   -- soit environ 50% du temps de validité d'une vref. Les mesures à l,oscillo revelent que la stabilisation s'obtient apres 250 ms 
                     ctrl_fsm <= ref_valid_st;
                  end if;
                  -- pragma translate_off
                  ctrl_fsm <= ref_valid_st;
                  -- pragma translate_on
               
               when ref_valid_st =>            -- on diffuse l'info de la validité de la reference 
                  ref_valid_i(ref_id) <= '1';
                  ctrl_fsm <= wait_fdbk_st;
               
               when wait_fdbk_st =>            -- on attend qu'au moins un calcul soit fait
                  prog_trig_i <= not HW_CFG_IN_PROGRESS and not USER_CFG_IN.DAC_FREE_RUNNING_MODE and not ref_feedbk_i(ref_id); -- ENO : 26 avril 2019 !!!!!!!!!! : ne jamais lancer prog_trig de ELCPRR lorsqu'une transaction de PROG est lancée car cette requete suppose l'arret du trig_ctler, alors que le prog_trig_i à zero l'empêche de s'arrêter
                  if ref_feedbk_i(ref_id) = '1' then
                     prog_trig_i <= '0';   -- dès qu'on a ce qu'on veut, prog_trig doit être relâchée pour une programmation de détecteur puisse se faire au besoin
                     if ref_id = 0 then
                        ctrl_fsm <= idle;
                     else
                        ctrl_fsm <= default_ref_st;  
                     end if;
                     ref_valid_i(1) <= '0';    -- ainsi les changements de niveau affecteront juste une image si impact il y a 
                  end if;
               
               when default_ref_st =>          -- on remet la reference par defaut (ref_id = 0)
                  ref_id <= 0;
                  actual_cfg_num <= USER_CFG_IN.CFG_NUM; 
                  ctrl_fsm <= check_value_st;                  
               
               when others =>
               
            end case;        
            
         end if;
      end if;  
   end process;
   
end rtl;
