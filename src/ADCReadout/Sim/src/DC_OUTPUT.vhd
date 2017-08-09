library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.NUMERIC_STD.ALL;  --try to use this library as much as possible.

entity DC_OUTPUT is
generic( 
    ADC_NBITS         : integer := 16; -- legal values are 14, 16, 18
    MV_VALUE          : real := 3.3;
    VALUE_RANGE       : real := 20.0;
    ZERO_OFFSET       : real := 10.0
    
    );
port (
    dc_out : out unsigned(ADC_NBITS-1 downto 0)
    --sin_out : out real
    );
end DC_OUTPUT;

architecture sim of DC_OUTPUT is



begin

sin_table : process
begin

    dc_out <= to_unsigned( integer((ZERO_OFFSET + MV_VALUE)/VALUE_RANGE * 2.0 ** ADC_NBITS ),ADC_NBITS);

    wait;
end process;


end sim;

