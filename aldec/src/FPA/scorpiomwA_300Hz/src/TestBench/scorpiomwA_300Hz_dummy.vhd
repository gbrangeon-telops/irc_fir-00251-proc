-------------------------------------------------------------------------------
--
-- Title       : scorpiomwA_300Hz_dummy
-- Design      : 
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\PROXY_Hercules\src\scorpiomwA_300Hz_dummy.vhd
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


entity scorpiomwA_300Hz_dummy is
   
   port(      
      ARESET            : in std_logic;
      MCLK_SOURCE       : in std_logic;
      
      FPA_INTF_CFG      : fpa_intf_cfg_type;
      --DIAG_MODE_EN      : in std_logic;
      
      FPA_INT           : in std_logic;
      --FPA_FDEM          : in std_logic;
      
      DIAG_DATA         : out std_logic_vector(61 downto 0); --! sortie des donn�es 
      DIAG_DVAL         : out std_logic
      );
end scorpiomwA_300Hz_dummy;


architecture rtl of scorpiomwA_300Hz_dummy is
   
   constant spare : std_logic := '0';
   
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
   
   constant  C_FPA_TAP_NUMBER_M1 : integer := DEFINE_FPA_TAP_NUMBER - 1; 
   
   type diag_fsm_type is (idle, interline_st, int_st, junk_data_st, tir_dly_st, get_line_data_st, cfg_line_gen_st, check_end_st, write_end_id_st);
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
   
   signal diag_data_i       : data_type;
   signal diag_dval_i       : std_logic_vector(C_FPA_TAP_NUMBER_M1 downto 0);
   signal diag_done         : std_logic_vector(C_FPA_TAP_NUMBER_M1 downto 0);
   signal dly_cnt           : unsigned(15 downto 0);
   signal data_cnt          : unsigned(15 downto 0);
   signal line_cnt          : unsigned(FPA_INTF_CFG.YSIZE'length-1 downto 0);
   signal fpa_int_last      : std_logic;
   signal revert_img        : std_logic;
   signal clk_div_i         : std_logic;
   signal clk_div_last      : std_logic;
   signal pix_count         : unsigned(31 downto 0);
   signal fpa_int_i         : std_logic;
   signal pixel_samp_trig   : std_logic;
   signal diag_quad_clk_i   : std_logic;
   signal diag_quad_clk_last: std_logic;
   signal diag_done_last    : std_logic;
   signal diag_sol          : std_logic;
   signal diag_eol          : std_logic;
   signal sof_i             : std_logic;
   signal eof_i             : std_logic;
   signal sol_i             : std_logic;
   signal eol_i             : std_logic;
   signal fval_i            : std_logic;
   signal diag_eol_last     : std_logic;
   signal fpa_fdem_last     : std_logic;
   
   attribute dont_touch     : string;
   attribute dont_touch of diag_fsm : signal is "true";
   
begin
   
   ----------------------------------------------
   -- OUTPUTS                                    
   ----------------------------------------------
   DIAG_DATA(61)          <= eof_i;  -- eof
   DIAG_DATA(60)          <= sof_i;  -- sof
   DIAG_DATA(59)          <= fval_i; -- fval
   DIAG_DATA(58)          <= eol_i;  -- eol
   DIAG_DATA(57)          <= sol_i;  -- sol
   DIAG_DATA(56)          <= FPA_INT;
   DIAG_DATA(55 downto 0) <= not (data(3)(13 downto 0)  & data(2)(13 downto 0)  & data(1)(13 downto 0)  & data(0)(13 downto 0));
   DIAG_DVAL              <= dval_i;
   
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
   UCa: Clk_Divider
   Generic map(
      Factor => DEFINE_ADC_QUAD_CLK_FACTOR
      )
   Port map( 
      Clock   => MCLK_SOURCE, 
      Reset   => sreset, 
      Clk_div => diag_quad_clk_i   -- attention, c'est en realit� un clock enable.
      );  
   
   -- sampling trig en mode diag
   UCb : process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         diag_quad_clk_last <= diag_quad_clk_i;
         pixel_samp_trig <= not diag_quad_clk_last and diag_quad_clk_i;
      end if;
   end process;
   
   -- smapping avec generateur de donn�es
   U1 : for ii in 0 to C_FPA_TAP_NUMBER_M1 generate 
      diag_line_ii : fpa_diag_line_gen 
      generic map(
         ANALOG_IDDCA => true,      
         SAMP_NUM_PER_PIX => DEFINE_FPA_PIX_SAMPLE_NUM_PER_CH
         )
      port map(
         CLK           => MCLK_SOURCE,
         ARESET        => ARESET,
         LINE_SIZE     => line_size,
         START_PULSE   => diag_line_gen_en,
         FIRST_VALUE   => first_value(ii),
         INCR_VALUE    => incr_value,
         PIX_SAMP_TRIG => pixel_samp_trig,
         DIAG_DATA     => diag_data_i(ii),
         DIAG_DVAL     => diag_dval_i(ii),
         DIAG_SOL      => diag_sol,
         DIAG_EOL      => diag_eol,   
         DIAG_DONE     => diag_done(ii)
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
   -- generation des donn�es du mode diag   
   -------------------------------------------------------------------   
   U3: process(MCLK_SOURCE)
   begin          
      if rising_edge(MCLK_SOURCE) then 
         if sreset = '1' then 
            diag_fsm <=  idle;
            dval_i <= '0';
            fval_i <= '0';
            diag_frame_done <= '0';
            fpa_int_last <= '0';
            diag_line_gen_en <= '0';
            diag_eol_last <= '0';
            fpa_fdem_last <= '0';
            
         else   
            
            diag_done_last <= diag_done(0);            
            fpa_int_i <= FPA_INT;
            fpa_int_last <= fpa_int_i; 
            diag_eol_last <= diag_eol;
            --fpa_fdem_last <= FPA_FDEM;
            
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
               for ii in 0 to C_FPA_TAP_NUMBER_M1 loop                  -- degrad� lineaire constant et d�grad� lin�aire dynamique
                  first_value(ii) <= std_logic_vector(to_unsigned(ii*DEFINE_DIAG_DATA_INC, first_value(0)'length));
                  incr_value <= std_logic_vector(to_unsigned(DEFINE_FPA_TAP_NUMBER*DEFINE_DIAG_DATA_INC, first_value(0)'length));
               end loop;                        
            end if;
            
            -- machine � �tats
            case diag_fsm is 
               
               when idle =>
                  dly_cnt <= (others => '0');
                  data_cnt <= to_unsigned(1, data_cnt'length);
                  line_cnt <= to_unsigned(1, line_cnt'length);
                  dval_i <= '0';
                  fval_i <= '0';
                  diag_frame_done <= '1';
                  diag_line_gen_en <= '0';
                  sof_i <= '0';
                  eof_i <= '0';
                  if fpa_int_last = '1' and fpa_int_i = '0' then                   
                     diag_fsm <=  tir_dly_st;
                  end if;
               
               when tir_dly_st =>
                  fval_i <= '1';
                  diag_frame_done <= '0';   
                  if pixel_samp_trig = '1' then
                     dly_cnt <= dly_cnt + 1;
                     dval_i <= '1';
                  else
                     dval_i <= '0';
                  end if;
                  for ii in 0 to C_FPA_TAP_NUMBER_M1 loop
                     data(ii) <= (others => '0');                  -- d�grad� vers la gauche
                  end loop;
                  if dly_cnt < 0 then 
                     diag_fsm <=  cfg_line_gen_st;                   
                  end if;                         
               
               when cfg_line_gen_st =>
                  dval_i <= '0';
                  diag_line_gen_en <= '1';                              -- on active le module g�n�ateur des donn�es diag                 
                  line_size <= std_logic_vector(resize(FPA_INTF_CFG.XSIZE_DIV_TAPNUM, line_size'length)); 
                  dly_cnt <= (others => '0');                  
                  diag_fsm <=  get_line_data_st;
               
               when get_line_data_st => 
                  dval_i <= diag_dval_i(0);         
                  if diag_done(0) = '0' then
                     diag_line_gen_en <= '0';              
                  end if;
                  -- on se branche sur le module generateur de donn�es diag
                  if revert_img = '1' then
                     for ii in 0 to C_FPA_TAP_NUMBER_M1 loop
                        data(ii) <= not diag_data_i(ii);                  -- d�grad� vers la gauche
                     end loop;
                  else                                                              
                     for ii in 0 to C_FPA_TAP_NUMBER_M1 loop
                        data(ii) <= diag_data_i(ii);                      -- d�grad� vers la droite 
                     end loop;
                  end if;                  
                  --if diag_done(0) = '1' and diag_done_last = '0' then  
                  --diag_fsm <=  check_end_st;
                  --end if;
                  
                  -- compteur de lignes
                  if diag_eol = '0' and diag_eol_last = '1' then  
                     diag_fsm <=  interline_st;                     
                  end if;
                  
                  -- identificateurs de trames
                  if line_cnt = 1 then 
                     sof_i <= diag_sol;
                  else
                     sof_i <= '0';
                  end if;
                  if line_cnt = FPA_INTF_CFG.YSIZE then 
                     eof_i <= diag_eol;
                  else
                     eof_i <= '0';
                  end if;
                  sol_i <= diag_sol;
                  eol_i <= diag_eol;
               
               when check_end_st =>
                  if line_cnt >= FPA_INTF_CFG.YSIZE + 1 then
                     diag_fsm <=  write_end_id_st;
                  else
                     diag_fsm <=  cfg_line_gen_st; 
                     line_cnt <= line_cnt + 1; 
                  end if;
               
               when interline_st => 
                  if pixel_samp_trig = '1' then
                     dly_cnt <= dly_cnt + 1;
                     dval_i <= '1';
                  else
                     dval_i <= '0';
                  end if;
                  for ii in 0 to C_FPA_TAP_NUMBER_M1 loop
                     data(ii) <= (others => 'Z');                  -- d�grad� vers la gauche
                  end loop;
                  if dly_cnt >= 32 then
                     dval_i <= '0';
                     diag_fsm <=  check_end_st;                   
                  end if;         
               
               when write_end_id_st =>
                  eof_i <= '0';
                  dval_i <= '1';
                  fval_i <= '0'; -- pour faire tomber fval en aval
                  diag_fsm <=  idle;
               
               when others =>
               
            end case;
            
         end if;         
      end if;
   end process;
   
   --------------------------------------------------------
   -- Genereteur d'impulsion de 2 secondes environ de periode
   -------------------------------------------------------- 
   U4: Clk_Divider
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
   -- contr�le du basculement de l'image en mode dynamique
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
                  if FPA_INTF_CFG.COMN.FPA_DIAG_TYPE = DEFINE_TELOPS_DIAG_DEGR_DYN then --  mode degrad� dynamique
                     if clk_div_last = '0' and clk_div_i = '1' then    -- il faut attendre 2 secondes avant de changer d'�tat
                        img_change_sm <= change_st;
                     end if;
                  else
                     revert_img <= '0';
                  end if;
               
               when change_st =>
                  if diag_frame_done = '1' then                            -- on attend la fin de l'image pour que le chagement d'�tat soit effectif
                     revert_img <= not revert_img;
                     img_change_sm <= idle;
                  end if;
               
               when others =>
               
            end case;        
            
         end if;
      end if;
   end process; 
   
end rtl;
