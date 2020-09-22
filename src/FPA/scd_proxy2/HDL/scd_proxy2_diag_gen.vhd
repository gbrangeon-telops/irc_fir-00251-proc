-------------------------------------------------------------------------------
--
-- Title       : scd_proxy2_diag_gen
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\SCD_PROXY2_Hercules\src\scd_proxy2_diag_gen.vhd
-- Generated   : Mon Jan 10 13:16:11 2011
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
use IEEE.numeric_std.all;
use work.FPA_define.all;
use work.Proxy_define.all;
use work.fpa_common_pkg.all;


entity scd_proxy2_diag_gen is
   
   port(
      
      ARESET       : in std_logic;
      CLK          : in std_logic;
      
      FPA_INTF_CFG : fpa_intf_cfg_type;
      DIAG_MODE_EN : in std_logic;
      
      FPA_INT      : in std_logic;
      
      CH1_DATA     : out std_logic_vector(27 downto 0); --! sortie des données deserialisés sur CH1    
      CH2_DATA     : out std_logic_vector(27 downto 0); --! sortie des données deserialisés sur CH2 
      
      DIAG_HDER    : out std_logic; --! 'à 1 pour signmifier la sortie du header
      DIAG_LINE    : out std_logic; --! 'à 1 pour signmifier la sortie des données d'une ligne
      DIAG_FRAME   : out std_logic
      
      );
end scd_proxy2_diag_gen;


architecture rtl of scd_proxy2_diag_gen is
   
   constant spare : std_logic := 'Z';
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component Clk_Divider is
      Generic(	
         Factor : integer := 2);		
      Port ( 
         Clock     : in std_logic;
         Reset     : in std_logic;		
         Clk_div   : out std_logic);
   end component;
   
   component fpa_diag_line_gen
      generic (
         ANALOG_IDDCA           : boolean := false;
         SAMP_NUM_PER_PIX       : natural range 0 to 15 := 5 
         );
      port(
         CLK                : in std_logic;
         ARESET             : in std_logic;
         LINE_SIZE          : in std_logic_vector(15 downto 0);
         START_PULSE        : in std_logic;
         FIRST_VALUE        : in std_logic_vector(15 downto 0); 
         INCR_VALUE         : in std_logic_vector(15 downto 0);
         PIX_SAMP_TRIG      : in std_logic;
         DIAG_DATA          : out std_logic_vector(15 downto 0);
         DIAG_DVAL          : out std_logic; 
         DIAG_SOL           : out std_logic;
         DIAG_EOL           : out std_logic;   
         DIAG_DONE          : out std_logic
         );
   end component;
   
   type diag_fsm_type is (idle, fig1_or_fig2_T6_dly_st, rst_cnt_st, fig4_T1_dly_st,fval_on_st,fig4_T2_dly_st, hder_st,
   start_line_gen_st, wait_line_gen_end_st, line_pause_st, fig1_or_fig2_T5_dly_st);
   type img_change_sm_type is (idle, change_st);
   
   signal diag_fsm          : diag_fsm_type;
   signal img_change_sm     : img_change_sm_type;
   signal ch1_data_i        : std_logic_vector(15 downto 0);
   signal ch2_data_i        : std_logic_vector(15 downto 0);
   signal hder_i            : std_logic;
   signal fval_i            : std_logic;
   signal lval_i            : std_logic;
   signal dval_i            : std_logic;    
   signal sreset            : std_logic;
   signal line_size_i       : std_logic_vector(15 downto 0);
   signal diag_line_gen_en  : std_logic;
   signal ch1_first_value   : std_logic_vector(15 downto 0);
   signal ch2_first_value   : std_logic_vector(15 downto 0);
   signal ch1_incr_value    : std_logic_vector(15 downto 0);
   signal ch2_incr_value    : std_logic_vector(15 downto 0);
   signal ch1_diag_data     : std_logic_vector(15 downto 0);
   signal ch2_diag_data     : std_logic_vector(15 downto 0);
   signal ch1_diag_dval     : std_logic;
   signal ch2_diag_dval     : std_logic;
   signal diag_done_i       : std_logic;
   signal dly_cnt           : unsigned(15 downto 0);
   signal hder_dcnt         : unsigned(15 downto 0);
   signal line_cnt          : unsigned(15 downto 0);
   signal fpa_int_i         : std_logic;
   signal fpa_int_last      : std_logic;
   signal revert_img        : std_logic;
   signal clk_div_i         : std_logic;
   signal clk_div_last      : std_logic;
   signal hder_data_id      : unsigned(7 downto 0);
   signal diag_clk_i        : std_logic;
   signal diag_clk_last_i   : std_logic;
   signal pix_samp_trig_i   : std_logic;
   
begin
   
   ----------------------------------------------
   -- OUTPUTS                                    
   ----------------------------------------------
   -- se reporter à la page 21 du doument Communication protocol appendix A5 (SPEC. NO: DPS3008) dans le dossier du pelicanD
   
   CH1_DATA(0)  <=  ch1_data_i(0);  
   CH1_DATA(1)  <=  ch1_data_i(1);  
   CH1_DATA(2)  <=  ch1_data_i(2);  
   CH1_DATA(3)  <=  ch1_data_i(3);  
   CH1_DATA(4)  <=  ch1_data_i(4);  
   CH1_DATA(5)  <=  ch1_data_i(7);
   CH1_DATA(6)  <=  ch1_data_i(5);  
   CH1_DATA(7)  <=  ch1_data_i(8);
   CH1_DATA(8)  <=  ch1_data_i(9);  
   CH1_DATA(9)  <=  ch1_data_i(10); 
   CH1_DATA(10) <=  ch1_data_i(14);
   CH1_DATA(11) <=  ch1_data_i(15);
   CH1_DATA(12) <=  ch1_data_i(11); 
   CH1_DATA(13) <=  ch1_data_i(12); 
   CH1_DATA(14) <=  ch1_data_i(13);
   CH1_DATA(15) <=  ch2_data_i(0);
   CH1_DATA(16) <=  ch2_data_i(6);
   CH1_DATA(17) <=  ch2_data_i(7);  
   CH1_DATA(18) <=  ch2_data_i(1);
   CH1_DATA(19) <=  ch2_data_i(2);
   CH1_DATA(20) <=  ch2_data_i(3);
   CH1_DATA(21) <=  ch2_data_i(4);
   CH1_DATA(22) <=  ch2_data_i(5);   
   CH1_DATA(23) <=  hder_i;         
   CH1_DATA(24) <=  lval_i;           
   CH1_DATA(25) <=  fval_i;           
   CH1_DATA(26) <=  dval_i;
   CH1_DATA(27) <=  ch1_data_i(6); 
   
   CH2_DATA(0)  <=  ch2_data_i(8);
   CH2_DATA(1)  <=  ch2_data_i(9);
   CH2_DATA(2)  <=  ch2_data_i(10);
   CH2_DATA(3)  <=  ch2_data_i(11);
   CH2_DATA(4)  <=  ch2_data_i(12);
   CH2_DATA(5)  <=  ch2_data_i(15);
   CH2_DATA(6)  <=  ch2_data_i(13);
   CH2_DATA(7)  <=  spare;
   CH2_DATA(8)  <=  spare;  
   CH2_DATA(9)  <=  spare; 
   CH2_DATA(10) <=  spare;
   CH2_DATA(11) <=  spare;
   CH2_DATA(12) <=  spare; 
   CH2_DATA(13) <=  spare; 
   CH2_DATA(14) <=  spare;
   CH2_DATA(15) <=  spare;
   CH2_DATA(16) <=  spare;
   CH2_DATA(17) <=  spare;  
   CH2_DATA(18) <=  spare;
   CH2_DATA(19) <=  spare;
   CH2_DATA(20) <=  spare;
   CH2_DATA(21) <=  spare;
   CH2_DATA(22) <=  spare;   
   CH2_DATA(23) <=  hder_i;
   CH2_DATA(24) <=  lval_i; 
   CH2_DATA(25) <=  fval_i;  
   CH2_DATA(26) <=  dval_i;
   CH2_DATA(27) <=  ch2_data_i(14);
   
   DIAG_HDER  <= hder_i;
   DIAG_LINE  <= lval_i;
   DIAG_FRAME <= fval_i;
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   --------------------------------------------------
   -- clock divider
   -------------------------------------------------- 
   -- sampling clk enable
   genA: if DEFINE_DIAG_DATA_CLK_FACTOR > 1 generate     
      UCa: Clk_Divider
      Generic map(
         Factor => DEFINE_DIAG_DATA_CLK_FACTOR
         )
      Port map( 
         Clock   => CLK, 
         Reset   => sreset, 
         Clk_div => diag_clk_i   -- attention, c'est en realité un clock enable.
         );  
      
      -- sampling trig en mode diag
      UCb : process(CLK)
      begin
         if rising_edge(CLK) then
            diag_clk_last_i <= diag_clk_i;
            pix_samp_trig_i <= not diag_clk_last_i and diag_clk_i;
         end if;
      end process;
   end generate;
   
   genB: if DEFINE_DIAG_DATA_CLK_FACTOR <= 1 generate 
      pix_samp_trig_i <= '1'; 
   end generate;   
   
   
   --------------------------------------------------
   -- CH1 data gen 
   --------------------------------------------------   
   U1: fpa_diag_line_gen
   generic map(
      ANALOG_IDDCA => false,      
      SAMP_NUM_PER_PIX => 1
      )
   port map(
      CLK => CLK,
      ARESET => ARESET,
      LINE_SIZE => line_size_i,
      START_PULSE => diag_line_gen_en,
      FIRST_VALUE => ch1_first_value,
      INCR_VALUE => ch1_incr_value,
      PIX_SAMP_TRIG => pix_samp_trig_i,
      DIAG_DATA => ch1_diag_data,
      DIAG_DVAL => ch1_diag_dval,
      DIAG_SOL => open,
      DIAG_EOL => open,    
      DIAG_DONE => diag_done_i
      );
   
   --------------------------------------------------
   -- CH2 data gen 
   --------------------------------------------------   
   U2: fpa_diag_line_gen
   generic map(
      ANALOG_IDDCA => false,      
      SAMP_NUM_PER_PIX => 1
      )
   port map(
      CLK => CLK,
      ARESET => ARESET,
      LINE_SIZE => line_size_i,
      START_PULSE => diag_line_gen_en,
      FIRST_VALUE => ch2_first_value,
      INCR_VALUE => ch2_incr_value,
      PIX_SAMP_TRIG => pix_samp_trig_i,
      DIAG_DATA => ch2_diag_data,
      DIAG_DVAL => ch2_diag_dval,
      DIAG_SOL => open,
      DIAG_EOL => open,   
      DIAG_DONE => open
      );   
   
   -------------------------------------------------------------------
   -- generation des données du mode diag   
   -------------------------------------------------------------------   
   U3: process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            diag_fsm <=  idle;
            fval_i <= '0';
            dval_i <= '0';
            lval_i <= '0';
            hder_i <= '0';
            fpa_int_last <= fpa_int_i;
         else   
            fpa_int_i <= FPA_INT;
            fpa_int_last <= fpa_int_i;
            
            -- configuration des generateurs de lignes
            if FPA_INTF_CFG.COMN.FPA_DIAG_TYPE = TELOPS_DIAG_CNST then         -- constant               
               ch1_first_value <= std_logic_vector(to_unsigned(4096, ch1_first_value'length)); 
               ch2_first_value <= std_logic_vector(to_unsigned(4096, ch2_first_value'length));
               ch1_incr_value <= (others => '0');
               ch2_incr_value <= (others => '0');
               
            else                                                       -- degradé lineaire constant et dégradé linéaire dynamique
               ch1_first_value <= std_logic_vector(to_unsigned(0, ch1_first_value'length)); --  (others => '0'); 
               ch2_first_value <= std_logic_vector(to_unsigned(0 + DIAG_DATA_INC, ch2_first_value'length));
               ch1_incr_value <= std_logic_vector(to_unsigned(2*DIAG_DATA_INC, ch1_incr_value'length));
               ch2_incr_value <= std_logic_vector(to_unsigned(2*DIAG_DATA_INC, ch2_incr_value'length));            
            end if;
            
            -- machine à états
            -- se reporter aux figures 1 et 2 et 4 des pages 13, 15 et 19 du doument Communication protocol appendix A5 (SPEC. NO: DPS3008) dans le dossier du pelicanD
            -- le delai T4 est déjà observé par le module fpa_driver pour generer FPA_INT et ACQ_INT
            case diag_fsm is 
               
               when idle =>
                  dly_cnt <= (others => '0');
                  hder_dcnt <= to_unsigned(1, hder_dcnt'length);
                  hder_data_id <= (others => '0');
                  line_cnt <= (others => '0');
                  dval_i <= '0';
                  lval_i <= '0';
                  fval_i <= '0';
                  diag_line_gen_en <= '0'; 
                  if DIAG_MODE_EN = '1' then 
                     if FPA_INTF_CFG.OP.INT_MODE = IWR then 
                        if fpa_int_last = '0' and fpa_int_i = '1' then   -- en mode IWR, le delay T6 est appliqué à partir du debut de l'integration
                           diag_fsm <=  fig1_or_fig2_T6_dly_st;              -- les nomenclatures des delais sont identiques sur les figures 1 et 2.
                        end if;
                     else
                        if fpa_int_last = '1' and fpa_int_i = '0' then   -- en mode ITR, le delay T6 est appliqué à partir de la fin de l'integration
                           diag_fsm <=  fig1_or_fig2_T6_dly_st;              -- les nomenclatures des delais sont identiques sur les figures 1 et 2.
                        end if;
                     end if;
                  end if;
               
               when fig1_or_fig2_T6_dly_st =>    -- figure 1 ou 2 : delay T6,
                  if dly_cnt >= FPA_INTF_CFG.MISC.FIG1_OR_FIG2_T6_DLY then 
                     diag_fsm <=  fval_on_st;                   
                  else
                     dly_cnt <= dly_cnt + 1; 
                  end if;
               --               
               when fval_on_st =>        -- figure 4 : Fval à on
                  fval_i <= '1';
                  diag_fsm <=  fig4_T2_dly_st; 
                  dly_cnt <= (others => '0');
               
               when fig4_T2_dly_st =>    -- figure 4 : pause T2
                  if dly_cnt = FPA_INTF_CFG.MISC.FIG4_T2_DLY then 
                     diag_fsm <=  hder_st;
                     
                  else
                     dly_cnt <= dly_cnt + 1; 
                  end if;  
               
               when hder_st =>
                  lval_i <= '1';
                  dval_i <= '1';
                  hder_i <= '1';
                  hder_dcnt <= hder_dcnt + 1;
                  hder_data_id <= hder_data_id + 1;
                  ch1_data_i <= (others => '0');
                  ch2_data_i <= (others => '0');                  
                  if hder_dcnt > FPA_INTF_CFG.MISC.FIG4_T6_DLY then
                     hder_i <= '0';                     
                  end if;
                  if hder_dcnt > FPA_INTF_CFG.MISC.FIG4_T3_DLY then
                     lval_i <= '0';
                     dval_i <= '0';
                  end if;
                  if hder_dcnt = FPA_INTF_CFG.MISC.FIG4_T5_DLY then
                     diag_fsm <=  start_line_gen_st;
                  else
                     
                  end if;
                  
                  
                  case to_integer(hder_data_id) is
                     when 0 =>   -- Byte 0
                        ch1_data_i(7 downto 0) <=  x"FF"; -- frame_start_id  <= fpa_hder_data(0);  -- Frame Start 
                     
                     when 4 =>   --  Byte[16 to 19]
                        ch1_data_i <=  x"8021";  -- last_cmd_id  <= fpa_hder_data(1) & fpa_hder_data(0); -- last successful command ID / failure ID
                        ch2_data_i(7 downto 0)  <= x"18";  -- byte_18          <= fpa_hder_data(2);
                        ch2_data_i(15 downto 8) <= x"19";  -- byte_19          <= fpa_hder_data(3);
                     
                     when 5 =>   -- byte 20
                        ch1_data_i(7 downto 0)  <= x"20";  -- byte_20          <= fpa_hder_data(0);
                     
                     when 6 =>   -- Byte[26:24]
                        ch1_data_i(7 downto 0)  <= std_logic_vector(FPA_INTF_CFG.INT.INT_TIME(7 downto 0));  --fpa_int_time(23 downto 0) <= unsigned(fpa_hder_data(2)) & unsigned(fpa_hder_data(1)) & unsigned(fpa_hder_data(0));    -- temps d'integration
                        ch1_data_i(15 downto 8) <= std_logic_vector(FPA_INTF_CFG.INT.INT_TIME(15 downto 8));
                        ch2_data_i(7 downto 0)  <= std_logic_vector(FPA_INTF_CFG.INT.INT_TIME(23 downto 16));
                     
                     when 8 =>   -- Byte[33:32] Byte[35:34]
                        ch1_data_i <= std_logic_vector(resize(FPA_INTF_CFG.OP.YSIZE,16));--fpa_ysize <= resize((unsigned(fpa_hder_data(1)) & unsigned(fpa_hder_data(0))), fpa_ysize'length);
                        ch2_data_i <= std_logic_vector(resize(FPA_INTF_CFG.OP.XSIZE,16));--fpa_xsize <= resize((unsigned(fpa_hder_data(3)) & unsigned(fpa_hder_data(2))), fpa_xsize'length);              
                     
                     when 11 => -- Byte[47..46]
                        ch2_data_i <= x"ABCD";--fpa_temp_pos <= unsigned(fpa_hder_data(3)) &  unsigned(fpa_hder_data(2));                -- fpa_temp_pos
                     
                     when 12 => -- Byte[49..48]
                        ch1_data_i <= x"00CD";--fpa_temp_neg <= unsigned(fpa_hder_data(1)) & unsigned(fpa_hder_data(0));                 -- fpa_temp_neg
                        --fpa_temp_reg_dval <= '1';
                     
                     when others =>
                        ch1_data_i <= (others => '0');
                        ch2_data_i <= (others => '0');
                     
                  end case;
               
               when start_line_gen_st =>
                  diag_line_gen_en <= '1';   -- on active le module généateur des données diag
                  line_size_i <= std_logic_vector(resize(FPA_INTF_CFG.MISC.XSIZE_DIV2, line_size_i'length)); 
                  dly_cnt <= (others => '0');
                  if diag_done_i = '0' then
                     diag_line_gen_en <= '0';
                     line_cnt <= line_cnt + 1;
                     diag_fsm <=  wait_line_gen_end_st;
                  end if;
               
               when wait_line_gen_end_st =>
                  lval_i <= '1';   
                  dval_i <= ch1_diag_dval; -- on se branche sur le module generateur de données diag
                  if revert_img = '1' then 
                     ch1_data_i <= not ch1_diag_data;     -- dégradé vers la gauche 
                     ch2_data_i <= not ch2_diag_data;     -- dégradé vers la gauche 
                  else
                     ch1_data_i <= ch1_diag_data; -- dégradé vers la droite 
                     ch2_data_i <= ch2_diag_data; -- dégradé vers la droite
                  end if;
                  if diag_done_i = '1' then  
                     diag_fsm <=  line_pause_st;
                     dly_cnt <= to_unsigned(6, dly_cnt'length); -- pour tenir compte des delais supplémentaires (vus en simulation)
                  end if;
               
               when line_pause_st =>
                  lval_i <= '0';  
                  dly_cnt <= dly_cnt + 1;
                  if dly_cnt >= FPA_INTF_CFG.MISC.FIG4_T4_DLY then
                     diag_fsm <=  start_line_gen_st;
                  end if;
                  if line_cnt >= FPA_INTF_CFG.OP.YSIZE then
                     diag_fsm <=  rst_cnt_st;
                  end if;
               
               when rst_cnt_st =>
                  dly_cnt <= (others => '0');
                  diag_fsm <=  fig1_or_fig2_T5_dly_st; 
               
               when fig1_or_fig2_T5_dly_st =>
                  dly_cnt <= dly_cnt + 1;                                                                             
                  if dly_cnt = FPA_INTF_CFG.MISC.FIG1_OR_FIG2_T5_DLY then
                     diag_fsm <= idle; 
                  end if;
               
               when others =>
               
            end case;
            
         end if;         
      end if;
   end process;
   
   --------------------------------------------------------
   -- Genereteur d'impulsion de 2 secondes de periode
   -------------------------------------------------------- 
   U4: Clk_Divider
   Generic map(
      Factor=> 200_000_000
      -- pragma translate_off
      /10_000
      -- pragma translate_on
      )
   Port map( 
      Clock => CLK, 
      Reset => sreset, 
      Clk_div => clk_div_i
      );
   
   ----------------------------------------------------------
   -- contrôle du basculement de l'image en mode dynamique
   ---------------------------------------------------------- 
   U5: process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            img_change_sm <= idle;
            revert_img <= '0';
         else 
            
            clk_div_last <= clk_div_i;
            
            case img_change_sm is
               
               when idle =>
                  if FPA_INTF_CFG.COMN.FPA_DIAG_TYPE = TELOPS_DIAG_DEGR_DYN then --  mode degradé dynamique
                     if clk_div_last = '0' and clk_div_i = '1' then    -- il faut attendre 2 secondes avant de changer d'état
                        img_change_sm <= change_st;
                     end if;
                  else
                     revert_img <= '0';
                  end if;
               
               when change_st =>
                  if hder_i = '1' then    -- on attend le debut d'une nouvelle image pour que le chagement d'état soit effectif
                     revert_img <= not revert_img;
                     img_change_sm <= idle;
                  end if;
               
               when others =>
               
            end case;        
            
         end if;
      end if;
   end process; 
   
end rtl;
