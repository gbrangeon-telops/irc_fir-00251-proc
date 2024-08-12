----------------------------------------------------------------------------------
-- Company: Telops
-- Engineer: ALA
-- 
-- Create Date: 08/05/2024 01:08:09 PM
-- Design Name: 
-- Module Name: oserdes_test_pattern - Behavioral
-- Project Name: calcium640D
-- Target Devices: Kintex 7
-- Tool Versions: 2018.3
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

use work.Proxy_define.all;

entity oserdes_test_pattern is
    Port (
        OSERDES_RST  : in std_logic;
        PIXEL_CLK    : in std_logic;
        PIPE_CLK     : in std_logic;
        BIT_CLK      : in std_logic;
        FPA_INTF_CFG : in fpa_intf_cfg_type;
        BIT_OUT      : out std_logic_vector(1 to 8)
    );
end oserdes_test_pattern;

architecture Behavioral of oserdes_test_pattern is
    component calcium_diag_data_gen is
       generic(
          DETECTOR_WIDTH       : positive := 640;
          DETECTOR_HEIGHT      : positive := 512;
          OCTO_DATA_ENA        : boolean  := FALSE;
          DIAG_DATA_CLK_FACTOR : integer  := DEFINE_DIAG_DATA_CLK_FACTOR
          );
       port(
          ARESET       : in std_logic;
          CLK          : in std_logic;
          FPA_INTF_CFG : in fpa_intf_cfg_type;
          FPA_INT      : in std_logic;
          QUAD_DATA    : out calcium_quad_data_type; --! sortie des données deserialisés
          OCTO_DATA    : out calcium_octo_data_type
          );
    end component;
    
    component sync_reset is
       port(
          ARESET : in std_logic;
          SRESET : out std_logic;
          CLK    : in std_logic
          );
    end component;
    
    signal octo_data_i  : calcium_octo_data_type;
    signal octo_data_ii : calcium_octo_data_type;
    
    type calcium_octo_serial_type is array (1 to 8) of std_logic_vector(24 downto 1);
    signal octo_serial_i : calcium_octo_serial_type;
    
    signal j : natural range 0 to 2;
    
    signal sreset : std_logic;
begin
    calcium_diag_data_gen_inst : calcium_diag_data_gen
       generic map(
          DETECTOR_WIDTH       => 640,
          DETECTOR_HEIGHT      => 512,
          OCTO_DATA_ENA        => TRUE,
          DIAG_DATA_CLK_FACTOR => 1
          )
       port map(
          ARESET       => OSERDES_RST,
          CLK          => PIXEL_CLK,
          FPA_INTF_CFG => FPA_INTF_CFG,
          FPA_INT      => '1',
          QUAD_DATA    => open,
          OCTO_DATA    => octo_data_i
          );
          
    G0 : for i in octo_serial_i'RANGE generate
    begin
        octo_serial_i(i)(24)          <= octo_data_ii.lval when (i mod 2) = 0 else octo_data_ii.fval;
        octo_serial_i(i)(23 downto 1) <= octo_data_ii.pix_data(i);
        
        OSERDESE2_inst : OSERDESE2
            generic map (
               DATA_RATE_OQ   => "DDR",
               DATA_RATE_TQ   => "DDR",
               DATA_WIDTH     => 8,
               INIT_OQ        => '0',
               INIT_TQ        => '0',
               SERDES_MODE    => "MASTER",
               SRVAL_OQ       => '0',
               SRVAL_TQ       => '0',
               TBYTE_CTL      => "FALSE",
               TBYTE_SRC      => "FALSE",
               TRISTATE_WIDTH => 4
            )
            port map (
               OFB       => open,
               OQ        => BIT_OUT(i),
               SHIFTOUT1 => open,
               SHIFTOUT2 => open,
               TBYTEOUT  => open,
               TFB       => open,
               TQ        => open,
               CLK       => BIT_CLK,
               CLKDIV    => PIPE_CLK,
               D1        => octo_serial_i(i)(8*j+8),
               D2        => octo_serial_i(i)(8*j+7),
               D3        => octo_serial_i(i)(8*j+6),
               D4        => octo_serial_i(i)(8*j+5),
               D5        => octo_serial_i(i)(8*j+4),
               D6        => octo_serial_i(i)(8*j+3),
               D7        => octo_serial_i(i)(8*j+2),
               D8        => octo_serial_i(i)(8*j+1),
               OCE       => '1',
               RST       => OSERDES_RST,
               SHIFTIN1  => '0',
               SHIFTIN2  => '0',
               T1        => '0',
               T2        => '0',
               T3        => '0',
               T4        => '0',
               TBYTEIN   => '0',
               TCE       => '0'
            );
    end generate;
    
    sync_reset_inst : sync_reset
       port map(
          ARESET => OSERDES_RST,
          SRESET => sreset,
          CLK    => PIPE_CLK
          );
          
    process(PIPE_CLK)
    begin
        if rising_edge(PIPE_CLK) then
            if sreset = '1' then
                octo_data_ii <= ((others => (others => '0')), others => '0');
                j            <= 2;
            elsif j = 0 then
                octo_data_ii <= octo_data_i;
                j            <= 2;
            else
                octo_data_ii <= octo_data_ii;
                j            <= j - 1;
            end if;
        end if;
    end process;
end Behavioral;
