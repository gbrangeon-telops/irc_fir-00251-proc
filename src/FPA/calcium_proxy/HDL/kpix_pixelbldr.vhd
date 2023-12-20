----------------------------------------------------------------------------------
-- Company: Telops
-- Engineer: ALA
-- 
-- Create Date: 12/18/2023 03:46:03 PM
-- Design Name: FIR-00251-Proc
-- Module Name: kpix_pixelbldr - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity kpix_pixelbldr is
    Port (
        clk  : in std_logic;
        rst  : in std_logic;
        kpix : in std_logic_vector;
        pix_in  : in  calcium_quad_data_type;
        pix_out : out calcium_quad_data_type
    );
end kpix_pixelbldr;

architecture Behavioral of kpix_pixelbldr is
    constant KPIX_LENGTH : positive := kpix'LENGTH / 4;
    type kpix_data_array_type is array (1 to 4) of signed(pix_data_range_type);
    signal kpix_data : kpix_data_array_type;
    
    signal pgen_en   : std_logic;
    signal pgen_kpix : std_logic_vector(15 downto 0);
    
    signal kpix_mean : std_logic_vector(15 downto 0);
    
    type compute_pipeline_type is array (0 to 2, 1 to 4) of unsigned(pix_data_range_type);
    constant COMPUTE_PIPELINE_RESET : compute_pipeline_type := (others => (others => (others => '0')));
    signal compute_pipeline : compute_pipeline_type := COMPUTE_PIPELINE_RESET;
    
    type data_pipeline_type is array (0 to 2) of calcium_quad_data_type;
    constant DATA_RESET : calcium_quad_data_type := ((others => (others => '0')), others => '0');
    constant DATA_PIPELINE_RESET : data_pipeline_type := (others => DATA_RESET);
    signal data_pipeline : data_pipeline_type := DATA_PIPELINE_RESET;
begin
    kpix_gen : for i in 1 to 4 generate
        kpix_data(i) <= resize(signed(pgen_kpix), kpix_data(i)'LENGTH) when pgen_en = '1' else resize(signed(kpix(i*KPIX_LENGTH-1 downto (i-1)*KPIX_LENGTH)), kpix_data(i)'LENGTH);
    end generate;
    
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                compute_pipeline <= COMPUTE_PIPELINE_RESET;
                data_pipeline    <= DATA_PIPELINE_RESET;
                pix_out          <= DATA_RESET;
            else
                for i in 1 to 4 loop
                    compute_pipeline(0, i) <= unsigned(kpix_data(i)) + unsigned(kpix_mean);
                    compute_pipeline(1, i) <= compute_pipeline(0, i) * unsigned(data_pipeline(0).pix_data(i)(pix_coarse_range_type));
                    compute_pipeline(2, i) <= compute_pipeline(1, i) + unsigned(data_pipeline(1).pix_data(i)(pix_residue_range_type));
                end loop;
                
                data_pipeline(0) <= pix_in;
                data_pipeline(1) <= data_pipeline(0);
                data_pipeline(2) <= data_pipeline(1);
                
                pix_out <= data_pipeline(2);
                if data_pipeline(2).aoi_dval = '1' then
                    for i in 1 to 4 loop
                        pix_out.pix_data(i) <= std_logic_vector(compute_pipeline(2, i));
                    end loop;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
