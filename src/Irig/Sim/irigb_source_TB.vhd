library fir_00229;
use fir_00229.IRIG_Testbench_define.all;
use fir_00229.IRIG_define.all;
library ieee;
use ieee.MATH_REAL.all;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity irigb_source_tb is
end irigb_source_tb;

architecture TB_ARCHITECTURE of irigb_source_tb is
   -- Component declaration of the tested unit
   component irigb_source
      port(
         ARESET           : in STD_LOGIC;
         CLK              : in STD_LOGIC;
         IRIG_SIGNAL      : out STD_LOGIC_VECTOR(7 downto 0);
         IRIG_SIGNAL_DVAL : out STD_LOGIC );
   end component;
   
   constant CLK_PERIOD  : time := 50 ns;
   
   signal irig_signal : STD_LOGIC_VECTOR(7 downto 0);
   signal irig_signal_dval : STD_LOGIC;
   signal clk : STD_LOGIC := '0';
   signal areset : STD_LOGIC;
   
   -- Add your code here ...
   
begin
   
   
   clk_gen: process(clk)
   begin
      clk <= not clk after CLK_PERIOD/2; 
   end process; 
   
   
   reset_gen: process
   begin
      areset <= '1'; 
      wait for 100 ns;
      areset <= '0';
      wait;
   end process;       
   
   
   
   
   UUT : irigb_source
   port map (
      ARESET            => areset,
      CLK               => clk,
      IRIG_SIGNAL       => irig_signal,
      IRIG_SIGNAL_DVAL  => irig_signal_dval
      );
   
   
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_irigb_source of irigb_source_tb is
   for TB_ARCHITECTURE
      for UUT : irigb_source
         use entity work.irigb_source(rtl);
      end for;
   end for;
end TESTBENCH_FOR_irigb_source;

