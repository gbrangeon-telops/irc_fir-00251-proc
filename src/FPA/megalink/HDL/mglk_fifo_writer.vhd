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
use work.proxy_define.all;
use work.fpa_common_pkg.all; 

entity mglk_fifo_writer is
   port (
      ARESET          : in std_logic;
      CLK             : in std_logic;
      CLK_100M        : in std_logic;
      
      FPA_INTF_CFG    : in fpa_intf_cfg_type;
      
      READOUT         : in std_logic;
      DIN             : in std_logic_vector(27 downto 0);
      
      DOUT            : out std_logic_vector(27 downto 0);
      DOUT_DVAL       : out std_logic;
      DOUT_FVAL       : out std_logic;      
      
      DIAG_FIFO_FLUSH : out std_logic;
      FPA_FIFO_FLUSH  : out std_logic      
      );  
end mglk_fifo_writer;


architecture rtl of mglk_fifo_writer is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component; 
   
   
   type writer_fsm_type is (init_st1, init_st2, idle, wr_hder_st, wait_hder_end_st, wr_img_st, wr_frm_end_id_st, wait_readout_st, flush_fifo_st);
   signal writer_fsm       : writer_fsm_type;
   signal sreset           : std_logic;
   signal dval_o           : std_logic;
   signal fval_o           : std_logic;
   signal dout_o           : std_logic_vector(DIN'range);
   signal din_p            : std_logic_vector(DIN'range);
   signal din_i            : std_logic_vector(DIN'range);
   signal fval_i           : std_logic;
   signal lval_i           : std_logic;
   signal dval_i           : std_logic;
   signal fval_p           : std_logic;
   signal lval_p           : std_logic;
   signal dval_p           : std_logic; 
   signal fval             : std_logic;
   signal lval             : std_logic;
   signal dval             : std_logic;
   signal fval_pipe0       : std_logic;
   signal lval_pipe0       : std_logic;
   signal dval_pipe0       : std_logic;
   signal din_pipe0        : std_logic_vector(DIN'range);
   signal pix_count        : unsigned(31 downto 0);
   signal flush_fifo       : std_logic;
   signal count            : unsigned(7 downto 0);
   signal readout_sync     : std_logic;
   signal lpause_cnt       : unsigned(15 downto 0);
   signal lval_timeout     : std_logic;
   signal lval_timeout_sync: std_logic;
   
   attribute dont_touch    : string;
   attribute dont_touch of lpause_cnt    : signal is "true";
   attribute dont_touch of lval_i        : signal is "true";
   attribute dont_touch of fval_i        : signal is "true"; 
   
begin
   
   --------------------------------------------------
   -- Outputs map
   -------------------------------------------------- 
   DOUT_DVAL <= dval_o;
   DOUT <= dout_o;
   DOUT_FVAL <= fval_o;
   
   --------------------------------------------------
   -- Inputs map
   -------------------------------------------------- 
   fval <= DIN(25);  -- Fval 
   lval <= DIN(24);  -- Lval 
   dval <= DIN(26);  -- Dval
   
   
   U0: process(CLK)
   begin
      if rising_edge(CLK) then
         
         --lval_timeout_sync <= lval_timeout;
         
         -- input pipe
         fval_pipe0 <= fval;  -- Fval 
         lval_pipe0 <= lval;  -- Lval 
         dval_pipe0 <= dval;  -- Dval
         din_pipe0 <= din;    -- DIN
         
         -- synchro avec fval_i
         lval_i <= lval_pipe0;  -- Lval 
         dval_i <= dval_pipe0;  -- Dval
         din_i <= din_pipe0;         
         fval_i <= not lval_timeout and fval_pipe0; 
      end if;
   end process;
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   --   U1b: sync_reset
   --   port map(
   --      ARESET => ARESET,
   --      CLK    => CLK_100M,
   --      SRESET => sreset_100M
   --      );
   
   --------------------------------------------------
   -- Fifo Writer Process
   --------------------------------------------------
   -- on ecrit dans les fifos que les données valides et une donnée invalide
   -- permettant aux modules en aval de détecter la tombée du fval.
   -- La synchro des données sur les canaux Base et medium est aussi assurée.
   U2: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then            
            dval_o <= '0';
            fval_o <= '0';
            writer_fsm <= init_st1;
            fval_p <= '0';
            lval_p <= '0';
            dval_p <= '0';
            flush_fifo <= '0';
            
         else           
            
            readout_sync <= READOUT;
            
            DIAG_FIFO_FLUSH <= flush_fifo and FPA_INTF_CFG.COMN.FPA_DIAG_MODE;
            FPA_FIFO_FLUSH <= flush_fifo and not FPA_INTF_CFG.COMN.FPA_DIAG_MODE;
            
            -- pipe de CLK pour donner du temps à la machine à états
            fval_p <= fval_i;
            lval_p <= lval_i;
            dval_p <= dval_i;
            din_p <= din_i;
            
            -- pragma translate_off
            if dout_o(25) = '1' then
               if dval_o = '1' then 
                  pix_count <= pix_count + 2;
               end if;
            else
               pix_count <= (others => '0');               
            end if;             
            -- pragma translate_on
            
            case writer_fsm is               
               
               when init_st1 => 
                  dval_o <= '0';
                  fval_o <= '0';
                  if fval_i = '1' and lval_i = '1' and dval_i = '1' then  -- je vois une image
                     writer_fsm <= init_st2;
                  end if;                  
               
               when init_st2 => 
                  dval_o <= '0';
                  fval_o <= '0';
                  if fval_i = '0' and lval_i = '0' and dval_i = '0' then  -- je ne la vois plus. 
                     writer_fsm <= idle;
                  end if;      
               
               when idle =>
                  dval_o <= '0';
                  fval_o <= '0';
                  flush_fifo <= '0';
                  count <= (others => '0');
                  if fval_i = '1' and lval_i = '1' and dval_i = '1' then  -- synchro sur le debut de l'image
                     writer_fsm <= wr_img_st;
                  end if;
               
               when wr_img_st =>
                  dval_o <= fval_p and lval_p and dval_p;
                  dout_o <= din_p;
                  fval_o <= fval_p;
                  if fval_p = '0' and lval_p = '0' and dval_p = '0' then  -- fin de l'image selon la figure 4 du document Communication protocol appendix A5 (SPEC. NO: DPS3008)
                     writer_fsm <= wr_frm_end_id_st;
                  end if;
               
               when  wr_frm_end_id_st => 
                  dout_o <= (others => '0'); -- permet de faire tomber le fval, lval et dval entre deux frames en aval 
                  dval_o <= '1';            
                  fval_o <= '0';             -- 
                  count <= count + 1;
                  if count = 3 then          -- ENO:ecrire plus que 3 pour être certain que même avec le decalage observé sur le Megalink, le readout tombera
                     writer_fsm <= wait_readout_st;
                  end if;
               
               when wait_readout_st =>
                  dval_o <= '0';
                  count <= (others => '0');
                  if readout_sync = '0' then   -- on attend la fin du readout pour reset des fifos
                     flush_fifo <= '1';
                     writer_fsm <= flush_fifo_st;
                  end if;
               
               when flush_fifo_st =>            -- le reste dure 7 coups d'horloge. Le fifo est reseté pour qu'un manque de pixel dans l'image actuelle n'affecte pas la suivante.
                  count <= count + 1;
                  if count = 7 then 
                     writer_fsm <= idle; 
                  end if;                  
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
   U3: process(CLK_100M)
   begin
      if rising_edge(CLK_100M) then 
         if sreset = '1' then
            lpause_cnt <= (others => '0');
            lval_timeout <= '1';
            lpause_cnt <=  (others => '0');
            
         else
            
            -- timeout
            if lpause_cnt = 0 then
               lval_timeout <= '1';
            end if;
            
            -- monostable redeclenchable pour verifier que les lval entrent au bon rate
            if lval = '1' then 
               lpause_cnt <= to_unsigned(PROXY_LVAL_TIMEOUT_FACTOR, lpause_cnt'length); -- 
               lval_timeout <= '0';
            elsif lpause_cnt >= 1 then
               lpause_cnt <= lpause_cnt - 1;
            end if;
            
            
            
         end if;
      end if;
   end process;
   
   
end rtl;
