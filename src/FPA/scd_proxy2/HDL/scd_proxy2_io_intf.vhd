------------------------------------------------------------------
--!   @file : scd_proxy2_io_intf
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.FPA_define.all;
use work.Proxy_define.all;

-- synopsys translate_off 
library KINTEX7;
library IEEE;
use IEEE.vital_timing.all;
-- synopsys translate_on 

entity scd_proxy2_io_intf is
   port(
      
      CLK             : in std_logic;
      ARESET          : in std_logic;     
      
      -- hw_driver side
      PROXY_PWR       : in std_logic;
      PROXY_TRIG      : in std_logic;
      PROXY_INTEGRATE : in std_logic;
      PROXY_POWERED   : out std_logic;
      DET_FPA_ON      : out std_logic;
      PROXY_TX        : in std_logic;
      PROXY_RX        : out std_logic;
      
      -- spares
      DET_SPARE_N0    : in std_logic;     -- non utilis�       
      DET_SPARE_P0    : in std_logic;     -- non utilis� 
      
      DET_SPARE_N1    : out std_logic;   -- c'est la sortie S_RESET_N
      DET_SPARE_P1    : out std_logic;   -- c'est la sortie S_RESET_P
      DET_SPARE_N2    : out std_logic;   -- c'est la sortie S_INTEGRATE_N
      DET_SPARE_P2    : out std_logic;   -- c'est la sortie S_INTEGRATE_P
      
      -- Clink TFG
      SER_TFG_N       : in std_logic;
      SER_TFG_P       : in std_logic;     
      
      -- Clink TC
      SER_TC_N        : out std_logic;
      SER_TC_P        : out std_logic;
      
      -- Clink CC
      DET_CC_N1       : out std_logic;    -- non utilis� 
      DET_CC_P1       : out std_logic;    -- non utilis�   
      DET_CC_N2       : out std_logic;    -- non utilis� 
      DET_CC_P2       : out std_logic;    -- non utilis� 
      DET_CC_N3       : out std_logic;    -- non utilis� 
      DET_CC_P3       : out std_logic;    -- non utilis� 
      DET_CC_N4       : out std_logic;    -- non utilis� 
      DET_CC_P4       : out std_logic;    -- non utilis�
      
      -- Fsync
      FSYNC_N         : out std_logic;
      FSYNC_P         : out std_logic    
      
      );
end scd_proxy2_io_intf;

architecture rtl of scd_proxy2_io_intf is

constant PROXY_RST_END_FACTOR    : integer     := POWER_WAIT_FACTOR/4;
constant C_PROXY_RST_SIGNAL      : std_logic   := '0';

   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   component OBUFTDS is
      -- synopsys translate_off
      generic(
         CAPACITANCE : string     := "DONT_CARE";
         IOSTANDARD  : string     := "DEFAULT";
         SLEW        : string     := "SLOW"
         );
      -- synopsys translate_on      
      port(
         O  : out std_ulogic;
         OB : out std_ulogic;         
         I  : in std_ulogic;
         T  : in std_ulogic
         );
   end component;
   
   component IBUFDS is
      -- synopsys translate_off
      generic(
         CAPACITANCE      : string  := "DONT_CARE";
         DIFF_TERM        : boolean :=  FALSE;
         DQS_BIAS         : string  :=  "FALSE";
         IBUF_DELAY_VALUE : string  := "0";
         IBUF_LOW_PWR     : boolean :=  TRUE;
         IFD_DELAY_VALUE  : string  := "AUTO";
         IOSTANDARD       : string  := "DEFAULT"
         );
      -- synopsys translate_on      
      port(
         O : out std_ulogic;         
         I  : in std_ulogic;
         IB : in std_ulogic
         );      
   end component;
   
   type proxy_trig_fsm_type is (idle, trig_on_st);
   type proxy2_io_intf_fsm_type is (idle, init_st, proxy_pwred_st);
   
   signal proxy_trig_fsm            : proxy_trig_fsm_type;
   signal proxy2_io_intf_fsm        : proxy2_io_intf_fsm_type;
   signal sreset                    : std_logic;
   signal proxy_trig_i              : std_logic;
   signal proxy_integrate_i         : std_logic;
   signal output_disabled           : std_logic;
   signal proxy_trig_o              : std_logic;
   signal proxy_integrate_o         : std_logic;
   signal cnt                       : unsigned(15 downto 0);
   signal timer_cnt                 : unsigned(31 downto 0);
   signal proxy_powered_o           : std_logic;
   signal proxy_reset_i             : std_logic;

   
begin
   
   
   PROXY_POWERED  <= proxy_powered_o;
   
   -- Sync reset 
   U1 : sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset); 
   
   -- sortie du trig vers proxy
   proxy_trig_i <= PROXY_TRIG; 
   proxy_integrate_i <= PROXY_INTEGRATE; 
   
   U2 : OBUFTDS
   port map(
      I  => proxy_trig_o,
      T  => output_disabled,
      O  => FSYNC_P,
      OB => FSYNC_N
      );
   
   -- sortie lien TX vers proxy
   U3A : OBUFTDS
   port map(
      I  => PROXY_TX,
      T  => output_disabled,
      O  => SER_TC_P,
      OB => SER_TC_N
      );
   
   -- sortie reset du proxy
   U3B : OBUFTDS
   port map(
      I  => proxy_reset_i,
      T  => output_disabled,
      O  => DET_SPARE_P1,
      OB => DET_SPARE_N1
      );
   
   -- sortie signal integration vers proxy
   U3C : OBUFTDS
   port map(
      I  => proxy_integrate_o,              
      T  => output_disabled,
      O  => DET_SPARE_P2,
      OB => DET_SPARE_N2
      );   
   
   -- entr�e lien RX vers hw_driver
   U4 : IBUFDS
   port map(
      O  => PROXY_RX,
      I  => SER_TFG_P,
      IB => SER_TFG_N
      );
   
   -- sortie des CLINK CC
   U6 : OBUFTDS
   port map(
      I  => 'Z',
      T  => '1',
      O  => DET_CC_P1,
      OB => DET_CC_N1
      );
   U7 : OBUFTDS
   port map(
      I  => 'Z',
      T  => '1',
      O  => DET_CC_P2,
      OB => DET_CC_N2
      );
   U8 : OBUFTDS
   port map(
      I  => 'Z',
      T  => '1',
      O  => DET_CC_P3,
      OB => DET_CC_N3
      );
   U9 : OBUFTDS
   port map(
      I  => 'Z',
      T  => '1',
      O  => DET_CC_P4,
      OB => DET_CC_N4
      );
   
   -- gestion de l'allumage du proxy (process ind�pendant)   
   U10: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            DET_FPA_ON <= '0';
         else
            DET_FPA_ON <= PROXY_PWR;   
         end if;
      end if;
   end process;               
   
   -- generation du proxy trig avec dur�e specifi�e   
   U11: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            proxy_trig_o <= '0';
            cnt <=  (others => '0');
            proxy_trig_fsm <= idle;
         else
            
            proxy_integrate_o <= proxy_integrate_i;
            case proxy_trig_fsm is
               
               when idle =>
                  cnt <=  (others => '0');
                  proxy_trig_o <= '0';
                  if proxy_trig_i = '1' then 
                     proxy_trig_o <= '1';
                     proxy_trig_fsm <= trig_on_st;
                  end if;  
               
               when trig_on_st => 
                  cnt <= cnt + 1;
                  if cnt = FSYNC_HIGH_TIME_FACTOR then
                     proxy_trig_fsm <= idle; 
                  end if;
               
               when others =>             
               
            end case;
         end if;
      end if;
   end process;    
   
   -- gestion du signal RDY
   U12: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            timer_cnt <= (others => '0');
            proxy_powered_o <= '0';
            output_disabled <= '1';
            proxy2_io_intf_fsm <=  init_st;
            proxy_reset_i <= C_PROXY_RST_SIGNAL;
            
         else
            
            
            case proxy2_io_intf_fsm is 
               
               -- init_st
               when init_st =>
                  proxy_powered_o <= '0';
                  output_disabled <= '1';
                  timer_cnt <= (others => '0');
                  proxy2_io_intf_fsm <= idle;
                  proxy_reset_i <= C_PROXY_RST_SIGNAL;
                  
                  
               -- attente du signal d'allumage du proxy
               when idle =>
                  if PROXY_PWR = '1' then
                     timer_cnt <=  timer_cnt + 1;
                     output_disabled <= '0';
                  else
                     timer_cnt <= (others => '0');
                  end if;
                  
                  if timer_cnt = PROXY_RST_END_FACTOR then   -- fin reset du proxy
                     proxy_reset_i <= not C_PROXY_RST_SIGNAL;
                  end if;                  
                  
                  if timer_cnt = POWER_WAIT_FACTOR then   -- delai d'au moins 1 sec pour que le proxy soit pr�t � recevoir les commandes
                     proxy2_io_intf_fsm <=  proxy_pwred_st;
                  end if; 
                  
                  -- pragma translate_off
                  if PROXY_PWR = '1' then
                     proxy2_io_intf_fsm <=  proxy_pwred_st;
                      proxy_reset_i <= not C_PROXY_RST_SIGNAL;
                  end if;
                  -- pragma translate_on
                  
               -- proxy est pret � recevoir des contr�les 
               when proxy_pwred_st =>                    
                  output_disabled <= '0';
                  proxy_powered_o <= '1';  -- pour le scd_proxy2, le signal de proxy powered est envoy�  SCD_PROXY2_POWER_WAIT usec apr�s l'allumage du proxy
                  if PROXY_PWR = '0' then
                     proxy2_io_intf_fsm <= init_st;
                  end if;   
               
               when others =>
               
            end case;             
            
         end if;  
      end if;
   end process;  
   
end rtl;
