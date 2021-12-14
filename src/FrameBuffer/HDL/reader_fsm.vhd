-------------------------------------------------------------------------------
--
-- Title       : read_fsm
-- Design      : tb_frame_buffer
-- Author      : Philippe Couture   
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\read_fsm.vhd
-- Generated   : Mon Aug 10 13:21:08 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.TEL2000.all;
use work.fb_define.all;

entity reader_fsm is
   Port ( 
   
    CLK                       : in STD_LOGIC;    --CLK_DATA
    ARESETN                   : in STD_LOGIC; 
    
    FB_CFG                    : in frame_buffer_cfg_type;  
    READER_DONE               : out STD_LOGIC;
    
    AXIS_MM2S_CMD_MOSI        : out t_axi4_stream_mosi_cmd32;
    AXIS_MM2S_CMD_MISO        : in t_axi4_stream_miso;
        
    AXIS_MM2S_STS_MOSI        : in t_axi4_stream_mosi_status;
    AXIS_MM2S_STS_MISO        : out t_axi4_stream_miso;
    
    AXIS_MM2S_DATA_MOSI       : in t_axi4_stream_mosi64;
    AXIS_MM2S_DATA_MISO       : out t_axi4_stream_miso;
    
    AXIS_TX_DATA_MOSI         : out t_axi4_stream_mosi64;
    AXIS_TX_DATA_MISO         : in t_axi4_stream_miso;
    
    RD_BUFFER_STATUS          : in buffer_status_type;    
    RD_BUFFER_STATUS_UPDATE   : out STD_LOGIC;
    
    FLUSH                     : in STD_LOGIC;
    
    ERROR                     : out std_logic_vector(2 downto 0)
        
   );
end reader_fsm;

architecture reader_fsm of reader_fsm is

  component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;   
   
   component double_sync is
      generic(
         INIT_VALUE : bit := '0'
         );
      port(
         D     : in std_logic;
         Q     : out std_logic := '0';
         RESET : in std_logic;
         CLK   : in std_logic
         );
   end component;

   signal areset_i                  : std_logic; 
   signal sreset                    : std_logic;    
   signal fb_cfg_i                  : frame_buffer_cfg_type;
   signal eof                       : std_logic;
   signal done                      : std_logic;
   signal done_last                 : std_logic;
   signal dm_rdy                    : std_logic;
   signal force_tlast               : std_logic;
   signal buf_sts_update            : std_logic;
   signal pix_cnt                   : unsigned(31 downto 0);
   signal fval_cnt                  : unsigned(31 downto 0);
   signal sts_ack_i                 : std_logic;
   signal flush_i                   : std_logic;    
   signal buf_sts_i                 : buffer_status_type;
   signal mm2s_cmd_mosi             : t_axi4_stream_mosi_cmd32;
   signal mm2s_cmd_miso             : t_axi4_stream_miso;
   signal mm2s_sts_mosi             : t_axi4_stream_mosi_status;
   signal mm2s_sts_miso             : t_axi4_stream_miso;  
   signal mm2s_addr                 : std_logic_vector(31 downto 0) := (others => '0');
   signal mm2s_eof                  : std_logic := '0';
   signal mm2s_btt                  : std_logic_vector(22 downto 0) := (others => '0');
   signal mm2s_err_o                : std_logic_vector(2 downto 0); -- (SLVERR & DECERR & INTERR)

   type reader_sm_type is (standby_rd, wait_rd_cmd_ack, wait_buf_sts_update_ack, wait_eof, wait_fval_pause); 
   signal reader_sm                 : reader_sm_type; 
   
   type output_sm_type is (hdr_st, img_st); 
   signal output_sm                 : output_sm_type;
   
   type dm_sts_ack_sm_type is (idle_st, waiting_dm_sts_ack_st); 
   signal dm_sts_ack_sm                 : dm_sts_ack_sm_type;
                                  
begin      
   
   -- I/O Connections assignments
   areset_i                      <= not ARESETN; 
   flush_i                       <= FLUSH;
   RD_BUFFER_STATUS_UPDATE       <= buf_sts_update;
   ERROR                         <= mm2s_err_o;
   AXIS_MM2S_CMD_MOSI            <= mm2s_cmd_mosi;
   mm2s_cmd_miso                 <= AXIS_MM2S_CMD_MISO;
   mm2s_sts_mosi                 <= AXIS_MM2S_STS_MOSI;
   mm2s_cmd_mosi.TDATA           <= std_logic_vector(RSVD & TAG & mm2s_addr & DRR & mm2s_eof & DSA & CTYPE & mm2s_btt);
   AXIS_MM2S_DATA_MISO.TREADY    <= AXIS_TX_DATA_MISO.TREADY;
   AXIS_TX_DATA_MOSI.TDATA       <= AXIS_MM2S_DATA_MOSI.TDATA;  
   AXIS_TX_DATA_MOSI.TLAST       <= AXIS_MM2S_DATA_MOSI.TLAST when force_tlast = '0' else '1';
   
   AXIS_TX_DATA_MOSI.TSTRB       <= (others => '1');  
   AXIS_TX_DATA_MOSI.TKEEP       <= (others => '1');  
   AXIS_TX_DATA_MOSI.TDEST       <= (others => '0'); 
   AXIS_TX_DATA_MOSI.TUSER       <= (others => '0'); 
   AXIS_TX_DATA_MOSI.TVALID      <= AXIS_MM2S_DATA_MOSI.TVALID;
   READER_DONE                   <= done;
   fb_cfg_i                      <= FB_CFG when FB_CFG.dval = '1' else fb_cfg_default; 
      
   U0: sync_reset
   port map(ARESET => areset_i, CLK    => CLK, SRESET => sreset ); 
   
   U1: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => RD_BUFFER_STATUS.ack, Q => sts_ack_i, RESET => sreset, CLK => CLK ); 
   
   U2 : process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            buf_sts_i <= buf_sts_default;
         else    
            if sts_ack_i = '1' then 
               buf_sts_i <= RD_BUFFER_STATUS;
            else
               buf_sts_i <= buf_sts_i;
            end if;
         end if;     
      end if;
   end process;
   
   U3: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            reader_sm <= standby_rd;
            buf_sts_update <= '0';
            mm2s_addr <= (others => '0');
            mm2s_eof <='1'; 
            mm2s_btt <= (others => '0');
            mm2s_cmd_mosi.tvalid <= '0';
            fval_cnt <= (others => '0');
            done <= '0';
         else
            
               case reader_sm is 
                  when standby_rd => 
                     done <= '1';
                           
                     if buf_sts_i.full = '1' and dm_rdy = '1' and flush_i = '0' then
                        -- Wait for pointed buffer to have a complete frame available 
                        done <= '0';
                        -- Send cmd to data mover's read engine                     
                        mm2s_addr <= resize(std_logic_vector(buf_sts_i.pbuf), mm2s_addr'length);
                        mm2s_eof <=  '1';
                        mm2s_btt <= resize(std_logic_vector(fb_cfg_i.frame_byte_size),mm2s_btt'length); 
                        mm2s_cmd_mosi.tvalid <= '1';  
                        reader_sm <= wait_rd_cmd_ack; 
                     
                     end if;
                     
                  when wait_rd_cmd_ack =>
                     -- Wait for read cmd to be acknoledge by data mover
                     if mm2s_cmd_miso.tready = '1' then  
                        mm2s_cmd_mosi.tvalid <= '0';
                        reader_sm <= wait_eof;
                     end if;
                  
                  when wait_eof =>
                     -- Wait for the last pixel of the frame
                     if eof = '1' then
                       buf_sts_update <= '1';
                       reader_sm <= wait_buf_sts_update_ack;
                     end if;
                     
                  when wait_buf_sts_update_ack =>
                      -- Wait for the buffer manager to update current pointed buffer status & read pointer 
                      if sts_ack_i = '1' then
                         buf_sts_update <= '0';               
                         reader_sm <= wait_fval_pause;
                     end if;

                  when wait_fval_pause => 
                     if fval_cnt >= fb_cfg_i.fval_pause_min then 
                       done <= '1';
                       fval_cnt <= (others => '0');
                       reader_sm <= standby_rd;
                     else
                       fval_cnt <= fval_cnt + 1;
                     end if;
                     
                  when others =>
                  
               end case;
         end if;
         
      end if;     
   end process;    

   -- This process reconstruct the AXI-STREAM signals : 
       --> TID (1 = hdr, 0 = img)
       --> TLAST associated with end of header.
   U4: process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            output_sm <= hdr_st;
            pix_cnt <= (others => '0');
            eof <= '0';
            AXIS_TX_DATA_MOSI.TID(0) <= '1'; 
         else 
            
               case output_sm is 
                  
                  when hdr_st =>
                     AXIS_TX_DATA_MOSI.TID(0) <= '1'; 
                     eof <= '0';  
                     force_tlast <= '0';
                     if pix_cnt = (fb_cfg_i.hdr_pix_size-8) then
                        force_tlast <= '1'; 
                        pix_cnt <= (others => '0');
                        output_sm <= img_st;
                     elsif AXIS_TX_DATA_MISO.TREADY = '1' and AXIS_MM2S_DATA_MOSI.TVALID = '1' then 
                        pix_cnt <= pix_cnt + PIXEL_WIDTH;
                     end if;   

                  when img_st =>  
                     AXIS_TX_DATA_MOSI.TID(0) <= '0';
                     force_tlast <= '0';
                     if pix_cnt = (fb_cfg_i.img_pix_size) then
                        eof <= '1';
                        pix_cnt <= (others => '0');
                        output_sm <= hdr_st;
                     elsif AXIS_TX_DATA_MISO.TREADY = '1' and AXIS_MM2S_DATA_MOSI.TVALID = '1' then 
                        pix_cnt <= pix_cnt + PIXEL_WIDTH;
                     end if;  
                     
                  when others =>
                  
               end case;               
         end if;     
      end if;
   end process;
   
   
   -- This process ensure that the data mover is ready to receive a new command.
   -- It is appart from the main fsm because the eof can happen before or after 
   -- the status ack is generated by the data mover.
   U5 : process(CLK)
   begin
       if rising_edge(CLK) then
            if sreset = '1' then
               done_last <= '0';
               dm_rdy   <= '1';
               AXIS_MM2S_STS_MISO.tready <= '0';
            else                 
               
               done_last <= done;
               
               case dm_sts_ack_sm is 
                  
                  when idle_st =>       
                     
                     if done = '0' and done_last = '1' then
                        dm_rdy   <= '0';
                        AXIS_MM2S_STS_MISO.tready <= '1';
                        dm_sts_ack_sm <= waiting_dm_sts_ack_st;
                     end if;
                     
                  when waiting_dm_sts_ack_st =>
                     
                     if AXIS_MM2S_STS_MOSI.tvalid = '1' then 
                        AXIS_MM2S_STS_MISO.tready <= '0';
                        dm_rdy   <= '1';
                        dm_sts_ack_sm <= idle_st;
                     end if;
                     
                  when others =>  
                  
               end case;
            end if;
       end if;
   end process;                 
   
   U6 : process(CLK)
   begin
       if rising_edge(CLK) then
            if sreset = '1' then
               mm2s_err_o <= (others => '0');
            else
               if( mm2s_sts_mosi.tvalid = '1') then

                   if(mm2s_sts_mosi.tdata(6 downto 4) /= "000") then
                       mm2s_err_o(2 downto 0) <= mm2s_sts_mosi.tdata(6 downto 4);
                   end if;
               else
                   mm2s_err_o <= mm2s_err_o;
               end if;
            end if;
       end if;
   end process;
   
end reader_fsm;
