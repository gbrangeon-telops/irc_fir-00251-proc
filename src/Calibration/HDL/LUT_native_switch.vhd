-------------------------------------------------------------------------------
--
-- Title       : LUT_native_switch
-- Design      : FIR_00251
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\Calibration\HDL\LUT_native_switch.vhd
-- Generated   : Thu Aug  6 08:53:19 2020
-- From        : this file is a switch for BRAM port
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {LUT_native_switch} architecture {LUT_native_switch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity LUT_native_switch is
	 port(			   
		 SWITCH : in STD_LOGIC;
		 -- native read port for axi-lite
		 AXI_LITE_RD_EN 	   : in std_logic;
		 AXI_LITE_RD_ADD       : in std_logic_vector(31 downto 0);      
      	 AXI_LITE_RD_DATA      : out std_logic_vector(31 downto 0);	   
         AXI_LITE_RD_DVAL      : out std_logic;
         AXI_LITE_RD_BUSY      : out std_logic;
		 -- native read port for bram
		 BRAM_RD_EN : out std_logic;
		 BRAM_RD_ADD : out std_logic_vector(31 downto 0);
		 BRAM_RD_DATA : in std_logic_vector(31 downto 0);
		 BRAM_RD_DVAL : in std_logic;	  
		 BRAM_RD_EOF_IN : out std_logic;
		 BRAM_RD_EOF_OUT  : in std_logic;
		 -- read port for calibration
		 READ_PORT_RD_EN : in std_logic;
		 READ_PORT_RD_ADD : in std_logic_vector(31 downto 0);
		 READ_PORT_DATA   : out std_logic_vector(31 downto 0);	
		 READ_PORT_RD_DVAL : out std_logic;
		 READ_PORT_RD_EOF_IN : in std_logic;
		 READ_PORT_RD_EOF_OUT : out std_logic
	     );
end LUT_native_switch;

--}} End of automatically maintained section

architecture LUT_native_switch of LUT_native_switch is
begin
	
	-- switch = 1, axi-lite
	-- switch = 0, bram read
	
	-- output assignation for AXI-LITE port
	AXI_LITE_RD_DATA <= 	BRAM_RD_DATA when SWITCH = '1' else (others => '0');
	AXI_LITE_RD_DVAL <= 	BRAM_RD_DVAL when SWITCH = '1' else '0';
	AXI_LITE_RD_BUSY <= '0';		 
	
	-- output assignation for READ PORT
	READ_PORT_DATA 	  <= (others => '0') when SWITCH = '1' else BRAM_RD_DATA;
	READ_PORT_RD_DVAL <= '0' when SWITCH = '1' else BRAM_RD_DVAL;
	READ_PORT_RD_EOF_OUT <= '0' when SWITCH = '1' else BRAM_RD_EOF_OUT;
		
	-- output assignation for BRAM
	BRAM_RD_EN <=  AXI_LITE_RD_EN when SWITCH = '1' else READ_PORT_RD_EN;
	BRAM_RD_ADD <= AXI_LITE_RD_ADD when SWITCH = '1' else READ_PORT_RD_ADD;
	BRAM_RD_EOF_IN <= '0' when SWITCH = '1' else READ_PORT_RD_EOF_IN;	
		
end LUT_native_switch;
