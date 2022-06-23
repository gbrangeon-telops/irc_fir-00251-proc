----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/18/2020 02:41:48 PM
-- Design Name: 
-- Module Name: isc0209a_tb - TB_ARCHITECTURE
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

library work;
use work.TEL2000.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AXIL_LUT_tb is
end AXIL_LUT_tb;

architecture TB_ARCHITECTURE of AXIL_LUT_tb is
   
   component axil32_to_native
     port (
          ARESET : in STD_LOGIC;
          AXIL_MOSI : in T_AXI4_LITE_MOSI;
          CLK : in STD_LOGIC;
          RD_BUSY : in STD_LOGIC;
          RD_DATA : in STD_LOGIC_VECTOR(31 downto 0);
          RD_DVAL : in STD_LOGIC;
          WR_BUSY : in STD_LOGIC;
          AXIL_MISO : out T_AXI4_LITE_MISO;
          ERR : out STD_LOGIC;
          RD_ADD : out STD_LOGIC_VECTOR(31 downto 0);
          RD_EN : out STD_LOGIC;
          WR_ADD : out STD_LOGIC_VECTOR(31 downto 0);
          WR_DATA : out STD_LOGIC_VECTOR(31 downto 0);
          WR_EN : out STD_LOGIC;
          WR_STRB : out STD_LOGIC_VECTOR(3 downto 0)
     );
   end component;
   
   component LUT_native_switch
     port (
          AXI_LITE_RD_ADD : in STD_LOGIC_VECTOR(31 downto 0);
          AXI_LITE_RD_EN : in STD_LOGIC;
          BRAM_RD_DATA : in STD_LOGIC_VECTOR(31 downto 0);
          BRAM_RD_DVAL : in STD_LOGIC;
          BRAM_RD_EOF_OUT : in STD_LOGIC;
          READ_PORT_RD_ADD : in STD_LOGIC_VECTOR(31 downto 0);
          READ_PORT_RD_EN : in STD_LOGIC;
          READ_PORT_RD_EOF_IN : in STD_LOGIC;
          SWITCH : in STD_LOGIC;
          AXI_LITE_RD_BUSY : out STD_LOGIC;
          AXI_LITE_RD_DATA : out STD_LOGIC_VECTOR(31 downto 0);
          AXI_LITE_RD_DVAL : out STD_LOGIC;
          BRAM_RD_ADD : out STD_LOGIC_VECTOR(31 downto 0);
          BRAM_RD_EN : out STD_LOGIC;
          BRAM_RD_EOF_IN : out STD_LOGIC;
          READ_PORT_DATA : out STD_LOGIC_VECTOR(31 downto 0);
          READ_PORT_RD_DVAL : out STD_LOGIC;
          READ_PORT_RD_EOF_OUT : out STD_LOGIC
     );
   end component;
   
   component tdp_ram_w32
     generic(
          PAGE_ADD_WIDTH : NATURAL := 14;
          PAGE_NUMBER : NATURAL := 64
     );
     port (
          ARESET : in STD_LOGIC;
          A_CLK : in STD_LOGIC;
          A_RD : in STD_LOGIC;
          A_RD_ADD : in STD_LOGIC_VECTOR(31 downto 0);
          A_RD_EOF_IN : in STD_LOGIC;
          A_WR : in STD_LOGIC;
          A_WR_ADD : in STD_LOGIC_VECTOR(31 downto 0);
          A_WR_DATA : in STD_LOGIC_VECTOR(31 downto 0);
          B_CLK : in STD_LOGIC;
          B_RD : in STD_LOGIC;
          B_RD_ADD : in STD_LOGIC_VECTOR(31 downto 0);
          B_RD_EOF_IN : in STD_LOGIC;
          B_WR : in STD_LOGIC;
          B_WR_ADD : in STD_LOGIC_VECTOR(31 downto 0);
          B_WR_DATA : in STD_LOGIC_VECTOR(31 downto 0);
          A_ERR : out STD_LOGIC;
          A_RD_DATA : out STD_LOGIC_VECTOR(31 downto 0);
          A_RD_DVAL : out STD_LOGIC;
          A_RD_EOF_OUT : out STD_LOGIC;
          B_ERR : out STD_LOGIC;
          B_RD_DATA : out STD_LOGIC_VECTOR(31 downto 0);
          B_RD_DVAL : out STD_LOGIC;
          B_RD_EOF_OUT : out STD_LOGIC
     );
   end component;

   constant CLK_100M_PERIOD : time := 10 ns;
   constant C_S_AXI_DATA_WIDTH : integer := 32;
   constant C_S_AXI_ADDR_WIDTH : integer := 32;
   
   signal areset : std_logic;
   signal CLK_100M : std_logic := '0';
   signal ERR : std_logic_vector(1 downto 0);
   signal AXIL_MOSI : T_AXI4_LITE_MOSI;
   signal AXIL_MISO : T_AXI4_LITE_MISO;
   signal BRAM_RD_DATA : STD_LOGIC_VECTOR(31 downto 0);
   signal BRAM_RD_DVAL : STD_LOGIC;
   signal BRAM_RD_EOF_OUT : STD_LOGIC;
   signal BRAM_RD_ADD : STD_LOGIC_VECTOR(31 downto 0);
   signal BRAM_RD_EN : STD_LOGIC;
   signal BRAM_RD_EOF_IN : STD_LOGIC;
   signal BRAM_WR_EN : STD_LOGIC;
   signal BRAM_WR_ADD : STD_LOGIC_VECTOR(31 downto 0);
   signal BRAM_WR_DATA : STD_LOGIC_VECTOR(31 downto 0);
   signal AXI_LITE_RD_ADD : STD_LOGIC_VECTOR(31 downto 0);
   signal AXI_LITE_RD_EN : STD_LOGIC;
   signal AXI_LITE_RD_BUSY : STD_LOGIC;
   signal AXI_LITE_RD_DATA : STD_LOGIC_VECTOR(31 downto 0);
   signal AXI_LITE_RD_DVAL : STD_LOGIC;
   signal readData0, readData1 : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
             

begin

   -- reset
   process
   begin
      areset <= '1'; 
      wait for 250 ns;
      areset <= '0';
      wait;
   end process;
   
   -- clk 100MHz
   process(CLK_100M)
   begin
      CLK_100M <= not CLK_100M after CLK_100M_PERIOD/2; 
   end process;
    
   -- µBlaze simulation
   MB_PROCESS : process 
   begin
      AXIL_MOSI.awaddr <= (others => '0');
      AXIL_MOSI.awprot <= (others => '0');
      AXIL_MOSI.wdata <= (others => '0');
      AXIL_MOSI.wstrb <= (others => '0');
      AXIL_MOSI.araddr <= (others => '0');
      AXIL_MOSI.arprot <= (others => '0');
      AXIL_MOSI.awvalid <= '0';
      AXIL_MOSI.wvalid <= '0';
      AXIL_MOSI.bready <= '0';
      AXIL_MOSI.arvalid <= '0';
      AXIL_MOSI.rready <= '0';
      
      wait until areset = '0';
      
      wait for 50 ns;
      
      -- write values in LUT
      wait until rising_edge(CLK_100M);
      write_axi_lite(CLK_100M, resize(x"0", C_S_AXI_ADDR_WIDTH), resize(x"F1", C_S_AXI_DATA_WIDTH), AXIL_MISO, AXIL_MOSI);
      wait until rising_edge(CLK_100M);
      write_axi_lite(CLK_100M, resize(x"1", C_S_AXI_ADDR_WIDTH), resize(x"F2", C_S_AXI_DATA_WIDTH), AXIL_MISO, AXIL_MOSI);
      
      -- read values in LUT
      wait until rising_edge(CLK_100M);
      read_axi_lite(CLK_100M, resize(x"0", C_S_AXI_ADDR_WIDTH), AXIL_MISO, AXIL_MOSI, readData0);
      wait until rising_edge(CLK_100M);
      read_axi_lite(CLK_100M, resize(x"1", C_S_AXI_ADDR_WIDTH), AXIL_MISO, AXIL_MOSI, readData1);
      
   end process MB_PROCESS;
    
    U1 : axil32_to_native
      port map(
           ARESET => areset,
           AXIL_MISO => AXIL_MISO,
           AXIL_MOSI => AXIL_MOSI,
           CLK => CLK_100M,
           ERR => ERR(0),
           RD_ADD => AXI_LITE_RD_ADD,
           RD_BUSY => AXI_LITE_RD_BUSY,
           RD_DATA => AXI_LITE_RD_DATA,
           RD_DVAL => AXI_LITE_RD_DVAL,
           RD_EN => AXI_LITE_RD_EN,
           WR_ADD => BRAM_WR_ADD,
           WR_BUSY => '0',
           WR_DATA => BRAM_WR_DATA,
           WR_EN => BRAM_WR_EN
      );
   
   U2 : LUT_native_switch
     port map(
          AXI_LITE_RD_ADD => AXI_LITE_RD_ADD,
          AXI_LITE_RD_BUSY => AXI_LITE_RD_BUSY,
          AXI_LITE_RD_DATA => AXI_LITE_RD_DATA,
          AXI_LITE_RD_DVAL => AXI_LITE_RD_DVAL,
          AXI_LITE_RD_EN => AXI_LITE_RD_EN,
          BRAM_RD_ADD => BRAM_RD_ADD,
          BRAM_RD_DATA => BRAM_RD_DATA,
          BRAM_RD_DVAL => BRAM_RD_DVAL,
          BRAM_RD_EN => BRAM_RD_EN,
          BRAM_RD_EOF_IN => BRAM_RD_EOF_IN,
          BRAM_RD_EOF_OUT => BRAM_RD_EOF_OUT,
          READ_PORT_DATA => open,
          READ_PORT_RD_ADD => (others => '0'),
          READ_PORT_RD_DVAL => open,
          READ_PORT_RD_EN => '0',
          READ_PORT_RD_EOF_IN => '0',
          READ_PORT_RD_EOF_OUT => open,
          SWITCH => '1'
     );
   
   U3 : tdp_ram_w32
     generic map (
          PAGE_ADD_WIDTH => 8,
          PAGE_NUMBER => 64
     )
     port map(
          ARESET => areset,
          A_CLK => CLK_100M,
          A_ERR => ERR(1),
          A_RD => BRAM_RD_EN,
          A_RD_ADD => BRAM_RD_ADD,
          A_RD_DATA => BRAM_RD_DATA,
          A_RD_DVAL => BRAM_RD_DVAL,
          A_RD_EOF_IN => BRAM_RD_EOF_IN,
          A_RD_EOF_OUT => BRAM_RD_EOF_OUT,
          A_WR => BRAM_WR_EN,
          A_WR_ADD => BRAM_WR_ADD,
          A_WR_DATA => BRAM_WR_DATA,
          B_CLK => '0',
          B_ERR => open,
          B_RD => '0',
          B_RD_ADD => (others => '0'),
          B_RD_DATA => open,
          B_RD_DVAL => open,
          B_RD_EOF_IN => '0',
          B_RD_EOF_OUT => open,
          B_WR => '0',
          B_WR_ADD => (others => '0'),
          B_WR_DATA => (others => '0')
     );
   
   
end TB_ARCHITECTURE;
