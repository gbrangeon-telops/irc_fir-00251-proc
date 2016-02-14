------------------------------------------------------------------
--!   @file : isc0209A_window_reg
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
use IEEE.numeric_std.all; 
use work.fpa_common_pkg.all;
use work.FPA_define.all;

entity isc0209A_window_reg is
   port(
      ARESET        : in std_logic;
      CLK           : in std_logic;
      FPA_INTF_CFG  : in fpa_intf_cfg_type;
      WIND_RQST     : out std_logic;
      WIND_REG      : out std_logic_vector(31 downto 0);
      WIND_DONE     : in std_logic
      );
end isc0209A_window_reg;

architecture rtl of isc0209A_window_reg is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   type   window_cfg_fsm_type is (idle, check_done_st, rqst_st, wait_end_st, update_reg_st);
   signal window_cfg_fsm      : window_cfg_fsm_type;  
   signal wind_rqst_i         : std_logic;
   signal wind_reg_i          : std_logic_vector(31 downto 0);
   signal new_wind_reg        : std_logic_vector(31 downto 0);
   signal sreset              : std_logic;
   signal actual_wind_reg     : std_logic_vector(31 downto 0);
   
begin
   
   WIND_RQST <= wind_rqst_i;
   WIND_REG <= wind_reg_i;
   
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U1 : sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset); 
   
   
   --------------------------------------------------
   --  bistream builder
   --------------------------------------------------
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then
         new_wind_reg(31) <= '1';	-- Start bit, always '1'
         new_wind_reg(30) <= '1';	-- Window bit, always '1'
         new_wind_reg(29 downto 22) <= std_logic_vector(FPA_INTF_CFG.XSTART(8 downto 1));                -- Value / 2 (WAX)
         new_wind_reg(21 downto 15) <= std_logic_vector(FPA_INTF_CFG.YSTART(7 downto 1));	               -- Value / 2 (WAY)
         new_wind_reg(14 downto 7)  <= std_logic_vector(FPA_INTF_CFG.XSIZE(8 downto 1));	               -- Value / 2 (WSX)
         new_wind_reg(6 downto 0)   <= std_logic_vector(resize((FPA_INTF_CFG.YSIZE(8 downto 1)-1),7));    -- (Value / 2) - 1 (WSY)
      end if;
   end process;
   
   
   ------------------------------------------------
   -- Voir s'il faut programmer le détecteur
   ------------------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            wind_rqst_i <= '0';
            window_cfg_fsm <= idle;
            actual_wind_reg(31) <= '0';   -- le bit 31 seul forcé à '0'  suffit pour eviter des bugs en power management. En fait cela force la reprogrammation après un reset
            
         else    
            
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings	
            case window_cfg_fsm is            
               
               when idle =>                -- en attente que le programmateur soit à l'écoute
                  wind_rqst_i <= '0';
                  if actual_wind_reg /= new_wind_reg then
                     window_cfg_fsm <= check_done_st; 
                  end if;
               
               when check_done_st =>
                  if WIND_DONE = '1'  then
                     window_cfg_fsm <= rqst_st;
                  else
                     window_cfg_fsm <= idle;
                  end if;
               
               when rqst_st =>                                     
                  wind_rqst_i <= '1';
                  wind_reg_i <= new_wind_reg;
                  if WIND_DONE = '0'  then 
                     window_cfg_fsm <= wait_end_st;
                  end if;                  
               
               when wait_end_st =>
                  wind_rqst_i <= '0';
                  if WIND_DONE = '1' then
                     window_cfg_fsm <= update_reg_st;
                  end if;  
               
               when update_reg_st =>
                  actual_wind_reg <= wind_reg_i;
                  window_cfg_fsm <= idle;                  
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
    
   
end rtl;
