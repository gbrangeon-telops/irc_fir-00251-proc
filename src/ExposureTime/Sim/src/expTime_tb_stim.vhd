-------------------------------------------------------------------------------
--
-- Title       : expTime_tb_stim
-- Author      : Olivier Dionne
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author$
-- $LastChangedDate$
-- $Revision$ 
-------------------------------------------------------------------------------
--
-- Description : Test bench for ExpTime module
--
-------------------------------------------------------------------------------

library IEEE;                                             
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;
use work.exposure_define.all;
use work.trig_define.all;

entity expTime_tb_stim is
   port(
      ET_AXIL_MOSI      : out t_axi4_lite_mosi;
      ET_AXIL_MISO      : in t_axi4_lite_miso;
      
      EHDRI_AXIL_MOSI   : out t_axi4_lite_mosi;
      EHDRI_AXIL_MISO   : in t_axi4_lite_miso;
      
      TRIG_AXIL_MOSI    : out t_axi4_lite_mosi;
      TRIG_AXIL_MISO    : in t_axi4_lite_miso;
      
      CLK100   : out std_logic;
      ARESETN  : out std_logic
   );
end expTime_tb_stim;



architecture rtl of expTime_tb_stim is
   
   -- CLK and RESET
   constant clk100_per : time := 10 ns;
   
   -- CLK and RESET
   signal clk100_o : std_logic := '0';
   signal rstn_i : std_logic := '0';
   
   constant C_S_AXI_DATA_WIDTH      : integer := 32;
   constant C_S_AXI_ADDR_WIDTH      : integer := 32;
   
   constant ACQ_PERIOD_CLK_CYCLE    : real := 50.0;

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
   
   --! µBlaze simulation
   MB_PROCESS : process 
   begin
      -- Reset
      if rstn_i = '0' then
      end if;
      
      wait until rstn_i = '1';
      wait for 100 ns;
      
      wait until rising_edge(clk100_o);
   
      ------------------------------------------
      -- AXI Lite function signatures
      ------------------------------------------
      --procedure write_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); Value : in std_logic_vector(31 downto 0);signal  miso : in  t_axi4_lite_miso;signal  mosi : out t_axi4_lite_mosi);
      --procedure read_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); signal miso : in  t_axi4_lite_miso; signal mosi : out t_axi4_lite_mosi;signal  ReadValue : out std_logic_vector(31 downto 0));
      
      
      -- EHDRI Config
      for j in 0 to 63 loop
	      write_axi_lite (clk100_o, std_logic_vector(to_unsigned(j * 4, C_S_AXI_ADDR_WIDTH)), x"E4E4E4E4", EHDRI_AXIL_MISO,  EHDRI_AXIL_MOSI);   -- ehdri_indexes
	      wait until rising_edge(clk100_o);
      end loop;
      
      write_axi_lite (clk100_o, x"00000100", std_logic_vector(to_unsigned(integer(1.0 * ACQ_PERIOD_CLK_CYCLE / 5.0), C_S_AXI_DATA_WIDTH)), EHDRI_AXIL_MISO,  EHDRI_AXIL_MOSI);   -- exptime0
      wait until rising_edge(clk100_o);
   
      write_axi_lite (clk100_o, x"00000104", std_logic_vector(to_unsigned(integer(1.0 * ACQ_PERIOD_CLK_CYCLE / 5.0), C_S_AXI_DATA_WIDTH)), EHDRI_AXIL_MISO,  EHDRI_AXIL_MOSI);   -- exptime1
      wait until rising_edge(clk100_o);
     
      write_axi_lite (clk100_o, x"00000108", std_logic_vector(to_unsigned(integer(1.0 * ACQ_PERIOD_CLK_CYCLE / 5.0), C_S_AXI_DATA_WIDTH)), EHDRI_AXIL_MISO,  EHDRI_AXIL_MOSI);   -- exptime2
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"0000010C", std_logic_vector(to_unsigned(integer(4.0 * ACQ_PERIOD_CLK_CYCLE / 5.0), C_S_AXI_DATA_WIDTH)), EHDRI_AXIL_MISO,  EHDRI_AXIL_MOSI);   -- exptime3
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"00000110", x"00000001", EHDRI_AXIL_MISO,  EHDRI_AXIL_MOSI);   -- sm_enable
      wait until rising_edge(clk100_o);
      
      
      -- Exp Time Config
      write_axi_lite (clk100_o, x"00000000", resize(EHDRI_SOURCE, C_S_AXI_DATA_WIDTH), ET_AXIL_MISO,  ET_AXIL_MOSI);   -- exp_source
      wait until rising_edge(clk100_o);
   
      write_axi_lite (clk100_o, x"00000004", std_logic_vector(to_unsigned(0, C_S_AXI_DATA_WIDTH)), ET_AXIL_MISO,  ET_AXIL_MOSI);   -- exp_time_min
      wait until rising_edge(clk100_o);
     
      write_axi_lite (clk100_o, x"00000008", std_logic_vector(to_unsigned(integer(ACQ_PERIOD_CLK_CYCLE), C_S_AXI_DATA_WIDTH)), ET_AXIL_MISO,  ET_AXIL_MOSI);   -- exp_time_max
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"0000000C", x"00000000", ET_AXIL_MISO,  ET_AXIL_MOSI);   -- exp_time
      wait until rising_edge(clk100_o);
      
      
      -- Trig Config
      write_axi_lite (clk100_o, x"000000C0", x"00000000", TRIG_AXIL_MISO,  TRIG_AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"00000000", resize(INTTRIG, C_S_AXI_DATA_WIDTH), TRIG_AXIL_MISO,  TRIG_AXIL_MOSI);   -- mode
      wait until rising_edge(clk100_o);
   
      write_axi_lite (clk100_o, x"00000004", std_logic_vector(to_unsigned(integer(ACQ_PERIOD_CLK_CYCLE), C_S_AXI_DATA_WIDTH)), TRIG_AXIL_MISO,  TRIG_AXIL_MOSI);   -- period
      wait until rising_edge(clk100_o);
     
      write_axi_lite (clk100_o, x"00000008", std_logic_vector(to_unsigned(0, C_S_AXI_DATA_WIDTH)), TRIG_AXIL_MISO,  TRIG_AXIL_MOSI);   -- fpatrig_dly
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"0000000C", x"00000000", TRIG_AXIL_MISO,  TRIG_AXIL_MOSI);   -- force_high
      wait until rising_edge(clk100_o);
   
      write_axi_lite (clk100_o, x"00000010", resize(RisingEdge, C_S_AXI_DATA_WIDTH), TRIG_AXIL_MISO,  TRIG_AXIL_MOSI);   -- trig_activ
      wait until rising_edge(clk100_o);
     
      write_axi_lite (clk100_o, x"00000014", x"00000000", TRIG_AXIL_MISO,  TRIG_AXIL_MOSI);   -- acq_window
      wait until rising_edge(clk100_o);
   
      write_axi_lite (clk100_o, x"00000018", std_logic_vector(to_unsigned(0, C_S_AXI_DATA_WIDTH)), TRIG_AXIL_MISO,  TRIG_AXIL_MOSI);   -- seq_framecount
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"0000001C", resize("0" & TRIGSEQ_HARDWARE, C_S_AXI_DATA_WIDTH), TRIG_AXIL_MISO,  TRIG_AXIL_MOSI);   -- seq_trigsource
      wait until rising_edge(clk100_o);
      
      write_axi_lite (clk100_o, x"000000C0", x"00000001", TRIG_AXIL_MISO,  TRIG_AXIL_MOSI);   -- control
      wait until rising_edge(clk100_o);
      
      wait for 100 ns;
     
      
      write_axi_lite (clk100_o, x"00000014", x"00000001", TRIG_AXIL_MISO,  TRIG_AXIL_MOSI);   -- acq_window
      wait until rising_edge(clk100_o);
      
      
   end process MB_PROCESS;

end rtl;
