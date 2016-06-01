-------------------------------------------------------------------------------
--
-- Title       : dbg_clk_high_measure
-- Design      : FIR_00180_Sofradir
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180\FIR_00180_Sofradir\src\dbg_clk_high_measure.vhd
-- Generated   : Tue Nov 22 11:24:34 2011
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

entity dbg_clk_high_measure is
   port(
      ARESET            : in std_logic;
      CLK               : in std_logic; 
      ENABLE            : in std_logic; 
      SIG_IN            : in std_logic;
      SIG_LENGTH        : out std_logic_vector(9 downto 0);
      DONE              : out std_logic
      );
end dbg_clk_high_measure;


architecture RTL of dbg_clk_high_measure is 
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;   
   
   constant C_ALL_ONES            : unsigned(SIG_LENGTH'length-1 downto 0) := (others => '1');
   
   signal meas_count_i            : unsigned(SIG_LENGTH'length-1 downto 0);
   signal meas_count_o            : unsigned(SIG_LENGTH'length-1 downto 0);
   signal sreset                  : std_logic;
   signal fval_i                  : std_logic;
   signal done_o                  : std_logic;
   signal sig_valid_i             : std_logic;
   signal sig_valid_last          : std_logic;
   signal enable_i                : std_logic;
   
   
begin
   
   SIG_LENGTH <= std_logic_vector(meas_count_o);
   DONE  <= done_o;
   
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
   -- mesure de la durée de LVAL 
   --------------------------------------------------  
   U2 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            meas_count_i <= (others => '0');
            done_o <= '0';
            enable_i <= '0';
            sig_valid_i <= '0';
            sig_valid_last <= '0';
            
         else 
            
            if SIG_IN = '0' then 
               enable_i <= ENABLE;
            end if;
            
            sig_valid_i <= SIG_IN and enable_i;            
            sig_valid_last <= sig_valid_i;
            
            -- mesure de la durée                
            if sig_valid_i = '1' then 
               meas_count_i <= meas_count_i + 1;            
            else
               meas_count_i <= (others => '0'); 
            end if;            
            
            -- wrap du compteur (donc un signal qui ne descend pas
            if meas_count_i = C_ALL_ONES then 
               meas_count_o <= C_ALL_ONES;
               done_o <= '1';
            else
               done_o <= '0';
            end if;
            
            -- registres de sortie 
            if sig_valid_last = '1' and sig_valid_i = '0' then 
               meas_count_o <= meas_count_i;      -- latch de la valeur avant RAZ sur meas_count_i
            end if;         
            done_o <= sig_valid_last and not sig_valid_i; 
            

            
         end if;
      end if;
   end process;
   
   
end RTL;
