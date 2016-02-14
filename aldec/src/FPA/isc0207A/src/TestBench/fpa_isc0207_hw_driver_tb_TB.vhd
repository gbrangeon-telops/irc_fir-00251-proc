library work;
use work.FPA_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity fpa_isc0207_hw_driver_tb_tb is
end fpa_isc0207_hw_driver_tb_tb;

architecture TB_ARCHITECTURE of fpa_isc0207_hw_driver_tb_tb is
   -- Component declaration of the tested unit
   component fpa_isc0207_hw_driver_tb
      port(
         ACQ_TRIG       : in STD_LOGIC;     -- 0k
         ARESET         : in STD_LOGIC;     -- 0k
         CLK_100M       : in STD_LOGIC;     -- 0k
         FPA_DIGIO11    : in STD_LOGIC;
         FPA_DIGIO12    : in STD_LOGIC;
         FPA_EXP_INFO   : in exp_info_type; -- 0k
         FPA_INTF_CFG   : in fpa_intf_cfg_type; -- 0k
         FPA_MCLK       : in STD_LOGIC;     -- 0k
         MB_CLK         : in STD_LOGIC;     -- 0k
         MCLK_SOURCE    : in STD_LOGIC;     -- 0k
         READOUT        : in STD_LOGIC;     -- 0k
         XTRA_TRIG      : in STD_LOGIC;     -- 0k
         ERR_FOUND      : out STD_LOGIC;
         FPA_DIGIO1     : out STD_LOGIC;
         FPA_DIGIO10    : out STD_LOGIC;
         FPA_DIGIO2     : out STD_LOGIC;
         FPA_DIGIO3     : out STD_LOGIC;
         FPA_DIGIO4     : out STD_LOGIC;
         FPA_DIGIO5     : out STD_LOGIC;
         FPA_DIGIO6     : out STD_LOGIC;
         FPA_DIGIO7     : out STD_LOGIC;
         FPA_DIGIO8     : out STD_LOGIC;
         FPA_DIGIO9     : out STD_LOGIC;
         FPA_ON         : out STD_LOGIC );
   end component;
   
   constant CLK_100M_PERIOD         : time := 10 ns;
   constant MCLK_SOURCE_PERIOD      : time := 12.5 ns;
   constant FPA_MCLK_PERIOD         : time := 200 ns;
   constant trig_period             : time := 100 us;
   
   constant xsize : natural := 320;
   constant ysize : natural := 256;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ACQ_TRIG : STD_LOGIC;
   signal ARESET : STD_LOGIC;
   signal CLK_100M : STD_LOGIC  := '0';
   signal FPA_DIGIO11 : STD_LOGIC;
   signal FPA_DIGIO12 : STD_LOGIC;
   signal FPA_EXP_INFO : exp_info_type;
   signal FPA_MCLK : STD_LOGIC := '0';
   signal MB_CLK : STD_LOGIC;
   signal MCLK_SOURCE : STD_LOGIC := '0';
   signal READOUT : STD_LOGIC;
   signal XTRA_TRIG : STD_LOGIC;
   -- Observed signals - signals mapped to the output ports of tested entity
   signal ERR_FOUND : STD_LOGIC;
   signal FPA_DIGIO1 : STD_LOGIC;
   signal FPA_DIGIO10 : STD_LOGIC;
   signal FPA_DIGIO2 : STD_LOGIC;
   signal FPA_DIGIO3 : STD_LOGIC;
   signal FPA_DIGIO4 : STD_LOGIC;
   signal FPA_DIGIO5 : STD_LOGIC;
   signal FPA_DIGIO6 : STD_LOGIC;
   signal FPA_DIGIO7 : STD_LOGIC;
   signal FPA_DIGIO8 : STD_LOGIC;
   signal FPA_DIGIO9 : STD_LOGIC;
   signal FPA_ON : STD_LOGIC;
   signal FPA_INTF_CFG : fpa_intf_cfg_type;
   signal trig : std_logic := '0';
   
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
   U1: process(CLK_100M)
   begin
      CLK_100M <= not CLK_100M after CLK_100M_PERIOD/2; 
   end process; 
   MB_CLK <= CLK_100M;
   
   -- clk
   U2: process(MCLK_SOURCE)
   begin
      MCLK_SOURCE <= not MCLK_SOURCE after MCLK_SOURCE_PERIOD/2; 
   end process;
   
   -- clk
   U3: process(FPA_MCLK)
   begin
      FPA_MCLK <= not FPA_MCLK after FPA_MCLK_PERIOD/2; 
   end process;
   
   U4: process(trig)
   begin
      trig <= not trig after trig_PERIOD/2; 
   end process;
   ACQ_TRIG <= trig;
   
   FPA_EXP_INFO.exp_time <=  to_unsigned(100, 32);
   FPA_EXP_INFO.exp_indx <=  x"05";
   FPA_EXP_INFO.exp_dval <= '1';
   XTRA_TRIG <= '0'; 
   READOUT <=  FPA_MCLK; 
   
   
   FPA_INTF_CFG.COMN.FPA_DIAG_TYPE <= DEFINE_TELOPS_DIAG_DEGR;
   FPA_INTF_CFG.DIAG_TIR <= to_unsigned(6, FPA_INTF_CFG.DIAG_TIR'length);
   FPA_INTF_CFG.XSIZE_DIV_TAPNUM <= to_unsigned(xsize/16, FPA_INTF_CFG.XSIZE_DIV_TAPNUM'length);
   FPA_INTF_CFG.YSIZE <= to_unsigned(ysize, FPA_INTF_CFG.YSIZE'length);
   FPA_INTF_CFG.COMN.FPA_DIAG_MODE <= '1';
   FPA_INTF_CFG.DIAG_ACTIVE_PIXEL_DLY <= to_unsigned(11, FPA_INTF_CFG.DIAG_ACTIVE_PIXEL_DLY'length);  -- ajutsé via simulation
   FPA_INTF_CFG.IMG_SAMP_NUM <= to_unsigned(4*xsize*ysize, FPA_INTF_CFG.IMG_SAMP_NUM'length);
   FPA_INTF_CFG.IMG_SAMP_NUM_PER_CH <= to_unsigned(4*xsize*ysize/16, FPA_INTF_CFG.IMG_SAMP_NUM_PER_CH'length);
   FPA_INTF_CFG.SOF_SAMP_POS_END_PER_CH <= to_unsigned(4, FPA_INTF_CFG.SOF_SAMP_POS_END_PER_CH'length);
   FPA_INTF_CFG.EOF_SAMP_POS_START_PER_CH <= to_unsigned(4*xsize*ysize/16-4, FPA_INTF_CFG.EOF_SAMP_POS_END_PER_CH'length);
   FPA_INTF_CFG.GOOD_SAMP_FIRST_POS_PER_CH <= to_unsigned(1, FPA_INTF_CFG.GOOD_SAMP_FIRST_POS_PER_CH'length);
   FPA_INTF_CFG.GOOD_SAMP_LAST_POS_PER_CH <= to_unsigned(4, FPA_INTF_CFG.GOOD_SAMP_LAST_POS_PER_CH'length);
   FPA_INTF_CFG.PIX_SAMP_NUM_PER_CH <= to_unsigned(4, FPA_INTF_CFG.PIX_SAMP_NUM_PER_CH'length);
   FPA_INTF_CFG.GOOD_SAMP_SUM_NUM <= to_unsigned(4, FPA_INTF_CFG.GOOD_SAMP_SUM_NUM'length);
   FPA_INTF_CFG.GOOD_SAMP_MEAN_NUMERATOR <= to_unsigned(1, FPA_INTF_CFG.GOOD_SAMP_MEAN_NUMERATOR'length);
   FPA_INTF_CFG.GOOD_SAMP_MEAN_DIV_BIT_POS <= to_unsigned(2, FPA_INTF_CFG.GOOD_SAMP_MEAN_DIV_BIT_POS'length); -- log2(2) pour une division par 2
   FPA_INTF_CFG.XSTART <= (others => '0');
   FPA_INTF_CFG.YSTART <= (others => '0');
   FPA_INTF_CFG.XSIZE  <= to_unsigned(xsize, FPA_INTF_CFG.YSIZE'length);
   FPA_INTF_CFG.YSIZE_DIV2_M1 <= to_unsigned(ysize/2-1, FPA_INTF_CFG.YSIZE_DIV2_M1'length);
   FPA_INTF_CFG.GAIN <= '0';
   FPA_INTF_CFG.ONCHIP_BIN_256 <= '0';
   FPA_INTF_CFG.ONCHIP_BIN_128 <= '0';
   FPA_INTF_CFG.INT_TIME <= to_unsigned(10, FPA_INTF_CFG.INT_TIME'length); 
   FPA_INTF_CFG.INT_SIGNAL_HIGH_TIME <= to_unsigned(8, FPA_INTF_CFG.int_signal_high_time'length);
   FPA_INTF_CFG.INT_INDX <= (others => '0');
   
   
   -- Unit Under Test port map
   UUT : fpa_isc0207_hw_driver_tb
   port map (
      ACQ_TRIG => ACQ_TRIG,
      ARESET => ARESET,
      CLK_100M => CLK_100M,
      FPA_DIGIO11 => FPA_DIGIO11,
      FPA_DIGIO12 => FPA_DIGIO12,
      FPA_EXP_INFO => FPA_EXP_INFO,
      FPA_INTF_CFG => FPA_INTF_CFG,
      FPA_MCLK => FPA_MCLK,
      MB_CLK => MB_CLK,
      MCLK_SOURCE => MCLK_SOURCE,
      READOUT => READOUT,
      XTRA_TRIG => XTRA_TRIG,
      ERR_FOUND => ERR_FOUND,
      FPA_DIGIO1 => FPA_DIGIO1,
      FPA_DIGIO10 => FPA_DIGIO10,
      FPA_DIGIO2 => FPA_DIGIO2,
      FPA_DIGIO3 => FPA_DIGIO3,
      FPA_DIGIO4 => FPA_DIGIO4,
      FPA_DIGIO5 => FPA_DIGIO5,
      FPA_DIGIO6 => FPA_DIGIO6,
      FPA_DIGIO7 => FPA_DIGIO7,
      FPA_DIGIO8 => FPA_DIGIO8,
      FPA_DIGIO9 => FPA_DIGIO9,
      FPA_ON => FPA_ON
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_fpa_isc0207_hw_driver_tb of fpa_isc0207_hw_driver_tb_tb is
   for TB_ARCHITECTURE
      for UUT : fpa_isc0207_hw_driver_tb
         use entity work.fpa_isc0207_hw_driver_tb(sch);
      end for;
   end for;
end TESTBENCH_FOR_fpa_isc0207_hw_driver_tb;

