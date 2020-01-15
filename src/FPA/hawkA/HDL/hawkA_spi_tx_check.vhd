-------------------------------------------------------------------------------
--
-- Title       : hawkA_spi_tx_check
-- Design      : hawk_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\Hawk\src\hawkA_spi_tx_check.vhd
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
use work.fpa_common_pkg.all;
use work.tel2000.all;

entity hawkA_spi_tx_check is
   port(
      
      ARESET           : in std_logic;
      CLK              : in std_logic;
      
      REGISTER_EN      : in std_logic_vector(2 downto 0);
      
      -- spi
      SPI_CS_N         : in std_logic;
      SPI_SD           : in std_logic;
      SPI_SCLK         : in std_logic;
      SPI_DONE         : in std_logic;
      
      SPI_DCNT         : out std_logic_vector(10 downto 0);
      SPI_DHIGH        : out std_logic;
      
      --LL
      TX_MOSI          : in t_ll_ext_mosi8;
      TX_MISO          : in t_ll_ext_miso;
      TX_DCNT          : out std_logic_vector(10 downto 0);
      
      DCR_EN           : out std_logic;
      MCR_EN           : out std_logic;
      WCR_EN           : out std_logic;
      DDR_EN           : out std_logic;
      WDR_EN           : out std_logic
      );
end hawkA_spi_tx_check;



architecture hawkA_spi_tx_check of hawkA_spi_tx_check is
   
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
   signal in_fsm, out_fsm : fsm_type;
   signal sreset         : std_logic;
   signal spi_sclk_last  : std_logic;
   signal spi_dcnt_i     : unsigned(SPI_DCNT'length-1 downto 0);
   signal tx_dcnt_i      : unsigned(TX_DCNT'length-1 downto 0);
   signal one_pos_dval   : std_logic;
   signal spi_sclk_rise  : std_logic; 
   
--   -- à garder pour chipscope
--   attribute keep        : string; 
--   attribute keep of spi_dcnt_i   : signal is "true"; 
--   attribute keep of one_pos_dval : signal is "true";
--   attribute keep of DCR_EN : signal is "true";
--   attribute keep of MCR_EN : signal is "true";
--   attribute keep of WCR_EN : signal is "true";
--   attribute keep of DDR_EN : signal is "true";
--   attribute keep of WDR_EN : signal is "true"; 
   
begin
   
   SPI_DCNT    <=  std_logic_vector(spi_dcnt_i);
   SPI_DHIGH   <= one_pos_dval;
   
   TX_DCNT <= std_logic_vector(tx_dcnt_i);
   
   
   U2: sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset); 
   
   
   -------------------------------------------
   -- compteur de données entrantes
   ------------------------------------------- 
   U3: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then            
            in_fsm <= idle;              
         else                            
            
            case in_fsm is
               
               when idle =>                  
                  if TX_MOSI.DVAL = '1' and TX_MOSI.SOF = '1' and TX_MISO.BUSY = '0'  then 
                     tx_dcnt_i <= to_unsigned(1, tx_dcnt_i'length);
                     in_fsm <= cnt_st;                 
                  end if;
                  
               
               when cnt_st =>
                  if TX_MOSI.DVAL = '1' and TX_MISO.BUSY = '0' then 
                     tx_dcnt_i <= tx_dcnt_i + 1;                  
                     if TX_MOSI.EOF = '1' then 
                        in_fsm <= idle; 
                     end if; 
                  end if;
               
               when others =>
               
            end case;  
            
         end if; 
      end if;
   end process;                               
   
   
   -------------------------------------------
   -- compteur de données sortantes
   -------------------------------------------   
   U4: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            spi_sclk_last <= '0';
            spi_dcnt_i <= (others =>'0');
            out_fsm <= idle; 
            one_pos_dval <= '0'; 
            spi_sclk_rise <= '0';
         else          
            
            spi_sclk_last <= SPI_SCLK;
            spi_sclk_rise <= SPI_SCLK and not spi_sclk_last;
            
            case out_fsm is
               
               when idle =>        
                  
                  DCR_EN <= BoolToStd(REGISTER_EN = DCR);
                  MCR_EN <= BoolToStd(REGISTER_EN = MCR);
                  WCR_EN <= BoolToStd(REGISTER_EN = WCR);
                  DDR_EN <= BoolToStd(REGISTER_EN = DDR);
                  WDR_EN <= BoolToStd(REGISTER_EN = WDR);
                  
                  if SPI_CS_N = '0' then 
                     spi_dcnt_i <= (others =>'0');
                     out_fsm <= cnt_st;                 
                  else
                     DCR_EN <= '0';
                  end if;
                  
               
               when cnt_st =>
                  if spi_sclk_rise = '1'then
                     spi_dcnt_i <= spi_dcnt_i + 1;
                     if SPI_SD = '1' then 
                        one_pos_dval <= '1';
                     else
                        one_pos_dval <= '0';
                     end if;                     
                  end if;   
                  
                  if SPI_CS_N = '1' then 
                     out_fsm <= idle; 
                  end if;
               
               when others =>
               
            end case;  
            
         end if; 
      end if;
   end process;
   
   
   
   
end hawkA_spi_tx_check;
