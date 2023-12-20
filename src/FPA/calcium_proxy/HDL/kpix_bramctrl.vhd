----------------------------------------------------------------------------------
-- Company: Telops
-- Engineer: ALA
-- 
-- Create Date: 12/06/2023 07:30:43 AM
-- Design Name: FIR-00251-Proc
-- Module Name: kpix_bramctrl - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity kpix_bramctrl is
    Generic (
        DETECTOR_WIDTH  : positive                := 640;
        DETECTOR_HEIGHT : positive                := 512;
        KPIX_LENGTH     : positive range 12 to 13 := 12
    );
    Port (
        clk : in std_logic;
        rst : in std_logic;
        kpix_data : in std_logic_vector(31 downto 0);
        kpix_dval : in std_logic;
        bram_data : out std_logic_vector(2*KPIX_LENGTH-1 downto 0);
        bram_addr : out std_logic_vector(23 downto 0);
        bram_wena : out std_logic;
        error : out std_logic;
        done  : out std_logic;
        size  : out std_logic
    );
end kpix_bramctrl;

architecture Behavioral of kpix_bramctrl is
    constant ADDRESS_HIGH : natural := DETECTOR_WIDTH*DETECTOR_HEIGHT/2-1;
    
    signal bram_addr_i : natural range 0 to ADDRESS_HIGH := 0;
    
    signal error_i : std_logic := '0';
    
    alias kpix_even_sign : std_logic_vector(16-KPIX_LENGTH downto 0) is kpix_data(31 downto 31-(16-KPIX_LENGTH));
    alias kpix_odd_sign  : std_logic_vector(16-KPIX_LENGTH downto 0) is kpix_data(15 downto 15-(16-KPIX_LENGTH));
begin
    bram_data <= kpix_data(16+KPIX_LENGTH-1 downto 16) & kpix_data(0+KPIX_LENGTH-1 downto 0);
    bram_addr <= std_logic_vector(to_unsigned(bram_addr_i, bram_addr'LENGTH));
    bram_wena <= kpix_dval;
    
    error <= error_i;
    size  <= '0' when KPIX_LENGTH = 12 else '1';
    
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                bram_addr_i <= 0;
                error_i     <= '0';
                done        <= '0';
            elsif kpix_dval = '1' then
                if bram_addr_i = ADDRESS_HIGH then
                    bram_addr_i <= 0;
                    done        <= '1';
                else
                    bram_addr_i <= bram_addr_i + 1;
                    done        <= '0';
                end if;
                
                if bram_addr_i = 0 or error_i = '0' then
                    error_i <= (or(kpix_even_sign) and nand(kpix_even_sign)) or (or(kpix_odd_sign) and nand(kpix_odd_sign));
                end if;
            end if;
        end if;
    end process;
end Behavioral;
