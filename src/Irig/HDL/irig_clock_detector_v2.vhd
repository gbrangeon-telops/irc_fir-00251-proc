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
   
   constant RAW_CLK_WINDOW_LEN        : integer := CLK_DETECTOR_DIV_FACTOR-2;   -- c'est la longueur totale du vecteur raw_clock_in_reg qui permet de balayer l'horloge entrante
   --constant ONE_THRESHOLD             : integer := (2*RAW_CLK_WINDOW_LEN)/3;    -- si le nombre de 1 depasse les 2/3 on est dans une zone stable de '1';
   --constant ZERO_THRESHOLD            : integer := RAW_CLK_WINDOW_LEN/3;        -- si le nombre de 0 depasse les 2/3 (et donc le nombre de 1 inferieur à 1/3) on est dans une zone stable de '0' 
   
   
   type freq_sm_type is (idle, meas_period_st, check_st1, check_st2);
   type re_delay_fsm_type is (idle, delay_st); 
   
   signal re_delay_fsm                : re_delay_fsm_type;
   signal freq_sm                     : freq_sm_type;   
   signal raw_clock_in_reg            : std_logic_vector(RAW_CLK_WINDOW_LEN-1 downto 0);
   signal raw_clock_in_iob            : std_logic; 
   signal raw_clock_in_iob_n          : std_logic;
   signal filt_clock_reg              : std_logic;
   signal sreset                      : std_logic;
   signal clk_cnt                     : unsigned(CLK_DETECTOR_DIV_BIT downto 0);
   signal detector_mclk_rising_edge   : std_logic;
   signal clk_bit_last                : std_logic; 
   signal sum_reg                     : unsigned(log2(CLK_DETECTOR_DIV_FACTOR) downto 0);
   signal reg_cnt                     : unsigned(log2(CLK_DETECTOR_DIV_FACTOR) downto 0);
   signal sum_reg_valid               : std_logic;
   signal clock_present_i             : std_logic;
   signal filt_clock_reg_last         : std_logic; 
   signal meas_count                  : unsigned(log2(IRIG_CARRIER_PERIOD_MAX_FACTOR) downto 0);   
   signal irig_clk_i                  : std_logic;
   signal irig_clk_i_last             : std_logic;
   signal irig_clk_rising             : std_logic; 
   signal re_delay_cnt                : unsigned(15 downto 0); -- permet de decaler le rising_edge de l'horloge IRIG pour se synchroniser sur les données
   
   attribute IOB : string;
   attribute IOB of raw_clock_in_iob                           : signal is "FORCE";     
   --
   attribute equivalent_register_removal : string; 
   attribute equivalent_register_removal of raw_clock_in_iob   : signal is "NO";     
   
   
   
begin
   
   --------------------------------------------------
   -- sortie
   -------------------------------------------------- 
   RAW_CLOCK_OUT <= raw_clock_in_iob;  -- RAW_CLOCK_OUT est en phase avec le signal entrant
   --FILT_CLOCK_OUT <= filt_clock_reg;   -- se rappeler que cette horloge étant filtrée, on a des delais. Il faut donc le decaler pour une synchronisation pargfaite. Le decalge se fait dans les differents blocs qui l'utilisent.
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
   
   
   --------------------------------------------------
   -- horloge de 312 KHz à partir de 20 MHz
   --------------------------------------------------  
   U2 : process(CLK)   
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            clk_cnt <= (others =>'0');
            detector_mclk_rising_edge <= '0';
            clk_bit_last <= '0';
         else
            clk_cnt <= clk_cnt + 1;  
            clk_bit_last <= std_logic(clk_cnt(CLK_DETECTOR_DIV_BIT));              -- simple divison de l'horloge de 20MHz par CLK_DETECTOR_DIV_FACTOR 
            detector_mclk_rising_edge <= not clk_bit_last and clk_cnt(CLK_DETECTOR_DIV_BIT); 
         end if;
      end if;
   end process;
   
   
   --------------------------------------------------
   -- signal entrant dans IOB
   -------------------------------------------------- 
   U3 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         raw_clock_in_iob <= RAW_CLOCK_IN;
         raw_clock_in_iob_n <= not raw_clock_in_iob;-- ceci est requis car les données de l'ADC sont en opposition de phase avec l'horloge dont nous avons besoin (ceci est dû à l'opamp qui a un gain negatif)
      end if;
   end process;
   
   
   --------------------------------------------------
   -- filtrage du signal entrant
   -------------------------------------------------- 
   -- principe: on prend des echantillons à 312KHz, du signal binaire.
   -- sur une serie de 60 echantillons, si nb_de_uns > nb_de_zeros - 8 echantillons alors on est dans une zone de '1' ,
   -- sinon c'est une zone de '0'.
   -- tous les glitches de durée 48 usec environ seront supprimées.
   
   
   U4 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            sum_reg <= (others =>'0'); 
            reg_cnt <= (others =>'1');
            sum_reg_valid <= '0';
            filt_clock_reg <= '0'; 
            -- translate_off
            raw_clock_in_reg <= (others =>'0');
            -- translate_on
         else 
            
            -- registre à decalage à 312 KHz
            if detector_mclk_rising_edge = '1' then 
               raw_clock_in_reg(0) <= raw_clock_in_iob_n;
               raw_clock_in_reg(raw_clock_in_reg'LENGTH-1 downto 1) <= raw_clock_in_reg(raw_clock_in_reg'LENGTH-2 downto 0); 
            end if;            
            
            -- re-initialisation
            if detector_mclk_rising_edge = '1' then 
               sum_reg <= (others =>'0');
               reg_cnt <= (others =>'0'); 
            end if;
            
            -- somme des '1' contenu dans le pipe avant l'arrivée du prochain detector_mclk_rising_edge
            if reg_cnt < raw_clock_in_reg'LENGTH then
               if raw_clock_in_reg(to_integer(reg_cnt)) = '1' then 
                  sum_reg <=  sum_reg + 1;
               end if;
               reg_cnt <= reg_cnt + 1;
            elsif  reg_cnt = raw_clock_in_reg'LENGTH then
               sum_reg_valid <= '1';    
               reg_cnt <= reg_cnt + 1;
            else
               sum_reg_valid <= '0';  
            end if;             
            
            -- prise de decision
            if  sum_reg_valid = '1' then 
               if sum_reg = RAW_CLK_WINDOW_LEN then           -- s'il y a 2/3 de '1' alors on est dans une zone de '1'
                  filt_clock_reg <= '1';
               elsif  sum_reg = 0 then                        -- s'il y a 2/3 de '0' et donc moins de 1/3 de '1' alors on est dans une zone de '0'
                  filt_clock_reg <= '0'; 
               end if;                                        -- s'il y a entre 1/3 et 2/3 de '1' ne pas changer d'état car on est possiblement en zone instable  
            end if; 
            
            
         end if;
      end if;
   end process;
   
   
   -----------------------------------------------------------------------
   -- decalage de l'horloge IRIG pour se synchroniser sur les données
   ----------------------------------------------------------------------- 
   --puis génération du rising
   U41: process(CLK)
   begin  
      if rising_edge(CLK) then 
         if sreset = '1' then 
            irig_clk_rising <= '0';
            re_delay_fsm <= idle;
         else
            
            -- detection du debut d'une periode de la porteuse IRIG
            irig_clk_i <= filt_clock_reg;
            irig_clk_i_last <= irig_clk_i;           
            
            case re_delay_fsm is
               
               when idle =>  
                  re_delay_cnt <= (others => '0');
                  irig_clk_rising <= '0';
                  if irig_clk_i = '1' and irig_clk_i_last = '0' then
                     re_delay_fsm <= delay_st;
                  end if;     
               
               when delay_st =>
                  re_delay_cnt <= re_delay_cnt + 1; 
                  if  re_delay_cnt = DATA_SYNC_DELAY then 
                     irig_clk_rising <= '1';
                     re_delay_fsm <= idle;
                  end if;
                  -- pragma translate_off
                  irig_clk_rising <= '1';
                  re_delay_fsm <= idle;
                  -- pragma translate_on
                  
               
               when others =>
               
            end case; 
            
         end if;
         
      end if;
   end process;
   
   
   
   
   --------------------------------------------------
   -- detection de l'horloge par mesure de sa periode
   --------------------------------------------------  
   U5 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            freq_sm <= idle; 
            clock_present_i <= '0';
            filt_clock_reg_last <= '0';
         else 
            
            filt_clock_reg_last <= filt_clock_reg;            
            
            case freq_sm is 
               
               when idle =>  
                  meas_count <= (others => '0');                 
                  if filt_clock_reg = '1' and filt_clock_reg_last = '0' then
                     freq_sm <= meas_period_st;   
                  end if;
               
               when meas_period_st => 
                  if detector_mclk_rising_edge = '1' then 
                     meas_count <= meas_count + 1;                   
                  end if;
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
