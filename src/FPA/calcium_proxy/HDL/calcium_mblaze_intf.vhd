------------------------------------------------------------------
--!   @file : calcium_mblaze_intf
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
use IEEE.numeric_std.all;
use work.tel2000.all;
use work.FPA_define.all;
use work.proxy_define.all;
use work.fpa_common_pkg.all;
use work.fleg_brd_define.all;

entity calcium_mblaze_intf is
   port (
      ARESET                     : in std_logic;
      MB_CLK                     : in std_logic;
      
      FPA_EXP_INFO               : in exp_info_type;
      
      MB_MOSI                    : in t_axi4_lite_mosi;
      MB_MISO                    : out t_axi4_lite_miso;
      
      RESET_ERR                  : out std_logic;
      STATUS_MOSI                : out t_axi4_lite_mosi;
      STATUS_MISO                : in t_axi4_lite_miso;
      MB_RESET                   : out std_logic;
      
      USER_CFG                   : out fpa_intf_cfg_type;
      ROIC_EXP_TIME_CFG          : out roic_exp_time_cfg_type;          -- paramètres reliés au temps d'intégration à programmer dans le ROIC
      ROIC_EXP_TIME_CFG_EN       : out std_logic;
      ROIC_EXP_TIME_CFG_DONE     : in std_logic;
      
      COOLER_STAT                : out fpa_cooler_stat_type;
      
      FPA_SOFTW_STAT             : out fpa_firmw_stat_type;
      
      COMPR_ERR                  : in std_logic_vector(4 downto 0);
      ROIC_RX_NB_DATA            : in std_logic_vector(7 downto 0);     -- feedback du nombre de données reçues disponibles dans la RAM
      RESET_ROIC_RX_DATA         : out std_logic;
      
      KPIX_REG                   : inout kpix_reg_type
   );
end calcium_mblaze_intf;


architecture rtl of calcium_mblaze_intf is
   
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS       : natural := DEFINE_FPA_EXP_TIME_CONV_DENOMINATOR_BIT_POS;  -- log2 de FPA_EXP_TIME_CONV_DENOMINATOR
   constant C_EXP_TIME_CONV_NUMERATOR_BITLEN          : integer := C_EXP_TIME_CONV_DENOMINATOR_BIT_POS + 5;
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_27  : natural := C_EXP_TIME_CONV_DENOMINATOR_BIT_POS + 27; --pour un total de 27 bits pour le temps d'integration
   constant C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1   : natural := C_EXP_TIME_CONV_DENOMINATOR_BIT_POS - 1;
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
      );
   end component;
   
   component double_sync
      generic (
         INIT_VALUE : bit := '0'
      );
      port (
         D     : in STD_LOGIC;
         Q     : out STD_LOGIC := '0';
         RESET : in STD_LOGIC;
         CLK   : in STD_LOGIC
      );
   end component;
   
   type exp_cfg_fsm_type is (idle, wait_conv_st, wait_prog_rdy_st, wait_prog_ack_st, wait_prog_end_st);
   type conv_exp_time_pipe_type is array (0 to 8) of unsigned(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_27 downto 0); -- la longueur du pipe en fonction du nombre de clk nécessaires et non de l'utilisation de l'array
   
   signal exp_cfg_fsm                  : exp_cfg_fsm_type;
   signal sreset                       : std_logic;
   signal axi_awaddr	                  : std_logic_vector(31 downto 0);
   signal axi_awready	               : std_logic;
   signal axi_wready	                  : std_logic;
   signal axi_bresp	                  : std_logic_vector(1 downto 0);
   signal axi_bvalid	                  : std_logic;
   signal axi_araddr	                  : std_logic_vector(31 downto 0);
   signal axi_arready	               : std_logic;
   signal axi_rdata	                  : std_logic_vector(31 downto 0);
   signal axi_rresp	                  : std_logic_vector(1 downto 0);
   signal axi_rvalid	                  : std_logic;
   signal axi_wstrb                    : std_logic_vector(3 downto 0);
   signal slv_reg_rden                 : std_logic;
   signal slv_reg_wren                 : std_logic;
   signal data_i                       : std_logic_vector(31 downto 0);
   signal user_cfg_in_progress         : std_logic;
   signal user_cfg_i                   : fpa_intf_cfg_type;
   signal int_dval_i                   : std_logic;
   signal int_time_i                   : unsigned(USER_CFG.int_time'length-1 downto 0);
   signal int_indx_i                   : std_logic_vector(USER_CFG.int_indx'length-1 downto 0);
   signal int_signal_high_time_i       : unsigned(USER_CFG.int_signal_high_time'length-1 downto 0);
   signal conv_exp_time_pipe           : conv_exp_time_pipe_type;
   signal conv_exp_dval_i              : std_logic;
   signal conv_exp_dval_pipe           : std_logic_vector(conv_exp_time_pipe'length-1 downto 0) := (others => '0');  -- pipe dval synchro avec pipe de conversion
   signal roic_exp_time_cfg_i          : roic_exp_time_cfg_type;
   signal roic_exp_time_cfg_en_i       : std_logic;
   signal roic_exp_time_cfg_done_sync  : std_logic;
   signal fpa_softw_stat_i             : fpa_firmw_stat_type;
   signal ctrled_reset_i               : std_logic;
   signal reset_err_i                  : std_logic;
   signal user_cfg_rdy_pipe            : std_logic_vector(7 downto 0) := (others => '0');
   signal user_cfg_rdy                 : std_logic := '0';
   signal valid_cfg_received           : std_logic := '0';
   signal mb_ctrled_reset_i            : std_logic;
   signal dac_cfg_in_progress          : std_logic;
   signal abs_fpa_int_time_offset_i    : unsigned(USER_CFG.fpa_int_time_offset'length-1 downto 0);
   signal kpix_value                   : std_logic_vector(31 downto 0);
   signal kpix_dval                    : std_logic;
   signal kpix_status                  : std_logic_vector(31 downto 0);
   signal compr_err_latch              : std_logic_vector(COMPR_ERR'range);
   signal reset_roic_rx_data_i         : std_logic;
   signal dsm_period                   : unsigned(USER_CFG.dsm_period_min'length-1 downto 0);
   signal dsm_period_delay             : unsigned(dsm_period'length-1 downto 0);
   signal dsm_nb_period                : unsigned(USER_CFG.dsm_nb_period_max'length-1 downto 0);
   
begin
   
   -- Output mapping
   MB_RESET <= ctrled_reset_i;
   RESET_ERR <= reset_err_i;
   FPA_SOFTW_STAT <= fpa_softw_stat_i;
   COOLER_STAT.COOLER_ON <= '1';
   ROIC_EXP_TIME_CFG <= roic_exp_time_cfg_i;
   ROIC_EXP_TIME_CFG_EN <= roic_exp_time_cfg_en_i;
   RESET_ROIC_RX_DATA <= reset_roic_rx_data_i;
   
   -- KPIX register mapping
   KPIX_REG.WRITE      <= kpix_value;
   KPIX_REG.WRITE_DVAL <= kpix_dval;
   kpix_status         <= KPIX_REG.STATUS;
   
   -- I/O Connections assignments
   MB_MISO.AWREADY     <= axi_awready;
   MB_MISO.WREADY      <= axi_wready;
   MB_MISO.BRESP	     <= axi_bresp;
   MB_MISO.BVALID      <= axi_bvalid;
   MB_MISO.ARREADY     <= axi_arready;
   MB_MISO.RDATA	     <= axi_rdata;
   MB_MISO.RRESP	     <= axi_rresp;
   MB_MISO.RVALID      <= axi_rvalid;
   
   -- STATUS_MOSI toujours envoyé au fpa_status_gen pour eviter des delais
   STATUS_MOSI.AWVALID <= '0';   -- registres de statut en mode lecture seulement
   STATUS_MOSI.AWADDR  <= (others => '0');   -- registres de statut en mode lecture seulement
   STATUS_MOSI.AWPROT  <= (others => '0'); -- registres de statut en mode lecture seulement
   STATUS_MOSI.WVALID  <= '0'; -- registres de statut en mode lecture seulement
   STATUS_MOSI.WDATA   <= (others => '0'); -- registres de statut en mode lecture seulement
   STATUS_MOSI.WSTRB   <= (others => '0'); -- registres de statut en mode lecture seulement
   STATUS_MOSI.BREADY  <= '0'; -- registres de statut en mode lecture seulement
   STATUS_MOSI.ARVALID <= MB_MOSI.ARVALID;
   STATUS_MOSI.ARADDR  <= resize(MB_MOSI.ARADDR(STATUS_BASE_ARADDR_WIDTH-1 downto 0), 32);
   STATUS_MOSI.ARPROT  <= MB_MOSI.ARPROT;
   STATUS_MOSI.RREADY  <= MB_MOSI.RREADY;
   
   --------------------------------------------------
   -- Reset
   --------------------------------------------------
   U1 : sync_reset
   port map (
      ARESET => ARESET,
      CLK    => MB_CLK,
      SRESET => sreset
   );
   
   --------------------------------------------------
   -- Double sync 
   --------------------------------------------------   
   U2 : double_sync
   generic map (
      INIT_VALUE => '0'
   )
   port map (
      RESET => sreset,
      D => ROIC_EXP_TIME_CFG_DONE,
      CLK => MB_CLK,
      Q => roic_exp_time_cfg_done_sync
   );
   
   --------------------------------------------------
   -- sortie de la config
   --------------------------------------------------
   U3 : process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         
         -- user_cfg_rdy
         user_cfg_rdy_pipe(0) <= not (user_cfg_in_progress or dac_cfg_in_progress);
         user_cfg_rdy_pipe(7 downto 1) <= user_cfg_rdy_pipe(6 downto 0);
         user_cfg_rdy <= not (user_cfg_in_progress or dac_cfg_in_progress) and user_cfg_rdy_pipe(7);
         
         if user_cfg_rdy = '1' then -- la config au complet 
            USER_CFG <= user_cfg_i;
            valid_cfg_received <= '1';
         end if;
         
      end if;
   end process;
   
   --------------------------------------------------
   -- gestion des erreurs
   --------------------------------------------------
   U4 : process(MB_CLK) 
   begin
      if rising_edge(MB_CLK) then
         if sreset = '1' then
            compr_err_latch <= (others => '0');
         else 
            
            -- latch des erreurs
            for i in COMPR_ERR'range loop
               if COMPR_ERR(i) = '1' then  
                  compr_err_latch(i) <= '1';
               end if;                                 
            end loop;
            
            -- gestion du reset
            if reset_err_i = '1' then 
               compr_err_latch <= (others => '0');
            end if;
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- reception Config
   --------------------------------------------------
   U5 : process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         if sreset = '1' then
            ctrled_reset_i <= '1';
            reset_err_i <= '0';
            user_cfg_in_progress <= '1'; -- fait expres pour qu'il soit mis à '0' ssi au moins une config rentre
            dac_cfg_in_progress <= '1';
            mb_ctrled_reset_i <= '0';
            fpa_softw_stat_i.dval <= '0';
            kpix_dval <= '0';
            reset_roic_rx_data_i <= '0';
            -- pour éviter les undefined avant le 1er int_dval_i
            user_cfg_i.int_time <= (others => '0');
            user_cfg_i.int_indx <= (others => '0');
            user_cfg_i.int_signal_high_time <= (others => '0');
            
         else                   
            
            ctrled_reset_i <= mb_ctrled_reset_i or not valid_cfg_received;
            kpix_dval <= '0'; -- remet le dval à 0
            
            -- temps d'exposition
            if int_dval_i = '1' then
               user_cfg_i.int_time <= int_time_i;
               user_cfg_i.int_indx <= int_indx_i;
               user_cfg_i.int_signal_high_time <= int_signal_high_time_i;
            end if;
            
            -- reste de la config
            if slv_reg_wren = '1' then  
               case axi_awaddr(11 downto 0) is             
                  
                  -- comn
                  when X"000" =>    user_cfg_i.comn.fpa_diag_mode                      <= data_i(0); user_cfg_in_progress <= '1';
                  when X"004" =>    user_cfg_i.comn.fpa_diag_type                      <= data_i(user_cfg_i.comn.fpa_diag_type'length-1 downto 0); 
                  when X"008" =>    user_cfg_i.comn.fpa_pwr_on                         <= data_i(0);
                  when X"00C" =>    user_cfg_i.comn.fpa_acq_trig_mode                  <= data_i(user_cfg_i.comn.fpa_acq_trig_mode'length-1 downto 0);
                  when X"010" =>    user_cfg_i.comn.fpa_acq_trig_ctrl_dly              <= unsigned(data_i(user_cfg_i.comn.fpa_acq_trig_ctrl_dly'length-1 downto 0));
                  when X"014" =>    user_cfg_i.comn.fpa_xtra_trig_mode                 <= data_i(user_cfg_i.comn.fpa_xtra_trig_mode'length-1 downto 0);
                  when X"018" =>    user_cfg_i.comn.fpa_xtra_trig_ctrl_dly             <= unsigned(data_i(user_cfg_i.comn.fpa_xtra_trig_ctrl_dly'length-1 downto 0));
                  when X"01C" =>    user_cfg_i.comn.fpa_trig_ctrl_timeout_dly          <= unsigned(data_i(user_cfg_i.comn.fpa_trig_ctrl_timeout_dly'length-1 downto 0));
                  when X"020" =>    user_cfg_i.comn.fpa_stretch_acq_trig               <= data_i(0);
                  when X"024" =>    user_cfg_i.comn.fpa_intf_data_source               <= data_i(0);
                  when X"028" =>    user_cfg_i.comn.fpa_xtra_trig_int_time             <= unsigned(data_i(user_cfg_i.comn.fpa_xtra_trig_int_time'length-1 downto 0));
                  when X"02C" =>    user_cfg_i.comn.fpa_prog_trig_int_time             <= unsigned(data_i(user_cfg_i.comn.fpa_prog_trig_int_time'length-1 downto 0));
                  when X"030" =>    user_cfg_i.comn.intclk_to_clk100_conv_numerator    <= unsigned(data_i(user_cfg_i.comn.intclk_to_clk100_conv_numerator'length-1 downto 0));
                  when X"034" =>    user_cfg_i.comn.clk100_to_intclk_conv_numerator    <= unsigned(data_i(user_cfg_i.comn.clk100_to_intclk_conv_numerator'length-1 downto 0));
                  
                  when X"038" =>    user_cfg_i.offsetx      <= unsigned(data_i(user_cfg_i.offsetx'length-1 downto 0));
                  when X"03C" =>    user_cfg_i.offsety      <= unsigned(data_i(user_cfg_i.offsety'length-1 downto 0));
                  when X"040" =>    user_cfg_i.width        <= unsigned(data_i(user_cfg_i.width'length-1 downto 0));
                  when X"044" =>    user_cfg_i.height       <= unsigned(data_i(user_cfg_i.height'length-1 downto 0));
                  
                  when X"048" =>    user_cfg_i.active_line_start_num       <= unsigned(data_i(user_cfg_i.active_line_start_num'length-1 downto 0));
                  when X"04C" =>    user_cfg_i.active_line_end_num         <= unsigned(data_i(user_cfg_i.active_line_end_num'length-1 downto 0));
                  when X"050" =>    user_cfg_i.active_line_width_div4      <= unsigned(data_i(user_cfg_i.active_line_width_div4'length-1 downto 0));
                     
                  when X"054" =>    user_cfg_i.diag.x_to_readout_start_dly       <= unsigned(data_i(user_cfg_i.diag.x_to_readout_start_dly'length-1 downto 0)); 
                  when X"058" =>    user_cfg_i.diag.fval_re_to_dval_re_dly       <= unsigned(data_i(user_cfg_i.diag.fval_re_to_dval_re_dly'length-1 downto 0));
                  when X"05C" =>    user_cfg_i.diag.lval_pause_dly               <= unsigned(data_i(user_cfg_i.diag.lval_pause_dly'length-1 downto 0));
                  when X"060" =>    user_cfg_i.diag.x_to_next_fsync_re_dly       <= unsigned(data_i(user_cfg_i.diag.x_to_next_fsync_re_dly'length-1 downto 0));
                  when X"064" =>    user_cfg_i.diag.xsize_div_per_pixel_num      <= unsigned(data_i(user_cfg_i.diag.xsize_div_per_pixel_num'length-1 downto 0));
                  
                  when X"068" =>    user_cfg_i.fpa_int_time_offset   <= signed(data_i(user_cfg_i.fpa_int_time_offset'length-1 downto 0));
                  
                  when X"06C" =>    user_cfg_i.int_fdbk_dly    <= unsigned(data_i(user_cfg_i.int_fdbk_dly'length-1 downto 0));
                  
                  when X"070" =>    user_cfg_i.kpix_pgen_en       <= data_i(0);
                  when X"074" =>    user_cfg_i.kpix_median_value  <= unsigned(data_i(user_cfg_i.kpix_median_value'length-1 downto 0));
                  
                  when X"078" =>    user_cfg_i.use_ext_pixqnb        <= data_i(0);
                  when X"07C" =>    user_cfg_i.clk_frm_pulse_width   <= unsigned(data_i(user_cfg_i.clk_frm_pulse_width'length-1 downto 0));
                  
                  when X"080" =>    user_cfg_i.fpa_serdes_lval_num   <= unsigned(data_i(user_cfg_i.fpa_serdes_lval_num'length-1 downto 0));
                  when X"084" =>    user_cfg_i.fpa_serdes_lval_len   <= unsigned(data_i(user_cfg_i.fpa_serdes_lval_len'length-1 downto 0));
                  
                  when X"088" =>    user_cfg_i.compr_ratio_fp32      <= data_i(user_cfg_i.compr_ratio_fp32'length-1 downto 0);
                  when X"08C" =>    user_cfg_i.compr_en              <= data_i(0);
                  when X"090" =>    user_cfg_i.compr_bypass_shift    <= unsigned(data_i(user_cfg_i.compr_bypass_shift'length-1 downto 0));
                  
                  when X"094" =>    user_cfg_i.roic_tx_nb_data    <= unsigned(data_i(user_cfg_i.roic_tx_nb_data'length-1 downto 0));
                  
                  when X"098" =>    user_cfg_i.dsm_period_constants                 <= unsigned(data_i(user_cfg_i.dsm_period_constants'length-1 downto 0));
                  when X"09C" =>    user_cfg_i.dsm_period_min                       <= unsigned(data_i(user_cfg_i.dsm_period_min'length-1 downto 0));
                  when X"0A0" =>    user_cfg_i.dsm_period_min_div_numerator         <= unsigned(data_i(user_cfg_i.dsm_period_min_div_numerator'length-1 downto 0));
                  when X"0A4" =>    user_cfg_i.dsm_nb_period_max                    <= unsigned(data_i(user_cfg_i.dsm_nb_period_max'length-1 downto 0));
                  when X"0A8" =>    user_cfg_i.dsm_nb_period_max_div_numerator      <= unsigned(data_i(user_cfg_i.dsm_nb_period_max_div_numerator'length-1 downto 0));
                  when X"0AC" =>    user_cfg_i.dsm_nb_period_min                    <= unsigned(data_i(user_cfg_i.dsm_nb_period_min'length-1 downto 0));
                  when X"0B0" =>    user_cfg_i.dsm_total_time_threshold             <= unsigned(data_i(user_cfg_i.dsm_total_time_threshold'length-1 downto 0));
                  
                  when X"0B4" =>    user_cfg_i.cfg_num         <= unsigned(data_i(user_cfg_i.cfg_num'length-1 downto 0)); user_cfg_in_progress <= '0';
                  
                  -- fpa_softw_stat_i qui dit au sequenceur general quel pilote C est en utilisation
                  when X"AE0" =>    fpa_softw_stat_i.fpa_roic                  <= data_i(fpa_softw_stat_i.fpa_roic'length-1 downto 0);
                  when X"AE4" =>    fpa_softw_stat_i.fpa_output                <= data_i(fpa_softw_stat_i.fpa_output'length-1 downto 0);  
                  when X"AE8" =>    fpa_softw_stat_i.fpa_input                 <= data_i(fpa_softw_stat_i.fpa_input'length-1 downto 0); fpa_softw_stat_i.dval <='1';  
                     
                  -- pour effacer erreurs latchées
                  when X"AEC" =>    reset_err_i                                <= data_i(0); 
                     
                  -- pour un reset complet du module FPA
                  when X"AF0" =>    mb_ctrled_reset_i                          <= data_i(0); fpa_softw_stat_i.dval <='0'; -- ENO: 10 juin 2015: ce reset permet de mettre la sortie vers le DDC en 'Z' lorsqu'on eteint la carte DDC et permet de faire un reset lorsqu'on allume la carte DDC
                  
                  -- pour écrire les valeurs de kpix dans la BRAM
                  when X"B00" =>    kpix_value        <= data_i(kpix_value'length-1 downto 0); kpix_dval <= '1';   -- le dval monte pour 1 clk
                  -- pour un reset des données reçues du ROIC
                  when X"B04" =>    reset_roic_rx_data_i       <= data_i(0);
                     
                     ----------------------------------------------------------------------------------------------------------------------------------------                  
                     -- EN0 15 janv 2019: la config des DACs passe désormais par l'adresse de base 0xD00 en vue de securiser les tensions du détecteur 
                  ----------------------------------------------------------------------------------------------------------------------------------------
                  when X"D00" =>    user_cfg_i.vdac_value(1)                   <= unsigned(data_i(user_cfg_i.vdac_value(1)'length-1 downto 0)); dac_cfg_in_progress <= '1';
                  when X"D04" =>    user_cfg_i.vdac_value(2)                   <= unsigned(data_i(user_cfg_i.vdac_value(2)'length-1 downto 0));
                  when X"D08" =>    user_cfg_i.vdac_value(3)                   <= unsigned(data_i(user_cfg_i.vdac_value(3)'length-1 downto 0));
                  when X"D0C" =>    user_cfg_i.vdac_value(4)                   <= unsigned(data_i(user_cfg_i.vdac_value(4)'length-1 downto 0));
                  when X"D10" =>    user_cfg_i.vdac_value(5)                   <= unsigned(data_i(user_cfg_i.vdac_value(5)'length-1 downto 0));
                  when X"D14" =>    user_cfg_i.vdac_value(6)                   <= unsigned(data_i(user_cfg_i.vdac_value(6)'length-1 downto 0));
                  when X"D18" =>    user_cfg_i.vdac_value(7)                   <= unsigned(data_i(user_cfg_i.vdac_value(7)'length-1 downto 0));
                  when X"D1C" =>    user_cfg_i.vdac_value(8)                   <= unsigned(data_i(user_cfg_i.vdac_value(8)'length-1 downto 0)); dac_cfg_in_progress <= '0';
                  
                  when others =>
                  
               end case;     
               
            end if; 
         end if; 
      end if; 
   end process;
   
   --------------------------------------------------
   -- gestion du temps d'integration
   --------------------------------------------------
   U6 : process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then
         if sreset = '1' then
            exp_cfg_fsm <= idle;
            roic_exp_time_cfg_en_i <= '0';
            int_dval_i <= '0';
            conv_exp_dval_i <= '0';
            
         else
         
            abs_fpa_int_time_offset_i <= unsigned(abs(user_cfg_i.fpa_int_time_offset));
            
            ---------------------------------------------------------------------------------
            -- pipe pour les calculs de conversion du temps d'integration et des timings DSM
            ---------------------------------------------------------------------------------
            -- pipe(0): temps d'intégration en CLK_100MHz qui tient compte de l'offset
            if user_cfg_i.fpa_int_time_offset(user_cfg_i.fpa_int_time_offset'high) = '0' then
               conv_exp_time_pipe(0) <= resize(int_time_i + abs_fpa_int_time_offset_i, conv_exp_time_pipe(0)'length); -- offset positif
            else
               conv_exp_time_pipe(0) <= resize(int_time_i - abs_fpa_int_time_offset_i, conv_exp_time_pipe(0)'length); -- offset négatif
            end if;
            -- pipe(1): étape de multiplication de la conversion en int clk
            conv_exp_time_pipe(1) <= resize(conv_exp_time_pipe(0) * resize(user_cfg_i.comn.clk100_to_intclk_conv_numerator, C_EXP_TIME_CONV_NUMERATOR_BITLEN), conv_exp_time_pipe(0)'length);
            -- pipe(2): étape de division de la conversion en int clk
            conv_exp_time_pipe(2) <= resize(conv_exp_time_pipe(1)(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_27 downto C_EXP_TIME_CONV_DENOMINATOR_BIT_POS), conv_exp_time_pipe(0)'length);  -- soit une division par 2^EXP_TIME_CONV_DENOMINATOR
            -- pipe(3): temps d'intégration converti en intclk
            conv_exp_time_pipe(3) <= conv_exp_time_pipe(2) + unsigned(resize(conv_exp_time_pipe(1)(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_M_1), conv_exp_time_pipe(0)'length));  -- pour l'operation d'arrondi
            -- On compare le temps d'intégration avec le threshold de temps total DSM
            if conv_exp_time_pipe(3) > user_cfg_i.dsm_total_time_threshold then
               -- Le temps d'intégration est plus long que le temps total de DSM
               --    on conserve le nombre de périodes maximum
               dsm_nb_period <= resize(user_cfg_i.dsm_nb_period_max, dsm_nb_period'length);
               --    on augmente la période DSM pour que le temps total soit aussi long que le temps d'intégration
               -- pipe(4): étape de multiplication de la division par le nombre de périodes maximum
               conv_exp_time_pipe(4) <= resize(conv_exp_time_pipe(3) * resize(user_cfg_i.dsm_nb_period_max_div_numerator, C_EXP_TIME_CONV_NUMERATOR_BITLEN), conv_exp_time_pipe(0)'length);
               -- pipe(5): durée de la période DSM (la valeur est tronquée plutôt qu'arrondie)
               conv_exp_time_pipe(5) <= resize(conv_exp_time_pipe(4)(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_27 downto C_EXP_TIME_CONV_DENOMINATOR_BIT_POS), conv_exp_time_pipe(0)'length);  -- soit une division par 2^EXP_TIME_CONV_DENOMINATOR
               -- pipe(6): on s'assure que la durée de la période DSM est plus grande que la période minimum
               dsm_period <= MAX(resize(conv_exp_time_pipe(5), dsm_period'length), resize(user_cfg_i.dsm_period_min, dsm_period'length));
            else
               -- Le temps d'intégration est plus court que le temps total de DSM
               --    on conserve la période DSM minimum
               dsm_period <= resize(user_cfg_i.dsm_period_min, dsm_period'length);
               --    on diminue le nombre de périodes jusqu'à ce que le temps total soit aussi long que le temps d'intégration
               -- pipe(4): étape de multiplication de la division par la période DSM minimum
               conv_exp_time_pipe(4) <= resize(conv_exp_time_pipe(3) * resize(user_cfg_i.dsm_period_min_div_numerator, C_EXP_TIME_CONV_NUMERATOR_BITLEN), conv_exp_time_pipe(0)'length);
               -- pipe(5): nombre de périodes DSM (la valeur est tronquée plutôt qu'arrondie)
               conv_exp_time_pipe(5) <= resize(conv_exp_time_pipe(4)(C_EXP_TIME_CONV_DENOMINATOR_BIT_POS_P_27 downto C_EXP_TIME_CONV_DENOMINATOR_BIT_POS), conv_exp_time_pipe(0)'length);  -- soit une division par 2^EXP_TIME_CONV_DENOMINATOR
               -- pipe(6): on s'assure que le nombre de périodes DSM est plus grand que le nombre de périodes minimum
               dsm_nb_period <= MAX(resize(conv_exp_time_pipe(5), dsm_nb_period'length), resize(user_cfg_i.dsm_nb_period_min, dsm_nb_period'length));
            end if;
            -- pipe(7): durée du délai de la période DSM
            dsm_period_delay <= resize(dsm_period - user_cfg_i.dsm_period_constants, dsm_period'length);
            -- pipe(8): copie des valeurs calculées dans la config
            --    bIntCnt est le temps d'intégration converti en int clk pour le fpa. Le temps d'intégration est bIntCnt + 1
            roic_exp_time_cfg_i.bIntCnt <= resize(conv_exp_time_pipe(3) - 1, roic_exp_time_cfg_i.bIntCnt'length);
            --    bDSMCycles est le nombre de DSM demandés au ROIC. Le nombre de cycles est bDSMCycles + 1 et il y a 1 période DSM pour DSMInitDelay
            roic_exp_time_cfg_i.bDSMCycles <= resize(dsm_nb_period - 2, roic_exp_time_cfg_i.bDSMCycles'length);
            --    bDSMDelayCnt est le délai entre les cycles DSM. Le délai est bDSMDelayCnt + 1
            roic_exp_time_cfg_i.bDSMDelayCnt <= resize(dsm_period_delay - 1, roic_exp_time_cfg_i.bDSMDelayCnt'length);
            --    bDSMInitDelayCnt est le délai avant le 1er cycle DSM. On utilise DSMInitDelay = DSMPeriod. Le délai est bDSMInitDelayCnt + 1
            roic_exp_time_cfg_i.bDSMInitDelayCnt <= resize(dsm_period - 1, roic_exp_time_cfg_i.bDSMInitDelayCnt'length);
            
            -- signal high time est en CLK_100MHz et tient compte du ET offset
            int_signal_high_time_i <= resize(conv_exp_time_pipe(0), int_signal_high_time_i'length);
            
            -- pipe pour rendre la donnée valide après la conversion
            conv_exp_dval_pipe <= conv_exp_dval_pipe(conv_exp_dval_pipe'high-1 downto 0) & conv_exp_dval_i;
            
            case exp_cfg_fsm is
               
               -- on attend qu'un nouveau temps d'intégration arrive
               when idle =>
                  int_dval_i <= '0';
                  if FPA_EXP_INFO.EXP_DVAL = '1' then   -- le signal FPA_EXP_INFO.EXP_DVAL est un pulse
                     conv_exp_dval_i <= '1';
                     -- on copie les valeurs venant de la FPA_EXP_INFO
                     int_time_i <= FPA_EXP_INFO.EXP_TIME;
                     int_indx_i <= FPA_EXP_INFO.EXP_INDX;
                     exp_cfg_fsm <= wait_conv_st;
                  end if;
               
               -- on attend la fin de la conversion
               when wait_conv_st =>
                  conv_exp_dval_i <= '0';
                  -- pipe dval synchro avec pipe de conversion. à ce moment-ci les données sont déjà prêtes donc cet état nous donne 1 clk de plus
                  if conv_exp_dval_pipe(conv_exp_dval_pipe'high) = '1' then
                     exp_cfg_fsm <= wait_prog_rdy_st; 
                  end if;
               
               -- on attend que le programmeur soit prêt
               when wait_prog_rdy_st =>
                  if user_cfg_i.comn.fpa_diag_mode = '1' then
                     -- en diag mode on ne programme pas, on valide directement les infos d'intégration
                     int_dval_i <= '1';        -- reste à 1 pour 1 clk
                     exp_cfg_fsm <= idle;
                  elsif roic_exp_time_cfg_done_sync = '1' then
                     roic_exp_time_cfg_en_i <= '1';        -- reste à 1 tant que la requête n'a pas été approuvée
                     exp_cfg_fsm <= wait_prog_ack_st; 
                  end if;
               
               -- on attend la confirmation du programmeur
               when wait_prog_ack_st =>
                  if roic_exp_time_cfg_done_sync = '0' then
                     roic_exp_time_cfg_en_i <= '0';
                     exp_cfg_fsm <= wait_prog_end_st; 
                  end if;
               
               -- on attend la confirmation du programmeur
               when wait_prog_end_st =>
                  if roic_exp_time_cfg_done_sync = '1' then
                     int_dval_i <= '1';        -- reste à 1 pour 1 clk
                     exp_cfg_fsm <= idle; 
                  end if;
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
   
   
   ----------------------------------------------------------------------------
   -- CFG MB AXI RD : contrôle du flow
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2   
   U7: process (MB_CLK)
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
   U8: process(MB_CLK)
   begin
      if rising_edge(MB_CLK) then         
         
         if  MB_MOSI.ARADDR(STATUS_BASE_ARADDR_WIDTH) = '1' then    -- adresse de base pour la lecture des statuts
            axi_rdata <= STATUS_MISO.RDATA; -- la donnée de statut est valide 1CLK après MB_MOSI.ARVALID            
         else 
            case MB_MOSI.ARADDR(11 downto 0) is
               when X"000" => axi_rdata <= resize(kpix_status, axi_rdata'length);
               when X"004" => axi_rdata <= resize(compr_err_latch, axi_rdata'length);
               when X"008" => axi_rdata <= resize(ROIC_RX_NB_DATA, axi_rdata'length);
               when others => axi_rdata <= (others => '1'); 
            end case; 
         end if;
         
      end if;     
   end process;   
   
   ----------------------------------------------------------------------------
   -- CFG MB AXI WR : contrôle du flow 
   ---------------------------------------------------------------------------- 
   -- (pour l'instant transaction se fait à au max 1 CLK sur 2 
   U9: process (MB_CLK)
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
   U10: process (MB_CLK)
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