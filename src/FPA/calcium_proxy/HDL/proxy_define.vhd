--******************************************************************************
-- Destination: 
--
--	File: Proxy_define.vhd
-- Hierarchy: Package file
-- Use: 
--	Project: IRCDEV
--	By: Edem Nofodjie
-- Date: 22 october 2009	  
--
--******************************************************************************
--Description
--******************************************************************************
-- 1- Defines the global variables 
-- 2- Defines the project function
--******************************************************************************


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use work.fpa_common_pkg.all;
use work.fpa_define.all;  

package Proxy_define is

   -- Pixel fields range. Used to index pixel bits vector.
   subtype pix_data_range_type    is natural range 22 downto  0;
   subtype pix_coarse_range_type  is natural range 22 downto 15;
   subtype pix_residue_range_type is natural range 14 downto  0;
   
   -- Quad pixel data array. Each pixel is on 23 bits.
   type pix_data_array_type is array (1 to 4) of std_logic_vector(22 downto 0);
   
   -- Quad data type. Quad pixel data array with some control signals.
   type calcium_quad_data_type is
   record
      -- Pixel data
      pix_data       : pix_data_array_type;
      -- Frame valid is high during a frame. Stays low at least 1 clk between frames.
      fval           : std_logic;
      -- Line valid is high during a line. Stays low at least 1 clk between lines.
      -- Can be high only when FVAL is high.
      lval           : std_logic;
      -- Data valid is high for each valid data transaction. Stays high if there are 2 
      -- consecutive transaction. Can be high only when FVAL and LVAL are high.
      dval           : std_logic;
      -- Area of interest data valid is the same signal as DVAL but is high only
      -- for pixel data transaction. Stays low for other data transactions.
      aoi_dval       : std_logic;
      -- Area of interest last is high during the last pixel data transaction.
      aoi_last       : std_logic;
   end record;
   
end Proxy_define;

package body Proxy_define is
   
   
   
end package body Proxy_define; 
