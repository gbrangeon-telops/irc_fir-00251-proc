library debug_scopio_230Hz;
use debug_scopio_230Hz.dbg_define.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity double_base_sig_measure_tb is
end double_base_sig_measure_tb;

architecture TB_ARCHITECTURE of double_base_sig_measure_tb is
   -- Component declaration of the tested unit
   component double_base_sig_measure
      port(
         ARESET : in STD_LOGIC;
         CH0_ARESET : in STD_LOGIC;
         CH0_CLK : in STD_LOGIC;
         CH0_DVAL : in STD_LOGIC;
         CH0_FVAL : in STD_LOGIC;
         CH0_LVAL : in STD_LOGIC;
         CH1_ARESET : in STD_LOGIC;
         CH1_CLK : in STD_LOGIC;
         CH1_DVAL : in STD_LOGIC;
         CH1_FVAL : in STD_LOGIC;
         CH1_LVAL : in STD_LOGIC;
         CLK_100M : in STD_LOGIC;
         CLK_80M : in STD_LOGIC;
         DBG_STAT : out dbg_stat_type );
   end component;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal CH0_ARESET : STD_LOGIC;
   signal CH0_CLK : STD_LOGIC;
   signal CH0_DVAL : STD_LOGIC;
   signal CH0_FVAL : STD_LOGIC;
   signal CH0_LVAL : STD_LOGIC;
   signal CH1_ARESET : STD_LOGIC;
   signal CH1_CLK : STD_LOGIC;
   signal CH1_DVAL : STD_LOGIC;
   signal CH1_FVAL : STD_LOGIC;
   signal CH1_LVAL : STD_LOGIC;
   -- Observed signals - signals mapped to the output ports of tested entity
   signal DBG_STAT : dbg_stat_type;
   
   constant xsize : natural := 128;
   constant ysize : natural := 16;
   
   constant CLK_40M_PERIOD  : time := 25.0 ns;
   constant CLK_80M_PERIOD  : time := 12.5 ns;
   constant CLK_100M_PERIOD : time := 10.0 ns; 
   constant lval_period     : time := 16_000 ns; 
   constant fval_period     : time := 16_384 us;
   
   constant TRIG_PERIOD : time := 100 us;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ARESET       : STD_LOGIC  := '1';
   signal CLK_40M      : STD_LOGIC  := '1';
   signal CLK_100M     : STD_LOGIC  := '1';
   signal CLK_80M      : STD_LOGIC  := '1';
   signal lval_i       : STD_LOGIC  := '0';
   signal fval_i       : STD_LOGIC  := '0';  
   signal cnt          : integer := 0;
   
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
   U2a: process(CLK_40M)
   begin
      CLK_40M <= not CLK_40M after CLK_40M_PERIOD/2; 
   end process;  
   
   U2b: process(CLK_100M)
   begin
      CLK_100M <= not CLK_100M after CLK_100M_PERIOD/2; 
   end process;  
   
   U2c: process(CLK_80M)
   begin
      CLK_80M <= not CLK_80M after CLK_80M_PERIOD/2; 
   end process;
   
   U3: process(lval_i)
   begin
      lval_i <= not lval_i after lval_period/2; 
   end process;
   
   U4: process(fval_i)
   begin
      fval_i <= not fval_i after fval_period/2; 
   end process;
   
   
   CH0_CLK <= CLK_40M; 
   CH0_DVAL <= lval_i;
   CH0_LVAL <= lval_i;
   CH0_FVAL <= fval_i; 
   
   
   CH1_CLK <= transport CLK_40M after 1000 ns; 
   CH1_DVAL <= transport lval_i after 1000 ns;
   CH1_LVAL <= transport lval_i after 1000 ns;
   CH1_FVAL <= transport fval_i after 1000 ns;
   
   -- Unit Under Test port map
   UUT : double_base_sig_measure
   port map (
      ARESET => areset,
      CH0_ARESET => areset,
      CH0_CLK => CH0_CLK,
      CH0_DVAL => CH0_DVAL,
      CH0_FVAL => CH0_FVAL,
      CH0_LVAL => CH0_LVAL,
      CH1_ARESET => areset,
      CH1_CLK => CH1_CLK,
      CH1_DVAL => CH1_DVAL,
      CH1_FVAL => CH1_FVAL,
      CH1_LVAL => CH1_LVAL,
      CLK_100M => CLK_100M,
      CLK_80M => CLK_80M,
      DBG_STAT => DBG_STAT
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_double_base_sig_measure of double_base_sig_measure_tb is
   for TB_ARCHITECTURE
      for UUT : double_base_sig_measure
         use entity work.double_base_sig_measure(sch);
      end for;
   end for;
end TESTBENCH_FOR_double_base_sig_measure;

