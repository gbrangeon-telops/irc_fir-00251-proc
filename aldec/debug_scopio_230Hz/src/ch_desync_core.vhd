------------------------------------------------------------------
--!   @file : ch_desync_core
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
use IEEE.NUMERIC_STD.all;

entity ch_desync_core is
   port(
      
      ARESET     : in std_logic;
      CLK        : in std_logic;
      
      CH0_FVAL   : in std_logic;
      CH0_LVAL   : in std_logic;
      CH0_DVAL   : in std_logic;
      
      CH1_FVAL   : in std_logic;
      CH1_LVAL   : in std_logic;
      CH1_DVAL   : in std_logic;
      
      MEAS       : out std_logic_vector(9 downto 0);
      DONE       : out std_logic
      );
end ch_desync_core;

architecture rtl of ch_desync_core is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;   
   
   type meas_fsm_type is (idle, meas_st);
   
   signal meas_fsm        : meas_fsm_type; 
   signal sreset          : std_logic;
   signal done_o          : std_logic;
   signal meas_count_o    : unsigned(MEAS'LENGTH-1 downto 0);
   signal ch0_fval_pipe   :std_logic_vector(2 downto 0);
   signal ch0_lval_pipe   :std_logic_vector(2 downto 0);
   signal ch0_dval_pipe   :std_logic_vector(2 downto 0);
   signal ch1_fval_pipe   :std_logic_vector(2 downto 0);
   signal ch1_lval_pipe   :std_logic_vector(2 downto 0);
   signal ch1_dval_pipe   :std_logic_vector(2 downto 0);
   signal ch0_re          : std_logic;
   signal ch1_re          : std_logic;
   signal ch0_valid_i     : std_logic;
   signal ch0_valid_last  : std_logic;
   signal ch1_valid_i     : std_logic;
   signal ch1_valid_last  : std_logic;
   
begin
   
   DONE <= done_o;
   MEAS <= std_logic_vector(meas_count_o);
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   
   
   --------------------------------------------------
   -- mesure de la durée de LVAL 
   --------------------------------------------------  
   U2 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            done_o <= '0';    
            ch0_fval_pipe(2 downto 0) <= (others => '0'); 
            ch0_lval_pipe(2 downto 0) <= (others => '0'); 
            ch0_dval_pipe(2 downto 0) <= (others => '0');            
            ch1_fval_pipe(2 downto 0) <= (others => '0'); 
            ch1_lval_pipe(2 downto 0) <= (others => '0'); 
            ch1_dval_pipe(2 downto 0) <= (others => '0'); 
            
            ch0_re <= '0';
            ch1_re <= '0';
            
            meas_fsm <=  idle;
            
         else 
            
            ch0_fval_pipe(2 downto 0) <= ch0_fval_pipe(1 downto 0) & CH0_FVAL;
            ch0_lval_pipe(2 downto 0) <= ch0_lval_pipe(1 downto 0) & CH0_LVAL;
            ch0_dval_pipe(2 downto 0) <= ch0_dval_pipe(1 downto 0) & CH0_DVAL;            
            
            ch1_fval_pipe(2 downto 0) <= ch1_fval_pipe(1 downto 0) & CH1_FVAL;
            ch1_lval_pipe(2 downto 0) <= ch1_lval_pipe(1 downto 0) & CH1_LVAL;
            ch1_dval_pipe(2 downto 0) <= ch1_dval_pipe(1 downto 0) & CH1_DVAL;            
            
            ch0_valid_i <= ch0_fval_pipe(2) and ch0_lval_pipe(2) and ch0_dval_pipe(2); 
            ch0_valid_last <= ch0_valid_i; 
            ch0_re <= not ch0_valid_last and ch0_valid_i;
            
            ch1_valid_i <= ch1_fval_pipe(2) and ch1_lval_pipe(2) and ch1_dval_pipe(2); 
            ch1_valid_last <= ch1_valid_i; 
            ch1_re <= not ch1_valid_last and ch1_valid_i;        
            
            case  meas_fsm is 
               
               when idle =>
                  done_o <= '0';
                  meas_count_o <= (others => '0');  
                  if (ch0_re xor ch1_re) = '1' then   
                     meas_fsm <=  meas_st;
                  end if;
               
               when meas_st =>
                  meas_count_o <=  meas_count_o + 1;
                  if ch0_re = '1' or ch1_re = '1' then 
                     done_o <= '1'; 
                     meas_fsm <=  idle;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   
   
end rtl;
