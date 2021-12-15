-------------------------------------------------------------------------------
--
-- Title       : fb_manager
-- Design      : tb_frame_buffer
-- Author      : Philippe Couture   
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\fb_manager.vhd
-- Generated   : Mon Aug 10 13:19:09 2020
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
use work.fbuffer_define.all;

entity fb_manager is

   Port ( 
   
    CLK                          : in STD_LOGIC;
    ARESETN                      : in STD_LOGIC; 
    
    USER_CFG                     : in frame_buffer_cfg_type;
    FB_CFG                       : out frame_buffer_cfg_type;
    STALL_WRITER                 : out STD_LOGIC;
    
    
    RD_BUFFER_STATUS             : out buffer_status_type;
    RD_BUFFER_STATUS_UPDATE      : in STD_LOGIC;
        
    WR_BUFFER_STATUS             : out buffer_status_type;
    WR_BUFFER_STATUS_UPDATE      : in STD_LOGIC;                 

    READER_DONE                  : in STD_LOGIC;
    WRITER_DONE                  : in STD_LOGIC;
    
    FLUSH                        : out STD_LOGIC;
    
    STATUS                       : out std_logic_vector(7 downto 0)
    
   );

end fb_manager;

architecture fb_manager of fb_manager is
  
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
   
   component gh_stretch 
	GENERIC (stretch_count: integer :=1023);
	 port(
		 CLK : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 D : in STD_LOGIC;
		 Q : out STD_LOGIC
	     );
   end component;

   signal areset_i             : std_logic; 
   signal sreset               : std_logic;    
   signal fb_cfg_i             : frame_buffer_cfg_type;
   signal cfg_dval_last        : std_logic;
   signal reader_rqst          : std_logic;
   signal writer_rqst          : std_logic;
   signal reader_rqst_last     : std_logic;
   signal writer_rqst_last     : std_logic;
   signal wr_buffer_status_i   : buffer_status_type;
   signal rd_buffer_status_i   : buffer_status_type; 
   signal wr_sts_ack_i         : std_logic;
   signal rd_sts_ack_i         : std_logic;
   signal wr_sts_ack_o         : std_logic;
   signal rd_sts_ack_o         : std_logic; 
   signal flush_i              : std_logic;
   signal next_rd_buffer       : std_logic_vector(rd_buffer_status_i.pbuf'LENGTH - 1 downto 0);
   signal next_wr_buffer       : std_logic_vector(wr_buffer_status_i.pbuf'LENGTH - 1 downto 0);
   signal buffer_full_sts      : std_logic_vector(2 downto 0);
   signal reader_done_i        : std_logic;
   signal writer_done_i        : std_logic;
   signal cfg_updater_rqst     : std_logic;
   signal init_cfg_done        : std_logic;
   signal cfg_update_done      : std_logic;
   signal cfg_update_done_last : std_logic;
   signal cnt                  : unsigned(3 downto 0);
   signal reader_rqst_latch    : std_logic;
   signal writer_rqst_latch    : std_logic;
   signal reader_rqst_latch_o  : std_logic; 
   signal writer_rqst_latch_o  : std_logic;
   
   type cfg_updater_sm_type is (idle_st, wait_empty_fb_st, cfg_updater_rqst_st); 
   signal cfg_updater_sm             : cfg_updater_sm_type;
   
   type reader_rqst_sm_type is (idle_st, wait_ack_st); 
   signal reader_rqst_sm             : reader_rqst_sm_type;
   
   type writer_rqst_sm_type is (idle_st, wait_ack_st); 
   signal writer_rqst_sm             : writer_rqst_sm_type; 
   
begin    
   
   areset_i         <= not ARESETN; 
   reader_rqst      <= RD_BUFFER_STATUS_UPDATE;
   writer_rqst      <= WR_BUFFER_STATUS_UPDATE; 
   RD_BUFFER_STATUS <= rd_buffer_status_i;
   WR_BUFFER_STATUS <= wr_buffer_status_i;
   STALL_WRITER     <= not (cfg_update_done and init_cfg_done);
   FB_CFG           <= fb_cfg_i;
   FLUSH            <= flush_i;
   STATUS           <= "000" & buffer_full_sts & cfg_update_done & init_cfg_done;

   U0: sync_reset
   port map(ARESET => areset_i, CLK    => CLK, SRESET => sreset ); 
  
   U1A: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => READER_DONE, Q    => reader_done_i, RESET => sreset, CLK => CLK ); 
   
   U1B: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => WRITER_DONE, Q    => writer_done_i, RESET => sreset, CLK => CLK ); 
   
   rd_sts_ack_o <= rd_sts_ack_i or (not init_cfg_done) or (cfg_update_done and not cfg_update_done_last);
   U2A: gh_stretch
   generic map (stretch_count => 4)
   port map(CLK => CLK, rst => sreset, D => rd_sts_ack_o, Q => rd_buffer_status_i.ack);
   
   wr_sts_ack_o <= wr_sts_ack_i or (not init_cfg_done) or (cfg_update_done and not cfg_update_done_last);
   U2B: gh_stretch
   generic map (stretch_count => 4)
   port map(CLK => CLK, rst => sreset, D => wr_sts_ack_o, Q => wr_buffer_status_i.ack);
   
   next_rd_buffer <= fb_cfg_i.buffer_b_addr when rd_buffer_status_i.pbuf = fb_cfg_i.buffer_a_addr else
                     fb_cfg_i.buffer_c_addr when rd_buffer_status_i.pbuf = fb_cfg_i.buffer_b_addr else
                     fb_cfg_i.buffer_a_addr when rd_buffer_status_i.pbuf = fb_cfg_i.buffer_c_addr else
                     fb_cfg_i.buffer_a_addr; 
                     
   next_wr_buffer <= fb_cfg_i.buffer_b_addr when wr_buffer_status_i.pbuf = fb_cfg_i.buffer_a_addr else
                     fb_cfg_i.buffer_c_addr when wr_buffer_status_i.pbuf = fb_cfg_i.buffer_b_addr else
                     fb_cfg_i.buffer_a_addr when wr_buffer_status_i.pbuf = fb_cfg_i.buffer_c_addr else
                     fb_cfg_i.buffer_a_addr; 
   
                     
   reader_rqst_latch_o <= reader_rqst_latch and not rd_sts_ack_i;                
   U3A: process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            reader_rqst_last <= '1';
            reader_rqst_latch <= '0';
         else 
            reader_rqst_last <= reader_rqst;
            case reader_rqst_sm is 
               
               when idle_st =>
                  if reader_rqst = '1' and reader_rqst_last = '0' then
                     reader_rqst_latch <= '1';
                     reader_rqst_sm <= wait_ack_st;
                  end if;   
   
               when wait_ack_st =>  
                  if rd_sts_ack_i = '1' then
                     reader_rqst_latch <= '0';
                     reader_rqst_sm <= idle_st;
                  end if;  
                  
               when others =>
               
            end case;               
         end if;     
      end if;
   end process;
   
   writer_rqst_latch_o <= writer_rqst_latch and not wr_sts_ack_i;
   U3B: process(CLK)        
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            writer_rqst_last <= '1';
            writer_rqst_latch <= '0';
         else 
            writer_rqst_last <= writer_rqst;
            case writer_rqst_sm is 
               
               when idle_st =>
                  if writer_rqst = '1' and writer_rqst_last = '0' then
                     writer_rqst_latch <= '1';
                     writer_rqst_sm <= wait_ack_st;
                  end if;   

               when wait_ack_st =>  
                  if wr_sts_ack_i = '1' then
                     writer_rqst_latch <= '0';
                     writer_rqst_sm <= idle_st;
                  end if;  
                  
               when others =>
               
            end case;               
         end if;     
      end if;
   end process;   
   
   U4: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            buffer_full_sts <= (others => '0');
            rd_buffer_status_i.pbuf <= (others => '0');
            rd_buffer_status_i.full <= '0';
            wr_buffer_status_i.pbuf <= (others => '0');
            wr_buffer_status_i.full <= '0';
            wr_sts_ack_i <= '0';
            rd_sts_ack_i <= '0';
            
         else              

            wr_sts_ack_i <= '0';
            rd_sts_ack_i <= '0'; 
            
            if reader_rqst_latch_o = '1' then
               -- update current buffers status
               if rd_buffer_status_i.pbuf = fb_cfg_i.buffer_a_addr then
                  buffer_full_sts(BUFFER_A_IDX) <=  '0'; 
                  if wr_buffer_status_i.pbuf = fb_cfg_i.buffer_a_addr then
                     wr_buffer_status_i.full <= '0';
                     wr_sts_ack_i <= '1';
                  end if;
               elsif rd_buffer_status_i.pbuf = fb_cfg_i.buffer_b_addr then
                  buffer_full_sts(BUFFER_B_IDX) <=  '0';
                  if wr_buffer_status_i.pbuf = fb_cfg_i.buffer_b_addr then
                     wr_buffer_status_i.full <= '0';
                     wr_sts_ack_i <= '1';
                  end if;                     
               elsif rd_buffer_status_i.pbuf = fb_cfg_i.buffer_c_addr then 
                  buffer_full_sts(BUFFER_C_IDX) <=  '0';
                  if wr_buffer_status_i.pbuf = fb_cfg_i.buffer_c_addr then
                     wr_buffer_status_i.full <= '0';
                     wr_sts_ack_i <= '1';
                  end if;                     
               end if;

               -- update reader to next buffer status
               if next_rd_buffer = fb_cfg_i.buffer_a_addr then
                  rd_buffer_status_i.full <= buffer_full_sts(BUFFER_A_IDX);
               elsif next_rd_buffer = fb_cfg_i.buffer_b_addr then
                  rd_buffer_status_i.full <= buffer_full_sts(BUFFER_B_IDX);
               elsif next_rd_buffer = fb_cfg_i.buffer_c_addr then
                  rd_buffer_status_i.full <= buffer_full_sts(BUFFER_C_IDX);                      
               end if;     
               
               rd_buffer_status_i.pbuf <= next_rd_buffer; 
               rd_sts_ack_i <= '1';
               
            elsif writer_rqst_latch_o = '1' then 
               
               -- update current buffer status
               if wr_buffer_status_i.pbuf = fb_cfg_i.buffer_a_addr then
                  buffer_full_sts(BUFFER_A_IDX) <=  '1';
                  if rd_buffer_status_i.pbuf = fb_cfg_i.buffer_a_addr then
                     rd_buffer_status_i.full <= '1';
                     rd_sts_ack_i <= '1';
                  end if;
               elsif wr_buffer_status_i.pbuf = fb_cfg_i.buffer_b_addr then
                  buffer_full_sts(BUFFER_B_IDX) <=  '1';
                  if rd_buffer_status_i.pbuf = fb_cfg_i.buffer_b_addr then
                     rd_buffer_status_i.full <= '1';
                     rd_sts_ack_i <= '1';
                  end if; 
               elsif wr_buffer_status_i.pbuf = fb_cfg_i.buffer_c_addr then
                  buffer_full_sts(BUFFER_C_IDX) <=  '1';
                  if rd_buffer_status_i.pbuf = fb_cfg_i.buffer_c_addr then
                     rd_buffer_status_i.full <= '1';
                     rd_sts_ack_i <= '1';
                  end if;
               end if;
               
               -- update reader to next buffer status
               if next_wr_buffer = fb_cfg_i.buffer_a_addr then
                  wr_buffer_status_i.full <= buffer_full_sts(BUFFER_A_IDX); 
               elsif next_wr_buffer = fb_cfg_i.buffer_b_addr then
                  wr_buffer_status_i.full <= buffer_full_sts(BUFFER_B_IDX); 
               elsif next_wr_buffer = fb_cfg_i.buffer_c_addr then
                  wr_buffer_status_i.full <= buffer_full_sts(BUFFER_C_IDX);                      
               end if;
               
               wr_buffer_status_i.pbuf <= next_wr_buffer; 
               wr_sts_ack_i <= '1';
               
            elsif cfg_updater_rqst = '1' then  
               rd_buffer_status_i.pbuf <= fb_cfg_i.buffer_a_addr;
               wr_buffer_status_i.pbuf <= fb_cfg_i.buffer_a_addr;
               if flush_i = '1' then
                  rd_buffer_status_i.full <= '0';
                  wr_buffer_status_i.full <= '0';
                  buffer_full_sts <= (others => '0'); 
               end if;
               
            end if; 
         end if;
      end if;     
   end process; 

   U5: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            cfg_update_done <= '0'; 
            cfg_updater_rqst <= '0';
            fb_cfg_i <= fb_cfg_default;
            cfg_updater_sm <= idle_st; 
            cfg_dval_last <= '0'; 
            init_cfg_done <= '0';
            cfg_update_done_last <= '0';
            flush_i <= '0';
            cnt <= (others => '0');
         else              
            
            cfg_dval_last <= USER_CFG.dval;
            cfg_update_done_last <= cfg_update_done;
            
            case cfg_updater_sm is 
               when idle_st => 
                  fb_cfg_i <= fb_cfg_i;
                  cfg_update_done <= '1';
                  flush_i <= '0';
                  if USER_CFG.dval = '1' and cfg_dval_last = '0' then 
                     cfg_update_done <= '0';
                     if USER_CFG.flush = '1' then
                        flush_i <= '1';
                     end if;
                     cfg_updater_sm <= wait_empty_fb_st;    
                  end if;  
               
               when wait_empty_fb_st => 
                  if (buffer_full_sts =  "000" or flush_i = '1') and reader_done_i = '1' and writer_done_i = '1' then 
                     cfg_updater_rqst <= '1';
                     fb_cfg_i <= USER_CFG;
                     cnt <= (others => '0');
                     cfg_updater_sm <= cfg_updater_rqst_st;
                  end if; 
                  
               when cfg_updater_rqst_st =>
                  cfg_updater_rqst <= '0';
                  init_cfg_done <= '1'; -- configuration needed at least once to be able to use the frame buffer. 
                  cnt <= cnt + 1;
                  if cnt > 10 then -- give time to process request before releasing the writer and/or reader
                     cfg_updater_sm <= idle_st; 
                  end if;
                  
               when others =>    
                  
            end case;      
         end if;
         
      end if;     
   end process;

end fb_manager;
