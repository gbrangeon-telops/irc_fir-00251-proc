-------------------------------------------------------------------------------
--
-- Title       : data_sampling
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : 
-- Generated   : Tue Nov 22 12:13:49 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
--library COMMON_HDL;
--use COMMON_HDL.Telops.all;

-- synthesis translate_off 
library KINTEX7;
library IEEE;
use IEEE.vital_timing.all;
-- synthesis translate_on 

entity data_sampling_dbg is
   port(
      ARESET : in std_logic;
      CH0_DATA_N : in std_logic_vector(3 downto 0);
      CH0_DATA_P : in std_logic_vector(3 downto 0);
      CH1_DATA_N : in std_logic_vector(3 downto 0);
      CH1_DATA_P : in std_logic_vector(3 downto 0);
      CH2_DATA_N : in std_logic_vector(3 downto 0);
      CH2_DATA_P : in std_logic_vector(3 downto 0);
      CH3_DATA_N : in std_logic_vector(3 downto 0);
      CH3_DATA_P : in std_logic_vector(3 downto 0);
      CH0_CLK_N : in std_logic;
      CH0_CLK_P : in std_logic;
      CH1_CLK_N : in std_logic;
      CH1_CLK_P : in std_logic;
      CH2_CLK_N : in std_logic;
      CH2_CLK_P : in std_logic;
      CH3_CLK_N : in std_logic;
      CH3_CLK_P : in std_logic;
      DATA0_0 : out std_logic_vector(3 downto 0);
      DATA0_90 : out std_logic_vector(3 downto 0);
      DATA1_0 : out std_logic_vector(3 downto 0);
      DATA1_90 : out std_logic_vector(3 downto 0);
      DATA2_0 : out std_logic_vector(3 downto 0);
      DATA2_90 : out std_logic_vector(3 downto 0);
      DATA3_0 : out std_logic_vector(3 downto 0);
      DATA3_90 : out std_logic_vector(3 downto 0);
      CLK_DATA_0 : out std_logic_vector(3 downto 0);
      CLK_DATA_90 : out std_logic_vector(3 downto 0)
      );
end data_sampling_dbg;



architecture RTL of data_sampling_dbg is
   component FD
      generic(
         INIT : BIT := '0'
         );
      port (
         C : in std_ulogic;
         D : in std_ulogic;
         Q : out std_ulogic
         );
   end component;
   component adc_rcv_clk_560MHz
      port (
         clk_in : in STD_LOGIC;
         reset : in STD_LOGIC;
         clk_560_0 : out STD_LOGIC;
         clk_560_90 : out STD_LOGIC;
         locked : out STD_LOGIC
         );
   end component;
   component IBUFGDS
      generic(
         -- synthesis translate_off
         CAPACITANCE : STRING := "DONT_CARE";
         IBUF_DELAY_VALUE : STRING := "0";
         IBUF_LOW_PWR : BOOLEAN := TRUE;
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
   
   component double_sync
      generic(
         INIT_VALUE : BIT := '0'
         );
      port (
         CLK : in STD_LOGIC;
         D : in STD_LOGIC;
         RESET : in STD_LOGIC;
         Q : out STD_LOGIC := '0'
         );
   end component;
   
   signal data_0_s : std_ulogic_vector(3 downto 0);
   signal data_1_s : std_ulogic_vector(3 downto 0);
   signal data_2_s : std_ulogic_vector(3 downto 0);
   signal data_3_s : std_ulogic_vector(3 downto 0);
   signal data_0_i : std_ulogic_vector(11 downto 0);
   signal data_1_i : std_ulogic_vector(11 downto 0);
   signal data_2_i : std_ulogic_vector(11 downto 0);
   signal data_3_i : std_ulogic_vector(11 downto 0);
   signal clk_s    : std_ulogic_vector(3 downto 0);
   signal clk_i    : std_ulogic_vector(11 downto 0);
   
   signal clk560, clk560_90 : std_ulogic;
   
   signal gnd : std_ulogic;
   
   attribute dont_touch : string; 
   attribute dont_touch of clk560 : signal is "true";
   attribute dont_touch of clk560_90 : signal is "true";
   attribute dont_touch of data_0_s : signal is "true";
   attribute dont_touch of data_1_s : signal is "true";
   attribute dont_touch of data_2_s : signal is "true";
   attribute dont_touch of data_3_s : signal is "true";
   attribute dont_touch of data_0_i : signal is "true";
   attribute dont_touch of data_1_i : signal is "true";
   attribute dont_touch of data_2_i : signal is "true";
   attribute dont_touch of data_3_i : signal is "true";
   attribute dont_touch of clk_s    : signal is "true";
   attribute dont_touch of clk_i    : signal is "true";
   
begin
   
   gnd <= '0';
   
   U14 : adc_rcv_clk_560MHz
   port map(
      clk_560_0 => clk560,
      clk_560_90 => clk560_90,
      clk_in => clk_s(0),
      reset => areset
      );
   
   input_gen : for i in 0 to 3 generate
      U0 : IBUFDS
      port map(
         I => CH0_DATA_P(i),
         IB => CH0_DATA_N(i),
         O => data_0_s(i)
         );
      
      U1 : IBUFDS
      port map(
         I => CH1_DATA_P(i),
         IB => CH1_DATA_N(i),
         O => data_1_s(i)
         );
      
      U2 : IBUFDS
      port map(
         I => CH2_DATA_P(i),
         IB => CH2_DATA_N(i),
         O => data_2_s(i)
         );
      
      U3 : IBUFDS
      port map(
         I => CH3_DATA_P(i),
         IB => CH3_DATA_N(i),
         O => data_3_s(i)
         );
   end generate;
   
   UCLK0 : IBUFGDS
   port map(
      I => CH0_CLK_P,
      IB => CH0_CLK_N,
      O => clk_s(0)
      );
   
   UCLK1 : IBUFGDS
   port map(
      I => CH1_CLK_P,
      IB => CH1_CLK_N,
      O => clk_s(1)
      );
   
   UCLK2 : IBUFGDS
   port map(
      I => CH2_CLK_P,
      IB => CH2_CLK_N,
      O => clk_s(2)
      );
   
   UCLK3 : IBUFGDS
   port map(
      I => CH3_CLK_P,
      IB => CH3_CLK_N,
      O => clk_s(3)
      );
   
   output_gen_ph0 : for i in 0 to 3 generate
      
      U00 : FD
      port map(
         C => clk560,
         D => data_0_s(i),
         Q => data_0_i(i)
         );
      
      U01 : FD
      port map(
         C => clk560,
         D => data_0_i(i),
         Q => DATA0_0(i)
         );
      
      U10 : FD
      port map(
         C => clk560,
         D => data_1_s(i),
         Q => data_1_i(i)
         );
      
      U11 : FD
      port map(
         C => clk560,
         D => data_1_i(i),
         Q => DATA1_0(i)
         );
      
      U20 : FD
      port map(
         C => clk560,
         D => data_2_s(i),
         Q => data_2_i(i)
         );
      
      U21 : FD
      port map(
         C => clk560,
         D => data_2_i(i),
         Q => DATA2_0(i)
         );
      
      U30 : FD
      port map(
         C => clk560,
         D => data_3_s(i),
         Q => data_3_i(i)
         );
      
      U31 : FD
      port map(
         C => clk560,
         D => data_3_i(i),
         Q => DATA3_0(i)
         );
      
      U40 : FD
      port map(
         C => clk560,
         D => clk_s(i),
         Q => clk_i(i)
         );
      
      U41 : FD
      port map(
         C => clk560,
         D => clk_i(i),
         Q => CLK_DATA_0(i)
         );
      
   end generate;
   
   output_gen_ph90 : for i in 0 to 3 generate
      
      U00 : FD
      port map(
         C => clk560_90,
         D => data_0_s(i),
         Q => data_0_i(i+4)
         );
      
      U01 : FD
      port map(
         C => clk560,
         D => data_0_i(i+4),
         Q => data_0_i(i+8)
         );
      
      U02 : FD
      port map(
         C => clk560,
         D => data_0_i(i+8),
         Q => DATA0_90(i)
         );
      
      U10 : FD
      port map(
         C => clk560_90,
         D => data_1_s(i),
         Q => data_1_i(i+4)
         );
      
      U11 : FD
      port map(
         C => clk560,
         D => data_1_i(i+4),
         Q => data_1_i(i+8)
         );
      
      U12 : FD
      port map(
         C => clk560,
         D => data_1_i(i+8),
         Q => DATA1_90(i)
         );
      
      U20 : FD
      port map(
         C => clk560_90,
         D => data_2_s(i),
         Q => data_2_i(i+4)
         );
      
      U21 : FD
      port map(
         C => clk560,
         D => data_2_i(i+4),
         Q => data_2_i(i+8)
         );
      
      U22 : FD
      port map(
         C => clk560,
         D => data_2_i(i+8),
         Q => DATA2_90(i)
         );
      
      U30 : FD
      port map(
         C => clk560_90,
         D => data_3_s(i),
         Q => data_3_i(i+4)
         );
      
      U31 : FD
      port map(
         C => clk560,
         D => data_3_i(i+4),
         Q => data_3_i(i+8)
         );
      
      U32 : FD
      port map(
         C => clk560,
         D => data_3_i(i+8),
         Q => DATA3_90(i)
         );
      
      U40 : FD
      port map(
         C => clk560_90,
         D => clk_s(i),
         Q => clk_i(i+4)
         );
      
      U41 : FD
      port map(
         C => clk560,
         D => clk_i(i+4),
         Q => clk_i(i+8)
         ); 
      
      U42 : FD
      port map(
         C => clk560,
         D => clk_i(i+8),
         Q => CLK_DATA_90(i)
         );
      
   end generate;
   
end RTL;
