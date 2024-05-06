-------------------------------------------------------------------------------
--
-- Title       : SCPIO_data_dispatcher
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\SCPIO_Hercules\src\SCPIO_data_dispatcher.vhd
-- Generated   : Mon Jan 10 13:16:11 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.Fpa_Common_Pkg.all;
use work.FPA_Define.all;
use work.proxy_define.all;
use work.tel2000.all;


entity scd_proxy2_dummy_dispatcher is
   
   port(
      
      ARESET            : in std_logic;
      CLK               : in std_logic;

      QUAD_FIFO_RST     : in std_logic;
      QUAD_FIFO_CLK     : in std_logic;
      QUAD_FIFO_DIN     : in std_logic_vector(95 downto 0);      
      QUAD_FIFO_WR      : in std_logic;
      
      DATA_MOSI         : out t_ll_area_mosi72;
      DATA_MISO         : in t_ll_area_miso    
      );
end scd_proxy2_dummy_dispatcher;

architecture rtl of scd_proxy2_dummy_dispatcher is 
      
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component fwft_afifo_w96_d128
      port (
         rst      : in std_logic;
         wr_clk   : in std_logic;
         rd_clk   : in std_logic;
         din      : in std_logic_vector(95 downto 0);
         wr_en    : in std_logic;
         rd_en    : in std_logic;
         dout     : out std_logic_vector(95 downto 0);
         valid    : out std_logic;
         full     : out std_logic;
         overflow : out std_logic;
         empty    : out std_logic;
         wr_rst_busy : out std_logic;   
         rd_rst_busy : out std_logic
         );
   end component;
   

   signal sreset                       : std_logic;
   signal quad_fifo_dval               : std_logic;
   signal data                         : std_logic_vector(55 downto 0); 
   signal aoi_fval                     : std_logic;
   signal aoi_lval                     : std_logic;
   signal aoi_sol                      : std_logic;
   signal aoi_eol                      : std_logic;
   signal aoi_sof                      : std_logic;
   signal aoi_eof                      : std_logic;
   signal aoi_spare                    : std_logic_vector(14 downto 0);
   signal aoi_dval                     : std_logic;    
   signal quad_fifo_dout               : std_logic_vector(QUAD_FIFO_DIN'LENGTH-1 downto 0);  
   signal quad_fifo_ovfl               : std_logic;
   signal data_mosi_i                  : t_ll_area_mosi72;
   signal naoi_dval                    : std_logic := '0';
   signal naoi_spare                   : std_logic_vector(12 downto 0);
   signal naoi_start                   : std_logic;
   signal naoi_stop                    : std_logic;
   signal naoi_ref_valid               : std_logic_vector(1 downto 0);
   signal aoi_acq_data                 : std_logic;
   signal pix_debug_dispatcher               : std_logic_vector(63 downto 0);
begin
  
-- pragma translate_off
   pix_debug_dispatcher             <= "00" & data(55 downto 42) & "00" & data(41 downto 28) & "00" & data(27 downto 14) & "00" & data(13 downto 0); 
-- pragma translate_on

   DATA_MOSI <= data_mosi_i;

   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   
   --------------------------------------------------
   -- fifo fwft quad_DATA 
   -------------------------------------------------- 
   U1 : fwft_afifo_w96_d128
   port map (
      rst => QUAD_FIFO_RST,
      wr_clk => QUAD_FIFO_CLK,
      rd_clk => CLK,
      din => QUAD_FIFO_DIN,
      wr_en => QUAD_FIFO_WR,
      rd_en => quad_fifo_dval,   -- les données sortent dès leur arrivée. Elle se retrouvent sur le bus PIX_MOSI. PIX_MOSI.DVAL permet de savoir que la donnée est valide pour AOI ou non. PIX_MOSI.MISC permet d'identifier les données (pour correction offset par exemple)     
      dout => quad_fifo_dout,
      valid  => quad_fifo_dval,
      full => open,
      overflow => quad_fifo_ovfl,
      empty => open,
      wr_rst_busy => open,  
      rd_rst_busy => open
      );
   
   ------------------------------------------------
   -- decodage données sortant du fifo
   ------------------------------------------------
   -- data  (AOI ou non AOI data)
   data           <= quad_fifo_dout(55 downto 0);
   
   -- AOI area flags
   aoi_sol        <= quad_fifo_dout(56);  
   aoi_eol        <= quad_fifo_dout(57);
   aoi_fval       <= quad_fifo_dout(58);
   aoi_sof        <= quad_fifo_dout(59);  
   aoi_eof        <= quad_fifo_dout(60);
   aoi_dval       <= quad_fifo_dout(61) and quad_fifo_dval; 
   aoi_spare      <= quad_fifo_dout(76 downto 62);   
   aoi_acq_data   <= quad_fifo_dout(62); -- spare(0) consacré à aoi_acq_data           
   
   -- non AOI area flags         
   naoi_dval      <= quad_fifo_dout(77) and quad_fifo_dval;
   naoi_start     <= quad_fifo_dout(78);
   naoi_stop      <= quad_fifo_dout(79);
   naoi_ref_valid <= quad_fifo_dout(81 downto 80);
   naoi_spare     <= quad_fifo_dout(94 downto 82);
  
   
   -----------------------------------------------------------------
   -- Sortie des pixels
   -------------------------------------------------------------------   
   U5: process(CLK)
   begin          
      if rising_edge(CLK) then 
         --données
         data_mosi_i.data             <= resize(data(55 downto 42),18) & resize(data(41 downto 28),18) & resize(data(27 downto 14),18) & resize(data(13 downto 0),18);            
         -- flags de données des pixels
         data_mosi_i.aoi_dval         <= aoi_dval and aoi_acq_data and not sreset; -- ENO. 22 fev 2020: les données sortent automatiquement dès qu'elles ont le tag aoi_acq_data à '1'.
         data_mosi_i.aoi_sof          <= aoi_sof;
         data_mosi_i.aoi_eof          <= aoi_eof;
         data_mosi_i.aoi_sol          <= aoi_sol;
         data_mosi_i.aoi_eol          <= aoi_eol;
         data_mosi_i.aoi_spare        <= aoi_spare;
         -- flags de données non pixels
         data_mosi_i.naoi_dval        <= naoi_dval;
         data_mosi_i.naoi_start       <= naoi_start;
         data_mosi_i.naoi_stop        <= naoi_stop;
         data_mosi_i.naoi_spare       <= naoi_spare;
         data_mosi_i.naoi_ref_valid   <= naoi_ref_valid;
      end if;
   end process; 
   
end rtl;
