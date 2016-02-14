-------------------------------------------------------------------------------
--
-- Title       : irig_comparator_v2
-- Design      : FIR-00229
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00229\src\FIR-00229\IRIG\irig_comparator_v2.vhd
-- Generated   : Tue Sep 13 11:36:12 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.IRIG_define_v2.all;

entity irig_comparator_v2 is
   port(  
      ARESET         : in std_logic;
      CLK            : in std_logic;
      THRESHOLD      : in std_logic_vector(7 downto 0);
      THRESHOLD_DVAL : in std_logic;
      RX_MOSI        : in t_ll_mosi8;
      RX_MISO        : out t_ll_miso;
      TX_MISO        : in t_ll_miso;
      TX_MOSI        : out t_ll_mosi1;
      ERR            : out std_logic
      );
end irig_comparator_v2;

architecture RTL of irig_comparator_v2 is
   component sync_reset
      port (
         ARESET : in STD_LOGIC;
         CLK    : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1'
         );
   end component;
   
   signal sreset          : std_logic;
   
begin 
   
   
   ------------------------------------------------------
   -- sorties
   ------------------------------------------------------ 
   RX_MISO <= ('0','0');
   
   
   ------------------------------------------------------
   -- Sync reset
   ------------------------------------------------------
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK => CLK,
      SRESET => sreset
      ); 
   
   
   ------------------------------------------------------
   -- proc
   ------------------------------------------------------    
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
          TX_MOSI.DVAL <= '0';
          TX_MOSI.SUPPORT_BUSY <= '1';
          TX_MOSI.SOF <= '0';
          TX_MOSI.EOF <= '0';
         else
            if unsigned(RX_MOSI.DATA) >= unsigned(THRESHOLD) then 
               TX_MOSI.DATA <= '1';
            else
               TX_MOSI.DATA <= '0';
            end if;
            TX_MOSI.DVAL <=  RX_MOSI.DVAL and THRESHOLD_DVAL; 
            ERR <= RX_MOSI.DVAL and TX_MISO.BUSY;
            
         end if; 
      end if;
   end process;   
   
   
end RTL;
