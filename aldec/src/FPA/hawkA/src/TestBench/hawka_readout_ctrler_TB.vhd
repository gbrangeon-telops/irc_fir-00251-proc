library hawkA;
use hawkA.FPA_define.all;
use hawkA.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity hawka_readout_ctrler_tb is
end hawka_readout_ctrler_tb;

architecture TB_ARCHITECTURE of hawka_readout_ctrler_tb is
   -- Component declaration of the tested unit
   component hawka_readout_ctrler
      port(
         ARESET : in STD_LOGIC;
         CLK : in STD_LOGIC;
         FPA_MCLK : in STD_LOGIC;
         FPA_PCLK : in STD_LOGIC;
         QUAD_CLK_COPY : in STD_LOGIC;
         FPA_INTF_CFG : in fpa_intf_cfg_type;
         FPA_INT : in STD_LOGIC;
         FPA_FDEM : out STD_LOGIC;
         FPA_RD_MCLK : out STD_LOGIC;
         READOUT_INFO : out readout_info_type );
   end component;
   
   constant CLK_100M_PERIOD         : time := 10.5 ns;
   constant MCLK_SOURCE_PERIOD      : time := 12.5 ns;
   constant FPA_MCLK_PERIOD         : time := 100.0 ns;
   constant FPA_INT_PERIOD          : time := 1000.0 us;
   constant quad_clk_PERIOD      : time := 25.0 ns;
   
   constant XSIZE : integer := 640;
   constant YSIZE : integer := 480;
   constant PAUSE_SIZE : integer := 8;
   
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ARESET       : STD_LOGIC  := '1';
   signal CLK          : STD_LOGIC; --  := '1';
   signal FPA_MCLK     : STD_LOGIC  := '1';
   signal MCLK_SOURCE  : STD_LOGIC  := '1';
   signal QUAD_CLK_COPY  : STD_LOGIC  := '1';
   signal CLK_100M     : STD_LOGIC  := '1';
   signal FPA_INTF_CFG : fpa_intf_cfg_type;
   signal FPA_INT      : STD_LOGIC; 
   signal FPA_INTi     : STD_LOGIC := '0';
   signal FPA_INTii    : STD_LOGIC ;
   -- Observed signals - signals mapped to the output ports of tested entity
   signal FPA_FDEM : STD_LOGIC;
   signal FPA_RD_MCLK : STD_LOGIC;
   signal READOUT_INFO : readout_info_type;
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
   
   -- clk
   U1: process(FPA_MCLK)
   begin
      FPA_MCLK <= not FPA_MCLK after FPA_MCLK_PERIOD/2; 
   end process; 
   
      -- clk
   U1m: process(QUAD_CLK_COPY)
   begin
      QUAD_CLK_COPY <= not QUAD_CLK_COPY after QUAD_CLK_PERIOD/2; 
   end process;
   
   -- clk
   U2: process(MCLK_SOURCE)
   begin
      MCLK_SOURCE <= not MCLK_SOURCE after MCLK_SOURCE_PERIOD/2; 
   end process;
   CLK <= MCLK_SOURCE;
   
   -- clk
   U3: process(FPA_INTi)
   begin
      FPA_INTi <= not FPA_INTi after FPA_INT_PERIOD/2; 
   end process; 
   FPA_INTii <= transport FPA_INTi after 1 us;
   FPA_INT <= FPA_INTi and FPA_INTii;
   
   
   FPA_INTF_CFG.line_period_pclk <= to_unsigned((XSIZE/4 + PAUSE_SIZE), FPA_INTF_CFG.line_period_pclk'length);
   FPA_INTF_CFG.readout_pclk_cnt_max   <= to_unsigned((XSIZE/4 + PAUSE_SIZE)*(YSIZE + 1) + 3, FPA_INTF_CFG.readout_pclk_cnt_max'length);
   
   FPA_INTF_CFG.active_line_start_num            <= to_unsigned(1, FPA_INTF_CFG.active_line_start_num'length); 
   FPA_INTF_CFG.active_line_end_num         <= to_unsigned(YSIZE + to_integer(FPA_INTF_CFG.active_line_start_num) - 1, FPA_INTF_CFG.active_line_end_num'length);
     
   FPA_INTF_CFG.pix_samp_num_per_ch   <= to_unsigned(4, FPA_INTF_CFG.pix_samp_num_per_ch'length);
   
   FPA_INTF_CFG.sof_posf_pclk   <= to_unsigned(PAUSE_SIZE, FPA_INTF_CFG.sof_posf_pclk'length);
   FPA_INTF_CFG.eof_posf_pclk   <= resize(FPA_INTF_CFG.active_line_end_num* FPA_INTF_CFG.line_period_pclk -1, FPA_INTF_CFG.eof_posf_pclk'length);
   FPA_INTF_CFG.sol_posl_pclk   <= to_unsigned(PAUSE_SIZE, FPA_INTF_CFG.sol_posl_pclk'length);
   FPA_INTF_CFG.eol_posl_pclk   <= to_unsigned(PAUSE_SIZE + (XSIZE/4)-1, FPA_INTF_CFG.eol_posl_pclk'length);
   FPA_INTF_CFG.eol_posl_pclk_p1   <= FPA_INTF_CFG.eol_posl_pclk + 1;
   
   --FPA_INTF_CFG <= FPA_INTF_CFG;
   
   -- Unit Under Test port map
   UUT : hawka_readout_ctrler
   port map (
      ARESET => ARESET,
      CLK => CLK,
      FPA_MCLK => FPA_MCLK,
      FPA_PCLK => FPA_MCLK,
      FPA_INTF_CFG => FPA_INTF_CFG,
      FPA_INT => FPA_INT,
      FPA_FDEM => FPA_FDEM,
      FPA_RD_MCLK => FPA_RD_MCLK,
      QUAD_CLK_COPY => QUAD_CLK_COPY,
      READOUT_INFO => READOUT_INFO
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_hawka_readout_ctrler of hawka_readout_ctrler_tb is
   for TB_ARCHITECTURE
      for UUT : hawka_readout_ctrler
         use entity work.hawka_readout_ctrler(rtl);
      end for;
   end for;
end TESTBENCH_FOR_hawka_readout_ctrler;

