------------------------------------------------------------------
--!   @file : calcium_prog_spi_driver
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.fpa_common_pkg.all;
use work.fpa_define.all;
use work.proxy_define.all;
use work.tel2000.all;

entity calcium_prog_spi_driver is
   port (
      ARESET      : in std_logic;
      CLK         : in std_logic;
      
      SCLK_IN     : in std_logic;
      
      -- interface TX
      TX_DVAL     : in std_logic;
      TX_DATA     : in std_logic_vector(15 downto 0);
      TX_TLAST    : in std_logic;
      TX_DONE     : out std_logic;  -- signale que le TX_DATA a été envoyé
      
      -- interface RX
      RX_DVAL     : out std_logic;
      RX_DATA     : out std_logic_vector(15 downto 0);
      
      -- interface avec le contrôleur SPI
      SCLK_OUT    : out std_logic;
      MOSI        : out std_logic;
      MISO        : in std_logic;
      CSN         : out std_logic
   );
end calcium_prog_spi_driver;

architecture rtl of calcium_prog_spi_driver is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
      );
   end component;  
   
   type spi_tx_fsm_type is (idle, latch_tx_data_st, launch_tx_st, send_tx_st, check_end_tx_st);
   type spi_rx_fsm_type is (idle, receive_rx_data_st, output_rx_data_st);
   
   signal spi_tx_fsm                : spi_tx_fsm_type;
   signal spi_rx_fsm                : spi_rx_fsm_type;
   signal sreset                    : std_logic;
   signal tx_data_latch             : std_logic_vector(TX_DATA'length-1 downto 0);
   signal tx_bit_cnt                : natural range 0 to TX_DATA'length-1;
   signal tx_tlast_latch            : std_logic;
   signal tx_done_i                 : std_logic;
   signal sclk_in_last              : std_logic;
   signal sclk_out_i                : std_logic;
   signal sclk_out_last             : std_logic;
   signal mosi_i                    : std_logic;
   signal csn_i                     : std_logic;
   signal rx_dval_i                 : std_logic;
   signal rx_data_i                 : std_logic_vector(RX_DATA'length-1 downto 0);
   signal rx_bit_cnt                : natural range 0 to RX_DATA'length-1;
   
begin  
   
   -- Output mapping
   TX_DONE <= tx_done_i;
   SCLK_OUT <= sclk_out_i;
   MOSI <= mosi_i;
   CSN <= csn_i;
   RX_DVAL <= rx_dval_i;
   RX_DATA <= rx_data_i;
   
   --------------------------------------------------
   -- Reset
   --------------------------------------------------
   U1 : sync_reset
   port map (
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
   );   
   
   ------------------------------------------------
   -- Gestion de la transmission vers le ROIC
   ------------------------------------------------
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            spi_tx_fsm <= idle;
            tx_done_i <= '0';
            sclk_out_i <= '0';
            mosi_i <= '1';
            csn_i <= '1';
            sclk_in_last <= '0';
         else 
            
            sclk_in_last <= SCLK_IN;
            
            case spi_tx_fsm is
               
               when idle =>
                  tx_done_i <= '1';    -- monte à 1 après chaque TX_DATA
                  if TX_DVAL = '1' then
                     spi_tx_fsm <= latch_tx_data_st;
                  end if;
               
               when latch_tx_data_st =>
                  tx_data_latch <= TX_DATA;
                  tx_tlast_latch <= TX_TLAST;
                  tx_done_i <= '0';          -- La donnée est latchée donc la génération de la prochaine données peut être enclenchée
                  spi_tx_fsm <= launch_tx_st;
                           
               when launch_tx_st =>
                  tx_bit_cnt <= TX_DATA'length-1;
                  if sclk_in_last = '1' and SCLK_IN = '0' then    -- On attend un premier front descendant pour donner un cycle entier sur SCLK_OUT
                     spi_tx_fsm <= send_tx_st;
                  end if;
               
               when send_tx_st =>
                  sclk_out_i <= SCLK_IN;
                  if sclk_in_last = '1' and SCLK_IN = '0' then    -- Synchro sur front descendant
                     mosi_i <= tx_data_latch(tx_bit_cnt);
                     if tx_bit_cnt = TX_DATA'length-1 then
                        csn_i <= '0';     -- Activation du chip select
                     elsif tx_bit_cnt = 0 then
                        spi_tx_fsm <= check_end_tx_st;
                     end if;
                     tx_bit_cnt <= tx_bit_cnt - 1;
                  end if;
               
               when check_end_tx_st =>
                  sclk_out_i <= SCLK_IN;
                  if sclk_in_last = '1' and SCLK_IN = '0' then    -- On attend un dernier front descendant
                     if tx_tlast_latch = '1' then
                        mosi_i <= '1';
                        csn_i <= '1';     -- Désactivation du chip select
                     end if;
                     spi_tx_fsm <= idle;
                  end if;
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;   
   
   ------------------------------------------------
   -- Gestion de la réception du ROIC
   ------------------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            spi_rx_fsm <= idle;
            rx_dval_i <= '0';
            sclk_out_last <= '0';
         else 
            
            sclk_out_last <= sclk_out_i;
            
            case spi_rx_fsm is
               
               when idle =>
                  rx_dval_i <= '0';
                  rx_bit_cnt <= RX_DATA'length-1;
                  spi_rx_fsm <= receive_rx_data_st;
               
               when receive_rx_data_st =>
                  if csn_i = '0' and sclk_out_last = '0' and sclk_out_i = '1' then    -- Synchro sur front montant
                     rx_data_i(rx_bit_cnt) <= MISO;
                     if rx_bit_cnt = 0 then
                        spi_rx_fsm <= output_rx_data_st;
                     end if;
                     rx_bit_cnt <= rx_bit_cnt - 1;
                  end if;
               
               when output_rx_data_st =>
                  rx_dval_i <= '1';       -- pour 1 CLK seulement
                  spi_rx_fsm <= idle;
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
   
   
end rtl;
