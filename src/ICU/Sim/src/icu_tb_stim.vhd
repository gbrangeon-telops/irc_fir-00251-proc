-------------------------------------------------------------------------------
--
-- Title       : ICU TB STIM
-- Design      : clink_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\telops\FIR-00251-Proc\src\ICU\Sim\src\axis_lane_stim.vhd
-- Generated   : Thu Jan 30 13:26:14 2014
-- From        : interface description file
-- By          : 
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library ieee;                                             
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;

entity icu_tb_stim is
   port(
      --------------------------------
      -- PowerPC Interface
      -------------------------------- 
      AXIL_MOSI : out t_axi4_lite_mosi;
      AXIL_MISO : in t_axi4_lite_miso;  
      
      CLK   : out STD_LOGIC;
      ARESET   : out STD_LOGIC
      );
end icu_tb_stim;

architecture rtl of icu_tb_stim is
   
   -- CLK and RESET
   signal clk_o : std_logic := '0';
   signal rst_i : std_logic := '0';
   
   signal pulse_width_i         : std_logic_vector(31 downto 0); -- [ms]
   signal period_i              : std_logic_vector(31 downto 0); -- [ms]
   signal transition_duration_i : std_logic_vector(31 downto 0); -- [ms]
   signal cmd_i                 : std_logic_vector(31 downto 0); -- "00", off "01", move forward, "10" move reverse
   signal mode_i                : std_logic_vector(31 downto 0);  -- "00" one-shot, "01" repeat
   signal polarity_i            : std_logic_vector(31 downto 0); -- '0' forward, '1' reverse
   
   signal status_i              : std_logic_vector(31 downto 0); -- "00", scene, "01" calib, "10" moving, "11" off
   
   constant C_S_AXI_DATA_WIDTH : integer := 32;
   constant C_S_AXI_ADDR_WIDTH : integer := 32;
   constant ADDR_LSB           : integer := 2;   -- 4 bytes access
   constant OPT_MEM_ADDR_BITS  : integer := 5;   -- Number of supplement bit
   constant ADDR_LENGTH        : integer := ADDR_LSB + 1 + OPT_MEM_ADDR_BITS;
   
   ----------------------------   
   -- Address of registers
   ----------------------------   
   constant ICU_MODE_ADDR                 : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(0,ADDR_LENGTH));
   constant ICU_PULSE_WIDTH_ADDR          : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(4,ADDR_LENGTH));
   constant ICU_PERIOD_ADDR               : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(8,ADDR_LENGTH));
   constant ICU_CALIB_POLARITY_ADDR       : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(12,ADDR_LENGTH));
   constant ICU_TRANSITION_DURATION_ADDR  : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(16,ADDR_LENGTH));
   constant ICU_PULSE_CMD_ADDR            : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(20,ADDR_LENGTH));
   constant ICU_STATUS_ADDR               : std_logic_vector(ADDR_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(24,ADDR_LENGTH));
      
   -- CLK and RESET
   constant CLK_per : time := 10 ns;
   
   constant CLK_PER_MSEC : integer := 100000;
   
begin
   -- Assign clock
   CLK <= clk_o;
   ARESET <= rst_i;
   
   CLK_GEN: process(clk_o)
   begin
      clk_o <= not clk_o after CLK_per/2;                          
   end process;
   
   --! Reset Generation
   RST_GEN : process
   begin          
      rst_i <= '1';
      wait for 5 us;
      rst_i <= '0'; 
      wait;
   end process;
   
   MB_PROCESS : process 
      variable j : integer := 0;
   begin     
      pulse_width_i         <= std_logic_vector(to_unsigned(1 * CLK_PER_MSEC, 32));
      period_i              <= std_logic_vector(to_unsigned(3 * CLK_PER_MSEC, 32));
      transition_duration_i <= std_logic_vector(to_unsigned(4 * CLK_PER_MSEC, 32));
      cmd_i                 <= std_logic_vector(to_unsigned(0, 32));
      mode_i                <= std_logic_vector(to_unsigned(1, 32));
      polarity_i            <= std_logic_vector(to_unsigned(0, 32));
      
      wait until rst_i = '0';
      wait for 1 us;
      
      -- send initial config
      write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_MODE_ADDR'length))                & ICU_MODE_ADDR,                 mode_i, AXIL_MISO, AXIL_MOSI);
      write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_PULSE_WIDTH_ADDR'length))         & ICU_PULSE_WIDTH_ADDR,          pulse_width_i, AXIL_MISO, AXIL_MOSI);
      write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_PERIOD_ADDR'length))              & ICU_PERIOD_ADDR,               period_i, AXIL_MISO, AXIL_MOSI);
      write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_TRANSITION_DURATION_ADDR'length)) & ICU_TRANSITION_DURATION_ADDR,  transition_duration_i, AXIL_MISO, AXIL_MOSI);
      write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_CALIB_POLARITY_ADDR'length))      & ICU_CALIB_POLARITY_ADDR,       polarity_i, AXIL_MISO, AXIL_MOSI);
      
      while(true) loop   
         -- Scene setpoint
         cmd_i                 <= std_logic_vector(to_unsigned(2, 32));
         wait until rising_edge(clk_o);
         
         write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_PULSE_CMD_ADDR'length))                & ICU_PULSE_CMD_ADDR,                 cmd_i, AXIL_MISO, AXIL_MOSI);
         wait until rising_edge(clk_o);
         --READ axi register
         read_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_STATUS_ADDR'length))            & ICU_STATUS_ADDR, AXIL_MISO, AXIL_MOSI, status_i);
         wait until rising_edge(clk_o);
         wait for 10 ms;
         -- CALIB set point
         cmd_i                 <= std_logic_vector(to_unsigned(1, 32));
         wait until rising_edge(clk_o);
         write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_PULSE_CMD_ADDR'length))                & ICU_PULSE_CMD_ADDR,                 cmd_i, AXIL_MISO, AXIL_MOSI);
         wait until rising_edge(clk_o);        
         read_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_STATUS_ADDR'length))            & ICU_STATUS_ADDR, AXIL_MISO, AXIL_MOSI, status_i);
         wait until rising_edge(clk_o);
         wait for 1 ms;
         read_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_STATUS_ADDR'length))            & ICU_STATUS_ADDR, AXIL_MISO, AXIL_MOSI, status_i);
         wait until rising_edge(clk_o);
         wait for 10 ms;
         
         -- change mode to ONE-SHOT
         cmd_i                 <= std_logic_vector(to_unsigned(0, 32));
         wait until rising_edge(clk_o);
         write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_PULSE_CMD_ADDR'length))                & ICU_PULSE_CMD_ADDR,                 cmd_i, AXIL_MISO, AXIL_MOSI);
         wait until rising_edge(clk_o);         
         -- change polarity
         wait for 3 ms;
         mode_i                <= std_logic_vector(to_unsigned(j mod 2, 32));
         polarity_i            <= std_logic_vector(to_unsigned(1, 32));
         write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_MODE_ADDR'length))                & ICU_MODE_ADDR,                 mode_i, AXIL_MISO, AXIL_MOSI);
         write_axi_lite(clk_o, std_logic_vector(to_unsigned(0,32-ICU_CALIB_POLARITY_ADDR'length))      & ICU_CALIB_POLARITY_ADDR,       polarity_i, AXIL_MISO, AXIL_MOSI);
         wait until rising_edge(clk_o);
         wait for 10 ms;
         
         j := j+1;
      end loop;
      
   end process MB_PROCESS;
   
   
end rtl;
