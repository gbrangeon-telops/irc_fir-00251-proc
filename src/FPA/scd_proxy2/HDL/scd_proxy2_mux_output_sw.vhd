------------------------------------------------------------------
--!   @file : scd_proxy2_mux_output_sw
--!   @brief
--!   @details
--!
--!   $Rev: 27206 $
--!   $Author: pcouture $
--!   $Date: 2022-03-03 15:45:34 -0500 (jeu., 03 mars 2022) $
--!   $Id: scd_proxy2_line_mux.vhd 27206 2022-03-03 20:45:34Z pcouture $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2023-09-08-Binning-FPA/src/FPA/scd_proxy2/HDL/scd_proxy2_line_mux.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.Fpa_Common_Pkg.all; 
use work.proxy_define.all;
use work.fpa_define.all;
use work.tel2000.all;

entity scd_proxy2_mux_output_sw is
   port(
      ARESET         : in std_logic; 
      TX_CLK         : in std_logic;
      
      RX0_MOSI       : in t_ll_ext_mosi72;
      RX0_MISO       : out t_ll_ext_miso;
      
      RX1_MOSI       : in t_ll_ext_mosi72;
      RX1_MISO       : out t_ll_ext_miso;
      
      TX_MOSI      : out t_ll_ext_mosi72; 
      TX_MISO      : in t_ll_ext_miso;  
      
      SEL            : in std_logic
      
      );
end scd_proxy2_mux_output_sw;


architecture rtl of scd_proxy2_mux_output_sw is

component sync_reset
   port(
      ARESET : in std_logic;
      SRESET : out std_logic;
      CLK : in std_logic);
end component;
   
component double_sync is
   generic(
      INIT_VALUE : bit := '0'
      );
   port(
      D     : in std_logic;
      Q     : out std_logic := '0';
      RESET : in std_logic;
      CLK   : in std_logic
      );
end component;
   
signal sreset_i                    : std_logic;
signal sel_i                       : std_logic;
signal sel_o                       : std_logic;
signal frame_in_progress           : std_logic; 

begin
   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => TX_CLK,
      SRESET => sreset_i
   );
      
   U1: double_sync
   port map(
      CLK => TX_CLK,
      D   => SEL,
      Q   => sel_i,
      RESET => sreset_i
      );
  
   U2: process(TX_CLK)
   begin          
      if rising_edge(TX_CLK) then 
         if sreset_i = '1' then
            sel_o <= '0';
            frame_in_progress  <= '0';
         else
            
            if RX0_MOSI.SOF = '1' or RX1_MOSI.SOF = '1' then    
               frame_in_progress <= '1';
            elsif frame_in_progress = '1' and  (RX0_MOSI.EOF = '1' or RX1_MOSI.EOF = '1') then
               frame_in_progress <= '0';
            end if;

            if frame_in_progress = '0' then    
               sel_o <= sel_i;
            else
               sel_o <= sel_o;
            end if;
            
         end if;         
      end if;
   end process;  
   
  TX_MOSI.DATA <= RX0_MOSI.DATA when sel_o = '0' else  RX1_MOSI.DATA; 
  TX_MOSI.MISC <= RX0_MOSI.MISC when sel_o = '0' else  RX1_MOSI.MISC; 
  TX_MOSI.DVAL <= RX0_MOSI.DVAL when sel_o = '0' else  RX1_MOSI.DVAL;  
  TX_MOSI.EOL  <= RX0_MOSI.EOL  when sel_o = '0' else  RX1_MOSI.EOL;
  TX_MOSI.EOF  <= RX0_MOSI.EOF  when sel_o = '0' else  RX1_MOSI.EOF;
  TX_MOSI.SOL  <= RX0_MOSI.SOL  when sel_o = '0' else  RX1_MOSI.SOL;
  TX_MOSI.SOF  <= RX0_MOSI.SOF  when sel_o = '0' else  RX1_MOSI.SOF;     
  TX_MOSI.SUPPORT_BUSY <= RX0_MOSI.SUPPORT_BUSY when sel_o = '0' else  RX1_MOSI.SUPPORT_BUSY;
     
  RX0_MISO.BUSY <= TX_MISO.BUSY when sel_o = '0' else  '0';
  RX1_MISO.BUSY <= TX_MISO.BUSY when sel_o = '1' else  '0';   
  
  RX0_MISO.AFULL <= TX_MISO.AFULL when sel_o = '0' else  '0';
  RX1_MISO.AFULL <= TX_MISO.AFULL when sel_o = '1' else  '0';     
      
end rtl;
