------------------------------------------------------------------
--!   @file : scd_proxy2_serial_com
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

entity scd_proxy2_serial_com is
   port(
      ARESET                 : in std_logic;
      CLK                    : in std_logic;
      
      USER_CFG               : in fpa_intf_cfg_type;
      USER_CFG_IN_PROGRESS   : in std_logic;          -- à '1' lorsque USER_CFG et son équivalent seriel sont en cours d'envoi
      
      -- interface avec le contrôleur
      SERIAL_PARAM           : in serial_param_type;
      
      SERIAL_FATAL_ERR       : out std_logic;
      SERIAL_DONE            : out std_logic;
      
      PROXY_RDY              : out std_logic;
      
      -- TRIG de synchro
      ACQ_TRIG               : in std_logic;
      XTRA_TRIG              : in std_logic;
      PROG_TRIG              : out std_logic;
      
      -- interface avec la RAM1 : ram de la config MB et de la config Int
      RAM1_RD                : out std_logic;
      RAM1_RD_ADD            : out std_logic_vector(10 downto 0);
      RAM1_RD_DATA           : in std_logic_vector(7 downto 0);
      RAM1_RD_DVAL           : in std_logic;      
      
      -- interface avec la RAM2 : ram de securisation de la cfg à envoyer au proxy
      RAM2_WR                : out std_logic;
      RAM2_WR_ADD            : out std_logic_vector(10 downto 0);      
      RAM2_WR_DATA           : out std_logic_vector(7 downto 0);
      RAM2_RD                : out std_logic;
      RAM2_RD_ADD            : out std_logic_vector(10 downto 0);
      RAM2_RD_DATA           : in std_logic_vector(7 downto 0);
      RAM2_RD_DVAL           : in std_logic;
      
      -- temperature du détecteur
      FPA_TEMP_STAT         : out fpa_temp_stat_type;
      TRIG_CTLER_STAT       : in std_logic_vector(7 downto 0);
      ROIC_READ_REG         : out std_logic_vector(7 downto 0);
      ROIC_READ_REG_DVAL    : out std_logic;
      
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
      
      READOUT               : in std_logic      
      );
end scd_proxy2_serial_com;

architecture RTL of scd_proxy2_serial_com is  
   
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
   
   -------------------------------------
   -- RAM1:
   --       elle est réservée à l'écriture de la config en provenance du MB. Le MB étant totalement asynchrone, il peut y ecrire à tout moment
   --       pour eviter donc que la config soit corrompue par une autre pendant qu'on l'utilise pour programmer le détecteur, on copie la config de cette RAM vers une seconde avant qu'elle ne soit réecrite
   -- RAM2:
   --       c'est la zone sécurisée, la config est à l'abri de toute modification de la part du MB. Toute config ecrite dans cette zone sera envoyée au détecteur.
   --       comme la config est securisée, elle pourra etre renvoyée au détecteur N fois (redondance), si la communication est mauvaise.
   --------------------------------------
   
   type prog_seq_fsm_type is (idle, cpy_cfg_st, wait_end_cpy_cfg_st, send_cfg_st, wait_end_send_cfg_st, wait_proxy_resp_st, cmd_fail_mgmt_st);
   type cfg_mgmt_fsm_type is (idle, init_cpy_rd_st, cpy_cfg_rd_st1, cpy_cfg_rd_st2, init_send_st, prog_trig_start_st, prog_trig_end_st, send_cfg_rd_st, 
   latch_data_st, send_cfg_out_st, wait_tx_fifo_empty_st, wait_proxy_resp_st, check_frm_end_st, uart_pause_st, cmd_resp_mgmt_st, timeout_mgmt_st);  
   type cmd_resp_fsm_type is (idle, decode_byte_st, check_resp_st, fpa_temp_resp_st, roic_read_resp_st);
   type com_data_array_type  is array (0 to 32) of std_logic_vector(7 downto 0);
   type failure_resp_data_type  is array (0 to 3) of std_logic_vector(7 downto 0);
   type prog_trig_fsm_type is (idle, check_prog_img_st);
   
   signal prog_seq_fsm            : prog_seq_fsm_type;
   signal cfg_mgmt_fsm            : cfg_mgmt_fsm_type;
   signal cmd_resp_fsm            : cmd_resp_fsm_type;
   signal prog_trig_fsm           : prog_trig_fsm_type;
   signal resp_data               : com_data_array_type;
   signal sreset                  : std_logic;
   signal serial_fatal_err_i      : std_logic;
   signal serial_done_i           : std_logic;
   signal cpy_cfg_en              : std_logic;
   signal send_cfg_en             : std_logic;
   signal serial_err_cnt          : unsigned(2 downto 0);
   signal cpy_cfg_done            : std_logic;
   signal send_cfg_done           : std_logic;
   signal serial_cmd_failure      : std_logic;
   signal ram2_wr_add_i           : unsigned(RAM2_WR_ADD'range);
   signal ram1_rd_i               : std_logic;
   signal ram1_rd_add_i           : unsigned(RAM1_RD_ADD'range);
   signal ram2_rd_i               : std_logic;
   signal ram2_rd_add_i           : unsigned(RAM2_RD_ADD'range);
   signal timeout_cnt             : unsigned(23 downto 0);
   signal cfg_byte_cnt            : unsigned(15 downto 0);
   signal rx_data_cnt             : unsigned(15 downto 0);
   signal rx_data_total           : unsigned(15 downto 0);
   signal trig_i                  : std_logic;
   signal trig_last               : std_logic;
   signal trig_rising             : std_logic;
   signal cfg_byte                : std_logic_vector(7 downto 0);
   signal cmd_resp_done           : std_logic;
   signal cmd_resp_done_last      : std_logic;
   signal proxy_serial_err        : std_logic;
   signal resp_hder               : std_logic_vector(USER_CFG.INCOMING_COM_HDER'range);
   signal resp_id                 : std_logic_vector(USER_CFG.INCOMING_COM_FAIL_ID'range);
   signal resp_payload            : std_logic_vector(15 downto 0);
   signal uart_tbaud_clk_en       : std_logic;
   signal uart_tbaud_clk_en_last  : std_logic;
   signal uart_tbaud_cnt          : unsigned(7 downto 0);
   signal cmd_resp_en             : std_logic;
   signal fpa_temp_reg_dval       : std_logic;
   signal roic_read_reg_dval_i    : std_logic;
   signal fpa_temp_reg            : unsigned(15 downto 0);  
   signal roic_read_reg_i         : unsigned(7 downto 0);
   signal resp_dcnt               : unsigned(7 downto 0);
   signal tx_data_i               : std_logic_vector(7 downto 0);
   signal tx_dval_i               : std_logic;
   signal rx_rd_en_i              : std_logic;
   signal proxy_rdy_i             : std_logic;
   signal resp_err                : std_logic_vector(7 downto 0);
   signal failure_resp_data       : failure_resp_data_type;
   signal fpa_temp_error          : std_logic;
   signal force_prog_trig_mode    : std_logic;
   signal prog_trig_i             : std_logic;
   signal readout_i               : std_logic;
   signal readout_last            : std_logic;
   signal img_cnt                 : natural range 0 to (FPA_XTRA_IMAGE_NUM_TO_SKIP + 1);
   signal prog_trig_done          : std_logic; 
   signal prog_trig_done_last     : std_logic;
   signal prog_trig_start         : std_logic;
   signal prog_trig_start_last    : std_logic; 
   signal acq_mode                : std_logic;
   signal cmd_ram2_eof_add        : unsigned(SERIAL_PARAM.CMD_EOF_ADD'LENGTH-1 downto 0);

   --attribute dont_touch           : string;
   --attribute dont_touch of resp_hder            : signal is "true";
   --attribute dont_touch of resp_payload         : signal is "true";
   --attribute dont_touch of resp_dcnt            : signal is "true";
   --attribute dont_touch of resp_id              : signal is "true";
   
begin
   
   acq_mode <= TRIG_CTLER_STAT(4);
   
   SERIAL_FATAL_ERR <= serial_fatal_err_i;
   SERIAL_DONE <= serial_done_i;
   PROXY_RDY <= proxy_rdy_i;
   
   RAM1_RD <= ram1_rd_i;                           
   RAM1_RD_ADD <= std_logic_vector(ram1_rd_add_i); 
   
   RAM2_WR <= RAM1_RD_DVAL;   
   RAM2_WR_ADD <= std_logic_vector(ram2_wr_add_i);
   RAM2_WR_DATA <= RAM1_RD_DATA; 
   
   RAM2_RD <= ram2_rd_i;     
   RAM2_RD_ADD <= std_logic_vector(ram2_rd_add_i);  
   
   TX_DVAL <= tx_dval_i;
   TX_DATA <= tx_data_i;
   RX_RD_EN <= rx_rd_en_i;
   
   FPA_TEMP_STAT.TEMP_DATA <= std_logic_vector(resize(fpa_temp_reg, FPA_TEMP_STAT.TEMP_DATA'LENGTH));
   FPA_TEMP_STAT.TEMP_DVAL <= fpa_temp_reg_dval;
   FPA_TEMP_STAT.FPA_PWR_ON_TEMP_REACHED <= '1';        -- fait expres pour le scd_proxy2 car il n'allume le detecteur que lorsque la temperature est ok. 
   
   PROG_TRIG <= prog_trig_i;
   ROIC_READ_REG_DVAL <= roic_read_reg_dval_i; 
   ROIC_READ_REG      <= std_logic_vector(roic_read_reg_i);
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1A : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   --------------------------------------------------
   -- synchro readout 
   --------------------------------------------------    
   U1B : double_sync
   port map(
      CLK => CLK,
      D   => READOUT,
      Q   => readout_i,
      RESET => sreset
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
                  if SERIAL_PARAM.RUN = '1' and cpy_cfg_done = '1' then
                     serial_done_i <= '0';
                     if RST_ERROR_EN = '1' then 
                        serial_fatal_err_i <= '0';
                     end if;
                     prog_seq_fsm <= cpy_cfg_st;
                  end if; 
               
               when cpy_cfg_st =>              -- la config est copiée de de la RAM1 vers la RAM2 sécurisée                  
                  cpy_cfg_en <= '1';
                  if cpy_cfg_done = '0' then
                     cpy_cfg_en <= '0';
                     prog_seq_fsm <= wait_end_cpy_cfg_st;
                  end if;
               
               when wait_end_cpy_cfg_st =>     -- fin de la copie de la config
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
                     if SERIAL_PARAM.ABORT = '1' then
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
   
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            cfg_mgmt_fsm <=  idle;
            cpy_cfg_done <= '0';
            send_cfg_done <= '0';
            ram1_rd_i <= '0';
            ram2_rd_i <= '0';
            trig_i <= '0';
            trig_last <= '0';
            trig_rising <= '0';
            serial_cmd_failure <= '0'; 
            uart_tbaud_clk_en_last <= '0';
            cmd_resp_en <= '0';
            tx_dval_i <= '0';
            proxy_rdy_i <= '0';
            force_prog_trig_mode <= '0';   
            prog_trig_start <= '0';
            prog_trig_done_last <= '0';
            -- pragma translate_off
            tx_data_i <= (others => '0');
            -- pragma translate_on  
            
         else             
            
            trig_i  <= XTRA_TRIG or ACQ_TRIG; 
            trig_last  <= trig_i;            
            trig_rising  <= trig_i and not trig_last;
            uart_tbaud_clk_en_last <= uart_tbaud_clk_en;
            
            prog_trig_done_last <= prog_trig_done;
            
            cmd_ram2_eof_add  <= SERIAL_PARAM.CMD_EOF_ADD - SERIAL_PARAM.CMD_SOF_ADD;
            
            if RAM1_RD_DVAL = '1' then
               ram2_wr_add_i <= ram2_wr_add_i + 1;                     
            end if;
            
            
            --fsm de contrôle            
            case  cfg_mgmt_fsm is 
               
               when idle =>
                  cpy_cfg_done <= '1';
                  send_cfg_done <= '1';
                  tx_dval_i <= '0';
                  ram1_rd_i <= '0';
                  ram2_rd_i <= '0';
                  timeout_cnt <= (others => '0');
                  cfg_byte_cnt <= (others => '0');                  
                  uart_tbaud_cnt <= (others => '0');
                  force_prog_trig_mode <= '0';
                  prog_trig_start <= '0';
                  
                  if cpy_cfg_en = '1' then
                     cpy_cfg_done <= '0';
                     cfg_mgmt_fsm <= cpy_cfg_rd_st1;
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
               when cpy_cfg_rd_st1 =>   -- on valide que la RAM1 n'est pas en ecriture
                  ram2_wr_add_i <= to_unsigned(0, ram2_wr_add_i'length);
                  if USER_CFG_IN_PROGRESS = '0' then 
                     cfg_mgmt_fsm <= cpy_cfg_rd_st2;
                  end if;
               
               when cpy_cfg_rd_st2 =>   -- la config est copiee de la ram1 vers la ram2 (zone sécurisée)                       
                  ram1_rd_i <= '1';
                  cfg_byte_cnt  <= cfg_byte_cnt + 1;
                  ram1_rd_add_i <= resize(SERIAL_PARAM.CMD_SOF_ADD, ram1_rd_add_i'length) + cfg_byte_cnt(ram1_rd_add_i'length-1 downto 0);                        
                  if ram1_rd_add_i(7 downto 0) = to_integer(SERIAL_PARAM.CMD_EOF_ADD) then 
                     cfg_mgmt_fsm <= idle;
                     ram1_rd_i <= '0';
                  end if;
                  
               -- partie envoi de la config vers le détecteur
               when init_send_st =>            
                  tx_dval_i <= '0';
                  cfg_byte_cnt <= (others => '0'); 
                  ram2_rd_add_i <= to_unsigned(0, ram2_rd_add_i'length); -- zone securisée sera en lecture                  
                  if SERIAL_PARAM.PROG_TRIG_MODE = '1' then
                     force_prog_trig_mode <= '1';
                     cfg_mgmt_fsm <= prog_trig_start_st; 
                  else
                     cfg_mgmt_fsm <= send_cfg_rd_st;   
                  end if;
               
               when prog_trig_start_st =>
                  prog_trig_start <= '1';
                  if prog_trig_done = '0' then 
                     prog_trig_start <= '0';
                     cfg_mgmt_fsm <= prog_trig_end_st;			   
                  end if;
               
               when prog_trig_end_st =>
                  if prog_trig_done = '1' then
                     if force_prog_trig_mode = '1' then
                        cfg_mgmt_fsm <= send_cfg_rd_st;
                     else
                        cfg_mgmt_fsm <= idle;
                     end if;
                  end if;
               
               when send_cfg_rd_st =>          -- on lit un byte dans la zone sécurisée     
                  ram2_rd_i <= '1';
                  tx_dval_i <= '0';
                  cfg_mgmt_fsm <= latch_data_st;
               
               when latch_data_st =>          -- on latche le byte lu
                  ram2_rd_i <= '0';                  
                  if RAM2_RD_DVAL = '1' then 
                     cfg_byte <= RAM2_RD_DATA; 
                     cfg_mgmt_fsm <= send_cfg_out_st; 
                  end if;
               
               when send_cfg_out_st =>       -- on envoie le byte latché
                  tx_dval_i <= '0';
                  if TX_AFULL = '0' then
                     tx_dval_i <= '1';
                     tx_data_i <= cfg_byte;
                     cfg_mgmt_fsm <= check_frm_end_st; 
                  end if;
                  -- pragma translate_off
                  tx_dval_i <= '1';
                  tx_data_i <= cfg_byte;
                  cfg_mgmt_fsm <= check_frm_end_st;
                  -- pragma translate_on 
               
               when check_frm_end_st =>
                  tx_dval_i <= '0';
                  if ram2_rd_add_i = to_integer(cmd_ram2_eof_add) then
                     cfg_mgmt_fsm <= wait_tx_fifo_empty_st;
                     cmd_resp_en <= '1';
                  else
                     cfg_mgmt_fsm <= send_cfg_rd_st;
                     ram2_rd_add_i <= ram2_rd_add_i + 1;  -- mis ici expres (incr pour la prochaine lecture)
                  end if;
               
               when wait_tx_fifo_empty_st =>                  
                  if TX_EMPTY = '1' then 
                     cfg_mgmt_fsm <= uart_pause_st;
                  end if;
                  -- pragma translate_off
                  cfg_mgmt_fsm <= uart_pause_st;
                  -- pragma translate_on
               
               when uart_pause_st =>                  
                  timeout_cnt <= (others => '0');
                  if uart_tbaud_clk_en = '1' and uart_tbaud_clk_en_last = '0' then
                     uart_tbaud_cnt <= uart_tbaud_cnt + 1;                   
                     if uart_tbaud_cnt = 10 then          --  assure que le dernier byte est transmis
                        cfg_mgmt_fsm <= wait_proxy_resp_st;  
                     end if;                  
                  end if; 
                  -- pragma translate_off
                  cfg_mgmt_fsm <= wait_proxy_resp_st;
                  -- pragma translate_on
               
               when wait_proxy_resp_st =>
                  timeout_cnt <= timeout_cnt + 1;                  
                  if cmd_resp_done = '1' and cmd_resp_done_last = '0' then
                     cfg_mgmt_fsm <= cmd_resp_mgmt_st;                                        
                  else
                     if timeout_cnt = 5_000_000 then   -- donne 50 ms sec au proxy pour donner une réponse
                           cfg_mgmt_fsm <= timeout_mgmt_st;
                     end if;
                     -- pragma translate_off                     
                     cfg_mgmt_fsm <= cmd_resp_mgmt_st;
                     -- pragma translate_on
                  end if;
               
               when cmd_resp_mgmt_st => 
                  if proxy_serial_err = '1' then
                     serial_cmd_failure  <= '1';
                     cfg_mgmt_fsm <= idle;                    
                  else
                     proxy_rdy_i <= '1';   
                     if force_prog_trig_mode = '1' then
                        force_prog_trig_mode <= '0';
                        cfg_mgmt_fsm <= prog_trig_start_st;
                     else
                        cfg_mgmt_fsm <= idle; 
                     end if;              
                  end if;
               
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
   Generic map(Factor=> SERIAL_TX_CLK_FACTOR)
   Port map( Clock => CLK, Reset => sreset, Clk_div => uart_tbaud_clk_en);
   
   --------------------------------------------------  
   -- Gestion des prog_trigs                             
   --------------------------------------------------  
   U5 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            prog_trig_done <= '1';
            prog_trig_i <= '0';
            prog_trig_start_last <= '0';
            prog_trig_fsm <= idle;
            img_cnt <= 0;
            readout_last <= '0';
         else             
            
            
            prog_trig_start_last <= prog_trig_start;
            readout_last <= readout_i;      
            
            case  prog_trig_fsm is 
               
               when idle =>  
                  img_cnt <= 0;
                  prog_trig_done <= '1';
                  prog_trig_i <= '0';  
                  
                  if prog_trig_start = '1' then
                     prog_trig_fsm <= check_prog_img_st;
                     prog_trig_i <= '1';
                  end if;
               
               when check_prog_img_st =>                     
                  prog_trig_done <= '0';
                  if readout_last = '1' and readout_i = '0' and acq_mode = '0' then 
                     img_cnt <= img_cnt + 1;
                  end if;
                  if img_cnt >= FPA_XTRA_IMAGE_NUM_TO_SKIP then                        
                     prog_trig_fsm <= idle;    
                  end if; 
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------  
   -- Gestion des erreurs                                 
   --------------------------------------------------
   -- vérifier si la réponse reçue du proxy valide la commande envoyée ou pas
   U6 : process(CLK)
      variable temp_diode      : unsigned(15 downto 0);
      variable temp_gnd        : unsigned(15 downto 0);  
      
      
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then  
            cmd_resp_fsm <= idle;
            rx_data_cnt <= (others => '0');
            proxy_serial_err <= '0';
            rx_rd_en_i <= '0';
            cmd_resp_done <= '0';
            cmd_resp_done_last <= '0';
            fpa_temp_reg_dval <= '0'; 
            roic_read_reg_dval_i <= '0';  
            roic_read_reg_i <= (others => '1');
            resp_dcnt <= (others => '0');
            fpa_temp_error <= '1'; -- à '1' tant qu'une lecture valide n'est pas reçue
         else
            
            cmd_resp_done_last <= cmd_resp_done;
            
            rx_rd_en_i <= not RX_EMPTY; -- par defaut
            
            case cmd_resp_fsm is               
               
               when idle =>   -- on cherche l'entête du header et on se synchronise dessus 
                  rx_data_cnt <= to_unsigned(1, rx_data_cnt'length);
                  rx_data_total <= (others => '1'); -- fait expres pour que bloquer la fsm dans l'etat decode_byte_st jusqu'à ;a recpetion de tous les bytes. Valeur mise à jour dans l'état decode_byte_st 
                  cmd_resp_done <= '1';
                  resp_err(1) <= '0';
                  for kk in 0 to 3 loop
                     failure_resp_data(kk) <= (others => '0');
                  end loop;
                  if RX_DVAL = '1' then                       
                     if  RX_DATA = USER_CFG.INCOMING_COM_HDER then
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
                        rx_data_total <=  (unsigned(RX_DATA) & unsigned(resp_payload(7 downto 0))) + to_integer(USER_CFG.INCOMING_COM_OVH_LEN);
                        resp_dcnt <= (others => '0');
                     elsif rx_data_cnt = rx_data_total then          -- checksum                                               
                        cmd_resp_fsm <= check_resp_st;
                        rx_rd_en_i <= '0';                           -- on arrête la lecture du fifo
                     elsif rx_data_cnt = 32 then                     
                        cmd_resp_fsm <= idle;
                        proxy_serial_err <= '1'; 
                        resp_err(0) <= '1';
                     else                                             -- data
                        resp_data(to_integer(resp_dcnt)) <= RX_DATA;
                        resp_dcnt <= resp_dcnt + 1;
                     end if;                  
                  end if;
               
               when check_resp_st =>   -- recherche du type de reponse reçue
                  rx_rd_en_i <= '0';   -- on arrête la lecture du fifo 
                  if resp_hder = USER_CFG.INCOMING_COM_HDER then 
                     if resp_id = USER_CFG.INCOMING_COM_FAIL_ID then
                        proxy_serial_err <= '1';
                        resp_err(1) <= '1';
                        for kk in 0 to 3 loop
                           failure_resp_data(kk) <= resp_data(kk);
                        end loop;
                        cmd_resp_fsm <= idle;   
                                                      
                     elsif resp_id = DEFINE_ROIC_READ_CMD then 
                        proxy_serial_err <= '0'; 
                        cmd_resp_fsm <= roic_read_resp_st;                        

                     elsif resp_id = USER_CFG.TEMP_CMD_ID then
                        proxy_serial_err <= '0'; 
                        cmd_resp_fsm <= fpa_temp_resp_st;
                     else
                        proxy_serial_err <= '0'; 
                        cmd_resp_fsm <= idle;
                     end if;                     
                  else
                     proxy_serial_err <= '1';
                     resp_err(2) <= '1';
                     cmd_resp_fsm <= idle;
                  end if;
               
               when fpa_temp_resp_st =>  -- extraction de la température raw 
                  rx_rd_en_i <= '0';   -- on arrête la lecture du fifo 
                  temp_diode := unsigned(resp_data(1)) & unsigned(resp_data(0));
                  temp_gnd   := (others => '0');  -- unsigned(resp_data(3)) & unsigned(resp_data(2));               
                  if temp_diode /= temp_gnd then  -- au demarrage , le proxy renvoie (temp_diode - temp_gnd = 0). Ce qui pose problème. dès que cela est levé, la temperature lue est supposée valide
                     fpa_temp_error <= '0';
                  end if;              
                  if fpa_temp_error = '0' then 
                     fpa_temp_reg_dval <= '1';     
                     fpa_temp_reg <= temp_diode - temp_gnd;
                  end if;
                  
                  cmd_resp_fsm <= idle;
               
                  
               when roic_read_resp_st =>  -- extraction de la valeur du registre
                  rx_rd_en_i <= '0';   -- on arrête la lecture du fifo 
                  roic_read_reg_dval_i <= '1';     
                  roic_read_reg_i <= unsigned(resp_data(0));
                  cmd_resp_fsm <= idle;   
                  
               when others =>
               
            end case; 
            
            if USER_CFG.failure_resp_management = '0' then 
               proxy_serial_err <= '0';
               resp_err <= (others => '0');  
            end if;
            
            
         end if;
      end if;
   end process;  
   
end RTL;
