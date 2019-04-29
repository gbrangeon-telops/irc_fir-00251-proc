-------------------------------------------------------------------------------
--
-- Title       : suphawkA_spi_tx_check
-- Design      : suphawk_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\suphawk\src\suphawkA_spi_tx_check.vhd
-- Generated   : Tue Mar  1 15:34:15 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
--library Common_HDL;
--use Common_HDL.telops.all;
use work.tel2000.all;

entity suphawkA_spi_tx_check is
   port(
      SPI_CS_N         : in std_logic;
      SPI_SD           : in std_logic;
      SPI_SCLK         : in std_logic;
      SPI_DONE         : in std_logic;
      REGISTER_EN      : in std_logic_vector(2 downto 0);
      ARESET           : in std_logic;
      CLK              : in std_logic;
      DATA_CNT         : out std_logic_vector(10 downto 0);
      DATA_HIGH        : out std_logic;
      DCR_EN           : out std_logic;
      MCR_EN           : out std_logic;
      WCR_EN           : out std_logic;
      DDR_EN           : out std_logic;
      WDR_EN           : out std_logic
      );
end suphawkA_spi_tx_check;



architecture suphawkA_spi_tx_check of suphawkA_spi_tx_check is
   
   -- definition des adresses du mux
   constant NONE : std_logic_vector(2 downto 0) := "000";
   constant DCR  : std_logic_vector(2 downto 0) := "001";
   constant MCR  : std_logic_vector(2 downto 0) := "010";
   constant WCR  : std_logic_vector(2 downto 0) := "011";
   constant DDR  : std_logic_vector(2 downto 0) := "100";
   constant WDR  : std_logic_vector(2 downto 0) := "101";
   
   -- sync_reset
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   type fsm_type is (idle, cnt_st);
   signal fsm            : fsm_type;
   signal sreset         : std_logic;
   signal spi_sclk_last  : std_logic;
   signal data_cnt_i     : unsigned(DATA_CNT'length-1 downto 0);
   signal one_pos_dval   : std_logic;
   signal spi_sclk_rise  : std_logic; 
   
   -- à garder pour chipscope
   attribute keep        : string; 
   attribute keep of data_cnt_i   : signal is "true"; 
   attribute keep of one_pos_dval : signal is "true";
   attribute keep of DCR_EN : signal is "true";
   attribute keep of MCR_EN : signal is "true";
   attribute keep of WCR_EN : signal is "true";
   attribute keep of DDR_EN : signal is "true";
   attribute keep of WDR_EN : signal is "true"; 
   
begin
   
   DATA_CNT <=  std_logic_vector(data_cnt_i);
   DATA_HIGH   <= one_pos_dval;
   
   
   U2: sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset); 
   
   
   U3: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            spi_sclk_last <= '0';
            data_cnt_i <= (others =>'0');
            fsm <= idle; 
            one_pos_dval <= '0'; 
            spi_sclk_rise <= '0';
         else          
            
            spi_sclk_last <= SPI_SCLK;
            spi_sclk_rise <= SPI_SCLK and not spi_sclk_last;
            
            case fsm is
               
               when idle =>        
                  
                  DCR_EN <= BoolToStd(REGISTER_EN = DCR);
                  MCR_EN <= BoolToStd(REGISTER_EN = MCR);
                  WCR_EN <= BoolToStd(REGISTER_EN = WCR);
                  DDR_EN <= BoolToStd(REGISTER_EN = DDR);
                  WDR_EN <= BoolToStd(REGISTER_EN = WDR);
                  
                  if SPI_CS_N = '0' then 
                     data_cnt_i <= (others =>'0');
                     fsm <= cnt_st;                 
                  else
                     DCR_EN <= '0';
                  end if;
                  
               
               when cnt_st =>
                  if spi_sclk_rise = '1'then
                     data_cnt_i <= data_cnt_i + 1;
                     if SPI_SD = '1' then 
                        one_pos_dval <= '1';
                     else
                        one_pos_dval <= '0';
                     end if;                     
                  end if;   
                  
                  if SPI_CS_N = '1' then 
                     fsm <= idle; 
                  end if;
               
               when others =>
               
            end case;  
            
         end if; 
      end if;
   end process;
   
   
   
   
end suphawkA_spi_tx_check;
