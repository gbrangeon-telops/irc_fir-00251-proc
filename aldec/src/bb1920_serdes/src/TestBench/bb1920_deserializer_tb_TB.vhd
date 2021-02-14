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
         ARESET         : in STD_LOGIC;
         CLK200         : in STD_LOGIC;
         DCLK_1X        : in STD_LOGIC;
         DCLK_8X        : in STD_LOGIC;
         DOUT_CLK       : in STD_LOGIC;
         MCLK_SOURCE    : in STD_LOGIC;
         FPA_INTF_CFG   : in fpa_intf_cfg_type );
   end component;
   
   
   constant XSIZE            : integer := 128;
   constant YSIZE            : integer := 4;  
   
   constant CLK200_PERIOD    : time := 5 ns;
   constant DOUT_CLK_PERIOD  : time := 10 ns;
   constant DCLK_1X_PERIOD   : time := 14.288 ns;
   constant DCLK_8X_PERIOD   : time :=  1.786 ns;
      
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ACQ_INT       : STD_LOGIC;
   signal ARESET        : STD_LOGIC;
   signal CLK200        : STD_LOGIC;
   signal DCLK_1X       : STD_LOGIC := '0';
   signal DCLK_8X       : STD_LOGIC := '0';
   signal DOUT_CLK      : STD_LOGIC := '0';
   signal MCLK_SOURCE   : STD_LOGIC := '0';
   signal FPA_INTF_CFG  : fpa_intf_cfg_type;
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
   
   ACQ_INT <= '1';
   
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
   
   -- config
   FPA_INTF_CFG.COMN.FPA_DIAG_TYPE <= DEFINE_TELOPS_DIAG_CNST;
   FPA_INTF_CFG.COMN.fpa_diag_mode            <= '1';
   FPA_INTF_CFG.COMN.fpa_diag_type            <= DEFINE_TELOPS_DIAG_DEGR;
   
   FPA_INTF_CFG.DIAG.YSIZE                    <= to_unsigned(YSIZE, 32);                 
   FPA_INTF_CFG.DIAG.XSIZE_DIV_TAPNUM         <= to_unsigned(XSIZE/4, 32);
   FPA_INTF_CFG.DIAG.LOVH_MCLK_SOURCE         <= to_unsigned(3, 32);
   FPA_INTF_CFG.REAL_MODE_ACTIVE_PIXEL_DLY    <= to_unsigned(8, 32);
   
   FPA_INTF_CFG.fpa_serdes_lval_num           <= to_unsigned(YSIZE, FPA_INTF_CFG.fpa_serdes_lval_num'LENGTH);
   FPA_INTF_CFG.fpa_serdes_lval_len           <= to_unsigned(XSIZE/4, FPA_INTF_CFG.fpa_serdes_lval_len'LENGTH);
   
   
   -- Unit Under Test port map
   UUT : bb1920_deserializer_tb
   port map (
      ACQ_INT        => ACQ_INT,
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

