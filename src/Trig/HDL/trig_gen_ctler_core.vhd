-------------------------------------------------------------------------------
--
-- Title       : trig_gen_ctler_core
-- Design      : Trig_ctrl_tb
-- Author      : Telops Inc
-- Company     : Telops Inc
--
-------------------------------------------------------------------------------
--
-- File        : 
-- Generated   : Mon Nov  9 18:22:53 2009
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
use work.trig_define.all;

entity trig_gen_ctler_core is
   port( 
      
      ARESET                          : in std_logic;
      CLK                             : in std_logic; 
      
      ACQ_INT                         : in std_logic;
      CONFIG                          : in trig_cfg_type;
      
      SFW_SYNC_TRIG                   : in std_logic;
      
      EXTERNAL_TRIG_OR_GATING         : in std_logic;  -- pulse en provenance de l'exterieur du ROIC
      EXTERNAL_TRIG_HIGH_TIME		     : in std_logic_vector(31 downto 0);  
      SEQ_SOFTTRIG                    : in std_logic;  -- pulse en provenance du ublaze
      
      RAW_PULSE                       : out std_logic; -- pulse en envoyé aux conditionneurs de trigs         
      
      INTERNAL_PULSE                  : in std_logic;  -- pulse interne généré par l'oscillateur local
      INTERNAL_PULSE_PERIOD           : out std_logic_vector(31 downto 0); -- periode du trig , pour oscillateur local seulement
      INTERNAL_PULSE_CNTRAZ           : out std_logic;
      
      FPA_TRIG_STAT                   : in std_logic_vector(7 downto 0);
      TRIG_OUT_STAT                   : in std_logic_vector(7 downto 0);
      
      TRIG_OUT_PARAM                  : out trig_conditioner_type;
      FPA_TRIG_PARAM                  : out trig_conditioner_type; 
      
      STATUS                          : out std_logic_vector(7 downto 0)
      );
end trig_gen_ctler_core;



architecture RTL of trig_gen_ctler_core is
   type mode_sm_type is (idle, IntTrig_st, ExtTrig_st, SfwTrig_st, SingleTrig_st, SeqTrig_st, Feedback_to_ppc_st, Pause_st);
   signal mode_sm                       : mode_sm_type;
   signal sreset                        : std_logic;
   signal raw_pulse_i                   : std_logic;	 -- trig envoyé aux conditionneurs de trigs
   signal internal_pulse_period_i       : std_logic_vector(31 downto 0);
   signal fpa_trig_param_i              : trig_conditioner_type;
   signal trig_out_param_i              : trig_conditioner_type;
   signal done                          : std_logic;
   signal trig_out_done                 : std_logic;
   signal fpa_trig_done                 : std_logic;
   signal run                           : std_logic;
   signal integration_detect            : std_logic;
   signal acq_int_last                  : std_logic;
   signal gated_image                   : std_logic; --pour le header de l'image 
   signal internal_pulse_cntraz_i       : std_logic; -- permet de mettre à '0' le compteur de generation des trigs
   signal trig_out_Allow_HighTimeChange : std_logic;
   signal fpa_trig_Allow_HighTimeChange : std_logic;

   signal frame_count        : unsigned(31 downto 0);
   signal ext_trig_last      : std_logic;
   signal seq_enable_i       : std_logic;
   signal seq_enable_last_i  : std_logic;
   signal seq_delay_enable_i : std_logic;
   signal seq_trig_i       : std_logic;
   
   signal clk_counter_rising        : unsigned(31 downto 0); 
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
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
   
   
begin 
   -----------------------------------------------------
   -- mapping entrée
   -----------------------------------------------------
   fpa_trig_Allow_HighTimeChange <= FPA_TRIG_STAT(1);   -- directement mapping de statut de fpa_trig
   trig_out_Allow_HighTimeChange <= TRIG_OUT_STAT(1);   -- directement mapping de statut de trig_out
   
   -----------------------------------------------------
   -- mapping sortie
   -----------------------------------------------------	
   --periode
   INTERNAL_PULSE_PERIOD <= internal_pulse_period_i;
   INTERNAL_PULSE_CNTRAZ <= internal_pulse_cntraz_i;
   
   -- parametre pour conditionneur de trig pour fpa local
   FPA_TRIG_PARAM <= fpa_trig_param_i;
   
   -- parametre pour conditionneur de trig pour fpa distant
   TRIG_OUT_PARAM <= trig_out_param_i;	
   
   -- trig  envoyé aux processeurs de trigs
   RAW_PULSE <= raw_pulse_i;
   
   -- statuts
   process(CLK) -- requis pour eviter pb de timing au sujet de trig_out_Allow_HighTimeChange et fpa_trig_Allow_HighTimeChange
   begin
      if rising_edge(CLK)then
         STATUS(7) <= '0'; 
         STATUS(6) <= '0'; 
         STATUS(5) <= '0'; 
         STATUS(4) <= '0'; 
         STATUS(3) <= trig_out_Allow_HighTimeChange; 
         STATUS(2) <= fpa_trig_Allow_HighTimeChange; 
         STATUS(1) <= gated_image; 
         STATUS(0) <= done;   -- done du contrôleur 
      end if;
   end process;
   
   -------------------------------------------------------
   --autres mappings--
   -------------------------------------------------------
   
   fpa_trig_done <= FPA_TRIG_STAT(0);
   trig_out_done <= TRIG_OUT_STAT(0);
   -----------------------------------------------------
   -- Synchronisation reset
   -----------------------------------------------------
   comp_sync_reset: sync_reset
   Port map(		
      ARESET   => ARESET,		
      SRESET   => sreset,
      CLK      => CLK);
   
   
   -----------------------------------------------------
   --  run
   -----------------------------------------------------	
   config_sync_proc: process(CLK)
   begin		   
      if rising_edge(CLK) then 
         run <= CONFIG.RUN; 
      end if;
   end process; 
   
   -----------------------------------------------------------------
   -- detection  du front montant de acq_int et du gated_image
   ---------------------------------------------------------------------	
   acqInt_sync_proc: process(CLK)
   begin		   
      if rising_edge(CLK) then
         if sreset ='1' then 
            integration_detect <= '0';	
            acq_int_last <= '1'; 
            gated_image <= '0';
         else 					   				
            acq_int_last <= ACQ_INT;
            if acq_int_last = '0' and ACQ_INT = '1' then 
               integration_detect <= '1';
               gated_image <= EXTERNAL_TRIG_OR_GATING;	
            else
               integration_detect <= '0';
            end if;					
         end if;
      end if;
   end process; 
   
   -----------------------------------------------------
   -- FSM de contrôle : decodage des modes de fonctionnement
   -----------------------------------------------------
   control_proc : process(CLK)
   begin  
      if rising_edge(CLK)then
         if sreset ='1' then
            mode_sm <= idle;
            done <= '0';
            fpa_trig_param_i.RUN  <= '0';
            trig_out_param_i.RUN  <= '0'; 
            raw_pulse_i <= '0';
            internal_pulse_period_i <= (others =>'0');
            internal_pulse_cntraz_i <= '1';
         else				
            case mode_sm is 
               
               --------------
               -- etat d'attente et de verification de mode 
               when idle =>
                  done <= '1';
                  raw_pulse_i <= '0';
                  fpa_trig_param_i.RUN  <= '0';-- arrêt des conditionneurs de trigs
                  trig_out_param_i.RUN <= '0';
                  internal_pulse_cntraz_i <='1';

                  if  fpa_trig_done = '1' and trig_out_done = '1'  and run = '1'  then 
                     if  CONFIG.MODE = INTTRIG then						
                        mode_sm <= IntTrig_st;						
                     elsif CONFIG.MODE = EXTTRIG then			
                        mode_sm <= ExtTrig_st;
                        --fpa_trig_param_i.HIGH_TIME <= (others =>'1');-- donne le temps à la mesure du HIGH_TIME (sortie du processeur de trig  bloqué à '1' en attentant la fin de la mesure)
                        --trig_out_param_i.HIGH_TIME <= (others =>'1');
                     elsif CONFIG.MODE = SINGLE_TRIG then
                        mode_sm <= SingleTrig_st;
                     elsif CONFIG.MODE = SFW_TRIG then
                        mode_sm <= SfwTrig_st;
                     elsif CONFIG.MODE = SEQ_TRIG then
                        mode_sm <= SeqTrig_st;
                     end if;
                     internal_pulse_period_i <= std_logic_vector(CONFIG.PERIOD);  -- envoyer le changement de priode avant de lancer les conditionneurs 						
                     done <= '0';
                  end if;
                  
                  -------------
               -- etat trig interne 	
               when IntTrig_st => 
                  internal_pulse_cntraz_i <= '0';
                  -- pulse envoyé aux processeurs de trigs
                  if CONFIG.FORCE_HIGH = '1' then	  
                     raw_pulse_i <= '1';
                  else
                     raw_pulse_i <= INTERNAL_PULSE;
                  end if;	
                  
                  -- parametres pour le processeur de trigs du FPA local (trig interne)
                  fpa_trig_param_i.RUN        <= '1';
                  fpa_trig_param_i.DLY      <= CONFIG.FPATRIG_DLY;
                  if fpa_trig_Allow_HighTimeChange = '1' then    --changement en live du HiGTH_TIME des trigs 
                     fpa_trig_param_i.HIGH_TIME  <= CONFIG.HIGH_TIME; -- peut changer sans probleme car le temps d'integration change sans reconfiguration de la camera
                  end if;
                  fpa_trig_param_i.TRIG_ACTIV <= CONFIG.TRIG_ACTIV;
                  fpa_trig_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  
                  -- parametres pour le processeur de trigs du FPA distant (trig out)
                  trig_out_param_i.RUN        <= '1'; -- EXTERNAL_TRIG_OR_GATING;  ENO: 30 janv2012 : changement de EXTERNAL_TRIG_OR_GATING à '1' sur demande de PDA
                  trig_out_param_i.DLY      <= CONFIG.TRIGOUT_DLY;
                  if trig_out_Allow_HighTimeChange = '1' then     --changement en live du HiGTH_TIME des trigs, decouple de celui du fpa_trig à cause du possible delai entre les Allow_HighTimeChange
                     trig_out_param_i.HIGH_TIME   <= CONFIG.HIGH_TIME;
                  end if;
                  trig_out_param_i.TRIG_ACTIV <= CONFIG.TRIG_ACTIV;
                  trig_out_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  
                  -- detection arrêt
                  if run = '0' then -- arreter les conditionneurs
                     fpa_trig_param_i.RUN  <= '0';
                     trig_out_param_i.RUN <= '0';
                     mode_sm <= Pause_st;
                  end if;	
                  
                  -----------------
               -- etat trig externe 	
               when ExtTrig_st =>						
                  internal_pulse_cntraz_i <= '0';
                  -- pulse envoyé aux processeurs de trigs
                  raw_pulse_i <= EXTERNAL_TRIG_OR_GATING and seq_enable_i;
                  
                  -- pour le FPA local (trig interne)
                  fpa_trig_param_i.RUN        <= '1';	 
                  fpa_trig_param_i.DLY      <= CONFIG.FPATRIG_DLY;
                  fpa_trig_param_i.TRIG_ACTIV <= CONFIG.TRIG_ACTIV;
                  fpa_trig_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  fpa_trig_param_i.HIGH_TIME  <= CONFIG.HIGH_TIME;
                  
                  -- pour le FPA distant (trig out)  
                  trig_out_param_i.RUN        <= '1'; 
                  trig_out_param_i.DLY      <= CONFIG.TRIGOUT_DLY;
                  trig_out_param_i.TRIG_ACTIV <= CONFIG.TRIG_ACTIV;
                  trig_out_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  trig_out_param_i.HIGH_TIME  <= CONFIG.HIGH_TIME;						
                  
                  -- detection arrêt
                  if integration_detect = '1' then
                     fpa_trig_param_i.RUN  <= '0';
                     trig_out_param_i.RUN <= '0';
                     mode_sm <= Pause_st;
                  end if;	
               
               when SfwTrig_st =>						
                  internal_pulse_cntraz_i <= '0';
                  -- pulse envoyé aux processeurs de trigs
                  raw_pulse_i <= SFW_SYNC_TRIG;
                  
                  -- parametres pour le processeur de trigs du FPA local (trig interne)
                  fpa_trig_param_i.RUN        <= '1';
                  fpa_trig_param_i.DLY      <= CONFIG.FPATRIG_DLY;
                  if fpa_trig_Allow_HighTimeChange = '1' then    --changement en live du HiGTH_TIME des trigs 
                     fpa_trig_param_i.HIGH_TIME  <= CONFIG.HIGH_TIME; -- peut changer sans probleme car le temps d'integration change sans reconfiguration de la camera
                  end if;
                  fpa_trig_param_i.TRIG_ACTIV <= CONFIG.TRIG_ACTIV;
                  fpa_trig_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  
                  -- parametres pour le processeur de trigs du FPA distant (trig out)
                  trig_out_param_i.RUN        <= '1'; -- EXTERNAL_TRIG_OR_GATING;  ENO: 30 janv2012 : changement de EXTERNAL_TRIG_OR_GATING à '1' sur demande de PDA
                  trig_out_param_i.DLY      <= CONFIG.TRIGOUT_DLY;
                  if trig_out_Allow_HighTimeChange = '1' then     --changement en live du HiGTH_TIME des trigs, decouple de celui du fpa_trig à cause du possible delai entre les Allow_HighTimeChange
                     trig_out_param_i.HIGH_TIME   <= CONFIG.HIGH_TIME;
                  end if;
                  trig_out_param_i.TRIG_ACTIV <= CONFIG.TRIG_ACTIV;
                  trig_out_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  
                  -- detection arrêt
                  if run = '0' then -- arreter les conditionneurs
                     fpa_trig_param_i.RUN  <= '0';
                     trig_out_param_i.RUN <= '0';
                     mode_sm <= Pause_st;
                  end if;	
                  
                  -----------------
               -- etat single Trig	
               when SingleTrig_st =>
               
                  --internal_pulse_cntraz_i <= '0';
                  if (seq_enable_i = '1') then
                     internal_pulse_cntraz_i <= '0';
                  else
                     internal_pulse_cntraz_i <= '1';
                  end if;
                  -- pulse envoyé aux processeurs de trigs
                  if CONFIG.FORCE_HIGH = '1' then	  
                     raw_pulse_i <= '1';
                  else
                     raw_pulse_i <= INTERNAL_PULSE and seq_enable_i;
                  end if;	
                  
                  -- pour le FPA local (trig interne)
                  fpa_trig_param_i.RUN        <= '1';	 
                  fpa_trig_param_i.DLY      <= CONFIG.FPATRIG_DLY;
                  fpa_trig_param_i.HIGH_TIME   <= CONFIG.HIGH_TIME;
                  fpa_trig_param_i.TRIG_ACTIV <= CONFIG.TRIG_ACTIV;
                  fpa_trig_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  
                  -- pour le FPA distant (trig out)  
                  trig_out_param_i.RUN        <= '1';    -- '0' ENO: 30 janv2012 : changement de '0' à '1' sur demande de PDA
                  trig_out_param_i.DLY      <= CONFIG.TRIGOUT_DLY;
                  trig_out_param_i.HIGH_TIME   <= CONFIG.HIGH_TIME;
                  trig_out_param_i.TRIG_ACTIV <= CONFIG.TRIG_ACTIV;
                  trig_out_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  
                  -- detection integration 
                  --if  run = '0' then  -- demande d'abandon
                  --   fpa_trig_param_i.RUN  <= '0';
                  --   trig_out_param_i.RUN <= '0';
                  --   mode_sm <= Pause_st; 
                  --end if;--else
                  if integration_detect = '1' then
                     fpa_trig_param_i.RUN  <= '0';
                     trig_out_param_i.RUN <= '0';
                     mode_sm <= feedback_to_ppc_st; 
                  end if;
                  --end if;	

                  -----------------
               -- etat sequence Trig	
               when SeqTrig_st =>
                  if (seq_enable_i = '1') then
                     internal_pulse_cntraz_i <= '0';
                  else
                     internal_pulse_cntraz_i <= '1';
                  end if;
                  -- pulse envoyé aux processeurs de trigs
                  if CONFIG.FORCE_HIGH = '1' then	  
                     raw_pulse_i <= '1';
                  else
                     raw_pulse_i <= INTERNAL_PULSE and seq_enable_i;
                  end if;	
                  
                  -- pour le FPA local (trig interne)
                  fpa_trig_param_i.RUN        <= '1';	 
                  fpa_trig_param_i.DLY      <= CONFIG.FPATRIG_DLY;
                  fpa_trig_param_i.HIGH_TIME   <= CONFIG.HIGH_TIME;
                  fpa_trig_param_i.TRIG_ACTIV <= RISINGEDGE;		-- trig_activ definit l'activation de la sequence en SeqTrig_st, on active le FPA sur un rising edge
                  fpa_trig_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  
                  -- pour le FPA distant (trig out)  
                  trig_out_param_i.RUN        <= '1';    -- '0' ENO: 30 janv2012 : changement de '0' à '1' sur demande de PDA
                  trig_out_param_i.DLY      <= CONFIG.FPATRIG_DLY;
                  trig_out_param_i.HIGH_TIME   <= CONFIG.HIGH_TIME;
                  trig_out_param_i.TRIG_ACTIV <= RISINGEDGE;		-- trig_activ definit l'activation de la sequence en SeqTrig_st, on active le FPA sur un rising edge
                  trig_out_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  
                  -- detection arrêt
                  if run = '0' then -- arreter les conditionneurs
                     fpa_trig_param_i.RUN  <= '0';
                     trig_out_param_i.RUN <= '0';
                     mode_sm <= feedback_to_ppc_st; 
                  end if;
                                    
                  -----------------
               -- etat où on attend que le PPC arrête ce mode avant d'en sortir sinon boucle lorsqu'on ira à idle.
               when Feedback_to_ppc_st =>                  
                  done <= '1';  -- envoyé au PPc pour signifier qu'on a pris une seule image et qu'on attend l'arêt du mode
                  if run = '0' then 	-- ajout de run ='0' pour s'assurer que le PPC a arr^té le mode SingleTrig_st 
                     mode_sm <= Pause_st;							
                  end if;	
                  
                  ----------------- 					
               -- etat d'attente de feedback d'arrêt des conditionneurs 
               when Pause_st =>  
                  if fpa_trig_done = '1' and trig_out_done = '1' then 	-- ajout de run ='0' pour s'assurer que le PPC a arr^té le mode SingleTrig_st 
                     mode_sm <= idle;
                     done <= '1';
               end if;	
               when others =>					
            end case;
         end if;				  		
      end if;		
   end process; 
   
   seq_trig_i <= SEQ_SOFTTRIG when CONFIG.seq_trigsource = TRIGSEQ_SOFTWARE else EXTERNAL_TRIG_OR_GATING;
   
   TRIGSEQ_PROC : process(CLK)
   begin
      if rising_edge(CLK) then
         ext_trig_last <= seq_trig_i;
         
         if sreset = '1' or fpa_trig_param_i.acq_window = '0' then
            seq_enable_i <= '0';
            frame_count <= (others => '0');
         else
            if CONFIG.seq_trigsource = TRIGSEQ_SOFTWARE then
               -- CONFIG.seq_activ = RISINGEDGE si on utilise le trigger software
               if (seq_trig_i = '1' and ext_trig_last = '0') then
                  seq_enable_i <= '1';
                  frame_count <= (others => '0');
               end if;
            else
         
               case CONFIG.trig_activ is
                  when RISINGEDGE =>
                     if (seq_trig_i = '1' and ext_trig_last = '0') then
                        seq_enable_i <= '1';
                        frame_count <= (others => '0');
                     end if;
                     
                  when FALLINGEDGE =>
                     if (seq_trig_i = '0' and ext_trig_last = '1') then
                        seq_enable_i <= '1';
                        frame_count <= (others => '0');
                     end if;
                     
                  when ANYEDGE =>
                     if (seq_trig_i /= ext_trig_last) then
                        seq_enable_i <= '1';
                        frame_count <= (others => '0');
                     end if;
                     
                  when others =>
                     seq_enable_i <= '0';
                     frame_count <= (others => '0');
               end case;
            end if;
            
            if integration_detect = '1' then
               if CONFIG.FPATRIG_DLY = to_unsigned(0, CONFIG.FPATRIG_DLY'length) and seq_enable_i = '1' then
                  -- New frame
                  frame_count <= frame_count + 1;
                  
                  if (frame_count >= (CONFIG.seq_framecount - 1)) then
                     seq_enable_i <= '0';
                     frame_count <= (others => '0');
                  else
                     seq_enable_i <= '1';
                  end if;
               elsif seq_delay_enable_i = '1' then
                  -- New frame
                  frame_count <= frame_count + 1;
                  
                  if (frame_count >= (CONFIG.seq_framecount - 1)) then
                     seq_enable_i <= '0';
                     frame_count <= (others => '0');
                  else
                     seq_enable_i <= '1';
                  end if;
               end if;
            end if;
         end if;
      end if;
   end process TRIGSEQ_PROC;
   
   DELAY_PROC : process(CLK)
   begin
      if rising_edge(CLK) then
         seq_enable_last_i <= seq_enable_i;

         if sreset = '1' or fpa_trig_param_i.acq_window = '0' then
            clk_counter_rising <= (others => '0');
            seq_delay_enable_i <= seq_enable_i;
         else

           if CONFIG.FPATRIG_DLY /= to_unsigned(0, CONFIG.FPATRIG_DLY'length) then
              -- Active les compteurs lors de detection de edge
              if seq_enable_i = '1' and seq_enable_last_i = '0' and clk_counter_rising = to_unsigned(0, clk_counter_rising'length) then  -- rising edge et aucun rising edge est presentement en traitement
                 clk_counter_rising <= clk_counter_rising + 1;
              end if;

              -- rising edge en delai
              if clk_counter_rising /= to_unsigned(0, clk_counter_rising'length) then
                 if clk_counter_rising >= (CONFIG.FPATRIG_DLY - 1) then
                    seq_delay_enable_i <= '1';
                    clk_counter_rising <= (others => '0');
                 else
                    clk_counter_rising <= clk_counter_rising + 1;
                 end if;
              end if;

              -- falling edge
              if seq_delay_enable_i = '1' and seq_enable_i = '0' then
                 seq_delay_enable_i <= '0';
              end if;

           end if;
         end if;
      end if;
   end process DELAY_PROC;
   
end RTL;

