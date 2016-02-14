-------------------------------------------------------------------------------
--
-- Title       : high_duration
-- Design      : FIR_00180_Sofradir
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180\FIR_00180_Sofradir\src\high_duration.vhd
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
--library COMMON_HDL;
--use COMMON_HDL.Telops.all;

entity high_duration is
   port(
      ARESET      : in STD_LOGIC;
      CLK         : in STD_LOGIC;
      ENABLE      : in STD_LOGIC;
      SIGNAL_IN   : in STD_LOGIC;
      HIGH_LENGTH : out STD_LOGIC_VECTOR(31 downto 0);
      DONE        : out STD_LOGIC
      );
end high_duration;


architecture RTL of high_duration is 
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;   
   
   signal meas_count : unsigned(31 downto 0);
   type meas_fsm_type is (idle, meas_high_st);   
   signal meas_fsm                : meas_fsm_type; 
   signal sreset                  : std_logic;
   signal signal_in_last          : std_logic;
   
begin
   
   
   
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
   -- detection de l'horloge par mesure de sa periode
   --------------------------------------------------  
   U2 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            meas_fsm <= idle; 
            signal_in_last <= SIGNAL_IN;  
            meas_count <= (others => '0');
            DONE <= '0';
         else 
            
            signal_in_last <= SIGNAL_IN;            
            
            case meas_fsm is 
               
               when idle => 
                  DONE <= '0';
                  if SIGNAL_IN = '1' and signal_in_last = '0' and ENABLE = '1' then
                     meas_fsm <= meas_high_st;
                     meas_count <= (others => '0');
                  end if;
               
               when meas_high_st => 
                  meas_count <= meas_count + 1;                   
                  if SIGNAL_IN = '0' and signal_in_last = '1' then
                     meas_fsm <= idle; 
                     HIGH_LENGTH <= std_logic_vector(meas_count);
                     DONE <= '1';
               end if;                
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   
end RTL;
