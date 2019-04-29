------------------------------------------------------------------
--!   @file : monit_adc_dummy
--!   @brief
--!   @details
--!
--!   $Rev: 22596 $
--!   $Author: enofodjie $
--!   $Date: 2018-12-04 12:05:46 -0500 (mar., 04 déc. 2018) $
--!   $Id: monit_adc_dummy.vhd 22596 2018-12-04 17:05:46Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/FPA/isc0207A/src/monit_adc_dummy.vhd $
------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity monit_adc_dummy is
   port(
      CLK      : in STD_LOGIC;
      ARESET   : in STD_LOGIC;
      SPI_SDI  : in std_logic;
      SPI_CSN  : in std_logic;
      SPI_SDO  : out std_logic;
      SPI_CLK  : in std_logic;
      CFG      : out std_logic_vector(15 downto 0);
      CFG_DVAL : out std_logic;
      CH0_DATA : in std_logic_vector(15 downto 0);
      CH1_DATA : in std_logic_vector(15 downto 0);
      CH2_DATA : in std_logic_vector(15 downto 0);
      CH3_DATA : in std_logic_vector(15 downto 0)
      );
end monit_adc_dummy;



architecture rtl of monit_adc_dummy is
   component spi_rx
      generic(
         BITWIDTH : NATURAL := 12
         );
      port (
         CLK : in STD_LOGIC;
         CSn : in STD_LOGIC;
         SCL : in STD_LOGIC;
         SDA : in STD_LOGIC;
         DOUT : out STD_LOGIC_VECTOR(BITWIDTH-1 downto 0);
         DVAL : out STD_LOGIC
         );
   end component;
   
   type ads1118_sm_type is (idle, send_data_st, wait_csn_st1, wait_csn_st2);
   type din_type is array (0 to 3) of std_logic_vector(15 downto 0);
   
   signal ads1118_sm : ads1118_sm_type;
   signal sclk_i     : std_logic;
   signal cfg_i      : std_logic_vector(15 downto 0);
   signal cfg_dval_i : std_logic;
   signal ss_i       : std_logic;
   signal mux_i      : std_logic_vector(2 downto 0);
   signal pga_i      : std_logic_vector(2 downto 0);
   signal mode_i     : std_logic;
   signal ddr_i      : std_logic_vector(2 downto 0);
   signal ts_mode_i  : std_logic;
   signal pull_up_enable_i : std_logic;
   signal nop_i      : std_logic_vector(1 downto 0);
   signal sclk_last  : std_logic;
   signal cfg_valid  : std_logic;
   signal ch_id      : integer range 0 to 3;
   signal bitcnt     : integer range -1 to 15;
   signal din        : din_type;
   signal data_to_send   : std_logic_vector(15 downto 0);
   
begin
   
   sclk_i   <=  transport SPI_CLK after 20ns;
   
   din(0) <= CH0_DATA; 
   din(1) <= CH1_DATA;
   din(2) <= CH2_DATA;
   din(3) <= CH3_DATA;
   
   CFG      <= cfg_i;
   CFG_DVAL <= cfg_dval_i;
   
   
   U5 : spi_rx
   generic map (
      BITWIDTH => 16
      )
   port map(
      CLK  => CLK,
      CSn  => SPI_CSN,
      SCL  => sclk_i,
      SDA  => SPI_SDI,
      DOUT => cfg_i,
      DVAL => cfg_dval_i
      );
   
   -- cfg
   ss_i        <= cfg_i(15);
   mux_i       <= cfg_i(14 downto 12);
   pga_i       <= cfg_i(11 downto 9);
   mode_i      <= cfg_i(8);
   ddr_i       <= cfg_i(7 downto 5);
   ts_mode_i   <= cfg_i(4);
   pull_up_enable_i <= cfg_i(3);
   nop_i       <= cfg_i(2 downto 1);
   
   
   -- 
   U6 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if areset = '1' then 
            ads1118_sm <= idle;
            SPI_SDO <= '0';
         else
            
            sclk_last <= sclk_i;
            
            ---if mux_i(2) = '1' and pga_i = "010" and mode_i = '0' and pull_up_enable_i = '1' and nop_i = "01" then
            cfg_valid <= cfg_dval_i;
            ---else
            ---   cfg_valid <= '0';
            ---end if;                                               
            
            ch_id <= to_integer(unsigned(mux_i(1 downto 0)));            
            
            case ads1118_sm is
               
               when idle =>
                  SPI_SDO <= '0';
                  bitcnt <= 15;
                  data_to_send <= din(ch_id);
                  if cfg_valid = '1'  then
                     ads1118_sm <= wait_csn_st1;
                  end if;
               
               when wait_csn_st1 =>
                  if SPI_CSN = '1' then 
                     ads1118_sm <= wait_csn_st2;
                  end if;
               
               when wait_csn_st2 =>
                  if SPI_CSN = '0' then 
                     ads1118_sm <= send_data_st;
                  end if;
               
               when send_data_st =>
                  if sclk_i = '1' and sclk_last = '0' then
                     bitcnt <= bitcnt - 1;
                     SPI_SDO <= data_to_send(bitcnt);
                  end if;
                  if SPI_CSN = '1' then 
                     ads1118_sm <= idle;
                  end if;                  
               
               when others =>
                  
               
            end case;
            
         end if;  
         
      end if;    
   end process;
   
end rtl;
