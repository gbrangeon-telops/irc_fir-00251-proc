-------------------------------------------------------------------------------
--
-- Title       : irig_threshold_gen_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\irig_threshold_gen_v2.vhd
-- Generated   : Tue Sep 13 10:33:05 2011
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

entity irig_threshold_gen_v2 is
   port(
      ARESET         : in std_logic;
      CLK            : in std_logic;
      RX_MOSI        : in t_ll_mosi8;
      RX_MISO        : out t_ll_miso;
      STARE_WINDOW   : in std_logic;
      THRESHOLD      : out std_logic_vector(7 downto 0);
      THRESHOLD_DVAL : out std_logic;
      THRESHOLD_DONE : out std_logic
      );
end irig_threshold_gen_v2;


architecture RTL of irig_threshold_gen_v2 is
   
   constant CST_DENOM  : integer := 2**9;
   constant CST_NUMER  : integer := (70*CST_DENOM)/100;
   
   component sync_reset
      port (
         ARESET : in STD_LOGIC;
         CLK    : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1'
         );
   end component;
   
   signal sreset                 : std_logic;
   signal done_i                 : std_logic;
   signal maximum_i              : unsigned(THRESHOLD'LENGTH-1 downto 0); 
   signal threshold_i            : unsigned(THRESHOLD'LENGTH-1 downto 0);
   signal stare_window_last      : std_logic;
   signal threshold_dval_i       : std_logic;
   signal threshold_temp         : integer range 0 to 256*CST_DENOM;
   
begin 
   
   
   ------------------------------------------------------
   -- sorties
   ------------------------------------------------------ 
   RX_MISO <= ('0','0');
   THRESHOLD <= std_logic_vector(threshold_i);
   THRESHOLD_DVAL <= threshold_dval_i;
   THRESHOLD_DONE <= done_i;
   
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
   U2 : process(CLK)
   begin        
      if rising_edge(CLK) then
         if sreset = '1' then 
            stare_window_last <= '0'; 
            maximum_i <= (others => '0');
            done_i <= '1';          -- fait express
            threshold_dval_i <= '0';
            threshold_i <= (others => '0');
         else   
            
            -- detection descente de STARE_WINDOW
            stare_window_last <= STARE_WINDOW;  
            
            -- recherche du MAX et du MIN dans la fenetre d'intérêt
            if STARE_WINDOW = '1' and RX_MOSI.DVAL = '1' then
               if unsigned(RX_MOSI.DATA) > maximum_i then
                  maximum_i <= unsigned(RX_MOSI.DATA);
               end if;
            end if;                                               
            
            -- reinitialisation des registres à la montée de STARE_WINDOW
            if STARE_WINDOW = '1' and  stare_window_last = '0' then
               maximum_i <= (others => '0');
               done_i <= '0';
            end if; 
            
            -- fin de la recherche
            if STARE_WINDOW = '0' and  stare_window_last = '1' then
               done_i <= '1';
            end if;               
            
            -- pour l'IRIG, le threshold est le 70% du max . De plus , le maximum est valide ssi il se retrouve au dessus de 30% de la valeur des ADC
            --threshold_temp <= to_integer(maximum_i)*CST_NUMER;
            threshold_i <= to_unsigned((to_integer(maximum_i)*CST_NUMER)/CST_DENOM, threshold_i'length);
            
            if maximum_i > ADC_VALID_RANGE  then 
               threshold_dval_i <= done_i;
            else
               threshold_dval_i <= '0';
            end if;
            
            
         end if;
      end if;
      
   end process; 
   
end RTL;
