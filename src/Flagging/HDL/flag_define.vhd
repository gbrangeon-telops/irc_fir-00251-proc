--******************************************************************************
-- Destination: 
--
--	File: flag_define.vhd
-- Hierarchy: Package file
-- Use: 
--	Project: TEL-2000
--	By: Fred Talbot
-- Date: 04 aout 2015
--
--******************************************************************************


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
use work.tel2000.all; 

package flag_define is    	  
   
   -- les differents modes d'operation du controleur
   constant DISABLE                : std_logic_vector(7 downto 0) := x"00";
   constant RISINGEDGE             : std_logic_vector(7 downto 0) := x"01";
   constant FALLINGEDGE            : std_logic_vector(7 downto 0) := x"02";
   constant ANYEDGE                : std_logic_vector(7 downto 0) := x"03";
   constant LEVELHIGH              : std_logic_vector(7 downto 0) := x"04";
   constant LEVELLOW               : std_logic_vector(7 downto 0) := x"05";
   
   constant FLAG_TRIG_HARDWARE     : std_logic := '0';
   constant FLAG_TRIG_SOFTWARE     : std_logic := '1';
   
   -------------------------------------------------------							
   -- parametres de config du flagging reçus du µblaze
   -------------------------------------------------------
   type flag_cfg_type is
   record 
      mode          : std_logic_vector(7 downto 0);
      delay 	     : unsigned(31 downto 0);          -- delai en coup de clock de 100 MHz
      frame_count   : unsigned(31 downto 0);          -- nb de frame a flagger sur mode edge
      trig_source   : std_logic;                      -- '0' = hardware, '1' = software
      dval          : std_logic;                      -- '1' = cfg valide
   end record flag_cfg_type;
   
   signal s_flag_cfg : flag_cfg_type;
   
   constant flag_cfg_default : flag_cfg_type := (
   DISABLE,
   to_unsigned(0,s_flag_cfg.delay'LENGTH), 
   to_unsigned(1,s_flag_cfg.frame_count'LENGTH),
   FLAG_TRIG_HARDWARE,
   '0'
   );
   
end flag_define;

package body flag_define is
   
end package body flag_define; 
