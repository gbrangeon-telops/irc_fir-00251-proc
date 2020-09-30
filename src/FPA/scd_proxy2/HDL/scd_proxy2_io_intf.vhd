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
      
      CLK           : in std_logic;
      ARESET        : in std_logic;     
      
      -- hw_driver side
      PROXY_PWR     : in std_logic;
      PROXY_TRIG    : in std_logic;
      PROXY_POWERED     : out std_logic;
      DET_FPA_ON    : out std_logic;
      PROXY_TX      : in std_logic;
      PROXY_RX      : out std_logic;
      PROXY_INT_FBK : out std_logic;
      
      -- spares
      DET_SPARE_N0  : in std_logic;            
      DET_SPARE_P0  : in std_logic;
      DET_SPARE_N1  : in std_logic;
      DET_SPARE_P1  : in std_logic;
      DET_SPARE_N2  : in std_logic;
      DET_SPARE_P2  : in std_logic;
      
      -- Clink TFG
      SER_TFG_N     : in std_logic;
      SER_TFG_P     : in std_logic;     
      
      -- Clink TC
      SER_TC_N      : out std_logic;
      SER_TC_P      : out std_logic;
      
      -- int fdbkin
      INT_FBK_N     : in std_logic;
      INT_FBK_P     : in std_logic; 
      
      -- Clink CC
      DET_CC_N1     : out std_logic;
      DET_CC_P1     : out std_logic;      
      DET_CC_N2     : out std_logic;
      DET_CC_P2     : out std_logic;
      DET_CC_N3     : out std_logic;
      DET_CC_P3     : out std_logic;
      DET_CC_N4     : out std_logic;
      DET_CC_P4     : out std_logic;
      
      -- Fsync
      FSYNC_N       : out std_logic;
      FSYNC_P       : out std_logic    
      
      );
end scd_proxy2_io_intf;

architecture scd_proxy2_io_intf of scd_proxy2_io_intf is
   
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
   type scd_proxy2_io_intf_fsm_type is (idle, init_st, proxy_pwred_st);
   
   signal proxy_trig_fsm     : proxy_trig_fsm_type;
   signal scd_proxy2_io_intf_fsm    : scd_proxy2_io_intf_fsm_type;
   signal sreset             : std_logic;
   signal int_fbk_i          : std_logic;
   signal proxy_trig_i       : std_logic;
   signal output_disabled          : std_logic;
   signal proxy_trig_o       : std_logic;
   signal proxy_int_feedbk_o : std_logic;
   signal cnt                : unsigned(15 downto 0);
   signal timer_cnt          : unsigned(31 downto 0);
   signal proxy_powered_o        : std_logic;
   
begin
   
   
   PROXY_POWERED  <= proxy_powered_o;
   
   -- Sync reset 
   U1 : sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset); 
   
   -- sortie du trig vers proxy
   proxy_trig_i <= PROXY_TRIG;
   U2 : OBUFTDS
   port map(
      I  => proxy_trig_o,
      T  => output_disabled,
      O  => FSYNC_P,
      OB => FSYNC_N
      );
   
   -- sortie lien TX vers proxy
   U3 : OBUFTDS
   port map(
      I  => PROXY_TX,
      T  => output_disabled,
      O  => SER_TC_P,
      OB => SER_TC_N
      );
   
   -- entrée lien RX vers hw_driver
   U4 : IBUFDS
   port map(
      O  => PROXY_RX,
      I  => SER_TFG_P,
      IB => SER_TFG_N
      );
   
   -- int fdbkin    
   PROXY_INT_FBK <= proxy_int_feedbk_o;
   U5 : IBUFDS
   port map(
      O  => int_fbk_i,
      I  => INT_FBK_P,
      IB => INT_FBK_N
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
   
   -- gestion de l'allumage du proxy (process indépendant)   
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
   
   -- generation du proxy trig avec durée specifiée   
   U11: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            proxy_trig_o <= '0';
            cnt <=  (others => '0');
            proxy_trig_fsm <= idle;
         else
            
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
            proxy_int_feedbk_o <= '0';
            scd_proxy2_io_intf_fsm <=  init_st;
         else
            
            
            case scd_proxy2_io_intf_fsm is 
               
               -- init_st
               when init_st =>
                  proxy_powered_o <= '0';
                  output_disabled <= '1';
                  proxy_int_feedbk_o <= '0';
                  timer_cnt <= (others => '0');
                  scd_proxy2_io_intf_fsm <= idle;
                  
               -- attente du signal d'allumage du proxy
               when idle =>
                  if PROXY_PWR = '1' then
                     timer_cnt <=  timer_cnt + 1;
                     output_disabled <= '0';
                  else
                     timer_cnt <= (others => '0');
                  end if;                  
                  if timer_cnt = POWER_WAIT_FACTOR then   -- delai d'au moins 1 sec pour que le proxy soit prêt à recevoir les commandes
                     scd_proxy2_io_intf_fsm <=  proxy_pwred_st;
                  end if;                  
                  -- pragma translate_off
                  if PROXY_PWR = '1' then
                     scd_proxy2_io_intf_fsm <=  proxy_pwred_st;
                  end if;
                  -- pragma translate_on
                  
               -- proxy est pret à recevoir des contrôles 
               when proxy_pwred_st =>                    
                  output_disabled <= '0';
                  proxy_powered_o <= '1';  -- pour le scd_proxy2, le signal de proxy powered est envoyé  SCD_PROXY2_POWER_WAIT usec après l'allumage du proxy
                  proxy_int_feedbk_o <= int_fbk_i;
                  if PROXY_PWR = '0' then
                     scd_proxy2_io_intf_fsm <= init_st;
                  end if;   
               
               when others =>
               
            end case;             
            
         end if;  
      end if;
   end process;  
   
end scd_proxy2_io_intf;
