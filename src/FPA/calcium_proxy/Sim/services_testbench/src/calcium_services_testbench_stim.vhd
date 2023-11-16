library work;
use work.FPA_define.all;
use work.TEL2000.all;
use work.fpa_common_pkg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity calcium_services_testbench_stim is
end calcium_services_testbench_stim;

architecture TB_ARCHITECTURE of calcium_services_testbench_stim is
   -- Component declaration of the tested unit
   component calcium_services_testbench
      port(
          ARESET : in STD_LOGIC;
          CLK_100M : in STD_LOGIC;
          GLOBAL_ERR : in STD_LOGIC;
          FPA_HARDW_STAT : out fpa_hardw_stat_type;
          FPA_TEMP_STAT : out fpa_temp_stat_type );
   end component;
   
   constant CLK_100M_PERIOD         : time := 10 ns;
   

   signal areset : std_logic;
   signal clk_100m : std_logic := '0';
   signal global_err : std_logic;
   signal fpa_hardw_stat : fpa_hardw_stat_type;
   signal fpa_temp_stat : fpa_temp_stat_type;

   
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
   U1: process(clk_100m)
   begin
      clk_100m <= not clk_100m after CLK_100M_PERIOD/2; 
   end process;
   
   global_err <= '0';
   
   -- Unit Under Test port map
   UUT : calcium_services_testbench
   port map (
       ARESET => areset,
       CLK_100M => clk_100m,
       GLOBAL_ERR => global_err,
       FPA_HARDW_STAT => fpa_hardw_stat,
       FPA_TEMP_STAT => fpa_temp_stat
   );
   
   
end TB_ARCHITECTURE;

