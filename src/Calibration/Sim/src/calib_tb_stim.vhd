-------------------------------------------------------------------------------
--
-- Title       : calib_tb_stim
-- Author      : Olivier Dionne
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author$
-- $LastChangedDate$
-- $Revision$ 
-------------------------------------------------------------------------------
--
-- Description : Test bench for Calibration module
--
-------------------------------------------------------------------------------

library IEEE;                                             
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;
use work.calib_define.all;

entity calib_tb_stim is
   port(
      --------------------------------
      -- RAM Write
      -------------------------------- 
      AXIL_MOSI      : out t_axi4_lite_mosi;
      AXIL_MISO      : in t_axi4_lite_miso;
      
      --------------------------------
      -- Calib Interface
      --------------------------------
      EXTRACTED_INFO_VALID        : out std_logic;
      EXTRACTED_BLOCK_INDEX       : out cal_block_index_type;
      MB_MOSI                     : out t_axi4_lite_mosi;
      MB_MISO                     : in t_axi4_lite_miso;
      STAT                        : out calib_stat_type;
      FPA_IMG_INFO                : out img_info_type;
      
      --------------------------------
      -- FIFO
      --------------------------------
      SYNC_MOSI   : out t_axi4_stream_mosi32;
      SYNC_MISO   : out t_axi4_stream_miso;
      FL_PIPE     : out std_logic;
      
      --------------------------------
      -- MISC
      --------------------------------
      CLK160   : out std_logic;
      CLK100   : out std_logic;
      ARESETN  : out std_logic
   );
end calib_tb_stim;



architecture rtl of calib_tb_stim is
   
   -- CLK and RESET
   constant clk160_per : time := 6.25 ns;
   constant clk100_per : time := 10 ns;
   
   -- CLK and RESET
   signal clk160_o : std_logic := '0';
   signal clk100_o : std_logic := '0';
   signal rstn_i : std_logic := '0';
   
   constant C_S_AXI_DATA_WIDTH      : integer := 32;
   constant C_S_AXI_ADDR_WIDTH      : integer := 32;
   
   constant BLOCK_INDEX_MAX         : integer := 3;
   constant PARAM_INDEX_MAX         : integer := 29;
   constant PARAM_INDEX_WIDTH       : integer := 5;
   
   signal addr : unsigned(C_S_AXI_ADDR_WIDTH-1 downto 0);
   signal data : unsigned(C_S_AXI_DATA_WIDTH-1 downto 0);
   signal calib_block_sel_mode_addr : unsigned(C_S_AXI_ADDR_WIDTH-1 downto 0);
   
   signal sync_mosi_tlast  : std_logic;
   signal fl_pipe_i        : std_logic;

begin
   --! Assign clock
   CLK160 <= clk160_o;
   CLK100 <= clk100_o;
   ARESETN <= rstn_i;

   --! Clock 160MHz generation                   
   CLK160_GEN: process(clk160_o)
   begin
      clk160_o <= not clk160_o after clk160_per/2;                          
   end process;
   
   --! Clock 100MHz generation 
   CLK100_GEN: process(clk100_o)
   begin
      clk100_o <= not clk100_o after clk100_per/2;                          
   end process;

   --! Reset Generation
   RST_GEN : process
   begin          
      rstn_i <= '0';
      wait for 1 us;
      rstn_i <= '1'; 
      wait;
   end process;
   
   --! Fifo
   SYNC_MOSI.TVALID <= '1';
   SYNC_MOSI.TDATA <= (others => '0');
   SYNC_MOSI.TSTRB <= (others => '0');
   SYNC_MOSI.TKEEP <= (others => '0');
   SYNC_MOSI.TLAST <= sync_mosi_tlast;
   SYNC_MOSI.TID <= (others => '0');
   SYNC_MOSI.TDEST <= (others => '0');
   SYNC_MOSI.TUSER <= (others => '0');
   SYNC_MISO.TREADY <= '1';
   FL_PIPE <= fl_pipe_i;
   
   --! µBlaze simulation
   MB_PROCESS : process 
   begin
      -- Reset
      if rstn_i = '0' then
         EXTRACTED_BLOCK_INDEX <= to_unsigned(0, cal_block_index_type'length);
         EXTRACTED_INFO_VALID <= '0';
         STAT.DONE <= '1';
         FPA_IMG_INFO.frame_id <= (others => '0');
         FPA_IMG_INFO.exp_info.exp_dval <= '0';
         sync_mosi_tlast <= '0';
         fl_pipe_i <= '1';
      end if;
      
      wait until rstn_i = '1';
      wait for 1 us;
      
      wait until rising_edge(clk160_o);
      fl_pipe_i <= '0';
   
      ------------------------------------------
      -- AXI Lite function signatures
      ------------------------------------------
      --procedure write_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); Value : in std_logic_vector(31 downto 0);signal  miso : in  t_axi4_lite_miso;signal  mosi : out t_axi4_lite_mosi);
      --procedure read_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); signal miso : in  t_axi4_lite_miso; signal mosi : out t_axi4_lite_mosi;signal  ReadValue : out std_logic_vector(31 downto 0));
      
      -- Write RAM
      BLOCK_INDEX_LOOP: for block_index in 0 to BLOCK_INDEX_MAX loop
         PARAM_INDEX_LOOP: for param_index in 0 to PARAM_INDEX_MAX loop
            -- Use the same value for addr and data
            data <= to_unsigned(block_index * (PARAM_INDEX_MAX+1) + param_index, data'length);        --in 4-byte words
            addr <= to_unsigned((block_index * (PARAM_INDEX_MAX+1) + param_index) * 4, addr'length);  --in bytes
            wait until rising_edge(clk100_o);
            write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(data), AXIL_MISO, AXIL_MOSI);
            wait for 5 ns;
         end loop PARAM_INDEX_LOOP;
      end loop BLOCK_INDEX_LOOP;
      
      --! Config
      addr <= (others => '0');
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(to_unsigned(PARAM_INDEX_MAX+1, C_S_AXI_DATA_WIDTH)), MB_MISO, MB_MOSI);
      wait for 5 ns;
      addr <= addr + 4;
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, std_logic_vector(addr), x"8000_0000", MB_MISO, MB_MOSI);
      wait for 5 ns;
      addr <= addr + 4;
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(to_unsigned(640, C_S_AXI_DATA_WIDTH)), MB_MISO, MB_MOSI);
      wait for 5 ns;
      addr <= addr + 4;
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(to_unsigned(512, C_S_AXI_DATA_WIDTH)), MB_MISO, MB_MOSI);
      wait for 5 ns;
      addr <= addr + 4;
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(to_unsigned(0, C_S_AXI_DATA_WIDTH)), MB_MISO, MB_MOSI);
      wait for 5 ns;
      addr <= addr + 4;
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(to_unsigned(0, C_S_AXI_DATA_WIDTH)), MB_MISO, MB_MOSI);
      wait for 5 ns;
      addr <= addr + 4;
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(to_unsigned(1, C_S_AXI_DATA_WIDTH)), MB_MISO, MB_MOSI);
      wait for 5 ns;
      addr <= addr + 4;
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(to_unsigned(BLOCK_INDEX_MAX, C_S_AXI_DATA_WIDTH)), MB_MISO, MB_MOSI);
      wait for 5 ns;
      
      addr <= addr + 4;
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, std_logic_vector(addr), resize(CBSM_EXPOSURE_TIME, C_S_AXI_DATA_WIDTH), MB_MISO, MB_MOSI);
      calib_block_sel_mode_addr <= addr;  --CALIB_BLOCK_SEL_MODE
      wait for 5 ns;
      
      BLOCK_INFO_LOOP: for block_index in 0 to NB_CALIB_BLOCK_MAX-1 loop
         addr <= addr + 4;
         wait until rising_edge(clk100_o);
         write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(to_unsigned(block_index*10+0, C_S_AXI_DATA_WIDTH)), MB_MISO, MB_MOSI);
         wait for 5 ns;
         addr <= addr + 4;
         wait until rising_edge(clk100_o);
         write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(to_unsigned(block_index*10+1, C_S_AXI_DATA_WIDTH)), MB_MISO, MB_MOSI);
         wait for 5 ns;
         addr <= addr + 4;
         wait until rising_edge(clk100_o);
         write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(to_unsigned(block_index*10+2, C_S_AXI_DATA_WIDTH)), MB_MISO, MB_MOSI);
         wait for 5 ns;
         addr <= addr + 4;
         wait until rising_edge(clk100_o);
         write_axi_lite(clk100_o, std_logic_vector(addr), std_logic_vector(to_unsigned(block_index*10+3, C_S_AXI_DATA_WIDTH)), MB_MISO, MB_MOSI);
         wait for 5 ns;
      end loop BLOCK_INFO_LOOP;
      
      wait until rising_edge(clk160_o);
      STAT.DONE <= '0';
      
      wait for 100 ns;
      
      
      
      -- New frame with exposure_time = sel_value1
      wait until rising_edge(clk100_o);
      FPA_IMG_INFO.frame_id <= to_unsigned(1, FPA_IMG_INFO.frame_id'length);
      FPA_IMG_INFO.exp_info.exp_time <= to_unsigned(10, FPA_IMG_INFO.frame_id'length);
      FPA_IMG_INFO.exp_info.exp_dval <= '1';
      wait for 100 ns;
      FPA_IMG_INFO.exp_info.exp_dval <= '0';
      
      -- New frame with invalid exposure_time (not defined)
      wait until rising_edge(clk100_o);
      FPA_IMG_INFO.frame_id <= to_unsigned(2, FPA_IMG_INFO.frame_id'length);
      FPA_IMG_INFO.exp_info.exp_time <= to_unsigned(15, FPA_IMG_INFO.frame_id'length);
      FPA_IMG_INFO.exp_info.exp_dval <= '1';
      wait for 100 ns;
      FPA_IMG_INFO.exp_info.exp_dval <= '0';
      
      -- New frame with exposure_time = sel_value3
      wait until rising_edge(clk100_o);
      FPA_IMG_INFO.frame_id <= to_unsigned(3, FPA_IMG_INFO.frame_id'length);
      FPA_IMG_INFO.exp_info.exp_time <= to_unsigned(30, FPA_IMG_INFO.frame_id'length);
      FPA_IMG_INFO.exp_info.exp_dval <= '1';
      wait for 100 ns;
      FPA_IMG_INFO.exp_info.exp_dval <= '0';
      
      -- New frame with invalid exposure_time (block_index > BLOCK_INDEX_MAX)
      wait until rising_edge(clk100_o);
      FPA_IMG_INFO.frame_id <= to_unsigned(4, FPA_IMG_INFO.frame_id'length);
      FPA_IMG_INFO.exp_info.exp_time <= to_unsigned(40, FPA_IMG_INFO.frame_id'length);
      FPA_IMG_INFO.exp_info.exp_dval <= '1';
      wait for 100 ns;
      FPA_IMG_INFO.exp_info.exp_dval <= '0';
      
      -- Live change of CALIB_BLOCK_SEL_MODE
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, std_logic_vector(calib_block_sel_mode_addr), resize(CBSM_USER_SEL_2, C_S_AXI_DATA_WIDTH), MB_MISO, MB_MOSI);
      wait until rising_edge(clk100_o);
      FPA_IMG_INFO.frame_id <= to_unsigned(5, FPA_IMG_INFO.frame_id'length);
      FPA_IMG_INFO.exp_info.exp_dval <= '1';
      wait for 100 ns;
      FPA_IMG_INFO.exp_info.exp_dval <= '0';
      
      -- Invalid change of CALIB_BLOCK_SEL_MODE
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, std_logic_vector(calib_block_sel_mode_addr), resize(CBSM_USER_SEL_7, C_S_AXI_DATA_WIDTH), MB_MISO, MB_MOSI);
      wait until rising_edge(clk100_o);
      FPA_IMG_INFO.frame_id <= to_unsigned(6, FPA_IMG_INFO.frame_id'length);
      FPA_IMG_INFO.exp_info.exp_dval <= '1';
      wait for 100 ns;
      FPA_IMG_INFO.exp_info.exp_dval <= '0';
      
      
      
      -- Read RAM and output params
      wait until rising_edge(clk160_o);
      EXTRACTED_BLOCK_INDEX <= to_unsigned(1, cal_block_index_type'length);
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '1';
      wait for 300 ns;
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '0';
      
      -- TLAST to fifo with only 1 param
      wait until rising_edge(clk160_o);
      sync_mosi_tlast <= '1';
      wait until rising_edge(clk160_o);
      sync_mosi_tlast <= '0';
      
      -- Read RAM and output params
      wait until rising_edge(clk160_o);
      EXTRACTED_BLOCK_INDEX <= to_unsigned(3, cal_block_index_type'length);
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '1';
      wait for 300 ns;
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '0';
      
      -- Read RAM and output params
      wait until rising_edge(clk160_o);
      EXTRACTED_BLOCK_INDEX <= to_unsigned(3, cal_block_index_type'length);
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '1';
      wait for 300 ns;
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '0';
      
      -- Read RAM and output params
      wait until rising_edge(clk160_o);
      EXTRACTED_BLOCK_INDEX <= to_unsigned(1, cal_block_index_type'length);
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '1';
      wait for 300 ns;
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '0';
      
      -- TLAST to fifo to update param
      wait until rising_edge(clk160_o);
      sync_mosi_tlast <= '1';
      wait until rising_edge(clk160_o);
      sync_mosi_tlast <= '0';
      
      wait for 100 ns;
      
      -- TLAST to fifo to update param
      wait until rising_edge(clk160_o);
      sync_mosi_tlast <= '1';
      wait until rising_edge(clk160_o);
      sync_mosi_tlast <= '0';
      
      wait for 100 ns;
      
      -- TLAST to fifo with only 1 param
      wait until rising_edge(clk160_o);
      sync_mosi_tlast <= '1';
      wait until rising_edge(clk160_o);
      sync_mosi_tlast <= '0';
      
      wait for 100 ns;
      
      -- TLAST to fifo while empty
      wait until rising_edge(clk160_o);
      sync_mosi_tlast <= '1';
      wait until rising_edge(clk160_o);
      sync_mosi_tlast <= '0';
      
      -- Read RAM and output params
      wait until rising_edge(clk160_o);
      EXTRACTED_BLOCK_INDEX <= to_unsigned(2, cal_block_index_type'length);
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '1';
      wait for 300 ns;
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '0';
      
      -- Read RAM and output params with invalid block_index
      wait until rising_edge(clk160_o);
      EXTRACTED_BLOCK_INDEX <= to_unsigned(7, cal_block_index_type'length);
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '1';
      wait for 300 ns;
      wait until rising_edge(clk160_o);
      EXTRACTED_INFO_VALID <= '0';
      
      -- Reset fifo while not empty
      wait until rising_edge(clk160_o);
      fl_pipe_i <= '1';
      wait until rising_edge(clk160_o);
      fl_pipe_i <= '0';

   end process MB_PROCESS;

end rtl;
