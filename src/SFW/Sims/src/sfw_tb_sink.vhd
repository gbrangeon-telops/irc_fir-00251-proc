-------------------------------------------------------------------------------
--
-- Title       : SFW TB sink
-- Design      : tb_sfw
-- Author      : JBO
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- File        :
-- Generated   : 
-- From        : 
-- By          : 
--
-------------------------------------------------------------------------------
--
-- Description :  Stim file for SFW simulation
--
-------------------------------------------------------------------------------

library IEEE;                                             
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.tel2000.all;
use work.img_header_define.all;

entity sfw_tb_sink is
    generic(
        HDR_INSERT_CLK_DELAY : integer := 5
    );
    port(
    --------------------------------
    -- MB Interface
    -------------------------------- 
    AXIL_MOSI : in t_axi4_lite_mosi;
    AXIL_MISO : out t_axi4_lite_miso;

    FPA_IMG_INFO : in img_info_type;
    FPA_EXP_INFO : in exp_info_type;
    
    --------------------------------
    -- SYSTEM
    -------------------------------- 
    CLK100   : in STD_LOGIC;
    ARESETN   : in STD_LOGIC
    );
end sfw_tb_sink;



architecture rtl of sfw_tb_sink is

constant nb_frame : integer := 500;

--type definition
type t_hdr_content is record 
  -- Write Address Channel   
  frame_id      : unsigned(31 downto 0);
  exp_time      : unsigned(31 downto 0);
  exp_time_indx : std_logic_vector(7 downto 0);
  fw_speed      : STD_LOGIC_VECTOR ( 15 downto 0 );
  fw_position      : STD_LOGIC_VECTOR ( 15 downto 0 );
  fw_end_start     : STD_LOGIC_VECTOR ( 15 downto 0 );
  fw_end_end      : STD_LOGIC_VECTOR ( 15 downto 0 );
end record;

type t_hdr_list is array (0 to nb_frame) of t_hdr_content;
type sfw_hder_write_state_t is (read_standby, read_hdr, eof );
   

signal hdr_list : t_hdr_list;
signal read_state_machine :sfw_hder_write_state_t := read_standby;

signal exp_feedbk_sr : std_logic_vector(HDR_INSERT_CLK_DELAY-1 downto 0); -- exp_feedback shift register

signal exp_time     : unsigned(31 downto 0);
signal exp_indx     : std_logic_vector(7 downto 0);
   
-- Constants


----------------------------   
-- Address of registers
----------------------------   

--Signals
signal frame_id : integer := 0;

--Exposure time ctrl


begin
-- Assign clock

EXP_INFO_PROCESS : process(CLK100)
begin
   if (rising_edge(CLK100)) then
      if ARESETN = '0' then
         exp_time <= (others => '0');
         exp_indx <= (others => '0');
      else
         if (FPA_EXP_INFO.exp_dval = '1') then
            exp_time <= FPA_EXP_INFO.exp_time;
            exp_indx <= FPA_EXP_INFO.exp_indx;
         end if;
      end if;
   end if;
end process EXP_INFO_PROCESS;


MB_PROCESS : process(CLK100)
begin
    if (rising_edge(CLK100)) then
        if ARESETN = '0' then
            AXIL_MISO.AWREADY   <= '1';
            AXIL_MISO.WREADY    <= '1';
            AXIL_MISO.BRESP     <= "00";
            AXIL_MISO.BVALID    <= '0';
            AXIL_MISO.RDATA     <= (others => '0');
            AXIL_MISO.RRESP     <= "00";
            AXIL_MISO.RVALID    <= '0';
            AXIL_MISO.ARREADY   <= '0';
            
            read_state_machine <= read_standby;
            frame_id <=0;
            
        else
            --delay to be conforme with reality
            exp_feedbk_sr(0) <= FPA_IMG_INFO.exp_feedbk;
            for i in 1 to HDR_INSERT_CLK_DELAY-1 loop
                exp_feedbk_sr(i) <= exp_feedbk_sr(i-1);        
            end loop;
            
            case read_state_machine is
                when read_standby =>
                    if(FPA_IMG_INFO.exp_feedbk = '1') then
                        hdr_list(frame_id).frame_id <= FPA_IMG_INFO.frame_id;
                        hdr_list(frame_id).exp_time <= FPA_IMG_INFO.exp_info.exp_time;
                        hdr_list(frame_id).exp_time_indx <= FPA_IMG_INFO.exp_info.exp_indx;
                        read_state_machine <= read_hdr;
                    end if;
                when read_hdr =>
                    --decode HDR ADDR
                    if (AXIL_MOSI.AWVALID = '1' AND AXIL_MOSI.WVALID = '1') THEN
                        case AXIL_MOSI.AWADDR(5 downto 0) is
                            when FWSPEEDAdd32 =>
                                hdr_list(frame_id).fw_speed <= AXIL_MOSI.WDATA(15 downto 0);
                            when FWPOSITIONAdd32 =>
                                hdr_list(frame_id).fw_position <= AXIL_MOSI.WDATA(31 downto 16);
                            when FWEncoderAtExposureStartAdd32 =>
                                hdr_list(frame_id).fw_end_start <= AXIL_MOSI.WDATA(15 downto 0);
                            when FWEncoderAtExposureEndAdd32 =>
                                hdr_list(frame_id).fw_end_end <= AXIL_MOSI.WDATA(31 downto 16);
                            when others =>
                        end case;
                        AXIL_MISO.BVALID    <= '1';
                        
                        --Choose next state
                        if( AXIL_MOSI.AWADDR(31 downto 16) = x"FFFF") then
                            read_state_machine <= eof;
                        else
                            read_state_machine <= read_hdr;
                        end if;
                    else
                        AXIL_MISO.BVALID    <= '0';                        
                    end if;

                when eof =>
                    AXIL_MISO.BVALID    <= '0';
                    if (exp_feedbk_sr(HDR_INSERT_CLK_DELAY-1) = '0') then
                        frame_id <= frame_id + 1;
                        read_state_machine <= read_standby;
                    end if;
                when others =>
                    read_state_machine <= read_standby;
            end case;
        end if;
    end if;
end process MB_PROCESS;


end rtl;
