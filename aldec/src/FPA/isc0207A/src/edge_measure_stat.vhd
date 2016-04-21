------------------------------------------------------------------
--!   @file : edge_measure_stat
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
use IEEE.numeric_std.all;

entity edge_measure_stat is
   generic(
      RE_DISTANCE_REF : unsigned(31 downto 0);
      FE_DISTANCE_REF : unsigned(31 downto 0)
      );
   
   port(
      CLK              : in STD_LOGIC;
      ARESET           : in STD_LOGIC;
      
      TOC_FE_DLY       : in STD_LOGIC_VECTOR(31 downto 0);
      TOC_FE_DLY_DVAL  : in STD_LOGIC;
      
      TOC_RE_DLY       : in STD_LOGIC_VECTOR(31 downto 0);
      TOC_RE_DLY_DVAL  : in STD_LOGIC;
      
      ERR              : out STD_LOGIC
      );
end edge_measure_stat;



architecture rtl of edge_measure_stat is
begin
   
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
   -- 
   --------------------------------------------------  
   U2 : process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            fe_err_i <= '0';
            re_err_i <= '0';
            ERR <= '0';
         else 
            
            if abs(TOC_FE_DLY - FE_DISTANCE_REF) > 2 then
               fe_err_i <= TOC_FE_DLY_DVAL;               
            end if;       
            
            if abs(TOC_RE_DLY - RE_DISTANCE_REF) > 2 then
               re_err_i <= TOC_RE_DLY_DVAL;               
            end if;
            
            if fe_err_i = '1' or re_err_i = '1' then 
               ERR <= '1';
            end if;
            
         end if;
      end if;
   end process;
   
   
end rtl;
