------------------------------------------------------------------
--!   @file : calcium_flow_mux
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
use work.Fpa_Common_Pkg.all;
use work.FPA_Define.all;
use work.proxy_define.all;

entity calcium_flow_mux is
   port (
      ARESET            : in std_logic;
      CLK               : in std_logic;
      
      FPA_INTF_CFG      : in fpa_intf_cfg_type;
      
      FPA_QUAD_DATA     : in calcium_quad_data_type;
      DIAG_QUAD_DATA    : in calcium_quad_data_type;
      TX_QUAD_DATA      : out calcium_quad_data_type
   );
end calcium_flow_mux;

architecture rtl of calcium_flow_mux is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
      );
   end component;
   
   type mode_fsm_type is (init_st, diag_wait_st, diag_st, fpa_wait_st, fpa_st);
   
   signal mode_fsm                     : mode_fsm_type;
   signal sreset                       : std_logic;
   signal tx_quad_data_i               : calcium_quad_data_type;
   
   
begin
   
   -- Output data mapping
   TX_QUAD_DATA <= tx_quad_data_i;
   
   --------------------------------------------------
   -- Reset
   --------------------------------------------------   
   U1 : sync_reset
   port map (
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
   );
   
   --------------------------------------------------
   -- Manage fpa and diag modes
   --------------------------------------------------
   U2 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then   
            mode_fsm <= init_st;
            tx_quad_data_i.fval <= '0';
            tx_quad_data_i.lval <= '0';
            tx_quad_data_i.dval <= '0';
            tx_quad_data_i.aoi_dval <= '0';
            tx_quad_data_i.aoi_last <= '0';
         else
            
            case mode_fsm is 
               
               when init_st =>
                  -- Begin in selected mode
                  if FPA_INTF_CFG.COMN.FPA_DIAG_MODE = '1' and FPA_INTF_CFG.COMN.FPA_INTF_DATA_SOURCE = DATA_SOURCE_INSIDE_FPGA then
                     mode_fsm <= diag_wait_st;
                  else
                     mode_fsm <= fpa_wait_st;
                  end if;
               
               when diag_wait_st =>
                  -- Wait for end of diag frame
                  if DIAG_QUAD_DATA.FVAL = '0' then 
                     -- Transmit while fval is low to make sure to generate a rising edge
                     tx_quad_data_i <= DIAG_QUAD_DATA;
                     mode_fsm <= diag_st;
                  end if;                   
               
               when diag_st => 
                  -- Transmit diag data even if fval is low
                  tx_quad_data_i <= DIAG_QUAD_DATA;
                  -- Change selected mode only at end of diag frame
                  if DIAG_QUAD_DATA.FVAL = '0' then
                     if FPA_INTF_CFG.COMN.FPA_DIAG_MODE = '0' or FPA_INTF_CFG.COMN.FPA_INTF_DATA_SOURCE = DATA_SOURCE_OUTSIDE_FPGA then
                        mode_fsm <= fpa_wait_st;
                     end if;
                  end if;
               
               when fpa_wait_st =>
                  -- Wait for end of fpa frame
                  if FPA_QUAD_DATA.FVAL = '0' then 
                     -- Transmit while fval is low to make sure to generate a rising edge
                     tx_quad_data_i <= FPA_QUAD_DATA;
                     mode_fsm <= fpa_st;
                  end if;
               
               when fpa_st => 
                  -- Transmit fpa data even if fval is low
                  tx_quad_data_i <= FPA_QUAD_DATA;
                  -- Change selected mode only at end of fpa frame
                  if FPA_QUAD_DATA.FVAL = '0' then
                     if FPA_INTF_CFG.COMN.FPA_DIAG_MODE = '1' and FPA_INTF_CFG.COMN.FPA_INTF_DATA_SOURCE = DATA_SOURCE_INSIDE_FPGA then
                        mode_fsm <= diag_wait_st;
                     end if;
                  end if;
               
               when others =>                 
               
            end case;
            
         end if;         
      end if;
   end process; 
   
end rtl;
