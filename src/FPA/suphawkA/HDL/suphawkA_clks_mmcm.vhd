------------------------------------------------------------------
--!   @file : suphawkA_clks_mmcm
--!   @brief
--!   @details
--!
--!   $Rev: 22765 $
--!   $Author: enofodjie $
--!   $Date: 2019-01-22 15:40:40 -0500 (mar., 22 janv. 2019) $
--!   $Id: suphawkA_clks_mmcm.vhd 22765 2019-01-22 20:40:40Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/FPA/suphawkA/HDL/suphawkA_clks_mmcm.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.FPA_Define.all; 
use work.fpa_common_pkg.all;
use work.Tel2000.all;

entity suphawkA_clks_mmcm is 
   
   port(
      ARESET           : in std_logic;
      CLK_100M_IN      : in std_logic;
      
      FPA_INT_CFG      : in fpa_intf_cfg_type;
      
      MCLK_SOURCE      : out std_logic;
      ADC_CLK_SOURCE   : out std_logic;
      MMCM_LOCKED      : out std_logic;
      
      CFG_IN_PROGRESS  : out std_logic      
      );
end suphawkA_clks_mmcm;

architecture rtl of suphawkA_clks_mmcm is 
   
   constant C_MMCM_RST_DURATION_mS     : real      := 200.0;      -- duree du reset du mmcm en millisec
   constant C_CLK_IN_RATE_KHZ          : real      := 100_000.0;  -- frequence de l'horloge d'entrée du présent module   
   constant C_MMCM_RST_DURATION_FACTOR : natural   := integer(C_MMCM_RST_DURATION_mS * C_CLK_IN_RATE_KHZ)    -- duree du reset en coups d'horloge CLK_IN
   -- pragma translate_off
   / integer(C_CLK_IN_RATE_KHZ)
   -- pragma translate_on
   ;   
   
   component SYNC_RESET is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
   
   component suphawkA_10_0_MHz_mmcm
      
      port
         (
         -- Status and control signals         
         reset             : in     std_logic;  
         locked            : out    std_logic;  
         clk_in            : in     std_logic;
         
         -- Dynamic phase shift ports           
         psclk             : in     std_logic;  
         psen              : in     std_logic;  
         psincdec          : in     std_logic;  
         psdone            : out    std_logic;
         
         -- outputs                            
         mclk_source       : out    std_logic;         
         adc_clk_source    : out    std_logic      
         );
      
   end component;
   
   type cfg_sm_type is(idle, rst_mmcm_st1, rst_mmcm_st2, wait_mmcm_rdy_st, wait_psdone_st, check_phase_st, inc_phase_st, wait_locked_st, wait_psbusy_st, update_cfg_st);   
   
   signal cfg_sm              : cfg_sm_type;
   signal mmcm_locked_i       : std_logic;
   signal sreset              : std_logic;
   signal mmcm_rdy_i          : std_logic;
   signal new_cfg_pending     : std_logic;
   signal present_adc_clk_phase: std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE'LENGTH-1 downto 0);
   signal phase_cnt_i         : unsigned(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE'LENGTH-1 downto 0);
   signal pause_cnt           : unsigned(25 downto 0);
   signal cfg_in_progress_i   : std_logic;
   signal psen_i              : std_logic;
   signal psdone_i            : std_logic;
   signal psincdec_i          : std_logic;
   signal mmcm_rst_i          : std_logic;
   
begin
   
   MMCM_LOCKED <= mmcm_locked_i;
   CFG_IN_PROGRESS <= cfg_in_progress_i;
   
   U0 : sync_reset 
   port map(
      ARESET => ARESET, 
      SRESET => sreset, 
      CLK    => CLK_100M_IN
      );
   
   -----------------------------------------------------------------
   -- Avec configuration dynamique
   -----------------------------------------------------------------   
   
   U1: process(CLK_100M_IN)
   begin          
      if rising_edge(CLK_100M_IN) then         
         if sreset = '1' then
            cfg_sm <= idle;
            new_cfg_pending <= '0';
            cfg_in_progress_i <= '0';
            mmcm_locked_i <= '0';
            present_adc_clk_phase <= (others => '0');
            mmcm_rst_i <= '1';
            
         else                      
            
            mmcm_locked_i <= not cfg_in_progress_i and mmcm_rdy_i; 
            
            if std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE) /= present_adc_clk_phase then 
               new_cfg_pending <= '1';
            else
               new_cfg_pending <= '0';
            end if;               
            
            -- fsm de prog de phase
            case cfg_sm is
               
               when idle =>
                  psen_i  <= '0';
                  psincdec_i <= '0';        
                  pause_cnt <= (others => '0');
                  phase_cnt_i <= (others => '0');
                  cfg_in_progress_i <= '0';
                  mmcm_rst_i <= '0';
                  if new_cfg_pending = '1' and mmcm_rdy_i = '1' then
                     cfg_sm <= rst_mmcm_st1;
                     cfg_in_progress_i <= '1';
                  end if;
               
               when rst_mmcm_st1 =>             -- reset du mmcm
                  mmcm_rst_i <= '1';
                  if mmcm_rdy_i = '0' then       
                     cfg_sm <= rst_mmcm_st2;
                  end if;
               
               when rst_mmcm_st2 =>             -- reset du mmcm
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt > C_MMCM_RST_DURATION_FACTOR then
                     cfg_sm <= wait_mmcm_rdy_st;
                  end if;
               
               when wait_mmcm_rdy_st =>        -- attente du rdy/locked du mmcm, preuve qu'il a complété son rst et est à l'écoute
                  mmcm_rst_i <= '0';
                  if mmcm_rdy_i = '1' then 
                     cfg_sm <= check_phase_st;
                  end if;               
               
               when check_phase_st =>         -- on cherche à savoir si on incremente la phase ou non (FPA_INT_CFG.ADC_CLK_SOURCE_PHASE est toujours positif)
                  if phase_cnt_i >= FPA_INT_CFG.ADC_CLK_SOURCE_PHASE then 
                     cfg_sm <= wait_locked_st; 
                  else
                     cfg_sm <= inc_phase_st; 
                  end if;                   
               
               when inc_phase_st =>          --  incrementation d'une unité de la phase 
                  psen_i  <= '1';
                  psincdec_i <= '1';
                  phase_cnt_i <= phase_cnt_i + 1;
                  cfg_sm <= wait_psbusy_st; 
               
               when wait_psbusy_st =>       --  attendre que le mmcm fasse le dephasage unitaire
                  psen_i  <= '0';
                  psincdec_i <= '0';
                  if psdone_i = '0' then 
                     cfg_sm <= wait_psdone_st;
                  end if;
                                         
               when wait_psdone_st =>      -- fin du dephasage unitaire fait par le mmcm. On retourne voir si le dephasage total demandé est atteint ou non
                  if psdone_i = '1' then 
                     cfg_sm <= check_phase_st;
                  end if;
               
               when wait_locked_st =>      -- attente du locked global du mmcm
                  pause_cnt <= (others => '0');
                  if mmcm_rdy_i = '1' then
                     cfg_sm <= update_cfg_st;
                  end if;               
               
               when update_cfg_st =>       -- mise à jour de la cfg
                  present_adc_clk_phase <= std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE);
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt(3) = '1' then 
                     cfg_sm <= idle; 
                  end if;
               
               when others =>
               
            end case;               
            
         end if;  
      end if;
   end process;       
   
   U2 :  suphawkA_10_0_MHz_mmcm
   port map (   
      reset             => mmcm_rst_i,
      locked            => mmcm_rdy_i,
      clk_in            => CLK_100M_IN,
      
      -- Dynamic phase shift ports
      
      psclk             =>   CLK_100M_IN,
      psen              =>   psen_i,
      psincdec          =>   psincdec_i,
      psdone            =>   psdone_i,
      
      -- outputs      
      mclk_source       => MCLK_SOURCE,      
      adc_clk_source    => ADC_CLK_SOURCE         
      );     
   
end rtl;
