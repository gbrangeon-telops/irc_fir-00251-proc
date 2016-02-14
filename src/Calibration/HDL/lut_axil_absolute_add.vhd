------------------------------------------------------------------
--!   @file : lut_axil_absolute_add
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
use work.tel2000.all;

entity lut_axil_absolute_add is
   generic
      (
      PAGE_ADD_WIDTH : integer := 6
      );
   
   port(
      
      RX_AXIL_MOSI : in   t_axi4_lite_mosi;
      RX_AXIL_MISO : out  t_axi4_lite_miso;
      
      PAGE_ID      : in std_logic_vector(7 downto 0);
      
      TX_AXIL_MOSI : out   t_axi4_lite_mosi;
      TX_AXIL_MISO : in  t_axi4_lite_miso     
      );   
end lut_axil_absolute_add;                           

architecture rtl of lut_axil_absolute_add is

signal lut_relative_wadd : std_logic_vector(PAGE_ADD_WIDTH-3 downto 0);  -- adresse relative d'ecriture dans une page de LUT.
signal lut_relative_radd : std_logic_vector(PAGE_ADD_WIDTH-3 downto 0);  -- adresse relative de lecture dans une page de LUT. 
   
begin
   
   lut_relative_wadd <= resize(RX_AXIL_MOSI.AWADDR(PAGE_ADD_WIDTH-1 downto 2),PAGE_ADD_WIDTH-2); -- l'adresse relative d'écriture dans une page de lUT = (adresse du µB)/4
   lut_relative_radd <= resize(RX_AXIL_MOSI.ARADDR(PAGE_ADD_WIDTH-1 downto 2),PAGE_ADD_WIDTH-2);  -- l'adresse relative de lecture dans une page de lUT = (adresse du µB)/4
   
   TX_AXIL_MOSI.AWVALID  <=  RX_AXIL_MOSI.AWVALID; 
   TX_AXIL_MOSI.AWADDR   <=  resize((PAGE_ID(7 downto 0) & lut_relative_wadd), 32);          -- adresse absolue = adresse relative d'aune page concaténée au numero de page
   TX_AXIL_MOSI.AWPROT   <=  RX_AXIL_MOSI.AWPROT;  
   TX_AXIL_MOSI.WVALID   <=  RX_AXIL_MOSI.WVALID;  
   TX_AXIL_MOSI.WDATA    <=  RX_AXIL_MOSI.WDATA;
   TX_AXIL_MOSI.BREADY   <=  RX_AXIL_MOSI.BREADY;  
   TX_AXIL_MOSI.ARVALID  <=  RX_AXIL_MOSI.ARVALID;                                           
   TX_AXIL_MOSI.ARADDR   <=  resize((PAGE_ID(7 downto 0) & lut_relative_radd), 32);          -- adresse absolue = adresse relative d'aune page concaténée au numero de page 
   TX_AXIL_MOSI.ARPROT   <=  RX_AXIL_MOSI.ARPROT;  
   TX_AXIL_MOSI.RREADY   <=  RX_AXIL_MOSI.RREADY;  
   TX_AXIL_MOSI.WSTRB    <=  RX_AXIL_MOSI.WSTRB;
   
   RX_AXIL_MISO <= TX_AXIL_MISO;
   
end rtl;
