------------------------------------------------------------------
--!   @file FlashResetPkg.vhd
--!   @brief Package for FlashReset
--!   @details This file contains common type definitions for the FlashReset modules.
--!
--!   $Rev: 22950 $
--!   $Author: elarouche $
--!   $Date: 2019-02-28 14:27:55 -0500 (jeu., 28 févr. 2019) $
--!   $Id: FlashResetPkg.vhd 22950 2019-02-28 19:27:55Z elarouche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/IP/325/FlashReset/HDL/FlashResetPkg.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all; 

package FRPKG is

type t_byte_array is array (natural range <>) of std_logic_vector(7 downto 0);

end FRPKG;
