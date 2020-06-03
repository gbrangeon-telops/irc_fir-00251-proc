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
      
      EXTERNAL_TRIG                   : in std_logic;  -- pulse en provenance de l'exterieur
      SEQ_SOFTTRIG                    : in std_logic;  -- pulse en provenance du ublaze
      
      GATE                            : in std_logic;
      
      RAW_PULSE                       : out std_logic; -- pulse envoyé au conditionneur de trigs         
      
      INTERNAL_PULSE                  : in std_logic;  -- pulse interne généré par l'oscillateur local
      INTERNAL_PULSE_PERIOD           : out std_logic_vector(31 downto 0); -- periode du trig , pour oscillateur local seulement
      INTERNAL_PULSE_CNTRAZ           : out std_logic;
      
      FPA_TRIG_STAT                   : in std_logic_vector(7 downto 0);
      FPA_TRIG_PARAM                  : out trig_conditioner_type; 
      
      STATUS                          : out std_logic_vector(7 downto 0)
      );
end trig_gen_ctler_core;



architecture RTL of trig_gen_ctler_core is
   type mode_sm_type is (idle, IntTrig_st, ExtTrig_st, SfwTrig_st, SingleTrig_st, SeqTrig_st, Feedback_to_ppc_st, Pause_st);
   signal mode_sm                       : mode_sm_type;
   signal sreset                        : std_logic;
   signal raw_pulse_i                   : std_logic;	 -- trig envoyé au conditionneur de trigs
   signal internal_pulse_period_i       : std_logic_vector(31 downto 0);
   signal fpa_trig_param_i              : trig_conditioner_type;
   signal done                          : std_logic;
   signal fpa_trig_done                 : std_logic;
   signal run                           : std_logic;
   signal integration_detect            : std_logic;
   signal acq_int_last                  : std_logic;
   signal internal_pulse_cntraz_i       : std_logic; -- permet de mettre à '0' le compteur de generation des trigs
   signal fpa_trig_Allow_HighTimeChange : std_logic;
   
   signal frame_count        : unsigned(31 downto 0);
   signal seq_trig_last      : std_logic;
   signal seq_enable_i       : std_logic;
   signal seq_enable_last_i  : std_logic;
   signal seq_delay_enable_i : std_logic;
   signal seq_trig_i         : std_logic;
   signal trig_seq_sreset    : std_logic := '1';
   
   signal clk_counter_rising        : unsigned(31 downto 0);
   
   signal gating_enable : std_logic;
   signal gate_i        : std_logic;
   
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
   
   attribute KEEP : string;
   attribute KEEP of raw_pulse_i : signal is "TRUE";
   attribute KEEP of internal_pulse_cntraz_i : signal is "TRUE";
   attribute KEEP of internal_pulse_period_i : signal is "TRUE";
   attribute KEEP of fpa_trig_param_i : signal is "TRUE";
   attribute KEEP of integration_detect : signal is "TRUE";
   attribute KEEP of mode_sm : signal is "TRUE";
   attribute KEEP of CONFIG : signal is "TRUE";
   attribute KEEP of fpa_trig_done : signal is "TRUE";
   attribute KEEP of run : signal is "TRUE";
   attribute KEEP of seq_delay_enable_i : signal is "TRUE";
   attribute KEEP of INTERNAL_PULSE : signal is "TRUE";
   attribute KEEP of seq_trig_i : signal is "TRUE";
   attribute KEEP of seq_enable_i : signal is "TRUE";
   
begin 
   -----------------------------------------------------
   -- mapping entrée
   -----------------------------------------------------
   fpa_trig_Allow_HighTimeChange <= FPA_TRIG_STAT(1);   -- directement mapping de statut de fpa_trig
   
   -----------------------------------------------------
   -- mapping sortie
   -----------------------------------------------------	
   --periode
   INTERNAL_PULSE_PERIOD <= internal_pulse_period_i;
   INTERNAL_PULSE_CNTRAZ <= internal_pulse_cntraz_i;
   
   -- parametre pour conditionneur de trigs
   FPA_TRIG_PARAM <= fpa_trig_param_i;	
   
   -- trig envoyé au conditionneur de trigs
   RAW_PULSE <= raw_pulse_i;
   
   -- statuts
   process(CLK) -- requis pour eviter pb de timing au sujet de fpa_trig_Allow_HighTimeChange
   begin
      if rising_edge(CLK)then
         STATUS(7) <= '0'; 
         STATUS(6) <= '0'; 
         STATUS(5) <= '0'; 
         STATUS(4) <= '0'; 
         STATUS(3) <= '0'; 
         STATUS(2) <= fpa_trig_Allow_HighTimeChange; 
         STATUS(1) <= '0'; 
         STATUS(0) <= done;   -- done du contrôleur 
      end if;
   end process;
   
   -------------------------------------------------------
   --autres mappings--
   -------------------------------------------------------
   fpa_trig_done <= FPA_TRIG_STAT(0);
   
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
   -- detection  du front montant de acq_int
   ---------------------------------------------------------------------	
   acqInt_sync_proc: process(CLK)
   begin		   
      if rising_edge(CLK) then
         if sreset ='1' then 
            integration_detect <= '0';	
            acq_int_last <= '1';
         else 					   				
            acq_int_last <= ACQ_INT;
            if acq_int_last = '0' and ACQ_INT = '1' then 
               integration_detect <= '1';	
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
         if sreset = '1' then
            mode_sm <= idle;
            done <= '0';
            fpa_trig_param_i.RUN  <= '0';
            raw_pulse_i <= '0';
            internal_pulse_period_i <= (others =>'0');
            internal_pulse_cntraz_i <= '1';
            
         else				
            gate_i <= GATE;
            
            case mode_sm is 
               
               --------------
               -- etat d'attente et de verification de mode 
               when idle =>
                  done <= '1';
                  raw_pulse_i <= '0';
                  fpa_trig_param_i.RUN  <= '0';-- arrêt du conditionneur de trigs
                  internal_pulse_cntraz_i <='1';
                  gating_enable <= '0';
                  
                  if  fpa_trig_done = '1' and run = '1'  then 
                     if  CONFIG.MODE = INTTRIG then						
                        mode_sm <= IntTrig_st;						
                     elsif CONFIG.MODE = GATING then						
                        mode_sm <= IntTrig_st;
                        gating_enable <= '1';
                     elsif CONFIG.MODE = EXTTRIG then			
                        mode_sm <= ExtTrig_st;
                        --fpa_trig_param_i.HIGH_TIME <= (others =>'1');-- donne le temps à la mesure du HIGH_TIME (sortie du processeur de trig  bloqué à '1' en attentant la fin de la mesure)
                     elsif CONFIG.MODE = SINGLE_TRIG then
                        mode_sm <= SingleTrig_st;
                     elsif CONFIG.MODE = SFW_TRIG then
                        mode_sm <= SfwTrig_st;
                     elsif CONFIG.MODE = SEQ_TRIG then
                        mode_sm <= SeqTrig_st;
                     end if;
                     internal_pulse_period_i <= std_logic_vector(CONFIG.PERIOD);  -- envoyer le changement de priode avant de lancer le conditionneur 						
                     done <= '0';
                  end if;
                  
                  -------------
               -- etat trig interne 	
               when IntTrig_st => 
                  internal_pulse_cntraz_i <= '0';
                  -- pulse envoyé au conditionneur de trigs
                  if CONFIG.FORCE_HIGH = '1' then	  
                     raw_pulse_i <= '1';
                  else
                     raw_pulse_i <= INTERNAL_PULSE;
                  end if;	
                  
                  -- parametres pour le conditionneur de trigs
                  fpa_trig_param_i.RUN        <= '1';
                  if fpa_trig_Allow_HighTimeChange = '1' then    --changement en live du HIGH_TIME des trigs 
                     fpa_trig_param_i.HIGH_TIME  <= CONFIG.HIGH_TIME; -- peut changer sans probleme car le temps d'integration change sans reconfiguration de la camera
                  end if;
                  if gating_enable = '1' and gate_i = '0' then
                     fpa_trig_param_i.ACQ_WINDOW <= '0'; -- force des extra_trigs
                  else
                     fpa_trig_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  end if;
                  
                  -- detection arrêt
                  if run = '0' then -- arreter le conditionneur
                     fpa_trig_param_i.RUN  <= '0';
                     mode_sm <= Pause_st;
                  end if;	
                  
                  -----------------
               -- etat trig externe 	
               when ExtTrig_st =>
                  -- pulse envoyé au conditionneur de trigs
                  raw_pulse_i <= EXTERNAL_TRIG and seq_delay_enable_i;
                  
                  -- parametres pour le conditionneur de trigs
                  fpa_trig_param_i.RUN        <= '1';
                  fpa_trig_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  fpa_trig_param_i.HIGH_TIME  <= CONFIG.HIGH_TIME;						
                  
                  -- detection arrêt
                  if integration_detect = '1' then
                     fpa_trig_param_i.RUN  <= '0';
                     mode_sm <= Pause_st;
                  end if;	
               
               when SfwTrig_st =>
                  -- pulse envoyé au conditionneur de trigs
                  raw_pulse_i <= SFW_SYNC_TRIG;
                  
                  -- parametres pour le conditionneur de trigs
                  fpa_trig_param_i.RUN        <= '1';
                  if fpa_trig_Allow_HighTimeChange = '1' then    --changement en live du HIGH_TIME des trigs 
                     fpa_trig_param_i.HIGH_TIME  <= CONFIG.HIGH_TIME; -- peut changer sans probleme car le temps d'integration change sans reconfiguration de la camera
                  end if;
                  fpa_trig_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  
                  -- detection arrêt
                  if run = '0' then -- arreter le conditionneur
                     fpa_trig_param_i.RUN  <= '0';
                     mode_sm <= Pause_st;
                  end if;	
                  
                  -----------------
               -- etat single Trig	
               when SingleTrig_st =>
                  
                  --internal_pulse_cntraz_i <= '0';
                  if (seq_delay_enable_i = '1') then
                     internal_pulse_cntraz_i <= '0';
                  else
                     internal_pulse_cntraz_i <= '1';
                  end if;
                  -- pulse envoyé au conditionneur de trigs
                  if CONFIG.FORCE_HIGH = '1' then	  
                     raw_pulse_i <= '1';
                  else
                     raw_pulse_i <= INTERNAL_PULSE and seq_delay_enable_i;
                  end if;	
                  
                  -- parametres pour le conditionneur de trigs
                  fpa_trig_param_i.RUN        <= '1';
                  fpa_trig_param_i.HIGH_TIME  <= CONFIG.HIGH_TIME;
                  fpa_trig_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  
                  -- detection integration 
                  --if  run = '0' then  -- demande d'abandon
                  --   fpa_trig_param_i.RUN  <= '0';
                  --   mode_sm <= Pause_st; 
                  --end if;--else
                  if integration_detect = '1' then
                     fpa_trig_param_i.RUN  <= '0';
                     mode_sm <= feedback_to_ppc_st; 
                  end if;
                  --end if;	
                  
                  -----------------
               -- etat sequence Trig	
               when SeqTrig_st =>
                  if (seq_delay_enable_i = '1') then
                     internal_pulse_cntraz_i <= '0';
                  else
                     internal_pulse_cntraz_i <= '1';
                  end if;
                  -- pulse envoyé au conditionneur de trigs
                  if CONFIG.FORCE_HIGH = '1' then	  
                     raw_pulse_i <= '1';
                  else
                     raw_pulse_i <= INTERNAL_PULSE and seq_delay_enable_i;
                  end if;	
                  
                  -- parametres pour le conditionneur de trigs
                  fpa_trig_param_i.RUN        <= '1';
                  fpa_trig_param_i.HIGH_TIME  <= CONFIG.HIGH_TIME;
                  fpa_trig_param_i.ACQ_WINDOW <= CONFIG.ACQ_WINDOW;
                  
                  -- detection arrêt
                  if run = '0' then -- arreter le conditionneur
                     fpa_trig_param_i.RUN  <= '0';
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
               -- etat d'attente de feedback d'arrêt du conditionneur
               when Pause_st =>  
                  if fpa_trig_done = '1' then 	-- ajout de run ='0' pour s'assurer que le PPC a arr^té le mode SingleTrig_st 
                     mode_sm <= idle;
                     done <= '1';
                  end if;	
               when others =>					
            end case;
         end if;				  		
      end if;		
   end process; 
   
   seq_trig_i <= SEQ_SOFTTRIG when CONFIG.seq_trigsource = TRIGSEQ_SOFTWARE else EXTERNAL_TRIG;
   
   TRIG_ACT_PROC : process(CLK)
   begin
      if rising_edge(CLK) then
         seq_trig_last <= seq_trig_i;
         
         trig_seq_sreset <= sreset or not fpa_trig_param_i.acq_window;
         
         if trig_seq_sreset = '1' then
            seq_enable_i <= '0';
         else
            if CONFIG.seq_trigsource = TRIGSEQ_SOFTWARE then
               -- CONFIG.trig_activ = RISINGEDGE si on utilise le trigger software
               if (seq_trig_i = '1' and seq_trig_last = '0') then
                  seq_enable_i <= '1';
               end if;
            else
               
               case CONFIG.trig_activ is
                  when RISINGEDGE =>
                     if (seq_trig_i = '1' and seq_trig_last = '0') then
                        seq_enable_i <= '1';
                     end if;
                  
                  when FALLINGEDGE =>
                     if (seq_trig_i = '0' and seq_trig_last = '1') then
                        seq_enable_i <= '1';
                     end if;
                  
                  when ANYEDGE =>
                     if (seq_trig_i /= seq_trig_last) then
                        seq_enable_i <= '1';
                     end if;
                  
                  when others =>
                     seq_enable_i <= '0';
               end case;
            end if;
            
            -- Reset seq_enable_i after one clock cycle
            if seq_enable_i = '1' then
               seq_enable_i <= '0';
            end if;
            
         end if;
      end if;
   end process TRIG_ACT_PROC;
   
   DELAY_PROC : process(CLK)
   begin
      if rising_edge(CLK) then
         seq_enable_last_i <= seq_enable_i;
         
         if trig_seq_sreset = '1' then
            clk_counter_rising <= (others => '0');
            seq_delay_enable_i <= '0';
            frame_count <= (others => '0');
         else
            
            -- Delay
            if CONFIG.FPATRIG_DLY /= to_unsigned(0, CONFIG.FPATRIG_DLY'length) then
               -- Active les compteurs lors de detection de edge
               if seq_enable_i = '1' and seq_enable_last_i = '0' and clk_counter_rising = to_unsigned(0, clk_counter_rising'length) then  -- rising edge et aucun rising edge est presentement en traitement
                  clk_counter_rising <= clk_counter_rising + 1;
               end if;
               
               -- rising edge en delai
               if clk_counter_rising /= to_unsigned(0, clk_counter_rising'length) then
                  if clk_counter_rising >= (CONFIG.FPATRIG_DLY - 1) then
                     seq_delay_enable_i <= '1';
                     frame_count <= (others => '0');
                     clk_counter_rising <= (others => '0');
                  else
                     clk_counter_rising <= clk_counter_rising + 1;
                  end if;
               end if;
            
            -- No delay
            else
               if seq_enable_i = '1' and seq_enable_last_i = '0' then
                  seq_delay_enable_i <= '1';
                  frame_count <= (others => '0');
               end if;
            end if;
            
            -- Sequence completed
            if seq_delay_enable_i = '1' and integration_detect = '1' then
               -- New frame
               frame_count <= frame_count + 1;
               
               if (frame_count >= (CONFIG.seq_framecount - 1)) then
                  seq_delay_enable_i <= '0';
                  frame_count <= (others => '0');
               else
                  seq_delay_enable_i <= '1';
               end if;
            end if;
            
         end if;
      end if;
   end process DELAY_PROC;
   
end RTL;

