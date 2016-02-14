------------------------------------------------------------------
--!   @file tel2000pkg.vhd
--!   @brief Package file for TEL-2000 projects.
--!   @details This file contains the records and constants used in the project.
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL: http://einstein/svn/firmware/FIR-00251-Common/trunk/VHDL/tel2000pkg.vhd $
------------------------------------------------------------------

--!   Use IEEE standard library.
library IEEE;
--!   Use logic elements package from IEEE library.
use IEEE.STD_LOGIC_1164.all; 
--!   Use numeric package package from IEEE library. 
use ieee.numeric_std.all;

package qadc_intf is
   
   type delay_array is array (natural range 0 to 3) of std_logic_vector(4 downto 0);
   type edges_array is array (natural range 0 to 3) of std_logic_vector(31 downto 0);
   type bitslip_cnt_array is array (natural range 0 to 3) of std_logic_vector(3 downto 0);
   
end;