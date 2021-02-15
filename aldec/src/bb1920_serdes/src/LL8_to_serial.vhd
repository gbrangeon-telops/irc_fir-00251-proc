---------------------------------------------------------------------------------------------------
--  Copyright (c) Telops Inc. 2007
--
--  File: LL8_to_serial.vhd
--  Use: general purpose spi master interface (DACs etc...)
--  Author: ENO
--
--  $Revision$
--  $Author$
--  $LastChangedDate$
---------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE. numeric_std.all;
use work.fpa_common_pkg.all;

entity LL8_to_serial is
   generic( 
      OUTPUT_MSB_FIRST : boolean := false;     -- si à true, alors RX_MOSI.DATA(7) est le premier bit à sortir sur le lien SPI. Cela signifie une sortie des bits 7 downto 0
      -- si à false alors RX_MOSI.DATA(0) est le premier bit à sortir sur le lien SPI. Cela signifie une sortie des bits 0 to 7
      DATA_TO_CS_DLY : natural range 1 to 31 := 1;  -- delai en coups de SCLK entre le debut du dernier SD et la remontee de CS_N. SCLK0 fait la periode du dernier SD et reste à '0' pour le reste du delai. Mettre à 1 pour aucun delai a la fin du dernier SD
      CS_TO_DATA_DLY : natural range 1 to 31 := 1;  -- delai en coups de SCLK entre la tombée de CS_N et la premiere donnée de SD. SCLK0 est à '0' durant ce delai
      SCLK0_FREE_RUNNING : boolean := false         -- à true si l'horloge SCLK0 roule tout le temps
      );
   
   port(
      -- general
      ARESET   : in std_logic;
      CLK      : in std_logic; 
      
      -- flow d'entrée
      RX_MOSI  : in t_ll_ext_mosi8;
      RX_MISO  : out t_ll_ext_miso;
      RX_DREM  : in std_logic_vector(3 downto 0); -- DREM = 8, 7, 6, ....1, pour signifier le nnombre de Bit valides dans le EOF 
      
      -- clock SPI fournie
      SCLKI    : in std_logic;      
      
      -- lien sortant spi master
      SCLK0    : out std_logic;      -- vaut SCLKI decalé de 1CLK
      SD       : out std_logic;
      CS_N     : out std_logic;
      FRM_DONE : out std_logic;      -- indique la fin de l'envoi d'une trame commeneçant par SOF et se terminant par EOF
      
      --err
      ERR      : out std_logic 
      );
end LL8_to_serial;

architecture rtl of LL8_to_serial is
   
   component double_sync
      generic(
         INIT_VALUE : bit := '0'
         );
      port(
         D : in std_logic;
         Q : out std_logic := '0';
         RESET : in std_logic;
         CLK : in std_logic
         );
   end component;
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   component fwft_sfifo_w3_d16
      port (
         clk : in std_logic;
         srst : in std_logic;
         din : in std_logic_vector(2 DOWNTO 0);
         wr_en : in std_logic;
         rd_en : in std_logic;
         dout : out std_logic_vector(2 DOWNTO 0);
         full : out std_logic;
         almost_full : out std_logic;
         overflow : out std_logic;
         empty : out std_logic;
         valid : out std_logic
         );
   end component;
   
   component fwft_afifo_w8_d256
      port (
         rst     : in std_logic;
         wr_clk  : in std_logic;
         rd_clk  : in std_logic;
         din     : in std_logic_vector(7 downto 0);
         wr_en   : in std_logic;
         rd_en   : in std_logic;
         dout    : out std_logic_vector(7 downto 0);
         full    : out std_logic;
         almost_full : out std_logic;
         overflow : out std_logic;
         empty   : out std_logic;
         valid   : out std_logic;
         wr_rst_busy : out std_logic;   
         rd_rst_busy : out std_logic
         );
   end component;
   
   type spi_fsm_type  is (init_st, wait_data_st, check_sof_st, check_eof_st, active_cs_st, inactive_cs_st, output_data_st, cs_to_data_dly_st, data_to_cs_dly_st);
   type fifo_fsm_type is (idle, wait_data_st, wait_param_st, build_data_st, build_data_st2, wr_data_st, check_wr_end_st);
   
   signal fifo_fsm                  : fifo_fsm_type;
   signal spi_fsm                   : spi_fsm_type;
   signal sd_o                      : std_logic;
   signal cs_n_o                    : std_logic;
   signal sclk_o                    : std_logic;
   signal frm_done_i                : std_logic;
   signal sreset                    : std_logic; 
   signal bit_cnt                   : unsigned(3 downto 0);
   signal busy_i                    : std_logic;
   --signal rx_mosi_i                 : t_ll_ext_mosi8;
   signal rx_mosi_latch             : t_ll_ext_mosi8;
   signal fifo_din                  : std_logic_vector(2 downto 0);
   signal fifo_dout                 : std_logic_vector(2 downto 0);
   signal rxfifo_rd                 : std_logic;
   signal rxfifo_dout               : std_logic_vector(7 downto 0);
   signal rxfifo_dval                 : std_logic;
   signal fifo_afull                : std_logic; 
   signal bitcnt                    : integer := 0;
   signal sclk_last                 : std_logic;
   signal sof_o, eof_o, dout_o      : std_logic;
   signal dly_cnt                   : natural range 0 to 31;
   --signal sclko_reg                 : std_logic;
   --signal byte_window_reg           : std_logic;
   --signal cs_n_reg                  : std_logic;
   
begin
   
   ------------------------------------------------------
   --Outputs map                        
   ------------------------------------------------------   
   RX_MISO.AFULL <= '0';
   RX_MISO.BUSY <= '0'; 
   SCLK0 <= SCLKI;
   SD <= sd_o;
   
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U0 : sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset); 
   
   
   
   Ua : fwft_afifo_w8_d256
   port map (
   rst      => ARESET,
   wr_clk   => CLK,
   rd_clk   => SCLKI,
   din      => RX_MOSI.DATA,
   wr_en    => RX_MOSI.DVAL,
   rd_en    => rxfifo_rd,
   dout     => rxfifo_dout,
   full     => open,
   almost_full => open,
   overflow => open,
   empty    => open,
   valid    => rxfifo_dval,
   wr_rst_busy => open,  
   rd_rst_busy => open
   );
   
   ------------------------------------------------------
   -- Écriture dans le fifo 
   ------------------------------------------------------
   U3: process(SCLKI)
   begin       
      if rising_edge(SCLKI) then                 
         
         if rxfifo_dval = '1' then
            bitcnt <= (bitcnt+1) mod 8;
         end if;
         sd_o <= rxfifo_dout(bitcnt);
         
         rxfifo_rd <= '0';
         if bitcnt = 7 then
            rxfifo_rd <=  '1';
         end if;
         
      end if;
   end process;   
   
   
   
end rtl;
