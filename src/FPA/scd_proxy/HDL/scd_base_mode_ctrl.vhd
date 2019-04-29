------------------------------------------------------------------
--!   @file : scd_base_mode_ctrl
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
use IEEE.STD_LOGIC_1164.all;
use work.FPA_Define.all;

entity scd_base_mode_ctrl is 
   port (
      ARESET            : in std_logic;
      
      FPA_CH1_IN_RST    : in std_logic; 
      FPA_CH1_DIN_CLK   : in std_logic; 
      FPA_CH1_DIN       : in std_logic_vector(27 downto 0);      
      FPA_CH1_DIN_DVAL  : in std_logic;   
      FPA_CH1_DIN_FVAL  : in std_logic;
      
      FPA_CH2_IN_RST    : in std_logic; 
      FPA_CH2_DIN_CLK   : in std_logic;
      FPA_CH2_DIN       : in std_logic_vector(27 downto 0);      
      FPA_CH2_DIN_DVAL  : in std_logic;      
      FPA_CH2_DIN_FVAL  : in std_logic;
      
      FPA_CH1_OUT_RST   : out std_logic;
      FPA_CH1_DOUT_CLK  : out std_logic;
      FPA_CH1_DOUT      : out std_logic_vector(27 downto 0);      
      FPA_CH1_DOUT_DVAL : out std_logic;
      
      FPA_CH2_OUT_RST   : out std_logic;
      FPA_CH2_DOUT_CLK  : out std_logic;
      FPA_CH2_DOUT      : out std_logic_vector(27 downto 0);      
      FPA_CH2_DOUT_DVAL : out std_logic;
      
      FPA_CH1_FIFO_FLUSH: in std_logic;
      FPA_CH2_FIFO_FLUSH: in std_logic
      ); 
   
end scd_base_mode_ctrl;


architecture rtl of scd_base_mode_ctrl is 
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component; 
   
   type base_mode_fsm_type is (odd_data_st, even_data_st, idle);
   signal base_mode_fsm       : base_mode_fsm_type;
   signal sreset              : std_logic;
   signal fval_p0             : std_logic;
   signal dval_p0             : std_logic;
   signal din_p0              : std_logic_vector(27 downto 0);
   signal fval_p1             : std_logic;
   signal dval_p1             : std_logic;
   signal din_p1              : std_logic_vector(27 downto 0);
   
   
begin
   
   -------------------------------------------------------------------------
   --      double base mode 
   -------------------------------------------------------------------------
   
   double_base_mode_gen: if PROXY_CLINK_CHANNEL_NUM = 2 generate	
   begin
      
      FPA_CH1_DOUT_CLK  <= FPA_CH1_DIN_CLK;            
      FPA_CH1_DOUT      <= FPA_CH1_DIN;
      FPA_CH1_DOUT_DVAL <= FPA_CH1_DIN_DVAL;
      FPA_CH1_OUT_RST   <= FPA_CH1_IN_RST or FPA_CH1_FIFO_FLUSH;
      
      FPA_CH2_DOUT_CLK  <= FPA_CH2_DIN_CLK;              
      FPA_CH2_DOUT      <= FPA_CH2_DIN;
      FPA_CH2_DOUT_DVAL <= FPA_CH2_DIN_DVAL;
      FPA_CH2_OUT_RST   <= FPA_CH2_IN_RST or FPA_CH2_FIFO_FLUSH;
      
   end generate;
   
   
   
   ------------------------------------------------------------------------
   --      simple base mode 
   -------------------------------------------------------------------------  
   
   simple_base_mode_gen: if PROXY_CLINK_CHANNEL_NUM = 1 generate	
   begin
      -- horloges et reset 
      FPA_CH1_DOUT_CLK  <= FPA_CH1_DIN_CLK;      
      FPA_CH1_OUT_RST   <= FPA_CH1_FIFO_FLUSH or FPA_CH1_IN_RST;
      FPA_CH2_DOUT_CLK  <= FPA_CH1_DIN_CLK;
      FPA_CH2_OUT_RST   <= FPA_CH1_FIFO_FLUSH or FPA_CH1_IN_RST;
      
      -- sync reset
      U1: sync_reset port map( ARESET => ARESET, CLK => FPA_CH1_DIN_CLK, SRESET => sreset);
      
      
      -- repartition des pixels
      U2: process(FPA_CH1_DIN_CLK) 
      begin
         if rising_edge(FPA_CH1_DIN_CLK) then 
            if sreset = '1' then 
               base_mode_fsm <= idle;
               FPA_CH1_DOUT_DVAL <= '0';
               FPA_CH2_DOUT_DVAL <= '0';
               fval_p0 <= '0';
               dval_p0 <= '0';
               fval_p1 <= '0';
               dval_p1 <= '0';
               
            else
               
               --pipe 
               fval_p0 <= FPA_CH1_DIN_FVAL;
               dval_p0 <= FPA_CH1_DIN_DVAL;
               din_p0  <= FPA_CH1_DIN;
               
               fval_p1 <= fval_p0;
               dval_p1 <= dval_p0;
               din_p1  <= din_p0;
               
               case base_mode_fsm is      
                  
                  when idle =>
                     FPA_CH1_DOUT_DVAL <= '0';
                     FPA_CH2_DOUT_DVAL <= '0';
                     if fval_p0 = '1' then   
                        base_mode_fsm <= odd_data_st; 
                     end if; 
                  
                  when odd_data_st =>                
                     FPA_CH1_DOUT_DVAL <= '0';
                     FPA_CH2_DOUT_DVAL <= '0';
                     if dval_p1 = '1' then 
                        FPA_CH1_DOUT <= din_p1;
                        FPA_CH1_DOUT_DVAL <= '1';
                        base_mode_fsm <= even_data_st;             
                     end if;
                     if FPA_CH1_FIFO_FLUSH = '1' then
                        base_mode_fsm <= idle; 
                     end if;
                  
                  when even_data_st =>
                     FPA_CH1_DOUT_DVAL <= '0';
                     FPA_CH2_DOUT_DVAL <= '0';
                     if dval_p1 = '1' then
                        FPA_CH2_DOUT <= din_p1;
                        FPA_CH2_DOUT_DVAL <= '1';					 
                        base_mode_fsm <= odd_data_st;
                     end if;
                     if FPA_CH1_FIFO_FLUSH = '1' then
                        base_mode_fsm <= idle; 
                     end if;
                  
                  when others =>
                  
               end case;
               
            end if;              
         end if;  
      end process; 
      
   end generate;
   
   
end rtl;
