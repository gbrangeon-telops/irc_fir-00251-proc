------------------------------------------------------------------
--!   @file : mglk_DOUT_DVALiter
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
use IEEE.NUMERIC_STD.all;
use work.fpa_define.all;
use work.fpa_common_pkg.all; 

entity isc0207A_dval_gen is
   port (
      ARESET          : in std_logic;
      CLK             : in std_logic;
      
      FPA_INTF_CFG    : in fpa_intf_cfg_type;
      
      READOUT         : in std_logic;
      DIN             : in std_logic_vector(56 downto 0);
      DIN_DVAL        : in std_logic;
      
      DOUT            : out std_logic_vector(61 downto 0);
      DOUT_DVAL       : out std_logic;
      DOUT_FVAL       : out std_logic;      
      
      FLUSH_FIFO      : out std_logic      
      );  
end isc0207A_dval_gen;


architecture rtl of isc0207A_dval_gen is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component; 
   
   
   type writer_fsm_type is (init_st1, init_st2, init_st3, idle, delay_st, wr_img_st, wr_frm_end_id_st, wait_readout_st, flush_fifo_st, check_flag_st, wr_fval_st);
   signal writer_fsm       : writer_fsm_type;
   signal sreset           : std_logic;
   signal dval_o           : std_logic;
   signal fval_o           : std_logic;
   signal lval_o           : std_logic;
   signal sof_o            : std_logic;
   signal eof_o            : std_logic;
   signal sol_o            : std_logic;
   signal eol_o            : std_logic;
   signal dout_o           : std_logic_vector(55 downto 0);
   
   signal lval             : std_logic;
   signal dval             : std_logic;
   signal dval_p           : std_logic;
   signal sync_flag        : std_logic;
   signal sync_flag_p      : std_logic;  
   signal data             : std_logic_vector(55 downto 0);
   signal data_p           : std_logic_vector(55 downto 0);
   signal pix_count        : unsigned(31 downto 0);
   signal flush_fifo_i       : std_logic;
   signal dly_cnt          : unsigned(7 downto 0);
   signal readout_sync     : std_logic;
   signal sample_cnt       : unsigned(23 downto 0);
   signal data_o           : std_logic_vector(55 downto 0);
   signal active_pixel_dly : unsigned(FPA_INTF_CFG.FPA_ACTIVE_PIXEL_DLY'length-1 downto 0);
   
   -- attribute dont_touch    : string;
   -- attribute dont_touch of sync_flag : signal is "true"; 
   -- attribute dont_touch of sample_cnt : signal is "true";
   -- attribute dont_touch of dval_p : signal is "true";
   -- attribute dont_touch of data_p : signal is "true";
   -- attribute dont_touch of dval   : signal is "true";
   -- attribute dont_touch of dval_o : signal is "true";
   -- attribute dont_touch of fval_o : signal is "true";
   -- attribute dont_touch of sof_o  : signal is "true";
   -- attribute dont_touch of dout_o : signal is "true";
   
begin
   
   --------------------------------------------------
   -- Outputs map
   -------------------------------------------------- 
   DOUT_DVAL <= dval_o;
   DOUT_FVAL <= fval_o;
   FLUSH_FIFO <= flush_fifo_i;    
   
   DOUT(55 downto 0) <= not dout_o; -- données du 0207 et du mode diag en video inverse
   DOUT(56) <= lval_o; -- lval  
   DOUT(57) <= sol_o;  -- sol
   DOUT(58) <= eol_o;  -- eol
   DOUT(59) <= fval_o; -- fval
   DOUT(60) <= sof_o;  -- sof
   DOUT(61) <= eof_o;  -- eof
   
   --------------------------------------------------
   -- Inputs map
   -------------------------------------------------- 
   sync_flag <= DIN(56);           -- sync_flag 
   data <= DIN(55 downto 0);
   dval <= DIN_DVAL;
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   --------------------------------------------------
   -- Fifo Writer Process
   --------------------------------------------------
   -- on ecrit dans les fifos que les données valides et une donnée invalide
   -- permettant aux modules en aval de détecter la tombée du fval.
   U2: process(CLK)
      variable incr :std_logic_vector(1 downto 0);
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then            
            writer_fsm <= init_st1;
            dval_o <= '0';
            lval_o <= '0';
            fval_o <= '0';
            flush_fifo_i <= '1';
            pix_count <= (others => '0');  
            
         else           
            
            readout_sync <= READOUT;
            
            -- pipe de CLK pour donner du temps à la machine à états
            sync_flag_p <= sync_flag;
            data_p <= data;
            dval_p <= dval;
            
            -- definition de active_pixel_dly
            if  FPA_INTF_CFG.COMN.FPA_DIAG_MODE = '0' then
               active_pixel_dly <= FPA_INTF_CFG.FPA_ACTIVE_PIXEL_DLY;
            else
               active_pixel_dly <= FPA_INTF_CFG.DIAG_ACTIVE_PIXEL_DLY;
            end if;
            
            
            case writer_fsm is         -- ENO: 23 juillet 2014. les etats init_st sont requis pour éviter des problèmes de synchro          
               
               when init_st1 =>      
                  flush_fifo_i <= '0';
                  if sync_flag_p = '1' then  -- je vois un signal de synchro
                     writer_fsm <= init_st2;
                  end if;                                                                       
               
               when init_st2 =>     
                  if sync_flag_p = '0' then  -- je ne vois plus le signal de synchro
                     writer_fsm <= init_st3;
                  end if;  
               
               when init_st3 =>
                  if dval_p = '1' then      
                     pix_count <= pix_count + DEFINE_FPA_TAP_NUMBER;
                  end if;                                           
                  if pix_count >= 64 then    -- je vois au moins un nombre de pixels équivalent à la plus petite ligne du 0207. cela implique que le système en amont est actif. je m'en vais en idle et attend la prochaine synchro 
                     writer_fsm <= idle;    -- sinon, si ces pixels ne venaient jamais,
                  end if;
               
               when idle =>
                  dval_o <= '0';
                  lval_o <= '0';   -- n'est pas utilisé pour le 0207       
                  fval_o <= '0';
                  flush_fifo_i <= '0';
                  dly_cnt <= (others => '0');
                  sample_cnt <= to_unsigned(1, sample_cnt'length);  
                  if sync_flag_p = '1' and sync_flag = '0' then      -- Pour le 0207, le signal de synchro est la fin de l'integration.
                     writer_fsm <= delay_st;
                  end if;
               
               when delay_st =>               -- delai en nombre de samples avant d'aller chercher les pixels de l'image 
                  incr := '0'&dval_p;
                  dly_cnt <= dly_cnt + to_integer(unsigned(incr));                 
                  if dly_cnt = active_pixel_dly then -- ACTIVE_PIXEL_DLY est configurable via microblaze
                     writer_fsm <= wr_img_st;  
                     fval_o <= '1';
                  end if;                    
               
               when wr_img_st =>
                  dly_cnt <= (others => '0'); 
                  dval_o <= dval_p;
                  dout_o <= data_p;
                  incr := '0'&dval_p;
                  sample_cnt <= sample_cnt + to_integer(unsigned(incr));  -- 
                  if dval_p = '1' and sample_cnt >= to_integer(FPA_INTF_CFG.IMG_SAMP_NUM_PER_CH) then -- nombre total d'echantillons de l'image = Xsize*Ysize*Nsample_per_pix. 
                     writer_fsm <= wr_fval_st; 
                  end if;
               
               when  wr_fval_st =>   -- permet de tirer un peu plus fval pour le module en aval 
                  dval_o <= '0';            
                  fval_o <= '1'; 
                  writer_fsm <= wr_frm_end_id_st;
               
               when  wr_frm_end_id_st => 
                  dval_o <= '1';            
                  fval_o <= '0';                -- permet de faire tomber le fval, lval et dval entre deux frames en aval 
                  dly_cnt <= dly_cnt + 1;
                  if dly_cnt = 3 then           -- ENO : ecrire plus que 3 pour être certainn que le readout tombera
                     writer_fsm <= wait_readout_st;
                  end if;
               
               when wait_readout_st =>
                  dval_o <= '0';
                  dly_cnt <= (others => '0');
                  if readout_sync = '0' then   -- on attend la fin du readout pour reset des fifos
                     writer_fsm <= flush_fifo_st;
                  end if;
               
               when flush_fifo_st =>            -- le reset dure 7 coups d'horloge. Le fifo est reseté pour qu'un manque de pixel dans l'image actuelle n'affecte pas la suivante.
                  flush_fifo_i <= '1';
                  dly_cnt <= dly_cnt + 1;
                  if dly_cnt = 7 then 
                     writer_fsm <= idle; 
                  end if;                       
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   
   --------------------------------------------------
   --  generation des identificateurs de trames 
   --------------------------------------------------
   U3: process(CLK)
   begin
      if rising_edge(CLK) then
         
         sol_o <= '0';  -- non necessaire pour le 0207
         eol_o <= '0';  -- non necessaire pour le 0207
         
         if  sample_cnt <= FPA_INTF_CFG.SOF_SAMP_POS_END_PER_CH then
            sof_o <= '1';
         else
            sof_o <= '0';
         end if;
         
         if   sample_cnt > FPA_INTF_CFG.EOF_SAMP_POS_START_PER_CH then
            eof_o <= '1';
         else
            eof_o <= '0';
         end if;   
         
      end if;
   end process;
   
end rtl;
