library IEEE;
use IEEE.std_logic_1164.all;
use work.IRIG_define_v2.all;
use work.tel2000.all;

entity irig_globaltest_tb is
end irig_globaltest_tb;

architecture TB_ARCHITECTURE of irig_globaltest_tb is
   
   component irig_globaltest
      port(
         ARESET         : in STD_LOGIC;
         CLK            : in STD_LOGIC;
         IRIG_ENABLE    : in STD_LOGIC;
         MB_CLK         : in STD_LOGIC;
         MB_MOSI        : in t_axi4_lite_mosi;
         RESET_IRIG_ERR : in STD_LOGIC;
         IRIG_PPS       : out STD_LOGIC;
         MB_MISO        : out t_axi4_lite_miso
         
         );
   end component;
   
   constant CLK_PERIOD      : time := 50 ns;
   constant MB_CLK_PERIOD   : time := 10 ns;
   
   signal areset          : std_logic;
   signal clk             : std_logic := '0';
   signal irig_enable     : std_logic;
   signal reset_irig_err  : std_logic;
   signal mb_mosi         : t_axi4_lite_mosi;
   signal mb_miso         : t_axi4_lite_miso;
   signal mb_clk          : std_logic := '0';
   
   signal irig_pps        : std_logic;
   signal irig_reg_mosi   : t_ll_mosi;
   signal irig_reg_sel    : std_logic_vector(3 downto 0);
   
   
   
begin
   
   clk_gen: process(clk)
   begin
      clk <= not clk after CLK_PERIOD/2; 
   end process; 
   
   mb_clk_gen: process(mb_clk)
   begin
      mb_clk <= not mb_clk after MB_CLK_PERIOD/2; 
   end process; 
   
   
   reset_irig_err_gen: process
   begin
      reset_irig_err <= '0'; 
      wait for 1000000 us;
      reset_irig_err <= '1';
      wait for 1 us;
      reset_irig_err <= '0'; 
      
      wait;
   end process; 
   
   
   reset_gen: process
   begin
      areset <= '1'; 
      wait for 100 ns;
      areset <= '0';
      wait;
   end process;       
   
   --mb_miso.tready <= '1'; 
   irig_enable <= '1';  
   
   -- Unit Under Test port map
   UUT : irig_globaltest
   port map (
      ARESET         => areset, 
      CLK            => clk,
      IRIG_ENABLE    => irig_enable,
      MB_CLK         => mb_clk,
      MB_MOSI        => mb_mosi,
      RESET_IRIG_ERR => reset_irig_err,
      IRIG_PPS       => irig_pps,
      MB_MISO        => open
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_irig_globaltest of irig_globaltest_tb is
   for TB_ARCHITECTURE
      for UUT : irig_globaltest
         use entity work.irig_globaltest(irig_globaltest);
      end for;
   end for;
end TESTBENCH_FOR_irig_globaltest;

