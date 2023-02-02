-------------------------------------------------------------------------------
--
-- Title       :  Flow controller
-- Design      : 
-- Author      :  Philippe Couture
-- Company     :  Telops
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00251-Proc\src\FrameBuffer\Sim\src\adaptblock.vhd
-- Generated   : Thu Jun 23 13:51:13 2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all; 
use work.BufferingDefine.all;

entity flow_controller is	  
		 port(                                
      
      ARESETN        : in STD_LOGIC;           
      CLK_DIN        : in std_logic;  	
       
      AXIS_MOSI_RX   : in t_axi4_stream_mosi64;     
      AXIS_MISO_RX   : out t_axi4_stream_miso;	   
	        
      AXIS_MOSI_TX   : out t_axi4_stream_mosi64;     
      AXIS_MISO_TX   : in t_axi4_stream_miso;
	  
      FLOW_CTRLER_CFG : in flow_ctrler_config_type
      );
end flow_controller;

--}} End of automatically maintained section

	
architecture behav of flow_controller is

component sync_resetn is
   port(
      ARESETN : in STD_LOGIC;
      SRESETN : out STD_LOGIC := '0';
      CLK    : in STD_LOGIC
      );
end component;

component double_sync
   generic(
      INIT_VALUE : bit := '0'
   );
	port(
		D : in STD_LOGIC;
		Q : out STD_LOGIC := '0';
		RESET : in STD_LOGIC;
		CLK : in STD_LOGIC
		);
end component;
  
type   flow_control_state is (idle_st, pause_st);
signal flow_control_s : flow_control_state;  
signal sresetn_i      : std_logic;  
signal sreset         : std_logic;
signal stall_i        : std_logic;	
signal rx_tready      : std_logic := '0';
signal flow_ctrler_cfg_i : flow_ctrler_config_type;
signal valid_cnt      : unsigned(flow_ctrler_cfg_i.valid_cnt'range) ;
signal lval_cnt       : unsigned(flow_ctrler_cfg_i.width'range) ;
signal width          : unsigned(flow_ctrler_cfg_i.width'range) ;
signal pause_cnt      : unsigned(flow_ctrler_cfg_i.lval_pause_min'range) ;
signal pause_cnt_min  : unsigned(flow_ctrler_cfg_i.lval_pause_min'range) ;
	
signal valid_cfg_last    : std_logic := '0';

attribute KEEP : string;
attribute KEEP of valid_cnt      : signal is "true";
attribute KEEP of flow_control_s : signal is "true";
attribute KEEP of rx_tready      : signal is "true";
attribute KEEP of flow_ctrler_cfg_i  : signal is "true";
attribute KEEP of lval_cnt       : signal is "true";
attribute KEEP of pause_cnt      : signal is "true";
attribute KEEP of pause_cnt_min  : signal is "true";

begin
	
   U1 :  sync_resetn
   port map(ARESETN => ARESETN, SRESETN => sresetn_i, CLK => CLK_DIN);
   
   sreset <= not sresetn_i;
   
   U1B : double_sync port map(D => FLOW_CTRLER_CFG.dval, Q => flow_ctrler_cfg_i.dval, RESET => sreset, CLK => CLK_DIN);
 

   
   U2 : process(CLK_DIN)
   begin
      if rising_edge(CLK_DIN) then
         if sresetn_i = '0' then
            flow_ctrler_cfg_i.stalled_cnt                   <= to_unsigned(3,flow_ctrler_cfg_i.stalled_cnt'length);
            flow_ctrler_cfg_i.valid_cnt                     <= to_unsigned(1,flow_ctrler_cfg_i.valid_cnt'length);
            flow_ctrler_cfg_i.width                         <= to_unsigned(0,flow_ctrler_cfg_i.width'length);
            flow_ctrler_cfg_i.lval_pause_min                <= to_unsigned(0,flow_ctrler_cfg_i.lval_pause_min'length);
            flow_ctrler_cfg_i.fval_pause_min                <= to_unsigned(0,flow_ctrler_cfg_i.fval_pause_min'length);
			flow_ctrler_cfg_i.memory_buffer_download_output <= '0';
            valid_cfg_last <= '0';
         else
            valid_cfg_last <= flow_ctrler_cfg_i.dval;
            if flow_ctrler_cfg_i.dval = '1' and valid_cfg_last = '0' then
               flow_ctrler_cfg_i.stalled_cnt                   <= FLOW_CTRLER_CFG.stalled_cnt;
               flow_ctrler_cfg_i.valid_cnt                     <= FLOW_CTRLER_CFG.valid_cnt;
			   flow_ctrler_cfg_i.memory_buffer_download_output <= FLOW_CTRLER_CFG.memory_buffer_download_output;
               flow_ctrler_cfg_i.width                         <= FLOW_CTRLER_CFG.width;
               flow_ctrler_cfg_i.lval_pause_min                <= FLOW_CTRLER_CFG.lval_pause_min;
               flow_ctrler_cfg_i.fval_pause_min                <= FLOW_CTRLER_CFG.fval_pause_min;
            end if;
            
         end if;  
      end if;
   end process;
       		
   AXIS_MOSI_TX.TKEEP    <=  (others => '1');
   AXIS_MOSI_TX.TSTRB    <=  (others => '1');
   AXIS_MOSI_TX.TUSER    <=  (others => '0');
   AXIS_MOSI_TX.TDEST    <=  (others => '0');
   AXIS_MOSI_TX.TID      <=  (others => '0');            
   AXIS_MOSI_TX.TLAST    <=  AXIS_MOSI_RX.TLAST;
   AXIS_MOSI_TX.TDATA    <=  AXIS_MOSI_RX.TDATA;            
   AXIS_MOSI_TX.TVALID   <=  AXIS_MOSI_RX.TVALID and not stall_i;            
   AXIS_MISO_RX.TREADY   <=  rx_tready;
   rx_tready             <=  AXIS_MISO_TX.TREADY and not stall_i;
   
	U4 : process(CLK_DIN)
   begin
      if rising_edge(CLK_DIN) then 
         if sresetn_i = '0' or flow_ctrler_cfg_i.dval = '0' then  
         	flow_control_s <=  idle_st; 
         	stall_i        <= '0';  
            lval_cnt       <= to_unsigned(0,lval_cnt'length);
         	valid_cnt      <= to_unsigned(0,valid_cnt'length);
            pause_cnt      <= to_unsigned(0,pause_cnt'length);
            width          <= to_unsigned(0,width'length);
          else	
             
             width <= resize(shift_right(flow_ctrler_cfg_i.width, 2), width'length);
             
             case flow_control_s is 
                
                when idle_st =>	    	 

                  if (AXIS_MOSI_RX.TVALID = '1' and rx_tready = '1') then
                     lval_cnt  <= lval_cnt + 1; 
                     valid_cnt <= valid_cnt + 1 ;

                     if (valid_cnt = flow_ctrler_cfg_i.valid_cnt-1) and flow_ctrler_cfg_i.valid_cnt > 0 and flow_ctrler_cfg_i.stalled_cnt > 0 then  
                        valid_cnt      <= to_unsigned(0,valid_cnt'length);
                        if lval_cnt = width-1 and AXIS_MOSI_RX.TLAST = '1' and flow_ctrler_cfg_i.fval_pause_min > 0 then --eof or "end of header"
                           lval_cnt       <= to_unsigned(0,lval_cnt'length);
                           pause_cnt_min  <= flow_ctrler_cfg_i.stalled_cnt + flow_ctrler_cfg_i.fval_pause_min;
                        elsif lval_cnt = width-1 and AXIS_MOSI_RX.TLAST = '0' and flow_ctrler_cfg_i.lval_pause_min > 0 then --eol
                           lval_cnt       <= to_unsigned(0,lval_cnt'length);
                           pause_cnt_min  <= flow_ctrler_cfg_i.stalled_cnt + flow_ctrler_cfg_i.lval_pause_min; 
                        else
                           pause_cnt_min  <= flow_ctrler_cfg_i.stalled_cnt;
                        end if;

                        stall_i        <= '1';  
                        flow_control_s <= pause_st;
                          
                    elsif lval_cnt = width-1 and AXIS_MOSI_RX.TLAST = '1' and flow_ctrler_cfg_i.fval_pause_min > 0 then --eof or "end of header" 
                        lval_cnt       <= to_unsigned(0,lval_cnt'length);
                        pause_cnt_min  <= flow_ctrler_cfg_i.fval_pause_min;
                        stall_i        <= '1';
                        flow_control_s <= pause_st;

                    elsif lval_cnt = width-1 and AXIS_MOSI_RX.TLAST = '0' and flow_ctrler_cfg_i.lval_pause_min > 0 then --eol 
                        lval_cnt       <= to_unsigned(0,lval_cnt'length);
                        pause_cnt_min  <= flow_ctrler_cfg_i.lval_pause_min;
                        stall_i        <= '1';
                        flow_control_s <= pause_st;                        
                    else
                        stall_i        <= '0';
                        flow_control_s <= idle_st;     
                    end if;
                  end if;

                when pause_st =>   
                  if pause_cnt = pause_cnt_min-1 then 
                     pause_cnt <= to_unsigned(0,pause_cnt'length);
                     stall_i <= '0';
                     flow_control_s <= idle_st;
                  else 			  
                     pause_cnt <= pause_cnt + 1;
                  end if;

            end case;
         end if;
      end if;
	end process; 
 
end behav;
