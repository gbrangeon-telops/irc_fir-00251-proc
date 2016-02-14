-------------------------------------------------------------------------------
--
-- Title       : Buffering TB STIM
-- Design      : clink_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        :
-- Generated   : 
-- From        : 
-- By          : 
--
-------------------------------------------------------------------------------
--
-- Description :  Stim file for Buffering simulation
--
-------------------------------------------------------------------------------

library IEEE;                                             
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;

entity buffering_tb_stim is
   port(
      --------------------------------
      -- PowerPC Interface
      -------------------------------- 
      AXIL_MOSI : out t_axi4_lite_mosi;
      AXIL_MISO : in t_axi4_lite_miso;
      
      AXIL_BUF_MOSI : out t_axi4_lite_mosi;
      AXIL_BUF_MISO : in t_axi4_lite_miso; 
      
      WATERLEVEL    : out STD_LOGIC;
      EXTERNAL_MOI  : out std_logic;
      ACQUISTION_STOP : out std_logic;
      
      STALL : out std_logic;
      
      CLK160   : out STD_LOGIC;
      CLK100   : out STD_LOGIC;
      ARESETN   : out STD_LOGIC
   );
end buffering_tb_stim;



architecture rtl of buffering_tb_stim is

-- CLK and RESET
signal clk160_o : std_logic := '0';
signal clk100_o : std_logic := '0';
signal rstn_i : std_logic := '0';

signal ReadValue : std_logic_vector(31 downto 0) := (others => '0');
signal read_value : std_logic_vector(31 downto 0) := (others => '0');
signal write_value : std_logic_vector(31 downto 0) := (others => '0');
signal write_value_u : unsigned(31 downto 0) := (others => '0');

constant NB_OF_FRAME : integer := 10;
constant IMG_WIDTH  :integer := 320;
constant IMG_HEIGTH  :integer := 256;

--signal uppercumsum_i     : std_logic_vector(31 downto 0);

--+-----------------
-- MB CTRL
--------------------
constant C_S_AXI_DATA_WIDTH : integer := 32;
constant C_S_AXI_ADDR_WIDTH : integer := 32;
constant ADDR_LSB           : integer := 2;   -- 4 bytes access
constant OPT_MEM_ADDR_BITS  : integer := 6;   -- Number of supplement bit

----------------------------   
-- Address of registers
----------------------------   
    constant MEMORY_BASE_ADDR_ADDR       : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(0,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant NB_SEQUENCE_MAX_ADDR        : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(4,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant SEQ_IMG_TOTAL_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(8,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant FRAME_SIZE_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(12,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant BUFFER_MODE_ADDR            : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(16,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant HDR_BYTESSIZE_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(20,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant IMG_BYTESSIZE_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(24,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant NB_IMG_PRE_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(28,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant NB_IMG_POST_ADDR            : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(32,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant RD_SEQ_ID_ADDR              : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(36,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant RD_START_ID_ADDR            : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(40,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant RD_STOP_ID_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(44,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant CLEAR_MEMORY_CONTENT_ADDR   : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(48,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant BUFFER_SWITCH_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(52,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant MOI_SOURCE_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(56,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant MOI_ACTIVATION_ADDR         : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(60,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant SOFT_MOI_ADDR               : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(64,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant ACQ_STOP_ADDR               : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(68,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant CONFIG_VALID_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(72,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant NB_SEQ_IN_MEM_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(76,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant FSM_ERROR_WR_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(80,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   constant FSM_ERROR_RD_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(84,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
   

-- CLK and RESET
constant clk160_per : time := 6.25 ns;
constant clk100_per : time := 10 ns;

begin
-- Assign clock
   CLK160 <= clk160_o;
   CLK100 <= clk100_o;
   ARESETN <= rstn_i;

   

--! Clock 160MHz generation                   
CLK160_GEN: process(clk160_o)
   begin
   clk160_o <= not clk160_o after clk160_per/2;                          
end process;

CLK100_GEN: process(clk100_o)
   begin
   clk100_o <= not clk100_o after clk100_per/2;                          
end process;

--! Reset Generation
RST_GEN : process
   begin          
      rstn_i <= '0';
   wait for 5 us;
      rstn_i <= '1'; 
   wait;
end process;


MB_PROCESS : process 
variable j : integer := 0;
variable nb_seq_mem : unsigned (31 downto 0) := to_unsigned(0,32);

begin
   AXIL_BUF_MOSI.ARVALID   <= '0';
   AXIL_BUF_MOSI.ARADDR    <= (others => '0');
   AXIL_BUF_MOSI.ARPROT    <= (others => '0');
   AXIL_BUF_MOSI.RREADY    <= '0';
   AXIL_BUF_MOSI.AWADDR    <= (others => '0');
   AXIL_BUF_MOSI.AWVALID	<= '0';
   AXIL_BUF_MOSI.AWPROT    <= (others => '0');
   AXIL_BUF_MOSI.BREADY	   <='0';
   AXIL_BUF_MOSI.WDATA	   <= (others => '0');
   AXIL_BUF_MOSI.WVALID	   <= '0';
   AXIL_BUF_MOSI.WSTRB	   <= (others =>'0');
   AXIL_BUF_MOSI.ARVALID	<= '0';
   AXIL_BUF_MOSI.RREADY	   <= '0';
   AXIL_MOSI.ARVALID   <= '0';
   AXIL_MOSI.ARADDR    <= (others => '0');
   AXIL_MOSI.ARPROT    <= (others => '0');
   AXIL_MOSI.RREADY    <= '0';
   AXIL_MOSI.AWADDR    <= (others => '0');
   AXIL_MOSI.AWVALID	<= '0';
   AXIL_MOSI.AWPROT    <= (others => '0');
   AXIL_MOSI.BREADY	   <='0';
   AXIL_MOSI.WDATA	   <= (others => '0');
   AXIL_MOSI.WVALID	   <= '0';
   AXIL_MOSI.WSTRB	   <= (others =>'0');
   AXIL_MOSI.ARVALID	<= '0';
   AXIL_MOSI.RREADY	   <= '0';

    --default value
    
   ACQUISTION_STOP <= '0';
   wait until rstn_i = '1';
   wait for 1 us;

   --START MB Process
   --Configure and start the BUFFERING

    wait until rising_edge(clk100_o);
    --write_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); Value : in std_logic_vector(31 downto 0);signal  miso : in  t_axi4_lite_miso;signal  mosi : out t_axi4_lite_mosi) is
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & MEMORY_BASE_ADDR_ADDR ,   std_logic_vector(to_unsigned(0,32))         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & NB_SEQUENCE_MAX_ADDR ,    std_logic_vector(to_unsigned(4,32))       ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & SEQ_IMG_TOTAL_ADDR ,      std_logic_vector(to_unsigned(20,32))         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & FRAME_SIZE_ADDR ,         std_logic_vector(to_unsigned(64*6,32))         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & HDR_BYTESSIZE_ADDR ,      std_logic_vector(to_unsigned(64*2*2,32))         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & IMG_BYTESSIZE_ADDR ,      std_logic_vector(to_unsigned(64*4*2,32))         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & BUFFER_MODE_ADDR ,        std_logic_vector(to_unsigned(1,32))         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & NB_IMG_PRE_ADDR ,         std_logic_vector(to_unsigned(5,32))         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & NB_IMG_POST_ADDR ,        std_logic_vector(to_unsigned(15,32))       ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_START_ID_ADDR ,          std_logic_vector(to_unsigned(0,32))     ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns;
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_STOP_ID_ADDR ,          std_logic_vector(to_unsigned(0,32))     ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns;     
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_SEQ_ID_ADDR ,          std_logic_vector(to_unsigned(0,32))     ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CLEAR_MEMORY_CONTENT_ADDR ,   std_logic_vector(to_unsigned(0,32)) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & BUFFER_SWITCH_ADDR ,      std_logic_vector(to_unsigned(2,32))     ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))     & MOI_SOURCE_ADDR ,       std_logic_vector(to_unsigned(0,32)) ,AXIL_MISO ,AXIL_MOSI); --0  externe, 1 soft, 2 no moi
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))     & MOI_ACTIVATION_ADDR ,       std_logic_vector(to_unsigned(0,32)) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns;
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))     & CONFIG_VALID_ADDR ,       std_logic_vector(to_unsigned(1,32)) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);

    -- PAUSE UNTIL THERE IS 4 SEQUENCE IS THE MEMORY
    while (nb_seq_mem <4) loop
        wait for 5 ns; 
        wait until rising_edge(clk100_o);
        read_axi_lite (clk100_o, std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & NB_SEQ_IN_MEM_ADDR ,AXIL_MISO,AXIL_MOSI, read_value);
        nb_seq_mem := unsigned(read_value);
        
--        wait for 5 ns; 
--        wait until rising_edge(clk100_o);
--        write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))     & SOFT_MOI_ADDR ,       std_logic_vector(to_unsigned(1,32)) ,AXIL_MISO ,AXIL_MOSI);
--        wait for 5 ns; 
--        wait until rising_edge(clk100_o);
--        write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))     & SOFT_MOI_ADDR ,       std_logic_vector(to_unsigned(0,32)) ,AXIL_MISO ,AXIL_MOSI);
        
        wait for 50 us;
    end loop;
    
    ACQUISTION_STOP <= '1';
    --Change Buffer Mode
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CONFIG_VALID_ADDR ,    std_logic_vector(to_unsigned(0,32))       ,AXIL_MISO ,AXIL_MOSI);
    
    
    -- Change buffer mode to read img of seq id 0
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & BUFFER_MODE_ADDR ,    std_logic_vector(to_unsigned(2,32))       ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & BUFFER_SWITCH_ADDR ,    std_logic_vector(to_unsigned(3,32))       ,AXIL_MISO ,AXIL_MOSI);     
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_SEQ_ID_ADDR ,    std_logic_vector(to_unsigned(0,32))       ,AXIL_MISO ,AXIL_MOSI);
    
    --READ START LOC from ram table then write it to buf_ctrl
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    read_axi_lite (clk100_o,x"00000000",AXIL_BUF_MISO,AXIL_BUF_MOSI, read_value);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_START_ID_ADDR ,    read_value       ,AXIL_MISO ,AXIL_MOSI);
    
    --READ END LOC from ram table then write it to buf_ctrl
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    read_axi_lite (clk100_o,x"00000002",AXIL_BUF_MISO,AXIL_BUF_MOSI, read_value);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_STOP_ID_ADDR ,    read_value       ,AXIL_MISO ,AXIL_MOSI);
    
    -- config valid
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CONFIG_VALID_ADDR ,    std_logic_vector(to_unsigned(1,32))       ,AXIL_MISO ,AXIL_MOSI);
    
    --wait for 75 us;
--    
--    -- Change buffer mode to read img of seq id 1
--    -- config invalid 
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CONFIG_VALID_ADDR ,    std_logic_vector(to_unsigned(0,32))       ,AXIL_MISO ,AXIL_MOSI);
--    
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_SEQ_ID_ADDR ,    std_logic_vector(to_unsigned(1,32))       ,AXIL_MISO ,AXIL_MOSI);
--    
--    --READ START LOC from ram table then write it to buf_ctrl
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    read_axi_lite (clk100_o,x"00000004",AXIL_BUF_MISO,AXIL_BUF_MOSI, read_value);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_START_ID_ADDR ,    read_value       ,AXIL_MISO ,AXIL_MOSI);
--    
--    --READ END LOC from ram table then write it to buf_ctrl
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    read_axi_lite (clk100_o,x"00000006",AXIL_BUF_MISO,AXIL_BUF_MOSI, read_value);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_STOP_ID_ADDR ,    read_value       ,AXIL_MISO ,AXIL_MOSI);
--    
--    -- config valid
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CONFIG_VALID_ADDR ,    std_logic_vector(to_unsigned(1,32))       ,AXIL_MISO ,AXIL_MOSI);
--    
--    wait for 75 us;
--    -- Change buffer mode to read img  moi of seq id 2
--    -- config invalid 
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CONFIG_VALID_ADDR ,    std_logic_vector(to_unsigned(0,32))       ,AXIL_MISO ,AXIL_MOSI);
--    
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_SEQ_ID_ADDR ,    std_logic_vector(to_unsigned(2,32))       ,AXIL_MISO ,AXIL_MOSI);
--    
--    --READ MOI LOC from ram table then write it to buf_ctrl
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    read_axi_lite (clk100_o,x"00000009",AXIL_BUF_MISO,AXIL_BUF_MOSI, read_value);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_START_ID_ADDR ,    read_value       ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_STOP_ID_ADDR ,    read_value      ,AXIL_MISO ,AXIL_MOSI);
--    
--    -- config valid
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CONFIG_VALID_ADDR ,    std_logic_vector(to_unsigned(1,32))       ,AXIL_MISO ,AXIL_MOSI);
--    
--   
--     wait for 10 us; 
--    
--    -- Change buffer mode to read img  moi of seq id 3
--    -- config invalid 
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CONFIG_VALID_ADDR ,    std_logic_vector(to_unsigned(0,32))       ,AXIL_MISO ,AXIL_MOSI);
--    
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_SEQ_ID_ADDR ,    std_logic_vector(to_unsigned(3,32))       ,AXIL_MISO ,AXIL_MOSI);
--    
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    read_axi_lite (clk100_o,x"0000000C",AXIL_BUF_MISO,AXIL_BUF_MOSI, read_value);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_START_ID_ADDR ,    read_value       ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    read_axi_lite (clk100_o,x"0000000E",AXIL_BUF_MISO,AXIL_BUF_MOSI, read_value);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & RD_STOP_ID_ADDR ,    read_value      ,AXIL_MISO ,AXIL_MOSI);
--    
--    -- config valid
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CONFIG_VALID_ADDR ,    std_logic_vector(to_unsigned(1,32))       ,AXIL_MISO ,AXIL_MOSI);
--    
    
    -- WAIT READ IMAGE THEN CLEAR BUFFER
    wait for 200us;
    
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CONFIG_VALID_ADDR ,    std_logic_vector(to_unsigned(0,32))       ,AXIL_MISO ,AXIL_MOSI);
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CLEAR_MEMORY_CONTENT_ADDR ,    std_logic_vector(to_unsigned(1,32))       ,AXIL_MISO ,AXIL_MOSI);
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CLEAR_MEMORY_CONTENT_ADDR ,    std_logic_vector(to_unsigned(0,32))       ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & BUFFER_MODE_ADDR ,    std_logic_vector(to_unsigned(0,32))       ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-MEMORY_BASE_ADDR_ADDR'length))    & CONFIG_VALID_ADDR ,    std_logic_vector(to_unsigned(1,32))       ,AXIL_MISO ,AXIL_MOSI);
    wait;
end process MB_PROCESS;


MOI_PROCESS : process
variable i : integer := 0;
begin
    EXTERNAL_MOI <= '0';

    wait for 10 us;
    EXTERNAL_MOI <= '1';
    wait for 100 ns;
    EXTERNAL_MOI <= '0';
    wait for 100 us;
    EXTERNAL_MOI <= '1';
    wait for 100 ns;
    EXTERNAL_MOI <= '0';
    wait for 20 us;
    EXTERNAL_MOI <= '1';
    wait for 100 ns;
    EXTERNAL_MOI <= '0';
    wait for 20 us;
    EXTERNAL_MOI <= '1';
    wait for 100 ns;
    EXTERNAL_MOI <= '0';
    wait for 25 us;
    EXTERNAL_MOI <= '1';
    wait for 100 ns;
    EXTERNAL_MOI <= '0';
    wait for 35 us;
    EXTERNAL_MOI <= '1';
    wait for 100 ns;
    EXTERNAL_MOI <= '0';
    wait for 100 us;
    EXTERNAL_MOI <= '1';
    wait for 100 ns;
    EXTERNAL_MOI <= '0';
    wait;
end process MOI_PROCESS;

WATERLEVEL_PROCESS : process
begin
    WATERLEVEL <= '0';
    wait for 270 us;
    WATERLEVEL <= '1';
    wait for 15 us;
     WATERLEVEL <= '0';
    wait;
end process WATERLEVEL_PROCESS;

STALL_PROCESS : process
begin
    STALL <= '1';
    wait for 7 us;
    STALL <= '0';
    report "START OF LOOP";  
    while true loop
        wait for 2.5 us;
        STALL <= '1';
        wait for 50 ns;
        STALL <= '0';
    end loop;
    report "END OF LOOP";    
    wait;
end process STALL_PROCESS;

end rtl;
