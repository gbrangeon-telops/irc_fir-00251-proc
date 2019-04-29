library work;
use work.FPA_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity isc0207a_data_ctrl_tb is
end isc0207a_data_ctrl_tb;

architecture TB_ARCHITECTURE of isc0207a_data_ctrl_tb is
   -- Component declaration of the tested unit
   component isc0207a_data_ctrl
      port(
         ACQ_INT : in STD_LOGIC;
         ARESET : in STD_LOGIC;
         --CLK_100M : in STD_LOGIC;
         CLK_80M : in STD_LOGIC;
         FPA_INT : in STD_LOGIC;
         MCLK_SOURCE : in STD_LOGIC;
         QUAD1_DVAL : in STD_LOGIC;
         QUAD2_DVAL : in STD_LOGIC;
         QUAD3_DVAL : in STD_LOGIC;
         QUAD4_DVAL : in STD_LOGIC;
         DATA_MISO : in t_axi4_stream_miso;
         FPA_INTF_CFG : in fpa_intf_cfg_type;
         FRAME_ID : in STD_LOGIC_VECTOR(31 downto 0);
         HDER_MISO : in t_axi4_lite_miso;
         INT_INDX : in STD_LOGIC_VECTOR(7 downto 0);
         INT_TIME : in STD_LOGIC_VECTOR(31 downto 0);
         QUAD1_DATA : in STD_LOGIC_VECTOR(56 downto 0);
         QUAD2_DATA : in STD_LOGIC_VECTOR(56 downto 0);
         QUAD3_DATA : in STD_LOGIC_VECTOR(56 downto 0);
         QUAD4_DATA : in STD_LOGIC_VECTOR(56 downto 0);
         ADC_SYNC_FLAG : out STD_LOGIC;
         CFG_MISMATCH : out STD_LOGIC;
         DATA_PATH_DONE : out STD_LOGIC;
         FIFO_ERR : out STD_LOGIC;
         FPA_ASSUMP_ERR : out STD_LOGIC;
         READOUT : out STD_LOGIC;
         SPEED_ERR : out STD_LOGIC;
         DATA_MOSI : out t_axi4_stream_mosi32;
         DISPATCH_INFO : out img_info_type;
         HDER_MOSI : out t_axi4_lite_mosi );
   end component;
   
   constant CLK_100M_PERIOD         : time := 10.5 ns;
   constant MCLK_SOURCE_PERIOD      : time := 12.5 ns;
   constant FPA_INT_PERIOD          : time := 700 us;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal CLK_80M : STD_LOGIC;
   signal ACQ_INT : STD_LOGIC;
   signal ARESET : STD_LOGIC;
   signal CLK_100M : STD_LOGIC := '0';
   signal FPA_INTi : STD_LOGIC  := '0';
   signal FPA_INTii : STD_LOGIC;
   signal FPA_INT : STD_LOGIC;
   signal MCLK_SOURCE : STD_LOGIC := '0';
   signal QUAD1_DVAL : STD_LOGIC;
   signal QUAD2_DVAL : STD_LOGIC;
   signal QUAD3_DVAL : STD_LOGIC;
   signal QUAD4_DVAL : STD_LOGIC;
   signal DATA_MISO : t_axi4_stream_miso;
   signal FPA_INTF_CFG : fpa_intf_cfg_type;
   signal FRAME_ID : STD_LOGIC_VECTOR(31 downto 0);
   signal HDER_MISO : t_axi4_lite_miso;
   signal INT_INDX : STD_LOGIC_VECTOR(7 downto 0);
   signal INT_TIME : STD_LOGIC_VECTOR(31 downto 0);
   signal QUAD1_DATA : STD_LOGIC_VECTOR(56 downto 0);
   signal QUAD2_DATA : STD_LOGIC_VECTOR(56 downto 0);
   signal QUAD3_DATA : STD_LOGIC_VECTOR(56 downto 0);
   signal QUAD4_DATA : STD_LOGIC_VECTOR(56 downto 0);
   -- Observed signals - signals mapped to the output ports of tested entity
   signal ADC_SYNC_FLAG : STD_LOGIC;
   signal CFG_MISMATCH : STD_LOGIC;
   signal DATA_PATH_DONE : STD_LOGIC;
   signal FIFO_ERR : STD_LOGIC;
   signal FPA_ASSUMP_ERR : STD_LOGIC;
   signal READOUT : STD_LOGIC;
   signal SPEED_ERR : STD_LOGIC;
   signal DATA_MOSI : t_axi4_stream_mosi32;
   signal DISPATCH_INFO : img_info_type;
   signal HDER_MOSI : t_axi4_lite_mosi;
   constant xsize : natural := 320;
   constant ysize : natural := 256;
   
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
   
   -- clk
   U2: process(MCLK_SOURCE)
   begin
      MCLK_SOURCE <= not MCLK_SOURCE after MCLK_SOURCE_PERIOD/2; 
   end process;
   CLK_80M <= MCLK_SOURCE;
   
   -- clk
   U3: process(FPA_INTi)
   begin
      FPA_INTi <= not FPA_INTi after FPA_INT_PERIOD/2; 
   end process; 
   FPA_INTii <= transport FPA_INTi after 10 us;
   FPA_INT <= FPA_INTi and FPA_INTii;
   ACQ_INT <= FPA_INT; 
   INT_TIME <= resize(x"02",32);
   INT_INDX <= (others => '0');
   FRAME_ID <= (others => '0');
   
   --xsize <= 320;
   --ysize <= 256;
   
   FPA_INTF_CFG.COMN.FPA_DIAG_TYPE <= DEFINE_TELOPS_DIAG_DEGR;
   FPA_INTF_CFG.DIAG_TIR <= to_unsigned(6, FPA_INTF_CFG.DIAG_TIR'length);
   FPA_INTF_CFG.XSIZE_DIV_TAPNUM <= to_unsigned(xsize/16, FPA_INTF_CFG.XSIZE_DIV_TAPNUM'length);
   FPA_INTF_CFG.YSIZE <= to_unsigned(ysize, FPA_INTF_CFG.YSIZE'length);
   FPA_INTF_CFG.COMN.FPA_DIAG_MODE <= '1';
   FPA_INTF_CFG.DIAG_ACTIVE_PIXEL_DLY <= to_unsigned(2, FPA_INTF_CFG.DIAG_ACTIVE_PIXEL_DLY'length);  -- ajutsé via simulation
   FPA_INTF_CFG.IMG_SAMP_NUM <= to_unsigned(4*xsize*ysize, FPA_INTF_CFG.IMG_SAMP_NUM'length);
   FPA_INTF_CFG.IMG_SAMP_NUM_PER_CH <= to_unsigned(4*xsize*ysize/16, FPA_INTF_CFG.IMG_SAMP_NUM_PER_CH'length);
   FPA_INTF_CFG.SOF_SAMP_POS_END_PER_CH <= to_unsigned(4, FPA_INTF_CFG.SOF_SAMP_POS_END_PER_CH'length);
   FPA_INTF_CFG.EOF_SAMP_POS_START_PER_CH <= to_unsigned(4*xsize*ysize/16-4, FPA_INTF_CFG.EOF_SAMP_POS_END_PER_CH'length);
   FPA_INTF_CFG.GOOD_SAMP_FIRST_POS_PER_CH <= to_unsigned(1, FPA_INTF_CFG.GOOD_SAMP_FIRST_POS_PER_CH'length);
   FPA_INTF_CFG.GOOD_SAMP_LAST_POS_PER_CH <= to_unsigned(4, FPA_INTF_CFG.GOOD_SAMP_LAST_POS_PER_CH'length);
   FPA_INTF_CFG.PIX_SAMP_NUM_PER_CH <= to_unsigned(4, FPA_INTF_CFG.PIX_SAMP_NUM_PER_CH'length);
   FPA_INTF_CFG.GOOD_SAMP_SUM_NUM <= to_unsigned(4, FPA_INTF_CFG.GOOD_SAMP_SUM_NUM'length);
   FPA_INTF_CFG.GOOD_SAMP_MEAN_NUMERATOR <= to_unsigned(2**19, FPA_INTF_CFG.GOOD_SAMP_MEAN_NUMERATOR'length);
   FPA_INTF_CFG.GOOD_SAMP_MEAN_DIV_BIT_POS <= to_unsigned(21, FPA_INTF_CFG.GOOD_SAMP_MEAN_DIV_BIT_POS'length); 
   DATA_MISO.TREADY <= '1';  
   HDER_MISO.WREADY <= '1';
   HDER_MISO.AWREADY <= '1';
   
   -- Unit Under Test port map
   UUT : isc0207a_data_ctrl
   port map (
      ACQ_INT => ACQ_INT,
      ARESET => ARESET,
      --CLK_100M => CLK_100M,
      CLK_80M => CLK_80M,
      FPA_INT => FPA_INT,
      MCLK_SOURCE => MCLK_SOURCE,
      QUAD1_DVAL => QUAD1_DVAL,
      QUAD2_DVAL => QUAD2_DVAL,
      QUAD3_DVAL => QUAD3_DVAL,
      QUAD4_DVAL => QUAD4_DVAL,
      DATA_MISO => DATA_MISO,
      FPA_INTF_CFG => FPA_INTF_CFG,
      FRAME_ID => FRAME_ID,
      HDER_MISO => HDER_MISO,
      INT_INDX => INT_INDX,
      INT_TIME => INT_TIME,
      QUAD1_DATA => QUAD1_DATA,
      QUAD2_DATA => QUAD2_DATA,
      QUAD3_DATA => QUAD3_DATA,
      QUAD4_DATA => QUAD4_DATA,
      ADC_SYNC_FLAG => ADC_SYNC_FLAG,
      CFG_MISMATCH => CFG_MISMATCH,
      DATA_PATH_DONE => DATA_PATH_DONE,
      FIFO_ERR => FIFO_ERR,
      FPA_ASSUMP_ERR => FPA_ASSUMP_ERR,
      READOUT => READOUT,
      SPEED_ERR => SPEED_ERR,
      DATA_MOSI => DATA_MOSI,
      DISPATCH_INFO => DISPATCH_INFO,
      HDER_MOSI => HDER_MOSI
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_isc0207a_data_ctrl of isc0207a_data_ctrl_tb is
   for TB_ARCHITECTURE
      for UUT : isc0207a_data_ctrl
         use entity work.isc0207a_data_ctrl(isc0207a_data_ctrl);
      end for;
   end for;
end TESTBENCH_FOR_isc0207a_data_ctrl;

