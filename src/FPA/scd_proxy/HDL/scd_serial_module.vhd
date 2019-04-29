------------------------------------------------------------------
--!   @file : scd_serial_module
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
use work.FPA_define.all;
use work.Proxy_define.all;
use work.fpa_common_pkg.all;

entity scd_serial_module is
   port(
      ARESETN               : in std_logic;
      CLK                   : in std_logic;
      
      -- interface avec le contrôleur
      SERIAL_BASE_ADD       : in std_logic_vector(7 downto 0);
      SERIAL_FATAL_ERR      : out std_logic;
      SERIAL_DONE           : out std_logic;
      SERIAL_EN             : in std_logic;
      SERIAL_ABORT          : in std_logic;
      PROXY_RDY             : out std_logic;
      
      -- TRIG de synchro
      ACQ_TRIG              : in std_logic;
      XTRA_TRIG             : in std_logic;
      
      -- interface avec la RAM
      RAM_WR                : out std_logic;
      RAM_WR_ADD            : out std_logic_vector(10 downto 0);      
      RAM_WR_DATA           : out std_logic_vector(7 downto 0);
      RAM_RD                : out std_logic;
      RAM_RD_ADD            : out std_logic_vector(10 downto 0);
      RAM_RD_DATA           : in std_logic_vector(7 downto 0);
      RAM_RD_DVAL           : in std_logic;
      
      -- temperature du détecteur
      FPA_TEMP_STAT         : out fpa_temp_stat_type;
      
      -- lien TX avec le uart block
      TX_AFULL              : in std_logic;
      TX_DATA               : out std_logic_vector(7 downto 0);
      TX_DVAL               : out std_logic;
      TX_EMPTY              : in std_logic;
      -- lien RX avec le uart block
      RX_EMPTY              : in std_logic;
      RX_DATA               : in std_logic_vector(7 downto 0);
      RX_DVAL               : in std_logic;
      RX_RD_EN              : out std_logic;      
      RX_ERR                : in std_logic;
      PRIM_XTRA_TRIG_ACTIVE : out std_logic
      
      );
end scd_serial_module;

architecture RTL of scd_serial_module is  
   
   constant RST_ERROR_EN : std_logic := '1';     -- mis à titre de debogage. Permet de contrôler le reset des erreurs critiques 
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   component Clk_Divider is
      Generic(	Factor: integer := 2);		
      Port ( Clock   : in std_logic;
         Reset       : in std_logic;		
         Clk_div     : out std_logic);
   end component;
   
   component sfifo_w8_d64
      PORT (
         clk            : in std_logic;
         rst            : in std_logic;
         din            : in std_logic_vector(7 downto 0);
         wr_en          : in std_logic;
         rd_en          : in std_logic;
         dout           : out std_logic_vector(7 downto 0);
         full           : out std_logic;
         overflow       : out std_logic;
         empty          : out std_logic;
         valid          : out std_logic;
         almost_full    : out std_logic;
         almost_empty   : out std_logic
         );
   end component;
   
   -------------------------------------
   -- cette constante permet de partionner la RAM de 248 bytes en 2
   -- A) la zone d'adresse de 0 à 511  :
   --       elle est réservée à l'écriture de la config en provenance du MB. Le MB étant totalement asynchrone, il peut y ecrire à tout moment
   --       pour eviter donc que la config soit corrompue par une autre pendant qu'on l'utilise pour programmer le détecteur, on copie la config de cette zone vers une autre plus sécurisée 
   --       avant qu'elle ne soit réecrite
   -- B) la zone d'adresse de 1024 à YYY :
   -- c'est la zone sécurisée, la config est à l'abri de toute modification de la part du MB. Toute config ecrite dans cette zone sera envoyée au détecteur.
   -- Comme la config est securisée, elle pourra etre renvoyée au détecteur N fois (redondance), si la communication est mauvaise.
   --------------------------------------
   --constant AXI_UARTLITE_RX_FIFO_ADD : std_logic_vector(7 downto 0) :=  x"00";   
   --constant AXI_UARTLITE_TX_FIFO_ADD : std_logic_vector(7 downto 0) :=  x"04";
   
   --adressees d'acces des fifos de AXI UART LITE
   
   --------------------------------------
   
   type prog_seq_fsm_type is (idle, cpy_cfg_st, wait_end_cpy_cfg_st, send_cfg_st, wait_end_send_cfg_st, wait_proxy_resp_st, cmd_fail_mgmt_st);
   type cfg_mgmt_fsm_type is (idle, init_cpy_rd_st, init_cpy_wr_st, cpy_cfg_rd_st, cpy_cfg_wr_st, init_send_st, send_cfg_rd_st, 
   latch_data_st, send_cfg_out_st, wait_tx_fifo_empty_st, wait_proxy_resp_st, check_frm_end_st, uart_pause_st, cmd_resp_mgmt_st, timeout_mgmt_st, wait_temp_trig_st);  
   type cmd_resp_fsm_type is (wait_resp_hder_st, rd_rx_fifo_st, decode_byte_st, check_resp_st, fpa_temp_resp_st);
   type com_data_array_type  is array (0 to SCD_LONGEST_CMD_BYTES_NUM) of std_logic_vector(7 downto 0);
   type failure_resp_data_type  is array (0 to 3) of std_logic_vector(7 downto 0);
   
   signal prog_seq_fsm            : prog_seq_fsm_type;
   signal cfg_mgmt_fsm            : cfg_mgmt_fsm_type;
   signal cmd_resp_fsm            : cmd_resp_fsm_type;
   signal resp_data               : com_data_array_type;
   signal areset                  : std_logic;
   signal sreset                  : std_logic;
   signal serial_fatal_err_i      : std_logic;
   signal serial_done_i           : std_logic;
   signal cpy_cfg_en              : std_logic;
   signal send_cfg_en             : std_logic;
   signal serial_err_cnt          : unsigned(2 downto 0);
   signal cpy_cfg_done            : std_logic;
   signal send_cfg_done           : std_logic;
   signal serial_cmd_failure      : std_logic;
   signal ram_wr_i                : std_logic;
   signal ram_wr_add_i            : unsigned(RAM_WR_ADD'range);
   signal ram_wr_data_i           : std_logic_vector(RAM_WR_DATA'range);
   signal ram_rd_i                : std_logic;
   signal ram_rd_add_i            : unsigned(RAM_RD_ADD'range);
   signal timeout_cnt             : unsigned(23 downto 0);
   signal cfg_byte_total          : unsigned(15 downto 0);
   signal cfg_byte_cnt            : unsigned(15 downto 0);
   signal rx_data_cnt             : unsigned(15 downto 0);
   signal cfg_payload             : std_logic_vector(15 downto 0);
   signal rx_data_total           : unsigned(15 downto 0);
   signal trig_i                  : std_logic;
   signal trig_last               : std_logic;
   signal trig_rising             : std_logic;
   signal cfg_byte                : std_logic_vector(7 downto 0);
   signal cmd_resp_done           : std_logic;
   signal cmd_resp_done_last      : std_logic;
   signal proxy_serial_err        : std_logic;
   signal resp_hder               : std_logic_vector(SCD_COM_RESP_HDER'range);
   signal resp_id                 : std_logic_vector(SCD_COM_RESP_FAILURE_ID'range);
   signal resp_payload            : std_logic_vector(15 downto 0);
   signal cfg_fifo_ovfl           : std_logic;
   signal cfg_fifo_rd_en          : std_logic;
   signal cfg_fifo_dout           : std_logic_vector(7 downto 0);
   signal cfg_fifo_empty          : std_logic;
   signal cfg_fifo_dval           : std_logic;
   signal uart_tbaud_clk_en       : std_logic;
   signal uart_tbaud_clk_en_last  : std_logic;
   signal uart_tbaud_cnt          : unsigned(7 downto 0);
   signal cmd_resp_en             : std_logic;
   signal cfg_fifo_wr_en          : std_logic;
   signal cfg_fifo_din            : std_logic_vector(7 downto 0);
   signal fpa_temp_reg_dval       : std_logic;
   signal fpa_temp_reg            : unsigned(15 downto 0);
   signal resp_dcnt               : unsigned(7 downto 0);
   signal tx_data_i               : std_logic_vector(7 downto 0);
   signal tx_dval_i               : std_logic;
   signal rx_rd_en_i              : std_logic;
   signal proxy_rdy_i             : std_logic;
   signal temp_trig               : std_logic;
   signal temp_trig_last          : std_logic;
   signal resp_err                : std_logic_vector(7 downto 0);
   signal failure_resp_data       : failure_resp_data_type;
   signal fpa_temp_error          : std_logic;
   signal force_xtra_trig_mode    : std_logic;
   
   
   -- attribute dont_touch           : string;
   -- attribute dont_touch of resp_err             : signal is "true";
   -- attribute dont_touch of resp_hder            : signal is "true";
   -- attribute dont_touch of resp_payload         : signal is "true";
   -- attribute dont_touch of resp_dcnt            : signal is "true";
   -- attribute dont_touch of serial_cmd_failure   : signal is "true";
   -- attribute dont_touch of resp_id              : signal is "true";
   -- attribute dont_touch of failure_resp_data    : signal is "true";
begin
   
   areset <= not ARESETN;
   SERIAL_FATAL_ERR <= serial_fatal_err_i;
   SERIAL_DONE <= serial_done_i;
   PROXY_RDY <= proxy_rdy_i;
   
   RAM_WR <= ram_wr_i;   
   RAM_WR_ADD <= std_logic_vector(ram_wr_add_i);
   RAM_WR_DATA <= ram_wr_data_i;
   RAM_RD <= ram_rd_i;     
   RAM_RD_ADD <= std_logic_vector(ram_rd_add_i);  
   
   TX_DVAL <= tx_dval_i;
   TX_DATA <= tx_data_i;
   RX_RD_EN <= rx_rd_en_i;
   
   FPA_TEMP_STAT.TEMP_DATA <= std_logic_vector(resize(fpa_temp_reg, FPA_TEMP_STAT.TEMP_DATA'LENGTH));
   FPA_TEMP_STAT.TEMP_DVAL <= fpa_temp_reg_dval;
   FPA_TEMP_STAT.FPA_PWR_ON_TEMP_REACHED <= '1'; -- fait expres pour le scd car il n'allume le detecteur que lorsque la temperature est ok. 
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1A : sync_reset
   port map(
      ARESET => areset,
      CLK    => CLK,
      SRESET => sreset
      );    
   
   
   --------------------------------------------------
   -- fifo de stockage temporaire du copieur
   --------------------------------------------------   
   U1B : sfifo_w8_d64
   PORT MAP (
      clk => CLK,
      rst => areset,
      din => cfg_fifo_din,
      wr_en => cfg_fifo_wr_en,
      rd_en => cfg_fifo_rd_en,
      dout => cfg_fifo_dout,
      full => open,
      overflow => cfg_fifo_ovfl,
      empty => cfg_fifo_empty,
      valid => cfg_fifo_dval,
      almost_full => open,
      almost_empty => open
      );
   
   --------------------------------------------------  
   -- sequencage des operations                                   
   --------------------------------------------------  
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            prog_seq_fsm <=  idle;
            serial_done_i <= '0';
            serial_fatal_err_i <= '0';
            cpy_cfg_en <= '0';
            send_cfg_en <= '0';
            serial_err_cnt <= (others => '0'); 
            
         else             
            
            --fsm de contrôle            
            case  prog_seq_fsm is 
               
               when idle =>
                  serial_done_i <= '1';
                  --serial_fatal_err_i <= '0';
                  serial_err_cnt <= (others => '0');
                  cpy_cfg_en <= '0';
                  send_cfg_en <= '0';
                  if SERIAL_EN = '1' and cpy_cfg_done = '1' then
                     serial_done_i <= '0';
                     if RST_ERROR_EN = '1' then 
                        serial_fatal_err_i <= '0';
                     end if;
                     prog_seq_fsm <= cpy_cfg_st;
                  end if; 
               
               when cpy_cfg_st =>              -- la config est copiée de de la zone A vers la zone B sécurisée (de la RAM)                  
                  cpy_cfg_en <= '1';
                  if cpy_cfg_done = '0' then
                     cpy_cfg_en <= '0';
                     prog_seq_fsm <= wait_end_cpy_cfg_st;
                  end if;
               
               when wait_end_cpy_cfg_st =>    -- fin de la copie de la config
                  if cpy_cfg_done = '1' and send_cfg_done = '1' then
                     prog_seq_fsm <= send_cfg_st;
                  end if; 
               
               when send_cfg_st =>             -- la config est envoyée de la zone sécurisée vers le proxy
                  send_cfg_en <= '1';
                  if send_cfg_done = '0' then
                     send_cfg_en <= '0';
                     prog_seq_fsm <= wait_end_send_cfg_st;
                  end if;
               
               when wait_end_send_cfg_st =>     -- fin de l'envoi de la config
                  if send_cfg_done = '1' then
                     prog_seq_fsm <= wait_proxy_resp_st;
                  end if;                  
               
               when wait_proxy_resp_st =>     -- on attend la réponse du proxy
                  if send_cfg_done = '1' then
                     if serial_cmd_failure = '1' then                        
                        prog_seq_fsm <= cmd_fail_mgmt_st;
                     else
                        prog_seq_fsm <= idle;                      
                     end if;                                       
                  end if;
               
               when cmd_fail_mgmt_st =>
                  if proxy_rdy_i = '1' then 
                     if serial_err_cnt = 10 then
                        prog_seq_fsm <= idle;    -- on fait 10 envois infructueuses de la même commande avant de generer une erreur fatale
                        serial_fatal_err_i <= '1';
                     else
                        serial_err_cnt <= serial_err_cnt + 1;
                        prog_seq_fsm <= send_cfg_st;
                     end if;
                  else
                     if SERIAL_ABORT = '1' then
                        prog_seq_fsm <= idle;
                     else                        
                        prog_seq_fsm <= send_cfg_st;
                     end if;
                  end if;
                  
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;   
   
   --------------------------------------------------  
   -- gestion de la configuration                                  
   --------------------------------------------------
   -- 1) copie de la config de la zone MB vers la zone sécurisée 
   -- 2) envoie de la config de la zone sécurisée vers le proxy
   
   -- ATTENTION !!!!!!!!!!!!  la simulation montre que les fifos du xuart se comportent comme des fifos standard et pas comme des fwft. 
   --  Cela veut dire que les données valides ne sont pas sur les outputs. Il faut lire es fifos et se vbaser sur les reeponses axi.
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            cfg_mgmt_fsm <=  idle;
            cpy_cfg_done <= '0';
            send_cfg_done <= '0';
            ram_wr_i <= '0';
            ram_rd_i <= '0';
            trig_i <= '0';
            trig_last <= '0';
            trig_rising <= '0';
            serial_cmd_failure <= '0';
            cfg_fifo_rd_en <= '0'; 
            cfg_byte_total <= (others => '1'); -- fait exprès pour validation facile en simulation
            uart_tbaud_clk_en_last <= '0';
            cmd_resp_en <= '0';
            cfg_fifo_wr_en <= '0';
            tx_dval_i <= '0';
            proxy_rdy_i <= '0';
            temp_trig_last <= '0';
            force_xtra_trig_mode <= '0';
            PRIM_XTRA_TRIG_ACTIVE <= '0';
            -- pragma translate_off
            tx_data_i <= (others => '0');
            -- pragma translate_on
         else             
            trig_i  <= XTRA_TRIG or ACQ_TRIG; 
            trig_last  <= trig_i;            
            trig_rising  <= trig_i and not trig_last;
            uart_tbaud_clk_en_last <= uart_tbaud_clk_en;
            temp_trig_last <= temp_trig;
            --fsm de contrôle            
            case  cfg_mgmt_fsm is 
               
               when idle =>
                  cpy_cfg_done <= '1';
                  send_cfg_done <= '1';
                  tx_dval_i <= '0';
                  ram_wr_i <= '0';
                  ram_rd_i <= '0';
                  timeout_cnt <= (others => '0');
                  cfg_byte_cnt <= (others => '0');                  
                  cfg_payload <= (others => '0');
                  cfg_fifo_rd_en <= '0';
                  uart_tbaud_cnt <= (others => '0');
                  cfg_fifo_wr_en <= '0';
                  force_xtra_trig_mode <= '0';
                  PRIM_XTRA_TRIG_ACTIVE <= '0';
                  if cpy_cfg_en = '1' then
                     cpy_cfg_done <= '0';
                     cfg_mgmt_fsm <= cpy_cfg_rd_st;
                     if RST_ERROR_EN = '1' then
                        serial_cmd_failure <= '0';
                     end if;
                  elsif send_cfg_en = '1' then
                     send_cfg_done <= '0';
                     cfg_mgmt_fsm <= init_send_st;
                     if RST_ERROR_EN = '1' then 
                        serial_cmd_failure <= '0';
                     end if;
                  end if;
                  
               -- partie copy de la config vers une zone securisée             
               when cpy_cfg_rd_st =>   -- la config est copiee de la zone A vers un fifo (avant de partir en zone sécurisée)                       
                  ram_wr_i <= '0';     -- ram en mode lecture
                  ram_rd_i <= '1';
                  cfg_byte_cnt <= cfg_byte_cnt + 1;
                  ram_rd_add_i <= resize(unsigned(SERIAL_BASE_ADD), ram_rd_add_i'length) + cfg_byte_cnt(ram_rd_add_i'length-1 downto 0);
                  if ram_rd_add_i(7 downto 0) = SCD_LONGEST_CMD_BYTES_NUM then  -- on en copie plus qu'il n'en faut mais cela simplifie le code
                     cfg_mgmt_fsm <= init_cpy_wr_st;
                     ram_rd_i <= '0';
                  end if;
                  cfg_fifo_wr_en <= RAM_RD_DVAL; 
                  cfg_fifo_din <= RAM_RD_DATA;
               
               when init_cpy_wr_st =>     -- zone securisée en ecriture
                  cfg_fifo_wr_en <= '0';
                  cfg_byte_cnt <= (others => '0');
                  ram_wr_add_i <= to_unsigned(SCD_CMD_SECUR_RAM_BASE_ADD, ram_wr_add_i'length); -- zone securisée sera en ecriture
                  cfg_mgmt_fsm <= cpy_cfg_wr_st;
               
               when cpy_cfg_wr_st =>  -- la config est copiee  du fifo vers la zone securisée B  
                  cfg_fifo_rd_en <= '1';                                      -- on peut commencer la lecture les yeux fermées car le fifo contient déjà des données quand on arrive ici     
                  if cfg_fifo_dval = '1' then
                     ram_rd_i <= '0';
                     ram_wr_i <= '1';                                         -- ram en mode ecriture  
                     ram_wr_add_i(7 downto 0) <= cfg_byte_cnt(7 downto 0);    -- la config est copiée dans la zone securisée. (7 downto 0) permet de ne pas toucher à l'adresse de base
                     ram_wr_data_i <= cfg_fifo_dout;
                     cfg_byte_cnt <= cfg_byte_cnt + 1;                     
                     if cfg_byte_cnt    = 3 then               -- 3 car cfg_byte_cnt commence à 0
                        cfg_payload(7 downto 0) <= cfg_fifo_dout;  -- payload de la config selon SCD
                     elsif cfg_byte_cnt = 4 then
                        cfg_payload(15 downto 8) <= cfg_fifo_dout; -- payload de la config selon SCD
                        cfg_byte_total <=  (unsigned(cfg_fifo_dout) & unsigned(cfg_payload(7 downto 0))) + SCD_CMD_OVERHEAD_BYTES_NUM; -- nombre de bytes total de la config                        
                     end if;
                  end if;
                  if cfg_fifo_empty = '1' then
                     cfg_mgmt_fsm <= idle;
                     cfg_fifo_rd_en <= '0'; 
                  end if;
                  
               -- partie envoi de la config vers le détecteur
               when init_send_st =>            
                  tx_dval_i <= '0';
                  cfg_byte_cnt <= (others => '0'); 
                  ram_rd_add_i <= to_unsigned(SCD_CMD_SECUR_RAM_BASE_ADD, ram_rd_add_i'length); -- zone securisée sera en lecture
                  --if unsigned(SERIAL_BASE_ADD) = to_unsigned(SCD_TEMP_CMD_RAM_BASE_ADD, SERIAL_BASE_ADD'length)  then  
                  --   cfg_mgmt_fsm <= wait_temp_trig_st; 
                  --else                                                 -- sinon on attend un trig pour lancer la programmation (suggestion de PDA pour avoir une chance de voir la config appliqée au prochain trig)
                  if unsigned(SERIAL_BASE_ADD) = to_unsigned(SCD_OP_CMD_RAM_BASE_ADD, SERIAL_BASE_ADD'length)  then -- si cmd OP, alors obligatoirement mode xtra_trig forcé.
                     force_xtra_trig_mode <= '1'; 
                  end if;
                  -- finalement, pas besoin de trig de synchro pour configurer le edtecteur. 
                  -- ainsi Si c'est le temps d'integration EHDRI, pas de delai car il est déja synchro sur montée du signal d'integration. l
                  --if trig_rising = '1' then     
                  cfg_mgmt_fsm <= send_cfg_rd_st;
                  --end if;
                  --end if;
               
               when  wait_temp_trig_st =>
                  --if temp_trig = '1' and temp_trig_last = '0' then  -- les lectures de temps sont espacées de 1 sec au moins pour ne pas inonder le proxy
                  cfg_mgmt_fsm <= send_cfg_rd_st;
                  --end if;
               
               when send_cfg_rd_st =>          -- on lit un byte dans la zone sécurisée
                  ram_wr_i <= '0';     
                  ram_rd_i <= '1';
                  tx_dval_i <= '0';
                  cfg_mgmt_fsm <= latch_data_st;
               
               when latch_data_st =>          -- on latche le byte lu
                  ram_rd_i <= '0';                  
                  if RAM_RD_DVAL = '1' then
                     cfg_byte <= RAM_RD_DATA;
                     cfg_byte_cnt  <= cfg_byte_cnt + 1;
                     cfg_mgmt_fsm <= send_cfg_out_st;                     
                  end if;
               
               when send_cfg_out_st =>       -- on envoie le byte latché
                  tx_dval_i <= '0';
                  if TX_AFULL = '0' then
                     tx_dval_i <= '1';
                     tx_data_i <= cfg_byte;
                     cfg_mgmt_fsm <= check_frm_end_st; 
                  end if;
               
               when check_frm_end_st =>
                  tx_dval_i <= '0';
                  if cfg_byte_cnt = cfg_byte_total then
                     cfg_mgmt_fsm <= wait_tx_fifo_empty_st;
                     cmd_resp_en <= '1';
                  else
                     cfg_mgmt_fsm <= send_cfg_rd_st;
                     ram_rd_add_i <= ram_rd_add_i + 1;  -- mis ici expres (incr pour la prochaine lecture)
                  end if;                  
               
               when wait_tx_fifo_empty_st =>                  
                  if TX_EMPTY = '1' then 
                     cfg_mgmt_fsm <= uart_pause_st;
                     PRIM_XTRA_TRIG_ACTIVE <= force_xtra_trig_mode;  -- ici on force le mode Xtra_trig
                  end if;
               
               when uart_pause_st =>                  
                  timeout_cnt <= (others => '0');
                  if uart_tbaud_clk_en = '1' and uart_tbaud_clk_en_last = '0' then
                     uart_tbaud_cnt <= uart_tbaud_cnt + 1;                   
                     if uart_tbaud_cnt = 10 then          --  assure que le dernier byte est transmis
                        cfg_mgmt_fsm <= wait_proxy_resp_st;  
                     end if;                  
                  end if;        
               
               when wait_proxy_resp_st =>
                  timeout_cnt <= timeout_cnt + 1;                  
                  if cmd_resp_done = '1' and cmd_resp_done_last = '0' then
                     cfg_mgmt_fsm <= cmd_resp_mgmt_st;                                        
                  else
                     if timeout_cnt = 5_000_000 then   -- donne 50 ms sec au proxy pour donner une réponse                     
                        cfg_mgmt_fsm <= timeout_mgmt_st;
                     end if; 
                     -- pragma translate_off
                     if timeout_cnt = 50_000 then                      
                        cfg_mgmt_fsm <= timeout_mgmt_st;
                     end if;
                     -- pragma translate_on
                  end if;
               
               when cmd_resp_mgmt_st => 
                  if proxy_serial_err = '1' then
                     serial_cmd_failure  <= '1';                    
                  else
                     proxy_rdy_i <= '1';
                  end if;
                  cfg_mgmt_fsm <= idle;
               
               when timeout_mgmt_st =>
                  serial_cmd_failure  <= '1';
                  cfg_mgmt_fsm <= idle;                  
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;   
   
   --------------------------------------------------
   -- Generateur pour uart_tbaud_clk_pulse
   -------------------------------------------------- 
   U4: Clk_Divider
   Generic map(Factor=> SCD_SERIAL_TX_CLK_FACTOR)
   Port map( Clock => CLK, Reset => sreset, Clk_div => uart_tbaud_clk_en);
   
   --------------------------------------------------
   -- Generateur pour temp_trig
   -------------------------------------------------- 
   U5: Clk_Divider   -- horloge de periode 1 sec pour lancer la lecture de temperature
   Generic map(Factor=> SCD_TEMP_TRIG_PERIOD_FACTOR
      -- pragma translate_off
      /100_000
      -- pragma translate_on
      )
   Port map( Clock => CLK, Reset => sreset, Clk_div => temp_trig);
   
   --------------------------------------------------  
   -- Gestion des erreurs                                 
   --------------------------------------------------
   -- vérifier si la réponse reçue du proxy valide la commande envoyée ou pas
   U6 : process(CLK)
      variable temp_diode : unsigned(15 downto 0);
      variable temp_gnd   : unsigned(15 downto 0);
      
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then  
            cmd_resp_fsm <= wait_resp_hder_st;
            rx_data_cnt <= (others => '0');
            proxy_serial_err <= '0';
            rx_rd_en_i <= '0';
            cmd_resp_done <= '0';
            cmd_resp_done_last <= '0';
            fpa_temp_reg_dval <= '0';
            resp_dcnt <= (others => '0');
            fpa_temp_error <= '1'; -- à '1' tant qu'une lecture valide n'est pas reçue
         else
            
            cmd_resp_done_last <= cmd_resp_done;
            
            rx_rd_en_i <= not RX_EMPTY; -- par defaut
            
            case cmd_resp_fsm is               
               
               when wait_resp_hder_st =>   -- on cherche l'entête du header et on se synchronise dessus 
                  rx_data_cnt <= to_unsigned(1, rx_data_cnt'length);
                  rx_data_total <= (others => '1'); -- fait expres pour que bloquer la fsm dans l'etat decode_byte_st jusqu'à ;a recpetion de tous les bytes. Valeur mise à jour dans l'état decode_byte_st 
                  cmd_resp_done <= '1';
                  resp_err(1) <= '0';
                  for kk in 0 to 3 loop
                     failure_resp_data(kk) <= (others => '0');
                  end loop;
                  if RX_DVAL = '1' then                       
                     if  RX_DATA = SCD_COM_RESP_HDER then
                        cmd_resp_fsm <= decode_byte_st;
                        resp_hder <= RX_DATA;
                        rx_data_cnt <= to_unsigned(2, rx_data_cnt'length);
                     end if;
                  end if;
               
               when decode_byte_st => -- decodage du byte lu
                  cmd_resp_done <= '0';
                  if RX_DVAL = '1' then
                     rx_data_cnt <= rx_data_cnt + 1;                   
                     if rx_data_cnt = 1 then                         -- Header
                        resp_hder <= RX_DATA;
                     elsif rx_data_cnt = 2 then                      -- id
                        resp_id(7 downto 0) <= RX_DATA;
                     elsif rx_data_cnt = 3 then                      -- id
                        resp_id(15 downto 8) <= RX_DATA;
                     elsif rx_data_cnt = 4 then                      -- payload
                        resp_payload(7 downto 0) <= RX_DATA;
                     elsif rx_data_cnt = 5 then                      -- payload
                        resp_payload(15 downto 8) <= RX_DATA;
                        rx_data_total <=  (unsigned(RX_DATA) & unsigned(resp_payload(7 downto 0))) + SCD_CMD_OVERHEAD_BYTES_NUM;
                        resp_dcnt <= (others => '0');
                     elsif rx_data_cnt = rx_data_total then        -- checksum                                               
                        cmd_resp_fsm <= check_resp_st;
                        rx_rd_en_i <= '0';   -- on arrête la lecture du fifo
                     elsif rx_data_cnt = 32 then                     
                        cmd_resp_fsm <= wait_resp_hder_st;
                        proxy_serial_err <= '1'; 
                        resp_err(0) <= '1';
                     else                                               -- data
                        resp_data(to_integer(resp_dcnt)) <= RX_DATA;
                        resp_dcnt <= resp_dcnt + 1;
                     end if;                  
                  end if; 
               
               when check_resp_st =>   -- recherche du type de reponse reçue
                  rx_rd_en_i <= '0';   -- on arrête la lecture du fifo 
                  if resp_hder = SCD_COM_RESP_HDER then 
                     if resp_id = SCD_COM_RESP_FAILURE_ID then
                        proxy_serial_err <= '1';
                        resp_err(1) <= '1';
                        for kk in 0 to 3 loop
                           failure_resp_data(kk) <= resp_data(kk);
                        end loop;
                        cmd_resp_fsm <= wait_resp_hder_st;
                     elsif resp_id = SCD_TEMP_CMD_ID then
                        proxy_serial_err <= '0'; 
                        cmd_resp_fsm <= fpa_temp_resp_st;
                     else
                        proxy_serial_err <= '0'; 
                        cmd_resp_fsm <= wait_resp_hder_st;
                     end if;                     
                  else
                     proxy_serial_err <= '1';
                     resp_err(2) <= '1';
                     cmd_resp_fsm <= wait_resp_hder_st;
                  end if;
               
               when fpa_temp_resp_st =>  -- extraction de la température raw 
                  rx_rd_en_i <= '0';   -- on arrête la lecture du fifo 
                  temp_diode := unsigned(resp_data(1)) & unsigned(resp_data(0));
                  temp_gnd   := unsigned(resp_data(3)) & unsigned(resp_data(2));                   
                  if temp_diode /= temp_gnd then  -- au demarrage , le proxy renvoie (temp_diode - temp_gnd = 0). Ce qui pose problème. dès que cela est levé, la temperature lue est supposée valide
                     fpa_temp_error <= '0';
                  end if;              
                  if fpa_temp_error = '0' then 
                     fpa_temp_reg_dval <= '1';     
                     fpa_temp_reg <= temp_diode - temp_gnd;
                  end if;
                  
                  cmd_resp_fsm <= wait_resp_hder_st;
               
               when others =>
               
            end case;  
            
            
         end if;
      end if;
   end process;  
   
end RTL;
