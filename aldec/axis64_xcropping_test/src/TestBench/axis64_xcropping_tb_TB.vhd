library axis64_xcropping_test;
use axis64_xcropping_test.TEL2000.all;
library ieee;
use ieee.STD_LOGIC_SIGNED.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Add your library and packages declaration here ...

entity axis64_xcropping_tb_tb is
end axis64_xcropping_tb_tb;

architecture TB_ARCHITECTURE of axis64_xcropping_tb_tb is
   -- Component declaration of the tested unit
   component axis64_xcropping_tb
      port(
         ARESET      : in STD_LOGIC;
         CLK         : in STD_LOGIC;
         AOI_EOL_POS : in STD_LOGIC_VECTOR(10 downto 0);
         AOI_SOL_POS : in STD_LOGIC_VECTOR(10 downto 0);
         FULL_WIDTH  : in STD_LOGIC_VECTOR(10 downto 0); 
         AOI_FLI_POS : in STD_LOGIC_VECTOR(10 downto 0);
         AOI_LLI_POS : in STD_LOGIC_VECTOR(10 downto 0)      
         );
      
   end component;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   
   constant CLK_PERIOD         : time := 10 ns;   
   
   signal ARESET        : STD_LOGIC;
   signal CLK           : STD_LOGIC := '0';
   signal AOI_EOL_POS   : STD_LOGIC_VECTOR(10 downto 0);
   signal AOI_SOL_POS   : STD_LOGIC_VECTOR(10 downto 0);
   signal FULL_WIDTH    : STD_LOGIC_VECTOR(10 downto 0);
   signal AOI_FLI_POS   : STD_LOGIC_VECTOR(10 downto 0);
   signal AOI_LLI_POS   : STD_LOGIC_VECTOR(10 downto 0);
   -- Observed signals - signals mapped to the output ports of tested entity
   
   -- Add your code here ...
   
begin
   
   -- reset
   U0A: process
   begin
      areset <= '1'; 
      wait for 250 ns;
      areset <= '0';
      wait;
   end process;
   
   -- clk
   U1: process(CLK)
   begin
      CLK <= not CLK after CLK_PERIOD/2; 
   end process;
   
   
   AOI_SOL_POS <= std_logic_vector(to_unsigned(1, AOI_SOL_POS'LENGTH));
   AOI_EOL_POS <= std_logic_vector(to_unsigned(640, AOI_EOL_POS'LENGTH));
   FULL_WIDTH  <= std_logic_vector(to_unsigned(640, FULL_WIDTH'LENGTH));
   AOI_FLI_POS <= std_logic_vector(to_unsigned(1, AOI_FLI_POS'LENGTH));
   AOI_LLI_POS <= std_logic_vector(to_unsigned(512, AOI_LLI_POS'LENGTH));
   
   -- Unit Under Test port map
   UUT : axis64_xcropping_tb
   port map (
      ARESET => ARESET,
      CLK => CLK,
      AOI_EOL_POS => AOI_EOL_POS,
      AOI_SOL_POS => AOI_SOL_POS,
      FULL_WIDTH => FULL_WIDTH,
      AOI_FLI_POS => AOI_FLI_POS,
      AOI_LLI_POS => AOI_LLI_POS    
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_axis64_xcropping_tb of axis64_xcropping_tb_tb is
   for TB_ARCHITECTURE
      for UUT : axis64_xcropping_tb
         use entity work.axis64_xcropping_tb(axis64_xcropping_tb);
      end for;
   end for;
end TESTBENCH_FOR_axis64_xcropping_tb;

