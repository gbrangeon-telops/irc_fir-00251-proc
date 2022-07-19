------------------------------------------------------------------
--!   @file : scorpiomwA_clks_gen_core
--!   @brief
--!   @details
--!
--!   $Rev: 26579 $
--!   $Author: enofodjie $
--!   $Date: 2021-06-21 19:26:27 -0400 (lun., 21 juin 2021) $
--!   $Id: scorpiomwA_clks_gen_core.vhd 26579 2021-06-21 23:26:27Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00272-FleG/trunk/src/FPA/scorpiomwA/HDL/scorpiomwA_clks_gen_core.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;
use work.fpa_common_pkg.all;
use work.FPA_define.all;

entity scorpiomwA_clks_gen_core is
   port(
      ARESET                 : in std_logic;
      
      MCLK_SOURCE            : in std_logic;  -- ne s'interrompt pas lors de la reconfig      
      ADC_CLK_SOURCE         : in std_logic;  -- ne s'interrompt pas lors de la reconfig       
      
      FPA_INTF_CFG           : in fpa_intf_cfg_type;      
      
      -- horloge standard
      NOMINAL_MCLK_RAW       : out std_logic; 
      PROG_MCLK_RAW          : out std_logic;
      
      ADC_REF_CLK            : out std_logic;  -- quad_clk utilisé par le readout_ctrler
      
      QUAD1_CLK              : out std_logic;
      QUAD2_CLK              : out std_logic   
      );
end scorpiomwA_clks_gen_core;

architecture rtl of scorpiomwA_clks_gen_core is   
   
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
         valid   : out std_logic;
         wr_rst_busy  : out std_logic;
         rd_rst_busy  : out std_logic
         );
   end component;
   
   type sync_fsm_type is (idle, done_st);
   
   signal sync_fsm                       : sync_fsm_type;
   
   signal sreset_mclk_source             : std_logic;
   signal sreset_adc_clk_source          : std_logic;
   signal quad_clk_iob                   : std_logic_vector(4 downto 1);   
   signal nominal_mclk_raw_i             : std_logic; 
   signal prog_mclk_raw_i                : std_logic;
   signal quad_clk_raw                   : std_logic := '0';
   signal quad_clk_from_adc_clk_source   : std_logic := '0';
   signal quad_clk_from_adc_clk_source_sync : std_logic := '0';
   signal adc_ref_clk_i                  : std_logic := '0';
   signal quad_clk_pipe                  : std_logic_vector(63 downto 0);
   signal adc_clk_pipe_sel               : std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL'LENGTH-1 downto 0);
   signal idle_cnt                       : unsigned(15 downto 0);
   
   signal fifo_wr_en                     : std_logic;
   signal fifo_din                       : std_logic_vector(7 downto 0);
   signal fifo_dout                      : std_logic_vector(7 downto 0);
   signal fifo_dout_dval                 : std_logic;
   
   signal nominal_mclk_raw_last          : std_logic;
   signal nominal_mclk_raw_re            : std_logic;
   signal wr_rst_busy                    : std_logic;
   
   
   attribute equivalent_register_removal : string;
   attribute equivalent_register_removal of quad_clk_iob: signal is "no";
   
   attribute iob : string;
   attribute iob of quad_clk_iob: signal is "true";
   
begin
   
   QUAD1_CLK         <= quad_clk_iob(1);
   QUAD2_CLK         <= quad_clk_iob(2);
   
   ADC_REF_CLK       <= adc_ref_clk_i;
   NOMINAL_MCLK_RAW  <= nominal_mclk_raw_i;    -- horloge à frequence nominale
   PROG_MCLK_RAW     <= prog_mclk_raw_i;       -- horloge à frequence nominale
   
   
   -----------------------------------------------------
   -- Synchronisation reset
   -----------------------------------------------------
   U1A: sync_reset
   Port map(		
      ARESET => ARESET, SRESET => sreset_mclk_source, CLK => MCLK_SOURCE);
   
   U1B: sync_reset
   Port map(		
      ARESET => ARESET, SRESET => sreset_adc_clk_source, CLK => ADC_CLK_SOURCE);
   --   --------------------------------------------------------
   --   -- Master_clock nominal
   --   -------------------------------------------------------- 
   U2: Clk_Divider
   Generic map(
      Factor=> DEFINE_FPA_CLK_INFO.MCLK_RATE_FACTOR(DEFINE_FPA_NOMINAL_MCLK_ID)
      )
   Port map( 
      Clock   => MCLK_SOURCE,    
      Reset   => sreset_mclk_source, 
      Clk_div => nominal_mclk_raw_i   -- attention, c'est en realité un clock enable. FPA_NOMINAL_MCLK
      ); 
   
   --   --------------------------------------------------------
   --   -- prog clock 
   --   -------------------------------------------------------- 
   U3: Clk_Divider
   Generic map(
      Factor=> DEFINE_FPA_CLK_INFO.MCLK_RATE_FACTOR(DEFINE_FPA_MCLK1_ID) --l''ID1 est accordé à l'horloge de programmation 
      )
   Port map( 
      Clock   => MCLK_SOURCE,    
      Reset   => sreset_mclk_source, 
      Clk_div => prog_mclk_raw_i   -- attention, c'est en realité un clock enable. 
      );
   
   --------------------------------------------------------
   -- adc_ref_clk_i 
   -------------------------------------------------------- 
   U4: Clk_Divider
   Generic map(
      Factor => DEFINE_ADC_QUAD_CLK_FACTOR
      )
   Port map( 
      Clock   => MCLK_SOURCE, 
      Reset   => sreset_mclk_source, 
      Clk_div => adc_ref_clk_i   -- attention, c'est en realité un clock enable.
      ); 
   
   --------------------------------------------------------
   -- quad_clk_from_adc_clk_source 
   --------------------------------------------------------
   U5: Clk_Divider
   Generic map(
      Factor => DEFINE_ADC_QUAD_CLK_FACTOR
      )
   Port map( 
      Clock   => ADC_CLK_SOURCE, 
      Reset   => sreset_adc_clk_source, 
      Clk_div => quad_clk_from_adc_clk_source     -- attention, c'est en realité un clock enable.
      ); 
   
   --------------------------------------------------------
   --  dephasage fin des quad clock via fifo
   -------------------------------------------------------- 
   fifo_din(1 downto 0)<= nominal_mclk_raw_i & nominal_mclk_raw_i;
   
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
      valid    => fifo_dout_dval,
      wr_rst_busy => wr_rst_busy,  
      rd_rst_busy => open
      );
   
   -- write du fifo,
   UCB : process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then       
         if sreset_mclk_source = '1' then         
            sync_fsm <= idle; 
            idle_cnt <= (others => '0');
            fifo_wr_en <= '0';
            nominal_mclk_raw_last <= '0';
            nominal_mclk_raw_re <= '0';
            
         else
            
            -- mclk_re
            nominal_mclk_raw_last <= nominal_mclk_raw_i;
            nominal_mclk_raw_re <= not nominal_mclk_raw_last and nominal_mclk_raw_i;
            
            case sync_fsm is
               
               when idle =>
                  if nominal_mclk_raw_re = '1' then 
                     idle_cnt <= idle_cnt + 1;
                  end if;
                  if idle_cnt(6) = '1' then
                     sync_fsm <= done_st;
                     idle_cnt <= (others => '0');
                  end if;
               
               when done_st =>
                  fifo_wr_en <= not wr_rst_busy;
               
               when others =>
               
            end case;             
            
         end if;         
         
      end if;
   end process; 
   
   --------------------------------------------------------
   --  dephasage grossier des quad clock via registres
   --------------------------------------------------------    
   U7A : double_sync_vector  
   port map(
      D => std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL),
      Q => adc_clk_pipe_sel,
      CLK => ADC_CLK_SOURCE); 
   
   U7B : process(ADC_CLK_SOURCE)
   begin
      if rising_edge(ADC_CLK_SOURCE) then                                          
         
         -- pipe de l'horloge des adcs
         quad_clk_pipe(0) <= fifo_dout(0);
         quad_clk_pipe(31 downto 1) <= quad_clk_pipe(30 downto 0);
         
         -- selection de l'horloge dephasagée pour chaque quad
         quad_clk_iob(2) <= quad_clk_pipe(to_integer(unsigned(adc_clk_pipe_sel)));
         quad_clk_iob(1) <= quad_clk_pipe(to_integer(unsigned(adc_clk_pipe_sel)));
      end if;
   end process;   
   
   
   
   --   U4D : process(ADC_CLK_SOURCE)
   --   begin
   --      if rising_edge(ADC_CLK_SOURCE) then                                              
   --         -- registres des IOBs
   --         -- for kk in 1 to 4 loop
   --         --   quad_clk_iob(kk) <= fifo_dout(0); 
   --         -- end loop;
   --         -- quad_clk_iob(4) <= fifo_dout(0);  
   --         -- quad_clk_iob(3) <= fifo_dout(0);  
   --         quad_clk_iob(2) <= fifo_dout(0);  
   --         quad_clk_iob(1) <= fifo_dout(0);        
   --      end if;
   --   end process;    
   
end rtl;
