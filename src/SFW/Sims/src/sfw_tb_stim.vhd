-------------------------------------------------------------------------------
--
-- Title       : SFW TB STIM
-- Design      : tb_sfw
-- Author      : JBO
-- Company     : Telops
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
-- Description :  Stim file for SFW simulation
--
-------------------------------------------------------------------------------

library IEEE;                                             
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.tel2000.all;

entity sfw_tb_stim is
    GENERIC(
    NB_ENCODER_COUNT : integer := 4096
    );
    port(
    --------------------------------
    -- MB Interface
    -------------------------------- 
    AXIL_MOSI : out t_axi4_lite_mosi;
    AXIL_MISO : in t_axi4_lite_miso;

    --------------------------------
    -- ENCODER
    -------------------------------- 
    CHAN_A    : out STD_LOGIC;
    CHAN_B    : out STD_LOGIC;
    CHAN_I    : out STD_LOGIC;
    --------------------------------
    -- DETECTOR
    --------------------------------
    SFW_TRIG       : in std_logic;
    FPA_EXP_INFO   : in exp_info_type;
    FPA_IMG_INFO   : out img_info_type;
    EXP_INFO_BUSY  : out std_logic;


    --------------------------------
    -- SYSTEM
    -------------------------------- 
    CLK100   : out STD_LOGIC;
    CLK80   : out STD_LOGIC;
    ARESETN   : out STD_LOGIC
    );
end sfw_tb_stim;



architecture sync of sfw_tb_stim is


-- CLK and RESET
constant clk100_per : time := 10 ns;
constant clk80_per : time := 12.5 ns;

signal clk100_o : std_logic := '0';
signal clk80_o : std_logic := '0';
signal rstn_i : std_logic := '0';

signal ReadValue : std_logic_vector(31 downto 0) := (others => '0');
signal read_value : std_logic_vector(31 downto 0) := (others => '0');
signal write_value : std_logic_vector(31 downto 0) := (others => '0');
signal write_value_u : unsigned(31 downto 0) := (others => '0');



-- encoder states channels I-A-B
constant PHASE0 : std_logic_vector(1 downto 0) := "00";
constant PHASE1 : std_logic_vector(1 downto 0) := "01";
constant PHASE2 : std_logic_vector(1 downto 0) := "11";
constant PHASE3 : std_logic_vector(1 downto 0) := "10";

-- Constants
constant SFWCTRL_BASE_ADDR_OFFSET : integer := 0;
constant SFWRAM_BASE_ADDR_OFFSET : integer:= 1024;

constant C_S_AXI_DATA_WIDTH : integer := 32;
constant C_S_AXI_ADDR_WIDTH : integer := 32;
constant ADDR_LSB           : integer := 2;   -- 4 bytes access
constant OPT_MEM_ADDR_BITS  : integer := 16;   -- Number of supplement bit
constant NUMBER_OF_FILTERS  : integer := 8;

constant FIXED_WHEEL       : integer := 0;
constant ROTATING_WHEEL    : integer := 1;
constant NOT_IMPLEMENTED   : integer := 2;

constant FW0_CENTERPOS : UNSIGNED := to_unsigned(1046,12);
constant FW1_CENTERPOS : UNSIGNED := to_unsigned(1558,12);
constant FW2_CENTERPOS : UNSIGNED := to_unsigned(2070,12);
constant FW3_CENTERPOS : UNSIGNED := to_unsigned(2582,12);
constant FW4_CENTERPOS : UNSIGNED := to_unsigned(3094,12);
constant FW5_CENTERPOS : UNSIGNED := to_unsigned(3606,12);
constant FW6_CENTERPOS : UNSIGNED := to_unsigned(23,12);
constant FW7_CENTERPOS : UNSIGNED := to_unsigned(535,12);
CONSTANT FW_WIDTH      : UNSIGNED := to_unsigned(100,12);

constant FW0_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW0_CENTERPOS - FW_WIDTH,16);
constant FW1_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW1_CENTERPOS - FW_WIDTH,16);
constant FW2_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW2_CENTERPOS - FW_WIDTH,16);
constant FW3_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW3_CENTERPOS - FW_WIDTH,16);
constant FW4_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW4_CENTERPOS - FW_WIDTH,16);
constant FW5_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW5_CENTERPOS - FW_WIDTH,16);
constant FW6_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW6_CENTERPOS - FW_WIDTH,16);
constant FW7_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW7_CENTERPOS - FW_WIDTH,16);

constant FW0_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW0_CENTERPOS + FW_WIDTH,16);
constant FW1_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW1_CENTERPOS + FW_WIDTH,16);
constant FW2_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW2_CENTERPOS + FW_WIDTH,16);
constant FW3_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW3_CENTERPOS + FW_WIDTH,16);
constant FW4_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW4_CENTERPOS + FW_WIDTH,16);
constant FW5_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW5_CENTERPOS + FW_WIDTH,16);
constant FW6_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW6_CENTERPOS + FW_WIDTH,16);
constant FW7_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW7_CENTERPOS + FW_WIDTH,16);






constant FPA_CLK_MULT_RATIO       : integer := 100;  --10ns period

constant FW0_EXPTIME_US : UNSIGNED := to_unsigned(50*FPA_CLK_MULT_RATIO,32);
constant FW1_EXPTIME_US : UNSIGNED := to_unsigned(250*FPA_CLK_MULT_RATIO,32);
constant FW2_EXPTIME_US : UNSIGNED := to_unsigned(500*FPA_CLK_MULT_RATIO,32);
constant FW3_EXPTIME_US : UNSIGNED := to_unsigned(1000*FPA_CLK_MULT_RATIO,32);
constant FW4_EXPTIME_US : UNSIGNED := to_unsigned(1500*FPA_CLK_MULT_RATIO,32);
constant FW5_EXPTIME_US : UNSIGNED := to_unsigned(3000*FPA_CLK_MULT_RATIO,32);
constant FW6_EXPTIME_US : UNSIGNED := to_unsigned(3500*FPA_CLK_MULT_RATIO,32);
constant FW7_EXPTIME_US : UNSIGNED := to_unsigned(4000*FPA_CLK_MULT_RATIO,32);

--constant SPEED_RPM      : integer := 3500;
constant SPEED_RPM      : integer := 1200;
--constant SPEED_RPM      : integer := 400;
constant sim_nb_turn    : integer := 5000;
CONSTANT CLK_FREQ       : INTEGER := 100000000;
constant RPM_FACTOR_VAL : unsigned(31 downto 0) := to_unsigned(1464843,32);
constant ENCODER_COUNT_DURATION : INTEGER := CLK_FREQ/(SPEED_RPM/60 *4096);
CONSTANT COUNT_DURATION : TIME := ENCODER_COUNT_DURATION* clk100_per;

CONSTANT DETECTOR_DELAY : TIME := 30 ns;

----------------------------   
-- Address of registers
----------------------------   
constant FW0_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(0+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW1_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(4+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW2_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(8+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW3_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(12+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW4_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(16+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW5_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(20+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW6_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(24+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW7_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(28+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant CLEAR_ERR_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(32+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant VALID_PARAM_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(36+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant WHEEL_STATE_ADDR                : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(40+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant POSITION_SETPOINT_ADDR     : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(44+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant NB_ENCODER_CNT_ADDR        : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(48+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant RPM_FACTOR_ADDR               : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(52+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant RPM_MAX_ADDR               : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(56+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));

constant FILTER_NUM_LOCK_ADDR       : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(60+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant POSITION_ADDR              : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(64+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant RPM_ADDR                   : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(68+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant ERROR_SPEED_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(72+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant SPEED_PRECISION_BIT_ADDR   : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(76+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));

constant FW0_EXPTIME_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(0+SFWRAM_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW1_EXPTIME_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(4+SFWRAM_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW2_EXPTIME_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(8+SFWRAM_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW3_EXPTIME_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(12+SFWRAM_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW4_EXPTIME_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(16+SFWRAM_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW5_EXPTIME_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(20+SFWRAM_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW6_EXPTIME_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(24+SFWRAM_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
constant FW7_EXPTIME_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(28+SFWRAM_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));


--Signals
signal lock : std_logic_vector(31 downto 0) ;
signal rand_num : integer := 0;
signal frame_id : unsigned(31 downto 0) := to_unsigned(0,32);

--Exposure time ctrl
signal exp_time_cmd : unsigned(31 downto 0);
signal exp_time_indx : std_logic_vector(7 downto 0);
signal exp_time_delay : time := 0 ns;

begin
-- Assign clock

CLK100 <= clk100_o;
CLK80 <= clk80_o;
ARESETN <= rstn_i;

CLK100_GEN: process(clk100_o)
   begin
   clk100_o <= not clk100_o after clk100_per/2;                          
end process;

CLK80_GEN: process(clk80_o)
   begin
   clk80_o <= not clk80_o after clk80_per/2;                          
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

begin
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
    
    lock <=  (others =>'0');

    --default value

    wait until rstn_i = '1';
    wait for 1 us;

   --START MB Process
   --Configure and start the SFW_CTRL

    wait until rising_edge(clk100_o);
    --write_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); Value : in std_logic_vector(31 downto 0);signal  miso : in  t_axi4_lite_miso;signal  mosi : out t_axi4_lite_mosi) is
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW0_POSITION_ADDR'length))    & FW0_POSITION_ADDR ,   std_logic_vector(FW0_MAXIMUM) & std_logic_vector(FW0_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW1_POSITION_ADDR'length))    & FW1_POSITION_ADDR ,   std_logic_vector(FW1_MAXIMUM) & std_logic_vector(FW1_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW2_POSITION_ADDR'length))    & FW2_POSITION_ADDR ,   std_logic_vector(FW2_MAXIMUM) & std_logic_vector(FW2_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW3_POSITION_ADDR'length))    & FW3_POSITION_ADDR ,   std_logic_vector(FW3_MAXIMUM) & std_logic_vector(FW3_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW4_POSITION_ADDR'length))    & FW4_POSITION_ADDR ,   std_logic_vector(FW4_MAXIMUM) & std_logic_vector(FW4_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW5_POSITION_ADDR'length))    & FW5_POSITION_ADDR ,   std_logic_vector(FW5_MAXIMUM) & std_logic_vector(FW5_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW6_POSITION_ADDR'length))    & FW6_POSITION_ADDR ,   std_logic_vector(FW6_MAXIMUM) & std_logic_vector(FW6_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW7_POSITION_ADDR'length))    & FW7_POSITION_ADDR ,   std_logic_vector(FW7_MAXIMUM) & std_logic_vector(FW7_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-CLEAR_ERR_ADDR'length))       & CLEAR_ERR_ADDR    ,   std_logic_vector(to_unsigned(1,32))       ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-WHEEL_STATE_ADDR'length))     & WHEEL_STATE_ADDR  ,   std_logic_vector(to_unsigned(ROTATING_WHEEL,32))         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-POSITION_SETPOINT_ADDR'length))   & POSITION_SETPOINT_ADDR ,   std_logic_vector(to_unsigned(1,32))         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-NB_ENCODER_CNT_ADDR'length))  & NB_ENCODER_CNT_ADDR ,   std_logic_vector(to_unsigned(NB_ENCODER_COUNT,32))       ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-RPM_FACTOR_ADDR'length))      & RPM_FACTOR_ADDR   ,   std_logic_vector(RPM_FACTOR_VAL)         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-RPM_MAX_ADDR'length))         & RPM_MAX_ADDR      ,   std_logic_vector(to_unsigned(6500,32))         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-VALID_PARAM_ADDR'length))    & VALID_PARAM_ADDR ,   std_logic_vector(to_unsigned(1,32))         ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    
    --Write Exposure time 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW0_EXPTIME_ADDR'length))    & FW0_EXPTIME_ADDR ,   std_logic_vector(FW0_EXPTIME_US) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW1_EXPTIME_ADDR'length))    & FW1_EXPTIME_ADDR ,   std_logic_vector(FW1_EXPTIME_US) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW2_EXPTIME_ADDR'length))    & FW2_EXPTIME_ADDR ,   std_logic_vector(FW2_EXPTIME_US) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW3_EXPTIME_ADDR'length))    & FW3_EXPTIME_ADDR ,   std_logic_vector(FW3_EXPTIME_US) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW4_EXPTIME_ADDR'length))    & FW4_EXPTIME_ADDR ,   std_logic_vector(FW4_EXPTIME_US) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW5_EXPTIME_ADDR'length))    & FW5_EXPTIME_ADDR ,   std_logic_vector(FW5_EXPTIME_US) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW6_EXPTIME_ADDR'length))    & FW6_EXPTIME_ADDR ,   std_logic_vector(FW6_EXPTIME_US) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o); 
    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW7_EXPTIME_ADDR'length))    & FW7_EXPTIME_ADDR ,   std_logic_vector(FW7_EXPTIME_US) ,AXIL_MISO ,AXIL_MOSI);
    wait for 5 ns; 
    wait until rising_edge(clk100_o);
    
    --Wait for the ctrl to lock
    while(lock(0) = '0') loop
        read_axi_lite(clk100_o, std_logic_vector(to_unsigned(0,32-ERROR_SPEED_ADDR'length))    & ERROR_SPEED_ADDR , AXIL_MISO, AXIL_MOSI, lock);
        wait for 5 ns; 
        wait until rising_edge(clk100_o);     
        wait for 1 ms;
    end loop;
    report "ERROR SPEED - END of MB simulation";  
    wait;
end process MB_PROCESS;


WHEEL_ROTATION_PROCESS : process
variable phase :integer := 0;
begin
    wait until rstn_i = '1';
    wait for 1 ms;
    
    
    --start rotation process
    for j in 0 to sim_nb_turn loop
        for i in 0 to (NB_ENCODER_COUNT-1) loop
            if ( i = 0 ) then
                CHAN_I <= '1';   
            else
                CHAN_I <= '0';
            end if;
            
            if (phase = 0) then
                CHAN_B <= '0';
                CHAN_A <= '0';
                phase := 1;
            elsif (phase = 1) then
                CHAN_B <= '0';
                CHAN_A <= '1';
                phase := 2;
            elsif (phase = 2) then
                CHAN_B <= '1';
                CHAN_A <= '1';
                phase := 3;
            elsif (phase = 3) then
                CHAN_B <= '1';
                CHAN_A <= '0';
                phase := 0;
            end if;
            
            --pause for the duration of a encoder step
            WAIT FOR COUNT_DURATION;
        end loop;
     end loop;
    wait;    
end process WHEEL_ROTATION_PROCESS;



FPA_EXPINFO_CTRL_PROCESS : process
begin
    exp_time_indx <= (others => '0');
    exp_time_cmd <= (others => '0');
    wait until rstn_i = '1';
    
    for i in 0 to sim_nb_turn*8 loop
        -- Wait for valid integration time
        wait until FPA_EXP_INFO.exp_dval = '1';
        exp_time_cmd <= FPA_EXP_INFO.exp_time;
        exp_time_indx <= FPA_EXP_INFO.exp_indx;
        wait until rising_edge(CLK80_o); 
    end loop;

    wait;    
end process FPA_EXPINFO_CTRL_PROCESS;

FPA_IMGINFO_CTRL_PROCESS : process
begin
    FPA_IMG_INFO.exp_feedbk <= '0';
    FPA_IMG_INFO.frame_id <= (others => '0');
    FPA_IMG_INFO.exp_info.exp_time <= (others => '0');
    FPA_IMG_INFO.exp_info.exp_indx <= (others => '0');
    FPA_IMG_INFO.exp_info.exp_dval <= '0';
    EXP_INFO_BUSY <= '0';
    wait until rstn_i = '1';
    
    for i in 0 to sim_nb_turn*8 loop
        wait until SFW_TRIG = '1';

        --Lacth exposure time parameter
        wait for DETECTOR_DELAY; -- detector delay (30 ns)
        wait until rising_edge(CLK80_o);
        FPA_IMG_INFO.exp_feedbk <= '1';
        FPA_IMG_INFO.frame_id <= frame_id;
        FPA_IMG_INFO.exp_info.exp_dval <= '1';
        FPA_IMG_INFO.exp_info.exp_time <= exp_time_cmd;
        FPA_IMG_INFO.exp_info.exp_indx <= exp_time_indx;
        exp_time_delay <= to_integer(exp_time_cmd) * 10 ns;
        EXP_INFO_BUSY <= '1';
        wait for exp_time_delay;
        wait until rising_edge(CLK80_o); 
        --Stop img integration
        FPA_IMG_INFO.exp_feedbk <= '0';
        FPA_IMG_INFO.exp_info.exp_dval <= '0';
        frame_id <= frame_id+1;
        EXP_INFO_BUSY <= '0';
    end loop;

    wait;    
end process FPA_IMGINFO_CTRL_PROCESS;

end sync;

--architecture async of sfw_tb_stim is
--
--
---- CLK and RESET
--constant clk100_per : time := 10 ns;
--constant clk80_per : time := 12.5 ns;
--
--signal clk100_o : std_logic := '0';
--signal clk80_o : std_logic := '0';
--signal rstn_i : std_logic := '0';
--
--signal ReadValue : std_logic_vector(31 downto 0) := (others => '0');
--signal read_value : std_logic_vector(31 downto 0) := (others => '0');
--signal write_value : std_logic_vector(31 downto 0) := (others => '0');
--signal write_value_u : unsigned(31 downto 0) := (others => '0');
--
--
--
---- encoder states channels I-A-B
--constant PHASE0 : std_logic_vector(1 downto 0) := "00";
--constant PHASE1 : std_logic_vector(1 downto 0) := "01";
--constant PHASE2 : std_logic_vector(1 downto 0) := "11";
--constant PHASE3 : std_logic_vector(1 downto 0) := "10";
--
---- Constants
--constant SFWCTRL_BASE_ADDR_OFFSET : integer := 0;
--constant SFWRAM_BASE_ADDR_OFFSET : integer:= 1024;
--
--constant C_S_AXI_DATA_WIDTH : integer := 32;
--constant C_S_AXI_ADDR_WIDTH : integer := 32;
--constant ADDR_LSB           : integer := 2;   -- 4 bytes access
--constant OPT_MEM_ADDR_BITS  : integer := 16;   -- Number of supplement bit
--constant NUMBER_OF_FILTERS  : integer := 8;
--
--constant FIXED_WHEEL       : integer := 0;
--constant ROTATING_WHEEL    : integer := 1;
--constant NOT_IMPLEMENTED   : integer := 2;
--
--constant FW0_CENTERPOS : UNSIGNED := to_unsigned(100,12);
--constant FW1_CENTERPOS : UNSIGNED := to_unsigned(200,12);
--constant FW2_CENTERPOS : UNSIGNED := to_unsigned(300,12);
--constant FW3_CENTERPOS : UNSIGNED := to_unsigned(400,12);
--constant FW4_CENTERPOS : UNSIGNED := to_unsigned(500,12);
--constant FW5_CENTERPOS : UNSIGNED := to_unsigned(600,12);
--constant FW6_CENTERPOS : UNSIGNED := to_unsigned(700,12);
--constant FW7_CENTERPOS : UNSIGNED := to_unsigned(800,12);
--CONSTANT FW_WIDTH      : UNSIGNED := to_unsigned(10,12);
--
--constant FW0_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW0_CENTERPOS - FW_WIDTH,16);
--constant FW1_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW1_CENTERPOS - FW_WIDTH,16);
--constant FW2_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW2_CENTERPOS - FW_WIDTH,16);
--constant FW3_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW3_CENTERPOS - FW_WIDTH,16);
--constant FW4_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW4_CENTERPOS - FW_WIDTH,16);
--constant FW5_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW5_CENTERPOS - FW_WIDTH,16);
--constant FW6_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW6_CENTERPOS - FW_WIDTH,16);
--constant FW7_MINIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW7_CENTERPOS - FW_WIDTH,16);
--
--constant FW0_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW0_CENTERPOS + FW_WIDTH,16);
--constant FW1_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW1_CENTERPOS + FW_WIDTH,16);
--constant FW2_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW2_CENTERPOS + FW_WIDTH,16);
--constant FW3_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW3_CENTERPOS + FW_WIDTH,16);
--constant FW4_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW4_CENTERPOS + FW_WIDTH,16);
--constant FW5_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW5_CENTERPOS + FW_WIDTH,16);
--constant FW6_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW6_CENTERPOS + FW_WIDTH,16);
--constant FW7_MAXIMUM : UNSIGNED(15 DOWNTO 0) := resize(FW7_CENTERPOS + FW_WIDTH,16);
--
--
--
--
--
--
--constant FPA_CLK_MULT_RATIO       : integer := 100;  --10ns period
--
--constant EXPTIME_US : UNSIGNED := to_unsigned(100*FPA_CLK_MULT_RATIO,32);
--
--
----constant SPEED_RPM      : integer := 3500;
--constant SPEED_RPM      : integer := 1200;
----constant SPEED_RPM      : integer := 400;
--constant sim_nb_turn    : integer := 5000;
--CONSTANT CLK_FREQ       : INTEGER := 100000000;
--constant RPM_FACTOR_VAL : unsigned(31 downto 0) := to_unsigned(1464843,32);
--constant ENCODER_COUNT_DURATION : INTEGER := CLK_FREQ/(SPEED_RPM/60 *4096);
--CONSTANT COUNT_DURATION : TIME := ENCODER_COUNT_DURATION* clk100_per;
--
--CONSTANT DETECTOR_DELAY : TIME := 1 us;
--
------------------------------   
---- Address of registers
------------------------------   
--constant FW0_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(0+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant FW1_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(4+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant FW2_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(8+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant FW3_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(12+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant FW4_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(16+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant FW5_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(20+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant FW6_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(24+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant FW7_POSITION_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(28+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant CLEAR_ERR_ADDR             : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(32+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant VALID_PARAM_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(36+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant WHEEL_STATE_ADDR                : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(40+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant POSITION_SETPOINT_ADDR     : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(44+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant NB_ENCODER_CNT_ADDR        : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(48+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant RPM_FACTOR_ADDR               : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(52+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant RPM_MAX_ADDR               : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(56+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--
--constant FILTER_NUM_LOCK_ADDR       : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(60+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant POSITION_ADDR              : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(64+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant RPM_ADDR                   : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(68+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant ERROR_SPEED_ADDR           : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(72+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--constant SPEED_PRECISION_BIT_ADDR   : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(76+SFWCTRL_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--
--constant EXPTIME_ADDR          : std_logic_vector(ADDR_LSB + OPT_MEM_ADDR_BITS downto 0) := std_logic_vector(to_unsigned(0+SFWRAM_BASE_ADDR_OFFSET,ADDR_LSB + OPT_MEM_ADDR_BITS + 1));
--
--
----Signals
--signal lock : std_logic_vector(31 downto 0) ;
--signal rand_num : integer := 0;
--signal frame_id : unsigned(31 downto 0) := to_unsigned(0,32);
--
----Exposure time ctrl
--signal exp_time_cmd : unsigned(31 downto 0);
--signal exp_time_indx : unsigned(7 downto 0);
--
--begin
---- Assign clock
--
--CLK100 <= clk100_o;
--CLK80 <= clk80_o;
--ARESETN <= rstn_i;
--
--CLK100_GEN: process(clk100_o)
--   begin
--   clk100_o <= not clk100_o after clk100_per/2;                          
--end process;
--
--CLK80_GEN: process(clk80_o)
--   begin
--   clk80_o <= not clk80_o after clk80_per/2;                          
--end process;
--
----! Reset Generation
--RST_GEN : process
--   begin          
--      rstn_i <= '0';
--   wait for 5 us;
--      rstn_i <= '1'; 
--   wait;
--end process;
--
--
--MB_PROCESS : process
--variable j : integer := 0;
--
--begin
--    AXIL_MOSI.ARVALID   <= '0';
--    AXIL_MOSI.ARADDR    <= (others => '0');
--    AXIL_MOSI.ARPROT    <= (others => '0');
--    AXIL_MOSI.RREADY    <= '0';
--    AXIL_MOSI.AWADDR    <= (others => '0');
--    AXIL_MOSI.AWVALID	<= '0';
--    AXIL_MOSI.AWPROT    <= (others => '0');
--    AXIL_MOSI.BREADY	   <='0';
--    AXIL_MOSI.WDATA	   <= (others => '0');
--    AXIL_MOSI.WVALID	   <= '0';
--    AXIL_MOSI.WSTRB	   <= (others =>'0');
--    AXIL_MOSI.ARVALID	<= '0';
--    AXIL_MOSI.RREADY	   <= '0';
--    
--    lock <=  (others =>'0');
--
--    --default value
--
--    wait until rstn_i = '1';
--    wait for 1 us;
--
--   --START MB Process
--   --Configure and start the SFW_CTRL
--
--    wait until rising_edge(clk100_o);
--    --write_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); Value : in std_logic_vector(31 downto 0);signal  miso : in  t_axi4_lite_miso;signal  mosi : out t_axi4_lite_mosi) is
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW0_POSITION_ADDR'length))    & FW0_POSITION_ADDR ,   std_logic_vector(FW0_MAXIMUM) & std_logic_vector(FW0_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW1_POSITION_ADDR'length))    & FW1_POSITION_ADDR ,   std_logic_vector(FW1_MAXIMUM) & std_logic_vector(FW1_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o); 
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW2_POSITION_ADDR'length))    & FW2_POSITION_ADDR ,   std_logic_vector(FW2_MAXIMUM) & std_logic_vector(FW2_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o); 
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW3_POSITION_ADDR'length))    & FW3_POSITION_ADDR ,   std_logic_vector(FW3_MAXIMUM) & std_logic_vector(FW3_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW4_POSITION_ADDR'length))    & FW4_POSITION_ADDR ,   std_logic_vector(FW4_MAXIMUM) & std_logic_vector(FW4_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW5_POSITION_ADDR'length))    & FW5_POSITION_ADDR ,   std_logic_vector(FW5_MAXIMUM) & std_logic_vector(FW5_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o); 
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW6_POSITION_ADDR'length))    & FW6_POSITION_ADDR ,   std_logic_vector(FW6_MAXIMUM) & std_logic_vector(FW6_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o); 
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-FW7_POSITION_ADDR'length))    & FW7_POSITION_ADDR ,   std_logic_vector(FW7_MAXIMUM) & std_logic_vector(FW7_MINIMUM) ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-CLEAR_ERR_ADDR'length))       & CLEAR_ERR_ADDR    ,   std_logic_vector(to_unsigned(1,32))       ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o); 
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-WHEEL_STATE_ADDR'length))     & WHEEL_STATE_ADDR  ,   std_logic_vector(to_unsigned(ROTATING_WHEEL,32))         ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-POSITION_SETPOINT_ADDR'length))   & POSITION_SETPOINT_ADDR ,   std_logic_vector(to_unsigned(1,32))         ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-NB_ENCODER_CNT_ADDR'length))  & NB_ENCODER_CNT_ADDR ,   std_logic_vector(to_unsigned(NB_ENCODER_COUNT,32))       ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o); 
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-RPM_FACTOR_ADDR'length))      & RPM_FACTOR_ADDR   ,   std_logic_vector(RPM_FACTOR_VAL)         ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o); 
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-RPM_MAX_ADDR'length))         & RPM_MAX_ADDR      ,   std_logic_vector(to_unsigned(6500,32))         ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-VALID_PARAM_ADDR'length))    & VALID_PARAM_ADDR ,   std_logic_vector(to_unsigned(1,32))         ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o); 
--    
--    --Write Exposure time 
--    write_axi_lite(clk100_o,std_logic_vector(to_unsigned(0,32-EXPTIME_ADDR'length))    & EXPTIME_ADDR ,   std_logic_vector(EXPTIME_US) ,AXIL_MISO ,AXIL_MOSI);
--    wait for 5 ns; 
--    wait until rising_edge(clk100_o);
--
--    
--    --Wait for the ctrl to lock
--    while(lock(0) = '0') loop
--        read_axi_lite(clk100_o, std_logic_vector(to_unsigned(0,32-ERROR_SPEED_ADDR'length))    & ERROR_SPEED_ADDR , AXIL_MISO, AXIL_MOSI, lock);
--        wait for 5 ns; 
--        wait until rising_edge(clk100_o);     
--        wait for 1 ms;
--    end loop;
--    report "ERROR SPEED - END of MB simulation";  
--    wait;
--end process MB_PROCESS;
--
--
--WHEEL_ROTATION_PROCESS : process
--variable phase :integer := 0;
--begin
--    wait until rstn_i = '1';
--    wait for 1 ms;
--    
--    
--    --start rotation process
--    for j in 0 to sim_nb_turn loop
--        for i in 0 to (NB_ENCODER_COUNT-1) loop
--            if ( i = 0 ) then
--                CHAN_I <= '1';   
--            else
--                CHAN_I <= '0';
--            end if;
--            
--            if (phase = 0) then
--                CHAN_B <= '0';
--                CHAN_A <= '0';
--                phase := 1;
--            elsif (phase = 1) then
--                CHAN_B <= '0';
--                CHAN_A <= '1';
--                phase := 2;
--            elsif (phase = 2) then
--                CHAN_B <= '1';
--                CHAN_A <= '1';
--                phase := 3;
--            elsif (phase = 3) then
--                CHAN_B <= '1';
--                CHAN_A <= '0';
--                phase := 0;
--            end if;
--            
--            --pause for the duration of a encoder step
--            WAIT FOR COUNT_DURATION;
--        end loop;
--     end loop;
--    wait;    
--end process WHEEL_ROTATION_PROCESS;
--
--
--
--EXP_CTRL_PROCESS : process
--variable exp_time_delay : time := 0 ns;
--
--    
--begin
--    FPA_IMG_INFO.exp_feedbk <= '0';
--    FPA_IMG_INFO.frame_id <= (others => '0');
--    FPA_IMG_INFO.exp_info.exp_time <= EXPTIME_US;
--    FPA_IMG_INFO.exp_info.exp_indx <= (others => '0');
--    FPA_IMG_INFO.exp_info.exp_dval <= '0';
--    EXP_INFO_BUSY <= '0';
--    exp_time_indx <= (others => '0');
--    exp_time_cmd <= EXPTIME_US;
--    wait until rstn_i = '1';
--    
--    for i in 0 to 10000 loop
--        --Lacth exposure time parameter
--        wait for DETECTOR_DELAY; -- detector delay (30 ns)
--        wait until rising_edge(CLK80_o);
--        FPA_IMG_INFO.exp_feedbk <= '1';
--        FPA_IMG_INFO.frame_id <= frame_id;
--        FPA_IMG_INFO.exp_info.exp_dval <= '1';
--        FPA_IMG_INFO.exp_info.exp_time <= exp_time_cmd;
--        FPA_IMG_INFO.exp_info.exp_indx <= std_logic_vector(exp_time_indx);
--        exp_time_delay := to_integer(exp_time_cmd) * 10 ns;
--        EXP_INFO_BUSY <= '1';
--        wait for exp_time_delay;
--        wait until rising_edge(CLK80_o); 
--        --Stop img integration
--        FPA_IMG_INFO.exp_feedbk <= '0';
--        FPA_IMG_INFO.exp_info.exp_dval <= '0';
--        frame_id <= frame_id+1;
--        exp_time_indx <= exp_time_indx + 1;
--        EXP_INFO_BUSY <= '0';
--    end loop;
--
--    wait;    
--end process EXP_CTRL_PROCESS;
--
--end async;