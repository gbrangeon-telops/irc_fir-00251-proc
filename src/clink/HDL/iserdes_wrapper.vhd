------------------------------------------------------------------
--!   @file : iserdes_wrapper
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


entity iserdes_wrapper is
   generic(
      IOBDELAY       : STRING := "NONE"   -- "IBUF" or "NONE"
      );
      
   port (
      CLK      : in STD_ULOGIC;
      CLKB     : in STD_ULOGIC;
      CLKDIV   : in STD_ULOGIC;
      D        : in STD_ULOGIC;
      DDLY     : in STD_ULOGIC;
      RST      : in STD_ULOGIC;
      Q1       : out STD_ULOGIC;
      Q2       : out STD_ULOGIC;
      Q3       : out STD_ULOGIC;
      Q4       : out STD_ULOGIC;
      Q5       : out STD_ULOGIC;
      Q6       : out STD_ULOGIC;
      Q7       : out STD_ULOGIC
      );
end iserdes_wrapper;


architecture rtl of iserdes_wrapper is
   
   component ISERDESE2
      generic(
         DATA_RATE : STRING := "DDR";
         DATA_WIDTH : INTEGER := 4;
         DYN_CLKDIV_INV_EN : STRING := "FALSE";
         DYN_CLK_INV_EN : STRING := "FALSE";
         INIT_Q1 : BIT := '0';
         INIT_Q2 : BIT := '0';
         INIT_Q3 : BIT := '0';
         INIT_Q4 : BIT := '0';
         INTERFACE_TYPE : STRING := "MEMORY";
         IOBDELAY : STRING := "NONE";
         NUM_CE : INTEGER := 2;
         OFB_USED : STRING := "FALSE";
         SERDES_MODE : STRING := "MASTER";
         SRVAL_Q1 : BIT := '0';
         SRVAL_Q2 : BIT := '0';
         SRVAL_Q3 : BIT := '0';
         SRVAL_Q4 : BIT := '0'
         );
      port (
         BITSLIP : in STD_ULOGIC;
         CE1 : in STD_ULOGIC;
         CE2 : in STD_ULOGIC;
         CLK : in STD_ULOGIC;
         CLKB : in STD_ULOGIC;
         CLKDIV : in STD_ULOGIC;
         CLKDIVP : in STD_ULOGIC;
         D : in STD_ULOGIC;
         DDLY : in STD_ULOGIC;
         DYNCLKDIVSEL : in STD_ULOGIC;
         DYNCLKSEL : in STD_ULOGIC;
         OCLK : in STD_ULOGIC;
         OCLKB : in STD_ULOGIC;
         OFB : in STD_ULOGIC;
         RST : in STD_ULOGIC;
         SHIFTIN1 : in STD_ULOGIC;
         SHIFTIN2 : in STD_ULOGIC;
         O : out STD_ULOGIC;
         Q1 : out STD_ULOGIC;
         Q2 : out STD_ULOGIC;
         Q3 : out STD_ULOGIC;
         Q4 : out STD_ULOGIC;
         Q5 : out STD_ULOGIC;
         Q6 : out STD_ULOGIC;
         Q7 : out STD_ULOGIC;
         Q8 : out STD_ULOGIC;
         SHIFTOUT1 : out STD_ULOGIC;
         SHIFTOUT2 : out STD_ULOGIC
         );
   end component;
   
begin
   
   iserdes_inst : ISERDESE2
   
   generic map (
      DATA_RATE=> "SDR",
      DATA_WIDTH => 7,
      DYN_CLKDIV_INV_EN =>"FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => IOBDELAY,
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
      )
   port map(
      BITSLIP      => '0',
      CE1          => '1',
      CE2          => '1',
      CLK          => CLK,
      CLKB         => CLKB,
      CLKDIV       => CLKDIV,
      CLKDIVP      => '0',
      D            => D,
      DDLY         => DDLY,
      DYNCLKDIVSEL => '0',
      DYNCLKSEL    => '0',
      O            => open,
      OCLK         => '0',
      OCLKB        => '0',
      OFB          => '0',
      Q1           => Q1,
      Q2           => Q2,
      Q3           => Q3,
      Q4           => Q4,
      Q5           => Q5,
      Q6           => Q6,
      Q7           => Q7,
      Q8           => open,
      RST          => RST,
      SHIFTIN1     => '0',
      SHIFTIN2     => '0',
      SHIFTOUT1    => open,
      SHIFTOUT2    => open
      );
   
end rtl;

