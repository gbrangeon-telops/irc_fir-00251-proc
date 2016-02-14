library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.TEL2000.all;
use work.exposure_define.all;

-- Add your library and packages declaration here ...

entity exposure_top_tb_TB is
end exposure_top_tb_TB;


architecture TB_ARCHITECTURE of exposure_top_tb_TB is
   -- Component declaration of the tested unit
   component exposure_top_tb
      port(
         ARESETN        : in STD_LOGIC;
         FPA_IMG_INFO   : in img_info_type;
         FW_EXP_INFO    : in exp_info_type;
         MB_CLK         : in STD_LOGIC;
         TRIG_HIGH_TIME : in STD_LOGIC_VECTOR(31 downto 0);
         ERROR          : out STD_LOGIC;
         EXP_CTRL_BUSY  : out STD_LOGIC;
         FPA_EXP_INFO   : out exp_info_type );
   end component;
   
   constant CLK_PERIOD         : time := 10 ns;
   constant EXP_FEEDBK_PERIOD  : time := 3 us;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ARESETN        : STD_LOGIC;
   signal FPA_IMG_INFO   : img_info_type;
   signal FW_EXP_INFO    : exp_info_type;
   signal MB_CLK         : STD_LOGIC := '0';
   signal TRIG_HIGH_TIME : STD_LOGIC_VECTOR(31 downto 0);
   -- Observed signals - signals mapped to the output ports of tested entity
   signal ERROR          : STD_LOGIC;
   signal EXP_CTRL_BUSY  : STD_LOGIC;
   signal FPA_EXP_INFO   : exp_info_type;
   signal exp_feedback   : STD_LOGIC := '0';
   
   
   -- Add your code here ...
   
begin
   
   MB_CLK_gen: process(MB_CLK)
   begin
      MB_CLK <= not MB_CLK after CLK_PERIOD/2; 
   end process; 
   
   
   exp_feedback_gen: process(exp_feedback)
   begin
      exp_feedback <= not exp_feedback after EXP_FEEDBK_PERIOD/2; 
   end process;
   FPA_IMG_INFO.exp_feedbk <= exp_feedback;
   
   reset_gen: process
   begin
      aresetn <= '0'; 
      wait for 30 ns;
      aresetn <= '1';
      wait;
   end process;
   
   fw_exp_gen: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         if aresetn = '0' then 
             FW_EXP_INFO.EXP_TIME <= (others => '0');
         else
           -- FW_EXP_INFO.EXP_DVAL <= '0';
            if EXP_CTRL_BUSY = '0' then
               FW_EXP_INFO.EXP_TIME <= FW_EXP_INFO.EXP_TIME + 1;
               FW_EXP_INFO.EXP_DVAL <= '1';
            end if;         
         end if;
      end if;
   end process;    
   
   -- Unit Under Test port map
   UUT : exposure_top_tb
   port map (
      ARESETN => ARESETN,
      FPA_IMG_INFO => FPA_IMG_INFO,
      FW_EXP_INFO => FW_EXP_INFO,
      MB_CLK => MB_CLK,
      TRIG_HIGH_TIME => TRIG_HIGH_TIME,
      ERROR => ERROR,
      EXP_CTRL_BUSY => EXP_CTRL_BUSY,
      FPA_EXP_INFO => FPA_EXP_INFO
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_exposure_top_tb of exposure_top_tb_TB is
   for TB_ARCHITECTURE
      for UUT : exposure_top_tb
         use entity work.exposure_top_tb(sch);
      end for;
   end for;
end TESTBENCH_FOR_exposure_top_tb;

