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
use work.blackbird1280D_testbench_pkg.all;
use work.trig_define.all;
entity scd_proxy_sim is
   generic (
   NO_FIRST_READOUT : boolean := true
   );
   port(
      
      ARESET       : in std_logic;
      CLK          : in std_logic;  
      
      INT_FBK_N    : out std_logic;
      INT_FBK_P    : out std_logic;
      
      FPA_INTF_CFG : fpa_intf_cfg_type;  
      TRIG_CONFIG  :  in TRIG_CFG_TYPE;
      
      ACQ_TRIG     : out std_logic;
      
      FSYNC        : in std_logic;
      RST_CLINK_N  : in std_logic;
      CH1_DATA     : out std_logic_vector(27 downto 0);
      CH2_DATA     : out std_logic_vector(27 downto 0); 
      CH3_DATA     : out std_logic_vector(27 downto 0) 
      
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
      FPA_TRIG     : in std_logic;
      
      CH1_DATA     : out std_logic_vector(27 downto 0); --! sortie des données deserialisés sur CH1    
      CH2_DATA     : out std_logic_vector(27 downto 0); --! sortie des données deserialisés sur CH2 
      CH3_DATA     : out std_logic_vector(27 downto 0); --! sortie des données deserialisés sur CH3 
      
      DIAG_HDER    : out std_logic; --! 'à 1 pour signifier la sortie du header
      DIAG_LINE    : out std_logic; --! 'à 1 pour signifier la sortie des données d'une ligne
      DIAG_FRAME   : out std_logic
      
      );
end component;


   signal areset_i            : std_logic; 
   signal acq_trig_i          : std_logic;
   signal cnt                 : integer := 0;
   signal cnt_i               : unsigned(31 downto 0);
   type trig_sm_type   is (idle, trig_gen);
   signal trig_sm          : trig_sm_type := idle;
   signal trig_period         : integer := integer((1.0/real(1000))*real(FPA_INTF_CLK_RATE_MHZ)*1000000.0);
   signal trig_duration       : integer := 3;
   
   type delay_sm_type   is (idle, wait_intg_start, wait_intg_duration, gen_pulse);
   signal delay_sm          : delay_sm_type := idle;
   signal fsync_cnt         : unsigned(31 downto 0);
   signal fpa_int_i         : std_logic;
   signal fsync_last        : std_logic;


   
begin  
  
   
   sgen_pelican_or_hercule : if (IsBlackbird1280D = '0') generate
   begin  
      INT_FBK_N <= not fpa_int_i;
      INT_FBK_P <= fpa_int_i;
   end generate;
   
   sgen_bb1280 : if (IsBlackbird1280D = '1') generate
   begin 
      INT_FBK_N <= '1';
      INT_FBK_P <= '0';
   end generate;   
   
   
  areset_i <= not RST_CLINK_N or ARESET;
  ACQ_TRIG <= acq_trig_i;
  -- Configuration du générateur de trig externe de la stimulation.
  trig_period        <=  to_integer(TRIG_CONFIG.period);
  trig_duration      <= 3; 
      
      
   U1: scd_diag_data_gen
   port map( 
      ARESET => areset_i,
      CLK => CLK,
      FPA_INTF_CFG => FPA_INTF_CFG, 
      DIAG_MODE_EN => '1',    
      FPA_INT => fpa_int_i,
      FPA_TRIG => FSYNC,
      CH1_DATA => CH1_DATA,
      CH2_DATA => CH2_DATA,   
      CH3_DATA => CH3_DATA,
      DIAG_HDER => open,
      DIAG_LINE => open,   
      DIAG_FRAME => open  
      );   
 
   
       -- Trigger generator
   U2: process(CLK)
   begin
      if rising_edge(CLK) then
         
         if areset_i = '1' then
            cnt <= 0;
            trig_sm <= trig_gen; 
            acq_trig_i <= '0';
         else

            case trig_sm  is 
               
               when idle  => 
               
                  if cnt < (trig_period - trig_duration) then 
                     cnt <= cnt + 1;
                     trig_sm <= idle;
                  else
                     cnt <= 0; 
                     trig_sm <= trig_gen;
                  end if;
   
               when trig_gen  =>
                  if cnt < 3 then 
                    acq_trig_i <= '1';
                    cnt <= cnt + 1;
                    trig_sm <= trig_gen;
                  else
                    cnt <= 0;
                    acq_trig_i <= '0';
                    trig_sm <= idle;
                  end if;
      
               when others =>
            
            end case;  
         end if;
         
      end if;
      
   end process;
    ----------------------------------------------------------
   -- Simulation du délai entre la montée de FSYNC et le début de l'intégration (délai T4)
   ---------------------------------------------------------- 
   U3: process(CLK)
   begin
      if rising_edge(CLK) then
         
         if areset_i = '1' then 
            fsync_last <= '0'; 
            delay_sm <= idle;
            cnt_i <= (others => '0');
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
                        delay_sm <= wait_intg_start;
                     else   
                        if fsync_cnt > 1 then
                           delay_sm <= wait_intg_start;
                        else   
                           delay_sm <= idle;
                        end if;   
                     end if;
                     
                  end if;

               when wait_intg_start  => 
               
                  cnt_i <= cnt_i + 1;
               
                  if cnt_i > FPA_INTF_CFG.scd_misc.scd_fsync_re_to_intg_start_dly then 
                     delay_sm <= gen_pulse; 
                     fpa_int_i <= '1'; 
                     cnt_i <= (others => '0');
                  end if; 

               when gen_pulse  =>
               
                  cnt_i <= cnt_i + 1;
               
                  if cnt_i > 3 then 
                     delay_sm <= wait_intg_duration; 
                     cnt_i <= (others => '0');
                  end if;
               
              when wait_intg_duration  => 
               
                  cnt_i <= cnt_i + 1;
               
                  if cnt_i > FPA_INTF_CFG.scd_int.scd_int_time - 3 then 
                     delay_sm <= idle; 
                     fpa_int_i <= '0'; 
                     cnt_i <= (others => '0');
                  end if; 
               when others =>
            
            end case;
            
         end if; 
               
      end if;
   end process;

end rtl;
