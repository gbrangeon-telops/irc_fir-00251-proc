------------------------------------------------------------------
--!   @file : exp_time_manager
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
use work.exposure_define.all;
use work.tel2000.all;

entity exp_time_manager is
   port(
      
      CLK                : in std_logic;
      ARESET             : in std_logic;
      
      MB_EXP_INFO        : in exp_info_type;
      FW_EXP_INFO        : in exp_info_type;
      EHDRI_EXP_INFO     : in exp_info_type;
      IMG_INFO           : in img_info_type;
      
      EXP_CONFIG         : in exp_config_type;
      FPA_EXP_INFO       : out exp_info_type;
      EXP_CTRL_BUSY      : out std_logic;     -- ce busy est pour les sources autre que le MicroBlaze.
      
      ERROR              : out std_logic
      );
end exp_time_manager;


architecture RTL of exp_time_manager is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
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
   
   type exp_ctrl_sm_type is (idle, wait_mb_exp_st, wait_fw_exp_st, wait_ehdri_exp_st, check_exp_limit_st1, wait_fpa_st, wait_mb_new_cgf_st, check_exp_limit_st2); 
   
   signal exp_ctrl_sm             : exp_ctrl_sm_type;
   signal sreset	                : std_logic;
   signal fpa_exp_info_i          : exp_info_type;
   signal fpa_exp_info_latch      : exp_info_type;
   signal exp_ctrl_busy_i         : std_logic;
   signal exp_source              : std_logic_vector(MB_SOURCE'range);
   signal exp_feedbk_sync         : std_logic;
   signal exp_feedbk_sync_last    : std_logic;
   signal fpa_synchro_done        : std_logic;
   
   -- -- -- attribute dont_touch                        : string;
   -- -- -- attribute dont_touch of fpa_exp_info_latch  : signal is "true";
   
begin
   
   
   FPA_EXP_INFO <= fpa_exp_info_i;
   EXP_CTRL_BUSY <= exp_ctrl_busy_i;
   ERROR <= '0'; -- aucune erreur pour l'instant
   
   ----------------------------------------------------------------------------
   --  synchro reset
   ----------------------------------------------------------------------------
   U1A: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   U1B : double_sync
   port map(
      CLK => CLK,
      D   => IMG_INFO.EXP_FEEDBK,
      Q   => exp_feedbk_sync,
      RESET => sreset
      );
   
   ----------------------------------------------------------------------------
   --  gestion du temps d'intégration
   ----------------------------------------------------------------------------   
   -- ce process envoie le temps d,intégration reçu de la source désignée par le microBlaze
   -- et l'envoie en suivant le timing d'intégration du détecteur
   -- le process peut envoyer deux temsp d 'intégratyion identique de façon succesives, il appartient au module fpa_intf de ne programmer le détecteur que 
   -- lorsque l'actuel temps d'intégration est différent du précédent.
   -- Toute application de config de détecteur se fait toujours en 1 ou N images plus tard mais elle se fait toujours. C'est un pipe.
   -- Ainsi en se synchronisant sur le signal d'intégration, la synchronisation sera parfaite
   
   U2: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            exp_ctrl_sm <= idle;
            exp_ctrl_busy_i <= '1';
            fpa_exp_info_i.exp_dval <= '0';
            --exp_feedbk_sync <= '0';
            exp_feedbk_sync_last <= '0';
            exp_source <= MB_SOURCE;
            fpa_synchro_done <= '0';
         else
            
            --exp_feedbk_sync <= IMG_INFO.EXP_FEEDBK;    -- IMG_INFO est certaibnement sur l'horloge FPA_INTF_CLK. Une simple synchro est suffisante
            exp_feedbk_sync_last <= exp_feedbk_sync;   --  
            
            fpa_synchro_done <= exp_feedbk_sync and not exp_feedbk_sync_last; -- la synchro du fpa est definie sur le rising edge de l'intégration. Ainsi le temps d'intégration envoyé sera appliqué sur l'image suivante
            
            if EXP_CONFIG.EXP_NEW_CFG = '1' then
               exp_ctrl_sm <= idle;
            else
               -- gestion du temps d'intégration (plusieurs états pour ameliorer timing)
               case exp_ctrl_sm is 
                  when idle =>
                     fpa_exp_info_i.exp_dval <= '0';
                     if EXP_CONFIG.EXP_SOURCE = MB_SOURCE then
                        exp_ctrl_busy_i <= '1';     -- si la source = MB_SOURCE alors toutes les autrres sources sont bloquées
                        exp_ctrl_sm <= wait_mb_exp_st;
                        exp_source <= MB_SOURCE;
                     elsif EXP_CONFIG.EXP_SOURCE = FW_SOURCE then
                        exp_ctrl_busy_i <= '0';     -- 
                        exp_ctrl_sm <= wait_fw_exp_st;
                        exp_source <= FW_SOURCE;
                     elsif EXP_CONFIG.EXP_SOURCE = EHDRI_SOURCE then
                        exp_ctrl_busy_i <= '0';     -- 
                        exp_ctrl_sm <= wait_ehdri_exp_st;
                        exp_source <= EHDRI_SOURCE;
                     end if;
                  
                  when wait_mb_exp_st =>
                     if MB_EXP_INFO.EXP_DVAL = '1' then 
                        fpa_exp_info_latch <= MB_EXP_INFO;
                        exp_ctrl_sm <= check_exp_limit_st1;
                     end if;
                     --if EXP_CONFIG.EXP_NEW_CFG = '1' then
                     --                     exp_ctrl_sm <= idle;
                     --                  end if;
                  
                  when wait_fw_exp_st =>
                     if FW_EXP_INFO.EXP_DVAL = '1' then 
                        fpa_exp_info_latch <= FW_EXP_INFO;
                        exp_ctrl_sm <= check_exp_limit_st1;
                        exp_ctrl_busy_i <= '1';     -- une fois qu'un temps d'integration est reçu, il faut le traiter avant d'en prendre un autre
                     end if;
                     --  if EXP_CONFIG.EXP_NEW_CFG = '1' then
                     --                     exp_ctrl_sm <= idle;
                     --                  end if;
                  
                  when wait_ehdri_exp_st =>
                     if EHDRI_EXP_INFO.EXP_DVAL = '1' then 
                        fpa_exp_info_latch <= EHDRI_EXP_INFO;
                        exp_ctrl_sm <= check_exp_limit_st1;
                        exp_ctrl_busy_i <= '1';     -- une fois qu'un temps d'integration est reçu, il faut le traiter avant d'en prendre un autre
                     end if;
                     --                  if EXP_CONFIG.EXP_NEW_CFG = '1' then
                     --                     exp_ctrl_sm <= idle;
                     --                  end if;
                  
                  when check_exp_limit_st1 => 
                     if fpa_exp_info_latch.exp_time < EXP_CONFIG.EXP_TIME_MIN then 
                        fpa_exp_info_latch.exp_time <= EXP_CONFIG.EXP_TIME_MIN;
                     end if;
                     exp_ctrl_sm <= check_exp_limit_st2;
                  
                  when check_exp_limit_st2 => 
                     if fpa_exp_info_latch.exp_time > EXP_CONFIG.EXP_TIME_MAX then   -- else car normalement les 2 conditions ne sont jamais verifiées en mm temps puisque EXP_TIME_MIN < EXP_TIME_MAX  
                        fpa_exp_info_latch.exp_time <= EXP_CONFIG.EXP_TIME_MAX;
                     end if;
                     exp_ctrl_sm <= wait_fpa_st;
                  
                  when wait_fpa_st =>             
                     if exp_source = FW_SOURCE then  -- la source rapide est supposée se synchroniser avec le détecteur pour envoyer le temps d'intégration au bon moment.
                        fpa_exp_info_i <= fpa_exp_info_latch;           -- le fpa_exp_info_i.dval est à '1' ici 
                        exp_ctrl_sm <= idle;            
                     elsif exp_source /= MB_SOURCE then  -- la source rapide est supposée se synchroniser avec le détecteur pour envoyer le temps d'intégration au bon moment.
                        if fpa_synchro_done  = '1' then -- sinon, un signal de synchro peut être defini
                           fpa_exp_info_i <= fpa_exp_info_latch;           -- le fpa_exp_info_i.dval est à '1' ici 
                           exp_ctrl_sm <= idle;
                        end if;
                     else
                        fpa_exp_info_i <= fpa_exp_info_latch;
                        exp_ctrl_sm <= wait_mb_new_cgf_st;
                     end if;
                     -- if EXP_CONFIG.EXP_NEW_CFG = '1' then
                     --                     exp_ctrl_sm <= idle;
                     --                  end if;  
                  
                  when wait_mb_new_cgf_st =>                             -- cet etat permet d'eviter que le même temps d'intégration du MB soit envoyé tout le temps au module fpa_intf
                     fpa_exp_info_i.exp_dval <= '0';                    -- le fpa_exp_info_i.dval dure ainsi juste 1 CLK 
                     --                  if EXP_CONFIG.EXP_NEW_CFG = '1' then
                     --                     exp_ctrl_sm <= idle;
                     --                  end if;                         
                  
                  when others =>
                  
               end case;
            end if;
         end if;
         
      end if;     
   end process; 
   
end RTL;
