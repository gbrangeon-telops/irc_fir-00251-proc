library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FPA_define.all;
use work.proxy_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;


-- Add your library and packages declaration here ...

entity bb1920_deserializer_tb_tb is
end bb1920_deserializer_tb_tb;

architecture TB_ARCHITECTURE of bb1920_deserializer_tb_tb is
   -- Component declaration of the tested unit
   component bb1920_deserializer_tb
      port(
	  	ACQ_INT        : in STD_LOGIC;	
	  	EN_0        	: in STD_LOGIC;
	  	EN_1        	: in STD_LOGIC;
         ARESET         : in STD_LOGIC;
         CLK200         : in STD_LOGIC;
         DCLK_1X        : in STD_LOGIC;
         DCLK_8X        : in STD_LOGIC;
         DOUT_CLK       : in STD_LOGIC;
         MCLK_SOURCE    : in STD_LOGIC;
         FPA_INTF_CFG   : in fpa_intf_cfg_type );
   end component;
   
   
   constant XSIZE            : integer := 960;
   constant YSIZE            : integer := 768;  
   constant AOI_FLAG1_SOL_POS   : integer := 1;	
   constant AOI_FLAG1_EOL_POS   : integer := 479; 
   constant AOI_FLAG2_SOL_POS   : integer := 480;	
   constant AOI_FLAG2_EOL_POS   : integer := 480;
   constant DIAG_YSIZE   		: integer := 192;
   constant DIAG_XSIZE   		: integer := 480 ;
   constant CLK200_PERIOD    : time := 5 ns;
   constant DOUT_CLK_PERIOD  : time := 10 ns;
   constant DCLK_1X_PERIOD   : time := 14.288 ns;
   constant DCLK_8X_PERIOD   : time :=  1.786 ns;
   constant ACQ_INT_PERIOD   : time :=  (XSIZE/4 + 10)*YSIZE * DCLK_1X_PERIOD;
      
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ACQ_INTi      : STD_LOGIC := '0';
   signal ACQ_INTii     : STD_LOGIC := '0';
   signal ACQ_INT       : STD_LOGIC := '0';
   signal ARESET        : STD_LOGIC;
   signal CLK200        : STD_LOGIC := '0';
   signal DCLK_1X       : STD_LOGIC := '0';
   signal DCLK_8X       : STD_LOGIC := '0';
   signal DOUT_CLK      : STD_LOGIC := '0';
   signal MCLK_SOURCE   : STD_LOGIC := '0';
   signal FPA_INTF_CFG  : fpa_intf_cfg_type;
   signal EN_0 			: STD_LOGIC := '0';
   signal EN_1 			: STD_LOGIC := '0';	 
   signal binning_mode  : std_logic_vector(1 downto 0) := "00";	
   -- Observed signals - signals mapped to the output ports of tested entity
   
   -- Add your code here ...
   
begin
   
   -- reset
   U0: process
   begin
      ARESET <= '1'; 
      wait for 250 ns;
      ARESET <= '0';
      wait;
   end process;
   
   -- ACQ_INT
   --U01: process(ACQ_INTi)	 
   U01: process
   begin
      --ACQ_INTi <= not ACQ_INTi after ACQ_INT_PERIOD/2; 
	  -- config 
   	  binning_mode <= "00";
	  wait for 1 ms;
	  ACQ_INTi <= '1';
	  wait for 1000 ns;
	  ACQ_INTi <= '0';
	  wait for 10 ms;
	  binning_mode <= "01";
	  wait for 100 ns;
	  ACQ_INTi <= '1';
	  wait for 1000 ns;
	  ACQ_INTi <= '0'; 
	  wait for 15 ms;
   end process;
   --ACQ_INTii <= transport ACQ_INTi after 1000 ns;
   
   --ACQ_INT <= ACQ_INTi and not ACQ_INTii;
   ACQ_INT <= ACQ_INTi ;
   -- CLK200
   U1: process(CLK200)
   begin
      CLK200 <= not CLK200 after CLK200_PERIOD/2; 
   end process;
   
   -- DOUT_CLK
   U2: process(DOUT_CLK)
   begin
      DOUT_CLK <= not DOUT_CLK after DOUT_CLK_PERIOD/2; 
   end process; 
   
   -- DCLK_1X
   U3: process(DCLK_1X)
   begin
      DCLK_1X <= not DCLK_1X after DCLK_1X_PERIOD/2; 
   end process;
   MCLK_SOURCE <= DCLK_1X;
   
   -- DCLK_8X
   U4: process(DCLK_8X)
   begin
      DCLK_8X <= not DCLK_8X after DCLK_8X_PERIOD/2; 
   end process; 
   
   EN_0 <= '1' ;
   EN_1 <= '1' ;
   
   FPA_INTF_CFG.OP.BINNING <= binning_mode;
   
   --FPA_INTF_CFG.COMN.FPA_DIAG_TYPE <= DEFINE_TELOPS_DIAG_CNST;	 
   FPA_INTF_CFG.COMN.FPA_DIAG_TYPE <= DEFINE_TELOPS_DIAG_DEGR_DYN;
   FPA_INTF_CFG.COMN.fpa_diag_mode            <= '1';
   FPA_INTF_CFG.COMN.fpa_diag_type            <= DEFINE_TELOPS_DIAG_DEGR;
   FPA_INTF_CFG.AOI_FLAG1.SOL_POS                   <= to_unsigned(AOI_FLAG1_SOL_POS,  FPA_INTF_CFG.AOI_FLAG1.SOL_POS'LENGTH);                 
   FPA_INTF_CFG.AOI_FLAG1.EOL_POS          <= to_unsigned(AOI_FLAG1_EOL_POS, FPA_INTF_CFG.AOI_FLAG1.EOL_POS'LENGTH);  
   FPA_INTF_CFG.AOI_FLAG2.SOL_POS                    <= to_unsigned(AOI_FLAG2_SOL_POS, FPA_INTF_CFG.AOI_FLAG2.SOL_POS'LENGTH);                 
   FPA_INTF_CFG.AOI_FLAG2.EOL_POS         <= to_unsigned(AOI_FLAG2_SOL_POS, FPA_INTF_CFG.AOI_FLAG2.EOL_POS'LENGTH);
   
   FPA_INTF_CFG.DIAG.YSIZE                    <= to_unsigned(DIAG_YSIZE, FPA_INTF_CFG.DIAG.YSIZE'LENGTH);                 
   FPA_INTF_CFG.DIAG.XSIZE_DIV_TAPNUM         <= to_unsigned(DIAG_XSIZE, FPA_INTF_CFG.DIAG.XSIZE_DIV_TAPNUM'LENGTH);
   FPA_INTF_CFG.DIAG.LOVH_MCLK_SOURCE         <= to_unsigned(3, FPA_INTF_CFG.DIAG.LOVH_MCLK_SOURCE'LENGTH);
   FPA_INTF_CFG.REAL_MODE_ACTIVE_PIXEL_DLY    <= to_unsigned(8, FPA_INTF_CFG.REAL_MODE_ACTIVE_PIXEL_DLY'LENGTH);
   
   FPA_INTF_CFG.fpa_serdes_lval_num           <= to_unsigned(YSIZE, FPA_INTF_CFG.fpa_serdes_lval_num'LENGTH);
   FPA_INTF_CFG.fpa_serdes_lval_len           <= to_unsigned(XSIZE/4, FPA_INTF_CFG.fpa_serdes_lval_len'LENGTH);
   
   --FPA_INTF_CFG.vid_if_bit_en		 			<= '1' ; 
   FPA_INTF_CFG.REAL_MODE_ACTIVE_PIXEL_DLY <= to_unsigned(8, 16);
   
   -- -- FPA_INTF_CFG.OP.BINNING <= transport "01" after 8000 ns;
   -- Unit Under Test port map
   UUT : bb1920_deserializer_tb
   port map (
   	  ACQ_INT        => ACQ_INT,
      EN_0           => EN_0,
      EN_1           => EN_1,
      ARESET         => ARESET,
      CLK200         => CLK200,
      DCLK_1X        => DCLK_1X,
      DCLK_8X        => DCLK_8X,
      DOUT_CLK       => DOUT_CLK,
      MCLK_SOURCE    => MCLK_SOURCE,
      FPA_INTF_CFG   => FPA_INTF_CFG
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_bb1920_deserializer_tb of bb1920_deserializer_tb_tb is
   for TB_ARCHITECTURE
      for UUT : bb1920_deserializer_tb
         use entity work.bb1920_deserializer_tb(sch);
      end for;
   end for;
end TESTBENCH_FOR_bb1920_deserializer_tb;

