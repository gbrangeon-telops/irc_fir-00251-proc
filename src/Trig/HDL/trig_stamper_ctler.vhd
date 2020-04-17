------------------------------------------------------------------
--!   @file : trig_stamper_ctler
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.trig_define.all;
use work.tel2000.all;
use work.img_header_define.all;
use work.BufferingDefine.all;

entity trig_stamper_ctler is
   port(
      ARESET                  : in std_logic;
      CLK                     : in std_logic;		
      
      -- External very accurate 10MHz clock and PPS signal
      CLK_10M                 : in std_logic; -- 10 MHz clk enable
      PPS                     : in std_logic;  -- Not used for now. Will be used for synchro to GPS or IRIG-B     
      
      -- Signal from FPA which triggers the latching of a time stamp.
      FPA_IMG_INFO            : in img_info_type; 
      
      -- External trigger
      EXT_TRIG                : in std_logic;  
      
      -- Buffering  
      BUFFERING_FLAG          : in buffering_flag_type;
      BUFFERING_FLAG_UPDATE_DONE : out std_logic; 
      
      -- New time from MB
      MB_TIME_SEC             : in std_logic_vector(31 downto 0); -- New PowerPC POSIXTime 
      MB_TIME_SUBSEC          : in std_logic_vector(23 downto 0);
      MB_OVERWRITE            : in std_logic;  
      START_PPS_PERMIT_WINDW  : in std_logic;
      
      -- Live POSIX Time
      POSIX_TIME              : out POSIX_time_type;
      
      -- interface avec le module GPS/IRIG
      PPS_SYNC                : out std_logic;
      PPS_ACQ_WINDOW          : in std_logic ;     
      PPS_TIMEOUT_RE          : out std_logic;
      
      -- envoi de la partie du Header
      HDER_MOSI               : out t_axi4_lite_mosi;
      HDER_MISO               : in t_axi4_lite_miso       
      );
end trig_stamper_ctler;

architecture RTL of trig_stamper_ctler is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;      
   
   component gh_edge_det
      port(
         clk   : in STD_LOGIC;
         rst   : in STD_LOGIC;
         D     : in STD_LOGIC;
         re    : out STD_LOGIC;
         fe    : out STD_LOGIC;
         sre   : out STD_LOGIC;
         sfe   : out STD_LOGIC);
   end component;
   
   type fast_hder_sm_type is (idle, send_hder_st);
   signal fast_hder_sm              : fast_hder_sm_type; 
   type   buffering_flag_update_sm_type is (idle_st, moi_check_st);
   signal buffering_flag_update_sm  : buffering_flag_update_sm_type;

   signal sreset                    : std_logic;
   signal seconds_cnt               : unsigned(31 downto 0);
   signal subseconds_cnt            : unsigned(23 downto 0);
   signal subseconds_temp_cnt       : unsigned(23 downto 0);
   signal subseconds_wrap           : std_logic;
   signal exposure_feedbk           : std_logic;
   signal clk_10M_re                : std_logic;  -- Rising edge
   signal pps_re                    : std_logic;  -- Rising edge
   signal mb_overwrite_re           : std_logic;  -- Rising edge	
   signal exposure_feedbk_re        : std_logic;  -- Rising edge
   signal start_pps_permit_windw_re : std_logic;  -- Rising edge   
   signal ext_trig_sync             : std_logic;		  
   signal PPS_sync_i			         : std_logic; 
   signal permit_pps_overwrite      : std_logic;	  
   signal SnapShotSubseconds        : unsigned(23 downto 0); 
   signal PpsOccurrenceTimeOut_cnt  : unsigned(2 downto 0);
   signal PpsOccurrenceTimeOut      : std_logic;
   signal time_stamp_i              : POSIX_time_type;
   signal img_time_stamp_rdy        : std_logic;
   signal hder_mosi_i               : t_axi4_lite_mosi;
   signal hcnt                      : unsigned(7 downto 0);
   signal hder_link_rdy             : std_logic;
   signal frame_id                  : std_logic_vector(31 downto 0);
   signal buffering_flag_val_i      : std_logic_vector(BUFFERING_FLAG.val'range);
   signal buffering_flag_val_sync   : std_logic_vector(BUFFERING_FLAG.val'range);
   signal buffering_flag_update_done_i : std_logic;
   signal buffering_dval_re         : std_logic;

begin      
   
   HDER_MOSI <= hder_mosi_i;   
   POSIX_TIME.Seconds <= seconds_cnt;    
   POSIX_TIME.SubSeconds <= subseconds_cnt;
   PPS_SYNC <=  pps_sync_i;
   exposure_feedbk <= FPA_IMG_INFO.EXP_FEEDBK;
   hder_link_rdy <= HDER_MISO.WREADY and HDER_MISO.AWREADY;
   
   
   BUFFERING_FLAG_UPDATE_DONE <= buffering_flag_update_done_i;

   
   -- Detect various rising edges   
   E1 : gh_edge_det port map(clk => CLK, rst => sreset, D => CLK_10M, sre => clk_10M_re, re => open, fe => open, sfe => open);      
   E2 : gh_edge_det port map(clk => CLK, rst => sreset, D => MB_OVERWRITE, sre => mb_overwrite_re, re => open, fe => open, sfe => open);   
   E3 : gh_edge_det port map(clk => CLK, rst => sreset, D => exposure_feedbk, sre => exposure_feedbk_re, re => open, fe => open, sfe => open);
   E4 : gh_edge_det port map(clk => CLK, rst => sreset, D => PPS_sync_i, sre => pps_re, re => open, fe => open, sfe => open); 
   E5 : gh_edge_det port map(clk => CLK, rst => sreset, D => START_PPS_PERMIT_WINDW, sre => start_pps_permit_windw_re, re => open, fe => open, sfe => open); 
   E6 : gh_edge_det port map(clk => CLK, rst => sreset, D => BUFFERING_FLAG.dval, sre => buffering_dval_re, re => open, fe => open, sfe => open); 
   
   -----------------------------------------------------
   -- Synchronisation reset
   -----------------------------------------------------
   U1: sync_reset
   Port map(		
      ARESET   => ARESET,		
      SRESET   => sreset,
      CLK   => CLK);  
   
   -----------------------------------------------------------------
   -- Process to handle the permit window valid signal
   -----------------------------------------------------------------
   U2: process(CLK)
   begin		 
      if rising_edge(CLK) then
         if start_pps_permit_windw_re = '1' then
            -- Set "overwite permit" signal when requested by MB on each decoded valid NMEA RMC.
            permit_pps_overwrite <= '1';
            -- And take a snapshot of the subseconds counter.
            SnapShotSubseconds <= subseconds_cnt-1;
         elsif (SnapShotSubseconds = subseconds_cnt)or (pps_re = '1') then
            -- Clear "overwite permit" signal when one exact second TimeOut was expired(Subsecond counter
            -- wrapped to the same value we've snaped before), or a PPS was recieved. MB will set it back up 
            -- at the next valid NMEA RMC.
            permit_pps_overwrite <= '0';
         end if;
         
         -- Reset
         if sreset = '1' then
            permit_pps_overwrite <= '0';
            SnapShotSubseconds <= (others => '0');
         end if;         
      end if;
   end process; 
   
   -----------------------------------------------------------------
   -- Process to handle the permit window valid signal
   -----------------------------------------------------------------
   U3: process(CLK)
   begin		 
      if rising_edge(CLK) then   
         
         ext_trig_sync <= EXT_TRIG;
         PPS_sync_i	   <= PPS;	
         
         -- Default value
         subseconds_wrap <= '0';                           
         
         -- Manage subseconds counter
         if clk_10M_re = '1' then
            if subseconds_temp_cnt = 9_999_999 then -- Wrap to zero
               subseconds_temp_cnt <= (others => '0'); 
               subseconds_wrap <= '1';
            else   
               subseconds_temp_cnt <= subseconds_temp_cnt + 1;                
            end if;
         end if;                
         subseconds_cnt <= subseconds_temp_cnt; -- decalage de subseconds_temp_cnt de 1CLK pour synchro parfaite avec seconds_cnt
         
         -- Manage seconds counter
         if mb_overwrite_re = '1' or (permit_pps_overwrite = '1' and PPS_ACQ_WINDOW = '1' and pps_re = '1') then
            seconds_cnt <= unsigned(MB_TIME_SEC);
            subseconds_temp_cnt <= unsigned(MB_TIME_SUBSEC); 
         elsif subseconds_wrap = '1' then
            seconds_cnt <= seconds_cnt + 1;   
         end if; 
         
         -- Latching of time stamp
         if exposure_feedbk_re = '1' then
            time_stamp_i.Seconds <= seconds_cnt;    
            time_stamp_i.SubSeconds <= subseconds_cnt;
            frame_id <= std_logic_vector(FPA_IMG_INFO.FRAME_ID);
            buffering_flag_val_i <= buffering_flag_val_sync; 
            img_time_stamp_rdy <= '1';
         else
            img_time_stamp_rdy <= '0'; 
         end if;
         
         -- Reset
         if sreset = '1' then
            seconds_cnt <= (others => '0');   
            subseconds_temp_cnt <= (others => '0'); 
            subseconds_wrap <= '0';
            img_time_stamp_rdy <= '0'; 
         end if;          
         
      end if;      
   end process;                                                         

   ---------------------------------------------------------------------
   -- Process for PPS Time-out
   ---------------------------------------------------------------------
   U4: process(CLK)
   begin
      if rising_edge(CLK) then
         
         -- PPS timeout counter 
         if pps_re = '1' then
            PpsOccurrenceTimeOut_cnt <= (others=>'0');
            PpsOccurrenceTimeOut <= '0';
         elsif (subseconds_wrap = '1') then
            PpsOccurrenceTimeOut_cnt <= PpsOccurrenceTimeOut_cnt + 1;           
         end if;
         
         -- 3 subseconds_wrap pulse without having any PPS: 2 successive PPS missing
         if PpsOccurrenceTimeOut_cnt = "11" then
            PpsOccurrenceTimeOut <= '1';		          
         end if;
         
         -- Reset
         if sreset = '1' then						  
            PpsOccurrenceTimeOut <= '0';		   
            PpsOccurrenceTimeOut_cnt <= (others=>'0');
         end if;
      end if;		  
   end process;
   PPS_TIMEOUT_RE <= PpsOccurrenceTimeOut;   
   
   ---------------------------------------------------------------------
   -- Process for sending header Parts of the stamper
   ---------------------------------------------------------------------
   U5: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            hder_mosi_i.awvalid <= '0';
            hder_mosi_i.wvalid <= '0';
            hder_mosi_i.wstrb <= (others => '0');
            hder_mosi_i.awprot <= (others => '0');
            hder_mosi_i.arvalid <= '0';
            hder_mosi_i.bready <= '1';
            hder_mosi_i.rready <= '0';
            hder_mosi_i.arprot <= (others => '0');
            fast_hder_sm <= idle; 
         else
            
            -- sortie de la partie header fast provenant du module
            case fast_hder_sm is
               
               when idle =>
                  hder_mosi_i.awvalid <= '0';
                  hder_mosi_i.wvalid <= '0';
                  hder_mosi_i.wstrb <= (others => '0');
                  hcnt <= to_unsigned(1, hcnt'length);
                  if img_time_stamp_rdy = '1' then
                     fast_hder_sm <= send_hder_st;                     
                  end if;
               
               when send_hder_st =>
                  if hder_link_rdy = '1' then 
                     if hcnt = 1 then    -- Buffering Flag  
                        hder_mosi_i.awaddr <= x"0000" & frame_id(7 downto 0) & resize(BufferingFlagAdd32, 8);--
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(buffering_flag_val_i), 32), BufferingFlagShift));
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= BufferingFlagBWE; 
                        
                     elsif hcnt = 2 then -- Posix Time seconds
                        hder_mosi_i.awaddr <= x"0000" & frame_id(7 downto 0) & resize(POSIXTimeAdd32, 8);--
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <= std_logic_vector(time_stamp_i.Seconds);
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= POSIXTimeBWE;

                     elsif hcnt = 3 then -- Posix Time Subseconds et x"FFFF" pour signaler la fin
                        hder_mosi_i.awaddr <= x"FFFF" & frame_id(7 downto 0) & resize(SubSecondTimeAdd32, 8);--
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <= std_logic_vector(resize(time_stamp_i.SubSeconds, 32));
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= SubSecondTimeBWE;
                        fast_hder_sm <= idle;
                     end if;
                     hcnt <= hcnt + 1;
--                  else
--                     hder_mosi_i.awvalid <= '0';
--                     hder_mosi_i.wvalid <= '0';
                  end if;
               
               when others =>
               
            end case;               
            
         end if;       
      end if;		  
   end process;

   ---------------------------------------------------------------------
   -- Process to handle buffering flag update
   ---------------------------------------------------------------------
   U6: process(CLK)
   begin
      if rising_edge(CLK) then
      
         if sreset = '1' then  
            
            buffering_flag_update_sm <= idle_st;
            buffering_flag_val_sync <= NONE_FLAG;
            buffering_flag_update_done_i <= '1'; 
            
         else  
           
            case buffering_flag_update_sm is
            
               when idle_st => 
               
                  buffering_flag_update_done_i <= '1';
                  if buffering_dval_re = '1' then  
                     buffering_flag_update_done_i <= '0';
                     buffering_flag_val_sync <= BUFFERING_FLAG.val;
                     buffering_flag_update_sm <= moi_check_st;
                  end if;
                  
               when moi_check_st => 
               
                  
                     
                     if buffering_dval_re = '1' then 
                        buffering_flag_update_sm <= idle_st; 
                     elsif BUFFERING_FLAG.dval = '0' then
                        if buffering_flag_val_sync = MOI_FLAG then
                           if img_time_stamp_rdy = '1' then 
                              buffering_flag_update_sm <= idle_st;   
                           end if;
                        else 
                           buffering_flag_update_sm <= idle_st;
                        end if;
                     end if;     

               when others =>
            
            end case;
         end if;
      end if;		  
   end process;
   
   
end RTL;