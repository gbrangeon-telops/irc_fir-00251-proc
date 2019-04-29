library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;

entity video_freeze_SM is
   port(
      --clk and reset
      CLK_DATA         : in std_logic; -- at 160 MHZ
      ARESETN          : in std_logic;
             
      -- AXIS signals
      RX_Mosi : in t_axi4_stream_mosi16;
      RX_Miso : in t_axi4_stream_miso;
      
      Freeze_Cmd : in std_logic;
      Freeze_Pixel : out std_logic
      
   );
end video_freeze_SM;

architecture implementation of video_freeze_SM is

   component sync_resetn is
   port(
      ARESETN : in STD_LOGIC;
      SRESETN : out STD_LOGIC := '1';
      CLK    : in STD_LOGIC
      );
    end component sync_resetn;
    
-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------
   signal sresetn           : std_logic;
   signal freeze_pixel_i    : std_logic;

   type freeze_state_t is (unfreeze, freeze_cmd_received, freeze, unfreeze_cmd_received );
   signal freeze_state : freeze_state_t := unfreeze;
   
begin
    U1 : sync_resetn port map(ARESETN => ARESETN, SRESETN => sresetn, CLK => CLK_DATA);   
    
    Freeze_Pixel <= freeze_pixel_i;
    
    FREEZE_PROC : process (CLK_DATA)
    begin
        if rising_edge(CLK_DATA) then 
            if sresetn = '0' then
                freeze_pixel_i <= '0';
                freeze_state <= unfreeze;
            else
                case freeze_state is
                    when unfreeze =>
                        freeze_pixel_i <= '0';

                        if Freeze_Cmd = '1' then
                            freeze_state <= freeze_cmd_received;
                        end if;

                    when freeze_cmd_received =>
                        if (RX_Mosi.TVALID = '1' and RX_Mosi.TLAST = '1' and RX_Miso.TREADY = '1') then
                            freeze_state <= freeze;
                            freeze_pixel_i <= '1';
                        else
                            freeze_pixel_i <= '0';
                        end if;
                        
                    when freeze =>
                        freeze_pixel_i <= '1';

                        if Freeze_Cmd = '0' then
                            freeze_state <= unfreeze_cmd_received;
                        end if;
                        
                    when unfreeze_cmd_received =>
                        if (RX_Mosi.TVALID = '1' and RX_Mosi.TLAST = '1' and RX_Miso.TREADY = '1') then
                            freeze_state <= unfreeze;
                            freeze_pixel_i <= '0';
                        else
                            freeze_pixel_i <= '1';
                        end if;

                    when others =>
                        freeze_state <= unfreeze;
    
                end case;
            end if;
        end if;
    end process FREEZE_PROC; 

end implementation;
