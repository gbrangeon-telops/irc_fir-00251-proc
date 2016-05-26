library scorpiomwA;
use scorpiomwA.FPA_define.all;
use scorpiomwA.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity scorpiomwA_readout_ctrler_tb is
end scorpiomwA_readout_ctrler_tb;

architecture TB_ARCHITECTURE of scorpiomwA_readout_ctrler_tb is
   -- Component declaration of the tested unit
   component scorpiomwA_readout_ctrler
      port (
         ARESET : in STD_LOGIC;
         CLK : in STD_LOGIC;
         FPA_DATA_VALID : in STD_LOGIC;
         FPA_INT : in STD_LOGIC;
         FPA_INTF_CFG : in FPA_INTF_CFG_TYPE;
         FPA_MCLK : in STD_LOGIC;
         FPA_PCLK : in STD_LOGIC;
         QUAD_CLK_COPY : in STD_LOGIC;
         ADC_SYNC_FLAG : out STD_LOGIC;
         READOUT_INFO : out READOUT_INFO_TYPE
         );
   end component;
   
   component scorpiomwA_clks_gen
      port (
         ARESET : in STD_LOGIC;
         CLK_80M : in STD_LOGIC;
         DISABLE_QUAD_CLK_DEFAULT : in STD_LOGIC;
         FPA_INTF_CFG : in FPA_INTF_CFG_TYPE;
         ADC_DESERIALIZER_RST : out STD_LOGIC;
         FPA_MCLK : out STD_LOGIC;
         FPA_PCLK : out STD_LOGIC;
         MCLK_SOURCE : out STD_LOGIC;
         MMCM_LOCKED : out STD_LOGIC;
         QUAD1_CLK : out STD_LOGIC;
         QUAD2_CLK : out STD_LOGIC;
         QUAD_CLK_COPY : out STD_LOGIC
         );
   end component;
   
   constant CLK_100M_PERIOD         : time := 10.0 ns;
   constant CLK_80M_PERIOD          : time := 12.5 ns;
   constant MCLK_SOURCE_PERIOD      : time := 13.889 ns;
   constant FPA_MCLK_PERIOD         : time := 55.556 ns;
   constant FPA_INT_PERIOD          : time := 300.0 us;
   constant quad_clk_PERIOD         : time := 25.0 ns;
   
   constant XSIZE : integer := 640;
   constant YSIZE : integer := 512;
   constant PAUSE_SIZE : integer := 0;
   
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ARESET       : STD_LOGIC  := '1';
   signal CLK          : STD_LOGIC; --  := '1';
   signal FPA_MCLK     : STD_LOGIC;
   signal FPA_PCLK     : STD_LOGIC;
   signal MCLK_SOURCE  : STD_LOGIC  := '1';
   signal QUAD_CLK_COPY  : STD_LOGIC;
   signal CLK_80M      : STD_LOGIC  := '1';
   signal FPA_INTF_CFG : fpa_intf_cfg_type;
   signal FPA_INT      : STD_LOGIC; 
   signal FPA_INTi     : STD_LOGIC := '0';
   signal FPA_INTii    : STD_LOGIC ;
   -- Observed signals - signals mapped to the output ports of tested entity
   signal FPA_DATA_VALID : STD_LOGIC;
   signal FPA_LSYNC : STD_LOGIC;
   signal READOUT_INFO : readout_info_type; 
   signal samp_cnt      : integer;
   --signal FPA_INTF_CFG : fpa_intf_cfg_type;
   
   -- Add your code here ...
   
begin
   
   -- reset
   U0: process
   begin
      areset <= '1'; 
      wait for 250 ns;
      areset <= '0';
      wait;
   end process;
   
   U26 : scorpiomwA_clks_gen
   port map(
      ADC_DESERIALIZER_RST => open,
      ARESET => areset,
      CLK_80M => CLK_80M,
      DISABLE_QUAD_CLK_DEFAULT => '0',
      FPA_MCLK => FPA_MCLK,
      FPA_PCLK => FPA_PCLK,
      QUAD1_CLK => open,
      QUAD2_CLK => open,
      MMCM_LOCKED => open,
      FPA_INTF_CFG => FPA_INTF_CFG,
      MCLK_SOURCE => MCLK_SOURCE,
      QUAD_CLK_COPY => QUAD_CLK_COPY
      );
   
   --   -- clk
   --   U1m: process(QUAD_CLK_COPY)
   --   begin
   --      QUAD_CLK_COPY <= not QUAD_CLK_COPY after QUAD_CLK_PERIOD/2; 
   --   end process;
   
   -- clk
   --   U2A: process(CLK)
   --   begin
   --      MCLK_SOURCE <= not MCLK_SOURCE after MCLK_SOURCE_PERIOD/2; 
   --   end process;
   --   CLK <= MCLK_SOURCE; 
   
   U2B: process(CLK_80M)
   begin
      CLK_80M <= not CLK_80M after CLK_80M_PERIOD/2; 
   end process;
   
   -- clk
   U3: process(FPA_INTi)
   begin
      FPA_INTi <= not FPA_INTi after FPA_INT_PERIOD/2; 
   end process; 
   FPA_INTii <= transport FPA_INTi after 10 us;
   FPA_INT <= FPA_INTi and FPA_INTii;
   
   FPA_DATA_VALID <= transport FPA_INT after 10 us;
   
   FPA_INTF_CFG.XSTART <= (others => '0');
   FPA_INTF_CFG.YSTART <= (others => '0');
   FPA_INTF_CFG.XSIZE  <= to_unsigned(xsize, FPA_INTF_CFG.XSIZE'length);
   FPA_INTF_CFG.YSIZE  <= to_unsigned(ysize, FPA_INTF_CFG.YSIZE'length);
   
   FPA_INTF_CFG.windcfg_part1  <= to_unsigned(1, FPA_INTF_CFG.windcfg_part1'length);
   FPA_INTF_CFG.windcfg_part2  <= to_unsigned(2, FPA_INTF_CFG.windcfg_part2'length);
   FPA_INTF_CFG.windcfg_part3  <= to_unsigned(3, FPA_INTF_CFG.windcfg_part3'length);
   FPA_INTF_CFG.windcfg_part4  <= to_unsigned(4, FPA_INTF_CFG.windcfg_part4'length);
   
   FPA_INTF_CFG.uprow_upcol    <= '0';
   FPA_INTF_CFG.sizea_sizeb    <= '0';
   FPA_INTF_CFG.itr            <= '1';
   FPA_INTF_CFG.gain           <= '0';
   
   FPA_INTF_CFG.gpol_code      <=  std_logic_vector(to_unsigned(2, FPA_INTF_CFG.gpol_code'length));
   
   
   FPA_INTF_CFG.real_mode_active_pixel_dly  <= to_unsigned(0, FPA_INTF_CFG.real_mode_active_pixel_dly'length);
   FPA_INTF_CFG.adc_quad2_en  <= '1';
   FPA_INTF_CFG.chn_diversity_en  <= '1'; 
   
   FPA_INTF_CFG.line_period_pclk <= to_unsigned((XSIZE/4 + PAUSE_SIZE), FPA_INTF_CFG.line_period_pclk'length);
   FPA_INTF_CFG.readout_pclk_cnt_max   <= to_unsigned((XSIZE/4 + PAUSE_SIZE)*(YSIZE) + 1, FPA_INTF_CFG.readout_pclk_cnt_max'length);
   
   FPA_INTF_CFG.active_line_start_num            <= to_unsigned(1, FPA_INTF_CFG.active_line_start_num'length); 
   FPA_INTF_CFG.active_line_end_num         <= to_unsigned(YSIZE + to_integer(FPA_INTF_CFG.active_line_start_num) - 1, FPA_INTF_CFG.active_line_end_num'length);
   
   FPA_INTF_CFG.pix_samp_num_per_ch   <= to_unsigned(2, FPA_INTF_CFG.pix_samp_num_per_ch'length);
   
   FPA_INTF_CFG.sof_posf_pclk   <= resize(FPA_INTF_CFG.line_period_pclk*(to_integer(FPA_INTF_CFG.active_line_start_num) - 1) + 1, FPA_INTF_CFG.sof_posf_pclk'length);
   FPA_INTF_CFG.eof_posf_pclk   <= resize(FPA_INTF_CFG.active_line_end_num* FPA_INTF_CFG.line_period_pclk - PAUSE_SIZE*2, FPA_INTF_CFG.eof_posf_pclk'length);
   FPA_INTF_CFG.sol_posl_pclk   <= to_unsigned(1, FPA_INTF_CFG.sol_posl_pclk'length);
   FPA_INTF_CFG.eol_posl_pclk   <= to_unsigned((XSIZE/4), FPA_INTF_CFG.eol_posl_pclk'length);
   FPA_INTF_CFG.eol_posl_pclk_p1   <= FPA_INTF_CFG.eol_posl_pclk + 1;
   
   FPA_INTF_CFG.adc_clk_phase   <= to_unsigned(0, FPA_INTF_CFG.adc_clk_phase'length);
   
   --FPA_INTF_CFG <= FPA_INTF_CFG;
   
   -- Unit Under Test port map
   UUT : scorpiomwA_readout_ctrler
   port map (
      ARESET => ARESET,
      CLK => MCLK_SOURCE,
      FPA_MCLK => FPA_MCLK,
      FPA_PCLK => FPA_PCLK,
      FPA_INTF_CFG => FPA_INTF_CFG,
      FPA_INT => FPA_INT,
      QUAD_CLK_COPY => QUAD_CLK_COPY,
      READOUT_INFO => READOUT_INFO,
      FPA_DATA_VALID => FPA_DATA_VALID
      );
   
   Uc : process(MCLK_SOURCE,  ARESET)
      variable v_cnt : integer;
      
   begin
      
      if  ARESET = '1' or READOUT_INFO.read_end = '1'  then 
         samp_cnt <=  0; 
      else
         
         if rising_edge(MCLK_SOURCE) then    
            if READOUT_INFO.samp_pulse = '1' and READOUT_INFO.dval = '1'  and READOUT_INFO.fval = '1'   then 
               samp_cnt <= samp_cnt + 1;
            end if; 
            
            v_cnt := samp_cnt;
         end if;
      end if;
   end process;            
   
   
   
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_scorpiomwA_readout_ctrler of scorpiomwA_readout_ctrler_tb is
   for TB_ARCHITECTURE
      for UUT : scorpiomwA_readout_ctrler
         use entity work.scorpiomwA_readout_ctrler(rtl);
      end for;
   end for;
end TESTBENCH_FOR_scorpiomwA_readout_ctrler;

