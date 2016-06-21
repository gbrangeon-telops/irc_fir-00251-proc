------------------------------------------------------------------
--!   @file : scd_mblaze_intf
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
use work.fpa_common_pkg.all;
use work.FPA_define.all;
use work.Proxy_define.all;
use work.Tel2000.all;

entity scd_mblaze_intf is
   port(
      ARESET               : in std_logic;
      MB_CLK               : in std_logic;
      
      FPA_EXP_INFO         : in exp_info_type;
      
      MB_MOSI              : in t_axi4_lite_mosi;
      MB_MISO              : out t_axi4_lite_miso;
      
      RESET_ERR            : out std_logic;
      STATUS_MOSI          : out t_axi4_lite_mosi;
      STATUS_MISO          : in t_axi4_lite_miso;    
      CTRLED_RESET         : out std_logic;
      
      USER_CFG_IN_PROGRESS : out std_logic;
      USER_CFG             : out fpa_intf_cfg_type;
      COOLER_STAT          : out fpa_cooler_stat_type;
      
      SER_CFG_DATA         : out std_logic_vector(7 downto 0);
      SER_CFG_ADD          : out std_logic_vector(10 downto 0);
      SER_CFG_DVAL         : out std_logic;
      
      FPA_SOFTW_STAT       : out fpa_firmw_stat_type;
      
      ERR                  : out std_logic  
      );
end scd_mblaze_intf;


architecture rtl of scd_mblaze_intf is
   
   constant MB_SOURCE  : std_logic_vector(1 downto 0)   :=  "00";
   constant EXP_SOURCE : std_logic_vector(1 downto 0)   :=  "01";   
   constant SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_23  : natural := SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS + 23; --pour un total de 24 bits pour le temps d'integration de scd
   constant SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1   : natural := SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS - 1;
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;     
   
   type cfg_arbit_fsm_type is (idle, cfg_begin_pause_st, check_mb_serial_st, exp_cfg_st, mb_cfg_st, cfg_end_pause_st, wait_exp_done_st);
   type exp_cfg_gen_fsm_type is (idle, wait_conv_st, wait_arbiter_st, serial_exp_cfg_st, struct_exp_cfg_st);
   
   signal cfg_arbit_fsm                   : cfg_arbit_fsm_type;
   signal exp_cfg_gen_fsm                 : exp_cfg_gen_fsm_type;
   signal sreset                          : std_logic;
   signal axi_awaddr	                     : std_logic_vector(31 downto 0);
   signal axi_awready	                  : std_logic;
   signal axi_wready	                     : std_logic;
   signal axi_bresp	                     : std_logic_vector(1 downto 0);
   signal axi_bvalid	                     : std_logic;
   signal axi_araddr	                     : std_logic_vector(31 downto 0);
   signal axi_arready	                  : std_logic;
   signal axi_rdata	                     : std_logic_vector(31 downto 0);
   signal axi_rresp	                     : std_logic_vector(1 downto 0);
   signal axi_rvalid	                     : std_logic;
   signal axi_wstrb                       : std_logic_vector(3 downto 0);   
   signal ser_cfg_dval_i                  : std_logic;
   signal ser_cfg_data_i                  : std_logic_vector(7 downto 0);
   signal mb_ser_cfg_data                 : std_logic_vector(7 downto 0);
   signal ser_cfg_add_i                   : std_logic_vector(SER_CFG_ADD'range);
   signal mb_ser_cfg_add                  : std_logic_vector(SER_CFG_ADD'range);
   signal exp_cfg_en                      : std_logic;
   signal user_cfg_in_progress_i          : std_logic;
   signal dly_cnt                         : unsigned(4 downto 0);
   signal mb_serial_assump_err            : std_logic;
   signal mb_cfg_rqst                     : std_logic;
   signal cfg_source                      : std_logic_vector(MB_SOURCE'range);
   signal exp_cfg_rqst                    : std_logic;
   signal mb_cfg_serial_in_progress       : std_logic;
   signal mb_cfg_serial_in_progress_last  : std_logic;
   signal mb_ser_cfg_dval                 : std_logic;
   signal mb_struct_cfg                   : fpa_intf_cfg_type;
   signal user_cfg_i                      : fpa_intf_cfg_type;
   signal exp_cfg_done                    : std_logic;
   signal exp_ser_cfg_add                 : std_logic_vector(SER_CFG_ADD'range);
   signal exp_ser_cfg_data                : std_logic_vector(7 downto 0);
   signal exp_ser_cfg_dval                : std_logic;
   signal exp_struct_cfg_valid            : std_logic;
   signal exp_time_i                      : unsigned(24 downto 0); -- en coups d'horloge de 100Mhz. Comme scd_exp_time_i tient sur 24 bits alors (2^24-1)*12.5/10 tiendra sur 25 bits
   signal exp_indx_i                      : std_logic_vector(7 downto 0);
   signal exp_checksum                    : unsigned(7 downto 0);
   signal byte_cnt                        : unsigned(7 downto 0);
   signal idle_cnt                        : unsigned(7 downto 0);
   signal exp_cfg_in_progress             : std_logic;
   signal slv_reg_rden                    : std_logic;
   signal slv_reg_wren                    : std_logic;
   signal data_i                          : std_logic_vector(31 downto 0);
   signal fpa_softw_stat_i                : fpa_firmw_stat_type;
   signal mb_struct_cfg_valid             : std_logic;
   signal reset_err_i                     : std_logic;
   signal fpa_int_time_last               : unsigned(exp_time_i'range);
   signal scd_exp_time_i                  : unsigned(user_cfg_i.scd_int.scd_int_time'range);
   signal scd_exp_time_temp1              : unsigned(exp_time_i'length + SCD_EXP_TIME_CONV_NUMERATOR'length - 1 downto 0);
   signal scd_exp_time_temp2              : unsigned(user_cfg_i.scd_int.scd_int_time'range);
   signal ctrled_reset_i                  : std_logic;
   --signal fpa_int_indx_last               : std_logic;
   --signal fpa_manuf_diag_mode_last        : std_logic;
   
   -- attribute dont_touch                   : string;
   -- attribute dont_touch of user_cfg_i     : signal is "true";
   
   
   
begin
   
   CTRLED_RESET <= ctrled_reset_i;
   RESET_ERR <= reset_err_i;
   ERR <= mb_serial_assump_err;
   USER_CFG <= user_cfg_i;
   USER_CFG_IN_PROGRESS <= user_cfg_in_progress_i;
   FPA_SOFTW_STAT <= fpa_softw_stat_i;
   COOLER_STAT.COOLER_ON <= '1';   -- pour le SCD, on peut se le permettre car le proxy n'allumera le détecteur que si la température du FPA est bonne.
   
   -- I/O Connections assignments
   MB_MISO.AWREADY     <= axi_awready;
   MB_MISO.WREADY      <= axi_wready;
   MB_MISO.BRESP	     <= axi_bresp;
   MB_MISO.BVALID      <= axi_bvalid;
   MB_MISO.ARREADY     <= axi_arready;
   MB_MISO.RDATA	     <= axi_rdata;
   MB_MISO.RRESP	     <= axi_rresp;
   MB_MISO.RVALID      <= axi_rvalid; 
   
   -- ecriture dans la ram de hw_driver   
   SER_CFG_DATA  <= ser_cfg_data_i;
   SER_CFG_ADD   <= ser_cfg_add_i;
   SER_CFG_DVAL  <= ser_cfg_dval_i;
   
   -- STATUS_MOSI toujours envoyé au fpa_status_gen pour eviter des delais
   STATUS_MOSI.AWVALID <= '0';   -- registres de statut en mode lecture seulement
   STATUS_MOSI.AWADDR  <= (others => '0');   -- registres de statut en mode lecture seulement
   STATUS_MOSI.AWPROT  <= (others => '0'); -- registres de statut en mode lecture seulement
   STATUS_MOSI.WVALID  <= '0'; -- registres de statut en mode lecture seulement    
   STATUS_MOSI.WDATA   <= (others => '0'); -- registres de statut en mode lecture seulement 
   STATUS_MOSI.WSTRB   <= (others => '0'); -- registres de statut en mode lecture seulement 
   STATUS_MOSI.BREADY  <= '0'; -- registres de statut en mode lecture seulement
   STATUS_MOSI.ARVALID <= MB_MOSI.ARVALID;
   STATUS_MOSI.ARADDR  <= resize(MB_MOSI.ARADDR(9 downto 0), 32); -- (9 downto 0) permet d'adresser tous les registres de statuts 
   STATUS_MOSI.ARPROT  <= MB_MOSI.ARPROT; 
   STATUS_MOSI.RREADY  <= MB_MOSI.RREADY; 
   
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U1 : sync_reset
   port map(ARESET => ARESET, CLK => MB_CLK, SRESET => sreset); 
   
   
   --------------------------------
   -- Arbitreur des configs 
   --------------------------------
   U2: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            cfg_arbit_fsm <= idle;
            ser_cfg_dval_i <= '0';
            exp_cfg_en <= '0';
            user_cfg_in_progress_i <= '0';
            dly_cnt <= (others => '0');
            mb_serial_assump_err <= '0';
            
         else
            
            case cfg_arbit_fsm is
               
               when idle  =>
                  exp_cfg_en <= '0';
                  user_cfg_in_progress_i <= '0';
                  dly_cnt <= (others => '0');
                  mb_serial_assump_err <= mb_cfg_serial_in_progress;  -- erreur de design grave si la config serielle a commencé sans que le MB n'ait eu accces
                  if mb_cfg_rqst = '1' then  -- priorité à la config du MB car elle n'est pas latchée. Celle du temps d'intégration est latchée
                     cfg_source <= MB_SOURCE;
                     cfg_arbit_fsm <= cfg_begin_pause_st;
                     user_cfg_in_progress_i <= '1';   -- copieur alerté de la venue d'une config                  
                  elsif exp_cfg_rqst = '1' then
                     cfg_source <= EXP_SOURCE;
                     cfg_arbit_fsm <= cfg_begin_pause_st;
                     user_cfg_in_progress_i <= '1';  -- copieur alerté de la venue d'une config                    
                  end if;                 
               
               when cfg_begin_pause_st => 
                  dly_cnt <= dly_cnt + 1;
                  if dly_cnt = SERIAL_CFG_COPIER_START_DLY then
                     if cfg_source = MB_SOURCE then
                        cfg_arbit_fsm <= check_mb_serial_st;
                        fpa_int_time_last <= exp_time_i;  -- temps d'integration en coups de 100MHz latchée
                     else
                        cfg_arbit_fsm <= wait_exp_done_st;
                        exp_cfg_en <= '1';
                     end if;
                  end if;
               
               when check_mb_serial_st =>
                  dly_cnt <= (others => '0');
                  if mb_cfg_serial_in_progress = '0' then 
                     cfg_arbit_fsm <= mb_cfg_st;
                  else
                     cfg_arbit_fsm <= idle;
                     mb_serial_assump_err <= '1'; -- erreur grave de design. Normalement, la partie seriale ne devrait jamais commencer avant que l'arbitre ne donne acces au MB. Sinon, perte de config
                  end if;
               
               when mb_cfg_st =>  -- la config du MB est envoyée                   
                  ser_cfg_add_i <= mb_ser_cfg_add; 
                  ser_cfg_data_i <= mb_ser_cfg_data; 
                  ser_cfg_dval_i <= mb_ser_cfg_dval;
                  if mb_cfg_serial_in_progress = '0' and mb_cfg_serial_in_progress_last = '1' then -- fin de la comm serielle  
                     user_cfg_i.comn     <= mb_struct_cfg.comn;   -- partie structurale envoyée en fin de com serielle
                     user_cfg_i.scd_misc <= mb_struct_cfg.scd_misc;
                     user_cfg_i.scd_temp <= mb_struct_cfg.scd_temp;
                     if mb_struct_cfg.cmd_to_update_id = SCD_OP_CMD_ID then
                        user_cfg_i.scd_op   <= mb_struct_cfg.scd_op;
                     elsif mb_struct_cfg.cmd_to_update_id = SCD_DIAG_CMD_ID then
                        user_cfg_i.scd_diag <= mb_struct_cfg.scd_diag;
                     end if;
                     --user_cfg_i.comn.fpa_acq_trig_period_min <= mb_struct_cfg.comn.fpa_acq_trig_period_min;
                     cfg_arbit_fsm <= cfg_end_pause_st; 
                  end if;
               
               when wait_exp_done_st =>
                  dly_cnt <= (others => '0');
                  if exp_cfg_done = '0' then
                     exp_cfg_en <= '0';
                     cfg_arbit_fsm <= exp_cfg_st;
                  end if;  
               
               when exp_cfg_st =>  --
                  ser_cfg_add_i <= exp_ser_cfg_add; 
                  ser_cfg_data_i <= exp_ser_cfg_data; 
                  ser_cfg_dval_i <= exp_ser_cfg_dval;
                  if exp_struct_cfg_valid = '1' then
                     user_cfg_i.scd_int.scd_int_time <= scd_exp_time_i;
                     user_cfg_i.scd_int.scd_int_indx <= exp_indx_i;
                     --user_cfg_i.comn.fpa_acq_trig_period_min <= mb_struct_cfg.comn.fpa_acq_trig_period_min; 
                  elsif exp_cfg_done = '1' then 
                     cfg_arbit_fsm <= cfg_end_pause_st; 
                  end if;
               
               when cfg_end_pause_st =>  -- ce delai permet au copieur de hw_driver de commencer la copie de la ram avant l'arrivée d'une autre cfg
                  dly_cnt <= dly_cnt + 1;
                  user_cfg_in_progress_i <= '0';
                  if dly_cnt = SERIAL_CFG_COPIER_END_DLY then
                     cfg_arbit_fsm <= idle;                     
                  end if;
               
               when others =>                  
               
            end case;        
            
         end if;
      end if;
   end process;
   
   -----------------------------------------------------
   -- generateur de config temps d'intégration 
   -----------------------------------------------------
   U3A: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            exp_cfg_gen_fsm <= idle;
            exp_cfg_rqst <= '0';
            exp_checksum <= (others => '0');
            idle_cnt <= (others => '0');
            exp_struct_cfg_valid <= '0';
            exp_cfg_done <= '0';
            exp_ser_cfg_dval <= '0';
            exp_cfg_in_progress <= '0';
         else
            
            case exp_cfg_gen_fsm is
               
               when idle  =>
                  exp_cfg_done <= '1'; 
                  exp_cfg_rqst <= '0'; 
                  exp_checksum <= (others => '0');
                  idle_cnt <= (others => '0');
                  byte_cnt <= to_unsigned(1, byte_cnt'length); --
                  exp_struct_cfg_valid <= '0'; 
                  exp_ser_cfg_dval <= '0';
                  exp_cfg_in_progress <= '0';
                  if FPA_EXP_INFO.EXP_DVAL = '1' or exp_cfg_en = '1' then   -- le signal FPA_EXP_INFO.EXP_DVAL est déjà un pulse donc impossible de boucler plusieurs fois en revenant à idle
                     exp_time_i <= FPA_EXP_INFO.EXP_TIME(exp_time_i'range);
                     exp_indx_i <= FPA_EXP_INFO.EXP_INDX;  
                     exp_cfg_gen_fsm <= wait_conv_st;
                     exp_cfg_rqst <= '1'; 
                  end if;
               
               when wait_conv_st =>               -- on attend environ 7 MB_CLK pour donner du temps au convertisseur   
                  idle_cnt <= idle_cnt + 1;
                  if idle_cnt = 5 then 
                     exp_cfg_gen_fsm <= wait_arbiter_st; 
                  end if;    
               
               when wait_arbiter_st =>  -- on attend l'arbitreur
                  if exp_cfg_en = '1' then
                     exp_cfg_in_progress <= '1';
                     exp_cfg_rqst <= '0';
                     exp_cfg_gen_fsm <= serial_exp_cfg_st;
                     exp_cfg_done <= '0';
                     exp_ser_cfg_data <= (others => '0'); -- fait expres pour le bon calcul du checksum
                  end if;
               
               when serial_exp_cfg_st => -- sur autorisation de l'arbitreur, on envoie la partie serielle                  
                  exp_ser_cfg_dval <= '1'; 
                  exp_ser_cfg_add <= std_logic_vector(resize((byte_cnt - 1 + SCD_INT_CMD_RAM_BASE_ADD), exp_ser_cfg_add'length)); -- pour que premiere adresse impérativement 0
                  byte_cnt <= byte_cnt + 1;
                  exp_checksum <= exp_checksum + unsigned(exp_ser_cfg_data); -- somme sur 8 bits donc implicitement modulo 256. certes decalé mais les zeros entre byte8 et byte12 permettent à la valeur d'etre prête avant l'envoi
                  if    byte_cnt = 1  then exp_ser_cfg_data <= SCD_CMD_HDER;                       -- scd exp_time CMD Header
                  elsif byte_cnt = 2  then exp_ser_cfg_data <= SCD_INT_CMD_ID(7 downto 0);         -- scd exp_time CMD ID                 
                  elsif byte_cnt = 3  then exp_ser_cfg_data <= SCD_INT_CMD_ID(15 downto 8);        -- scd exp_time CMD ID                  
                  elsif byte_cnt = 4  then exp_ser_cfg_data <= SCD_INT_CMD_DLEN(7 downto 0);       -- scd exp_time data length                  
                  elsif byte_cnt = 5  then exp_ser_cfg_data <= SCD_INT_CMD_DLEN(15 downto 8);      -- scd exp_time data length 
                  elsif byte_cnt = 6  then exp_ser_cfg_data <= std_logic_vector(scd_exp_time_i(7 downto 0));             -- exp_time en coups de 80MHz       
                  elsif byte_cnt = 7  then exp_ser_cfg_data <= std_logic_vector(scd_exp_time_i(15 downto 8));            -- exp_time en coups de 80MHz  
                  elsif byte_cnt = 8  then exp_ser_cfg_data <= std_logic_vector(scd_exp_time_i(23 downto 16));           -- exp_time en coups de 80MHz  
                  elsif byte_cnt = 12 then                                                         -- checksum 
                     exp_ser_cfg_data <= std_logic_vector(unsigned(not std_logic_vector(exp_checksum)) + 1); -- le fait qu'il y ait des zeros entre byte8 et byte12 donne le temps au cheksum d'etre prêt avant le byte 12 
                     exp_cfg_gen_fsm <= struct_exp_cfg_st; 
                  else  -- si byte cnt entre 9 et 11  
                     exp_ser_cfg_data <= (others => '0'); -- le fait qu'il y ait des zeros entre byte8 et byte12 donne le temps au cheksum d'etre prêt avant le byte 12.
                  end if;              
               
               when struct_exp_cfg_st =>  -- on envoie ensuite la partie structurale
                  exp_ser_cfg_dval <= '0'; -- en fait ici, la partie structurale est exp_time_i qui est dejà connue. L'arbitreur l'enverra 
                  exp_cfg_gen_fsm <= idle;               
                  exp_struct_cfg_valid <= '1';
               
               when others =>                  
               
            end case;        
            
         end if;
      end if;
   end process; 
   
   
   ----------------------------------------------------------------------------
   -- Conversion du temps d'integration en coups de 80 MHz pour SCD
   ---------------------------------------------------------------------------- 
   -- il fait faire : int_time_80MHz = round(int_time_100MHz * 80/100)
   
   --    N = 26
   --    num   = floor(4*2^N/5);
   --    deno  = 2^N;
   --    int_time_80MHz_appr = floor(x*num/deno);
   --    if mod((x*num), deno) >= 2^(N-1) 
   --       xappr = xappr + 1;
   --    end 
   --    erreur = max(abs(int_time_80MHz_appr - int_time_80MHz)) < 0.5
   
   U3B: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         scd_exp_time_temp1 <= exp_time_i * SCD_EXP_TIME_CONV_NUMERATOR;
         scd_exp_time_temp2 <= scd_exp_time_temp1((SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_23) downto SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS);  -- soit une division par SCD_EXP_TIME_CONV_DENOMINATOR
         if scd_exp_time_temp1(SCD_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1) = '1' then  -- pour l'operation d'arrondi
            scd_exp_time_i <= scd_exp_time_temp2 + 1;
         else
            scd_exp_time_i <= scd_exp_time_temp2;
         end if;       
      end if;
   end process;
   
   
   ----------------------------------------------------------------------------
   -- CFG MB AXI RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U4: process (MB_CLK)
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
   -- CFG MB AXI RD : données vers µBlaze                                       
   ---------------------------------------------------------------------------- 
   U5: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then         
         
         if  MB_MOSI.ARADDR(10) = '1' then    -- adresse de base pour la lecture des statuts
            axi_rdata <= STATUS_MISO.RDATA; -- la donnée de statut est valide 1CLK après MB_MOSI.ARVALID            
         else 
            axi_rdata <= (others =>'1'); 
         end if;
         
      end if;     
   end process;   
   
   ----------------------------------------------------------------------------
   -- CFG MB AXI WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U6: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_awready <= '0'; 
            axi_wready <= '0';
         else            
            
            if (axi_awready = '0' and MB_MOSI.AWVALID = '1' and MB_MOSI.WVALID = '1') then -- 
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
   -- CFG MB AXI WR : reception configuration
   ----------------------------------------------------------------------------
   U7: process(MB_CLK)        -- 
   begin
      if rising_edge(MB_CLK) then
         if sreset = '1' then
            fpa_softw_stat_i.dval <= '0';
            mb_struct_cfg_valid <= '0';
            mb_cfg_serial_in_progress <= '0';
            mb_cfg_serial_in_progress_last <= '0';
            mb_cfg_rqst <= '0'; 
            mb_ser_cfg_dval <= '0';
            reset_err_i<= '0';
            fpa_softw_stat_i.fpa_input <= LVDS25; -- normaement c'est un mesureur de la tension de la banque du FPGA qui doit forunir cette info (sera fait dans sur une carte ADC). Mais pour la carte ACQ ce n'Est pas le cas.
            ctrled_reset_i <= '1';
            
         else 
            
            ctrled_reset_i <= '0';
            
            mb_cfg_serial_in_progress_last <= mb_cfg_serial_in_progress;
            
            if slv_reg_wren = '1' then 				
               
               if  axi_awaddr(10) = '1' then   -- données de configuration serielle, envoyées dans la ram du hw_driver
                  mb_cfg_rqst <= '0'; -- fait expres. Ainsi demande non traitée par l'arbitre avant le debut de la partie serielle est perdue. En principe par design, n'arrivera jamais.
                  mb_cfg_serial_in_progress <= '1'; 
                  mb_ser_cfg_add <= std_logic_vector(resize(axi_awaddr(9 downto 2),mb_ser_cfg_add'length));  -- Cela suppose que l'adresse du mB varie par pas de 4 
                  mb_ser_cfg_data <= data_i(7 downto 0); -- pour la partie serielle de la config, seule la partie (7 downto 0) est valide (voir le driver C)                  
                  mb_ser_cfg_dval <= '1';
                  if axi_awaddr(7 downto 0) = SERIAL_CFG_END_ADD then  -- adresse de fin de commande serielle
                     mb_cfg_serial_in_progress <= not data_i(0);
                     mb_ser_cfg_dval <= '0';
                  end if;
                  
               else   -- données pour config du bloc
                  
                  mb_cfg_serial_in_progress <= '0';
                  
                  if axi_wstrb = "1111" then  -- c'Est obligatoire d'envoyer les données de la config structurale sur 32 bits
                     
                     case axi_awaddr(7 downto 0) is 
                        
                        -- elements de config                                                                                                  
                        when X"00" =>    mb_struct_cfg.comn.fpa_diag_mode               <= data_i(0); mb_cfg_rqst <= '1';                       
                        when X"04" =>    mb_struct_cfg.comn.fpa_diag_type               <= data_i(mb_struct_cfg.comn.fpa_diag_type'length-1 downto 0); 
                        when X"08" =>    mb_struct_cfg.comn.fpa_pwr_on                  <= data_i(0);						
                        when X"0C" =>    mb_struct_cfg.comn.fpa_trig_ctrl_mode          <= data_i(mb_struct_cfg.comn.fpa_trig_ctrl_mode'length-1 downto 0);
                        when X"10" =>    mb_struct_cfg.comn.fpa_acq_trig_ctrl_dly       <= unsigned(data_i(mb_struct_cfg.comn.fpa_acq_trig_ctrl_dly'length-1 downto 0)); 						
                        when X"14" =>    mb_struct_cfg.comn.fpa_acq_trig_period_min     <= unsigned(data_i(mb_struct_cfg.comn.fpa_acq_trig_period_min'length-1 downto 0));                                    
                        when X"18" =>    mb_struct_cfg.comn.fpa_xtra_trig_ctrl_dly      <= unsigned(data_i(mb_struct_cfg.comn.fpa_xtra_trig_ctrl_dly'length-1 downto 0));                                    
                        when X"1C" =>    mb_struct_cfg.comn.fpa_xtra_trig_period_min    <= unsigned(data_i(mb_struct_cfg.comn.fpa_xtra_trig_period_min'length-1 downto 0));                                      
                        when X"20" =>    mb_struct_cfg.scd_op.scd_xstart                <= unsigned(data_i(mb_struct_cfg.scd_op.scd_xstart'length-1 downto 0));                                
                        when X"24" =>    mb_struct_cfg.scd_op.scd_ystart                <= unsigned(data_i(mb_struct_cfg.scd_op.scd_ystart'length-1 downto 0));                        
                        when X"28" =>    mb_struct_cfg.scd_op.scd_xsize                 <= unsigned(data_i(mb_struct_cfg.scd_op.scd_xsize'length-1 downto 0));                              
                        when X"2C" =>    mb_struct_cfg.scd_op.scd_ysize                 <= unsigned(data_i(mb_struct_cfg.scd_op.scd_ysize'length-1 downto 0));                                
                        when X"30" =>    mb_struct_cfg.scd_op.scd_gain                  <= data_i(mb_struct_cfg.scd_op.scd_gain'length-1 downto 0);                                                     
                        when X"34" =>    mb_struct_cfg.scd_op.scd_out_chn               <= data_i(0); 
                        when X"38" =>    mb_struct_cfg.scd_op.scd_diode_bias            <= data_i(mb_struct_cfg.scd_op.scd_diode_bias'length-1 downto 0);                        
                        when X"3C" =>    mb_struct_cfg.scd_op.scd_int_mode              <= data_i(mb_struct_cfg.scd_op.scd_int_mode'length-1 downto 0);                        
                        when X"40" =>    mb_struct_cfg.scd_op.scd_pix_res               <= data_i(mb_struct_cfg.scd_op.scd_pix_res'length-1 downto 0); 
                        when X"44" =>    mb_struct_cfg.scd_op.scd_frame_period_min      <= unsigned(data_i(mb_struct_cfg.scd_op.scd_frame_period_min'length-1 downto 0));                         
                        when X"48" =>    mb_struct_cfg.scd_diag.scd_bit_pattern         <= data_i(mb_struct_cfg.scd_diag.scd_bit_pattern'length-1 downto 0);                         
                        when X"4C" =>    mb_struct_cfg.scd_misc.scd_fig1_or_fig2_t6_dly <= unsigned(data_i(mb_struct_cfg.scd_misc.scd_fig1_or_fig2_t6_dly'length-1 downto 0));                       
                        when X"50" =>    mb_struct_cfg.scd_misc.scd_fig4_t1_dly         <= unsigned(data_i(mb_struct_cfg.scd_misc.scd_fig4_t1_dly'length-1 downto 0));                       
                        when X"54" =>    mb_struct_cfg.scd_misc.scd_fig4_t2_dly         <= unsigned(data_i(mb_struct_cfg.scd_misc.scd_fig4_t2_dly'length-1 downto 0));                        
                        when X"58" =>    mb_struct_cfg.scd_misc.scd_fig4_t6_dly         <= unsigned(data_i(mb_struct_cfg.scd_misc.scd_fig4_t6_dly'length-1 downto 0));                        
                        when X"5C" =>    mb_struct_cfg.scd_misc.scd_fig4_t3_dly         <= unsigned(data_i(mb_struct_cfg.scd_misc.scd_fig4_t3_dly'length-1 downto 0));                         
                        when X"60" =>    mb_struct_cfg.scd_misc.scd_fig4_t5_dly         <= unsigned(data_i(mb_struct_cfg.scd_misc.scd_fig4_t5_dly'length-1 downto 0));
                        when X"64" =>    mb_struct_cfg.scd_misc.scd_fig4_t4_dly         <= unsigned(data_i(mb_struct_cfg.scd_misc.scd_fig4_t4_dly'length-1 downto 0));                            
                        when X"68" =>    mb_struct_cfg.scd_misc.scd_fig1_or_fig2_t5_dly <= unsigned(data_i(mb_struct_cfg.scd_misc.scd_fig1_or_fig2_t5_dly'length-1 downto 0));
                        when X"6C" =>    mb_struct_cfg.scd_misc.scd_fig1_or_fig2_t4_dly <= unsigned(data_i(mb_struct_cfg.scd_misc.scd_fig1_or_fig2_t4_dly'length-1 downto 0));
                        when X"70" =>    mb_struct_cfg.scd_misc.scd_xsize_div2          <= unsigned(data_i(mb_struct_cfg.scd_misc.scd_xsize_div2'length-1 downto 0));
                        -- Id de la partie de mb_Struct_cg qu.il faut mettre à jour
                        when X"74" =>    mb_struct_cfg.cmd_to_update_id                 <= data_i(mb_struct_cfg.cmd_to_update_id'length-1 downto 0);
                           
                        -- mode diag manufacturier 
                        when X"B0" =>    mb_struct_cfg.scd_diag.scd_bit_pattern <= data_i(mb_struct_cfg.scd_diag.scd_bit_pattern'length-1 downto 0); mb_cfg_rqst <= '1'; -- bit pattern est utilisé par le pilote Hw pour programmer le détecteur                   
                           
                        -- trig lecture de temperatur(le changement de numero est vu comme un changement de config impliquant la repogrammation)
                        when X"D0" =>    mb_struct_cfg.scd_temp.scd_temp_read_num <= unsigned(data_i(mb_struct_cfg.scd_temp.scd_temp_read_num 'length-1 downto 0)); mb_cfg_rqst <= '1';
                           
                        -- fpa_softw_stat_i qui dit au sequenceur general quel pilote C est en utilisation
                        when X"E0" =>    fpa_softw_stat_i.fpa_roic   <= data_i(fpa_softw_stat_i.fpa_roic'length-1 downto 0);
                        when X"E4" =>    fpa_softw_stat_i.fpa_output <= data_i(fpa_softw_stat_i.fpa_output'length-1 downto 0); fpa_softw_stat_i.dval <='1';  
                           
                        -- pour effacer erreurs latchées
                        when X"EC" =>    reset_err_i <= data_i(0);
                           
                        -- pour un reset complet du module FPA
                        when X"F0" =>   ctrled_reset_i <= data_i(0); fpa_softw_stat_i.dval <='0'; -- ENO: 10 juin 2015: ce reset permet de mettre la sortie vers le DDC en 'Z' lorsqu'on etient la carte DDC et permet de faire un reset lorsqu'on allume la carte DDC
                        --fpa_softw_stat_i.dval <='0' permet de ne pas rallumer automatiquement la carte DDC après un reset controllé.
                        when others => --do nothing
                        
                     end case;
                  end if;
               end if;
            else
               mb_ser_cfg_dval <= '0';
            end if;
         end if;
      end if;
   end process;   
   
   -----------------------------------------------------
   -- CFG MB AXI WR  : WR feedback envoyé au MB
   -----------------------------------------------------
   U8: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            axi_bvalid  <= '0';
            axi_bresp   <= "00"; -- need to work more on the responses
         else
            if slv_reg_wren = '1' and axi_bvalid = '0' then
               axi_bvalid <= '1';
               axi_bresp  <= "00"; 
            elsif MB_MOSI.BREADY = '1' and axi_bvalid = '1' then   -- check if bready is asserted while bvalid is high)
               axi_bvalid <= '0';                                  -- (there is a possibility that bready is always asserted high)
            end if;
         end if;
      end if;
   end process;
   
end rtl;