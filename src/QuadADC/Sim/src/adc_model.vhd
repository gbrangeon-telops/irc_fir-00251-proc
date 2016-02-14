-------------------------------------------------------------------------------
--
-- Title       : ADC TB STIM
-- Design      : clink_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\telops\FIR-00251-Proc\src\clink\Sim\src\adc_tb_stim.vhd
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

-- synthesis translate_off 
library KINTEX7;
library IEEE;
use IEEE.vital_timing.all;
-- synthesis translate_on 

entity adc_model is
   port(
      ENC_P : in std_logic;
      ENC_N : in std_logic;
      
      AIN_0 : in std_logic_vector(13 downto 0); -- test data, same CLK as domain ENC_P/N
      AIN_1 : in std_logic_vector(13 downto 0); -- test data, same CLK as domain ENC_P/N
      AIN_2 : in std_logic_vector(13 downto 0); -- test data, same CLK as domain ENC_P/N
      AIN_3 : in std_logic_vector(13 downto 0); -- test data, same CLK as domain ENC_P/N
      
      CS_N : in std_logic;
      SCK : in std_logic;
      SDI : in std_logic;
      SDO : out std_logic;
      
      FR_P : out std_logic;
      FR_N : out std_logic;
      
      DCO_P : out std_logic;
      DCO_N : out std_logic;
      
      OUT_P : out std_logic_vector(3 downto 0);
      OUT_N : out std_logic_vector(3 downto 0)
      );
end adc_model;

architecture rtl of adc_model is
   
   component IBUFDS
      generic(
         -- synthesis translate_off
         CAPACITANCE : STRING := "DONT_CARE";
         DQS_BIAS : STRING := "FALSE";
         IBUF_DELAY_VALUE : STRING := "0";
         IBUF_LOW_PWR : BOOLEAN := TRUE;
         IFD_DELAY_VALUE : STRING := "AUTO";
         IOSTANDARD : STRING := "DEFAULT";
         -- synthesis translate_on
         DIFF_TERM : BOOLEAN := FALSE
         );
      port (
         I : in std_ulogic;
         IB : in std_ulogic;
         O : out std_ulogic
         );
   end component;
   
   component spi_slave is
      generic(
         REG_WIDTH  : integer := 24);
      port(
         CLK        : in    std_logic;
         RST        : in    std_logic;
         DOUT       : in    std_logic_vector(REG_WIDTH-1 downto 0);
         DIN        : out   std_logic_vector(REG_WIDTH-1 downto 0);
         STB        : out   std_logic;
         SPI_SCK    : in    std_logic;
         SPI_MOSI   : in    std_logic;
         SPI_MISO   : out   std_logic;
         SPI_SSn    : in    std_logic);
   end component;
   
   
   component spi_rx
      generic(
         BITWIDTH : natural := 12);
      port(
         CLK  : in std_logic;
         DOUT : out std_logic_vector(BITWIDTH-1 downto 0);
         DVAL : out std_logic;
         CSn  : in std_logic;
         SDA  : in std_logic;
         SCL  : in std_logic);
   end component;
   
   -- CLK and RESET
   signal rst_i : std_ulogic := '1';
   signal bit_clk : std_ulogic := '0';
   
   signal fr_s, out0_s, out1_s, out2_s, out3_s : std_ulogic := '0';
   signal fr_d, out0_d, out1_d, out2_d, out3_d : std_ulogic := '0';
   signal dco_s, dco_d : std_ulogic := '0';
   
   signal data0, data1, data2, data3 : unsigned(13 downto 0) := "10101010101010";
   signal data0_hold, data1_hold, data2_hold, data3_hold : unsigned(13 downto 0);
   
   signal enc_i : std_ulogic := '1';
   
   signal spi_dval, spi_rd_dval : std_ulogic := '0';
   signal spi_dout : std_logic_vector(15 downto 0);
   
   signal rd_addr_data: std_logic_vector(7 downto 0);
   signal rd_dout : std_logic_vector(7 downto 0);
   signal spi_rd_ssn : std_ulogic := '1';
   
   signal output_test_pattern : std_ulogic := '0'; -- '0' : sample, '1' test pattern
   signal test_pattern: std_logic_vector(13 downto 0) := (others => '0');
   signal cfg_reg1 : std_logic_vector(7 downto 0) := (others => '0');
   signal cfg_reg2 : std_logic_vector(7 downto 0) := (others => '0');
   signal cfg_reg3 : std_logic_vector(7 downto 0) := (others => '0');
   signal cfg_reg4 : std_logic_vector(7 downto 0) := (others => '0');
   
   constant ENC_PER : time := 25 ns; -- ENC signal period (sample rate)
   constant t_ser: time := ENC_PER/14; -- bit period
   constant t_data : time := t_ser/2; -- DATA to DCO delay
   constant t_pd : time := 1.1ns + 2*t_ser; -- propagation delay delay [ns]
   
   constant CLK_PER_MSEC : integer := 100000;
   constant INITIAL_VALUE : unsigned(15 downto 0) := x"DCBA";
   
begin
   
   FR_P <= fr_d;
   FR_N <= not fr_d;
   
   DCO_P <= dco_d;
   DCO_N <= not dco_d;
   
   OUT_P(0) <= out0_d;
   OUT_N(0) <= not out0_d;
   OUT_P(1) <= out1_d;
   OUT_N(1) <= not out1_d;
   OUT_P(2) <= out2_d;
   OUT_N(2) <= not out2_d;
   OUT_P(3) <= out3_d;
   OUT_N(3) <= not out3_d;
   
   --! Reset Generation
   RST_GEN : process
   begin          
      rst_i <= '1';
      wait for 1us;
      rst_i <= '0'; 
      wait;
   end process;
   
   enc_buf : IBUFDS
   port map(
      I => ENC_P,
      IB => ENC_N,
      O => enc_i
      );
   
   spi_cfg : spi_rx
   generic map(
      BITWIDTH => 16)
   port map(
      CLK => bit_clk,
      DOUT => spi_dout,
      DVAL => spi_dval,
      CSn => CS_N,
      SDA => SDI,
      SCL => SCK
      );
   
   decode_rd_addr : process(bit_clk)
      variable addr : unsigned(6 downto 0);
      variable data_v : std_logic_vector(7 downto 0);
      variable sclk_hist : std_logic_vector(1 downto 0);
      variable ss_n_var : std_logic;
   begin
      if rising_edge(bit_clk) then
         if sclk_hist = "10" then
            spi_rd_ssn <= ss_n_var;
         end if;
         rd_dout <= data_v;
         if spi_rd_dval = '1'  and rd_addr_data(rd_addr_data'left) = '1' then
            addr := unsigned(rd_addr_data(6 downto 0));
            data_v := (others => rd_addr_data(0));
            
            case addr(3 downto 0) is
               when x"1" =>
                  data_v := cfg_reg1;
                  --spi_rd_ssn <= '0';
                  ss_n_var := '0';
               
               when x"2" =>
                  data_v := cfg_reg2;
                  --spi_rd_ssn <= '0';
                  ss_n_var := '0';
               
               when x"3" =>
                  data_v := cfg_reg3;
                  --spi_rd_ssn <= '0';
                  ss_n_var := '0';
               
               when x"4" =>
                  data_v := cfg_reg4;
                  --spi_rd_ssn <= '0';
                  ss_n_var := '0';
               
               when others =>
               --spi_rd_ssn <= '1';
               ss_n_var := '1';
               
            end case;
            
         else
            if CS_N = '1' then
               --spi_rd_ssn <= '1';
               ss_n_var := '1';
            end if;
         end if;
         
         sclk_hist := sclk_hist(0) & SCK;
         
      end if;
   end process;
   
   spi_cfg_rd_addr : spi_rx
   generic map(
      BITWIDTH => 8)
   port map(
      CLK => bit_clk,
      DOUT => rd_addr_data,
      DVAL => spi_rd_dval,
      CSn => CS_N,
      SDA => SDI,
      SCL => SCK
      );
   
   spi_out : spi_slave
   generic map(
      REG_WIDTH => 8)
   port map(
      CLK => bit_clk,
      RST => '0',
      DOUT => rd_dout,
      DIN => open, -- out
      STB => open,--        : out   std_logic;
      SPI_SCK => SCK,
      SPI_MOSI => '0',
      SPI_MISO => SDO,
      SPI_SSn => spi_rd_ssn
      );   
   
   cfg : process(bit_clk)
      variable addr : unsigned(6 downto 0);
   begin
      if rising_edge(bit_clk) then
         if spi_dval = '1' then
            addr := unsigned(spi_dout(14 downto 8));
            case addr(3 downto 0) is
               when x"0" =>
               
               when x"1" =>
                  cfg_reg1 <= spi_dout(7 downto 0);
               
               when x"2" =>
                  cfg_reg2 <= spi_dout(7 downto 0);
               
               when x"3" =>
                  output_test_pattern <= spi_dout(7);
                  test_pattern(13 downto 8) <= spi_dout(5 downto 0);
                  cfg_reg3 <= spi_dout(7 downto 0);
               
               when x"4" =>
                  test_pattern(7 downto 0) <= spi_dout(7 downto 0);
                  cfg_reg4 <= spi_dout(7 downto 0);
               
               when others =>
            end case;
         end if;
      end if;
   end process;
   
   -- add latency to the outputs
   fr_d <= transport fr_s after t_pd - 1.5*t_ser;
   out0_d <= transport out0_s after t_pd - 1.5*t_ser;
   out1_d <= transport out1_s after t_pd - 1.5*t_ser;
   out2_d <= transport out2_s after t_pd - 1.5*t_ser;
   out3_d <= transport out3_s after t_pd - 1.5*t_ser;
   dco_d <= transport dco_s after t_pd - 1.5*t_ser;
   
   bitclk_gen : process
   begin
      wait on enc_i;
      loop1 : for i in 0 to 13 loop
         bit_clk <= not bit_clk after t_ser/2;
         wait on bit_clk;
      end loop;
   end process;
   
   serialize_data : process(bit_clk)
      variable cnt : integer range 0 to 7 := 0;
      variable latency : unsigned(0 downto 0) := (others => '0');
      variable enc_1p : std_ulogic := '0';
      variable fr_i, fr_1p : std_ulogic := '0';
      variable data0_reg : std_ulogic_vector(data0'length-1 downto 0) := (others => '0');
      variable data1_reg : std_ulogic_vector(data1'length-1 downto 0) := (others => '0');
      variable data2_reg : std_ulogic_vector(data2'length-1 downto 0) := (others => '0');
      variable data3_reg : std_ulogic_vector(data3'length-1 downto 0) := (others => '0');
   begin
      if rising_edge(bit_clk) then
         
         out0_s <= data0_reg(data0_reg'length-1);
         data0_reg := data0_reg(12 downto 0) & '0';
         out1_s <= data1_reg(data0_reg'length-1);
         data1_reg := data1_reg(12 downto 0) & '0';
         out2_s <= data2_reg(data0_reg'length-1);
         data2_reg := data2_reg(12 downto 0) & '0';
         out3_s <= data3_reg(data0_reg'length-1);
         data3_reg := data3_reg(12 downto 0) & '0';
         
         if enc_1p = '0' and enc_i = '1' then
            data0_hold <= data0;
            data1_hold <= data1; 
            data2_hold <= data2; 
            data3_hold <= data3;
            data0_reg := std_ulogic_vector(data0);
            data1_reg := std_ulogic_vector(data1);
            data2_reg := std_ulogic_vector(data2);
            data3_reg := std_ulogic_vector(data3);
            fr_i := '1';
            cnt := 0;
         end if;
         
         if cnt = 7 then
            cnt := 0;
            fr_i := '0';
         else
            cnt := cnt + 1;
         end if;
         
         enc_1p := enc_i;
         fr_s <= fr_1p;
         fr_1p := fr_i;
      end if;
   end process;
   
   dco_gen : process(bit_clk)
   begin
      if falling_edge(bit_clk) then
         dco_s <= not dco_s;
      end if;
   end process;
   
   data_gen : process(enc_i, rst_i)
   begin
      if rst_i = '1' then
         data0 <= INITIAL_VALUE(13 downto 0);
         data1 <= INITIAL_VALUE(13 downto 0);
         data2 <= INITIAL_VALUE(13 downto 0);
         data3 <= INITIAL_VALUE(13 downto 0);
      else
         if rising_edge(enc_i) then
            if output_test_pattern = '0' then
               data0 <= unsigned(AIN_0);
               data1 <= unsigned(AIN_1);
               data2 <= unsigned(AIN_2);
               data3 <= unsigned(AIN_3);
            else
               data0 <= unsigned(test_pattern);
               data1 <= unsigned(test_pattern);
               data2 <= unsigned(test_pattern);
               data3 <= unsigned(test_pattern);
            end if;
         end if;
         
      end if;
   end process;
   
end rtl;
