-------------------------------------------------------------------------------
--
-- Title       : irig_frame_decoder_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\irig_frame_decoder_v2.vhd
-- Generated   : Tue Sep 13 16:33:37 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 
use work.tel2000.all;
use work.IRIG_define_v2.all;


entity irig_frame_decoder_v2 is
   port(
      ARESET           : in std_logic;
      CLK              : in std_logic;
      
      -- autres entrées
      FRM_DEC_CFG      : in frame_decoder_cfg_type;
      RAW_IRIG_CLK     : in std_logic;
      BIT_MOSI         : in t_ll_mosi1;
      BIT_MISO         : out t_ll_miso; 
      POS_IDENTIFIER   : in std_logic;  
      
      -- horloges de reference
      CARRIER_REFPULSE : in std_logic;
      ALPHAB_REFPULSE  : in std_logic;
      
      -- interface avec le module irig_controller
      FRM_DEC_STATUS   : out std_logic_vector(7 downto 0); -- statuts envoyés au module irig_controller 
      GLOBAL_STATUS    : in  std_logic_vector(15 downto 0); -- statut global generé par le module irig_controller
      
      -- interface avec le µBlaze Inbterface
      IRIG_DATA        : out irig_data_type;
      IRIG_PPS         : out std_logic;
	  DELAY   : in   std_logic_vector(31 downto 0)  
	  
      );
end irig_frame_decoder_v2;



architecture RTL of irig_frame_decoder_v2 is   
   constant SYNC_FOUND_DURATION : integer := IRIG_MORPHEME_RATE_FACTOR + 5; -- + 5 pour se donner une petite marge
   constant IRIG_FRAME_DURATION : integer := IRIG_MORPHEME_PER_FRAME + 1;   -- + 1 pour se donner une petite marge 
   
   component sync_reset
      port (
         ARESET : in STD_LOGIC;
         CLK    : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1'
         );
   end component;
   
   type frm_sync_fsm_type is (idle, wait_ref_marker_st, frm_st, end_st);
   type mux_fsm_type is (idle, wait_st, send_data_st, pause_st, send_status_st, end_st);
   type pps_fsm_type is (idle, wait_P0_st, avoid_jitter_st, wait_next_crossing_st, wait_clk_channel_dly_st, gen_pps_st);
   
   signal frm_sync_fsm             : frm_sync_fsm_type;
   signal mux_fsm                  : mux_fsm_type; 
   signal pps_fsm                  : pps_fsm_type;
   signal sreset                   : std_logic;
   signal frm_received             : std_logic;
   signal frm_received_last        : std_logic;
   signal frm_in_progress          : std_logic_vector(1 downto 0);
   signal identifier_pipe          : std_logic_vector(1 downto 0);
   signal din_pipe                 : std_logic_vector(1 downto 0);
   signal din_dval_pipe            : std_logic_vector(1 downto 0);
   signal sequence_err             : std_logic;
   signal index_cnt                : signed(7 downto 0);
   signal any_input_valid          : std_logic;
   signal irig_data_raw            : std_logic_vector(100 downto 0);
   signal status_available         : std_logic;
   signal irig_dout_dval           : std_logic;
   signal irig_dout_sel            : std_logic_vector(3 downto 0);
   signal irig_dout                : std_logic_vector(15 downto 0);
   signal mux_cnt                  : unsigned(3 downto 0); 
   signal pps_i                    : std_logic;
   signal irig_status_reg          : std_logic_vector(15 downto 0);
   signal pps_gen_err              : std_logic;
   signal cnt                      : unsigned(15 downto 0);
   signal raw_irig_clk_last        : std_logic;
   signal irig_pps_out             : std_logic;
   signal frm_sync_lost            : std_logic; 
   signal speed_err                : std_logic;
   signal input_too_late           : std_logic;
   signal carrier_cnt              : unsigned(log2(IRIG_MORPHEME_RATE_FACTOR)+1 downto 0);
   signal morpheme_cnt             : unsigned(log2(IRIG_MORPHEME_PER_FRAME)+1 downto 0);
   signal valid_irig_detected      : std_logic;
   signal idle_cnt                 : unsigned(2 downto 0);
   signal irig_data_i              : irig_data_type;
   signal delay_i                  : std_logic_vector(31 downto 0); 
   
   -- attribute dont_touch : string; 
   -- attribute dont_touch of irig_data_i          : signal is "true"; 
   -- attribute dont_touch of frm_received         : signal is "true";  
   -- attribute dont_touch of irig_dout            : signal is "true";
   -- attribute dont_touch of irig_dout_dval       : signal is "true";
   -- attribute dont_touch of irig_dout_sel        : signal is "true";
   
   
begin 
   
   delay_i <= DELAY;  
   
   --------------------------------------------------
   -- sorties 
   --------------------------------------------------    
   -- signaux envoyés au ROIC
   IRIG_DATA <= irig_data_i;        
   IRIG_PPS <= irig_pps_out;   
   -- statuts envoyés au module irig_controller   
   FRM_DEC_STATUS(6) <= '0';
   FRM_DEC_STATUS(5) <= pps_gen_err;
   FRM_DEC_STATUS(4) <= sequence_err;
   FRM_DEC_STATUS(3) <= frm_sync_lost;
   FRM_DEC_STATUS(2) <= frm_received;
   FRM_DEC_STATUS(1) <= frm_in_progress(0);
   FRM_DEC_STATUS(0) <= valid_irig_detected;
   
   -- vers le decodeur d'alphabet
   BIT_MISO.BUSY <= '0';
   BIT_MISO.AFULL <= '0';
   
   --input map
   irig_status_reg <= GLOBAL_STATUS;
   
   
   --------------------------------------------------
   -- lancement du decodeur de trame
   --------------------------------------------------
   --U0 : process(CLK)
   --begin          
   --   if rising_edge(CLK) then 
   --      sreset <= sreset or not FRM_DEC_CFG.ENABLE;          
   --   end if;
   -- end process;
   
   
   --------------------------------------------------
   -- sync reset 
   --------------------------------------------------
   U1 : sync_reset
   port map(ARESET => ARESET, SRESET => sreset, CLK => CLK);  
   
   --------------------------------------------------
   -- recherche de la synchronisation 
   -------------------------------------------------- 
   U2 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            frm_sync_fsm <= idle; 
            frm_received <= '0';
            frm_in_progress(0) <= '0';  
            identifier_pipe(0) <= '0';
            din_dval_pipe(0) <= '0';
            frm_received_last <= '0';
            frm_sync_lost <= '0';
            status_available <= '0';
         else
            
            -- pipeline pour synchroniser entrées avec frm_in_progress(0)
            identifier_pipe(0) <= POS_IDENTIFIER;
            din_pipe(0) <= BIT_MOSI.DATA;
            din_dval_pipe(0) <= BIT_MOSI.DVAL; 
            
            frm_received_last <= frm_received;
            
            -- machine à états pour detection de la synchronisation            
            case frm_sync_fsm is
               when idle => 
                  frm_in_progress(0) <= '0';
                  if POS_IDENTIFIER = '1' and FRM_DEC_CFG.ENABLE = '1' then 
                     frm_sync_fsm <= wait_ref_marker_st; 
                  end if;                  
                  frm_sync_lost <= BIT_MOSI.DVAL and frm_received;   -- après reception d'une trame, on s'attend à ce que le prochaine morpheme soit P0, sinon, il y a perte de synchroniséation
                  status_available <= ALPHAB_REFPULSE;               -- ainsi les status sont mis à jour automatiquement à toutes les 10 ms si frm_sync_fsm ne fait rien. ainsi le MB aura des mises à jous continuelles  
               
               when wait_ref_marker_st =>
                  frm_received <= '0';        -- ce qui signifie qu'on a juste 10ms pour envoyer les données avant qu'une nouvelle trame ne commence
                  status_available <= '0';
                  if BIT_MOSI.DVAL = '1' then
                     frm_sync_fsm <= idle; 
                     frm_sync_lost <= frm_received;
                  else
                     if POS_IDENTIFIER = '1' then 
                        frm_in_progress(0) <= '1';
                        frm_sync_fsm <= frm_st;
                     end if;
                  end if;                   
                  if input_too_late = '1' then      -- si l'entrée est en retard,  alors il y a un problème, on abandonne la trame
                     frm_sync_fsm <= idle; 
                  end if;
               
               when frm_st =>  
                  if sequence_err = '1' then    -- on attend la fin de la reception
                     frm_sync_fsm <= idle;                     
                  end if;
                  if index_cnt = 98 then       -- bel et bien 98 car 99 est occupé par P0 et il faut retourner à idle avant qu'il n'arrive
                     frm_sync_fsm <= end_st;                     
                  end if;           
                  if input_too_late = '1' then     -- si l'entrée est en retard, alors il y a un problème, on abandonne la trame
                     frm_sync_fsm <= idle; 
                  end if;
               
               when end_st =>
                  frm_received <= '1';
                  frm_sync_fsm <= idle; 
               
               when others =>                  
               
            end case;                   
            
         end if;
      end if;
   end process;
   
   
   --------------------------------------------------
   -- generation des index_cnt et pipelining
   -------------------------------------------------- 
   -- les index_cnt sont definis dabs le protocole IRIG
   -- Pr possede l'index 0 et P0 l'index 99
   any_input_valid <= identifier_pipe(0) or din_dval_pipe(0);
   
   U3 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            index_cnt <= to_signed(-1, index_cnt'length);
            identifier_pipe(1) <= '0';
            din_dval_pipe(1) <= '0';
            frm_in_progress(1) <= '0';
         else
            
            -- generation des index (0 à 98) des morphemes
            if frm_in_progress(0) = '1' then 
               if any_input_valid = '1' then 
                  index_cnt <= index_cnt + 1;      -- la premeire valeur sera 0, ainsi, il va etre parfaitement synchronisé avec Pr 
               end if; 
            else
               index_cnt <= to_signed(-1, index_cnt'length);  --init à -1, ainsi le premier sera -1 + 1 = 0
            end if; 
            
            -- pipeline pour synchronisation des entrées avec index_cnt
            identifier_pipe(1) <= identifier_pipe(0);
            din_pipe(1) <= din_pipe(0);
            din_dval_pipe(1) <= din_dval_pipe(0);
            frm_in_progress(1) <= frm_in_progress(0);
            
         end if;
      end if;
   end process;
   
   
   --------------------------------------------------
   -- verification de la position des identificateurs
   -------------------------------------------------- 
   U4 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            sequence_err <= '0';
         else        
            if frm_in_progress(1) = '1' then 
               case to_integer(index_cnt) is
                  --when -1 =>                          -- ne rien faire car probablement que P0 rentrera en ce moment           
                  when 0  => 
                  sequence_err <= din_dval_pipe(1);     -- erreur si on ne trouve pas de positionneur aux positions 0,9,19,...89.
                  when 9  => 
                  sequence_err <= din_dval_pipe(1);                  
                  when 19 => 
                  sequence_err <= din_dval_pipe(1);                  
                  when 29 => 
                  sequence_err <= din_dval_pipe(1);                 
                  when 39 => 
                  sequence_err <= din_dval_pipe(1);                  
                  when 49 => 
                  sequence_err <= din_dval_pipe(1);                  
                  when 59 => 
                  sequence_err <= din_dval_pipe(1);
                  when 69 => 
                  sequence_err <= din_dval_pipe(1);
                  when 79 => 
                  sequence_err <= din_dval_pipe(1);
                  when 89 => 
                  sequence_err <= din_dval_pipe(1);
                  when  others => 
                  sequence_err <= identifier_pipe(1);     -- erreur si on trouve un positionneur aux positions autres que 0,9,19,...89.
               end case;
               
            else
               sequence_err <= '0';
            end if;            
            
         end if;
      end if;
   end process;
   
   
   --------------------------------------------------
   -- prise des données
   -------------------------------------------------- 
   -- les données serielles entrantes
   -- sont enregistrées dans un long vecteur de 100 bits
   U5 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if frm_in_progress(1) = '1' then  -- frm_in_progress(1) = '1' protege le vecteur de la valeur -1 que prend index_cnt lorsque frm_in_progress(1) = '0'
            irig_data_raw(to_integer(index_cnt)) <= din_pipe(1);
         end if;  
      end if;
   end process;
   
   
   --------------------------------------------------
   -- Extraction des données à toutes les secondes 
   --------------------------------------------------
   -- mais envoi 1 seconde sur 2 
   -- Il est utilisé dans le ROIC pour aider le MB à eviter d'interpreter des données en cours de changement
   
   U6 : process(CLK)
   begin          
      if rising_edge(CLK) then
         if sreset = '1' then 
            irig_data_i.time_dval <= '0';
            irig_data_i.status_dval <= '0';
         else 
            
            -- registres du temps
            if frm_received = '1' and frm_received_last = '0' then      -- extraction à toutes les secondes en vrai BCD             
               irig_data_i.seconds_reg(15 downto 0)     <=  resize(irig_data_raw(8 downto 6) & irig_data_raw(4 downto 1),16);       -- bit 5 non utilisé
               irig_data_i.minutes_reg(15 downto 0)     <=  resize(irig_data_raw(17 downto 15) & irig_data_raw(13 downto 10),16);   -- bit 18 et 14 non utilisés
               irig_data_i.hours_reg(15 downto 0)       <=  resize(irig_data_raw(26 downto 25) & irig_data_raw(23 downto 20),16);   -- bit 28, 27 et 24 non utilisés
               irig_data_i.dayofyear_reg(15 downto 0)   <=  resize(irig_data_raw(41 downto 40) & irig_data_raw(38 downto 35) & irig_data_raw(33 downto 30),16);   -- bit 44, 43, 42 et 34 non utilisés
               irig_data_i.tenthsofsec_reg(15 downto 0) <=  resize(irig_data_raw(48 downto 45),16);
               irig_data_i.year_reg(15 downto 0)        <=  resize(irig_data_raw(58 downto 55) & irig_data_raw(53 downto 50),16);   -- bit 54 non utilisé               
               irig_data_i.time_dval <= not irig_data_i.time_dval;                      -- passe à '1' à la reception d'une trame sur deux
            end if;
            
            -- registres des statuts
            irig_data_i.status_reg  <= irig_status_reg;
            irig_data_i.status_dval <= status_available;
            
         end if;  
      end if;
   end process;     
   
   --------------------------------------------------
   -- generation du PPS à toutes les secondes
   --------------------------------------------------
   -- mais demande d'envoi une fois sur 2
   U8 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            pps_fsm <= idle; 
            pps_i <= '0';
            pps_gen_err <= '0';
            raw_irig_clk_last <= '0';
            irig_pps_out <= '0';
         else
            
            raw_irig_clk_last <= RAW_IRIG_CLK;
            
            case pps_fsm is
               when idle => 
                  pps_i <= '0';
                  pps_gen_err <= '0';
                  cnt <= (others => '0');   -- compteur generique
                  if frm_received = '1' and frm_received_last = '0' then 
                     pps_fsm <= wait_P0_st; 
                  end if;
               
               when wait_P0_st =>
                  if BIT_MOSI.DVAL = '1' then      -- certainement une erreur donc il faut annuler la generation du PPS.
                     pps_fsm <= idle;
                     pps_gen_err <= '1';
                  else
                     if POS_IDENTIFIER = '1' then  -- certainement un P0 vient de passer après reception d'une trame valide
                        pps_fsm <= avoid_jitter_st;
                     end if;
                  end if;  
               
               when avoid_jitter_st =>             -- cet état permet d'eviter (au besoin)les trainées de bouncings qui suivent les changements d'états du comparateur 
                  cnt <= cnt + 1;
                  if cnt > 0 then                  -- pas necessaire d'attendre car il y a suffisamment de delais sur les données 
                     pps_fsm <= wait_next_crossing_st; 
                     cnt <= (others => '0');
                  end if;
               
               when wait_next_crossing_st =>        -- le prochain zero-crossing (front montant) correspond au PPS
                  if RAW_IRIG_CLK = '1' and raw_irig_clk_last = '0' then                      
                     pps_fsm <= wait_clk_channel_dly_st;
                     cnt <= (others => '0');
                  end if;
                  
                  if CARRIER_REFPULSE = '1' then  -- si le zero-crossing n'est jamais venu après 2ms, on a un problème
                     cnt <= cnt + 1;
                  end if;
                  if cnt = 3 then 
                     pps_fsm <= idle; 
                     pps_i <= '0';
                     pps_gen_err <= '1';
                  end if;                    
               
               when wait_clk_channel_dly_st =>    -- il peut y avoir des delais sur le canal de clock. En effet l'ajout du passe-haut induit une avance de phase
                  cnt <= cnt + 1;                    
                  if cnt >= unsigned(delay_i) then 
                     pps_fsm <= gen_pps_st;
                     cnt <= (others => '0');
                  end if;                   
               
               when gen_pps_st => 
                  pps_i <= '1';
                  cnt <= cnt + 1;                    
                  if cnt = 1000 then   -- cela donne une pulse PPS de durée 1000/20MHz = 50usec
                     pps_fsm <= idle;
                  end if;                  
               
               when others =>                  
               
            end case;                   
            
            irig_pps_out <=  pps_i and not irig_data_i.time_dval;  -- envoi du pps une fois sur 2 mais decalées par rapport à l'envoi des registres
            
         end if;
      end if;
   end process;   
   
   --------------------------------------------------
   -- qques signaux de monitoring
   --------------------------------------------------   
   U10 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            carrier_cnt <= (others => '0');
            input_too_late <= '0';
            morpheme_cnt <=  (others => '0');
            valid_irig_detected <= '0';
         else
            -- monostable redeclenchable pour verifier que les morphemes entrent au bon rate et ce, sans interruption
            if any_input_valid = '1' then 
               carrier_cnt <= to_unsigned(SYNC_FOUND_DURATION, carrier_cnt'LENGTH); -- cela donne 15ms à chaque morpheme pour entrer dans le decodeur de trame sinon, pb
            else
               if CARRIER_REFPULSE = '1' and carrier_cnt > 0 then 
                  carrier_cnt <= carrier_cnt - 1;
               end if;
            end if;
            
            if carrier_cnt = 0 then
               input_too_late <= '1';
            else
               input_too_late <= '0';
            end if;
            
            -- monostable redeclenchable pour verifier que les trames entrent au bon rate et ce, sans interruption
            if pps_i = '1' then 
               morpheme_cnt <= to_unsigned(IRIG_FRAME_DURATION, morpheme_cnt'LENGTH); -- cela donne 1010ms à chaque debut de trame pour entrer dans le decodeur de trame sinon, pb
            else
               if ALPHAB_REFPULSE = '1' and morpheme_cnt > 0 then 
                  morpheme_cnt <= morpheme_cnt - 1;
               end if;
            end if;
            
            if morpheme_cnt = 0 then
               valid_irig_detected <= '0';
            else
               valid_irig_detected <= '1';
            end if;
            
            
         end if;
      end if;
      
   end process;
   
end RTL;
