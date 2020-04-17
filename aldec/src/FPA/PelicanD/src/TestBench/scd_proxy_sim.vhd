-------------------------------------------------------------------------------
--
-- Title       : scd_diag_data_gen
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\SCD_Hercules\src\scd_diag_data_gen.vhd
-- Generated   : Mon Jan 10 13:16:11 2011
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
use IEEE.numeric_std.all;
use work.FPA_define.all;
use work.Proxy_define.all;
use work.fpa_common_pkg.all;
use work.pelicand_testbench_pkg.all;

entity scd_proxy_sim is
   generic (
   FIG1_FIG2_T4_SEC : real := 0.000001;
   NO_FIRST_READOUT : boolean := true
   );
   port(
      
      ARESET       : in std_logic;
      CLK          : in std_logic;
      FPA_INTF_CFG : fpa_intf_cfg_type; 
      FSYNC        : in std_logic;
      FPA_INT      : out std_logic;
      
      CH1_DATA     : out std_logic_vector(27 downto 0); --! sortie des données deserialisés sur CH1    
      CH2_DATA     : out std_logic_vector(27 downto 0) --! sortie des données deserialisés sur CH2 
      
      );
end scd_proxy_sim;


architecture rtl of scd_proxy_sim is


component scd_diag_data_gen
   port(
      ARESET       : in std_logic;
      CLK          : in std_logic;
      
      FPA_INTF_CFG : fpa_intf_cfg_type;
      DIAG_MODE_EN : in std_logic;
      
      FPA_INT      : in std_logic;
      
      CH1_DATA     : out std_logic_vector(27 downto 0); --! sortie des données deserialisés sur CH1    
      CH2_DATA     : out std_logic_vector(27 downto 0); --! sortie des données deserialisés sur CH2 
      
      DIAG_HDER    : out std_logic; --! 'à 1 pour signmifier la sortie du header
      DIAG_LINE    : out std_logic; --! 'à 1 pour signmifier la sortie des données d'une ligne
      DIAG_FRAME   : out std_logic
      
      );
end component;


   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   type delay_sm_type   is (idle, wait_t4, wait_t2, gen_pulse);
   signal delay_sm          : delay_sm_type := idle;
   signal cnt               : unsigned(31 downto 0); 
   signal fsync_cnt         : unsigned(31 downto 0);
   signal fpa_int_i         : std_logic;
   signal fsync_last        : std_logic;
   signal sreset            : std_logic;

begin
   FPA_INT <= fpa_int_i;
   
   --------------------------------------------------
   -- data gen 
   --------------------------------------------------   
   U2: scd_diag_data_gen
   port map( 
      ARESET => ARESET,
      CLK => CLK,
      FPA_INTF_CFG => FPA_INTF_CFG, 
      DIAG_MODE_EN => '1',    
      FPA_INT => fpa_int_i,  
      CH1_DATA => CH1_DATA,
      CH2_DATA => CH2_DATA,
      DIAG_HDER => open,
      DIAG_LINE => open,   
      DIAG_FRAME => open  
      );   
 
   
   ----------------------------------------------------------
   -- Simulation du délai entre la montée de FSYNC et le début de l'intégration (délai T4)
   ---------------------------------------------------------- 
   U3: process(CLK)
   begin
      if rising_edge(CLK) then
         
         if ARESET = '1' then 
            fsync_last <= '0'; 
            delay_sm <= idle;
            cnt <= (others => '0');
            fsync_cnt <= (others => '0');
            fpa_int_i <= '0';
         else 
            
            fsync_last <= FSYNC;
            
            case delay_sm  is
            
               when idle => 
                                                            
                  fpa_int_i <= '0';
               
                  if FSYNC = '1' and fsync_last = '0' then 
                     fsync_cnt <= fsync_cnt + 1;
                     
                     if NO_FIRST_READOUT = false then
                        delay_sm <= wait_t4;
                     else   
                        if fsync_cnt > 1 then
                           delay_sm <= wait_t4;
                        else   
                           delay_sm <= idle;
                        end if;   
                     end if;
                     
                  end if;

               when wait_t4  => 
               
                  cnt <= cnt + 1;
               
                  if cnt > sec_to_clks(FIG1_FIG2_T4_SEC) then 
                     delay_sm <= gen_pulse; 
                     fpa_int_i <= '1'; 
                     cnt <= (others => '0');
                  end if; 

               when gen_pulse  =>
               
                  cnt <= cnt + 1;
               
                  if cnt > 3 then 
                     delay_sm <= wait_t2; 
                     cnt <= (others => '0');
                  end if;
               
              when wait_t2  => 
               
                  cnt <= cnt + 1;
               
                  if cnt > FPA_INTF_CFG.scd_int.scd_int_time - 3 then 
                     delay_sm <= idle; 
                     fpa_int_i <= '0'; 
                     cnt <= (others => '0');
                  end if; 
               when others =>
            
            end case;
            
         end if; 
               
      end if;
   end process; 
   
   
end rtl;
