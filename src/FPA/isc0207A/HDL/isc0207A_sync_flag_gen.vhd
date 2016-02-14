------------------------------------------------------------------
--!   @file : isc0207A_sync_flag_gen
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity isc0207A_sync_flag_gen is
   port(
      ARESET           : in std_logic;
      MCLK_SOURCE      : in std_logic;
      FPA_INT          : in std_logic;
      ADC_SYNC_FLAG    : out std_logic;
      DIAG_SYNC_FLAG   : out std_logic
      );
end isc0207A_sync_flag_gen;

architecture rtl of isc0207A_sync_flag_gen is

-- pour le 0207, le flag de synchronisation est le signal d'int�gration. On est capable de capturer l'image N samples apr�s sa tromb�e. 
-- le defi est que N doit �tre rigouresuement constant d'une image � l'autre, d'une carte � l'autre, d'un boot-up � l'autre
-- Pour que N soit constant, nous utilisons MCLK_SOURCE ou ADC_CLK_SOURCE. MCLK_SOURCE = ADC_CLK_SOURCE de toute fa�on.

begin
 U1: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then 
         ADC_SYNC_FLAG <= FPA_INT;       
         DIAG_SYNC_FLAG <= FPA_INT;
      end if;      
   end process;
end rtl;
