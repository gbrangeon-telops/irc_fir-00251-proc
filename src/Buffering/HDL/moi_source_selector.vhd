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
      MODE      : in t_MOI_MODE; 
      EDGE      : in t_EDGE_TYPE; 
      
      MOI       : out std_logic;
      
      ARESETN  : in  std_logic;
      CLK      : in  std_logic     
      );
end moi_source_selector;


architecture RTL of moi_source_selector is 
   
   signal areset    : std_logic;
   signal sreset    : std_logic;
   signal soft_moi_d1  : std_logic;
   signal soft_moi : std_logic;
   signal external_sync : std_logic;
   signal ext_moi_o : std_logic;
   signal ext_moi_i : std_logic_vector(1 downto 0);


   component SYNC_RESET is
      port(
         --clk and reset
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
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
   
   
begin    
   
    areset <= not ARESETN;
   
    --------------------------------------------------
    -- synchro reset 
    --------------------------------------------------   
    U1: sync_reset
    port map(
      ARESET => areset,
      CLK    => CLK,
      SRESET => sreset
      );
      
    U2 : double_sync 
    port map(
       D => EXTERNAL,
       Q => external_sync,
       RESET => sreset,
       CLK => CLK
    );

    clk_output : process(CLK)
    begin
        if rising_edge(CLK) then
            if sreset = '1' then            
                MOI <= '0';
            else
                case MODE.MOIMODE is
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
            if sreset = '1' then            
                ext_moi_o <= '0';
                ext_moi_i <= "00";
                soft_moi_d1 <= '0';
                soft_moi <= '0';
            else
                --external
                ext_moi_i(0) <= external_sync;
                ext_moi_i(1) <= ext_moi_i(0);
                case EDGE.EDGETYPE is
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
