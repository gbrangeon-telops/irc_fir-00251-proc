------------------------------------------------------------------
--!   @file isc0804A_intf_testbench_pkgpkg.vhd
--!   @brief Package file for TEL-2000 projects.
--!   @details This file contains the records and constants used in the project.
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.numeric_std.all;
use work.fbuffer_define.all;

package fb_testbench_pkg is                                         

 
function to_intf_cfg(cfg:frame_buffer_cfg_type) return unsigned;

end fb_testbench_pkg;

package body fb_testbench_pkg is

   function to_intf_cfg(cfg:frame_buffer_cfg_type) return unsigned is 
   
      variable buffer_a_addr	           : unsigned(31 downto 0) := (others => '0');          -- frame buffer base adresse
      variable buffer_b_addr             : unsigned(31 downto 0) := (others => '0');          -- buffer a size in byte
      variable buffer_c_addr             : unsigned(31 downto 0) := (others => '0');          -- buffer b size in byte
      variable frame_byte_size           : unsigned(31 downto 0) := (others => '0');          -- frame size in byte
      variable hdr_pix_size              : unsigned(31 downto 0) := (others => '0');          -- header size in byte 
      variable img_pix_size              : unsigned(31 downto 0) := (others => '0');          -- image size in byte
      variable lval_pause_min            : unsigned(31 downto 0) := (others => '0');          -- minimum pause between line
      variable fval_pause_min            : unsigned(31 downto 0) := (others => '0');          -- minimum pause between frame

      variable y                         : unsigned(8*32-1 downto 0);  
      
      
   begin
        
      -- cfg usager
      y := cfg.buffer_a_addr
      & cfg.buffer_b_addr
      & cfg.buffer_c_addr
      & cfg.frame_byte_size 
      & cfg.hdr_pix_size
      & cfg.img_pix_size
      & cfg.lval_pause_min
      & cfg.fval_pause_min;
      return y;
      
   end to_intf_cfg;
   
   
   

end package body fb_testbench_pkg;

