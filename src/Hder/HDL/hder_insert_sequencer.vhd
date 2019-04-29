------------------------------------------------------------------
--!   @file : hder_insert_sequencer
--!   @brief
--!   @details
--!
--!   $Rev $
--!   $Author $
--!   $Date $
--!   $Id $
--!   $URL $
------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;           
use IEEE.numeric_std.ALL;
use work.hder_define.all;
use work.tel2000.all;

entity hder_insert_sequencer is
   port(
      
      ARESET           : in std_logic;
      CLK              : in std_logic;
      
      CONFIG           : in hder_insert_cfg_type;
      
      IMG_INFO         : in img_info_type;
      
      FPA_HDER_MOSI    : in t_axi4_lite_mosi;
      FPA_HDER_MISO    : out t_axi4_lite_miso;
      
      TRIG_HDER_MOSI   : in t_axi4_lite_mosi;
      TRIG_HDER_MISO   : out t_axi4_lite_miso;
      
      FW_HDER_MOSI     : in t_axi4_lite_mosi;
      FW_HDER_MISO     : out t_axi4_lite_miso;
      
      EHDRI_HDER_MOSI  : in t_axi4_lite_mosi;
      EHDRI_HDER_MISO  : out t_axi4_lite_miso;
      
      CAL_HDER_MOSI    : in t_axi4_lite_mosi;
      CAL_HDER_MISO    : out t_axi4_lite_miso;
      
      FLAGGING_HDER_MOSI  : in t_axi4_lite_mosi;
      FLAGGING_HDER_MISO  : out t_axi4_lite_miso;
      
      ADC_RDOUT_HDER_MOSI  : in t_axi4_lite_mosi;
      ADC_RDOUT_HDER_MISO  : out t_axi4_lite_miso;
      
      RAM_WR_ADD       : out std_logic_vector(5 downto 0);
      RAM_WR_DATA      : out std_logic_vector(31 downto 0);
      RAM_BWE          : out std_logic_vector(3 downto 0);
      
      RAM_RD           : out std_logic;
      RAM_RD_ADD       : out std_logic_vector(5 downto 0);
      RAM_RD_DATA      : in std_logic_vector(31 downto 0);
      RAM_RD_DVAL      : in std_logic;
      
      OUT_MOSI         : out t_axi4_stream_mosi32;
      OUT_MISO         : in t_axi4_stream_miso;
      
      HDER_TLAST_OUT   : in std_logic;
      
      SEQ_STATUS       : out std_logic_vector(4 downto 0)
      );
end hder_insert_sequencer;


architecture rtl of hder_insert_sequencer is
   
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
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
   
   component fwft_sfifo_w8_d16
      port(
         srst     : in std_logic;
         clk      :  in std_logic;
         din      :  in std_logic_vector(7 downto 0);
         wr_en    : in std_logic;
         rd_en    :  in std_logic;
         dout     : out std_logic_vector(7 downto 0);
         valid    :  out std_logic;
         full     :  out std_logic;
         overflow :  out std_logic;
         empty    :  out std_logic);
   end component;
   
   type sequencer_sm_type is (idle, hder_reorder_st, wait_reorder_end_st, hder_send_st, wait_hder_end_st, pause_st);  
   type fast_hder_reorder_sm_type is (idle, check_st, ram_wr_st, fetch_data_st, check_end_st); 
   type hder_client_in_type is 
   record
      hder_id        : std_logic_vector(7 downto 0);
      hder_eof_code  : std_logic_vector(15 downto 0);
      mosi           : t_axi4_lite_mosi;      
   end record;                          
   
   type hder_client_out_type is 
   record
      miso_bvalid    : std_logic;
      fifo_rd        : std_logic;
      error          : std_logic;
   end record; 
   
   type fast_hder_client_in_type is array (1 to FAST_HDER_CLIENT_NUMBER) of hder_client_in_type;
   type fast_hder_client_out_type is array (1 to FAST_HDER_CLIENT_NUMBER) of hder_client_out_type; 
   type sender_sm_type is (idle, enable_rder_st, hder_send_st, zpad_send_st, check_zpad_st);
   type ram_reader_sm_type is (idle, read_st, pause_st1, pause_st2);
   
   signal ram_reader_sm                : ram_reader_sm_type;
   signal sender_sm                    : sender_sm_type;
   signal fast_hder_client_in          : fast_hder_client_in_type;
   signal fast_hder_client_out         : fast_hder_client_out_type;
   signal fast_hder_reorder_sm         : fast_hder_reorder_sm_type;
   signal sequencer_sm                 : sequencer_sm_type;
   signal sreset                       : std_logic;
   signal exp_feedbk_sync              : std_logic;
   signal hder_id_fifo_wr              : std_logic;
   signal exp_feedbk_sync_last         : std_logic;
   signal frame_id_sync                : std_logic_vector(IMG_INFO.FRAME_ID'range);
   signal hder_id_fifo_rd              : std_logic;
   signal hder_id_fifo_dout            : std_logic_vector(7 downto 0);
   signal hder_id_fifo_dval            : std_logic;
   signal hder_id_fifo_ovfl            : std_logic;
   signal fast_hder_reorder_en         : std_logic;
   signal hder_sender_en               : std_logic;
   signal hder_id_ref                  : std_logic_vector(7 downto 0);
   signal hder_reorder_done            : std_logic;
   signal hder_sender_done             : std_logic;
   signal fast_hder_client_cnt         : unsigned(7 downto 0);
   signal num                          : natural range 1 to FAST_HDER_CLIENT_NUMBER;
   signal ram_wr_add_i, add_buff       : unsigned(ALEN_M1 downto 0);
   signal ram_rd_add_i                 : signed(8 downto 0);
   signal ram_wr_data_i, data_buff     : std_logic_vector(31 downto 0);
   signal ram_bwe_i                    : std_logic_vector(3 downto 0);
   signal out_mosi_i                   : t_axi4_stream_mosi32;
   signal data_cnt                     : unsigned(CONFIG.ZERO_PAD_LEN_DIV2_M1'length-1 downto 0);
   signal ram_rd_i                     : std_logic;
   signal sequencer_done               : std_logic;
   signal ram_reader_done              : std_logic;
   signal ram_reader_en                : std_logic;
   signal eof_code_buff                : std_logic_vector(hder_client_in_type.hder_eof_code'length-1 downto 0);
   signal hder_id_buff                 : std_logic_vector(hder_client_in_type.hder_id'length-1 downto 0);
   signal wstrb_buff                   : std_logic_vector(3 downto 0);
   signal fpa_hder_fast_received       : std_logic;
   signal cal_hder_fast_received       : std_logic;
   signal hder_cycle_end               : std_logic;
   -- signal out_incr_en                  : std_logic_vector(1 downto 0);
   --signal out_rdy_i                    : std_logic;
   
begin
   
   OUT_MOSI <= out_mosi_i;
   
   RAM_WR_ADD <= std_logic_vector(ram_wr_add_i);
   RAM_WR_DATA <= ram_wr_data_i;
   RAM_BWE <= ram_bwe_i;
   RAM_RD <= ram_rd_i;
   RAM_RD_ADD <= std_logic_vector(ram_rd_add_i(ALEN_M1 downto 0));
   ------------------------------------------------------------------
   --  Fast Hder inputs mapping
   ------------------------------------------------------------------
   -- FPA FAST HDER PART
   fast_hder_client_in(1).hder_id       <= FPA_HDER_MOSI.AWADDR(15 downto 8); -- selon le protocole de transfert, AWADDR(15 downto 8) = frame_id. C'est aussi le hder_id 
   fast_hder_client_in(1).hder_eof_code <= FPA_HDER_MOSI.AWADDR(31 downto 16); -- selon le protocole de transfert, AWADDR(31 downto 16) = EOF.
   fast_hder_client_in(1).mosi          <= FPA_HDER_MOSI;
   FPA_HDER_MISO.AWREADY                <= fast_hder_client_out(1).fifo_rd;
   FPA_HDER_MISO.WREADY                 <= fast_hder_client_out(1).fifo_rd;
   FPA_HDER_MISO.BVALID                 <= fast_hder_client_out(1).miso_bvalid;
   FPA_HDER_MISO.BRESP                  <= AXI_OKAY;
   FPA_HDER_MISO.ARREADY                <= '0'; -- lecture non autorisée
   FPA_HDER_MISO.RVALID                 <= '0'; -- lecture non autorisée
   
   -- TRIG FAST HDER PART
   fast_hder_client_in(2).hder_id       <= TRIG_HDER_MOSI.AWADDR(15 downto 8); -- selon le protocole de transfert, AWADDR(15 downto 8) = frame_id. C'est aussi le hder_id 
   fast_hder_client_in(2).hder_eof_code <= TRIG_HDER_MOSI.AWADDR(31 downto 16); -- selon le protocole de transfert, AWADDR(31 downto 16) = EOF.
   fast_hder_client_in(2).mosi          <= TRIG_HDER_MOSI;
   TRIG_HDER_MISO.AWREADY               <= fast_hder_client_out(2).fifo_rd;
   TRIG_HDER_MISO.WREADY                <= fast_hder_client_out(2).fifo_rd;
   TRIG_HDER_MISO.BVALID                <= fast_hder_client_out(2).miso_bvalid;
   TRIG_HDER_MISO.BRESP                 <= AXI_OKAY;
   TRIG_HDER_MISO.ARREADY               <= '0'; -- lecture non autorisée
   TRIG_HDER_MISO.RVALID                <= '0'; -- lecture non autorisée
   
   -- FW FAST HDER PART
   fast_hder_client_in(3).hder_id       <= FW_HDER_MOSI.AWADDR(15 downto 8); -- selon le protocole de transfert, AWADDR(15 downto 8) = frame_id. C'est aussi le hder_id 
   fast_hder_client_in(3).hder_eof_code <= FW_HDER_MOSI.AWADDR(31 downto 16); -- selon le protocole de transfert, AWADDR(31 downto 16) = EOF.
   fast_hder_client_in(3).mosi          <= FW_HDER_MOSI;
   FW_HDER_MISO.AWREADY                 <= fast_hder_client_out(3).fifo_rd;
   FW_HDER_MISO.WREADY                  <= fast_hder_client_out(3).fifo_rd;
   FW_HDER_MISO.BVALID                  <= fast_hder_client_out(3).miso_bvalid;
   FW_HDER_MISO.BRESP                   <= AXI_OKAY;
   FW_HDER_MISO.ARREADY                 <= '0'; -- lecture non autorisée
   FW_HDER_MISO.RVALID                  <= '0'; -- lecture non autorisée
   
   -- EHDRI HDER PART
   fast_hder_client_in(4).hder_id       <= EHDRI_HDER_MOSI.AWADDR(15 downto 8); -- selon le protocole de transfert, AWADDR(15 downto 8) = frame_id. C'est aussi le hder_id 
   fast_hder_client_in(4).hder_eof_code <= EHDRI_HDER_MOSI.AWADDR(31 downto 16); -- selon le protocole de transfert, AWADDR(31 downto 16) = EOF.
   fast_hder_client_in(4).mosi          <= EHDRI_HDER_MOSI;
   EHDRI_HDER_MISO.AWREADY              <= fast_hder_client_out(4).fifo_rd;
   EHDRI_HDER_MISO.WREADY               <= fast_hder_client_out(4).fifo_rd;
   EHDRI_HDER_MISO.BVALID               <= fast_hder_client_out(4).miso_bvalid;
   EHDRI_HDER_MISO.BRESP                <= AXI_OKAY;
   EHDRI_HDER_MISO.ARREADY              <= '0'; -- lecture non autorisée
   EHDRI_HDER_MISO.RVALID               <= '0'; -- lecture non autorisée 
   
   --CAL HDER PART
   fast_hder_client_in(5).hder_id       <= CAL_HDER_MOSI.AWADDR(15 downto 8); -- selon le protocole de transfert, AWADDR(15 downto 8) = frame_id. C'est aussi le hder_id 
   fast_hder_client_in(5).hder_eof_code <= CAL_HDER_MOSI.AWADDR(31 downto 16); -- selon le protocole de transfert, AWADDR(31 downto 16) = EOF.
   fast_hder_client_in(5).mosi          <= CAL_HDER_MOSI;
   CAL_HDER_MISO.AWREADY                <= fast_hder_client_out(5).fifo_rd;
   CAL_HDER_MISO.WREADY                 <= fast_hder_client_out(5).fifo_rd;
   CAL_HDER_MISO.BVALID                 <= fast_hder_client_out(5).miso_bvalid;
   CAL_HDER_MISO.BRESP                  <= AXI_OKAY;
   CAL_HDER_MISO.ARREADY                <= '0'; -- lecture non autorisée
   CAL_HDER_MISO.RVALID                 <= '0'; -- lecture non autorisée
   
   -- FLAGGING HDER PART
   fast_hder_client_in(6).hder_id       <= FLAGGING_HDER_MOSI.AWADDR(15 downto 8); -- selon le protocole de transfert, AWADDR(15 downto 8) = frame_id. C'est aussi le hder_id 
   fast_hder_client_in(6).hder_eof_code <= FLAGGING_HDER_MOSI.AWADDR(31 downto 16); -- selon le protocole de transfert, AWADDR(31 downto 16) = EOF.
   fast_hder_client_in(6).mosi          <= FLAGGING_HDER_MOSI;
   FLAGGING_HDER_MISO.AWREADY              <= fast_hder_client_out(6).fifo_rd;
   FLAGGING_HDER_MISO.WREADY               <= fast_hder_client_out(6).fifo_rd;
   FLAGGING_HDER_MISO.BVALID               <= fast_hder_client_out(6).miso_bvalid;
   FLAGGING_HDER_MISO.BRESP                <= AXI_OKAY;
   FLAGGING_HDER_MISO.ARREADY              <= '0'; -- lecture non autorisée
   FLAGGING_HDER_MISO.RVALID               <= '0'; -- lecture non autorisée 
   
   -- ADC READOUT HDER PART
   fast_hder_client_in(7).hder_id       <= ADC_RDOUT_HDER_MOSI.AWADDR(15 downto 8); -- selon le protocole de transfert, AWADDR(15 downto 8) = frame_id. C'est aussi le hder_id 
   fast_hder_client_in(7).hder_eof_code <= ADC_RDOUT_HDER_MOSI.AWADDR(31 downto 16); -- selon le protocole de transfert, AWADDR(31 downto 16) = EOF.
   fast_hder_client_in(7).mosi          <= ADC_RDOUT_HDER_MOSI;
   ADC_RDOUT_HDER_MISO.AWREADY              <= fast_hder_client_out(7).fifo_rd;
   ADC_RDOUT_HDER_MISO.WREADY               <= fast_hder_client_out(7).fifo_rd;
   ADC_RDOUT_HDER_MISO.BVALID               <= fast_hder_client_out(7).miso_bvalid;
   ADC_RDOUT_HDER_MISO.BRESP                <= AXI_OKAY;
   ADC_RDOUT_HDER_MISO.ARREADY              <= '0'; -- lecture non autorisée
   ADC_RDOUT_HDER_MISO.RVALID               <= '0'; -- lecture non autorisée  
   
   ------------------------------------------------------------------
   --  synchro reset
   ------------------------------------------------------------------
   U1A : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   U1B : double_sync
   port map(
      CLK => CLK,
      D   => IMG_INFO.EXP_FEEDBK,
      Q   => exp_feedbk_sync,
      RESET => sreset
      );
   
   -------------------------------------------------------------------
   -- Ecriture de l'id du header dans un fifo
   -------------------------------------------------------------------   
   -- il faut ecrire dans un fifo fwft l'id du header. 
   -- Cet id permet de savoir à quelle image se rapporte les hders fast
   U2: process(CLK)
   begin          
      if rising_edge(CLK) then                   
         if sreset = '1' then 
            hder_id_fifo_wr <= '0';
            exp_feedbk_sync_last <= '0';
         else            
            exp_feedbk_sync_last <= exp_feedbk_sync;
            frame_id_sync <= std_logic_vector(IMG_INFO.FRAME_ID);
            hder_id_fifo_wr <= exp_feedbk_sync  and not exp_feedbk_sync_last;
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- fifo fwft pour hder_id
   --------------------------------------------------
   U3 : fwft_sfifo_w8_d16
   port map (
      srst => sreset,
      clk => CLK,
      din => frame_id_sync(7 downto 0),  -- (7 downto 0) suffisant pour savoir à quelle image se rapportent les headers fast
      wr_en => hder_id_fifo_wr,
      rd_en => hder_id_fifo_rd,
      dout => hder_id_fifo_dout,
      valid  => hder_id_fifo_dval,
      full => open,
      overflow => hder_id_fifo_ovfl,
      empty => open
      );
   
   --------------------------------------------------
   -- sequenceur
   --------------------------------------------------
   U4: process(CLK)	
   begin  
      if rising_edge(CLK) then
         if sreset = '1' then 
            sequencer_sm <= idle;
            fast_hder_reorder_en <= '0';
            hder_sender_en <= '0';
            sequencer_done <= '0';
            hder_cycle_end <= '0';
         else				
            
            hder_cycle_end <= HDER_TLAST_OUT;
            
            case sequencer_sm is	
               
               -- idle
               when idle =>
                  sequencer_done <= '1';
                  hder_id_fifo_rd <= '0';
                  fast_hder_reorder_en <= '0';
                  hder_sender_en <= '0';                  
                  if hder_id_fifo_dval = '1' then -- s'il y a une image en cours d'intégration, il y a forcéement son umero dans le fifo
                     sequencer_sm <= hder_reorder_st;
                     hder_id_ref <= hder_id_fifo_dout; -- on latch le hder_id, c'Est l'id de reference
                     hder_id_fifo_rd <= '1';       -- puis en met à jour la sortie du fwft
                     sequencer_done <= '0';
                  end if;
                  
               -- on reordonne les headers fast	
               when hder_reorder_st =>	
                  hder_id_fifo_rd <= '0';
                  fast_hder_reorder_en <= '1';
                  if hder_reorder_done = '0' then 
                     sequencer_sm <= wait_reorder_end_st;
                  end if;
                  
               -- on attend la fin du reordonnement du header
               when wait_reorder_end_st =>
                  fast_hder_reorder_en <= '0';
                  if hder_reorder_done = '1' then 
                     sequencer_sm <= hder_send_st;
                  end if;
                  
               -- on envoie le header  
               when hder_send_st =>		
                  hder_sender_en <= '1';
                  if hder_sender_done = '0' then 
                     sequencer_sm <= wait_hder_end_st;
                  end if;
                  
               -- on attend la fin de l'envoi du header
               when wait_hder_end_st =>
                  hder_sender_en <= '0';
                  if hder_sender_done = '1' then 
                     sequencer_sm <= pause_st;
                  end if;
                  
               -- on attend que le header ait quitté le module avant de preparer le prochain pourque le fifo du heder en aval ne defonce jamais
               when pause_st =>
                  if hder_cycle_end = '1' then 
                     sequencer_sm <= idle;
                  end if;    
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- reordonnement du header
   --------------------------------------------------
   U5: process(CLK)	
   begin  
      if rising_edge(CLK) then
         if sreset = '1' then 
            fast_hder_reorder_sm <= idle;
            hder_reorder_done <= '0';
            fpa_hder_fast_received <= '0';
            cal_hder_fast_received <= '0';
            for j in 1 to FAST_HDER_CLIENT_NUMBER loop
               fast_hder_client_out(j).fifo_rd <= '0';
               fast_hder_client_out(j).miso_bvalid <= '0';
               fast_hder_client_out(j).error <= '0';
            end loop;                                                  
            -- pragma translate_off
            add_buff <= (others => '0');
            data_buff <= (others => '0');
            eof_code_buff <= (others => '0');
            hder_id_buff <= (others => '0');
            wstrb_buff <= (others => '0');
            -- pragma translate_on
         else				
            
            case fast_hder_reorder_sm is	
               
               -- idle
               when idle =>
                  hder_reorder_done <= '1';
                  fpa_hder_fast_received <= '0';
                  cal_hder_fast_received <= '0';
                  fast_hder_client_cnt <= (others => '0');
                  ram_bwe_i <= (others => '0');         -- valeur par defaut plaçant la ram en mode read
                  
                  -- en idle, on bloque tous les fast header clients
                  for j in 1 to FAST_HDER_CLIENT_NUMBER loop  
                     fast_hder_client_out(j).fifo_rd <= '0';
                     fast_hder_client_out(j).miso_bvalid <= '0';
                  end loop;
                  --lancement du reordonnement
                  if fast_hder_reorder_en = '1' then    
                     fast_hder_reorder_sm <= check_st;
                  end if;
                  
               -- on determine quel client de hder fast a des données à envoyer en ram
               when check_st =>
                  hder_reorder_done <= '0';
                  ram_bwe_i <= (others => '0');  -- ram protegée contre toute ecriture hasardeuse 
                  if fast_hder_client_cnt >= 3 and fpa_hder_fast_received = '1' and cal_hder_fast_received  = '1' then -- ainsi, si la FW n'est pas active, on retourne à idle. Sinon, on il doit y avoir des données à mettre en RAM et donc fast_hder_reorder_sm ira en ram_wr_st; 
                     --if fast_hder_client_cnt >= 2 and fpa_hder_fast_received = '1' then -- en attendant de remettre la calibration
                     fast_hder_reorder_sm <= idle;
                  end if;
                  for j in 1 to FAST_HDER_CLIENT_NUMBER loop
                     fast_hder_client_out(j).miso_bvalid <= '0';
                     if fast_hder_client_in(j).hder_id = hder_id_ref and (fast_hder_client_in(j).mosi.awvalid and fast_hder_client_in(j).mosi.wvalid) = '1' then 
                        num <= j;
                        fast_hder_reorder_sm <= fetch_data_st;
                     end if;
                  end loop;                  
                  
               -- on prend la donnée valide à la sortie du fifo fwft
               when fetch_data_st =>
                  if num = 1 then
                     fpa_hder_fast_received <= '1';
                  end if;
                  if num = 5 then
                     cal_hder_fast_received <= '1';
                  end if;
                  
                  add_buff <= unsigned(fast_hder_client_in(num).mosi.awaddr(ALEN_M1 downto 0));
                  data_buff <= fast_hder_client_in(num).mosi.wdata;
                  eof_code_buff <= fast_hder_client_in(num).hder_eof_code;
                  hder_id_buff <= fast_hder_client_in(num).hder_id;
                  wstrb_buff <= fast_hder_client_in(num).mosi.wstrb;
                  if (fast_hder_client_in(num).mosi.awvalid and fast_hder_client_in(num).mosi.wvalid) = '1' then                     
                     fast_hder_client_out(num).miso_bvalid <= '1';
                     fast_hder_client_out(num).fifo_rd <= '1';     -- on raffraichit le fifo fwft pour le prochain passage
                     fast_hder_reorder_sm <= ram_wr_st;
                  end if;
                  
               -- on ecrit la donnée dans la ram si elle est conforme
               when ram_wr_st =>                  
                  fast_hder_client_out(num).fifo_rd <= '0';       -- pour avoir un pulse
                  fast_hder_client_out(num).miso_bvalid <= '0';   -- pour avoir un pulse                 
                  ram_wr_add_i <= add_buff;
                  ram_wr_data_i <= data_buff;
                  if hder_id_buff = hder_id_ref then
                     ram_bwe_i <= wstrb_buff; 
                     fast_hder_reorder_sm <= check_end_st;
                  else  -- on ne s'attend pas à ce que le hder_id change avant la fin de la transmission. Le cas échéant, le code du client comporte un bug.
                     ram_bwe_i <= (others => '0');                                     
                     fast_hder_client_out(num).error <= '1';  
                  end if;
                  
               -- fin de l'ecriture pour le client
               when check_end_st =>               
                  if eof_code_buff = FAST_HDER_EOF_CODE then
                     fast_hder_client_out(num).fifo_rd <= '0'; -- on bloque le fifo-client
                     fast_hder_client_cnt <= fast_hder_client_cnt + 1; -- on compte le nombre de clients qui ont envoyé leur données en ram
                     fast_hder_reorder_sm <= check_st;
                  else
                     fast_hder_reorder_sm <= fetch_data_st;
                  end if;
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- envoi du header reordonné et de l'image
   --------------------------------------------------
   -- lecteur de RAM (fait ainsi pour ameliorer timing)
   
   U6A : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then 
            ram_reader_done <= '0';
            ram_reader_sm <= idle;
            ram_rd_i <= '0';
            -- pragma translate_off
            ram_rd_add_i <= (others => '0');
            -- pragma translate_on
         else
            
            case ram_reader_sm is
               
               when idle => 
                  ram_reader_done <= '1';
                  ram_rd_i <= '0';
                  ram_rd_add_i <= to_signed(-1, ram_rd_add_i'length);  -- ainsi, la premiere adresse à lire sera -1 + 1 = 0 
                  if ram_reader_en = '1' then 
                     ram_reader_sm <= pause_st1;
                     ram_reader_done <= '0';
                  end if;
               
               when pause_st1 =>        -- requis pour que le ram_reader_done ='0' soit compris par le sender_sm  
                  ram_reader_sm <= read_st;
               
               when read_st =>          -- aucun support de busy lors de la lecture des 64 pix de la RAM. Voilà pourquoi le fifo à l'extérieur a 64 pix de profond.
                  ram_rd_i <= '1';
                  ram_rd_add_i <= ram_rd_add_i + 1;
                  if ram_rd_add_i = to_integer(CONFIG.EFF_HDER_LEN_DIV2_M1) then                     
                     ram_reader_sm <= pause_st2;
                  end if;
               
               when pause_st2 =>  
                  ram_rd_i <= '0';    -- en plaçant ici, on lit plus que necessaure mais pas grave car le sender envoie le bon nombre
                  if RAM_RD_DVAL = '0' then 
                     ram_reader_sm <= idle;
                  end if;
               
               when others =>
                  
               
            end case;
         end if;
      end if;      
   end process;
   
   
   -- sender 
   U6B: process(CLK)
      variable ram_cnt_incr: std_logic_vector(1 downto 0);
      variable rdy_cnt_incr: std_logic_vector(1 downto 0);
   begin  
      if rising_edge(CLK) then
         if sreset = '1' then 
            sender_sm <= idle;
            hder_sender_done <= '0';
            out_mosi_i.tvalid <= '0';
            ram_reader_en <= '0'; 
         else                          
            
            -- assignation par défaut
            out_mosi_i.tstrb <= "1111";
            out_mosi_i.tkeep <= "1111";
            out_mosi_i.tuser <= (others => '0');
            out_mosi_i.tdest <= (others => '0');
            out_mosi_i.tid <= (others => '1');   -- pour downstream, permet identification du header
            out_mosi_i.tdata <= RAM_RD_DATA(15 downto 0) & RAM_RD_DATA(31 downto 16); -- ainsi on supprime dbus_reorder
            
            -- autres assignations
            ram_cnt_incr := '0'&  RAM_RD_DVAL;
            rdy_cnt_incr := '0'&  OUT_MISO.TREADY;
            
            -- fsm
            case sender_sm is 
               
               --idle
               when idle =>
                  hder_sender_done <= '1';
                  out_mosi_i.tvalid <= '0';
                  out_mosi_i.tlast <= '0';
                  data_cnt <= (others =>'0');
                  ram_reader_en <= '0'; 
                  if hder_sender_en = '1' then                    
                     sender_sm <= enable_rder_st;
                  end if;
                  
               -- on active le reader de la ram  
               when enable_rder_st => 
                  ram_reader_en <= '1'; 
                  if ram_reader_done = '0' then
                     sender_sm <= hder_send_st;
                  end if;                  
                  
               -- envoi du header de la ram vers la sortie du module
               when hder_send_st =>        -- la ram ne peut gerer le busy donc on utilise afull lors de sa lecture
                  ram_reader_en <= '0';         
                  hder_sender_done <= '0';         
                  data_cnt <= data_cnt + to_integer(unsigned(ram_cnt_incr)); 
                  out_mosi_i.tvalid <= RAM_RD_DVAL;
                  if data_cnt = to_integer(CONFIG.EFF_HDER_LEN_DIV2_M1) then
                     out_mosi_i.tlast <= CONFIG.HDER_TLAST_EN and not CONFIG.NEED_PADDING;
                     sender_sm <= check_zpad_st; 
                  end if;
                  
               -- check if we need zero padding
               when check_zpad_st =>
                  out_mosi_i.tvalid <= '0';
                  out_mosi_i.tlast <= '0'; 
                  data_cnt <= (others =>'0');
                  if CONFIG.NEED_PADDING = '0' then
                     sender_sm <= idle;                     
                  else
                     sender_sm <= zpad_send_st;
                  end if;          
                  
               -- envoi du zero pad si necessaire
               when zpad_send_st => 
                  out_mosi_i.tdata <= (others =>'0'); 
                  data_cnt <= data_cnt + to_integer(unsigned(rdy_cnt_incr)); 
                  out_mosi_i.tvalid <= '1'; 
                  if OUT_MISO.TREADY = '1' and data_cnt = to_integer(CONFIG.ZERO_PAD_LEN_DIV2_M1) then         -- on gère le busy ici car les donnnées ne proviennent pas d'une RAM                                          
                     sender_sm <= idle;
                     out_mosi_i.tlast <= CONFIG.HDER_TLAST_EN;                 
                  end if;          
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- gestion des erreurs
   --------------------------------------------------
   U7: process(CLK)  
   begin  
      if rising_edge(CLK) then
         if sreset = '1' then 
            SEQ_STATUS <= (others => '0');
         else            
            SEQ_STATUS(4) <= '0'; -- spare
            SEQ_STATUS(3) <= fast_hder_client_out(3).error;
            SEQ_STATUS(2) <= fast_hder_client_out(2).error;
            SEQ_STATUS(1) <= fast_hder_client_out(1).error;
            SEQ_STATUS(0) <= sequencer_done;
         end if;
      end if;
   end process;
   
   
   
end rtl;
