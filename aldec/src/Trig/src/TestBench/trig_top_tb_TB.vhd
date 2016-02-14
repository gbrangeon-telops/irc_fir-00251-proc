library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.TEL2000.all;


-- Add your library and packages declaration here ...

entity trig_top_tb_tB is
end trig_top_tb_tB;

architecture TB_ARCHITECTURE of trig_top_tb_tB is
   -- Component declaration of the tested unit
   component trig_top_tb
      port(
         ACQ_INT         : in STD_LOGIC;
         ARESETN         : in STD_LOGIC;
         MB_CLK          : in STD_LOGIC;
         --CLK_10M         : in STD_LOGIC;
         EXT_TRIG        : in STD_LOGIC;
         FPA_IMG_INFO    : in img_info_type;
         FPA_INTF_CLK    : in STD_LOGIC;		
         FPA_EXP_INFO    : in exp_info_type;
         ACQ_TRIG        : out STD_LOGIC;
         ERROR           : out STD_LOGIC;
         GATING          : out STD_LOGIC;
         PPS_SYNC        : out STD_LOGIC;
         TRIG_OUT        : out STD_LOGIC;
         XTRA_TRIG       : out STD_LOGIC;
         HDER_MOSI       : out t_axi4_lite_mosi;
         HDER_MISO       : in t_axi4_lite_miso
         );
   end component;
   
   
   constant CLK_PERIOD       : time := 10 ns;
   constant CLK_10M_PERIOD   : time := 100 ns;
   constant EXT_TRIG_PERIOD  : time := 300 ns;
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal ACQ_INT        : STD_LOGIC;
   signal ARESETN        : STD_LOGIC;
   signal MB_CLK         : STD_LOGIC := '0';
   signal CLK_10M        : STD_LOGIC := '0';
   signal EXT_TRIG       : STD_LOGIC :='0';
   signal FPA_IMG_INFO   : img_info_type;
   signal FPA_INTF_CLK   : STD_LOGIC := '0';
   signal HDER_MISO      : t_axi4_lite_miso;
   signal FPA_EXP_INFO   : exp_info_type;
   -- Observed signals - signals mapped to the output ports of tested entity
   signal ACQ_TRIG : STD_LOGIC;
   signal ERROR : STD_LOGIC;
   signal GATING : STD_LOGIC;
   signal PPS_SYNC : STD_LOGIC;
   signal TRIG_OUT : STD_LOGIC;
   signal XTRA_TRIG : STD_LOGIC;
   signal HDER_MOSI : t_axi4_lite_mosi;
   
   -- Add your code here ...
   
begin
   
   HDER_MISO.AWREADY <= '1';
   HDER_MISO.WREADY <= '1';
   HDER_MISO.ARREADY <= '1';
   HDER_MISO.BVALID <= '0';
   HDER_MISO.BRESP <=(others => '0');
   HDER_MISO.RVALID <= '0';
   HDER_MISO.RDATA <=(others => '0');
   HDER_MISO.RRESP <=(others => '0');
   
   
   MB_CLK_gen: process(MB_CLK)
   begin
      MB_CLK <= not MB_CLK after CLK_PERIOD/2; 
   end process;
   
   --   FPA_INTF_CLK_gen: process(FPA_INTF_CLK)
   --   begin
   --      FPA_INTF_CLK <= not FPA_INTF_CLK after CLK_PERIOD/2; 
   --   end process;
   
   FPA_INTF_CLK <= transport MB_CLK after 2ns;
   
--   CLK_10M_gen: process(CLK_10M)
--   begin
--      CLK_10M <= not CLK_10M after CLK_10M_PERIOD/2; 
--   end process;
   
   Ext_trig_gen: process(EXT_TRIG)
   begin
      EXT_TRIG <= '1';--not EXT_TRIG after EXT_TRIG_PERIOD/2; 
   end process;
      
   reset_gen: process
   begin
      aresetn <= '0'; 
      wait for 30 ns;
      aresetn <= '1';
      wait;
   end process; 
   
   FPA_IMG_INFO.exp_feedbk <= TRIG_OUT;
   FPA_IMG_INFO.frame_id <= to_unsigned(10, FPA_IMG_INFO.frame_id'length);  
   FPA_IMG_INFO.exp_info.exp_time <= (to_unsigned(15, FPA_IMG_INFO.exp_info.exp_time'length));
   FPA_IMG_INFO.exp_info.exp_indx <= '1'; 
   FPA_IMG_INFO.exp_info.exp_dval <= FPA_IMG_INFO.exp_feedbk;
   
   FPA_EXP_INFO.EXP_TIME <= to_unsigned(15, FPA_EXP_INFO.EXP_TIME'length);
   FPA_EXP_INFO.EXP_DVAL <= '1';
   
   ACQ_INT <= '0';
   
   -- Unit Under Test port map
   UUT : trig_top_tb
   port map (
      ACQ_INT => ACQ_INT,
      ARESETN => ARESETN,
      MB_CLK => MB_CLK,
      --CLK_10M => CLK_10M,
      EXT_TRIG => EXT_TRIG,
      FPA_IMG_INFO => FPA_IMG_INFO,
      FPA_INTF_CLK => FPA_INTF_CLK,
      HDER_MISO => HDER_MISO,
      FPA_EXP_INFO => FPA_EXP_INFO,
      ACQ_TRIG => ACQ_TRIG,
      ERROR => ERROR,
      GATING => GATING,
      PPS_SYNC => PPS_SYNC,
      TRIG_OUT => TRIG_OUT,
      XTRA_TRIG => XTRA_TRIG,
      HDER_MOSI => HDER_MOSI
      );
   
   -- Add your stimulus here ...
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_trig_top_tb of trig_top_tb_tB is
   for TB_ARCHITECTURE
      for UUT : trig_top_tb
         use entity work.trig_top_tb(sch);
      end for;
   end for;
end TESTBENCH_FOR_trig_top_tb;

