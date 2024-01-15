------------------------------------------------------------------
--!   @file : isc0804A_2k_clks_gen_core
--!   @brief
--!   @details
--!
--!   $Rev: 27897 $
--!   $Author: enofodjie $
--!   $Date: 2022-09-27 10:32:30 -0400 (mar., 27 sept. 2022) $
--!   $Id: isc0804A_2k_clks_gen_core.vhd 27897 2022-09-27 14:32:30Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00272-FleG/trunk/src/FPA/isc0804A_2k/HDL/isc0804A_2k_clks_gen_core.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;
use work.fpa_common_pkg.all;
use work.FPA_define.all;
use work.fastrd2_define.all;

entity isc0804A_2k_clks_gen_core is
   port(
      ARESET                 : in std_logic;
      
      MCLK_SOURCE            : in std_logic;  -- ne s'interrompt pas lors de la reconfig      
      ADC_CLK1_SOURCE        : in std_logic;  -- ne s'interrompt pas lors de la reconfig
      ADC_CLK2_SOURCE        : in std_logic;  -- ne s'interrompt pas lors de la reconfig
      ADC_CLK3_SOURCE        : in std_logic;  -- ne s'interrompt pas lors de la reconfig
      ADC_CLK4_SOURCE        : in std_logic;  -- ne s'interrompt pas lors de la reconfig
      
      FPA_INTF_CFG           : in fpa_intf_cfg_type;      
      
      -- horloge standard
      NOMINAL_MCLK_RAW       : out std_logic;
      FAST_MCLK_RAW          : out std_logic;
      PROG_MCLK_RAW          : out std_logic;
      
      ADC_REF_CLK            : out std_logic;  -- quad_clk utilisé par le readout_ctrler      
      
      QUAD1_CLK              : out std_logic;
      QUAD2_CLK              : out std_logic;
      QUAD3_CLK              : out std_logic;
      QUAD4_CLK              : out std_logic      
      );
end isc0804A_2k_clks_gen_core;

architecture rtl of isc0804A_2k_clks_gen_core is   
   
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
   
   signal sreset_mclk_source             : std_logic := '1';
   signal sreset_adc_clk1_source         : std_logic := '1';
   signal sreset_adc_clk2_source         : std_logic := '1';
   signal sreset_adc_clk3_source         : std_logic := '1';
   signal sreset_adc_clk4_source         : std_logic := '1';
   signal quad_clk_iob                   : std_logic_vector(4 downto 1);   
   signal nominal_mclk_raw_i             : std_logic;
   signal fast_mclk_raw_i                : std_logic;
   signal prog_mclk_raw_i                : std_logic;
   signal quad_clk_raw                   : std_logic := '0';
   signal adc_ref_clk_i                  : std_logic := '0';
   signal quad_clk_pipe1                 : std_logic_vector(63 downto 0);
   signal quad_clk_pipe2                 : std_logic_vector(63 downto 0);
   signal quad_clk_pipe3                 : std_logic_vector(63 downto 0);
   signal quad_clk_pipe4                 : std_logic_vector(63 downto 0);
   signal adc_clk_pipe_sel1              : std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL1'LENGTH-1 downto 0);
   signal adc_clk_pipe_sel2              : std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL1'LENGTH-1 downto 0);
   signal adc_clk_pipe_sel3              : std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL1'LENGTH-1 downto 0);
   signal adc_clk_pipe_sel4              : std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL1'LENGTH-1 downto 0);
   signal idle_cnt                       : unsigned(15 downto 0);
   
   signal fifo_din                       : std_logic_vector(7 downto 0);
   signal fifo_wr_en1, fifo_wr_en2       : std_logic;
   signal fifo_wr_en3, fifo_wr_en4       : std_logic;
   signal fifo_dout1, fifo_dout2         : std_logic_vector(7 downto 0);
   signal fifo_dout3, fifo_dout4         : std_logic_vector(7 downto 0);
   signal fifo_dout_dval1, fifo_dout_dval2 : std_logic;
   signal fifo_dout_dval3, fifo_dout_dval4 : std_logic;
   
   signal nominal_mclk_raw_last          : std_logic;
   signal nominal_mclk_raw_re            : std_logic;
   signal wr_rst_busy1, wr_rst_busy2     : std_logic;
   signal wr_rst_busy3, wr_rst_busy4     : std_logic;
   
   signal nominal_pclk_raw_i             : std_logic;   
   
   attribute equivalent_register_removal : string;
   attribute equivalent_register_removal of quad_clk_iob: signal is "no";
   
   attribute iob : string;
   attribute iob of quad_clk_iob: signal is "true";
   
begin
   
   QUAD1_CLK         <= quad_clk_iob(1);
   QUAD2_CLK         <= quad_clk_iob(2);
   QUAD3_CLK         <= quad_clk_iob(3);
   QUAD4_CLK         <= quad_clk_iob(4);
   
   ADC_REF_CLK       <= adc_ref_clk_i;
   NOMINAL_MCLK_RAW  <= nominal_mclk_raw_i;    -- horloge à frequence nominale
   FAST_MCLK_RAW     <= fast_mclk_raw_i;       -- horloge à frequence rapide
   PROG_MCLK_RAW     <= prog_mclk_raw_i;       -- horloge à frequence nominale   
   
   -----------------------------------------------------
   -- Synchronisation reset
   -----------------------------------------------------
   U1A: sync_reset
   Port map(		
      ARESET => ARESET, SRESET => sreset_mclk_source, CLK => MCLK_SOURCE);
   
   U1B: sync_reset
   Port map(		
      ARESET => ARESET, SRESET => sreset_adc_clk1_source, CLK => ADC_CLK1_SOURCE);

   U1C: sync_reset
   Port map(		
      ARESET => ARESET, SRESET => sreset_adc_clk2_source, CLK => ADC_CLK2_SOURCE);

   U1D: sync_reset
   Port map(		
      ARESET => ARESET, SRESET => sreset_adc_clk3_source, CLK => ADC_CLK3_SOURCE);
      
   U1E: sync_reset
   Port map(		
      ARESET => ARESET, SRESET => sreset_adc_clk4_source, CLK => ADC_CLK4_SOURCE);
      
   --   --------------------------------------------------------
   --   -- Master_clock nominal
   --   -------------------------------------------------------- 
   U2A: Clk_Divider
   Generic map(
    Factor=> DEFINE_FPA_CLK_INFO.MCLK_RATE_FACTOR(DEFINE_FPA_NOMINAL_MCLK_ID)
      )
   Port map( 
      Clock   => MCLK_SOURCE,    
      Reset   => sreset_mclk_source, 
      Clk_div => nominal_mclk_raw_i   -- attention, c'est en realité un clock enable. FPA_NOMINAL_MCLK
      );
   
   U2B: Clk_Divider
   Generic map(
      Factor=> DEFINE_FPA_CLK_INFO.PCLK_RATE_FACTOR(DEFINE_FPA_NOMINAL_MCLK_ID)
      )
   Port map( 
      Clock   => MCLK_SOURCE,    
      Reset   => sreset_mclk_source, 
      Clk_div => nominal_pclk_raw_i   -- attention, c'est en realité un clock enable. FPA_NOMINAL_PCLK
      );
	  
   U2C: Clk_Divider
   Generic map(
    Factor=> DEFINE_FPA_CLK_INFO.MCLK_RATE_FACTOR(DEFINE_FPA_MCLK2_ID)
      )
   Port map( 
      Clock   => MCLK_SOURCE,    
      Reset   => sreset_mclk_source, 
      Clk_div => fast_mclk_raw_i   -- attention, c'est en realité un clock enable. FPA_NOMINAL_MCLK
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
   --  dephasage fin des quad clock via fifo
   -------------------------------------------------------- 
   fifo_din(1 downto 0)<= nominal_pclk_raw_i & nominal_pclk_raw_i;
   
   adcclk_sync1 : fwft_afifo_w8_d256
   port map (
      rst      => ARESET,
      wr_clk   => MCLK_SOURCE,
      rd_clk   => ADC_CLK1_SOURCE,
      din      => fifo_din,
      wr_en    => fifo_wr_en1,
      rd_en    => fifo_dout_dval1,
      dout     => fifo_dout1,
      full     => open,
      almost_full => open,
      overflow => open,
      empty    => open,
      valid    => fifo_dout_dval1,
      wr_rst_busy => wr_rst_busy1,  
      rd_rst_busy => open
      );

   adcclk_sync2 : fwft_afifo_w8_d256
   port map (
      rst      => ARESET,
      wr_clk   => MCLK_SOURCE,
      rd_clk   => ADC_CLK2_SOURCE,
      din      => fifo_din,
      wr_en    => fifo_wr_en2,
      rd_en    => fifo_dout_dval2,
      dout     => fifo_dout2,
      full     => open,
      almost_full => open,
      overflow => open,
      empty    => open,
      valid    => fifo_dout_dval2,
      wr_rst_busy => wr_rst_busy2,  
      rd_rst_busy => open
      );

   adcclk_sync3 : fwft_afifo_w8_d256
   port map (
      rst      => ARESET,
      wr_clk   => MCLK_SOURCE,
      rd_clk   => ADC_CLK3_SOURCE,
      din      => fifo_din,
      wr_en    => fifo_wr_en3,
      rd_en    => fifo_dout_dval3,
      dout     => fifo_dout3,
      full     => open,
      almost_full => open,
      overflow => open,
      empty    => open,
      valid    => fifo_dout_dval3,
      wr_rst_busy => wr_rst_busy3,  
      rd_rst_busy => open
      );

   adcclk_sync4 : fwft_afifo_w8_d256
   port map (
      rst      => ARESET,
      wr_clk   => MCLK_SOURCE,
      rd_clk   => ADC_CLK4_SOURCE,
      din      => fifo_din,
      wr_en    => fifo_wr_en4,
      rd_en    => fifo_dout_dval4,
      dout     => fifo_dout4,
      full     => open,
      almost_full => open,
      overflow => open,
      empty    => open,
      valid    => fifo_dout_dval4,
      wr_rst_busy => wr_rst_busy4,  
      rd_rst_busy => open
      );
      
   -- write du fifo
   UCB : process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then       
         if sreset_mclk_source = '1' then         
            sync_fsm <= idle; 
            idle_cnt <= (others => '0');
            fifo_wr_en1 <= '0';
            fifo_wr_en2 <= '0';
            fifo_wr_en3 <= '0';
            fifo_wr_en4 <= '0';
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
                  fifo_wr_en1 <= not wr_rst_busy1;
                  fifo_wr_en2 <= not wr_rst_busy2;
                  fifo_wr_en3 <= not wr_rst_busy3;
                  fifo_wr_en4 <= not wr_rst_busy4;
               
               when others =>
                  null;
            end case;             
         end if;         
      end if;
   end process; 
   
   --------------------------------------------------------
   --  dephasage grossier des quad clock via registres
   --------------------------------------------------------    
   U7A : double_sync_vector  
   port map(
      D => std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL1),
      Q => adc_clk_pipe_sel1,
      CLK => ADC_CLK1_SOURCE); 

   U7B : double_sync_vector  
   port map(
      D => std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL2),
      Q => adc_clk_pipe_sel2,
      CLK => ADC_CLK2_SOURCE); 
      
   U7C : double_sync_vector  
   port map(
      D => std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL3),
      Q => adc_clk_pipe_sel3,
      CLK => ADC_CLK3_SOURCE); 

   U7D : double_sync_vector  
   port map(
      D => std_logic_vector(FPA_INTF_CFG.ADC_CLK_PIPE_SEL4),
      Q => adc_clk_pipe_sel4,
      CLK => ADC_CLK4_SOURCE); 
      
   U8A : process(ADC_CLK1_SOURCE)
   begin
      if rising_edge(ADC_CLK1_SOURCE) then                                          
         if sreset_adc_clk1_source = '1' then
            quad_clk_pipe1 <= (others=>'0');
         else
            -- pipe de l'horloge des adcs
            quad_clk_pipe1(0) <= fifo_dout1(0);
            quad_clk_pipe1(31 downto 1) <= quad_clk_pipe1(30 downto 0);
         
            -- selection de l'horloge dephasagée pour chaque quad
            quad_clk_iob(1) <= quad_clk_pipe1(to_integer(unsigned(adc_clk_pipe_sel1)));
         end if;
      end if;
   end process;      

   U8B : process(ADC_CLK2_SOURCE)
   begin
      if rising_edge(ADC_CLK2_SOURCE) then                                          
         if sreset_adc_clk2_source = '1' then
            quad_clk_pipe2 <= (others=>'0');
         else
            -- pipe de l'horloge des adcs
            quad_clk_pipe2(0) <= fifo_dout2(0);
            quad_clk_pipe2(31 downto 1) <= quad_clk_pipe2(30 downto 0);
         
            -- selection de l'horloge dephasagée pour chaque quad
            quad_clk_iob(2) <= quad_clk_pipe2(to_integer(unsigned(adc_clk_pipe_sel2)));
         end if;
      end if;
   end process;      

   U8C : process(ADC_CLK3_SOURCE)
   begin
      if rising_edge(ADC_CLK3_SOURCE) then                                          
         if sreset_adc_clk3_source = '1' then
            quad_clk_pipe3 <= (others=>'0');
         else
            -- pipe de l'horloge des adcs
            quad_clk_pipe3(0) <= fifo_dout3(0);
            quad_clk_pipe3(31 downto 1) <= quad_clk_pipe3(30 downto 0);
         
            -- selection de l'horloge dephasagée pour chaque quad
            quad_clk_iob(3) <= quad_clk_pipe3(to_integer(unsigned(adc_clk_pipe_sel3)));
         end if;
      end if;
   end process;      

   U8D : process(ADC_CLK4_SOURCE)
   begin
      if rising_edge(ADC_CLK4_SOURCE) then                                          
         if sreset_adc_clk4_source = '1' then
            quad_clk_pipe4 <= (others=>'0');
         else
            -- pipe de l'horloge des adcs
            quad_clk_pipe4(0) <= fifo_dout4(0);
            quad_clk_pipe4(31 downto 1) <= quad_clk_pipe4(30 downto 0);
         
            -- selection de l'horloge dephasagée pour chaque quad
            quad_clk_iob(4) <= quad_clk_pipe4(to_integer(unsigned(adc_clk_pipe_sel4)));
         end if;
      end if;
   end process;      
   
end rtl;