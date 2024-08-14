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
use IEEE.NUMERIC_STD.ALL;

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
        BIT_OUT      : out std_logic_vector(8 downto 1);
        BIT_OUT_P    : inout std_logic_vector(8 downto 1);
        BIT_OUT_N    : inout std_logic_vector(8 downto 1)
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
    
    signal oq : std_logic_vector(8 downto 1);
    signal tq : std_logic_vector(8 downto 1);
    
    signal fpa_int : std_logic;
    
    signal fpa_intf_cfg_i : fpa_intf_cfg_type;
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
          FPA_INTF_CFG => fpa_intf_cfg_i,
          FPA_INT      => fpa_int,
          QUAD_DATA    => open,
          OCTO_DATA    => octo_data_i
          );
          
    G0 : for i in octo_serial_i'RANGE generate
        signal d : std_logic_vector(8 downto 1);
    begin
        octo_serial_i(i)(24)          <= octo_data_ii.lval when (i mod 2) = 0 else octo_data_ii.fval;
        octo_serial_i(i)(23 downto 1) <= octo_data_ii.pix_data(i);
        
        d <= octo_serial_i(i)(8*j+8 downto 8*j+1);
        
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
               TRISTATE_WIDTH => 1
            )
            port map (
               OFB       => open,
               OQ        => oq(i),
               SHIFTOUT1 => open,
               SHIFTOUT2 => open,
               TBYTEOUT  => open,
               TFB       => open,
               TQ        => tq(i),
               CLK       => BIT_CLK,
               CLKDIV    => PIPE_CLK,
               D1        => d(8),
               D2        => d(7),
               D3        => d(6),
               D4        => d(5),
               D5        => d(4),
               D6        => d(3),
               D7        => d(2),
               D8        => d(1),
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
            
        IOBUFDS_inst : IOBUFDS
           generic map (
              DIFF_TERM    => TRUE,
              IBUF_LOW_PWR => FALSE,
              IOSTANDARD   => "LVDS_25",
              SLEW         => "FAST")
           port map (
              O   => BIT_OUT(i),
              IO  => BIT_OUT_P(i),
              IOB => BIT_OUT_N(i),
              I   => oq(i),
              T   => tq(i)
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
    
    process(PIXEL_CLK)
    begin
        if rising_edge(PIXEL_CLK) then
            if sreset = '1' then
                fpa_int <= '0';
            else
                fpa_int <= not fpa_int;
            end if;
        end if;
    end process;
    
    process(FPA_INTF_CFG)
    begin
        fpa_intf_cfg_i <= FPA_INTF_CFG;
        fpa_intf_cfg_i.diag.xsize_div_per_pixel_num <= "0" & FPA_INTF_CFG.diag.xsize_div_per_pixel_num(9 downto 1);
    end process;
end Behavioral;
