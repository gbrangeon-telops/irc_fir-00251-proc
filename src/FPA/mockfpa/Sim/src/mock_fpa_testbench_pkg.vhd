------------------------------------------------------------------
--!   @file isc0804A_intf_testbench_pkgpkg.vhd
--!   @brief Package file for TEL-2000 projects.
--!   @details This file contains the records and constants used in the project.
--!
--!   $Rev: 27228 $
--!   $Author: pcouture $
--!   $Date: 2022-03-14 09:32:24 -0400 (lun., 14 mars 2022) $
--!   $Id: mock_fpa_testbench_pkg.vhd 27228 2022-03-14 13:32:24Z pcouture $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2022-07-26%20-%20Architecture%20V1%20-%20Phase%201/src/FrameBuffer/Sim/src/mock_fpa_testbench_pkg.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.numeric_std.all;

package mock_fpa_testbench_pkg is                                         

function sec_to_clks(sec:real) return unsigned;
function clks_to_sec(clks:unsigned) return real;


end mock_fpa_testbench_pkg;

package body mock_fpa_testbench_pkg is 
	
constant SIM_CLK_FREQ           : real     := 100.0; --MHz
   
function sec_to_clks(sec:real) return unsigned is         

   variable y                              : unsigned(31 downto 0); 
begin   
   y :=  to_unsigned(integer(sec*(real(SIM_CLK_FREQ)*1000000.0)),32);
   
   return y;
end sec_to_clks;

function clks_to_sec(clks:unsigned) return real is         

   variable y                              : real; 
begin   
   y :=  real(to_integer(clks))/(real(SIM_CLK_FREQ)*1000000.0); 
   return y;
end clks_to_sec;   
 
   
   
end package body mock_fpa_testbench_pkg;

