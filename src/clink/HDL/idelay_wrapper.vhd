------------------------------------------------------------------
--!   @file : idelay_wrapper
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- other libraries declarations
-- synthesis translate_off 
library KINTEX7;
library IEEE;
use IEEE.vital_timing.all;
-- synthesis translate_on 


entity idelay_wrapper is
   generic (
      IDELAY_VALUE   : integer := 0;
      SIGNAL_PATTERN : string := "DATA";
      IDELAY_TYPE    : string := "VAR_LOAD"
      );   
   port(
      C           : in std_logic;
      LD          : in std_logic;
      IDATAIN     : in std_logic;      
      DATAOUT     : out std_logic;      
      CNTVALUEIN  : in std_logic_vector(4 downto 0);
      CNTVALUEOUT : out std_logic_vector(4 downto 0)      
      );
end idelay_wrapper;


architecture rtl of idelay_wrapper is
   
   component IDELAYE2
      generic(
         CINVCTRL_SEL : STRING := "FALSE";
         DELAY_SRC : STRING := "IDATAIN";
         HIGH_PERFORMANCE_MODE : STRING := "TRUE";
         IDELAY_TYPE : STRING := "FIXED";
         IDELAY_VALUE : INTEGER := 0;
         PIPE_SEL : STRING := "FALSE";
         REFCLK_FREQUENCY : REAL := 200.0;
         SIGNAL_PATTERN : STRING := "DATA"
         );
      port (
         C : in STD_ULOGIC;
         CE : in STD_ULOGIC;
         CINVCTRL : in STD_ULOGIC;
         CNTVALUEIN : in STD_LOGIC_VECTOR(4 downto 0);
         DATAIN : in STD_ULOGIC;
         IDATAIN : in STD_ULOGIC;
         INC : in STD_ULOGIC;
         LD : in STD_ULOGIC;
         LDPIPEEN : in STD_ULOGIC;
         REGRST : in STD_ULOGIC;
         CNTVALUEOUT : out STD_LOGIC_VECTOR(4 downto 0);
         DATAOUT : out STD_ULOGIC
         );
   end component;
   
begin
   
   delay_inst : IDELAYE2
   generic map (
      CINVCTRL_SEL  => "FALSE",
      DELAY_SRC  => "IDATAIN",
      HIGH_PERFORMANCE_MODE  => "TRUE",
      IDELAY_TYPE  => IDELAY_TYPE, -- "VAR_LOAD", "FIXED"
      IDELAY_VALUE  => IDELAY_VALUE,
      PIPE_SEL  => "FALSE",
      REFCLK_FREQUENCY  => 200.0,
      SIGNAL_PATTERN  => SIGNAL_PATTERN
      )
   port map(
      C              => C,
      CE             => '0',
      CINVCTRL       => '0',
      CNTVALUEIN     => CNTVALUEIN,
      CNTVALUEOUT    => CNTVALUEOUT,
      DATAIN         => '0',
      DATAOUT        => DATAOUT,
      IDATAIN        => IDATAIN,
      INC            => '0',
      LD             => LD,
      LDPIPEEN       => '0',
      REGRST         => '0'
      );
   
end rtl;

