--******************************************************************************
-- Destination: 
--
--	File: detector_trace_define.vhd
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


package detector_trace_define is    
   
   
   constant RE_ROIC_DATA_NS      : integer := 0;
   constant FE_ROIC_DATA_NS      : integer := 0;
   
   constant RE_ROIC_FSYNC_NS     : integer := 0;
   constant FE_ROIC_FSYNC_NS     : integer := 520_200; -- dépend du frame rate
   
   constant RE_ROIC_MCLK_NS      : integer := 175;
   constant FE_ROIC_MCLK_NS      : integer := 75;
   
   constant RE_ADC_SYNC_FLAG_NS  : integer := 520_188; -- dépend du frame rate
   constant FE_ADC_SYNC_FLAG_NS  : integer := 540_188;
   
   constant RE_QUAD1_CLK_NS      : integer := 12;      -- 12.5 en realité
   constant FE_QUAD1_CLK_NS      : integer := 0;       
   
   constant RE_QUAD2_CLK_NS      : integer := 12;
   constant FE_QUAD2_CLK_NS      : integer := 0;
   
   constant RE_QUAD3_CLK_NS      : integer := 12;
   constant FE_QUAD3_CLK_NS      : integer := 0;
   
   constant RE_QUAD4_CLK_NS      : integer := 12;
   constant FE_QUAD4_CLK_NS      : integer := 0;
   
   
   
   
end detector_trace_define;

package body detector_trace_define is
   
   
end package body detector_trace_define; 
