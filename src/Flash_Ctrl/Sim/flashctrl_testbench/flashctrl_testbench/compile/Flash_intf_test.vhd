-------------------------------------------------------------------------------
--
-- Title       : Flash_intf_test
-- Design      : flashctrl_testbench
-- Author      : Unknown
-- Company     : Unknown
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\Flash_Ctrl\Sim\flashctrl_testbench\flashctrl_testbench\compile\Flash_intf_test.vhd
-- Generated   : Mon Dec  1 08:24:25 2014
-- From        : D:\Telops\FIR-00251-Proc\src\Flash_Ctrl\HDL\Flash_intf_test.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;


-- other libraries declarations
-- synthesis translate_off 
library KINTEX7;
library IEEE;
use IEEE.vital_timing.all;
-- synthesis translate_on 

entity Flash_intf_test is
  port(
       FLASH_RDY_BUSY_N : in STD_LOGIC;
       FLASH_RDY_BUSY_N2 : in STD_LOGIC;
       FLASH_CTRL : in STD_LOGIC_VECTOR(4 downto 0);
       CTRL_F_RDY_BUSY_N : out STD_LOGIC;
       FLASH_ALE : out std_ulogic;
       FLASH_CE2_N : out STD_LOGIC;
       FLASH_CE_N : out std_ulogic;
       FLASH_CLE : out std_ulogic;
       FLASH_DQS : out STD_LOGIC;
       FLASH_RE_N : out std_ulogic;
       FLASH_WE_N : out std_ulogic;
       FLASH_DQ2 : out STD_LOGIC_VECTOR(15 downto 8);
       FLASH_DQ : inout STD_LOGIC_VECTOR(7 downto 0);
       FLASH_DQ_CPU : inout STD_LOGIC_VECTOR(7 downto 0)
  );
end Flash_intf_test;

architecture Flash_intf_test of Flash_intf_test is

---- Component declarations -----

component OBUF
-- synthesis translate_off
  generic(
       CAPACITANCE : STRING := "DONT_CARE";
       DRIVE : INTEGER := 12;
       IOSTANDARD : STRING := "DEFAULT";
       SLEW : STRING := "SLOW"
  );
-- synthesis translate_on
  port (
       I : in std_ulogic;
       O : out std_ulogic
  );
end component;

----     Constants     -----
constant VCC_CONSTANT   : STD_LOGIC := '1';

---- Signal declarations used on the diagram ----

signal NET502 : STD_LOGIC;
signal NET579 : STD_LOGIC;
signal VCC : STD_LOGIC;
signal BUS434 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS451 : STD_LOGIC_VECTOR (7 downto 0);

begin

----  Component instantiations  ----

U1 : OBUF
  port map(
       I => FLASH_CTRL(0),
       O => FLASH_CE_N
  );

U2 : OBUF
  port map(
       I => FLASH_CTRL(1),
       O => FLASH_CLE
  );

U3 : OBUF
  port map(
       I => FLASH_CTRL(2),
       O => FLASH_ALE
  );

U4 : OBUF
  port map(
       I => FLASH_CTRL(3),
       O => FLASH_WE_N
  );

U5 : OBUF
  port map(
       I => FLASH_CTRL(4),
       O => FLASH_RE_N
  );


---- Power , ground assignment ----

VCC <= VCC_CONSTANT;
BUS434(7) <= VCC;
BUS434(6) <= VCC;
BUS434(5) <= VCC;
BUS434(4) <= VCC;
BUS434(3) <= VCC;
BUS434(2) <= VCC;
BUS434(1) <= VCC;
BUS434(0) <= VCC;
NET502 <= VCC;

---- Terminal assignment ----

    -- Inputs terminals
	NET579 <= FLASH_RDY_BUSY_N;

    -- Output\buffer terminals
	CTRL_F_RDY_BUSY_N <= NET579;
	FLASH_CE2_N <= NET502;
	FLASH_DQ2 <= BUS434;
	FLASH_DQS <= NET502;

    -- Bidirectional terminals
	BUS451 <= FLASH_DQ;
	FLASH_DQ <= BUS451;
	BUS451 <= FLASH_DQ_CPU;
	FLASH_DQ_CPU <= BUS451;


end Flash_intf_test;
