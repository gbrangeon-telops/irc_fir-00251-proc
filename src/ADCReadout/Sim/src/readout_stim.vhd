-------------------------------------------------------------------------------
--
-- Title       : adc_readout_tb_stim
-- Design      : clink_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : 
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

entity readout_stim is
   port(
      MBCLK  : in STD_LOGIC;
      ARESET : in STD_LOGIC;
      FPA_Img_Info : out img_info_type;
      R      : out std_logic_vector(31 downto 0);
      Q      : out std_logic_vector(31 downto 0)
      );
end readout_stim;

architecture rtl of readout_stim is
   

   
   -- CLK and RESET
   signal mb_clk_o : std_logic := '0';
   signal rst_i : std_logic := '0';
   
   signal int_i : std_logic;
   signal frame_id : unsigned(31 downto 0);
   
   signal stall_i : std_logic := '0';
   
   -- CLK and RESET
   constant CLK_per : time := 50 ns;
   constant MBCLK_per : time := 10 ns;
   constant CLK_SAMPLES_per : time := 1 us;
   
   constant CLK_PER_MSEC : integer := 100000;
   
begin
   

   mb_clk_o <= MBCLK;
   rst_i <= ARESET;
   

   process(mb_clk_o)
      variable cnt : integer range 0 to 2**30 := 0;
   begin
      if rising_edge(mb_clk_o) then
         if rst_i = '1' then
            cnt := 21;
            int_i <= '0';
            frame_id <= (others => '0');
         else
            if cnt <= 20 then
               int_i <= '1';
            else
               int_i <= '0';
            end if;
            
            if cnt = 0 then
               frame_id <= frame_id + 1;
            end if;
            
            cnt := cnt + 1;
            if cnt = 1_000 then
               cnt := 0;
            end if;
         end if ;
      end if;
   end process;
   
   FPA_Img_Info.exp_feedbk <= int_i;
   FPA_Img_Info.frame_id <= frame_id;

   R <= x"00001000"; -- decimal 4096 -> 1.0
   Q <= x"00008000"; -- decimal 2048.0
   
end rtl;