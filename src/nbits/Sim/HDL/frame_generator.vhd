----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2023 02:39:53 PM
-- Design Name: 
-- Module Name: frame_generator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use STD.ENV.ALL;

entity frame_generator is
    Generic (
        XSIZE     : positive := 10;
        YSIZE     : positive := 10;
        PIXELSIZE : positive := 24;
        FVAL      : boolean  := FALSE
    );
    Port (
        clk : in  std_logic;
        o   : out std_logic
    );
end frame_generator;

architecture Behavioral of frame_generator is
    type frame is array(0 to XSIZE, 0 to YSIZE) of std_logic_vector(PIXELSIZE-1 downto 0);
    function dummy_frame return frame is
        variable dummy : frame;
    begin
        for y in dummy'RANGE(2) loop
            for x in dummy'RANGE(1) loop
                if x = 0 or y = 0 then
                    dummy(x, y) := (others => '0');
                else
                    dummy(x, y) := std_logic_vector(to_unsigned((y - 1) * dummy'RIGHT(1) + x, dummy(x, y)'LENGTH));
                end if;
                dummy(x, y)(dummy(x, y)'LEFT) := '0' when y = 0 or (x = 0 and FVAL = FALSE) else '1';
            end loop;
        end loop;
        
        return dummy;
    end dummy_frame;
    constant TESTFRAME : frame := dummy_frame;
    
    signal clk_i : std_logic := '1';
    signal pxl_i : std_logic_vector(TESTFRAME(0, 0)'RANGE);
begin
    clk_i <= clk when clk /= 'U' else not clk_i after 5 ns;
    
    process
    begin
        for y in TESTFRAME'RANGE(2) loop
            for x in TESTFRAME'RANGE(1) loop
                pxl_i <= TESTFRAME(x, y);
                for i in TESTFRAME(x, y)'RANGE loop
                    o <= TESTFRAME(x, y)(i);
                    wait until rising_edge(clk_i);
                end loop;
            end loop;
        end loop;
        --stop;
    end process;
end Behavioral;
