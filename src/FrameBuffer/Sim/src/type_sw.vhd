-------------------------------------------------------------------------------
--
-- Title       : type_sw
-- Design      : switch_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\switch_tb\src\type_sw.vhd
-- Generated   : Thu Feb  9 10:32:53 2023
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {type_sw} architecture {type_sw}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.tel2000.all;

entity type_sw is
	 port(
        IN_RX_MOSI  : in  t_axi4_stream_mosi128;
        IN_RX_MISO  : out t_axi4_stream_miso;

        TX0_MOSI : out t_axi4_stream_mosi128;
        TX0_MISO : in  t_axi4_stream_miso;

        TX1_MOSI : out t_axi4_stream_mosi128;
        TX1_MISO : in  t_axi4_stream_miso;
		
		SW_PARAM : in  std_logic;
        ARESETN  : in  std_logic;
        CLK      : in  std_logic  
	     );
end type_sw;

--}} End of automatically maintained section

architecture type_sw of type_sw is 

   signal sw_param_cng  : std_logic;  
   signal sresetn       : std_logic;  

   
   component sync_resetn
      port(
         ARESETN : in std_logic;
         SRESETN : out std_logic;
         CLK    : in std_logic);
   end component;  
   
   
begin    
   sw_param_cng <= SW_PARAM;   

   
   TX0_MOSI.TVALID <= IN_RX_MOSI.TVALID when sw_param_cng = '0' else '0';
   TX0_MOSI.TLAST <= IN_RX_MOSI.TLAST; 
   TX0_MOSI.TDATA <= IN_RX_MOSI.TDATA;   
   TX0_MOSI.TID   <= IN_RX_MOSI.TID; 
   TX0_MOSI.TKEEP <= IN_RX_MOSI.TKEEP;
   TX0_MOSI.TSTRB <= IN_RX_MOSI.TSTRB;
   TX0_MOSI.TDEST <= IN_RX_MOSI.TDEST;
   TX0_MOSI.TUSER <= IN_RX_MOSI.TUSER;

   TX1_MOSI.TVALID <= IN_RX_MOSI.TVALID when sw_param_cng = '1' else '0';
   TX1_MOSI.TLAST <= IN_RX_MOSI.TLAST; 
   TX1_MOSI.TDATA <= IN_RX_MOSI.TDATA;   
   TX1_MOSI.TID   <= IN_RX_MOSI.TID;
   TX1_MOSI.TKEEP <= IN_RX_MOSI.TKEEP;
   TX1_MOSI.TSTRB <= IN_RX_MOSI.TSTRB;
   TX1_MOSI.TDEST <= IN_RX_MOSI.TDEST;
   TX1_MOSI.TUSER <= IN_RX_MOSI.TUSER;
   
   
   IN_RX_MISO <= TX0_MISO when sw_param_cng = '0' else TX1_MISO;
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1: sync_resetn
   port map(
      ARESETN => ARESETN,
      CLK    => CLK,
      SRESETN => sresetn
      );
	  
end type_sw;
