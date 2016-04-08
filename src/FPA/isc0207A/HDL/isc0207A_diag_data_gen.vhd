-------------------------------------------------------------------------------
--
-- Title       : isc0207_diag_data_gen
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\PROXY_Hercules\src\isc0207_diag_data_gen.vhd
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
use work.fpa_common_pkg.all;


entity isc0207_diag_data_gen is
   
   port(
      
      ARESET            : in std_logic;
      MCLK_SOURCE       : in std_logic;
      
      FPA_INTF_CFG      : fpa_intf_cfg_type;
      DIAG_MODE_EN      : in std_logic;
      
      FPA_INT           : in std_logic;
      DATA_SYNC_FLAG    : in std_logic;
      
      QUAD1_DIAG_DATA   : out std_logic_vector(56 downto 0); --! sortie des données 
      QUAD2_DIAG_DATA   : out std_logic_vector(56 downto 0);
      QUAD3_DIAG_DATA   : out std_logic_vector(56 downto 0);
      QUAD4_DIAG_DATA   : out std_logic_vector(56 downto 0);
      QUAD_DIAG_DVAL    : out std_logic
      );
end isc0207_diag_data_gen;


architecture rtl of isc0207_diag_data_gen is
   
   constant spare : std_logic := '0';
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component clk_divider_asyn is
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
   
   constant  C_FPA_TAP_NUMBER_M1 : integer := DEFINE_FPA_TAP_NUMBER - 1; 
   
   type diag_fsm_type is (idle, int_st, junk_data_st, tir_dly_st, get_line_data_st, cfg_line_gen_st, check_end_st);
   type img_change_sm_type is (idle, change_st); 
   type data_type is array (0 to C_FPA_TAP_NUMBER_M1) of std_logic_vector(15 downto 0);
   
   signal diag_fsm          : diag_fsm_type;
   signal img_change_sm     : img_change_sm_type;
   signal data              : data_type;
   signal diag_frame_done   : std_logic;
   signal dval_i            : std_logic;    
   signal sreset            : std_logic;
   signal line_size         : std_logic_vector(15 downto 0);
   signal diag_line_gen_en  : std_logic;
   signal first_value       : data_type;
   signal incr_value        : std_logic_vector(15 downto 0);
   signal fpa_2xmclk_dummy  : std_logic;
   
   signal diag_data         : data_type;
   signal diag_dval         : std_logic_vector(C_FPA_TAP_NUMBER_M1 downto 0);
   signal ch2_diag_dval     : std_logic;
   signal diag_done         : std_logic_vector(C_FPA_TAP_NUMBER_M1 downto 0);
   signal dly_cnt           : unsigned(15 downto 0);
   signal data_cnt          : unsigned(15 downto 0);
   signal line_cnt          : unsigned(15 downto 0);
   signal fpa_int_i         : std_logic;
   signal fpa_int_last      : std_logic;
   signal revert_img        : std_logic;
   signal clk_div_i         : std_logic;
   signal clk_div_last      : std_logic;
   signal pix_count         : unsigned(31 downto 0);
   signal sync_flag         : std_logic;
   signal pixel_samp_trig   : std_logic;
   signal diag_quad_clk_i   : std_logic;
   signal diag_quad_clk_last: std_logic;
   signal diag_done_last    : std_logic;
   
   attribute dont_touch     : string;
   attribute dont_touch of diag_fsm : signal is "true";
   
begin
   
   ----------------------------------------------
   -- OUTPUTS                                    
   ----------------------------------------------
   QUAD4_DIAG_DATA <= sync_flag & not (data(15)(13 downto 0) & data(14)(13 downto 0) & data(13)(13 downto 0) & data(12)(13 downto 0)); -- inverion des données pour emuler le 0207
   QUAD3_DIAG_DATA <= sync_flag & not (data(11)(13 downto 0) & data(10)(13 downto 0) & data(9)(13 downto 0)  & data(8)(13 downto 0));
   QUAD2_DIAG_DATA <= sync_flag & not (data(7)(13 downto 0)  & data(6)(13 downto 0)  & data(5)(13 downto 0)  & data(4)(13 downto 0));
   QUAD1_DIAG_DATA <= sync_flag & not (data(3)(13 downto 0)  & data(2)(13 downto 0)  & data(1)(13 downto 0)  & data(0)(13 downto 0));
   QUAD_DIAG_DVAL  <= dval_i;
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => MCLK_SOURCE,
      SRESET => sreset
      );
   
   
   --------------------------------------------------
   -- 16 channels diag data gen 
   -------------------------------------------------- 
   -- sampling clk enable
   UCa: clk_divider_asyn
   Generic map(
      Factor => DEFINE_ADC_QUAD_CLK_FACTOR
      )
   Port map( 
      Clock   => MCLK_SOURCE, 
      Reset   => sreset, 
      Clk_div => diag_quad_clk_i   -- attention, c'est en realité un clock enable.
      );  
   
   -- sampling trig en mode diag
   UCb : process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         diag_quad_clk_last <= diag_quad_clk_i;
         pixel_samp_trig <= not diag_quad_clk_last and diag_quad_clk_i;
      end if;
   end process;
   
   -- smapping avec generateur de données
   U1 : for ii in 0 to C_FPA_TAP_NUMBER_M1 generate 
      diag_line_ii : fpa_diag_line_gen 
      generic map(
         ANALOG_IDDCA => true,      
         SAMP_NUM_PER_PIX => DEFINE_FPA_PIX_SAMPLE_NUM_PER_CH
         )
      port map(
         CLK         => MCLK_SOURCE,
         ARESET      => ARESET,
         LINE_SIZE   => line_size,
         START_PULSE => diag_line_gen_en,
         FIRST_VALUE => first_value(ii),
         INCR_VALUE  => incr_value,
         PIX_SAMP_TRIG => pixel_samp_trig,
         DIAG_DATA   => diag_data(ii),
         DIAG_DVAL   => diag_dval(ii),
         DIAG_SOL    => open,
         DIAG_EOL    => open,   
         DIAG_DONE   => diag_done(ii)
         );
   end generate; 
   
   -- pragma translate_off
   Udbg : fpa_diag_line_gen 
   generic map(
      ANALOG_IDDCA => true,      
      SAMP_NUM_PER_PIX => DEFINE_FPA_PIX_SAMPLE_NUM_PER_CH
      )
   port map(
      CLK         => MCLK_SOURCE,
      ARESET      => ARESET,
      LINE_SIZE   => line_size,
      START_PULSE => diag_line_gen_en,
      FIRST_VALUE => first_value(0),
      INCR_VALUE  => incr_value,
      PIX_SAMP_TRIG => pixel_samp_trig,
      DIAG_DATA   => open,
      DIAG_DVAL   => open,
      DIAG_SOL    => open,
      DIAG_EOL    => open,   
      DIAG_DONE   => open
      );
   -- pragma translate_on 
   
   -------------------------------------------------------------------
   -- generation des données du mode diag   
   -------------------------------------------------------------------   
   U3: process(MCLK_SOURCE)
   begin          
      if rising_edge(MCLK_SOURCE) then 
         if sreset = '1' then 
            diag_fsm <=  idle;
            dval_i <= '0';
            diag_frame_done <= '0';
            fpa_int_last <= fpa_int_i;
            diag_line_gen_en <= '0';
         else   
            
            
            diag_done_last <= diag_done(0); 
            
            sync_flag <= DATA_SYNC_FLAG;
            fpa_int_i <= FPA_INT;
            fpa_int_last <= fpa_int_i; 
            
            -- pragma translate_off
            if diag_frame_done = '0' then
               if dval_i = '1' then 
                  pix_count <= pix_count + 2;
               end if;
            else
               pix_count <= (others => '0');               
            end if;             
            -- pragma translate_on
            
            -- configuration des generateurs de lignes
            if FPA_INTF_CFG.COMN.FPA_DIAG_TYPE = DEFINE_TELOPS_DIAG_CNST then  -- constant
               for ii in 0 to C_FPA_TAP_NUMBER_M1 loop
                  first_value(ii) <= std_logic_vector(to_unsigned(4096, first_value(0)'length)); 
                  incr_value <= (others => '0');
               end loop;               
            else                                                       
               for ii in 0 to C_FPA_TAP_NUMBER_M1 loop                  -- degradé lineaire constant et dégradé linéaire dynamique
                  first_value(ii) <= std_logic_vector(to_unsigned(ii*DEFINE_DIAG_DATA_INC, first_value(0)'length));
                  incr_value <= std_logic_vector(to_unsigned(DEFINE_FPA_TAP_NUMBER*DEFINE_DIAG_DATA_INC, first_value(0)'length));
               end loop;                        
            end if;
            
            -- machine à états
            case diag_fsm is 
               
               when idle =>
                  dly_cnt <= (others => '0');
                  data_cnt <= to_unsigned(1, data_cnt'length);
                  line_cnt <= (others => '0');
                  dval_i <= '0';
                  diag_frame_done <= '1';
                  diag_line_gen_en <= '0'; 
                  if DIAG_MODE_EN = '1' then 
                     if fpa_int_last = '0' and fpa_int_i = '1' then   -- seul le mode ITR est supporté poour le momeent.
                        diag_fsm <=  int_st;                  
                     end if;
                  end if;
               
               when int_st =>
                  if fpa_int_i = '0' then
                     diag_fsm <=  tir_dly_st;
                  end if;
               
               when tir_dly_st =>
                  diag_frame_done <= '0';   
                  dly_cnt <= dly_cnt + 1;              
                  if dly_cnt >= to_integer(FPA_INTF_CFG.DIAG_TIR) then 
                     diag_fsm <=  junk_data_st;                   
                  end if;                         
               
               when junk_data_st =>
                  dval_i <= '1';     -- le module fifo writer saura extraire les veritables données. Cet état existe juste pour tester sa capacité d'extraction
                  diag_fsm <=  cfg_line_gen_st;
               
               when cfg_line_gen_st =>
                  diag_line_gen_en <= '1';                              -- on active le module généateur des données diag
                  line_size <= std_logic_vector(resize(FPA_INTF_CFG.XSIZE_DIV_TAPNUM, line_size'length)); 
                  dly_cnt <= (others => '0');  
                  line_cnt <= line_cnt + 1;
                  diag_fsm <=  get_line_data_st;
               
               when get_line_data_st => 
                  dval_i <= diag_dval(0);         
                  if diag_done(0) = '0' then
                     diag_line_gen_en <= '0';              
                  end if;
                  -- on se branche sur le module generateur de données diag
                  if revert_img = '1' then
                     for ii in 0 to C_FPA_TAP_NUMBER_M1 loop
                        data(ii) <= not diag_data(ii);                  -- dégradé vers la gauche
                     end loop;
                  else                                                              
                     for ii in 0 to C_FPA_TAP_NUMBER_M1 loop
                        data(ii) <= diag_data(ii);                      -- dégradé vers la droite 
                     end loop;
                  end if;
                  if diag_done(0) = '1' and diag_done_last = '0' then  
                     diag_fsm <=  check_end_st;
                  end if;
               
               when check_end_st =>
                  if line_cnt >= FPA_INTF_CFG.YSIZE then
                     diag_fsm <=  idle;
                  else
                     diag_fsm <=  cfg_line_gen_st; 
                  end if;
               
               when others =>
               
            end case;
            
         end if;         
      end if;
   end process;
   
   --------------------------------------------------------
   -- Genereteur d'impulsion de 2 secondes environ de periode
   -------------------------------------------------------- 
   U4: clk_divider_asyn
   Generic map(
      Factor=> 200_000_000
      -- pragma translate_off
      /10_000
      -- pragma translate_on
      )
   Port map( 
      Clock => MCLK_SOURCE, 
      Reset => sreset, 
      Clk_div => clk_div_i
      );
   
   ----------------------------------------------------------
   -- contrôle du basculement de l'image en mode dynamique
   ---------------------------------------------------------- 
   U5: process(MCLK_SOURCE)
   begin          
      if rising_edge(MCLK_SOURCE) then 
         if sreset = '1' then 
            img_change_sm <= idle;
            revert_img <= '0';
         else 
            
            clk_div_last <= clk_div_i;
            
            case img_change_sm is
               
               when idle =>
                  if FPA_INTF_CFG.COMN.FPA_DIAG_TYPE = DEFINE_TELOPS_DIAG_DEGR_DYN then --  mode degradé dynamique
                     if clk_div_last = '0' and clk_div_i = '1' then    -- il faut attendre 2 secondes avant de changer d'état
                        img_change_sm <= change_st;
                     end if;
                  else
                     revert_img <= '0';
                  end if;
               
               when change_st =>
                  if diag_frame_done = '1' then                            -- on attend la fin de l'image pour que le chagement d'état soit effectif
                     revert_img <= not revert_img;
                     img_change_sm <= idle;
                  end if;
               
               when others =>
               
            end case;        
            
         end if;
      end if;
   end process; 
   
end rtl;
