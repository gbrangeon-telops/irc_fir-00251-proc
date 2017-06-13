library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.NUMERIC_STD.ALL;  --try to use this library as much as possible.

entity sinewave is
generic( 
    ADC_NBITS         : integer := 16; -- legal values are 14, 16, 18
    CLK_PERIOD : time := 50 ns;
    SIN_PERIOD : time := 1 ms
    );
port (
    clk :in  std_logic;
    sin_out : out unsigned(15 downto 0)
    --sin_out : out real
    );
end sinewave;

architecture Behavioral of sinewave is

CONSTANT SIN_RANGE : integer := SIN_PERIOD/CLK_PERIOD;
type memory_type is array (0 to SIN_RANGE) of real; 

signal sine : memory_type;
signal cnt : unsigned (20 downto 0) := to_unsigned(0,21);

begin

sin_table : process
begin
    for i in 0 to SIN_RANGE loop
        sine(i) <= SIN( real(i) / real(SIN_RANGE) * 2.0 * MATH_PI);
    end loop;
    wait;
end process;
    





process(clk)
begin
  --to check the rising edge of the clock signal
  if(rising_edge(clk)) then
        sin_out <= to_unsigned( natural((sine(to_integer(cnt))+1.0 ) / real(2.0) * real(2**integer'(ADC_NBITS))),sin_out'length);
        if( cnt < SIN_RANGE) then
            cnt <= cnt + 1;
        else
            cnt <= to_unsigned(0,21);    
        end if;
        
    end if;
end process;


--step_out : process
--    variable step_out : unsigned(15 downto 0) := to_unsigned(0,16);
--begin
--   step_out := step_out + x"1000";
--   sin_out <=  step_out;
--   wait for 500 us;
--end process;


end Behavioral;

