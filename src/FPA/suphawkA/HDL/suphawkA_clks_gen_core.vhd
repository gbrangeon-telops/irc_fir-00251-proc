------------------------------------------------------------------
--!   @file : suphawkA_clks_gen_core
--!   @brief
--!   @details
--!
--!   $Rev: 23147 $
--!   $Author: elarouche $
--!   $Date: 2019-04-01 14:32:59 -0400 (lun., 01 avr. 2019) $
--!   $Id: suphawkA_clks_gen_core.vhd 23147 2019-04-01 18:32:59Z elarouche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/src/FPA/suphawkA/HDL/suphawkA_clks_gen_core.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;
use work.fpa_common_pkg.all;
use work.FPA_define.all;

entity suphawkA_clks_gen_core is
   port(
      ARESET                 : in std_logic;
      
      MCLK_SOURCE            : in std_logic;  -- ne s'interrompt pas lors de la reconfig      
      ADC_CLK_SOURCE         : in std_logic;  -- ne s'interrompt pas lors de la reconfig 
      
      
      
      FPA_INTF_CFG           : in fpa_intf_cfg_type;      
      
      -- horloge standard
      FPA_MCLK               : out std_logic;
      FPA_PCLK               : out std_logic;  -- pour le suphawk, Pixel clock (PCLK) = master clock (MCLK). C'est le double pour les indigo
      
      -- horloge rapide
      FPA_FAST_MCLK          : out std_logic;  -- 
      FPA_FAST_PCLK          : out std_logic;  -- 
      
      QUAD_CLK_COPY          : out std_logic;  -- quad_clk utilisé par le readout_ctrler
      QUAD_CLK_ENABLED       : out std_logic;
      
      QUAD1_CLK              : out std_logic;
      QUAD2_CLK              : out std_logic;
      QUAD3_CLK              : out std_logic;
      QUAD4_CLK              : out std_logic
      
      );
end suphawkA_clks_gen_core;

architecture rtl of suphawkA_clks_gen_core is   
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   component double_sync is
      generic(
         INIT_VALUE : bit := '0'
         );
      port(
         D     : in std_logic;
         Q     : out std_logic := '0';
         RESET : in std_logic;
         CLK   : in std_logic
         );
   end component;
   
   component double_sync_vector is       -- ENO : 10 oct 2017: necessaire pour ce module
      port(
         D : in std_logic_vector;
         Q : out std_logic_vector;
         CLK : in std_logic
         );
   end component;
   
   component Clk_Divider is
      Generic(	
         Factor : integer := 2);		
      Port ( 
         Clock     : in std_logic;
         Reset     : in std_logic;		
         Clk_div   : out std_logic);
   end component;
   
   component fwft_afifo_w8_d256
      port (
         rst     : in std_logic;
         wr_clk  : in std_logic;
         rd_clk  : in std_logic;
         din     : in std_logic_vector(7 downto 0);
         wr_en   : in std_logic;
         rd_en   : in std_logic;
         dout    : out std_logic_vector(7 downto 0);
         full    : out std_logic;
         almost_full : out std_logic;
         overflow : out std_logic;
         empty   : out std_logic;
         valid   : out std_logic
         );
   end component;
   
   constant C_CLK_RDY_DLY_ms   : real := 1000.0;
   constant C_DLY_BIT_POS      : integer := integer(ceil(log(C_CLK_RDY_DLY_ms * real(DEFINE_FPA_MCLK_RATE_KHZ))/MATH_LOG_OF_2));
   
   type sync_fsm_type is (idle, done_st);
   
   signal sync_fsm                       : sync_fsm_type;
   
   signal sreset_mclk_source             : std_logic;
   signal sreset_adc_clk_source          : std_logic;
   signal quad_clk_iob                   : std_logic_vector(4 downto 1);
   
   signal fpa_mclk_i                     : std_logic := '0';
   signal fpa_pclk_i                     : std_logic := '0';
   
   signal fpa_fast_mclk_i                : std_logic := '0';
   signal fpa_fast_pclk_i                : std_logic := '0';
   
   signal quad_clk_raw                   : std_logic := '0';
   signal quad_clk_from_mclk_source      : std_logic := '0';
   --signal quad_clk_from_adc_clk_source   : std_logic := '0';
   signal quad_clk_enabled_i             : std_logic := '0';
   signal quad_clk_copy_i                : std_logic := '0';
   signal quad_clk_pipe                  : std_logic_vector(63 downto 0);
   --signal quad_clk_sel                   : std_logic;
   signal cfg_in_progress_i              : std_logic;
   signal adc_clk_pipe_sel_i             : std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL'LENGTH-1 downto 0);
   signal idle_cnt                       : unsigned(C_DLY_BIT_POS downto 0);
   
   signal fifo_wr_en                     : std_logic;
   signal fifo_din                       : std_logic_vector(7 downto 0);
   signal fifo_dout                      : std_logic_vector(7 downto 0);
   signal fifo_dout_dval                 : std_logic;
   
   signal fpa_mclk_last                  : std_logic;
   signal fpa_mclk_re                    : std_logic;
   
   
   attribute equivalent_register_removal : string;
   attribute equivalent_register_removal of quad_clk_iob: signal is "no";
   
   attribute iob : string;
   attribute iob of quad_clk_iob: signal is "true";
   
   -- attribute dont_touch : string;
   -- attribute dont_touch of quad_clk_iob: signal is "true";
   
begin
   
   QUAD1_CLK <= quad_clk_iob(1);
   QUAD2_CLK <= quad_clk_iob(2);
   QUAD3_CLK <= quad_clk_iob(3);
   QUAD4_CLK <= quad_clk_iob(4);
   QUAD_CLK_COPY <= quad_clk_copy_i;
   
   -- ENO: 07 juin 2017: le passage à travers les registres associant les outputs ports  dans un porcess crée des problèmes en simulation.
   -- Eviter d'utiliser directement des outputs ports sans des process 
   
   FPA_MCLK <= fpa_mclk_i;      -- le not permet un alignement des edges de MCLK et PCLK
   FPA_PCLK <= fpa_pclk_i;             -- pour le suphawk, Pixel clock (PCLK) = master clock (MCLK). C'est le double pour les indigo 
   FPA_FAST_MCLK <= fpa_fast_mclk_i;    -- horloge ultrarapide pour le fast windowing
   FPA_FAST_PCLK <= fpa_fast_pclk_i;    -- horloge ultrarapide pour le fast windowing
   QUAD_CLK_ENABLED <= quad_clk_enabled_i;
   
   -----------------------------------------------------
   -- Synchronisation reset
   -----------------------------------------------------
   U1A: sync_reset
   Port map(		
      ARESET => ARESET, SRESET => sreset_mclk_source, CLK => MCLK_SOURCE);
   
   U1B: sync_reset
   Port map(		
      ARESET => ARESET, SRESET => sreset_adc_clk_source, CLK => ADC_CLK_SOURCE);
   
   --------------------------------------------------------
   -- Slow Master_clock statique
   -------------------------------------------------------- 
   U2A: Clk_Divider
   Generic map(
      Factor=> DEFINE_FPA_MCLK_RATE_FACTOR
      )
   Port map( 
      Clock   => MCLK_SOURCE,    
      Reset   => sreset_mclk_source, 
      Clk_div => fpa_mclk_i   -- attention, c'est en realité un clock enable. 
      );
   
   --------------------------------------------------------
   -- Slow Pixel_clock statique
   -------------------------------------------------------- 
   U2B: Clk_Divider
   Generic map(
      Factor=> DEFINE_FPA_PCLK_RATE_FACTOR
      )
   Port map( 
      Clock   => MCLK_SOURCE,     
      Reset   => sreset_mclk_source, 
      Clk_div => fpa_pclk_i   -- attention, c'est en realité un clock enable. 
      );
   
   --------------------------------------------------------
   -- quad_clock_copy 
   -------------------------------------------------------- 
   UCA: Clk_Divider
   Generic map(
      Factor => DEFINE_ADC_QUAD_CLK_FACTOR
      )
   Port map( 
      Clock   => MCLK_SOURCE, 
      Reset   => sreset_mclk_source, 
      Clk_div => quad_clk_from_mclk_source   -- attention, c'est en realité un clock enable.
      );  
   
   UCB : process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then       
         if sreset_mclk_source = '1' then         
            sync_fsm <= idle; 
            idle_cnt <= (others => '0');
            fifo_wr_en <= '0';
            quad_clk_enabled_i <= '0';
            fpa_mclk_last <= fpa_mclk_i;
            fpa_mclk_re <= '0';
            
         else
            
            -- quad_clk_copy
            quad_clk_copy_i <= quad_clk_from_mclk_source;
            
            -- mclk_re
            fpa_mclk_last <= fpa_mclk_i;
            fpa_mclk_re <= not fpa_mclk_last and fpa_mclk_i;
            
            case sync_fsm is
               
               when idle =>
                  if fpa_mclk_re = '1' then 
                     idle_cnt <= idle_cnt + 1;
                  end if;
                  if idle_cnt(6) = '1' then
                     sync_fsm <= done_st; 
                  end if;
               
               when done_st =>
                  fifo_wr_en <= '1';
                  if fpa_mclk_re = '1' then 
                     idle_cnt <= idle_cnt + 1;
                  end if;
                  if idle_cnt(C_DLY_BIT_POS) = '1' then
                     quad_clk_enabled_i <= '1';
                  end if;
                  -- pragma translate_off
                     quad_clk_enabled_i <= '1';
                  -- pragma translate_on
               
               when others =>
               
            end case;
            
            
         end if;
         
         
      end if;
   end process;   
   
   --   --------------------------------------------------------
   --   --  Fast Master_clock statique
   --   -------------------------------------------------------- 
   --   U2C: Clk_Divider
   --   Generic map(
   --      Factor=> DEFINE_FPA_FAST_MCLK_RATE_FACTOR
   --      )
   --   Port map( 
   --      Clock   => MCLK_SOURCE,     
   --      Reset   => sreset_mclk_source, 
   --      Clk_div => fpa_fast_mclk_i   -- attention, c'est en realité un clock enable. 
   --      );
   
   --   --------------------------------------------------------
   --   --  Fast Pixel_clock statique
   --   -------------------------------------------------------- 
   --   U2D: Clk_Divider
   --   Generic map(
   --      Factor=> DEFINE_FPA_FAST_PCLK_RATE_FACTOR
   --      )
   --   Port map( 
   --      Clock   => MCLK_SOURCE,     
   --      Reset   => sreset_mclk_source, 
   --      Clk_div => fpa_fast_pclk_i   -- attention, c'est en realité un clock enable. 
   --      );
   
   
   --------------------------------------------------------
   --  dephasage grossier des quad clock
   --------------------------------------------------------    
   sync_en : double_sync_vector  
   port map(
      D => std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL),
      Q => adc_clk_pipe_sel_i,
      CLK => MCLK_SOURCE); 
   
   U4C : process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then                                          
         
         -- pipe de l'horloge des adcs dans le domaine mclk_source (qui n'est jamais dephasé et donc stable)
         quad_clk_pipe(0) <= quad_clk_from_mclk_source;
         quad_clk_pipe(31 downto 1) <= quad_clk_pipe(30 downto 0);
         
         -- selection de l'horloge dephasagée pour chaque quad dans le domaine mclk_source 
         fifo_din(0) <= quad_clk_pipe(to_integer(unsigned(adc_clk_pipe_sel_i))); 
      end if;
   end process; 
   
   --------------------------------------------------------
   --  dephasage fin des quad clock via 
   -------------------------------------------------------- 
   
   adcclk_sync : fwft_afifo_w8_d256
   port map (
      rst      => ARESET,
      wr_clk   => MCLK_SOURCE,
      rd_clk   => ADC_CLK_SOURCE,
      din      => fifo_din,
      wr_en    => fifo_wr_en,
      rd_en    => fifo_dout_dval,
      dout     => fifo_dout,
      full     => open,
      almost_full => open,
      overflow => open,
      empty    => open,
      valid    => fifo_dout_dval
      );
   
   
   U4D : process(ADC_CLK_SOURCE)
   begin
      if rising_edge(ADC_CLK_SOURCE) then                                              
         -- registres des IOBs
         for kk in 1 to 4 loop
            quad_clk_iob(kk) <= fifo_dout(0); 
         end loop;         
      end if;
   end process;
   
   
end rtl;
