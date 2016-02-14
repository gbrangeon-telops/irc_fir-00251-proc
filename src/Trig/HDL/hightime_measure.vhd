-------------------------------------------------------------------------------
--
-- Title       : hightime_measure
-- Design      : Trig_ctrl_tb
-- Author      : telops
-- Company     : Telops Inc
--
-------------------------------------------------------------------------------
--
-- File        : 
-- Generated   : Fri Dec 11 15:45:37 2009
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

entity hightime_measure is
   port( 
      ARESET           : in std_logic;
      CLK              : in std_logic;
      PULSE            : in std_logic;
      HIGH_TIME        : out std_logic_vector(31 downto 0)
      );
end hightime_measure;



architecture RTL of hightime_measure is 
   
   constant OVFL_THRESHOLD : unsigned(HIGH_TIME'LENGTH-1 downto 0) := (others =>'1');
   
   type counter_sm_type is (idle, highttime_st, overflow_st);
   signal counter_sm      : counter_sm_type;
   signal hightime_count  : unsigned(HIGH_TIME'LENGTH-1 downto 0);
   signal hightime_i      : unsigned(HIGH_TIME'LENGTH-1 downto 0);      
   signal sreset          : std_logic;
   signal pulse_i         : std_logic;	
   signal last_pulse_i    : std_logic;
   signal counter_en      : std_logic;
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   component clk_divider_pulse
      generic(FACTOR : integer);
      port(
         CLOCK : in std_logic;
         RESET : in std_logic;
         PULSE : out std_logic);
   end component;
   
   
begin		
   --output
   HIGH_TIME <= std_logic_vector(hightime_i);	
   
   --  synchro reset 
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      ); 	
   
   -- compteur 	
   U2: process(CLK)	
   begin 
      if rising_edge(CLK) then
         if sreset ='1' then	 
            last_pulse_i <= PULSE;
            counter_sm <= idle; 
            hightime_i <= (others => '1');
            
         else
            -- synchro	
            pulse_i <= PULSE; 
            --pour detection Front Montant
            last_pulse_i <= pulse_i;	  
            
            case counter_sm is			
               
               ------------------------
               -- etat d'attente
               when idle =>
                  hightime_count <= to_unsigned(1, hightime_count'length);
                  if last_pulse_i = '0' and pulse_i = '1' then  --detection front montant
                     counter_sm <= highttime_st;
                     hightime_i <= (others => '1'); -- valeur par defaut sortie tant que mesure non faite.
                  end if;	
               
               when highttime_st =>	      -- attention: il y a pun pullUp sur EXTTRIG <=> pas de trig => il est à '1'
                  -- comptage avec horloge de 100 MHz 
                  hightime_count <= hightime_count + 1;
                  
                  -- detection retour normal etat initial
                  if pulse_i = '0' then -- detection front descendant car on est venu isi sur front montant
                     counter_sm <= idle;
                     hightime_i <= hightime_count; -- sortie de la valeur mesurée que lorsque le front descend, sinon, valeur sortie = (others => '1')
                  end if;
                  
                  -- detection de l'overflow: cas particulier
                  if hightime_count = OVFL_THRESHOLD then 
                     counter_sm <= overflow_st;
                  end if;
               
               when overflow_st =>
                  -- detection retour normal etat initial
                  if pulse_i = '0' then 
                     counter_sm <= idle;
                     hightime_i <= (others => '0');  -- cela permet aux conditionneurs de détecter la fin du hightTime
                  end if;
               
               when others =>
               
            end case;
         end if;
      end if;
   end process;
end RTL;
