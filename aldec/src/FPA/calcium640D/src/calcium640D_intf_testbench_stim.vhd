
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

library work;
use work.FPA_define.all;
use work.proxy_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
use work.calcium640D_intf_testbench_pkg.all;


entity calcium640D_intf_testbench_stim is
end calcium640D_intf_testbench_stim;

architecture TB_ARCHITECTURE of calcium640D_intf_testbench_stim is
   
   component calcium640D_intf_testbench
      port (
         ACQ_TRIG : in STD_LOGIC;
         ARESET : in STD_LOGIC;
         CLK_100M : in STD_LOGIC;
         MB_CLK : in STD_LOGIC;
         ROIC_MISO : in STD_LOGIC;
         RX_CLK : in STD_LOGIC;
         RX_RDY : in STD_LOGIC;
         XTRA_TRIG : in STD_LOGIC;
         DOUT_MISO : in t_axi4_stream_miso;
         FPA_EXP_INFO : in exp_info_type;
         HDER_MISO : in t_axi4_lite_miso;
         MB_MOSI : in t_axi4_lite_mosi;
         RX_DATA : in STD_LOGIC_VECTOR(191 downto 0);
         CLK_DDR_N : out STD_LOGIC;
         CLK_DDR_P : out STD_LOGIC;
         CLK_FRM : out STD_LOGIC;
         CLK_RD : out STD_LOGIC;
         DAC_CSN : out STD_LOGIC;
         DAC_SCLK : out STD_LOGIC;
         DAC_SD : out STD_LOGIC;
         DOUT_CLK : out STD_LOGIC;
         ERR_FOUND : out STD_LOGIC;
         FPA_HDER_CLK : out STD_LOGIC;
         FPA_ON : out STD_LOGIC;
         PIXQNB_EN : out STD_LOGIC;
         POCAN_RESET : out STD_LOGIC;
         ROIC_MOSI : out STD_LOGIC;
         ROIC_SCLK : out STD_LOGIC;
         DOUT_MOSI : out t_axi4_stream_mosi128;
         HDER_MOSI : out t_axi4_lite_mosi;
         IMAGE_INFO : out img_info_type;
         MB_MISO : out t_axi4_lite_miso
      );
   end component;
   
   constant CLK_100M_PERIOD         : time := 10 ns;
   constant ACQ_TRIG_PERIOD         : time := 4 ms;
   
   constant DIAG_MODE_CFG1          : std_logic := '1';
   constant XSIZE_CFG1              : natural := 64;
   constant YSIZE_CFG1              : natural := 2;
   signal user_cfg_vector1          : unsigned(USER_CFG_VECTOR_SIZE*32-1 downto 0) := to_intf_cfg(DIAG_MODE_CFG1, XSIZE_CFG1, YSIZE_CFG1, 1);
   
   constant DIAG_MODE_CFG2          : std_logic := '1';
   constant XSIZE_CFG2              : natural := 640;
   constant YSIZE_CFG2              : natural := 512;
   signal user_cfg_vector2          : unsigned(USER_CFG_VECTOR_SIZE*32-1 downto 0) := to_intf_cfg(DIAG_MODE_CFG2, XSIZE_CFG2, YSIZE_CFG2, 2);
   
   constant FPA_SOFTW_STAT_FPA_ROIC    : std_logic_vector(7 downto 0) := FPA_ROIC_CALCIUM;
   constant FPA_SOFTW_STAT_FPA_OUTPUT  : std_logic_vector(1 downto 0) := OUTPUT_DIGITAL;
   constant FPA_SOFTW_STAT_FPA_INPUT   : std_logic_vector(7 downto 0) := LVCMOS18;
   constant FPA_SOFTW_STAT_BASE_ADD    : natural := to_integer(unsigned(x"AE0"));
   
   constant VDAC_VALUE              : unsigned(31 downto 0) := to_unsigned(4005, 32);    -- x"FA5" all DACs to the same value
   constant DAC_CFG_BASE_ADD        : natural := to_integer(unsigned(x"D00"));
   constant DAC_CFG_VECTOR_SIZE     : natural := 8;
   
   signal ACQ_TRIG : STD_LOGIC;
   signal ARESET : STD_LOGIC;
   signal CLK_100M : STD_LOGIC := '0';
   signal MB_CLK : STD_LOGIC;
   signal ROIC_MISO : STD_LOGIC;       -- À implémenter !!!
   signal RX_CLK : STD_LOGIC;
   signal RX_RDY : STD_LOGIC;
   signal XTRA_TRIG : STD_LOGIC := '0';
   signal DOUT_MISO : t_axi4_stream_miso;
   signal FPA_EXP_INFO : exp_info_type;
   signal HDER_MISO : t_axi4_lite_miso;
   signal MB_MOSI : t_axi4_lite_mosi;
   signal RX_DATA : STD_LOGIC_VECTOR(191 downto 0);   -- À implémenter !!!
   signal CLK_DDR_N : STD_LOGIC;
   signal CLK_DDR_P : STD_LOGIC;
   signal CLK_FRM : STD_LOGIC;
   signal CLK_RD : STD_LOGIC;
   signal DAC_CSN : STD_LOGIC;
   signal DAC_SCLK : STD_LOGIC;
   signal DAC_SD : STD_LOGIC;
   signal DOUT_CLK : STD_LOGIC;
   signal ERR_FOUND : STD_LOGIC;
   signal FPA_HDER_CLK : STD_LOGIC;
   signal FPA_ON : STD_LOGIC;
   signal PIXQNB_EN : STD_LOGIC;
   signal POCAN_RESET : STD_LOGIC;
   signal ROIC_MOSI : STD_LOGIC;
   signal ROIC_SCLK : STD_LOGIC;
   signal DOUT_MOSI : t_axi4_stream_mosi128;
   signal HDER_MOSI : t_axi4_lite_mosi;
   signal IMAGE_INFO : img_info_type;
   signal MB_MISO : t_axi4_lite_miso;
   
begin
   
   -- Constant assignments
   MB_CLK <= CLK_100M;
   DOUT_MISO.TREADY <= '1';
   HDER_MISO.WREADY  <= '1';
   HDER_MISO.AWREADY <= '1';
   
   -- Reset
   U0 : process
   begin
      ARESET <= '1'; 
      wait for 250 ns;
      ARESET <= '0';
      wait;
   end process;
   
   -- Clk
   U1 : process(CLK_100M)
   begin
      CLK_100M <= not CLK_100M after CLK_100M_PERIOD/2; 
   end process;
   
   -- Trig
   U2 : process
   begin
      ACQ_TRIG <= '0';
      wait for (ACQ_TRIG_PERIOD - 100 ns);
      ACQ_TRIG <= '1';
      wait for 100 ns;
   end process;
   
   -- MicroBlaze Interface
   U4 : process
      variable start_pos : integer;
      variable end_pos   : integer;
   begin
      
      MB_MOSI.awaddr <= (others => '0');
      MB_MOSI.awprot <= (others => '0');
      MB_MOSI.wdata <= (others => '0');
      MB_MOSI.wstrb <= (others => '0');
      MB_MOSI.araddr <= (others => '0');
      MB_MOSI.arprot <= (others => '0');
      
      MB_MOSI.awvalid <= '0';
      MB_MOSI.wvalid <= '0';
      MB_MOSI.bready <= '0';
      MB_MOSI.arvalid <= '0';
      MB_MOSI.rready <= '0';
      
      FPA_EXP_INFO.exp_dval <= '0';
      
      wait until ARESET = '0';
      
      wait for 350 ns;
      
      -- Write FPA_SOFTW_STAT
      write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(FPA_SOFTW_STAT_BASE_ADD, 32)), resize(FPA_SOFTW_STAT_FPA_ROIC, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns;      
      write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(FPA_SOFTW_STAT_BASE_ADD + 4, 32)), resize(FPA_SOFTW_STAT_FPA_OUTPUT, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns; 
      write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(FPA_SOFTW_STAT_BASE_ADD + 8, 32)), resize(FPA_SOFTW_STAT_FPA_INPUT, 32), MB_MISO,  MB_MOSI);
      wait for 30 ns;
      
      -- Write DAC
      for ii in 0 to DAC_CFG_VECTOR_SIZE-1 loop 
         wait until rising_edge(MB_CLK);
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(DAC_CFG_BASE_ADD + 4*ii, 32)), std_logic_vector(VDAC_VALUE), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop;
      
      -- Write 1st config
      for ii in 0 to USER_CFG_VECTOR_SIZE-1 loop 
         wait until rising_edge(MB_CLK);      
         start_pos := user_cfg_vector1'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(user_cfg_vector1(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop;
      
      -- CTRLED_RESET is activated until first valid config is received
      -- Wait for MMCM lock + delay to have every modules out of reset
      wait for 2 ms;
      
      -- Configure exposure time
      wait until rising_edge(MB_CLK);
      FPA_EXP_INFO.exp_time <= to_unsigned(500, FPA_EXP_INFO.exp_time'length);     -- in clk cycle of 10ns (100MHz)
      FPA_EXP_INFO.exp_indx <= x"05";
      FPA_EXP_INFO.exp_dval <= '1';
      wait until rising_edge(MB_CLK);
      FPA_EXP_INFO.exp_dval <= '0';
      
--      -- Write 2nd config
--      for ii in 0 to USER_CFG_VECTOR_SIZE-1 loop 
--         wait until rising_edge(MB_CLK);      
--         start_pos := user_cfg_vector2'length -1 - 32*ii;
--         end_pos   := start_pos - 31;
--         write_axi_lite (MB_CLK, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(user_cfg_vector2(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
--         wait for 30 ns;
--      end loop;

      wait for 4 ms;

      -- Configure exposure time
      wait until rising_edge(MB_CLK);
      FPA_EXP_INFO.exp_time <= to_unsigned(10_000, FPA_EXP_INFO.exp_time'length);     -- in clk cycle of 10ns (100MHz)
      FPA_EXP_INFO.exp_indx <= x"04";
      FPA_EXP_INFO.exp_dval <= '1';
      wait until rising_edge(MB_CLK);
      FPA_EXP_INFO.exp_dval <= '0';
      
      report "FCR written";
      
      report "END OF SIMULATION"
      severity error;
      wait;
   end process;
   
   -- Unit Under Test port map
   UUT : calcium640D_intf_testbench
   port map (
      ACQ_TRIG => ACQ_TRIG,
      ARESET => ARESET,
      CLK_100M => CLK_100M,
      MB_CLK => MB_CLK,
      ROIC_MISO => ROIC_MISO,
      RX_CLK => RX_CLK,
      RX_RDY => RX_RDY,
      XTRA_TRIG => XTRA_TRIG,
      DOUT_MISO => DOUT_MISO,
      FPA_EXP_INFO => FPA_EXP_INFO,
      HDER_MISO => HDER_MISO,
      MB_MOSI => MB_MOSI,
      RX_DATA => RX_DATA,
      CLK_DDR_N => CLK_DDR_N,
      CLK_DDR_P => CLK_DDR_P,
      CLK_FRM => CLK_FRM,
      CLK_RD => CLK_RD,
      DAC_CSN => DAC_CSN,
      DAC_SCLK => DAC_SCLK,
      DAC_SD => DAC_SD,
      DOUT_CLK => DOUT_CLK,
      ERR_FOUND => ERR_FOUND,
      FPA_HDER_CLK => FPA_HDER_CLK,
      FPA_ON => FPA_ON,
      PIXQNB_EN => PIXQNB_EN,
      POCAN_RESET => POCAN_RESET,
      ROIC_MOSI => ROIC_MOSI,
      ROIC_SCLK => ROIC_SCLK,
      DOUT_MOSI => DOUT_MOSI,
      HDER_MOSI => HDER_MOSI,
      IMAGE_INFO => IMAGE_INFO,
      MB_MISO => MB_MISO
   );
   
end TB_ARCHITECTURE;