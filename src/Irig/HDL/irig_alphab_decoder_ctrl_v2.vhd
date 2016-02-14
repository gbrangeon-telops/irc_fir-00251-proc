-------------------------------------------------------------------------------
--
-- Title       : irig_alphab_decoder_ctrl_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\irig_alphab_decoder_ctrl_v2.vhd
-- Generated   : Tue Sep 13 14:29:29 2011
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
--library Common_HDL;
--use Common_HDL.Telops.all;
use work.IRIG_define_v2.all;

entity irig_alphab_decoder_ctrl_v2 is
   port(    
      ARESET             : in std_logic;
      CLK                : in std_logic;  
      
      ALPHAB_REFPULSE    : in std_logic;
      ALPHAB_DEC_CFG     : in alphab_decoder_cfg_type;
      ALPHAB_SYNC_FOUND  : in std_logic;
      ALPHAB_ERR         : in std_logic_vector(7 downto 0);
      COMPARATOR_ERR     : in std_logic; 
      THRESHOLD_DONE     : in std_logic;
      
      THRESHOLD_WINDOW   : out std_logic;
      STATUS             : out std_logic_vector(7 downto 0)
      );
end irig_alphab_decoder_ctrl_v2;


architecture RTL of irig_alphab_decoder_ctrl_v2 is
   component sync_reset
      port (
         ARESET : in STD_LOGIC;
         CLK    : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1'
         );
   end component;                              
   
   type alphab_fsm_type is (idle, init_threshold_st, threshold_st, end_threshold_st, wait_alphab_detector_st); 
   signal alphab_fsm             : alphab_fsm_type;   
   signal sreset                 : std_logic;
   signal init_done              : std_logic;
   signal threshold_window_i     : std_logic;
   signal alphab_decoder_success : std_logic;
   signal idle_cnt               : unsigned(2 downto 0);
   
   
begin 
   
   
   ------------------------------------------------------
   -- sorties
   ------------------------------------------------------ 
   --statuts
   U0 : process(CLK)
   begin
      if rising_edge(CLK) then
         STATUS(7 downto 5) <= (others => '0');
         STATUS(4) <= ALPHAB_ERR(1);
         STATUS(3) <= COMPARATOR_ERR;
         STATUS(2) <= ALPHAB_ERR(0);
         STATUS(1) <= alphab_decoder_success;
         STATUS(0) <= init_done;
      end if;
   end process;
   -- theshold_window 
   THRESHOLD_WINDOW <= threshold_window_i;
   
   ------------------------------------------------------
   -- Sync reset
   ------------------------------------------------------
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK => CLK,
      SRESET => sreset
      );
   
   
   
   ------------------------------------------------------
   -- proc
   ------------------------------------------------------    
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            alphab_fsm <= idle; 
            init_done <= '0';
            alphab_decoder_success <= '0';
            threshold_window_i <= '0';
         else
            
            case alphab_fsm is 
               
               when idle  =>                  
                  init_done <= '1'; 
                  alphab_decoder_success <= ALPHAB_SYNC_FOUND;
                  threshold_window_i <= '0';
                  if ALPHAB_DEC_CFG.INIT = '1' and THRESHOLD_DONE = '1' then  -- demande de lancement de l'initialisation
                     alphab_fsm <= init_threshold_st;
                     init_done <= '0';
                     alphab_decoder_success <= '0';
                  end if;    
                  idle_cnt <= (others => '0');
               
               when init_threshold_st =>           -- on lance la recherche du threshold et on attend que le module soit lancé               
                  threshold_window_i <= '1';
                  if THRESHOLD_DONE = '0' then 
                     alphab_fsm <= threshold_st;
                  end if;
               
               when threshold_st =>                 -- on attend qu'au moins deux morphemes sont captées pour determiner le seuil
                  if ALPHAB_REFPULSE = '1' then
                     idle_cnt <=  idle_cnt + 1; 
                  end if;
                  if idle_cnt = 3 then            
                     alphab_fsm <= end_threshold_st;
                     threshold_window_i <= '0';
                  end if; 
               
               when end_threshold_st =>          -- on attend la fin de la determination du seuil
                  idle_cnt <= (others => '0');
                  if THRESHOLD_DONE = '1' then 
                     alphab_fsm <= wait_alphab_detector_st;
                  end if;
               
               when wait_alphab_detector_st =>    -- on attend qu'au moins deux morphemes sont passées dans le detecteur d'alphabet
                  if ALPHAB_REFPULSE = '1' then
                     idle_cnt <=  idle_cnt + 1; 
                  end if;
                  if idle_cnt = 3 then          
                     alphab_fsm <= idle;
                  end if;                  
               
               when others =>
               
            end case;
            
         end if; 
      end if;
      
   end process;
   
end RTL;
