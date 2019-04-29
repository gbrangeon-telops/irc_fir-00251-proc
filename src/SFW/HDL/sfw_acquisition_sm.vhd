-------------------------------------------------------------------------------
--
-- Title       : SFW_Ctrl
-- Author      : Jean-Alexis Boulet
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author: pcouture $
-- $LastChangedDate: 2018-12-13 15:30:18 -0500 (jeu., 13 déc. 2018) $
-- $Revision: 22650 $ 
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.ALL;
use work.tel2000.all;
use work.sfw_define.all;
use work.img_header_define.all;



entity SFW_ACQUISITION_SM is
    GENERIC(
        RAM_BUS_WIDTH : integer := 7;
        HDR_INSERT_CLK_DELAY : integer :=4;
        SPEED_PRECISION_BIT  : integer := 4       -- Number of bits added to increase precision to the RPM
    );
    port(
        --------------------------------
        -- MB Interface
        --------------------------------
        WHEEL_STATE     : in STD_LOGIC_VECTOR(1 downto 0);     
        VALID_PARAM     : in STD_LOGIC;
        FILTER_NUM_LOCKED   :in STD_LOGIC;
        --------------------------------
        -- Header Data
        --------------------------------
        RISING_POSITION         : in std_logic_vector(15 downto 0);   -- encoder position at when INTEGRATION rises
        FALLING_POSITION        : in std_logic_vector(15 downto 0);   -- encoder position at when INTEGRATION falls
        ACQ_FILTER_NUMBER       : in std_logic_vector(7 downto 0);    -- Number of the filter (if valid) after the integration is done
        NEXT_FILTER_NUMBER      : in std_logic_vector(7 downto 0);    -- Number of the next filter in front of the lens
        RPM                     : in  std_logic_vector(15+SPEED_PRECISION_BIT downto 0);

        SFW_HDR_MOSI            : out t_axi4_lite_mosi;
        SFW_HDR_MISO            : in t_axi4_lite_miso;

        FPA_IMG_INFO        : in  img_info_type;
        FPA_EXP_INFO        : out exp_info_type;
        --EXP_INFO_BUSY       :in std_logic;

        --------------------------------
        -- RAM INTF
        --------------------------------
        EXP_RAM_ADDR        : out std_logic_vector(RAM_BUS_WIDTH-1 downto 0);
        EXP_RAM_DATA        : in std_logic_vector(31 downto 0);

        --------------------------------
        -- ERROR SIGNAL
        --------------------------------
        SYNC_ERROR          : out std_logic;

        
        --------------------------------
        -- Misc
        --------------------------------   
        CLK                 : in  std_logic;
        ARESETN             : in  std_logic
    );
end SFW_ACQUISITION_SM;


architecture RTL of SFW_ACQUISITION_SM is
   -- Component declaration
   component sync_resetn
      port(
         ARESETN                 : in std_logic;
         SRESETN                 : out std_logic;
         CLK                    : in std_logic);
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
   
   -- Signals
   signal sresetn               : std_logic := '0';
   signal enable                : std_logic := '0';
   signal valid_parameters      : std_logic := '0'; -- Tells if filter positions are valid
   signal fpa_exp_info_o        : exp_info_type;

   signal exp_ram_addr_i        : std_logic_vector(RAM_BUS_WIDTH-1 downto 0);
   signal next_exp_time_valid   : std_logic_vector(2 downto 0);
   signal exp_feedbk        :std_logic;
   signal exp_feedbk_sr : std_logic_vector(HDR_INSERT_CLK_DELAY-1 downto 0); -- exp_feedback shift register
   signal fpa_img_info_i        : img_info_type;
   --HDR AXIL
   type sfw_hder_write_state_t is (write_standby, wr_speed, wr_position, wr_enc_start, wr_enc_end, wait_write_completed);
   signal write_state : sfw_hder_write_state_t := write_standby;   
   signal next_write_state : sfw_hder_write_state_t := write_standby;
   signal axil_mosi_i : t_axi4_lite_mosi;
   signal axil_miso_i : t_axi4_lite_miso;

begin
   ----------------------------------------
   -- CLK
   ----------------------------------------
   sreset_ctrl_gen : sync_resetN
   port map(
      ARESETN => ARESETN,
      CLK    => CLK,
      SRESETN => sresetn
      );
   
   fpa_img_info_i <= FPA_IMG_INFO;
   
   double_sync_gen : double_sync port map( D => fpa_img_info_i.exp_feedbk, Q => exp_feedbk , RESET => sresetn , CLK => CLK );   
   --------------------------
   -- input signal
   --------------------------
   valid_parameters <= VALID_PARAM;
   --------------------------
   -- output signal
   --------------------------
   FPA_EXP_INFO <= fpa_exp_info_o; 
   EXP_RAM_ADDR <= exp_ram_addr_i;
   enable <= '1' when valid_parameters = '1' and ( WHEEL_STATE = ROTATING_WHEEL) else '0';
   
   SYNC_ERROR <= '0';
   
--------------------------
-- Synchronous Exposure time management
--------------------------
sync_exptime_mng_process : process(CLK)
begin
    if rising_edge(CLK) then 
        if sresetn = '0' or enable = '0' then
            fpa_exp_info_o.exp_dval <= '0';
            fpa_exp_info_o.exp_indx <= (others => '0');
            fpa_exp_info_o.exp_time <= (others => '0');
            
        else
            if(next_exp_time_valid(2) = '1') then -- next_exp_time updated with next filter exp_time
               fpa_exp_info_o.exp_time <= unsigned(EXP_RAM_DATA);
               fpa_exp_info_o.exp_indx <= NEXT_FILTER_NUMBER;
               fpa_exp_info_o.exp_dval <= '1';
            else
               fpa_exp_info_o.exp_dval <= '0';
            end if;
        end if;
    end if; 
end process sync_exptime_mng_process; 

   
--Read the exposure time value to be applied next
read_ram_process : process(CLK)
begin
    if rising_edge(CLK) then
        if sresetn = '0' or enable = '0' then
            exp_ram_addr_i <= (others => '0');
            next_exp_time_valid <= (others => '0');
        else
            next_exp_time_valid(2) <= next_exp_time_valid(1);
            next_exp_time_valid(1) <= next_exp_time_valid(0);
            if (resize(NEXT_FILTER_NUMBER, exp_ram_addr_i'length) /= exp_ram_addr_i) then
               next_exp_time_valid(0) <= '1';
            else
               next_exp_time_valid(0) <= '0';
            end if;
            
            --READ RAM
            exp_ram_addr_i <= std_logic_vector(NEXT_FILTER_NUMBER(RAM_BUS_WIDTH-1 downto 0));
            
        end if;
    end if; 
end process read_ram_process;

--Read the exposure time value to be applied next
SFW_HDR_MOSI <= axil_mosi_i;            
axil_miso_i <= SFW_HDR_MISO;           


--Header Gen process must send FW_SPEED, FW_POSITION, FW_ENCODER_START, FW_ENCODER_END and exposure time
Header_gen_process : process(CLK)
begin
    if rising_edge(CLK) then 
        if sresetn = '0' or WHEEL_STATE = NOT_IMPLEMENTED then
            axil_mosi_i.awvalid <= '0';
            axil_mosi_i.wvalid <= '0';
            axil_mosi_i.wstrb <= (others => '0');
            axil_mosi_i.bready <= '1';
            write_state <= write_standby;
            next_write_state <= write_standby;
            exp_feedbk_sr <= (others => '0');
            
        else
        
            exp_feedbk_sr(0) <= exp_feedbk;
            for i in 1 to HDR_INSERT_CLK_DELAY-1 loop
                exp_feedbk_sr(i) <= exp_feedbk_sr(i-1);        
            end loop;
            
            --Wait for integration then write Speed and enc_start, Wait for the end of integration then write FW_position and encoder end
            case write_state is
            
                when write_standby =>
                    -- Check for the start of delayed integration then write Speed
                    if exp_feedbk_sr(HDR_INSERT_CLK_DELAY-1) = '1' then 
                        write_state <= wr_speed;
                    end if;


                when wr_speed =>
                    axil_mosi_i.awaddr <= x"0000" &  std_logic_vector(fpa_img_info_i.frame_id(7 downto 0)) &  std_logic_vector(resize(FWSpeedAdd32, 8));
                    axil_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(RPM(15+SPEED_PRECISION_BIT downto SPEED_PRECISION_BIT)),32), FWSpeedShift));
                    axil_mosi_i.wstrb <= FWSpeedBWE;
                    axil_mosi_i.awvalid <= '1';
                    axil_mosi_i.wvalid <= '1';
                    --axil_mosi_i.bready <= '0';
                    write_state <= wait_write_completed;
                    next_write_state <= wr_enc_start;

               
                when wr_enc_start =>
                    axil_mosi_i.awaddr <= x"0000" &  std_logic_vector(fpa_img_info_i.frame_id(7 downto 0)) &  std_logic_vector(resize(FWEncoderAtExposureStartAdd32, 8));
                    axil_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(RISING_POSITION), 32), FWEncoderAtExposureStartShift));
                    axil_mosi_i.wstrb <= FWEncoderAtExposureStartBWE;
                    axil_mosi_i.awvalid <= '1';
                    axil_mosi_i.wvalid <= '1';
                    write_state <= wait_write_completed;
                    next_write_state <= wr_position;

                                    
                when wr_position =>
                    if(exp_feedbk_sr(HDR_INSERT_CLK_DELAY-1)= '0') then -- wait for ACQ to be latched
                        axil_mosi_i.awaddr <= x"0000" &  std_logic_vector(fpa_img_info_i.frame_id(7 downto 0)) &  std_logic_vector(resize(FWPositionAdd32, 8));
                        axil_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(ACQ_FILTER_NUMBER), 32), FWPositionShift));
                        axil_mosi_i.wstrb <= FWPositionBWE;
                        axil_mosi_i.awvalid <= '1';
                        axil_mosi_i.wvalid <= '1';
                        write_state <= wait_write_completed;
                        next_write_state <= wr_enc_end;
                    end if;
        
                
                when wr_enc_end =>
                    axil_mosi_i.awaddr <= x"FFFF" &  std_logic_vector(fpa_img_info_i.frame_id(7 downto 0)) &  std_logic_vector(resize(FWEncoderAtExposureEndAdd32, 8));
                    axil_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(FALLING_POSITION) ,32), FWEncoderAtExposureEndShift));
                    axil_mosi_i.wstrb <= FWEncoderAtExposureEndBWE;
                    axil_mosi_i.awvalid <= '1';
                    axil_mosi_i.wvalid <= '1';
                    write_state <= wait_write_completed;
                    next_write_state <= write_standby;
                  
                    
                when wait_write_completed =>
                    if axil_miso_i.awready = '1' and axil_miso_i.wready = '1' then
                        axil_mosi_i.awvalid <= '0';
                        axil_mosi_i.wvalid <= '0';
                        axil_mosi_i.wstrb <= (others => '0');
                    else
                        axil_mosi_i.wdata <= axil_mosi_i.wdata;
                        axil_mosi_i.awaddr <= axil_mosi_i.awaddr;
                        axil_mosi_i.awvalid <= axil_mosi_i.awvalid;
                        axil_mosi_i.wvalid <= axil_mosi_i.wvalid;
                        axil_mosi_i.wstrb <= axil_mosi_i.wstrb;
                    end if;
                    
                    if axil_miso_i.bvalid = '1' then
                        write_state <= next_write_state;
                        --axil_mosi_i.bready <= '0';
                    else
                        write_state <= write_state;
                        --axil_mosi_i.bready <= '1';
                    end if;
                    
                when others =>
                    write_state <= write_standby;
                    
            end case;
        end if;
    end if; 
end process Header_gen_process;
 
end RTL;

