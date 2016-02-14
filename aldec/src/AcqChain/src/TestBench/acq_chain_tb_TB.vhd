library IEEE;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity acq_chain_tb_TB is
end acq_chain_tb_TB;

architecture TB_ARCHITECTURE of acq_chain_tb_TB is
   -- Component declaration of the tested unit
   component acq_chain_tb
      port(
         ARESETN   : in STD_LOGIC;
         CLK_100M  : in STD_LOGIC;
         CLK_10M   : in STD_LOGIC;
         CLK_80M   : in STD_LOGIC;
         DCLK      : in STD_LOGIC;
         EXT_TRIG  : in STD_LOGIC;
         MB_CLK    : in STD_LOGIC;
         FILENAME  : in STRING(1 to 255);
         TRIG_OUT  : out STD_LOGIC );
   end component;
   
   
   constant MB_CLK_PERIOD   : time := 10 ns;
   constant CLK_80M_PERIOD  : time := 12.5 ns;
   constant CLK_10M_PERIOD  : time := 100 ns;
   constant DCLK_PERIOD     : time := 6.25 ns;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ARESETN  : STD_LOGIC;
   signal CLK_100M : STD_LOGIC := '0';
   signal CLK_10M  : STD_LOGIC := '0';
   signal CLK_80M  : STD_LOGIC := '0';
   signal DCLK     : STD_LOGIC := '0';
   signal EXT_TRIG : STD_LOGIC;
   signal MB_CLK   : STD_LOGIC := '0';
   signal FILENAME : STRING(1 to 255);
   -- Observed signals - signals mapped to the output ports of tested entity
   signal TRIG_OUT : STD_LOGIC;
   
   -- Add your code here ...
   
begin
   
   U1: process(MB_CLK)
   begin
      MB_CLK <= not MB_CLK after MB_CLK_PERIOD/2; 
   end process; 
   
   CLK_100M <= transport MB_CLK after 7 ns;
   
   
   U2: process(CLK_80M)
   begin
      CLK_80M <= not CLK_80M after CLK_80M_PERIOD/2; 
   end process;
   
   U3: process(CLK_10M)
   begin
      CLK_10M <= not CLK_10M after CLK_10M_PERIOD/2; 
   end process; 
   
   U4: process(DCLK)
   begin
      DCLK <= not DCLK after DCLK_PERIOD/2; 
   end process;
   
   reset_gen: process
   begin
      aresetn <= '0'; 
      wait for 250 ns;
      aresetn <= '1';
      wait;
   end process;
   --areset <= not aresetn;
   FILENAME(1 to 65) <= "D:\Telops\FIR-00251-Proc\aldec\src\AcqChain\src\data_out\dout.dat"; 
   
   -- Unit Under Test port map
   UUT : acq_chain_tb
   port map (
      ARESETN => ARESETN,
      CLK_100M => CLK_100M,
      CLK_10M => CLK_10M,
      CLK_80M => CLK_80M,
      DCLK => DCLK,
      EXT_TRIG => EXT_TRIG,
      MB_CLK => MB_CLK,
      TRIG_OUT => TRIG_OUT,
      FILENAME => FILENAME
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_acq_chain_tb of acq_chain_tb_TB is
   for TB_ARCHITECTURE
      for UUT : acq_chain_tb
         use entity work.acq_chain_tb(sch);
      end for;
   end for;
end TESTBENCH_FOR_acq_chain_tb;

