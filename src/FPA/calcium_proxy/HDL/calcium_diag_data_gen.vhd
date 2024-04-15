------------------------------------------------------------------
--!   @file : calcium_diag_data_gen
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
use IEEE.math_real.all;
use work.FPA_define.all;
use work.Proxy_define.all;


entity calcium_diag_data_gen is
   
   generic(
      
      DETECTOR_WIDTH  : positive := 640;
      DETECTOR_HEIGHT : positive := 512;
      OCTO_DATA_ENA   : boolean  := FALSE
      
      );
   
   port(
      
      ARESET       : in std_logic;
      CLK          : in std_logic;
      
      FPA_INTF_CFG : in fpa_intf_cfg_type;
      
      FPA_INT      : in std_logic;
      
      QUAD_DATA    : out calcium_quad_data_type; --! sortie des données deserialisés
	  OCTO_DATA    : out calcium_octo_data_type
      
      );
end calcium_diag_data_gen;


architecture rtl of calcium_diag_data_gen is
   
   component sync_reset	is
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component Clk_Divider is
      Generic(	
         Factor : integer := 2);		
      Port( 
         Clock     : in std_logic;
         Reset     : in std_logic;		
         Clk_div   : out std_logic);
   end component;
   
   component fpa_diag_line_gen is
      generic(
         SAMP_NUM_PER_PIX   : natural range 0 to 15 := 5 
         );
      port(
         CLK                : in std_logic;
         ARESET             : in std_logic;
         LINE_SIZE          : in std_logic_vector(15 downto 0);
         START_PULSE        : in std_logic;
         FIRST_VALUE        : in std_logic_vector(23 downto 0); 
         INCR_VALUE         : in std_logic_vector(23 downto 0);
         PIX_SAMP_TRIG      : in std_logic;
         DIAG_DATA          : out std_logic_vector(23 downto 0);
         DIAG_DVAL          : out std_logic; 
         DIAG_SOL           : out std_logic;
         DIAG_EOL           : out std_logic;
         DIAG_LVAL          : out std_logic;
         DIAG_DONE          : out std_logic
         );
   end component;
   
   type calcium_data_type is
   record
      pix_data       : pix_data_array_type(1 to 4 * (1 + boolean'POS(OCTO_DATA_ENA)));
      fval           : std_logic;
      lval           : std_logic;
      dval           : std_logic;
      aoi_dval       : std_logic;
      aoi_last       : std_logic;
   end record;
   
   type diag_fsm_type is (idle, x_to_readout_start_dly_st, fval_on_st, fval_re_to_dval_re_dly_st, start_line_gen_st,
   wait_line_gen_end_st, line_pause_st, rst_cnt_st, x_to_next_fsync_re_dly_st);
   type img_change_sm_type is (idle, change_st);
   
   signal diag_fsm          : diag_fsm_type;
   signal img_change_sm     : img_change_sm_type;
   signal pix_data_i        : calcium_data_type;
   alias  fval_i           is pix_data_i.fval;  
   signal fval_last         : std_logic;
   alias  lval_i           is pix_data_i.lval;
   alias  dval_i           is pix_data_i.dval;    
   alias  aoi_dval_i       is pix_data_i.aoi_dval;    
   alias  aoi_last_i       is pix_data_i.aoi_last;    
   signal sreset            : std_logic;
   signal line_size_i       : std_logic_vector(15 downto 0);
   signal diag_line_gen_en  : std_logic;
   signal pix_first_value   : std_logic_vector(23 downto 0);
   signal pix_coarse_value  : unsigned(pix_coarse_range_type);
   signal pix_offset_value  : pix_data_array_type(pix_data_i.pix_data'RANGE);
   signal incr_value        : std_logic_vector(23 downto 0);
   signal pix_diag_data     : std_logic_vector(23 downto 0);
   signal pix_diag_lval     : std_logic;
   signal pix_diag_dval     : std_logic;
   signal pix_diag_last     : std_logic;
   signal diag_done_i       : std_logic;
   signal dly_cnt           : unsigned(15 downto 0);
   signal line_cnt          : unsigned(15 downto 0);
   signal fpa_int_i         : std_logic;
   signal fpa_int_last      : std_logic;
   signal revert_img        : std_logic;
   signal clk_div_i         : std_logic;
   signal clk_div_last      : std_logic;
   signal diag_clk_i        : std_logic;
   signal diag_clk_last     : std_logic;
   signal pix_samp_trig_i   : std_logic := '1';
   
   constant COARSE_SHIFT_N  : integer := integer(ceil(log2(real(DETECTOR_HEIGHT)))) - pix_coarse_value'LENGTH;
   constant RESIDUE_MAX_VAL : integer := (DETECTOR_WIDTH-1)*DIAG_DATA_INC;
   constant RESIDUE_BIT_CNT : integer := integer(ceil(log2(real(RESIDUE_MAX_VAL+1))));
   constant RESIDUE_BIT_MSK : integer := 2**RESIDUE_BIT_CNT-1;
   constant RESIDUE_INI_VAL : integer := RESIDUE_BIT_MSK-RESIDUE_MAX_VAL;
  
begin
   
   G0 : if OCTO_DATA_ENA = FALSE generate
      QUAD_DATA.pix_data <= pix_data_i.pix_data;
      QUAD_DATA.fval     <= pix_data_i.fval;
      QUAD_DATA.lval     <= pix_data_i.lval;
      QUAD_DATA.dval     <= pix_data_i.dval;
      QUAD_DATA.aoi_dval <= pix_data_i.aoi_dval;
      QUAD_DATA.aoi_last <= pix_data_i.aoi_last;
   end generate;
   G1 : if OCTO_DATA_ENA = TRUE generate
      OCTO_DATA.pix_data <= pix_data_i.pix_data;
      OCTO_DATA.fval     <= pix_data_i.fval;
      OCTO_DATA.lval     <= pix_data_i.lval;
      OCTO_DATA.dval     <= pix_data_i.dval;
      OCTO_DATA.aoi_dval <= pix_data_i.aoi_dval;
      OCTO_DATA.aoi_last <= pix_data_i.aoi_last;
   end generate;
   
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
   -- sampling clk enable
   -------------------------------------------------- 
   genA: if DEFINE_DIAG_DATA_CLK_FACTOR > 1 generate     
      U1: Clk_Divider
      Generic map(
         Factor => DEFINE_DIAG_DATA_CLK_FACTOR
         )
      Port map( 
         Clock   => CLK, 
         Reset   => sreset, 
         Clk_div => diag_clk_i -- attention, c'est en realité un clock enable.
         );  
      
      -- sampling trig en mode diag
      process(CLK)
      begin
         if rising_edge(CLK) then
            diag_clk_last   <= diag_clk_i;
            pix_samp_trig_i <= not diag_clk_last and diag_clk_i;
         end if;
      end process;
   end generate;
   
   --------------------------------------------------
   -- Pixel data gen 
   --------------------------------------------------   
   U2: fpa_diag_line_gen
   generic map(    
      SAMP_NUM_PER_PIX => 1 -- toujours à 1 pour les iddcas numériques
      )
   port map(
      CLK           => CLK,
      ARESET        => ARESET,
      LINE_SIZE     => line_size_i,
      START_PULSE   => diag_line_gen_en,
      FIRST_VALUE   => pix_first_value,
      INCR_VALUE    => incr_value,
      PIX_SAMP_TRIG => pix_samp_trig_i,
      DIAG_DATA     => pix_diag_data,
      DIAG_DVAL     => pix_diag_dval,
      DIAG_SOL      => open,
      DIAG_EOL      => pix_diag_last,    
      DIAG_LVAL     => pix_diag_lval,
      DIAG_DONE     => diag_done_i
      );
   
   -------------------------------------------------------------------
   -- generation des données du mode diag   
   -------------------------------------------------------------------   
   process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            diag_fsm     <= idle;
            fval_last    <= '0';
            pix_data_i   <= ((others => (others => '0')), others => '0');
			incr_value   <= (others => '0');
			dly_cnt      <= (others => '0');           
            fpa_int_last <= fpa_int_i;  
         else   
            fpa_int_i    <= FPA_INT;
            fpa_int_last <= fpa_int_i;
            fval_last    <= fval_i;  
            
            -- configuration du generateur de lignes
            if FPA_INTF_CFG.COMN.FPA_DIAG_TYPE = TELOPS_DIAG_CNST then -- constant               
               pix_first_value <= std_logic_vector(to_unsigned(4096, pix_first_value'length));
               incr_value      <= (others => '0');
            else                                                       -- dégradé linéaire constant et dégradé linéaire dynamique
			   if revert_img = '0' then
                  pix_first_value <= (others => '0');
			   else               
                  pix_first_value <= std_logic_vector(to_unsigned(RESIDUE_INI_VAL, pix_first_value'length));
			   end if;
               incr_value <= std_logic_vector(to_unsigned(pix_data_i.pix_data'length*DIAG_DATA_INC, incr_value'length));           
            end if;
           
            case diag_fsm is 
               
               when idle =>
                  dly_cnt    <= (others => '0');
                  line_cnt   <= (others => '0');
                  pix_data_i <= ((others => (others => '0')), others => '0');
                  
                  diag_line_gen_en <= '0';
                  if fpa_int_last = '1' and fpa_int_i = '0' then
                     diag_fsm <= x_to_readout_start_dly_st;              
                  end if;
               
               when x_to_readout_start_dly_st =>    
                  if dly_cnt >= FPA_INTF_CFG.diag.x_to_readout_start_dly then 
                     diag_fsm <= fval_on_st;                   
                  else
                     dly_cnt <= dly_cnt + 1; 
                  end if;

               when fval_on_st => 
                  fval_i   <= '1';
                  diag_fsm <= fval_re_to_dval_re_dly_st; 
                  dly_cnt  <= (others => '0');
               
               when fval_re_to_dval_re_dly_st =>   
                  if dly_cnt = FPA_INTF_CFG.diag.fval_re_to_dval_re_dly then 
                     diag_fsm <= start_line_gen_st;
                  else
                     dly_cnt <= dly_cnt + 1; 
                  end if;  

               when start_line_gen_st =>
                  diag_line_gen_en <= '1'; -- on active le module générateur de données diag
                  line_size_i      <= std_logic_vector(resize(FPA_INTF_CFG.diag.xsize_div_per_pixel_num, line_size_i'length)); 
                  dly_cnt          <= (others => '0');
                  if diag_done_i = '0' then
                     diag_line_gen_en <= '0';
                     line_cnt         <= line_cnt + 1;
					 diag_fsm         <= wait_line_gen_end_st;
					 if FPA_INTF_CFG.COMN.FPA_DIAG_TYPE = TELOPS_DIAG_CNST then -- constant
					    pix_coarse_value <= (others => '0');
						pix_offset_value <= (others => (others => '0'));
					 else
					    pix_coarse_value <= resize(line_cnt srl COARSE_SHIFT_N, pix_coarse_value'LENGTH);
						for i in 0 to pix_offset_value'length-1 loop
						   pix_offset_value(i+1) <= std_logic_vector(to_unsigned(i*DIAG_DATA_INC, pix_offset_value(i+1)'length));
						end loop;
                     end if;
                  end if;
               
               when wait_line_gen_end_st =>
                  lval_i     <= pix_diag_lval;   
                  dval_i     <= pix_diag_dval; -- on se branche sur le module générateur de données diag   
                  aoi_dval_i <= pix_diag_dval;
				  if pix_diag_last = '1' and line_cnt >= FPA_INTF_CFG.height then
				     aoi_last_i <=	'1';
				  else
				     aoi_last_i <=	'0';
                  end if;
				  
				  for i in 0 to pix_data_i.pix_data'length-1 loop
                     if revert_img = '1' then 
                        pix_data_i.pix_data(i+1)                         <= not std_logic_vector(unsigned(pix_diag_data(pix_data_range_type))+unsigned(pix_offset_value(i+1))) and std_logic_vector(to_unsigned(RESIDUE_BIT_MSK, pix_data_i.pix_data(i+1)'LENGTH)); -- dégradé gauche
                        pix_data_i.pix_data(i+1)(pix_coarse_value'RANGE) <= not std_logic_vector(pix_coarse_value); 
                     else
                        pix_data_i.pix_data(i+1)                         <=     std_logic_vector(unsigned(pix_diag_data(pix_data_range_type))+unsigned(pix_offset_value(i+1))); -- dégradé droite
                        pix_data_i.pix_data(i+1)(pix_coarse_value'RANGE) <=     std_logic_vector(pix_coarse_value); 
                     end if;
                  end loop;
				  
                  if diag_done_i = '1' then
                     diag_fsm <= line_pause_st;
                     dly_cnt  <= to_unsigned(6, dly_cnt'length); -- pour tenir compte des délais supplémentaires (vus en simulation)
                  end if;
               
               when line_pause_st =>  
                  dly_cnt <= dly_cnt + 1;
                  if dly_cnt >= FPA_INTF_CFG.diag.lval_pause_dly then
                     diag_fsm <= start_line_gen_st;
                  end if;
                  if line_cnt >= FPA_INTF_CFG.height then
                     diag_fsm <= rst_cnt_st;
                  end if;
               
               when rst_cnt_st =>
                  dly_cnt  <= (others => '0');
                  diag_fsm <= x_to_next_fsync_re_dly_st; 
               
               when x_to_next_fsync_re_dly_st =>
                  dly_cnt <= dly_cnt + 1;                                                                             
                  if dly_cnt = FPA_INTF_CFG.diag.x_to_next_fsync_re_dly then
                     diag_fsm <= idle; 
                  end if;
               
               when others =>
               
            end case;
         end if;         
      end if;
   end process;
   
   --------------------------------------------------------
   -- Générateur d'impulsion de 2 secondes
   -------------------------------------------------------- 
   U3: Clk_Divider
   Generic map(
      Factor => 200_000_000
      -- pragma translate_off
      /10_000
      -- pragma translate_on
      )
   Port map( 
      Clock   => CLK, 
      Reset   => sreset, 
      Clk_div => clk_div_i
      );
   
   ----------------------------------------------------------
   -- contrôle du basculement de l'image en mode dynamique
   ---------------------------------------------------------- 
   process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            img_change_sm <= idle;
            revert_img    <= '0';
         else 
            clk_div_last <= clk_div_i;
            
            case img_change_sm is
               when idle =>
                  if FPA_INTF_CFG.COMN.FPA_DIAG_TYPE = TELOPS_DIAG_DEGR_DYN then -- mode dégradé dynamique
                     if clk_div_last = '0' and clk_div_i = '1' then -- il faut attendre 2 secondes avant de changer d'état
                        img_change_sm <= change_st;
                     end if;
                  else
                     revert_img <= '0';
                  end if;
               
               when change_st =>
                  if fval_last = '0' and fval_i = '1' then -- on attend le début d'une nouvelle image pour que le chagement d'état soit effectif
                     revert_img    <= not revert_img;
                     img_change_sm <= idle;
                  end if;
               
               when others =>
            end case;        
         end if;
      end if;
   end process; 
end rtl;
