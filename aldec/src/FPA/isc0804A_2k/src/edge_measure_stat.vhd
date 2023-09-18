------------------------------------------------------------------
--!   @file : edge_measure_stat
--!   @brief
--!   @details
--!
--!   $Rev: 20057 $
--!   $Author: enofodjie $
--!   $Date: 2017-02-05 15:16:08 -0500 (dim., 05 févr. 2017) $
--!   $Id: edge_measure_stat.vhd 20057 2017-02-05 20:16:08Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/FPA/isc0804A/src/edge_measure_stat.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity edge_measure_stat is
   generic(
      RE_DISTANCE_REF : integer := 0;
      FE_DISTANCE_REF : integer := 0
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
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   signal sreset        : std_logic;
   signal fe_err_i      : std_logic;
   signal re_err_i      : std_logic;
   signal delta_re      : signed(32 downto 0);
   signal delta_fe      : signed(32 downto 0);
   signal delta_re_dval : std_logic;
   signal delta_fe_dval : std_logic;
   
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
            delta_fe_dval <= '0';
            delta_fe_dval <= '0';
            ERR <= '0';
         else 
            
            delta_re <= abs(signed('0' & TOC_RE_DLY) - to_signed(RE_DISTANCE_REF, 33));
            delta_re_dval <= TOC_RE_DLY_DVAL;
            
            delta_fe <= abs(signed('0' & TOC_FE_DLY) - to_signed(FE_DISTANCE_REF, 33));
            delta_fe_dval <= TOC_FE_DLY_DVAL;
            
            if delta_re > 2 then
               re_err_i <= delta_re_dval;               
            end if;
            
            if delta_fe > 2 then
               fe_err_i <= delta_fe_dval;               
            end if;        
            
            if fe_err_i = '1' or re_err_i = '1' then 
               ERR <= '1';
            end if;
            
         end if;
      end if;
   end process;
   
   
end rtl;
