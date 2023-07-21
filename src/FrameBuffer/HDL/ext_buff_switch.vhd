-------------------------------------------------------------------------------
--
-- Title       : ext_buff_switch
-- Design      : switch_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\switch_tb\src\ext_buff_switch.vhd
-- Generated   : Fri Feb 10 10:11:13 2023
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
--{entity {ext_buff_switch} architecture {ext_buff_sw}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;
use work.BufferingDefine.all;

entity ext_buff_switch is 
   generic (
   registered : boolean := false;	
   sync_eof : boolean := false -- set to true to synchronize a change on SEL between two images (* might lose one frame during synchronization if a sof immediately follows an eof). Requires registered = true
      );
    Port (	
	
      ARESETN   : in  std_logic;
      DCLK      : in  std_logic;
      
      RX_MOSI   : in  t_axi4_stream_mosi128;
      RX_MISO   : out t_axi4_stream_miso;
      
      FROM_STORAGE_MOSI  : in  t_axi4_stream_mosi128;
      FROM_STORAGE_MISO  : out t_axi4_stream_miso;
      
      TX_MOSI     : out t_axi4_stream_mosi128;
      TX_MISO     : in  t_axi4_stream_miso;
      
      TO_STORAGE_MOSI : out t_axi4_stream_mosi128;
      TO_STORAGE_MISO : in  t_axi4_stream_miso;
      
      BM_SW   	   : in external_buffer_switch_type;
      FALL     	: out std_logic;
      
      ERROR       : out std_logic_vector(1 downto 0) 		
    
    );	
	
end ext_buff_switch;


architecture ext_buff_sw of ext_buff_switch is

    signal buff_sw_cfg_s         : std_logic_vector(1 downto 0):=(others => '0');  
    signal sresetn               : std_logic; 
    signal sreset                : std_logic;
    signal rx_miso_i             : t_axi4_stream_miso; 
    signal tx_mosi_out_i         : t_axi4_stream_mosi128;
    signal tx_miso_out_i         : t_axi4_stream_miso;
    signal to_storage_mosi_out_i : t_axi4_stream_mosi128;
    signal to_storage_miso_out_i : t_axi4_stream_miso;

    signal ext_sw_cfg_sync       : std_logic_vector(1 downto 0);
    signal bm_sw_dval_last       : std_logic :='0'; 
    signal bm_sw_dval_sync       : std_logic :='0';
    signal bm_sel_i              : std_logic_vector(1 downto 0);

    signal eof_i                 : std_logic;
    signal sof_i                 : std_logic;
    signal fall_i                : std_logic;
   
   --------------------------------------------------------------
   --	components
   -------------------------------------------------------------
   
   component sync_resetn
      port(
         ARESETN : in std_logic;
         SRESETN : out std_logic;
         CLK    : in std_logic);
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
   
   component axis128_reg is
      port(
         RX_MOSI  : in  t_axi4_stream_mosi128;
         RX_MISO  : out t_axi4_stream_miso;
         TX_MOSI  : out  t_axi4_stream_mosi128;
         TX_MISO  : in t_axi4_stream_miso;
         
         ARESETN  : in  std_logic;
         CLK      : in  std_logic     
         );
   end component;
 
   component axis128_img_boundaries is
      port(
         RX_MOSI  : in  t_axi4_stream_mosi128;
         RX_MISO  : in t_axi4_stream_miso;
         SOF      : out std_logic; -- pulse at the beginning of a frame
         EOF      : out std_logic; -- indicates if a frame is done (held at the end of the image)
         ARESETN  : in  std_logic;
         CLK      : in  std_logic     
         );
   end component;

begin 
	
   bm_sel_i <= BM_SW.sel(3 downto 2);
   FALL     <=  fall_i; 
   ERROR <= "00";
   rx_miso_i.tready          <= tx_miso_out_i.tready    	                                      when buff_sw_cfg_s = "00" else 
                                to_storage_miso_out_i.tready  and tx_miso_out_i.tready            when buff_sw_cfg_s = "01" else 
                                '0';
 
   FROM_STORAGE_MISO.tready   <= tx_miso_out_i.tready                                             when buff_sw_cfg_s = "10" else 
                                 '0';
                                
   tx_mosi_out_i.TVALID       <= RX_MOSI.TVALID                                                    when buff_sw_cfg_s = "00" else 
                                 RX_MOSI.TVALID and rx_miso_i.tready                             when buff_sw_cfg_s = "01" else
                                 FROM_STORAGE_MOSI.TVALID                                        when buff_sw_cfg_s = "10" else 
                                 '0';
 
   to_storage_mosi_out_i.TVALID  <= RX_MOSI.TVALID and rx_miso_i.tready                       when buff_sw_cfg_s = "01" else '0';	
                                     
   tx_mosi_out_i.TDATA           <= FROM_STORAGE_MOSI.TDATA                                   when buff_sw_cfg_s = "10" else RX_MOSI.TDATA;    				         
   tx_mosi_out_i.TLAST           <= FROM_STORAGE_MOSI.TLAST                                   when buff_sw_cfg_s = "10" else RX_MOSI.TLAST;
   tx_mosi_out_i.TID             <= FROM_STORAGE_MOSI.TID                                     when buff_sw_cfg_s = "10" else RX_MOSI.TID;

   to_storage_mosi_out_i.TDATA   <= RX_MOSI.TDATA;
   to_storage_mosi_out_i.TLAST   <= RX_MOSI.TLAST; 
   to_storage_mosi_out_i.TID     <= RX_MOSI.TID; 

   RX_MISO.tready              <= rx_miso_i.tready;
   to_storage_mosi_out_i.tuser <= (others => '0');
   to_storage_mosi_out_i.tstrb <= (others => '1');
   to_storage_mosi_out_i.tkeep <= (others => '1');
   to_storage_mosi_out_i.tdest <= (others => '0');
   tx_mosi_out_i.tuser         <= (others => '0');
   tx_mosi_out_i.tstrb         <= (others => '1');
   tx_mosi_out_i.tkeep         <= (others => '1');
   tx_mosi_out_i.tdest         <= (others => '0');

   U1 : process(DCLK)
     begin
       if rising_edge(DCLK) then
          if (sresetn = '0') then            
              ext_sw_cfg_sync <= (others => '0');
              bm_sw_dval_last <= '0';
          else	
   
              bm_sw_dval_last <= bm_sw_dval_sync;
              if (bm_sw_dval_sync = '1' and bm_sw_dval_last  = '0') then
                 ext_sw_cfg_sync <= bm_sel_i; 
              end if;
   
              if eof_i = '1' then
                 buff_sw_cfg_s <= ext_sw_cfg_sync; 
                 fall_i        <= not ext_sw_cfg_sync(0);
              end if;
              
          end if;
       end if;
     end process; 	  
   

   U2: sync_resetn
   port map(
      ARESETN => ARESETN,
      CLK    => DCLK,
      SRESETN => sresetn
      );
   sreset <= not sresetn;  
 
   U3: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => BM_SW.dval, Q => bm_sw_dval_sync, RESET => sreset, CLK => DCLK ); 

  reg_gen_t: if registered = true generate
      U5: axis128_reg
      port map(
         RX_MOSI => tx_mosi_out_i,
         RX_MISO => tx_miso_out_i,
         TX_MOSI => TX_MOSI,
         TX_MISO => TX_MISO,
         ARESETN => ARESETN,
         CLK     => DCLK
         );
      
      U6: axis128_reg
      port map(
         RX_MOSI => to_storage_mosi_out_i,
         RX_MISO => to_storage_miso_out_i,
         TX_MOSI => TO_STORAGE_MOSI,
         TX_MISO => TO_STORAGE_MISO,
         ARESETN => ARESETN,
         CLK     => DCLK
         );

   end generate; 

   reg_gen_f : if registered = false generate 
        TX_MOSI               <= tx_mosi_out_i;
        tx_miso_out_i         <= TX_MISO ;
        TO_STORAGE_MOSI       <= to_storage_mosi_out_i;
        to_storage_miso_out_i <= TO_STORAGE_MISO;	 
  end generate;	   
 
   detect_eof : if sync_eof = true generate
      U7 : axis128_img_boundaries
      port map (
         RX_MOSI => RX_MOSI, 
         RX_MISO => rx_miso_i,
         SOF => sof_i,
         EOF => eof_i,
         ARESETN => ARESETN,
         CLK => DCLK
         );
  end generate;	 
  
   detect_eof_f : if sync_eof = false generate
      eof_i <= '1';
   end generate;
  
end ext_buff_sw;

