----------------------------------------------------------------------------------
-- Company: Telops
-- Engineer: ALA
-- 
-- Create Date: 12/07/2023 02:59:45 PM
-- Design Name: FIR-00251-Proc
-- Module Name: kpix_bramaddr - Behavioral
-- Project Name: Senseeker
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library WORK;
use WORK.PROXY_DEFINE.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity kpix_bramaddr is
    Generic (
        DETECTOR_WIDTH  : positive := 640
    );
    Port (
        clk : in std_logic;
        rst : in std_logic;
        cfg : in fpa_intf_cfg_type;
        dval : in std_logic;
        dlst : in std_logic;
        addr : out std_logic_vector;
        rena : out std_logic
    );
end kpix_bramaddr;

architecture Behavioral of kpix_bramaddr is
    constant DETECTOR_WIDTH_D4  : positive := DETECTOR_WIDTH/4;
    alias    current_width_d4   : unsigned(cfg.width'LEFT  -2 downto 0) is cfg.width  (cfg.width'LEFT   downto 2);
    alias    current_offsetx_d4 : unsigned(cfg.offsetx'LEFT-2 downto 0) is cfg.offsetx(cfg.offsetx'LEFT downto 2);
    alias    current_offsety_d1 : unsigned(cfg.offsety'LEFT-0 downto 0) is cfg.offsety(cfg.offsety'LEFT downto 0);
    
    signal tmp_address : natural range 0 to 2**addr'LENGTH-1   := 0;
    signal cur_address : natural range 0 to 2**addr'LENGTH-1   := 0;
    signal cnt_address : natural range 0 to DETECTOR_WIDTH/4   := 0;
    signal jmp_address : natural range 0 to DETECTOR_WIDTH/4-2 := 0;
    
    type fsm_type is (IDLE, RUN);
    
    signal frame_done : std_logic := '1';
begin
    addr <= std_logic_vector(to_unsigned(cur_address, addr'LENGTH));
    
    process(clk, dval)
        variable state : fsm_type := IDLE;
    begin
        if dval = '1' and (frame_done = '1' or state = RUN) then
            rena <= '1';
        else
            rena <= '0';
        end if;
        
        if rising_edge(clk) then
            if rst = '1' then
                tmp_address <= 0;
                cur_address <= 0;
                cnt_address <= 0;
                jmp_address <= 0;
                state       := IDLE;
                frame_done  <= '1';
            else
                tmp_address <= to_integer(current_offsety_d1)*DETECTOR_WIDTH_D4;
                
                if dlst = '1' then
                    state      := IDLE;
                    frame_done <= '1';
                elsif dval = '1' and frame_done = '1' then
                    state      := RUN;
                    frame_done <= '0';
                end if;
                
                case state is
                    when IDLE =>
                        cur_address <= tmp_address+to_integer(current_offsetx_d4);
                        cnt_address <= 1;
                        jmp_address <= DETECTOR_WIDTH_D4-to_integer(current_width_d4)+1;
                    when RUN =>
                        if dval = '1' then
                            if cnt_address = to_integer(current_width_d4) then
                                cur_address <= cur_address+jmp_address;
                                cnt_address <= 1;
                            else
                                cur_address <= cur_address+1;
                                cnt_address <= cnt_address+1;
                            end if;
                        end if;
                end case;
            end if;
        end if;
    end process;
end Behavioral;
