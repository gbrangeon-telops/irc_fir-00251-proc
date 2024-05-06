------------------------------------------------------------------
--!   @file : scd_proxy2_mux_dsync
--!   @brief
--!   @details
--!
--!   $Rev: 27206 $
--!   $Author: pcouture $
--!   $Date: 2022-03-03 15:45:34 -0500 (jeu., 03 mars 2022) $
--!   $Id: scd_proxy2_mux_std_core.vhd 27206 2022-03-03 20:45:34Z pcouture $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2023-09-08-Binning-FPA/src/FPA/scd_proxy2/HDL/scd_proxy2_line_mux.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.Fpa_Common_Pkg.all;
use work.fpa_define.all; 
use work.proxy_define.all;
use work.tel2000.all;

entity scd_proxy2_mux_dsync is
   port(
	   ARESET         : in std_logic;

      -- ch0_in no binn 
      CH0_DCLK         : in std_logic;
      CH0_DUAL_DATA    : in std_logic_vector(35 downto 0);
      CH0_DUAL_DVAL    : in std_logic;
      CH0_SUCCESS      : in std_logic;
      CH0_RDY			: in std_logic;
	  
      -- ch1_in binn
      CH1_DCLK      : in std_logic;
      CH1_DUAL_DATA : in std_logic_vector(35 downto 0);
      CH1_DUAL_DVAL : in std_logic;
      CH1_SUCCESS      : in std_logic;
      CH1_RDY			: in std_logic;
	  
      -- ch_out
      CHOUT_DCLK      : out std_logic;
      CHOUT_DUAL_DATA : out std_logic_vector(35 downto 0);
      CHOUT_DUAL_DVAL : out std_logic;
      CHOUT_SUCCESS      : out std_logic;
      CHOUT_RDY			: out std_logic; 
      
      FPA_INTF_CFG     : in fpa_intf_cfg_type
      );
end scd_proxy2_mux_dsync;


architecture rtl of scd_proxy2_mux_dsync is
   
   --type line_mux_fsm_type is (wait_binning_mode,line0_out_st, line1_out_st);
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
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

   -- tbd 
   --signal err_i                : std_logic;
   --signal sel_i                : std_logic;
   --signal sel_o                : std_logic;
   signal sreset               : std_logic;
   --signal line_mux_fsm         : line_mux_fsm_type;
   signal binning_mode         : std_logic;
   --signal output_state         : std_logic; 

begin
   --binning_mode <= to_integer(signed(FPA_INTF_CFG.op.binning));	 
   --Only no binning and binning 2x2
   --sel_i <=	FPA_INTF_CFG.op.binning(0);
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CH0_DCLK,
      SRESET => sreset
      );
	  
  U2 : double_sync
  port map(
     CLK => CH0_DCLK,
     D   => FPA_INTF_CFG.op.binning(0),	 -- FPA_INTF_CFG.op.binning(0);
     Q   => binning_mode,
     RESET => sreset
     );	  
--	 
--   U3: process(CH0_DCLK)
--   begin          
--      if rising_edge(CH0_DCLK) then 
--         if sreset = '1' then
--            sel_o <= '0';
--            output_state <= '0' ;
--			err_i <= '0';
--         else
--            
--            if binning_mode = '0' then    
--               sel_o <= '0'; -- ou binning_mode?
--			   output_state <= '1' ;
--            elsif binning_mode = '1' then
--               sel_o <= '1'; -- ou binning_mode?
--			   output_state <= '1' ;
--			else 
--			    sel_o <= sel_o;	
--				output_state <= '0' ;
--            end if;
--            
--         end if;         
--      end if;
--   end process;  
   
      -- assign output
   CHOUT_DCLK      <= CH1_DCLK  when binning_mode = '1' else  CH0_DCLK; 
   CHOUT_DUAL_DATA <= CH1_DUAL_DATA when binning_mode = '1' else  CH0_DUAL_DATA; 
   CHOUT_DUAL_DVAL <= CH1_DUAL_DVAL when binning_mode = '1' else  CH0_DUAL_DVAL; 
   CHOUT_SUCCESS   <= CH1_SUCCESS when binning_mode = '1' else  CH0_SUCCESS; 
   CHOUT_RDY   <= CH1_RDY when binning_mode = '1' else  CH0_RDY; 
   

   
   
end rtl;
