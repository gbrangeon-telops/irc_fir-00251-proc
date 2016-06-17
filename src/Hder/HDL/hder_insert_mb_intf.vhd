------------------------------------------------------------------
--!   @file : hder_insert_mb_intf
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
use IEEE.STD_LOGIC_1164.all;           
use IEEE.numeric_std.ALL;
use work.hder_define.all;
use work.tel2000.all;

entity hder_insert_mb_intf is
   port(
      
      ARESETN       : in std_logic;
      MB_CLK        : in std_logic;
      TX_CLK        : in std_logic;
      FW_HDER_CLK   : in std_logic;
      TRIG_HDER_CLK : in std_logic;
      FPA_HDER_CLK  : in std_logic;
      EHDRI_HDER_CLK: in std_logic;
      CAL_HDER_CLK  : in std_logic;
      
      CONFIG        : out hder_insert_cfg_type;
      
      MB_MOSI       : in t_axi4_lite_mosi;
      MB_MISO       : out t_axi4_lite_miso;
      
      RAM_WR_ADD    : out std_logic_vector(5 downto 0);  -- sortie vers le port B de la block ram
      RAM_WR_DATA   : out std_logic_vector(31 downto 0); -- sortie vers le port B de la block ram
      RAM_BWE       : out std_logic_vector(3 downto 0);  -- sortie vers le port B de la block ram
      
      STATUS        : in std_logic_vector(11 downto 0);
      ERR           : out std_logic
      );
end hder_insert_mb_intf;


architecture rtl of hder_insert_mb_intf is
      
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;     
   
   component err_sync
      generic(
         STRETCH_CYCLES : NATURAL := 2);
      port(
         D : in STD_LOGIC;
         Q : out STD_LOGIC;
         ARESET : in STD_LOGIC;
         D_CLK : in STD_LOGIC;
         Q_CLK : in STD_LOGIC);
   end component;     
   
   component double_sync
      generic(
         INIT_VALUE : BIT := '0');
      port(
         D : in STD_LOGIC;
         Q : out STD_LOGIC;
         RESET : in STD_LOGIC;
         CLK : in STD_LOGIC);
   end component; 
   
   
   signal config_i             : hder_insert_cfg_type;
   signal areset               : std_logic;
   signal sreset               : std_logic;
   signal ehdri_hder_ovfl      : std_logic;
   signal din_ovfl             : std_logic;
   signal fw_hder_ovfl         : std_logic;
   signal trig_hder_ovfl       : std_logic;
   signal fpa_hder_ovfl        : std_logic;
   signal fw_hder_err          : std_logic;
   signal trig_hder_err        : std_logic;
   signal fpa_hder_err         : std_logic;
   signal ehdri_hder_ovfl_sync : std_logic;
   signal din_ovfl_sync        : std_logic;
   signal fw_hder_ovfl_sync    : std_logic;
   signal trig_hder_ovfl_sync  : std_logic;
   signal fpa_hder_ovfl_sync   : std_logic;
   signal fw_hder_err_sync     : std_logic;
   signal trig_hder_err_sync   : std_logic;
   signal fpa_hder_err_sync    : std_logic;
   
   signal sequencer_done       : std_logic;
   signal hdr_rx_mosi         : t_axi4_lite_mosi;
   
   signal axi_awaddr	          : std_logic_vector(31 downto 0);
   signal axi_awready	       : std_logic;
   signal axi_wready	          : std_logic;
   signal axi_bresp	          : std_logic_vector(1 downto 0);
   signal axi_bvalid	          : std_logic;
   signal axi_araddr	          : std_logic_vector(31 downto 0);
   signal axi_arready	       : std_logic;
   signal axi_rdata	          : std_logic_vector(31 downto 0);
   signal axi_rresp	          : std_logic_vector(1 downto 0);
   signal axi_rvalid	          : std_logic;
   signal axi_wstrb            : std_logic_vector(3 downto 0);
   signal data_i               : std_logic_vector(31 downto 0);
   signal slv_reg_rden	       : std_logic;
   signal slv_reg_wren	       : std_logic;
   signal control_i            : std_logic_vector(31 downto 0);
   signal status_to_mb         : std_logic_vector(15 downto 0);
   signal reset_err_i          : std_logic;
   signal error                : std_logic_vector(15 downto 0);
   signal error_latch          : std_logic_vector(15 downto 0);
   signal error_found          : std_logic;
   signal seq_status_spare     : std_logic;
   signal config_valid         : std_logic;
   signal cal_hder_ovfl        : std_logic;
   signal cal_hder_ovfl_sync   : std_logic;
   signal flagging_hder_ovfl        : std_logic;
   signal flagging_hder_ovfl_sync   : std_logic;
   
   signal ram_wr_add_i       : unsigned(ALEN_M1 downto 0);
   signal ram_wr_data_i      : std_logic_vector(31 downto 0);
   signal ram_bwe_i           : std_logic_vector(3 downto 0);
   
   -- attribute dont_touch        : string;                                   
   -- attribute dont_touch of config_i  : signal is "true";    
   -- attribute dont_touch of hdr_rx_mosi  : signal is "true";
   -- attribute dont_touch of ram_wr_add_i  : signal is "true";
   -- attribute dont_touch of ram_wr_data_i  : signal is "true";
   -- attribute dont_touch of ram_bwe_i  : signal is "true";
   
begin	
   
   -- I/O Connections assignments
   MB_MISO.AWREADY  <= axi_awready;
   MB_MISO.WREADY   <= axi_wready;
   MB_MISO.BRESP	  <= axi_bresp;
   MB_MISO.BVALID   <= axi_bvalid;
   MB_MISO.ARREADY  <= axi_arready;
   MB_MISO.RDATA	  <= axi_rdata;
   MB_MISO.RRESP	  <= axi_rresp;
   MB_MISO.RVALID   <= axi_rvalid;
   
   RAM_WR_ADD <= std_logic_vector(ram_wr_add_i);
   RAM_WR_DATA <= ram_wr_data_i;
   RAM_BWE <= ram_bwe_i;
   
   areset <= not ARESETN;
   
   ERR <= error_found;
   
   -- mapping statuts 
   flagging_hder_ovfl   <=  STATUS(11);
   cal_hder_ovfl     	<=  STATUS(10);
   ehdri_hder_ovfl   	<=  STATUS(9); 
   din_ovfl          	<=  STATUS(8); 
   fw_hder_ovfl      	<=  STATUS(7); 
   trig_hder_ovfl    	<=  STATUS(6); 
   fpa_hder_ovfl     	<=  STATUS(5); 
   seq_status_spare  	<=  STATUS(4); 
   fw_hder_err       	<=  STATUS(3); 
   trig_hder_err     	<=  STATUS(2); 
   fpa_hder_err      	<=  STATUS(1); 
   sequencer_done    	<=  STATUS(0);
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => MB_CLK,
      SRESET => sreset
      );
   
   ----------------------------------------------------------------------------
   --  SORTIE CONFIG : 
   ---------------------------------------------------------------------------- 
   UC:    -- 
      process(MB_CLK)
   begin  			
      if rising_edge(MB_CLK) then
         if sreset ='1' then
            CONFIG <= hder_insert_cfg_default;
         else
            --CONFIG.RUN <= config_i.run ;
            if sequencer_done = '1' and config_valid = '1' then 
               CONFIG <= config_i;	                
            end if;
         end if;
      end if;
   end process; 
   
   ----------------------------------------------------------------------------
   -- RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U3: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
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
   U4: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then         
         case axi_araddr(7 downto 0) is
            when X"00" => axi_rdata <= resize(std_logic_vector(config_i.eff_hder_len),32); 
            when X"04" => axi_rdata <= resize(std_logic_vector(config_i.zero_pad_len),32);
            when X"08" => axi_rdata <= resize(std_logic_vector(config_i.hder_len),32);
            when X"0C" => axi_rdata <= resize(std_logic_vector(config_i.eff_hder_len_div2_m1),32);
            when X"10" => axi_rdata <= resize(std_logic_vector(config_i.zero_pad_len_div2_m1),32);
            when X"14" => axi_rdata <= resize(("0000"& config_i.need_padding),32);
            when X"18" => axi_rdata <= resize(("0000"& config_i.hder_tlast_en),32);
            -- 
            when X"C0" => axi_rdata <= resize(control_i,32);
            -- statut
            when X"50" => axi_rdata <= resize(status_to_mb,32);	
            when others=> 
            axi_rdata <= (others =>'1');
         end case;        
      end if;     
   end process;   
   
   ----------------------------------------------------------------------------
   -- WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U5: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
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
   axi_wstrb <= MB_MOSI.WSTRB;  -- requis car le MB envoie des chmps de header avec des strobes differents de "1111";
   
   ----------------------------------------------------------------------------
   -- WR : reception configuration
   ----------------------------------------------------------------------------
   U6: process(MB_CLK)        -- 
   begin
      if rising_edge(MB_CLK) then
         if sreset = '1' then
            config_i <= hder_insert_cfg_default;  -- 
            reset_err_i <= '0';
            hdr_rx_mosi.awvalid <= '0';
            hdr_rx_mosi.wvalid <= '0';
            hdr_rx_mosi.wstrb <= (others => '0');
            hdr_rx_mosi.awprot <= (others => '0');
            hdr_rx_mosi.arvalid <= '0';
            hdr_rx_mosi.bready <= '1';
            hdr_rx_mosi.rready <= '0';
            hdr_rx_mosi.arprot <= (others => '0');
            config_valid <= '0';
         else            
            
            if slv_reg_wren = '1' then -- ne pas ajouter MOSI.WSTRB 				
               
               if  axi_awaddr(9) = '1' then   -- données slow header envoyées dans un fifo
                  hdr_rx_mosi.awvalid <= '1';
                  hdr_rx_mosi.wvalid <= '1';
                  hdr_rx_mosi.awaddr <= resize(axi_awaddr(7 downto 2),32);  -- quotient de la division euclidienne par 4. Cela suppose que l'adresse du mB varie par pas de 4 
                  hdr_rx_mosi.wdata <= data_i;                  
                  hdr_rx_mosi.wstrb <= axi_wstrb(0)&axi_wstrb(1)&axi_wstrb(2)&axi_wstrb(3); -- le strobe du MB doit être corrigé pour que tout soit en big endian dans la dp Ram
                  -- pragma translate_off
                  hdr_rx_mosi.wdata <=  data_i(7 downto 0) & data_i(15 downto 8) & data_i(23 downto 16) & data_i(31 downto 24) ; 
                  -- pragma translate_on
                  
               else   -- données pour config du bloc
                  
                  hdr_rx_mosi.awvalid <= '0';
                  hdr_rx_mosi.wvalid <= '0';
                  if axi_wstrb = "1111" then  -- c'Est obligatoir d'envoyer les données sur 32 bits
                     case axi_awaddr(7 downto 0) is 
                        -- elements de config
                        when X"00" => 
                           config_i.eff_hder_len <= unsigned(data_i(config_i.eff_hder_len'length-1 downto 0));
                           config_valid <= '0';
                        
                        when X"04" => 
                           config_i.zero_pad_len <= unsigned(data_i(config_i.zero_pad_len'length-1 downto 0));
                        
                        when X"08" => 
                           config_i.hder_len <= unsigned(data_i(config_i.hder_len'length-1 downto 0));
                        
                        when X"0C" => 
                           config_i.eff_hder_len_div2_m1 <= unsigned(data_i(config_i.eff_hder_len_div2_m1'length-1 downto 0));
                        
                        when X"10" => 
                           config_i.zero_pad_len_div2_m1 <= unsigned(data_i(config_i.zero_pad_len_div2_m1'length-1 downto 0));
                        
                        when X"14" => 
                           config_i.need_padding <= data_i(0);
                        
                        when X"18" => 
                           config_i.hder_tlast_en <= data_i(0);  
                           config_valid <= '1';
                        
                        when X"C0" => reset_err_i <= data_i(1);
                        
                        when others => --do nothing
                        
                     end case;
                  end if;
               end if;
            else
               hdr_rx_mosi.awvalid <= '0';
               hdr_rx_mosi.wvalid <= '0'; 
            end if;
         end if;
      end if;
   end process;
   
   --------------------------------
   -- WR  : WR feedback envoyé au MB
   --------------------------------
   U7: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
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
   
   ----------------------------------------------------------------------------
   -- gestion des statuts
   ---------------------------------------------------------------------------- 
   -- Synchronisation du domaine CLK_100M au domaine PPC_CLK
   Ue1 : err_sync port map(D => din_ovfl,       Q => din_ovfl_sync,       ARESET => ARESET, D_CLK => TX_CLK,        Q_CLK => MB_CLK);   
   Ue2 : err_sync port map(D => fw_hder_ovfl,   Q => fw_hder_ovfl_sync,   ARESET => ARESET, D_CLK => FW_HDER_CLK,   Q_CLK => MB_CLK);    
   Ue3 : err_sync port map(D => trig_hder_ovfl, Q => trig_hder_ovfl_sync, ARESET => ARESET, D_CLK => TRIG_HDER_CLK, Q_CLK => MB_CLK);   
   Ue4 : err_sync port map(D => fpa_hder_ovfl,  Q => fpa_hder_ovfl_sync,  ARESET => ARESET, D_CLK => FPA_HDER_CLK,  Q_CLK => MB_CLK);
   Ue5 : err_sync port map(D => fpa_hder_err,   Q => fpa_hder_err_sync,   ARESET => ARESET, D_CLK => FPA_HDER_CLK,  Q_CLK => MB_CLK); 
   Ue6 : err_sync port map(D => trig_hder_err,  Q => trig_hder_err_sync,  ARESET => ARESET, D_CLK => TRIG_HDER_CLK, Q_CLK => MB_CLK); 
   Ue7 : err_sync port map(D => fw_hder_err,    Q => fw_hder_err_sync,    ARESET => ARESET, D_CLK => FW_HDER_CLK,   Q_CLK => MB_CLK);    
   Ue8 : err_sync port map(D => ehdri_hder_ovfl,Q => ehdri_hder_ovfl_sync,ARESET => ARESET, D_CLK => FW_HDER_CLK,   Q_CLK => MB_CLK);
   Ue9 : err_sync port map(D => cal_hder_ovfl,  Q => cal_hder_ovfl_sync,  ARESET => ARESET, D_CLK => CAL_HDER_CLK,  Q_CLK => MB_CLK);
   Ue10 : err_sync port map(D => flagging_hder_ovfl,  Q => flagging_hder_ovfl_sync,  ARESET => ARESET, D_CLK => CAL_HDER_CLK,  Q_CLK => MB_CLK);
   
   -- definition des erreurs (connecter les signaux des erreurs ici)
   error(15 downto 12) <= (others => '0');
   error(11)  <= flagging_hder_ovfl_sync;
   error(10)  <= cal_hder_ovfl_sync;
   error(9)  <= ehdri_hder_ovfl_sync;
   error(8)  <= din_ovfl_sync;
   error(7)  <= fw_hder_ovfl_sync;
   error(6)  <= trig_hder_ovfl_sync;
   error(5)  <= fpa_hder_ovfl_sync;
   error(4)  <= '0'; -- spare du sequenceur
   error(3)  <= fw_hder_err_sync;
   error(2)  <= trig_hder_err_sync; 
   error(1)  <= fpa_hder_err_sync; 
   error(0)  <= '0';  
   
   -- process pour lacther les erreurs
   U8 : process(MB_CLK) 
   begin
      if rising_edge(MB_CLK) then
         if sreset = '1' then       
            ERR <= '0';
            din_ovfl_sync  <= '0';
            --fw_hder_ovfl_sync  <= '0';
            --trig_hder_ovfl_sync  <= '0';
            --fpa_hder_ovfl_sync  <= '0';
            --fpa_hder_err_sync  <= '0';
            --trig_hder_err_sync  <= '0';
            --fw_hder_err_sync  <= '0';
            error_latch  <= (others => '0');
            error_found <= '0';
         else            
            
            ERR <= din_ovfl_sync or fw_hder_ovfl_sync or trig_hder_ovfl_sync or fpa_hder_ovfl_sync or fpa_hder_err_sync or trig_hder_err_sync or fw_hder_err_sync;
            
            -- latch des erreurs
            for i in 0 to error'length-1 loop
               if error(i) = '1'  then  
                  error_latch(i)  <=  '1';
               end if;                                 
            end  loop;
            
            -- gestion du latch
            if reset_err_i = '1' then 
               error_found <= '0';
               error_latch <= (others => '0');
            else
               if error /= (error'length-1 downto 0 => '0') then
                  error_found <= '1';         
               end if;
            end if;
            
            status_to_mb(10 downto 1) <= error_latch(10 downto 1); -- le bit '0' n'est pas une erreur mais un done
            status_to_mb(0) <= sequencer_done;			
            
         end if;
      end if;
   end process; 
   
   -- conversion AXILite vers natif pour la block ram
   process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         if hdr_rx_mosi.awvalid = '1' and hdr_rx_mosi.wvalid = '1' then  -- cela marchera bien tant que: les infos variables du header slow (comme la température etc..) sont sur 4 bytes max.
            ram_wr_add_i <= unsigned(hdr_rx_mosi.awaddr(ALEN_M1 downto 0));
            ram_wr_data_i <= hdr_rx_mosi.wdata;
            ram_bwe_i <= hdr_rx_mosi.wstrb;
         else
            ram_bwe_i <= (others => '0');         -- valeur par defaut plaçant la ram en mode read
         end if;   
      end if;
   end process;
   
end rtl;
