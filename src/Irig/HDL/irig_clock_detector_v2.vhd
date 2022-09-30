-------------------------------------------------------------------------------
--
-- Title       : irig_clock_detector_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\irig_clock_detector_v2.vhd
-- Generated   : Fri Sep  9 10:52:18 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
--library COMMON_HDL;
use work.tel2000.all;
use work.IRIG_define_v2.all;

entity irig_clock_detector_v2 is
   port(
      CLK            : in STD_LOGIC;
      ARESET         : in STD_LOGIC;
      RAW_CLOCK_IN   : in STD_LOGIC;
      CLOCK_PRESENT  : out STD_LOGIC;
      RAW_CLOCK_OUT  : out STD_LOGIC;
      IRIG_CARRIER_RE: out STD_LOGIC
      
      );
end irig_clock_detector_v2;



architecture RTL of irig_clock_detector_v2 is
   
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
   
   component gh_debounce 
   	generic (min_pw: integer :=1;
   	         hold: integer :=10); -- 2 is min useful value
   	port(
   		CLK : in STD_LOGIC;
   		rst : in STD_LOGIC;
   		D   : in STD_LOGIC;
   		Q   : out STD_LOGIC
   		);
   end component;
   
   constant RAW_CLK_DEBOUNCE_USEC     : integer := 10;
   constant RAW_CLK_DEBOUNCE_FACTOR   : integer := (SYS_CLK_FREQ_HZ/1_000_000)*RAW_CLK_DEBOUNCE_USEC; -- RAW_CLK_DEBOUNCE_USEC en coups de clock système
   -------------------------------------------------------------------------------------------------
   -- À l'origine, l'horloge filtrée était générée à partir de l'horloge brute passant 
   -- dans un registre à décalage sur une horloge de 312.5kHz (horloge système / 64). Avec 62
   -- échantillons de suite à la même valeur, cette valeur était attribuée à l'horloge filtrée.
   -- L'horloge filtrée était donc l'horloge brute décalée de 62 x 64 coups d'horloge système.
   -- En ajoutant un module de debounce, l'horloge filtrée est simplement générée par un délai 
   -- équivalent pour conserver la même synchronisation.
   -- L'horloge de 312.5kHz (horloge système / 64) a été abandonnée puisqu'elle était asynchrone
   -- à l'horloge brute et ajoutait du jitter à la génération de l'horloge filtrée.
   constant FILT_CLK_DELAY            : integer := 62*64;
   -------------------------------------------------------------------------------------------------
   
   
   type freq_sm_type is (idle, meas_period_st, check_st1, check_st2);
   type delay_fsm_type is (idle, delay_st); 
   
   signal re_delay_fsm, filt_clk_delay_fsm                : delay_fsm_type;
   signal freq_sm                     : freq_sm_type;   
   signal raw_clock_in_sync           : std_logic;
   signal raw_clock_debounce, raw_clock_debounce_last          : std_logic;
   signal raw_clock_re                : std_logic;
   signal filt_clock_reg, filt_clock_reg_last              : std_logic;
   signal sreset                      : std_logic;
   signal clock_present_i             : std_logic;
   signal meas_count                  : unsigned(log2(IRIG_CARRIER_PERIOD_MAX_FACTOR) downto 0);   
   signal irig_clk_rising             : std_logic; 
   signal re_delay_cnt                : unsigned(log2(DATA_SYNC_DELAY) downto 0); -- permet de decaler le rising_edge de l'horloge IRIG pour se synchroniser sur les données
   signal filt_clk_delay_cnt          : unsigned(log2(FILT_CLK_DELAY) downto 0);
   
   
   
begin
   
   --------------------------------------------------
   -- sortie
   -------------------------------------------------- 
   RAW_CLOCK_OUT <= raw_clock_debounce;  -- RAW_CLOCK_OUT est en phase avec le signal entrant
   --FILT_CLOCK_OUT <= filt_clock_reg;   -- se rappeler que cette horloge étant filtrée, on a des delais. Il faut donc le decaler pour une synchronisation parfaite.
   CLOCK_PRESENT <= clock_present_i;
   IRIG_CARRIER_RE <= irig_clk_rising;  -- Rising_edge parfaitement synchronisé avec l'entrée des données IRIG (tient compte des delais de la chaine)
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   -- synchronize and debounce RAW_CLOCK_IN
   S1 : double_sync generic map(INIT_VALUE => '0') port map (RESET => sreset, D => RAW_CLOCK_IN, CLK => CLK, Q => raw_clock_in_sync);
   --D1 : gh_debounce generic map(min_pw => RAW_CLK_DEBOUNCE_FACTOR, hold => 2) port map (CLK => CLK, rst => sreset, D => raw_clock_in_sync, Q => raw_clock_debounce);  -- on ignore les petits pulses avant une transition stable
   D1 : gh_debounce generic map(min_pw => 1, hold => RAW_CLK_DEBOUNCE_FACTOR) port map (CLK => CLK, rst => sreset, D => raw_clock_in_sync, Q => raw_clock_debounce);    -- on transitionne au 1er pulse et on ignore les suivants
   
   
   -----------------------------------------------------------------------
   -- Génération de l'horloge filtrée (voir notes constant FILT_CLK_DELAY)
   -----------------------------------------------------------------------  
   U2 : process(CLK)   
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            filt_clk_delay_fsm <= idle;
            filt_clock_reg <= '0';
            raw_clock_debounce_last <= raw_clock_debounce;
         else
            
            raw_clock_debounce_last <= raw_clock_debounce;
            
            case filt_clk_delay_fsm is
               
               when idle =>  
                  filt_clk_delay_cnt <= (others => '0');
                  if raw_clock_debounce_last = '0' and raw_clock_debounce = '1' then   -- rising edge
                     filt_clk_delay_fsm <= delay_st;
                     raw_clock_re <= '1';
                  elsif raw_clock_debounce_last = '1' and raw_clock_debounce = '0' then   -- falling edge
                     filt_clk_delay_fsm <= delay_st;
                     raw_clock_re <= '0';
                  end if;     
               
               when delay_st =>
                  filt_clk_delay_cnt <= filt_clk_delay_cnt + 1; 
                  if filt_clk_delay_cnt = FILT_CLK_DELAY then 
                     filt_clock_reg <= not raw_clock_re;  -- inversion requise car les données de l'ADC sont en opposition de phase avec l'horloge dont nous avons besoin (ceci est dû à l'opamp qui a un gain negatif)
                     filt_clk_delay_fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
 
         end if;
      end if;
   end process;
   
   
   -----------------------------------------------------------------------
   -- decalage de l'horloge IRIG pour se synchroniser sur les données
   -----------------------------------------------------------------------
   U3 : process(CLK)
   begin  
      if rising_edge(CLK) then 
         if sreset = '1' then 
            irig_clk_rising <= '0';
            re_delay_fsm <= idle;
         else
            
            case re_delay_fsm is
               
               when idle =>  
                  re_delay_cnt <= (others => '0');
                  irig_clk_rising <= '0';
                  if filt_clock_reg = '1' and filt_clock_reg_last = '0' then
                     re_delay_fsm <= delay_st;
                  end if;     
               
               when delay_st =>
                  re_delay_cnt <= re_delay_cnt + 1; 
                  if re_delay_cnt = DATA_SYNC_DELAY then 
                     irig_clk_rising <= '1';
                     re_delay_fsm <= idle;
                  end if;
               
               when others =>
               
            end case; 
            
         end if;
         
      end if;
   end process;
   
   
   
   
   ---------------------------------------------------
   -- detection de l'horloge pour mesure de sa periode
   ---------------------------------------------------  
   U4 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            freq_sm <= idle; 
            clock_present_i <= '0';
            filt_clock_reg_last <= filt_clock_reg;
         else 
            
            filt_clock_reg_last <= filt_clock_reg;            
            
            case freq_sm is 
               
               when idle =>  
                  meas_count <= (others => '0');                 
                  if filt_clock_reg = '1' and filt_clock_reg_last = '0' then
                     freq_sm <= meas_period_st;   
                  end if;
               
               when meas_period_st =>
                  meas_count <= meas_count + 1;
                  if filt_clock_reg = '1' and filt_clock_reg_last = '0' then
                     freq_sm <= check_st1;   
                  end if;
                  if meas_count > IRIG_CARRIER_PERIOD_MAX_FACTOR then -- timeout
                     freq_sm <= idle;
                     clock_present_i <= '0';
                  end if;
               
               when check_st1 =>
                  if meas_count >= IRIG_CARRIER_PERIOD_MIN_FACTOR then 
                     freq_sm <= check_st2;
                  else
                     freq_sm <= idle;
                     clock_present_i <= '0';
                  end if;
               
               when check_st2 => 
                  if meas_count <= IRIG_CARRIER_PERIOD_MAX_FACTOR then 
                     clock_present_i <= '1';
                  else
                     clock_present_i <= '0';
                  end if;
                  freq_sm <= idle; 
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   
   
   
   
end RTL;
