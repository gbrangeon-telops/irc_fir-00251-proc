library common_hdl;
use common_hdl.Telops.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity ad7478_driver_tb is
   -- Generic declarations of the tested unit
   generic(
      ADC_SCLK_FACTOR : INTEGER := 32 );
end ad7478_driver_tb;

architecture TB_ARCHITECTURE of ad7478_driver_tb is
   -- Component declaration of the tested unit
   component ad7478_driver
      generic(
         ADC_SCLK_FACTOR : INTEGER := 32 );
      port(
         CLK : in STD_LOGIC;
         ARESET : in STD_LOGIC;
         START_ADC : in STD_LOGIC;
         ADC_DATA_RDY : out STD_LOGIC;
         ADC_BUSY : out STD_LOGIC;
         ADC_DIN : in STD_LOGIC;
         ADC_SCLK : out STD_LOGIC;
         ADC_CS_N : out STD_LOGIC;
         ADC_ERR : out STD_LOGIC;
         ADC_DATA : out STD_LOGIC_VECTOR(7 downto 0) );
   end component;
   
   constant CLK_PERIOD  : time := 50 ns;
   
   
   -- Stimulus signals - signals mapped to the input and inout ports of tested entity
   signal clk : STD_LOGIC := '0';
   signal areset : STD_LOGIC;
   signal start_adc : STD_LOGIC;
   signal adc_din : STD_LOGIC;
   -- Observed signals - signals mapped to the output ports of tested entity
   signal adc_data_rdy : STD_LOGIC;
   signal adc_busy : STD_LOGIC;
   signal adc_sclk : STD_LOGIC;
   signal adc_cs_n : STD_LOGIC;
   signal adc_err : STD_LOGIC;
   signal adc_data : STD_LOGIC_VECTOR(7 downto 0);
   
   -- Add your code here ...
   
begin 
   
   clk_gen: process(clk)
   begin
      clk <= not clk after CLK_PERIOD/2; 
   end process; 
   
   
   reset_gen: process
   begin
      areset <= '1'; 
      wait for 100 ns;
      areset <= '0';
      wait;
   end process;       
   
   start_adc <= '1';
   
   -- Unit Under Test port map
   UUT : ad7478_driver
   generic map (
      ADC_SCLK_FACTOR => ADC_SCLK_FACTOR
      )
   
   port map (
      CLK => clk,
      ARESET => areset,
      START_ADC => start_adc,
      ADC_DATA_RDY => adc_data_rdy,
      ADC_BUSY => adc_busy,
      ADC_DIN => adc_din,
      ADC_SCLK => adc_sclk,
      ADC_CS_N => adc_cs_n,
      ADC_ERR => adc_err,
      ADC_DATA => adc_data         
      );
             
   
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_ad7478_driver of ad7478_driver_tb is
   for TB_ARCHITECTURE
      for UUT : ad7478_driver
         use entity work.ad7478_driver(rtl);
      end for;
   end for;
end TESTBENCH_FOR_ad7478_driver;

