----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2024 02:48:05 PM
-- Design Name: 
-- Module Name: calcium640D_fpa_dummy - Behavioral
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

library WORK;
use WORK.PROXY_DEFINE.ALL;
use WORK.FPA_SERDES_DEFINE.ALL;
use WORK.FPA_DEFINE.ALL;

entity calcium640D_fpa_dummy is
    generic(                                                                      
         PIXEL_CLK_PERIOD : time := 30 ns;                                        
         PIPE_CLK_PERIOD : time := 10 ns;                                         
         BIT_CLK_PERIOD : time := 1250 ps;                                        
         FRAME_RATE_MIN : real := 0.1; -- Hz                                      
         CHANNEL_COUNT : positive := 4;                                           
         IODELAY_GROUP_NAME : string := "iodelay_b13";                            
         DATA_WIDTH : positive := PIXEL_CLK_PERIOD/BIT_CLK_PERIOD;                
         DATA_RATE : string := "SDR"                                              
    );                                                                            
    port(                                                                         
         NBITS_RESET_N : in STD_LOGIC;                                            
         PIXEL_CLK_N : in STD_ULOGIC;                                             
         PIXEL_CLK_P : in STD_ULOGIC;                                             
         REF_CLK : in std_ulogic;                                                 
         REF_CLK_RESET : in STD_ULOGIC;
         FPA_INTF_CFG : in fpa_intf_cfg_type;                                     
         FPA_INT : in STD_LOGIC;                                     
         CH_RDY : out STD_LOGIC;                                                  
         PIXEL_DOUT_CLK : out STD_LOGIC;                                          
         SERDES_TRIG : out STD_LOGIC;                                             
         PIXEL_DOUT : out STD_LOGIC_VECTOR(2*CHANNEL_COUNT*DATA_WIDTH-1 downto 0);
         STAT : out fpa_serdes_stat_type                                          
    );                                                                            
end calcium640D_fpa_dummy;

architecture Behavioral of calcium640D_fpa_dummy is
    component nbits_receiver_nch is
      generic(
           PIXEL_CLK_PERIOD : time := 30 ns;
           PIPE_CLK_PERIOD : time := 10 ns;
           BIT_CLK_PERIOD : time := 1250 ps;
           FRAME_RATE_MIN : real := 0.1; -- Hz
           CHANNEL_COUNT : positive := 4;
           IODELAY_GROUP_NAME : string := "iodelay_b13";
           DATA_WIDTH : positive := PIXEL_CLK_PERIOD/BIT_CLK_PERIOD;
           DATA_RATE : string := "SDR"
      );
      port(
           NBITS_RESET_N : in STD_LOGIC;
           PIXEL_CLK_N : in STD_ULOGIC;
           PIXEL_CLK_P : in STD_ULOGIC;
           REF_CLK : in std_ulogic;
           REF_CLK_RESET : in STD_ULOGIC;
           BIT_DIN_N : in STD_LOGIC_VECTOR(2*CHANNEL_COUNT-1 downto 0);
           BIT_DIN_P : in STD_LOGIC_VECTOR(2*CHANNEL_COUNT-1 downto 0);
           FPA_INTF_CFG : in fpa_intf_cfg_type;
           CH_RDY : out STD_LOGIC;
           PIXEL_DOUT_CLK : out STD_LOGIC;
           SERDES_TRIG : out STD_LOGIC;
           PIXEL_DOUT : out STD_LOGIC_VECTOR(2*CHANNEL_COUNT*DATA_WIDTH-1 downto 0);
           STAT : out fpa_serdes_stat_type
      );
    end component;
    
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
    
    signal fpa_intf_cfg_i : fpa_intf_cfg_type;
    signal octo_data_i    : calcium_octo_data_type;
    signal pixel_clk_i    : std_logic;
    
    type calcium_octo_serial_type is array (1 to 8) of std_logic_vector(DATA_WIDTH downto 1);
    signal octo_serial_i  : calcium_octo_serial_type;
    signal bit_dout_i     : std_logic_vector(8 downto 1);
begin
    process(FPA_INTF_CFG)
    begin
        fpa_intf_cfg_i <= FPA_INTF_CFG;
        fpa_intf_cfg_i.diag.xsize_div_per_pixel_num <= "0" & FPA_INTF_CFG.diag.xsize_div_per_pixel_num(9 downto 1);
    end process;
    
    pixel_clk_i <= PIXEL_CLK_P and (not PIXEL_CLK_N);
    
    calcium_diag_data_gen_inst : calcium_diag_data_gen
       generic map(
          DETECTOR_WIDTH       => XSIZE_MAX,
          DETECTOR_HEIGHT      => YSIZE_MAX,
          OCTO_DATA_ENA        => TRUE,
          DIAG_DATA_CLK_FACTOR => 1
          )
       port map(
          ARESET       => not NBITS_RESET_N,
          CLK          => pixel_clk_i,
          FPA_INTF_CFG => fpa_intf_cfg_i,
          FPA_INT      => FPA_INT,
          QUAD_DATA    => open,
          OCTO_DATA    => octo_data_i
          );
    
    process
    begin
        wait until rising_edge(pixel_clk_i);
        while TRUE loop
            for i in 1 to 4 loop
                octo_serial_i(2*i-1) <= octo_data_i.fval & octo_data_i.pix_data(2*i-1);
                octo_serial_i(2*i-0) <= octo_data_i.lval & octo_data_i.pix_data(2*i-0);
            end loop;
            
            for i in DATA_WIDTH downto 1 loop
                wait for BIT_CLK_PERIOD/2;
            
                for j in 1 to 8 loop
                    bit_dout_i(j) <= octo_serial_i(j)(i);
                end loop;
                
                wait for BIT_CLK_PERIOD/2;
            end loop;
        end loop;
    end process;
    
    nbits_receiver_nch_inst : nbits_receiver_nch
      generic map(
           PIXEL_CLK_PERIOD => PIXEL_CLK_PERIOD,
           PIPE_CLK_PERIOD => PIPE_CLK_PERIOD,
           BIT_CLK_PERIOD => BIT_CLK_PERIOD,
           FRAME_RATE_MIN => FRAME_RATE_MIN,
           CHANNEL_COUNT => CHANNEL_COUNT,
           IODELAY_GROUP_NAME => IODELAY_GROUP_NAME,
           DATA_RATE => DATA_RATE
      )
      port map(
           NBITS_RESET_N => NBITS_RESET_N,
           PIXEL_CLK_N => PIXEL_CLK_N,
           PIXEL_CLK_P => PIXEL_CLK_P,
           REF_CLK => REF_CLK,
           REF_CLK_RESET => REF_CLK_RESET,
           BIT_DIN_N(7 downto 0) => not(bit_dout_i),
           BIT_DIN_P(7 downto 0) => bit_dout_i,
           FPA_INTF_CFG => FPA_INTF_CFG,
           CH_RDY => CH_RDY,
           PIXEL_DOUT_CLK => PIXEL_DOUT_CLK,
           SERDES_TRIG => SERDES_TRIG,
           PIXEL_DOUT => PIXEL_DOUT,
           STAT => STAT
      );
end Behavioral;
