----------------------------------------------------------------------------------
-- Company: Telops
-- Engineer: ALA
-- 
-- Create Date: 12/18/2023 07:12:42 AM
-- Design Name: FIR-00251-Proc
-- Module Name: kpix_dlypipeline - Behavioral
-- Project Name: Senseeker
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
library WORK;
use WORK.PROXY_DEFINE.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity kpix_dlypipeline is
    Generic (
        CLOCK_LATENCY : natural := 0
    );
    Port (
        clk : in std_logic;
        rst : in std_logic;
        input  : in  calcium_quad_data_type;
        output : out calcium_quad_data_type
    );
end kpix_dlypipeline;

architecture Behavioral of kpix_dlypipeline is
    constant RESET_VALUE : calcium_quad_data_type := ((others => (others => '0')), others => '0');
    
    type delay_pipeline_type is array (0 to CLOCK_LATENCY) of calcium_quad_data_type;
    
    signal delay_pipeline : delay_pipeline_type := (others => RESET_VALUE);
begin
    delay_pipeline(0) <= input;
    output            <= delay_pipeline(CLOCK_LATENCY);
    
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                delay_pipeline(1 to CLOCK_LATENCY) <= (others => RESET_VALUE);
            else
                delay_pipeline(1 to CLOCK_LATENCY) <= delay_pipeline(0 to CLOCK_LATENCY-1);
            end if;
        end if;
    end process;
end Behavioral;
