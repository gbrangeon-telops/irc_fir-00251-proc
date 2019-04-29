library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tel2000.all;

entity video_ehdri_SM is
   port(
      --clk and reset
      CLK_DATA         : in std_logic; -- at 160 MHZ
      ARESETN          : in std_logic;
             
      RX_MOSI  : in  t_axi4_stream_mosi16; 
      RX_MISO  : in t_axi4_stream_miso;
	  
      HDR_INFO_VALID  : in std_logic;
      SELECTOR_ENABLE : in std_logic;
      HDR_EHDRI_INDEX : in std_logic_vector(7 downto 0); 
      CMD_EHDRI_INDEX : in std_logic_vector(7 downto 0); 
      Freeze_Pixel    : out std_logic
   );
end video_ehdri_SM;

architecture implementation of video_ehdri_SM is

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

   type output_state_t is (eval_frame, in_frame);
   signal output_state : output_state_t := eval_frame;

begin
    U1 : sync_resetn port map(ARESETN => ARESETN, SRESETN => sresetn, CLK => CLK_DATA);   
    
    Freeze_Pixel <= freeze_pixel_i;
    
    FREEZE_PROC : process (CLK_DATA)
    begin
        if rising_edge(CLK_DATA) then 
            if sresetn = '0' then
                freeze_pixel_i <= '0';
                output_state <= eval_frame;
            else
                case output_state is
                    when eval_frame =>
                        if HDR_INFO_VALID = '1' then
                           if HDR_EHDRI_INDEX /= CMD_EHDRI_INDEX and HDR_EHDRI_INDEX /= x"05" and SELECTOR_ENABLE = '1' then
                              output_state <= in_frame;
                              freeze_pixel_i <= '1';
                           else
                              output_state <= in_frame;
                              freeze_pixel_i <= '0';
                           end if;
                        end if;
                
                    when in_frame =>
                        if RX_MOSI.TVALID = '1' and RX_MOSI.TLAST = '1' and RX_MISO.TREADY = '1' then
                            output_state <= eval_frame;
                        end if;
                        
                    when others =>
                        output_state <= eval_frame;
                    
                end case;
            end if;
        end if;
    end process FREEZE_PROC; 

end implementation;
