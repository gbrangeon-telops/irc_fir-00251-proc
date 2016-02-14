library work;
use work.FPA_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity fpa_isc0207_intf_tb_tb is
end fpa_isc0207_intf_tb_tb;

architecture TB_ARCHITECTURE of fpa_isc0207_intf_tb_tb is
   -- Component declaration of the tested unit
   component fpa_isc0207_intf_tb
      port(
         ARESET      : in STD_LOGIC;
         CLK_100M    : in STD_LOGIC;
         CLK_80M     : in STD_LOGIC;
         DISABLE_QUAD_CLK_DEFAULT : in STD_LOGIC;
         SPI_SDO     : in STD_LOGIC;
         FPA_MCLK    : out STD_LOGIC;
         QUAD1_CLK   : out STD_LOGIC;
         QUAD2_CLK   : out STD_LOGIC;
         QUAD3_CLK   : out STD_LOGIC;
         QUAD4_CLK   : out STD_LOGIC;
         SPI_CSN     : out STD_LOGIC;
         SPI_MUX0    : out STD_LOGIC;
         SPI_MUX1    : out STD_LOGIC;
         SPI_SCLK    : out STD_LOGIC;
         SPI_SDI     : out STD_LOGIC );
   end component;
   
   
   constant CLK_100M_PERIOD         : time := 10 ns;
   constant CLK_80M_PERIOD          : time := 12.5 ns; 
   constant SPI_SDO_PERIOD          : time := 100 us;
   
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ARESET : STD_LOGIC;
   signal CLK_100M : STD_LOGIC := '0';
   signal CLK_80M : STD_LOGIC  := '0';
   signal DISABLE_QUAD_CLK_DEFAULT : STD_LOGIC;
   signal SPI_SDO : STD_LOGIC := '0';
   -- Observed signals - signals mapped to the output ports of tested entity
   signal FPA_MCLK : STD_LOGIC;
   signal QUAD1_CLK : STD_LOGIC;
   signal QUAD2_CLK : STD_LOGIC;
   signal QUAD3_CLK : STD_LOGIC;
   signal QUAD4_CLK : STD_LOGIC;
   signal SPI_CSN : STD_LOGIC;
   signal SPI_MUX0 : STD_LOGIC;
   signal SPI_MUX1 : STD_LOGIC;
   signal SPI_SCLK : STD_LOGIC;
   signal SPI_SDI : STD_LOGIC;
   
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
   U2: process(CLK_80M)
   begin
      CLK_80M <= not CLK_80M after CLK_80M_PERIOD/2; 
   end process;
   
         -- SPI_SDO
   U3: process(SPI_SDO)
   begin
      SPI_SDO <= not SPI_SDO after SPI_SDO_PERIOD/2; 
   end process;
   
   DISABLE_QUAD_CLK_DEFAULT  <= '0';
   
   -- Unit Under Test port map
   UUT : fpa_isc0207_intf_tb
   port map (
      ARESET => ARESET,
      CLK_100M => CLK_100M,
      CLK_80M => CLK_80M,
      DISABLE_QUAD_CLK_DEFAULT => DISABLE_QUAD_CLK_DEFAULT,
      SPI_SDO => SPI_SDO,
      FPA_MCLK => FPA_MCLK,
      QUAD1_CLK => QUAD1_CLK,
      QUAD2_CLK => QUAD2_CLK,
      QUAD3_CLK => QUAD3_CLK,
      QUAD4_CLK => QUAD4_CLK,
      SPI_CSN => SPI_CSN,
      SPI_MUX0 => SPI_MUX0,
      SPI_MUX1 => SPI_MUX1,
      SPI_SCLK => SPI_SCLK,
      SPI_SDI => SPI_SDI
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_fpa_isc0207_intf_tb of fpa_isc0207_intf_tb_tb is
   for TB_ARCHITECTURE
      for UUT : fpa_isc0207_intf_tb
         use entity work.fpa_isc0207_intf_tb(fpa_isc0207_intf_tb);
      end for;
   end for;
end TESTBENCH_FOR_fpa_isc0207_intf_tb;

