------------------------------------------------------------------
--!   @file : scorpiomwA_clks_mmcm
--!   @brief
--!   @details
--!
--!   $Rev: 26854 $
--!   $Author: enofodjie $
--!   $Date: 2021-10-13 11:58:28 -0400 (mer., 13 oct. 2021) $
--!   $Id: scorpiomwA_clks_mmcm.vhd 26854 2021-10-13 15:58:28Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00272-FleG/trunk/src/FPA/scorpiomwA/HDL/scorpiomwA_clks_mmcm.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.FPA_Define.all; 
use work.fpa_common_pkg.all;
use work.Tel2000.all;

entity scorpiomwA_clks_mmcm is 
   
   port(
      ARESET           : in std_logic;
      CLK_100M_IN      : in std_logic;
      
      FPA_INT_CFG      : fpa_intf_cfg_type;
      
      MCLK_SOURCE      : out std_logic;
      ADC_CLK_SOURCE   : out std_logic;
      MMCM_LOCKED      : out std_logic;
      
      CFG_IN_PROGRESS  : out std_logic      
      );
end scorpiomwA_clks_mmcm;

architecture rtl of scorpiomwA_clks_mmcm is 
   
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
   
   component scorpiomwA_18MHz_mmcm       
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
   
   component scorpiomwA_144MHz_to_18MHz_mmcm       
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
   
   component scorpiomwA_27MHz_mmcm       
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
   
   signal cfg_sm                 : cfg_sm_type;
   signal mmcm_locked_i          : std_logic;
   signal sreset                 : std_logic;
   signal mmcm_rdy_i             : std_logic;
   signal new_cfg_pending        : std_logic;
   signal present_adc_clk_phase1 : std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE'LENGTH-1 downto 0);
   signal present_adc_clk_phase2 : std_logic_vector(FPA_INT_CFG.ADC_CLK_PIPE_SEL'LENGTH-1 downto 0);
   signal phase_cnt_i            : unsigned(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE'LENGTH-1 downto 0);
   signal pause_cnt              : unsigned(25 downto 0);
   signal cfg_in_progress_i      : std_logic;
   signal psen_i                 : std_logic;
   signal psdone_i               : std_logic;
   signal psincdec_i             : std_logic;
   signal mmcm_rst_i             : std_logic;
   signal new_cfg_part1          : std_logic;
   signal new_cfg_part2          : std_logic;
   
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
            present_adc_clk_phase1 <= (others => '0'); 
            present_adc_clk_phase2 <= (others => '0');
            mmcm_rst_i <= '1'; 
            new_cfg_part1 <= '0';
            new_cfg_part2 <= '0';
            
            else                      
            
            mmcm_locked_i <= not cfg_in_progress_i; 
            
            if std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE) /= present_adc_clk_phase1 then 
               new_cfg_part1 <= '1';
            else
               new_cfg_part1 <= '0';
            end if; 
            
            if std_logic_vector(FPA_INT_CFG.ADC_CLK_PIPE_SEL) /= present_adc_clk_phase2 then 
               new_cfg_part2 <= '1';
            else
               new_cfg_part2 <= '0';
            end if; 
            
            new_cfg_pending <= new_cfg_part1 or new_cfg_part2;
            
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
                  present_adc_clk_phase1 <= std_logic_vector(FPA_INT_CFG.ADC_CLK_SOURCE_PHASE);
                  present_adc_clk_phase2 <= std_logic_vector(FPA_INT_CFG.ADC_CLK_PIPE_SEL);
                  pause_cnt <= pause_cnt + 1;
                  if pause_cnt(3) = '1' then 
                     cfg_sm <= idle; 
                  end if;
               
               when others =>
               
            end case;               
            
         end if;  
      end if;
   end process;       
   
   
   Gen1 : if abs(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_HZ - 72_000_000) <= 10_000 generate   
      begin    
      U1 :  scorpiomwA_18MHz_mmcm
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
   end generate;
   
   Gen2 : if abs(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_HZ - 144_000_000) <= 10_000 generate   
      begin                                             
      U2 :  scorpiomwA_144MHz_to_18MHz_mmcm
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
   end generate; 
   
   Gen3 : if abs(DEFINE_FPA_MASTER_CLK_SOURCE_RATE_HZ - 108_000_000) <= 10_000 generate   
      begin                                             
      U2 :  scorpiomwA_27MHz_mmcm
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
   end generate;
   
   
   
end rtl;
