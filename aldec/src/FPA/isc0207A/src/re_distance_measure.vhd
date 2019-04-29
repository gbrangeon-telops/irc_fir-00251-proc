------------------------------------------------------------------
--!   @file : re_distance_measure
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity re_distance_measure is
   port(
      
      ARESET   : in std_logic;
      CLK      : in std_logic;
      
      ENABLE   : in std_logic;
      
      TIC      : in std_logic; -- c'est à partir du rising_edge de ce signal que part la mesure
      TOC      : in std_logic;  -- c'est à partir du rising_edge de ce signal que s'arrête la mesure
      
      DLY      : out std_logic_vector(31 downto 0);
      DLY_DVAL : out std_logic
      );
   
end re_distance_measure;

architecture rtl of re_distance_measure is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;   
   
   signal meas_count          : unsigned(31 downto 0);
   type meas_fsm_type is (idle, meas_high_st);   
   signal meas_fsm            : meas_fsm_type; 
   signal sreset              : std_logic;
   signal tic_sync            : std_logic;
   signal tic_sync_last       : std_logic;
   signal toc_sync            : std_logic;
   signal toc_sync_last       : std_logic;
   signal toc_re              : std_logic;
   
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
            tic_sync_last <= tic_sync;  
            meas_count <= (others => '0');
            DLY_DVAL <= '0';
            toc_re <= '0';
         else 
            
            tic_sync <= TIC;
            tic_sync_last <= tic_sync;
            
            toc_sync <= TOC;
            toc_sync_last <= toc_sync; 
            
            toc_re <= toc_sync and not toc_sync_last;  -- permet de retarder la falling edge de 1 Clk
            
            case meas_fsm is 
               
               when idle => 
                  DLY_DVAL <= '0';
                  if tic_sync = '1' and tic_sync_last = '0' and ENABLE = '1' then
                     meas_fsm <= meas_high_st;
                     meas_count <= (others => '0');
                  end if;
               
               when meas_high_st => 
                  meas_count <= meas_count + 1;                   
                  if (toc_sync = '1' and toc_sync_last = '0') or toc_re = '1' then
                     meas_fsm <= idle; 
                     DLY <= std_logic_vector(meas_count);
                     DLY_DVAL <= '1';
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   
end rtl;
