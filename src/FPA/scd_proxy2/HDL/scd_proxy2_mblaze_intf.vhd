------------------------------------------------------------------
--!   @file : scd_proxy2_mblaze_intf
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
use IEEE.std_logic_misc.all;
use work.fpa_common_pkg.all;
use work.FPA_define.all;
use work.Proxy_define.all;
use work.Tel2000.all;

entity scd_proxy2_mblaze_intf is
   
   generic (
      G_FPA_PIX_NUM_PER_PCLK : integer := 4
      );
   
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
      
      MB_SER_CFG           : out t_axi4_stream_mosi16;
      EXP_SER_CFG          : out t_axi4_stream_mosi16;
      
      FPA_SOFTW_STAT       : out fpa_firmw_stat_type;
      
      ERR                  : out std_logic  
      );
end scd_proxy2_mblaze_intf;


architecture rtl of scd_proxy2_mblaze_intf is
   
   constant C_MB_SOURCE  : std_logic_vector(1 downto 0)   :=  "00";
   constant C_EXP_SOURCE : std_logic_vector(1 downto 0)   :=  "01";   
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_26    : natural := DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS + 26; --pour un total de 26 bits pour le temps d'integration de 0207
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1     : natural := DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS - 1;   
   constant C_DIAG_LOVH_MCLK                            : natural := 8; 
   constant C_EXP_TIME_CONV_NUMERATOR_BITLEN            : natural := DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS;
   
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;     
   
   type exp_cfg_gen_fsm_type is (idle, wait_int_dval_st, wait_mb_cfg_st, serial_exp_cfg_st, pause_st);
   
   type int_indx_pipe_type is array (0 to 4) of std_logic_vector(7 downto 0);
   type int_time_pipe_type is array (0 to 4) of unsigned(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_26 downto 0);
   
   signal int_time_pipe                   : int_time_pipe_type := ((others => '0'), (others => '0'), (others => '0'), (others => '0'), (others => '0')); 
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
   signal exp_cfg_en                      : std_logic;
   signal user_cfg_in_progress_i          : std_logic;
   signal dly_cnt                         : unsigned(4 downto 0);
   signal mb_serial_assump_err            : std_logic;
   signal mb_cfg_in_progress              : std_logic;
   signal mb_ser_cfg_dval                 : std_logic;
   signal mb_ser_cfg_data                 : std_logic_vector(7 downto 0);
   signal mb_ser_cfg_add                  : std_logic_vector(7 downto 0);
   signal mb_struct_cfg                   : fpa_intf_cfg_type;
   signal user_cfg_i                      : fpa_intf_cfg_type;
   signal exp_cfg_done                    : std_logic;
   signal exp_ser_cfg_add                 : std_logic_vector(7 downto 0);
   signal exp_ser_cfg_data                : std_logic_vector(7 downto 0);
   signal exp_ser_cfg_dval                : std_logic;
   signal exp_indx_i                      : std_logic_vector(7 downto 0);
   signal exp_checksum                    : unsigned(7 downto 0);
   signal int_signal_high_time_i          : unsigned(31 downto 0);
   signal int_indx_pipe                   : int_indx_pipe_type;
   signal int_dval_pipe                   : std_logic_vector(7 downto 0) := (others => '0');
   signal at_least_one_mb_cfg_received    : std_logic;
   signal at_least_one_exp_cfg_received   : std_logic;
   signal mb_ctrled_reset_i               : std_logic;
   signal valid_cfg_received              : std_logic;
   signal user_cfg_rdy_pipe               : std_logic_vector(7 downto 0) := (others => '0');
   signal user_cfg_rdy                    : std_logic := '0';
   
   signal byte_cnt                        : unsigned(7 downto 0);
   signal exp_cfg_in_progress             : std_logic;
   signal slv_reg_rden                    : std_logic;
   signal slv_reg_wren                    : std_logic;
   signal data_i                          : std_logic_vector(31 downto 0);
   signal fpa_softw_stat_i                : fpa_firmw_stat_type;
   signal reset_err_i                     : std_logic;
   signal ctrled_reset_i                  : std_logic;
   signal abs_additional_int_time_offset_i : integer := 0; 
   
   signal int_cfg_i                       : int_cfg_type;
   signal exp_struct_cfg                  : int_cfg_type;
   signal user_cfg_int                    : int_cfg_type;
   -- signal checksum_base_add               : unsigned(exp_ser_cfg_add'length-1 downto 0);
   
   
begin
   
   CTRLED_RESET            <= ctrled_reset_i;
   RESET_ERR               <= reset_err_i;
   ERR                     <= mb_serial_assump_err;
   USER_CFG                <= user_cfg_i;
   USER_CFG_IN_PROGRESS    <= user_cfg_in_progress_i;
   FPA_SOFTW_STAT          <= fpa_softw_stat_i;
   COOLER_STAT.COOLER_ON   <= '1';   -- pour le SCD_PROXY2, on peut se le permettre car le proxy n'allumera le détecteur que si la température du FPA est bonne.
   
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
   MB_SER_CFG.TDATA    <= mb_ser_cfg_add & mb_ser_cfg_data;
   MB_SER_CFG.TVALID   <= mb_ser_cfg_dval;
   EXP_SER_CFG.TDATA   <= exp_ser_cfg_add & exp_ser_cfg_data;
   EXP_SER_CFG.TVALID  <= exp_ser_cfg_dval;
   
   
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
   
   ----------------------------------------------------------------------------
   -- reception configuration
   ----------------------------------------------------------------------------
   U7: process(MB_CLK)        -- 
   begin
      if rising_edge(MB_CLK) then
         if sreset = '1' then
            fpa_softw_stat_i.dval <= '0';
            mb_cfg_in_progress <= '1';  -- fait expres
            mb_ser_cfg_dval <= '0';
            reset_err_i<= '0';
            fpa_softw_stat_i.fpa_input <= LVDS25; -- normaement c'est un mesureur de la tension de la banque du FPGA qui doit forunir cette info (sera fait dans sur une carte ADC). Mais pour la carte ACQ ce n'Est pas le cas.
            mb_ctrled_reset_i <= '0';
            at_least_one_mb_cfg_received <= '0';
            
         else            
            
            -- MB: config serielle
            mb_ser_cfg_add <= std_logic_vector(resize(axi_awaddr(9 downto 2),mb_ser_cfg_add'length));  -- Cela suppose que l'adresse du mB varie par pas de 4 
            mb_ser_cfg_data <= data_i(7 downto 0); -- pour la partie serielle de la config, seule la partie (7 downto 0) est valide (voir le driver C)                  
            mb_ser_cfg_dval <= slv_reg_wren and axi_awaddr(10);         
            
            -- MB: config structurelle
            if slv_reg_wren = '1' then
               
               case axi_awaddr(7 downto 0) is 
                  
                  -- comn                                                                                                  
                  when X"00" =>    mb_struct_cfg.comn.fpa_diag_mode               <= data_i(0); mb_cfg_in_progress <= '1';                       
                  when X"04" =>    mb_struct_cfg.comn.fpa_diag_type               <= data_i(mb_struct_cfg.comn.fpa_diag_type'length-1 downto 0); 
                  when X"08" =>    mb_struct_cfg.comn.fpa_pwr_on                  <= data_i(0);						
                  when X"0C" =>    mb_struct_cfg.comn.fpa_trig_ctrl_mode          <= data_i(mb_struct_cfg.comn.fpa_trig_ctrl_mode'length-1 downto 0);
                  when X"10" =>    mb_struct_cfg.comn.fpa_acq_trig_ctrl_dly       <= unsigned(data_i(mb_struct_cfg.comn.fpa_acq_trig_ctrl_dly'length-1 downto 0)); 						
                  when X"14" =>    mb_struct_cfg.comn.fpa_spare                   <= unsigned(data_i(mb_struct_cfg.comn.fpa_spare'length-1 downto 0));                                    
                  when X"18" =>    mb_struct_cfg.comn.fpa_xtra_trig_ctrl_dly      <= unsigned(data_i(mb_struct_cfg.comn.fpa_xtra_trig_ctrl_dly'length-1 downto 0));                                    
                  when X"1C" =>    mb_struct_cfg.comn.fpa_trig_ctrl_timeout_dly   <= unsigned(data_i(mb_struct_cfg.comn.fpa_trig_ctrl_timeout_dly'length-1 downto 0));                                      
                  when X"20" =>    mb_struct_cfg.comn.fpa_stretch_acq_trig        <= data_i(0);
                  when X"24" =>    mb_struct_cfg.comn.clk100_to_intclk_conv_numerator  <= unsigned(data_i(mb_struct_cfg.comn.clk100_to_intclk_conv_numerator'length-1 downto 0));
                  when X"28" =>    mb_struct_cfg.comn.intclk_to_clk100_conv_numerator  <= unsigned(data_i(mb_struct_cfg.comn.intclk_to_clk100_conv_numerator'length-1 downto 0));
                     
                  -- op
                  when X"2C" =>    mb_struct_cfg.op.xstart                        <= unsigned(data_i(mb_struct_cfg.op.xstart'length-1 downto 0));                                
                  when X"30" =>    mb_struct_cfg.op.ystart                        <= unsigned(data_i(mb_struct_cfg.op.ystart'length-1 downto 0));                        
                  when X"34" =>    mb_struct_cfg.op.xsize                         <= unsigned(data_i(mb_struct_cfg.op.xsize'length-1 downto 0));                              
                  when X"38" =>    mb_struct_cfg.op.ysize                         <= unsigned(data_i(mb_struct_cfg.op.ysize'length-1 downto 0));                                
                  when X"3C" =>    mb_struct_cfg.op.frame_time                    <= unsigned(data_i(mb_struct_cfg.op.frame_time'length-1 downto 0));                                                     
                  when X"40" =>    mb_struct_cfg.op.gain                          <= data_i(mb_struct_cfg.op.gain'length-1 downto 0); 
                  when X"44" =>    mb_struct_cfg.op.int_mode                      <= data_i(mb_struct_cfg.op.int_mode'length-1 downto 0);                        
                  when X"48" =>    mb_struct_cfg.op.test_mode	                   <= data_i(mb_struct_cfg.op.test_mode'length-1 downto 0);                        
                  when X"4C" =>    mb_struct_cfg.op.det_vbias                     <= data_i(mb_struct_cfg.op.det_vbias'length-1 downto 0);                         
                  when X"50" =>    mb_struct_cfg.op.det_ibias                     <= data_i(mb_struct_cfg.op.det_ibias'length-1 downto 0); 
                  when X"54" =>    mb_struct_cfg.op.det_vsat                      <= data_i(mb_struct_cfg.op.det_vsat'length-1 downto 0);                         
                  when X"58" =>    mb_struct_cfg.op.binning                       <= data_i(mb_struct_cfg.op.binning'length-1 downto 0);      
                  when X"5C" =>    mb_struct_cfg.op.output_chn                    <= data_i(mb_struct_cfg.op.output_chn'length-1 downto 0);   
                  when X"60" =>    mb_struct_cfg.op.spare1		                   <= data_i(mb_struct_cfg.op.spare1'length-1 downto 0); 		 
                  when X"64" =>    mb_struct_cfg.op.spare2		                   <= data_i(mb_struct_cfg.op.spare2'length-1 downto 0); 		 
                  when X"68" =>    mb_struct_cfg.op.spare3		                   <= data_i(mb_struct_cfg.op.spare3'length-1 downto 0); 		 
                  when X"6C" =>    mb_struct_cfg.op.spare4                        <= data_i(mb_struct_cfg.op.spare4'length-1 downto 0);       
                  when X"70" =>    mb_struct_cfg.op.cfg_num                       <= unsigned(data_i(mb_struct_cfg.op.cfg_num'length-1 downto 0));          
                  
                  when X"74" =>    mb_struct_cfg.diag.ysize                       <= unsigned(data_i(mb_struct_cfg.diag.ysize'length-1 downto 0));
                  when X"78" =>    mb_struct_cfg.diag.xsize_div_tapnum            <= unsigned(data_i(mb_struct_cfg.diag.xsize_div_tapnum'length-1 downto 0));
                  when X"7C" =>    mb_struct_cfg.diag.lovh_mclk_source            <= unsigned(data_i(mb_struct_cfg.diag.lovh_mclk_source'length-1 downto 0));
                     
                  -- misc (principalement variables/parametres qui ne changent pratiquement pas)
                  when X"80" =>    mb_struct_cfg.frame_dly_cst                    <= unsigned(data_i(mb_struct_cfg.frame_dly_cst'length-1 downto 0)); 
                  when X"84" =>    mb_struct_cfg.int_dly_cst                      <= unsigned(data_i(mb_struct_cfg.int_dly_cst'length-1 downto 0));
                  when X"88" =>    mb_struct_cfg.additional_fpa_int_time_offset   <= signed(data_i(mb_struct_cfg.additional_fpa_int_time_offset'length-1 downto 0));                            
                  when X"8C" =>    mb_struct_cfg.itr                              <= data_i(0);
                  when X"90" =>    mb_struct_cfg.real_mode_active_pixel_dly       <= unsigned(data_i(mb_struct_cfg.real_mode_active_pixel_dly'length-1 downto 0));
                  
                  when X"94" =>    mb_struct_cfg.cmd_hder                         <= data_i(mb_struct_cfg.cmd_hder'length-1 downto 0);
                  when X"98" =>    mb_struct_cfg.int_cmd_id                       <= data_i(mb_struct_cfg.int_cmd_id'length-1 downto 0);
                  when X"9C" =>    mb_struct_cfg.int_cmd_dlen                     <= data_i(mb_struct_cfg.int_cmd_dlen'length-1 downto 0);
                  when X"A0" =>    mb_struct_cfg.int_cmd_offs_add                 <= data_i(mb_struct_cfg.int_cmd_offs_add'length-1 downto 0);
                  when X"A4" =>    mb_struct_cfg.fpa_serdes_lval_num              <= unsigned(data_i(mb_struct_cfg.fpa_serdes_lval_num'length-1 downto 0));
                  when X"A8" =>    mb_struct_cfg.fpa_serdes_lval_len              <= unsigned(data_i(mb_struct_cfg.fpa_serdes_lval_len'length-1 downto 0));
                  
                  when X"AC" =>    mb_struct_cfg.op_cmd_id                        <= data_i(mb_struct_cfg.op_cmd_id'length-1 downto 0); 
                  when X"B0" =>    mb_struct_cfg.temp_cmd_id                      <= data_i(mb_struct_cfg.temp_cmd_id'length-1 downto 0); 
                  
                  when X"B4" =>    mb_struct_cfg.op_cmd_bram_base_add             <= unsigned(data_i(mb_struct_cfg.op_cmd_bram_base_add'length-1 downto 0));
                  when X"B8" =>    mb_struct_cfg.int_cmd_bram_base_add            <= unsigned(data_i(mb_struct_cfg.int_cmd_bram_base_add'length-1 downto 0));
                  when X"BC" =>    mb_struct_cfg.temp_cmd_bram_base_add           <= unsigned(data_i(mb_struct_cfg.temp_cmd_bram_base_add'length-1 downto 0)); 
                  
                  when X"C0" =>    mb_struct_cfg.int_cmd_bram_base_add_m1         <= unsigned(data_i(mb_struct_cfg.int_cmd_bram_base_add_m1'length-1 downto 0));
                  when X"C4" =>    mb_struct_cfg.int_checksum_base_add            <= unsigned(data_i(mb_struct_cfg.int_checksum_base_add'length-1 downto 0));
                  when X"C8" =>    mb_struct_cfg.cmd_overhead_bytes_num           <= unsigned(data_i(mb_struct_cfg.cmd_overhead_bytes_num'length-1 downto 0));  
                  when X"CC" =>    mb_struct_cfg.int_clk_period_factor            <= unsigned(data_i(mb_struct_cfg.int_clk_period_factor'length-1 downto 0));  mb_cfg_in_progress <= '0'; at_least_one_mb_cfg_received <= '1';
                     
                  -- lecture de temperature
                  when X"D8" =>    mb_struct_cfg.temp.cfg_num                     <= unsigned(data_i(mb_struct_cfg.temp.cfg_num'length-1 downto 0)); mb_cfg_in_progress <= '1';
                  when X"DC" =>    mb_struct_cfg.temp.cfg_end                     <= data_i(0); mb_cfg_in_progress <= '0'; 
                     
                  -- fpa_softw_stat_i qui dit au sequenceur general quel pilote C est en utilisation
                  when X"E0" =>    fpa_softw_stat_i.fpa_roic   <= data_i(fpa_softw_stat_i.fpa_roic'length-1 downto 0);
                  when X"E4" =>    fpa_softw_stat_i.fpa_output <= data_i(fpa_softw_stat_i.fpa_output'length-1 downto 0); fpa_softw_stat_i.dval <='1';
                  when X"E8" =>    fpa_softw_stat_i.fpa_input <= data_i(fpa_softw_stat_i.fpa_input'length-1 downto 0); fpa_softw_stat_i.dval <='1';
                     
                  -- pour effacer erreurs latchées
                  when X"EC" =>    reset_err_i <= data_i(0);
                     
                  -- pour un reset complet du module FPA
                  when X"F0" =>   mb_ctrled_reset_i <= data_i(0); fpa_softw_stat_i.dval <='0'; -- ENO: 10 juin 2015: ce reset permet de mettre la sortie vers le DDC en 'Z' lorsqu'on etient la carte DDC et permet de faire un reset lorsqu'on allume la carte DDC
                  --fpa_softw_stat_i.dval <='0' permet de ne pas rallumer automatiquement la carte DDC après un reset controllé.
                  when others => --do nothing
                  
               end case;                     
               
            end if;
            
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
            exp_checksum <= (others => '0');
            exp_cfg_done <= '0';
            exp_ser_cfg_dval <= '0';
            exp_cfg_in_progress <= '0';
            at_least_one_exp_cfg_received <= '0';
            
         else             
            
            -- checksum_base_add <= resize(unsigned(mb_struct_cfg.int_cmd_dlen), checksum_base_add'length) + 4;  -- +4 pour tenir compte de l'overhead de la cmd.         
            
            case exp_cfg_gen_fsm is       
               
               when idle  =>
                  exp_cfg_done <= '1'; 
                  exp_checksum <= (others => '0');
                  byte_cnt <= to_unsigned(1, byte_cnt'length); -- 
                  exp_ser_cfg_dval <= '0';
                  exp_cfg_in_progress <= '0';
                  exp_ser_cfg_data <= (others => '0');  -- fait expres pour le bon calcul du checksum
                  if int_dval_pipe(1) = '1' then        -- int_dval_pipe(1) est à 1CLK près le front montant de EXP_INFO.EXP_DVAL. Donc dès qu'un temps d'integration rentre, on quitte idle pour attendre sa conversion
                     exp_cfg_in_progress <= '1';        -- ainsi, la sortie de la config est bloquée jusqu'à ce que la commande du temps d'integration soit pleinement constituée 
                     exp_cfg_gen_fsm <= wait_mb_cfg_st;
                  end if; 
               
               when wait_mb_cfg_st =>      -- il faut qu'on ait reçu au moins une config de MB car la commande seriellede EXP en utilise certains elements
                  if at_least_one_mb_cfg_received = '1' then
                     exp_struct_cfg <= int_cfg_i;
                     exp_cfg_gen_fsm <= serial_exp_cfg_st;
                  end if;
               
               when serial_exp_cfg_st =>   -- on envoie la partie serielle
                  exp_cfg_done <= '0';
                  exp_ser_cfg_dval <= '1'; 
                  exp_ser_cfg_add <= std_logic_vector(resize((byte_cnt + mb_struct_cfg.int_cmd_bram_base_add_m1), exp_ser_cfg_add'length)); -- pour que premiere adresse impérativement 0
                  byte_cnt <= byte_cnt + 1;
                  exp_checksum <= exp_checksum + unsigned(exp_ser_cfg_data); -- somme sur 8 bits donc implicitement modulo 256. certes decalé mais les zeros entre byte8 et byte12 permettent à la valeur d'etre prête avant l'envoi
                  
                  --   cmd identification
                  if    byte_cnt = 1  then exp_ser_cfg_data <= mb_struct_cfg.cmd_hder(7 downto 0);                       -- scd_proxy2 exp_time CMD Header
                  elsif byte_cnt = 2  then exp_ser_cfg_data <= mb_struct_cfg.int_cmd_id(7 downto 0);         -- scd_proxy2 exp_time CMD ID                 
                  elsif byte_cnt = 3  then exp_ser_cfg_data <= mb_struct_cfg.int_cmd_id(15 downto 8);        -- scd_proxy2 exp_time CMD ID                  
                  elsif byte_cnt = 4  then exp_ser_cfg_data <= mb_struct_cfg.int_cmd_dlen(7 downto 0);       -- scd_proxy2 exp_time data length                  
                  elsif byte_cnt = 5  then exp_ser_cfg_data <= mb_struct_cfg.int_cmd_dlen(15 downto 8);      -- scd_proxy2 exp_time data length 
                  elsif byte_cnt = 6  then exp_ser_cfg_data <= mb_struct_cfg.int_cmd_offs_add(7 downto 0);        -- scd_proxy2 exp_time offset add 
                     
                     -- frame_dly
                  elsif byte_cnt = 6  then exp_ser_cfg_data <= std_logic_vector(exp_struct_cfg.frame_dly(7 downto 0));             -- exp_time en coups de 80MHz       
                  elsif byte_cnt = 7  then exp_ser_cfg_data <= std_logic_vector(exp_struct_cfg.frame_dly(15 downto 8));            -- exp_time en coups de 80MHz  
                  elsif byte_cnt = 8  then exp_ser_cfg_data <= x"0" & std_logic_vector(exp_struct_cfg.frame_dly(19 downto 16));           -- exp_time en coups de 80MHz  
                     
                     -- int_dly
                  elsif byte_cnt = 9  then exp_ser_cfg_data <= std_logic_vector(exp_struct_cfg.int_dly(7 downto 0));             -- exp_time en coups de 80MHz       
                  elsif byte_cnt = 10 then exp_ser_cfg_data <= std_logic_vector(exp_struct_cfg.int_dly(15 downto 8));            -- exp_time en coups de 80MHz  
                  elsif byte_cnt = 11 then exp_ser_cfg_data <= x"0" & std_logic_vector(exp_struct_cfg.int_dly(19 downto 16)); 
                     
                     -- int_time   
                  elsif byte_cnt = 12 then exp_ser_cfg_data <= std_logic_vector(exp_struct_cfg.int_time(7 downto 0));             -- exp_time en coups de 80MHz       
                  elsif byte_cnt = 13 then exp_ser_cfg_data <= std_logic_vector(exp_struct_cfg.int_time(15 downto 8));            -- exp_time en coups de 80MHz  
                  elsif byte_cnt = 14 then exp_ser_cfg_data <= x"0" & std_logic_vector(exp_struct_cfg.int_time(19 downto 16));    -- exp_time en coups de 80MHz  
                     
                     -- checksum
                  elsif byte_cnt = 18 then
                     exp_ser_cfg_add <= std_logic_vector(resize((mb_struct_cfg.int_checksum_base_add + mb_struct_cfg.int_cmd_bram_base_add), exp_ser_cfg_add'length));
                     exp_ser_cfg_data <= std_logic_vector(unsigned(not std_logic_vector(exp_checksum)) + 1); -- le fait qu'il y ait des zeros entre byte8 et byte12 donne le temps au cheksum d'etre prêt avant le byte 12 
                     exp_cfg_gen_fsm <= pause_st; 
                  else  -- si byte cnt entre 15 et 17  
                     exp_ser_cfg_data <= (others => '0'); -- le fait qu'il y ait des zeros entre byte15 et byte17 donne le temps au cheksum d'etre prêt avant le byte 18.
                     exp_ser_cfg_dval <= '0';
                  end if;              
               
               when pause_st =>  -- on envoie ensuite la partie structurale
                  exp_ser_cfg_dval <= '0'; 
                  exp_cfg_gen_fsm <= idle;               
                  at_least_one_exp_cfg_received <= '1';
               
               when others =>                  
               
            end case;        
            
         end if;
      end if;
   end process; 
   
   --------------------------------
   -- gestion  de la config 
   --------------------------------
   U2: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         if sreset = '1' then
            user_cfg_in_progress_i <= '0';
            valid_cfg_received <= '0';
            ctrled_reset_i <= '1';
            user_cfg_i.comn.clk100_to_intclk_conv_numerator <= to_unsigned(4697620, user_cfg_i.comn.clk100_to_intclk_conv_numerator'length);
            
         else     
            
            user_cfg_in_progress_i <= exp_cfg_in_progress or mb_cfg_in_progress;
            ctrled_reset_i <= mb_ctrled_reset_i or not valid_cfg_received;
            
            -- user_cfg_rdy
            user_cfg_rdy_pipe(0) <= not user_cfg_in_progress_i;
            user_cfg_rdy_pipe(7 downto 1) <= user_cfg_rdy_pipe(6 downto 0);
            user_cfg_rdy <= not user_cfg_in_progress_i and and_reduce(user_cfg_rdy_pipe);
            
            -- la config au complet
            if user_cfg_rdy = '1' then  
               user_cfg_i <= mb_struct_cfg;
               user_cfg_i.int <= exp_struct_cfg;
               user_cfg_i.int_time <= exp_struct_cfg.int_time;
               valid_cfg_received <= at_least_one_mb_cfg_received and at_least_one_exp_cfg_received;         
            end if; 
            
         end if;
      end if;
   end process;
   
   ------------------------------------------------  
   -- calcul du temps d'integratuion en coups de MCLK                               
   -------------------------------------------------
   U3B: process (MB_CLK)
   begin
      if rising_edge(MB_CLK) then 
         
         abs_additional_int_time_offset_i <= to_integer(abs(user_cfg_i.additional_fpa_int_time_offset));
         
         -- pipe pour le calcul du temps d'integration en mclk
         int_time_pipe(0) <= resize(FPA_EXP_INFO.EXP_TIME, int_time_pipe(0)'length) ;
         int_time_pipe(1) <= resize(int_time_pipe(0) * resize(user_cfg_i.comn.clk100_to_intclk_conv_numerator, C_EXP_TIME_CONV_NUMERATOR_BITLEN), int_time_pipe(0)'length);          
         int_time_pipe(2) <= resize(int_time_pipe(1)(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_26 downto DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS), int_time_pipe(0)'length);  -- soit une division par 2^EXP_TIME_CONV_DENOMINATOR
         int_time_pipe(3) <= int_time_pipe(2) + resize("00"& int_time_pipe(1)(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1), int_time_pipe(0)'length);  -- pour l'operation d'arrondi
         if user_cfg_i.additional_fpa_int_time_offset(31) = '0' then 
            int_time_pipe(4) <= int_time_pipe(3)+ to_unsigned(abs_additional_int_time_offset_i, int_time_pipe(4)'length);
         else
            int_time_pipe(4) <= int_time_pipe(3)- to_unsigned(abs_additional_int_time_offset_i, int_time_pipe(4)'length);
         end if; 
         
         -- pipe de synchro pour l'index           
         int_indx_pipe(0)     <= FPA_EXP_INFO.EXP_INDX;
         int_indx_pipe(1)     <= int_indx_pipe(0); 
         int_indx_pipe(2)     <= int_indx_pipe(1); 
         int_indx_pipe(3)     <= int_indx_pipe(2); 
         int_indx_pipe(4)     <= int_indx_pipe(3);          
         
         -- pipe pour rendre valide la donnée qques CLKs apres sa sortie
         int_dval_pipe(0)     <= FPA_EXP_INFO.EXP_DVAL;
         int_dval_pipe(1)     <= FPA_EXP_INFO.EXP_DVAL and not int_dval_pipe(0); -- front montant de FPA_EXP_INFO.EXP_DVAL pour generer juste un pulse
         int_dval_pipe(2)     <= int_dval_pipe(1); 
         int_dval_pipe(3)     <= int_dval_pipe(2);
         int_dval_pipe(4)     <= int_dval_pipe(3);
         int_dval_pipe(5)     <= int_dval_pipe(4);
         int_dval_pipe(6)     <= int_dval_pipe(5);
         int_dval_pipe(7)     <= int_dval_pipe(6);
         
         -- mapping de int_cfg_i        
         int_cfg_i.int_time   <= int_time_pipe(4)(int_cfg_i.int_time'length-1 downto 0); -- suppose que (int_time_pipe(3)(int_time_i'length-1 downto 0) > DEFINE_FPA_INT_TIME_OFFSET_FACTOR). int_signal_high_time est parfaitement synchrosnié avec in_time_i
         int_cfg_i.int_dly    <= mb_struct_cfg.int_dly_cst;
         int_cfg_i.int_indx   <= int_indx_pipe(4);
         int_cfg_i.frame_dly  <= int_cfg_i.int_time(19 downto 0) + mb_struct_cfg.frame_dly_cst; 
         int_cfg_i.int_dval   <= or_reduce(int_dval_pipe(7 downto 5));  -- on genere un signal de largeur 2 CLK environ
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
         
         if  MB_MOSI.ARADDR(10) = '1' then    -- adresse de base pour la lecture des statuts provenant du generateur de statuts
            axi_rdata <= STATUS_MISO.RDATA;   -- la donnée de statut est valide 1CLK après MB_MOSI.ARVALID            
            
         elsif MB_MOSI.ARADDR(11) = '1' then  -- adresse de base pour la lecture des statuts ne provenant pas du generateur de statuts
            axi_rdata <= std_logic_vector(to_unsigned(G_FPA_PIX_NUM_PER_PCLK, axi_rdata'length));
            
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