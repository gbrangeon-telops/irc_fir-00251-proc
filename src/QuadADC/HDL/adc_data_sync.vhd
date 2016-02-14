-------------------------------------------------------------------------------
--
-- Title       : adc_data_sync
-- Design      : adc_intf_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\telops\FIR-00251-Proc\src\QuadADC\HDL\adc_data_sync.vhd
-- Generated   : Wed May 27 09:14:02 2015
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity adc_data_sync is
   port(
      ARESET : in std_logic;
      CLKD : in std_logic; -- same as output clock of the iserdes
      DVAL_IN : in std_logic; -- same as output clock of the iserdes
      D0 : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      D1 : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      D2 : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      D3 : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      CLK_DOUT : in std_logic;
      FLAG : in std_logic; -- CLK_DOUT domain
      Q : out std_logic_vector(56 downto 0); -- CLK_DOUT domain
      DVAL : out std_logic -- CLK_DOUT domain
      );
end adc_data_sync;

architecture rtl of adc_data_sync is
   component double_sync is
      port(
         D : in std_logic;
         Q : out std_logic;
         RESET : in std_logic;
         CLK : in std_logic
         );
   end component;
   
   component afifo_w57d16 is
      port (
         RST : in std_logic;
         WR_CLK : in std_logic;
         RD_CLK : in std_logic;
         DIN : in std_logic_vector ( 56 downto 0 );
         WR_EN : in std_logic;
         RD_EN : in std_logic;
         DOUT : out std_logic_vector ( 56 downto 0 );
         FULL : out std_logic;
         EMPTY : out std_logic;
         VALID : out std_logic
         );
   end component;
   
   signal sreset : std_ulogic;
   signal flag_sync : std_ulogic;
   signal dval_i, dval_out : std_ulogic;
   signal data_i, data_o : std_logic_vector(Q'length-1 downto 0) := (others => '0');
   
   signal full_i, empty_i : std_ulogic;
   
   attribute keep : string;
   attribute keep of dval_out : signal is "true";
   attribute keep of data_o : signal is "true";
   
begin
   
   Q <= std_logic_vector(data_o);
   DVAL <= dval_out;
   
   sync_en : double_sync
   port map(
      D => FLAG,
      Q => flag_sync,
      RESET => '0',
      CLK => CLKD);
   
   merge_proc : process(CLKD)
   begin
      if rising_edge(CLKD) then
         if DVAL_IN = '1' then
            dval_i <= '1';
         else
            dval_i <= '0';
         end if;
         data_i <= flag_sync & D3 & D2 & D1 & D0;
      end if;
   end process;
   
   fifo : afifo_w57d16
   port map(
      rst => ARESET,
      wr_clk => CLKD,
      rd_clk => CLK_DOUT,
      din => data_i,
      wr_en => dval_i,
      rd_en => '1',
      dout => data_o,
      full => full_i,
      empty => empty_i,
      valid => dval_out);
end rtl;
