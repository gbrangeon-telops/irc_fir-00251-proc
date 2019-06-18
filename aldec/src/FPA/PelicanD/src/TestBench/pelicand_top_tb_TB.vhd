
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.TEL2000.all;
use work.fpa_define.all;
use work.fpa_common_pkg.all;
use work.Proxy_define.all;

-- Add your library and packages declaration here ...

entity pelicand_top_tb_tB is
end pelicand_top_tb_tB;

architecture TB_ARCHITECTURE of pelicand_top_tb_tB is
   -- Component declaration of the tested unit
   component pelicand_top_tb
      port(
         ARESETN        : in std_logic;
         CLK_100M       : in std_logic;
         
         -- intf avec le trigger
         ACQ_TRIG       : in std_logic;
         XTRA_TRIG      : in std_logic;
         
         -- reconnaissance ddc et allumage detecteur
         DET_FREQ_ID    : in std_logic;
         DET_FPA_ON     : out std_logic;
         
         -- contrôle proxy                   
         DET_SPARE_N0   : in std_logic;
         DET_SPARE_N1   : in std_logic;
         DET_SPARE_N2   : in std_logic;
         DET_SPARE_P0   : in std_logic;
         DET_SPARE_P1   : in std_logic;
         DET_SPARE_P2   : in std_logic;
         DET_CC_N1      : out std_logic;
         DET_CC_N2      : out std_logic;
         DET_CC_N3      : out std_logic;
         DET_CC_N4      : out std_logic;
         DET_CC_P1      : out std_logic;
         DET_CC_P2      : out std_logic;
         DET_CC_P3      : out std_logic;
         DET_CC_P4      : out std_logic;
         SER_TFG_N      : in std_logic;
         SER_TFG_P      : in std_logic;
         FSYNC_N        : out std_logic;
         FSYNC_P        : out std_logic;
         SER_TC_N       : out std_logic;
         SER_TC_P       : out std_logic;
         
         -- Proxy : feedback integration
         INT_FBK_N      : in std_logic;
         INT_FBK_P      : in std_logic;
         
         -- entree des données
         DOUT_CLK       : in std_logic; 
         
         -- Clink in
         FPA_CH1_DATA   : in std_logic_vector(27 downto 0);
         FPA_CH2_DATA   : in std_logic_vector(27 downto 0);
         FPA_CH1_CLK    : in std_logic;
         FPA_CH2_CLK    : in std_logic;   
         
         -- temps d'intégration
         FPA_EXP_INFO   : in exp_info_type;
         
         -- sortie pixels                 
         DOUT_MOSI      : out t_axi4_stream_mosi64;
         DOUT_MISO      : in t_axi4_stream_miso;
         
         --infos vers les modules externes
         IMAGE_INFO     : out img_info_type;
         
         -- header part
         HDER_MOSI      : out t_axi4_lite_mosi;
         HDER_MISO      : in t_axi4_lite_miso;
         
         -- microblaze CLK
         MB_CLK         : in std_logic; 
         
         -- erreur 
         ERR_FOUND      : out std_logic
         );
   end component;
   
  
   constant MB_CLK_PERIOD      : time := 10ns;
   constant ACQ_TRIG_PERIOD    : time := 1us;
   constant DET_FREQ_ID_PERIOD : time := 0.333ms;
   constant DOUT_CLK_PERIOD    : time := 6.25ns;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ACQ_TRIG      : std_logic;
   signal XTRA_TRIG     : std_logic := '0'; 
   signal ARESETN       : std_logic;
   signal CLK_100M      :  std_logic;
   signal DET_FREQ_ID   : std_logic := '0';
   signal DET_SPARE_N0  : std_logic;
   signal DET_SPARE_N1  : std_logic;
   signal DET_SPARE_N2  : std_logic;
   signal DET_SPARE_P0  : std_logic;
   signal DET_SPARE_P1  : std_logic;
   signal DET_SPARE_P2  : std_logic;
   signal DOUT_CLK      : std_logic := '0';
   signal FPA_CH1_CLK   : std_logic;
   signal FPA_CH2_CLK   : std_logic;
   signal FPA_EXP_INFO  : exp_info_type;
   signal INT_FBK_N     : std_logic;
   signal INT_FBK_P     : std_logic;
   signal MB_CLK        : std_logic := '0';
   signal SER_TFG_N     : std_logic;
   signal SER_TFG_P     : std_logic;
   signal DOUT_MISO     : t_axi4_stream_miso;
   signal FPA_CH1_DATA  : std_logic_vector(27 downto 0);
   signal FPA_CH2_DATA  : std_logic_vector(27 downto 0);
   signal HDER_MISO     : t_axi4_lite_miso;
   -- Observed signals - signals mapped to the output ports of tested entity
   signal DET_CC_N1     : std_logic;
   signal DET_CC_N2     : std_logic;
   signal DET_CC_N3     : std_logic;
   signal DET_CC_N4     : std_logic;
   signal DET_CC_P1     : std_logic;
   signal DET_CC_P2     : std_logic;
   signal DET_CC_P3     : std_logic;
   signal DET_CC_P4     : std_logic;
   signal DET_FPA_ON    : std_logic;
   signal ERR_FOUND     : std_logic;
   signal FSYNC_N       : std_logic;
   signal FSYNC_P       : std_logic;
   signal SER_TC_N      : std_logic;
   signal SER_TC_P      : std_logic;
   signal DOUT_MOSI     : t_axi4_stream_mosi64;
   signal HDER_MOSI     : t_axi4_lite_mosi;
   signal IMAGE_INFO    : img_info_type;
   
   -- Add your code here ...
   
begin
   
   -- MB Clk
   U1: process(MB_CLK)
   begin
      MB_CLK <= not MB_CLK after MB_CLK_PERIOD/2; 
   end process;
   CLK_100M <= transport MB_CLK after 2ns;
   
   -- trig
   ACQ_TRIG <= '1';
   XTRA_TRIG <= '0'; 
   
   -- ARESETN
   U2: process
   begin
      ARESETN <= '0'; 
      wait for 250 ns;
      ARESETN <= '1';
      wait;
   end process;
   
   -- DET_FREQ_ID
   U3: process(DET_FREQ_ID)                     
   begin                                   
      DET_FREQ_ID <= not DET_FREQ_ID after DET_FREQ_ID_PERIOD/2;
   end process;
   
   -- SER_TFG   
   SER_TFG_N <= SER_TC_N when SER_TC_N /= 'Z' else '0';
   SER_TFG_P <= SER_TC_P when SER_TC_N /= 'Z' else '1';
   
   -- iNT FEEDBCK
   INT_FBK_N <= '1';--FSYNC_N;
   INT_FBK_P <= '0';--FSYNC_P;
   
   -- DOUT_CLK
   U4: process(DOUT_CLK)
   begin
      DOUT_CLK <= not DOUT_CLK after DOUT_CLK_PERIOD/2; 
   end process;
   
   -- DOUT_MISO
   DOUT_MISO.TREADY <= '1';
   
   -- temps d'intégration
   FPA_EXP_INFO.exp_time <= to_unsigned(20, FPA_EXP_INFO.exp_time'length);
   FPA_EXP_INFO.exp_indx <= (others =>'0');
   FPA_EXP_INFO.exp_dval <= '1';
   
   -- HDER_MISO
   HDER_MISO.AWREADY <= '1';
   HDER_MISO.WREADY <= '1';
   
   -- Unit Under Test port map
   UUT : pelicand_top_tb
   port map (
      ACQ_TRIG => ACQ_TRIG,
      ARESETN => ARESETN,
      CLK_100M => CLK_100M,
      DET_FREQ_ID => DET_FREQ_ID,
      DET_SPARE_N0 => DET_SPARE_N0,
      DET_SPARE_N1 => DET_SPARE_N1,
      DET_SPARE_N2 => DET_SPARE_N2,
      DET_SPARE_P0 => DET_SPARE_P0,
      DET_SPARE_P1 => DET_SPARE_P1,
      DET_SPARE_P2 => DET_SPARE_P2,
      DOUT_CLK => DOUT_CLK,
      DOUT_MISO => DOUT_MISO,
      FPA_CH1_CLK => FPA_CH1_CLK,
      FPA_CH2_CLK => FPA_CH2_CLK,
      FPA_EXP_INFO => FPA_EXP_INFO,
      HDER_MISO => HDER_MISO,
      INT_FBK_N => INT_FBK_N,
      INT_FBK_P => INT_FBK_P,
      MB_CLK => MB_CLK,
      SER_TFG_N => SER_TFG_N,
      SER_TFG_P => SER_TFG_P,
      XTRA_TRIG => XTRA_TRIG,
      FPA_CH1_DATA => FPA_CH1_DATA,
      FPA_CH2_DATA => FPA_CH2_DATA,
      DET_CC_N1 => DET_CC_N1,
      DET_CC_N2 => DET_CC_N2,
      DET_CC_N3 => DET_CC_N3,
      DET_CC_N4 => DET_CC_N4,
      DET_CC_P1 => DET_CC_P1,
      DET_CC_P2 => DET_CC_P2,
      DET_CC_P3 => DET_CC_P3,
      DET_CC_P4 => DET_CC_P4,
      DET_FPA_ON => DET_FPA_ON,
      DOUT_MOSI => DOUT_MOSI,
      ERR_FOUND => ERR_FOUND,
      FSYNC_N => FSYNC_N,
      FSYNC_P => FSYNC_P,
      HDER_MOSI => HDER_MOSI,
      IMAGE_INFO => IMAGE_INFO,
      SER_TC_N => SER_TC_N,
      SER_TC_P => SER_TC_P
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_pelicand_top_tb of pelicand_top_tb_tB is
   for TB_ARCHITECTURE
      for UUT : pelicand_top_tb
         use entity work.pelicand_top_tb(sch);
      end for;
   end for;
end TESTBENCH_FOR_pelicand_top_tb;

