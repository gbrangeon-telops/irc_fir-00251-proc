-------------------------------------------------------------------------------
--
-- Title       : blackbird_data_dispatcher
-- Design      : scd_proxy2
-- Author      : ETD
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\2020-08-08 Line Buffer\Simulation\Line_buffer\src\Stim.vhd
-- Generated   : Mon Nov 09 14:28:25 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Fichier intégrant les deux channels en 1 sortie
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use ieee.numeric_std.all;
use work.tel2000.all;	

entity data_dispatcher is
	port(		   
		CLK_CH0 : in std_logic;
      CLK_CH1 : in std_logic;
      D_CLK : in std_logic;
		ARESET : in std_logic;
		 
		CH0_DATA : in std_logic_vector(31 downto 0);
      CH0_DVAL : in std_logic;
      CH1_DATA : in std_logic_vector(31 downto 0);
      CH1_DVAL : in std_logic;
      
      DATA_OUT : out std_logic_vector(63 downto 0);
	  VALID_OUT : out std_logic);
end data_dispatcher;

architecture data_dispatcher of data_dispatcher is	

   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;

   component fwft_afifo_w32_d16
      port (
         rst            : in std_logic;
         wr_clk         : in std_logic;
         rd_clk         : in std_logic;
         din            : in std_logic_vector(31 downto 0);
         wr_en          : in std_logic;
         rd_en          : in std_logic;
         dout           : out std_logic_vector(31 downto 0);
         valid          : out std_logic;
         full           : out std_logic;
         overflow       : out std_logic;
         empty          : out std_logic;
         wr_rst_busy    : out std_logic;
         rd_rst_busy    : out std_logic
         );
   end component;
   
   component fifo_generator_1
  Port ( 
    rst : in STD_LOGIC;
    wr_clk : in STD_LOGIC;
    rd_clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    full : out STD_LOGIC;
    overflow : out STD_LOGIC;
    empty : out STD_LOGIC;
    valid : out STD_LOGIC
  ); 
   end component;
   
   signal sreset : std_logic;
   signal fifo_rd_en : std_logic;
   signal valid_ch0_dval : std_logic;
   signal valid_ch1_dval : std_logic;
   signal fifo_ch0_dout : std_logic_vector(31 downto 0);
   signal fifo_ch1_dout : std_logic_vector(31 downto 0);
   signal fifo_ch0_ovfl : std_logic;
   signal fifo_ch1_ovfl : std_logic;
   
   signal reg_0 : std_logic_vector(63 downto 0);
   signal reg_1 : std_logic_vector(63 downto 0);
   signal reg_2 : std_logic_vector(63 downto 0);
   signal reg_3 : std_logic_vector(63 downto 0);
   signal reg_4 : std_logic_vector(63 downto 0);
   signal fval_pixel : std_logic;
   
begin

   fifo_rd_en <= valid_ch0_dval and valid_ch1_dval; -- lecture synchronisée des 2 fifos tout le temps. 
   DATA_OUT <= fval_pixel & reg_4(62 downto 0);
   VALID_OUT <= fifo_rd_en;
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => D_CLK,
      SRESET => sreset
      );   
	  
	fifo_ch0 : fifo_generator_1
  Port map( 
    rst => ARESET,
    wr_clk => CLK_CH0,
    rd_clk => D_CLK,
    din => CH0_DATA,
    wr_en => CH0_DVAL,
    rd_en => fifo_rd_en,
	dout => fifo_ch0_dout,
    full => open,
    overflow => fifo_ch0_ovfl,
    empty => open,
    valid => valid_ch0_dval);
   
	fifo_ch1 : fifo_generator_1
  Port map( 
    rst => ARESET,
    wr_clk => CLK_CH1,
    rd_clk => D_CLK,
    din => CH1_DATA,
    wr_en => CH1_DVAL,
    rd_en => fifo_rd_en,
	dout => fifo_ch1_dout,
    full => open,
    overflow => fifo_ch1_ovfl,
    empty => open,
    valid => valid_ch1_dval);

   shift_register : process(D_CLK)
   begin
      if rising_edge(D_CLK) then
         if sreset = '1' then
            reg_0 <= (others => '0');
            reg_1 <= (others => '0');
            reg_2 <= (others => '0');
            reg_3 <= (others => '0');
            reg_4 <= (others => '0');
         else
            if fifo_rd_en = '1' then
               reg_0 <= fifo_ch1_dout & fifo_ch0_dout;
               reg_1 <= reg_0;
               reg_2 <= reg_1;
               reg_3 <= reg_2;
               reg_4 <= reg_3;
            else
               reg_0 <= reg_0;
               reg_1 <= reg_1;
               reg_2 <= reg_2;
               reg_3 <= reg_3;
               reg_4 <= reg_4;
            end if;
         end if;
      end if;
   end process shift_register;
   
   fval_pixel_creation : process(D_CLK)
   begin
      if rising_edge(D_CLK) then
         if sreset = '1' then
            fval_pixel <= '0';
         else
            --Si on a un pixel suivi d'une fin d'image 4 packet plus tard (fin de fval_pixel)
            if reg_3(28) = '1' and reg_0(30) = '0' then
               fval_pixel <= '0';
            --Si on a une image débuté et un pixel ensuite (debut de fval_pixel)
            elsif reg_4(30) = '1' and reg_3(28) = '1' then
               fval_pixel <= '1';
            else  
               fval_pixel <= fval_pixel;
            end if;
         end if;
      end if;
   end process fval_pixel_creation;

end data_dispatcher;