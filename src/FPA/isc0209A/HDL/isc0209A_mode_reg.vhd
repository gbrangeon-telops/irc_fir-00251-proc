------------------------------------------------------------------
--!   @file : isc0209A_mode_reg
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

entity isc0209A_mode_reg is
   port(
      ARESET        : in std_logic;
      CLK           : in std_logic;
      FPA_INTF_CFG  : in fpa_intf_cfg_type;
      MODE_RQST     : out std_logic;
      MODE_REG      : out std_logic_vector(31 downto 0);
      MODE_DONE     : in std_logic
      );
end isc0209A_mode_reg;

architecture rtl of isc0209A_mode_reg is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   type   mode_cfg_fsm_type is (idle, check_done_st, rqst_st, wait_end_st, update_reg_st);
   signal mode_cfg_fsm      : mode_cfg_fsm_type;  
   signal mode_rqst_i         : std_logic;
   signal mode_reg_i          : std_logic_vector(31 downto 0);
   signal new_mode_reg        : std_logic_vector(31 downto 0);
   signal sreset              : std_logic;
   signal present_mode_reg     : std_logic_vector(31 downto 0);
   signal global_reset_i      : std_logic;
   
begin
   
   MODE_RQST <= mode_rqst_i;
   MODE_REG <= mode_reg_i;
   
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
         -- Mode and Configuration parameter Register
         new_mode_reg(31) <= '1';	-- Start bit
         new_mode_reg(30) <= '0';	-- mode bit
         new_mode_reg(29 downto 28) <= FPA_INTF_CFG.GAIN(1 downto 0);                     -- Integration Capacitor (GC)        
         new_mode_reg(27 downto 26) <= "11";                                              -- Default settings for PW[1:0] Power Control  : "11"   Optimal for 5MHz clock          
         new_mode_reg(25 downto 23) <= "000";                                             -- Default settings for I[2:0]  Master Current : "000"  Optimal for 5MHz clock
         new_mode_reg(22 downto 16) <= FPA_INTF_CFG.DETPOL_CODE(6 downto 0);              -- settings for DE[6:0] Detector Bias 
         new_mode_reg(15 downto 8)  <= x"00";                                             -- settings for  TS[7:0] Test functions : x"00"
         new_mode_reg(7 downto 6)   <= FPA_INTF_CFG.REVERT & FPA_INTF_CFG.INVERT;	      -- RO[2:1], XDIR, YDIR
         new_mode_reg(5 downto 2)  <= "0111";	
         -- RO[0]   Line Repeat    : "0" => No
         -- OM[1:0] Output select  : "11" => 4 outputs
         -- RE, Reference Output Enable : "1"
         new_mode_reg(1) <= global_reset_i;                    -- RST, Global Reset pour obliger à reseter le detecteur au demarrage
         
         new_mode_reg(0) <=  FPA_INTF_CFG.SKIMMING_EN;         -- Skimming
      end if;
   end process;
   
   
   ------------------------------------------------
   -- Voir s'il faut programmer le détecteur
   ------------------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            mode_rqst_i <= '0';
            mode_cfg_fsm <= idle;
            present_mode_reg(31) <= '0';   -- le bit 31 seul forcé à '0'  suffit pour eviter des bugs en power management. En fait cela force la reprogrammation après un reset
            global_reset_i <= '1';
         else    
            
            -- la machine a états comporte plusieurs états afin d'ameliorer les timings	
            case mode_cfg_fsm is            
               
               when idle =>                -- en attente que le programmateur soit à l'écoute
                  mode_rqst_i <= '0';
                  if present_mode_reg /= new_mode_reg then
                     mode_cfg_fsm <= check_done_st; 
                  end if;
               
               when check_done_st =>
                  if MODE_DONE = '1'  then
                     mode_cfg_fsm <= rqst_st;
                  else
                     mode_cfg_fsm <= idle;
                  end if;
               
               when rqst_st =>                                     
                  mode_rqst_i <= '1';
                  mode_reg_i <= new_mode_reg;
                  if MODE_DONE = '0'  then 
                     mode_cfg_fsm <= wait_end_st;
                  end if;                  
               
               when wait_end_st =>
                  mode_rqst_i <= '0';
                  if MODE_DONE = '1' then
                     mode_cfg_fsm <= update_reg_st;
                  end if;  
               
               when update_reg_st =>
                  present_mode_reg <= mode_reg_i;
                  global_reset_i <= '0';               -- ainsi une seconde reprogrammation aura lieu mais cette fois avec global reste à '0'
                  mode_cfg_fsm <= idle;                  
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
   
end rtl;
