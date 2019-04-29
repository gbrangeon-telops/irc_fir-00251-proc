-------------------------------------------------------------------------------
--
-- Title       : trig_tb_stim
-- Author      : Olivier Dionne
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author: odionne $
-- $LastChangedDate: 2017-03-22 10:04:58 -0400 (mer., 22 mars 2017) $
-- $Revision: 20205 $ 
-------------------------------------------------------------------------------
--
-- Description : Test bench for Trig module
--
-------------------------------------------------------------------------------

library IEEE;                                             
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;
use work.trig_define.all;

entity trig_tb_stim is
   port(
      AXIL_MOSI      : out t_axi4_lite_mosi;
      AXIL_MISO      : in t_axi4_lite_miso;
      
      TRIG_HW        : out std_logic;
      TRIG_SFW       : out std_logic;
      
      FPA_EXP_INFO   : out exp_info_type;
      
      CLK100   : out std_logic;
      ARESETN  : out std_logic
   );
end trig_tb_stim;



architecture rtl of trig_tb_stim is
   
   -- CLK and RESET
   constant clk100_per : time := 10 ns;
   
   -- CLK and RESET
   signal clk100_o : std_logic := '0';
   signal rstn_i : std_logic := '0';
   
   constant C_S_AXI_DATA_WIDTH      : integer := 32;
   constant C_S_AXI_ADDR_WIDTH      : integer := 32;
   
   constant PERIOD_CLK_CYCLE        : real := 50.0;
   constant TRIG_SEQ_FRAME_CNT      : integer := 5;
   
   signal trig_hw_o : std_logic;
   signal trig_sfw_o : std_logic;
   signal readData : std_logic_vector(31 downto 0);

begin
   --! Assign clock
   CLK100 <= clk100_o;
   ARESETN <= rstn_i;

   --! Clock 100MHz generation 
   CLK100_GEN: process(clk100_o)
   begin
      clk100_o <= not clk100_o after clk100_per/2;                          
   end process;

   --! Reset Generation
   RST_GEN : process
   begin          
      rstn_i <= '0';
      wait for 100 ns;
      rstn_i <= '1'; 
      wait;
   end process;
   
   --! Outputs
   TRIG_HW <= trig_hw_o;
   TRIG_SFW <= trig_sfw_o;
   
   --! µBlaze simulation
   MB_PROCESS : process 
   begin
      -- Reset
      if rstn_i = '0' then
         trig_hw_o <= '0';
         trig_sfw_o <= '0';
         FPA_EXP_INFO.exp_dval <= '0';
      end if;
      
      wait until rstn_i = '1';
      wait for 100 ns;
      
      wait until rising_edge(clk100_o);
   
      ------------------------------------------
      -- AXI Lite function signatures
      ------------------------------------------
      --procedure write_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); Value : in std_logic_vector(31 downto 0);signal  miso : in  t_axi4_lite_miso;signal  mosi : out t_axi4_lite_mosi);
      --procedure read_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); signal miso : in  t_axi4_lite_miso; signal mosi : out t_axi4_lite_mosi;signal  ReadValue : out std_logic_vector(31 downto 0));
      
      
      -- Config
      write_axi_lite (clk100_o, x"000000C0", x"00000000", AXIL_MISO,  AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"00000000", resize(SEQ_TRIG, C_S_AXI_DATA_WIDTH), AXIL_MISO,  AXIL_MOSI);   -- mode
      wait until rising_edge(clk100_o);
   
      write_axi_lite (clk100_o, x"00000004", std_logic_vector(to_unsigned(integer(PERIOD_CLK_CYCLE), C_S_AXI_DATA_WIDTH)), AXIL_MISO,  AXIL_MOSI);   -- period
      wait until rising_edge(clk100_o);
     
      write_axi_lite (clk100_o, x"00000008", std_logic_vector(to_unsigned(0, C_S_AXI_DATA_WIDTH)), AXIL_MISO,  AXIL_MOSI);   -- fpatrig_dly
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"0000000C", x"00000000", AXIL_MISO,  AXIL_MOSI);   -- force_high
      wait until rising_edge(clk100_o);
   
      write_axi_lite (clk100_o, x"00000010", resize(RisingEdge, C_S_AXI_DATA_WIDTH), AXIL_MISO,  AXIL_MOSI);   -- trig_activ
      wait until rising_edge(clk100_o);
     
      write_axi_lite (clk100_o, x"00000014", x"00000001", AXIL_MISO,  AXIL_MOSI);   -- acq_window
      wait until rising_edge(clk100_o);
   
      write_axi_lite (clk100_o, x"00000018", std_logic_vector(to_unsigned(TRIG_SEQ_FRAME_CNT, C_S_AXI_DATA_WIDTH)), AXIL_MISO,  AXIL_MOSI);   -- seq_framecount
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"0000001C", resize("0" & TRIGSEQ_HARDWARE, C_S_AXI_DATA_WIDTH), AXIL_MISO,  AXIL_MOSI);   -- seq_trigsource
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"000000C0", x"00000001", AXIL_MISO,  AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      FPA_EXP_INFO.exp_time <= to_unsigned(integer(PERIOD_CLK_CYCLE / 2.0), FPA_EXP_INFO.exp_time'length);
      wait until rising_edge(clk100_o);
      FPA_EXP_INFO.exp_dval <= '1';
      wait until rising_edge(clk100_o);
      FPA_EXP_INFO.exp_dval <= '0';
      
      wait for 100 ns;
      
      -- Trig
      wait until rising_edge(clk100_o);
      trig_hw_o <= '1';
      
      wait for 50 ns;
      
      wait until rising_edge(clk100_o);
      trig_hw_o <= '0';
      
      wait for (TRIG_SEQ_FRAME_CNT * integer(PERIOD_CLK_CYCLE) * clk100_per);
      
      
      
      -- Config
      write_axi_lite (clk100_o, x"000000C0", x"00000000", AXIL_MISO,  AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"00000008", std_logic_vector(to_unsigned(integer(0.5*PERIOD_CLK_CYCLE), C_S_AXI_DATA_WIDTH)), AXIL_MISO,  AXIL_MOSI);   -- fpatrig_dly
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"000000C0", x"00000001", AXIL_MISO,  AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      wait for 100 ns;
      
      -- Trig
      wait until rising_edge(clk100_o);
      trig_hw_o <= '1';
      
      wait for 50 ns;
      
      wait until rising_edge(clk100_o);
      trig_hw_o <= '0';
      
      wait for (TRIG_SEQ_FRAME_CNT * integer(PERIOD_CLK_CYCLE) * clk100_per);
      
      
      
      -- Config
      write_axi_lite (clk100_o, x"000000C0", x"00000000", AXIL_MISO,  AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"0000001C", resize("0" & TRIGSEQ_SOFTWARE, C_S_AXI_DATA_WIDTH), AXIL_MISO,  AXIL_MOSI);   -- seq_trigsource
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"000000C0", x"00000001", AXIL_MISO,  AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      wait for 100 ns;
      
      -- Trig
      write_axi_lite (clk100_o, x"00000020", x"00000001", AXIL_MISO,  AXIL_MOSI);   -- seq_softtrig_i
      wait until rising_edge(clk100_o);
      
      wait for (TRIG_SEQ_FRAME_CNT * integer(PERIOD_CLK_CYCLE) * clk100_per);
      
      
      
      -- Config
      write_axi_lite (clk100_o, x"000000C0", x"00000000", AXIL_MISO,  AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"00000000", resize(SFW_TRIG, C_S_AXI_DATA_WIDTH), AXIL_MISO,  AXIL_MOSI);   -- mode
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"000000C0", x"00000001", AXIL_MISO,  AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      FPA_EXP_INFO.exp_time <= to_unsigned(4, FPA_EXP_INFO.exp_time'length);
      wait until rising_edge(clk100_o);
      FPA_EXP_INFO.exp_dval <= '1';
      wait until rising_edge(clk100_o);
      FPA_EXP_INFO.exp_dval <= '0';
      
      wait for 100 ns;
      
      -- Trig
      SFW_TRIG_LOOP: for index in 1 to 3 loop
         wait until rising_edge(clk100_o);
         trig_sfw_o <= '1';
         
         wait until rising_edge(clk100_o);
         trig_sfw_o <= '0';
         
         wait for 100 ns;
      end loop SFW_TRIG_LOOP;
      
      
      
      -- Config
      write_axi_lite (clk100_o, x"000000C0", x"00000000", AXIL_MISO,  AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"00000000", resize(INTTRIG, C_S_AXI_DATA_WIDTH), AXIL_MISO,  AXIL_MOSI);   -- mode
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"000000C0", x"00000001", AXIL_MISO,  AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      
   end process MB_PROCESS;

end rtl;
