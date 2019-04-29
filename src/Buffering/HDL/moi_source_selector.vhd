-------------------------------------------------------------------------------
--
-- Title       : moi_source_selector
-- Author      : Jean-Alexis Boulet
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- Description : select the moi source type and edge
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.Tel2000.all;
use work.BufferingDefine.all;

entity moi_source_selector is
   
   port(
      EXTERNAL  : in  STD_LOGIC;
      SOFTWARE  : in STD_LOGIC;
      MODE      : in MOI_MODE; 
      EDGE      : in EDGE_TYPE; 
      
      MOI       : out std_logic;
      
      ARESETN  : in  std_logic;
      CLK      : in  std_logic     
      );
end moi_source_selector;


architecture RTL of moi_source_selector is 
   
signal sresetn   : std_logic;
    signal soft_moi_d1  : std_logic;
    signal soft_moi : std_logic;
    signal ext_moi_o : std_logic;
    signal ext_moi_i : std_logic_vector(1 downto 0);


   component sync_resetn
      port(
         ARESETN : in std_logic;
         SRESETN : out std_logic;
         CLK    : in std_logic);
   end component;  
   
   
begin    
   

    --------------------------------------------------
    -- synchro reset 
    --------------------------------------------------   
    U1: sync_resetn
    port map(
      ARESETN => ARESETN,
      CLK    => CLK,
      SRESETN => sresetn
      );
   

    clk_output : process(CLK)
    begin
        if rising_edge(CLK) then
            if sresetn = '0' then            
                MOI <= '0';
            else
                case MODE is
                    when EXT_SRC => -- ext moi
                        MOI <= ext_moi_o;
                    when SOFT_SRC => -- soft moi
                        MOI <= soft_moi;               
                    when NO_SRC => -- no moi
                        MOI <= '1';
                    when others =>
                        MOI <= '0';
                end case;                    
            end if;
        end if;
    end process;
    
    
    edge_detect : process(CLK)
    begin
        if rising_edge(CLK) then
            if sresetn = '0' then            
                ext_moi_o <= '0';
                ext_moi_i <= "00";
                soft_moi_d1 <= '0';
                soft_moi <= '0';
            else
                --external
                ext_moi_i(0) <= EXTERNAL;
                ext_moi_i(1) <= ext_moi_i(0);
                case EDGE is
                    when RISING => -- ext moi
                        if ext_moi_i(0) = '1' and ext_moi_i(1) = '0' then -- rising edge
                            ext_moi_o <= '1';
                        else
                            ext_moi_o <= '0';                
                        end if;
                    when FALLING => -- soft moi
                        if ext_moi_i(0) = '0' and ext_moi_i(1) = '1' then --Falling edge
                            ext_moi_o <= '1';
                        else
                            ext_moi_o <= '0';                        
                        end if;
                    when ANY => -- no moi
                        if (ext_moi_i(0) /= ext_moi_i(1)) then
                            ext_moi_o <= '1';
                        else
                            ext_moi_o <= '0';                        
                        end if;
                    when others =>
                        ext_moi_o <= '0';  
                end case;
                
                --software
                soft_moi_d1 <= SOFTWARE;
                if (soft_moi_d1 = '0' and SOFTWARE ='1') then 
                    soft_moi <= '1';
                else                
                    soft_moi <= '0';
                end if;
                
                
            end if;
        end if;
    end process;      
   
end RTL;
