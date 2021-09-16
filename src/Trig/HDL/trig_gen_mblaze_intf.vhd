------------------------------------------------------------------
--!   @file : trig_gen_mblaze_intf
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
use work.tel2000.all;
use work.trig_define.all;
use work.min_max_define.all;

entity trig_gen_mblaze_intf is
   port(
      
      ARESET                    : in std_logic;
      CLK                       : in std_logic;
      
      STATUS                    : in std_logic_vector(15 downto 0);
      POSIX_TIME                : in POSIX_time_type;
      
      MB_MOSI                   : in t_axi4_lite_mosi;
      MB_MISO                   : out t_axi4_lite_miso;
      
      PPS_SOURCE                : out std_logic; 
      
      FPA_EXP_INFO              : in exp_info_type;
      TRIG_CFG                  : out trig_cfg_type;
      RESET_ERR                 : out std_logic;
      MB_OVERWRITE              : out std_logic;
      MB_TIME_SEC               : out std_logic_vector(31 downto 0);
      START_PPS_PERMIT_WINDW    : out std_logic;
      PPS_TIMEOUT_RE            : in std_logic;
      MB_TIME_SUBSEC            : out std_logic_vector(23 downto 0);
	  
	   SEQ_SOFTTRIG				  : out std_logic;
      
      
      TRIG_DELAY_MIN       : in STD_LOGIC_VECTOR(31 downto 0);
      TRIG_DELAY_MAX       : in STD_LOGIC_VECTOR(31 downto 0);
      
      TRIG_PERIOD_MIN           : in  array8_slv32;
      TRIG_PERIOD_MAX           : in  array8_slv32
      );
end trig_gen_mblaze_intf;

architecture rtl of trig_gen_mblaze_intf is
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;      
   
   -- misc signals
   signal control_i                 : std_logic_vector(MB_MOSI.WDATA'length-1 downto 0);
   signal sreset                    : std_logic; 
   signal trig_cfg_i                : trig_cfg_type;   -- sur domaine ppclk
   signal trig_cfg_o                : trig_cfg_type;   -- sur domaine adc_clk
   
   signal reset_err_i               : std_logic;          -- sur domaine ppclk
   signal trig_ctler_done           : std_logic;                         
   
   signal mb_time_sec_i             : std_logic_vector(31 downto 0) := (others => '0');
   signal mb_time_subsec_i          : std_logic_vector(23 downto 0) := (others => '0');
   signal mb_overwrite_i            : std_logic;   
   signal start_pps_permit_windw_i  : std_logic;
   signal trig_high_time_i          : unsigned(31 downto 0);
   
   --   signal posix_seconds             : std_logic_vector(31 downto 0);
   --   signal posix_subseconds          : std_logic_vector(23 downto 0);
   
   --   signal pps_timeout_i					: std_logic;
   
   signal axi_awaddr	               : std_logic_vector(31 downto 0);
   signal axi_awready	            : std_logic;
   signal axi_wready	               : std_logic;
   signal axi_bresp	               : std_logic_vector(1 downto 0);
   signal axi_bvalid	               : std_logic;
   signal axi_araddr	               : std_logic_vector(31 downto 0);
   signal axi_arready	            : std_logic;
   signal axi_rdata	               : std_logic_vector(31 downto 0);
   signal axi_rresp	               : std_logic_vector(1 downto 0);
   signal axi_rvalid	               : std_logic;
   signal data_i, data_o            : std_logic_vector(31 downto 0);
   
   signal slv_reg_rden	            : std_logic;
   signal slv_reg_wren	            : std_logic; 
   signal pps_source_i              : std_logic;
   signal seq_softtrig_i            : std_logic;
   
   -- Keep signals so that the attribute TIG can be attributed to them in the xcf file.
   attribute keep : string;                                   
   attribute keep of trig_cfg_i : signal is "true";              
   
begin
   SEQ_SOFTTRIG <= seq_softtrig_i;
   
   -- I/O Connections assignments
   MB_MISO.AWREADY  <= axi_awready;
   MB_MISO.WREADY   <= axi_wready;
   MB_MISO.BRESP	  <= axi_bresp;
   MB_MISO.BVALID   <= axi_bvalid;
   MB_MISO.ARREADY  <= axi_arready;
   MB_MISO.RDATA	  <= axi_rdata;
   MB_MISO.RRESP	  <= axi_rresp;
   MB_MISO.RVALID   <= axi_rvalid;
   
   MB_OVERWRITE            <= mb_overwrite_i;
   MB_TIME_SEC             <= mb_time_sec_i;
   START_PPS_PERMIT_WINDW  <= start_pps_permit_windw_i;
   MB_TIME_SUBSEC          <=mb_time_subsec_i;
   
   -- qques output maps
   TRIG_CFG <= trig_cfg_o;
   RESET_ERR <= reset_err_i;
   PPS_SOURCE <= pps_source_i;
   
   -- ques input maps
   U1 : process(CLK)
   begin
      if rising_edge(CLK) then
         trig_ctler_done <= STATUS(0);
      end if;
   end process;
   
   ----------------------------------------------------------------------------
   --  synchro reset
   ----------------------------------------------------------------------------
   U2: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      ); 
   
   ----------------------------------------------------------------------------
   -- sortie des nouvelles configurations                                          
   ----------------------------------------------------------------------------
   U3: process(CLK)
   begin  			
      if rising_edge(CLK) then
         if sreset = '1' then
            trig_cfg_o <= trig_cfg_default;	            
         else 
            
            -- changement en live du acq_window
            trig_cfg_o.acq_window <= trig_cfg_i.acq_window;     -- le soin est donner au contrôleur de savoir quand rendre cela effectif
            
            -- trig_cfg à sortir si run = '1' et si aucune activité dans le bloc
            -- cela suppose un arrêt au préalable de la part du µblaze	
            trig_cfg_o.run <= trig_cfg_i.run;  -- il le faut afin d'arrêter le bloc 
            if trig_ctler_done = '1' and trig_cfg_i.run = '1' then  
               trig_cfg_o <= trig_cfg_i;
            end if;	
            
            -- changement en live du HighTime des trigs
            if FPA_EXP_INFO.EXP_DVAL = '1' then 
               trig_cfg_o.high_time <= FPA_EXP_INFO.EXP_TIME;   -- trig_cfg_i.high_time;     -- le soin est donné au contrôleur de savoir quand rendre cela effectif
            end if;
            
         end if;
      end if;
   end process;	 
   
   ----------------------------------------------------------------------------
   -- RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U4: process (CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            axi_arready <= '0';
            axi_araddr  <= (others => '1');
            axi_rvalid <= '0';
            axi_rresp  <= "00";
         else
            
            if axi_arready = '0' and MB_MOSI.ARVALID = '1' then
               -- indicates that the slave has acceped the valid read address
               axi_arready <= '1';
               -- Read Address latching 
               axi_araddr  <= MB_MOSI.ARADDR;
            else
               axi_arready <= '0';
            end if;
            
            if axi_arready = '1' and MB_MOSI.ARVALID = '1' and axi_rvalid = '0' then
               -- Valid read data is available at the read data bus
               axi_rvalid <= '1';
               axi_rresp  <= "00"; -- 'OKAY' response
            elsif axi_rvalid = '1' and MB_MOSI.RREADY = '1' then
               -- Read data is accepted by the master
               axi_rvalid <= '0';
            end if;
            
         end if;
      end if;
   end process; 
   slv_reg_rden <= axi_arready and MB_MOSI.ARVALID and (not axi_rvalid);
   
   ---------------------------------------------------------------------------- 
   -- RD : données vers µBlaze                                       
   ---------------------------------------------------------------------------- 
   U5: process(CLK)
   begin
      if rising_edge(CLK) then
         
         case axi_araddr(7 downto 0) is
            -- cfg feedback: partie trigger
            when X"00" => axi_rdata <= resize(trig_cfg_i.mode, 32);
            when X"04" => axi_rdata <= resize(std_logic_vector(trig_cfg_i.period), 32); 
            when X"08" => axi_rdata <= resize(std_logic_vector(trig_cfg_i.fpatrig_dly), 32);
            when X"0C" => axi_rdata <= resize('0'& trig_cfg_i.force_high, 32) ;
            when X"10" => axi_rdata <= resize(trig_cfg_i.trig_activ,32);
            when X"14" => axi_rdata <= resize('0'& trig_cfg_i.acq_window, 32);
            when X"18" => axi_rdata <= resize(std_logic_vector(trig_cfg_i.seq_framecount), 32);
            when X"1C" => axi_rdata <= resize('0'& trig_cfg_i.seq_trigsource, 32);
            
            when X"40" => axi_rdata <= resize('0'& PPS_TIMEOUT_RE,32);			
               
            -- 	cfg feedback: partie control	
            when X"C0" => axi_rdata <= resize(control_i, 32);  
               
            -- demande du temps reel
            when X"D0" => axi_rdata <= std_logic_vector(POSIX_TIME.Seconds);
            when X"D4" => axi_rdata <= std_logic_vector(resize(POSIX_TIME.SubSeconds, 32));
            
            when X"50" => axi_rdata <= resize(STATUS,32);					--
            
            when X"54" => axi_rdata <= resize(TRIG_PERIOD_MIN(0),32);
            when X"58" => axi_rdata <= resize(TRIG_PERIOD_MAX(0),32);
            when X"5C" => axi_rdata <= resize(TRIG_PERIOD_MIN(1),32);
            when X"60" => axi_rdata <= resize(TRIG_PERIOD_MAX(1),32);
            when X"64" => axi_rdata <= resize(TRIG_PERIOD_MIN(2),32);
            when X"68" => axi_rdata <= resize(TRIG_PERIOD_MAX(2),32);
            when X"6C" => axi_rdata <= resize(TRIG_PERIOD_MIN(3),32);
            when X"70" => axi_rdata <= resize(TRIG_PERIOD_MAX(3),32);
            when X"74" => axi_rdata <= resize(TRIG_PERIOD_MIN(4),32);
            when X"78" => axi_rdata <= resize(TRIG_PERIOD_MAX(4),32);
            when X"7C" => axi_rdata <= resize(TRIG_PERIOD_MIN(5),32);
            when X"80" => axi_rdata <= resize(TRIG_PERIOD_MAX(5),32);
            when X"84" => axi_rdata <= resize(TRIG_PERIOD_MIN(6),32);
            when X"88" => axi_rdata <= resize(TRIG_PERIOD_MAX(6),32);
            when X"8C" => axi_rdata <= resize(TRIG_PERIOD_MIN(7),32);
            when X"90" => axi_rdata <= resize(TRIG_PERIOD_MAX(7),32);
            
            when X"94" => axi_rdata <= resize(TRIG_DELAY_MIN,32);
            when X"98" => axi_rdata <= resize(TRIG_DELAY_MAX,32);
			
            -- pps source
            when X"E0" => axi_rdata <= resize('0' & pps_source_i,32);

            when others=> axi_rdata <= (others =>'1');
         end case;        
      end if;     
   end process;   
   
   ----------------------------------------------------------------------------
   -- WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U6: process (CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            axi_awready <= '0'; 
            axi_wready <= '0';
         else 
            
            if (axi_awready = '0' and MB_MOSI.AWVALID = '1' and MB_MOSI.WVALID = '1') then
               axi_awready <= '1';
               axi_awaddr <= MB_MOSI.AWADDR;
            else
               axi_awready <= '0';
            end if;
            
            if (axi_wready = '0' and MB_MOSI.WVALID = '1' and MB_MOSI.AWVALID = '1') then
               axi_wready <= '1';
            else
               axi_wready <= '0';
            end if;
            
         end if;
      end if;
   end process;
   slv_reg_wren <= axi_wready and MB_MOSI.WVALID and axi_awready and MB_MOSI.AWVALID ;
   data_i <= MB_MOSI.WDATA;
   
   ----------------------------------------------------------------------------
   -- WR : reception configuration
   ----------------------------------------------------------------------------
   U7: process(CLK)        -- 
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            trig_cfg_i <= trig_cfg_default;  -- la config par defaut est faite de sorte à lancer les triggers en mode XTRA_TRIG
            mb_overwrite_i <= '0'; 
            start_pps_permit_windw_i <= '0';
            reset_err_i <= '0';
            mb_time_sec_i <= (others => '0');
            mb_time_subsec_i <= (others => '0');
            pps_source_i <= '0';
            seq_softtrig_i <= '0';
         else

            -- changement en live du HighTime des trigs
            if FPA_EXP_INFO.EXP_DVAL = '1' then 
               trig_cfg_i.high_time <= FPA_EXP_INFO.EXP_TIME;   -- trig_cfg_i.high_time;     -- le soin est donné au contrôleur de savoir quand rendre cela effectif
            end if;	
            
            if slv_reg_wren = '1' and MB_MOSI.WSTRB =  "1111" then -- Master write, toutes les transcations à 32 bits !!! comme dans IRCDEV 					
               case axi_awaddr(7 downto 0) is 
                  -- cfg partie trigger
                  when X"00" => trig_cfg_i.mode          <= data_i(trig_cfg_i.mode'length-1 downto 0);					
                  when X"04" => trig_cfg_i.period        <= unsigned(data_i(trig_cfg_i.period'length-1 downto 0)); 		
                  when X"08" => trig_cfg_i.fpatrig_dly   <= unsigned(data_i(trig_cfg_i.fpatrig_dly'length-1 downto 0));
                  when X"0C" => trig_cfg_i.force_high    <= data_i(0);
                  when X"10" => trig_cfg_i.trig_activ    <= data_i(trig_cfg_i.trig_activ'length-1 downto 0);
                  when X"14" => trig_cfg_i.acq_window    <= data_i(0);
                  when X"18" => trig_cfg_i.seq_framecount <= unsigned(data_i(trig_cfg_i.seq_framecount'length-1 downto 0)); 
                  when X"1C" => trig_cfg_i.seq_trigsource <= data_i(0);
                  when X"20" => seq_softtrig_i			  <= data_i(0);
                     
                  -- cfg partie stamper                  
                  when X"30" => mb_time_sec_i            <= data_i;
                  when X"34" => mb_time_subsec_i         <= data_i(23 downto 0);
                  when X"38" => mb_overwrite_i           <= data_i(0);   
                  when X"3C" => start_pps_permit_windw_i <= data_i(0); 

                  -- pps source
                  when X"E0" => pps_source_i             <= data_i(0); 
                  
                     
                  -- control
                  when X"C0" =>
                     control_i <=  data_i;
                     trig_cfg_i.RUN  <= data_i(0);	        -- CONTROL(0) =  run ou stop pour Trigger
                     reset_err_i <= data_i(1);			     -- CONTROL(1) = reset_error pour generateur de status
                  
                  when others => --do nothing
               end case;  
            else
               seq_softtrig_i <= '0';
            end if;
         end if;
      end if;
   end process;
   
   --------------------------------
   -- WR  : WR feedback envoyé au MB
   --------------------------------
   U8: process (CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            axi_bvalid  <= '0';
            axi_bresp   <= "00"; --need to work more on the responses
         else
            if slv_reg_wren = '1' and axi_bvalid = '0' then
               axi_bvalid <= '1';
               axi_bresp  <= "00"; 
            elsif MB_MOSI.BREADY = '1' and axi_bvalid = '1' then   --check if bready is asserted while bvalid is high)
               axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
            end if;
         end if;
      end if;
   end process;
   
end rtl;
