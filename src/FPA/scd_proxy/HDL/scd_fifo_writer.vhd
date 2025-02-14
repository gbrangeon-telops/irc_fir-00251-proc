------------------------------------------------------------------
--!   @file : scd_DOUT_DVALiter
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
use work.Proxy_define.all;


entity scd_fifo_writer is
   port (
      ARESET           : in std_logic;
      CLK              : in std_logic;
      
      FPA_INTF_CFG     : in fpa_intf_cfg_type;
      
      DIN              : in std_logic_vector(27 downto 0);
      
      DOUT             : out std_logic_vector(27 downto 0);
      DOUT_DVAL        : out std_logic;
      
      READOUT          : in std_logic;
      
      DIAG_FIFO_FLUSH  : out std_logic;
      FPA_FIFO_FLUSH   : out std_logic
      
      );  
end scd_fifo_writer;


architecture rtl of scd_fifo_writer is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component; 
   
   
   type writer_fsm_type is (init_st1, init_st2, idle, wr_img_st, wr_frm_end_id_st, wait_readout_st, flush_fifo_st);
   signal writer_fsm       : writer_fsm_type;
   signal sreset           : std_logic;
   signal dval_o           : std_logic;
   signal dout_o           : std_logic_vector(DIN'range);
   signal din_p            : std_logic_vector(DIN'range);
   signal fval             : std_logic;
   signal lval             : std_logic;
   signal dval             : std_logic;
   signal fval_p           : std_logic;
   signal lval_p           : std_logic;
   signal dval_p           : std_logic;
   signal flush_fifo       : std_logic;
   signal count            : unsigned(7 downto 0);
   signal readout_sync     : std_logic;
   
begin
   
   --------------------------------------------------
   -- Outputs map
   -------------------------------------------------- 
   DOUT_DVAL <= dval_o;
   DOUT <= dout_o;
   
   --------------------------------------------------
   -- Inputs map
   -------------------------------------------------- 
   lval <= DIN(24);  -- Lval 
   fval <= DIN(25);  -- Fval 
   dval <= DIN(26);  -- Dval 
   
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
   -- on ecrit dans les fifos que les donn�es valides et une donn�e invalide
   -- permettant aux modules en aval de d�tecter la tomb�e du fval.
   -- La synchro des donn�es sur les canaux Base et medium est aussi assur�e.
   U2: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then            
            dval_o <= '0';
            writer_fsm <= init_st1;
            -- pragma translate_off
            writer_fsm <= init_st2;
            -- pragma translate_on
            fval_p <= '0';
            lval_p <= '0';
            dval_p <= '0';
            flush_fifo <= '0';
            
            
         else           
            
            readout_sync <= READOUT;
            
            DIAG_FIFO_FLUSH <= flush_fifo and FPA_INTF_CFG.COMN.FPA_DIAG_MODE;
            FPA_FIFO_FLUSH <= flush_fifo and not FPA_INTF_CFG.COMN.FPA_DIAG_MODE;
            
            
            -- pipe de CLK pour donner du temps � la machine � �tats
            fval_p <= fval;
            lval_p <= lval;
            dval_p <= dval;
            din_p  <= DIN;
            
            case writer_fsm is               
               
               
               when init_st1 => 
                  dval_o <= '0';
                  if fval = '1' and lval = '1' and dval = '1' then  -- je vois une image
                     writer_fsm <= init_st2;
                  end if; 
               
               when init_st2 => 
                  dval_o <= '0';
                  if fval = '0' and lval = '0' and dval = '0' then  -- permet une synchronisation sur le d�but de l'image
                     writer_fsm <= idle;
                  end if;                  
               
               when idle =>
                  dval_o <= '0';
                  flush_fifo <= '0';
                  count <= (others => '0');
                  if fval = '1' and lval = '1' and dval = '1' then
                     writer_fsm <= wr_img_st;
                  end if;
               
               when wr_img_st =>
                  dval_o <= fval_p and lval_p and dval_p;
                  dout_o <= din_p;
                  if fval_p = '0' and lval_p = '0' and dval_p = '0' then  -- fin de l'image selon la figure 4 du document Communication protocol appendix A5 (SPEC. NO: DPS3008)
                     writer_fsm <= wr_frm_end_id_st;
                  end if;
               
               when  wr_frm_end_id_st => 
                  dout_o <= (others => '0'); -- permet de faire tomber le fval entre deux frames en aval 
                  dval_o <= '1';             -- sera remis automatiquement � '0' au dans le prochain etat
                  count <= count + 1;
                  if count = 3 then          -- ENO:ecrire plus que 3 pour �tre certain le readout tombera � coup s�r
                     writer_fsm <= wait_readout_st;
                  end if;
               
               when wait_readout_st =>
                  dval_o <= '0';
                  count <= (others => '0');
                  if readout_sync = '0' then   -- on attend la fin du readout pour reset des fifos
                     flush_fifo <= '1';
                     writer_fsm <= flush_fifo_st;
                  end if;
               
               when flush_fifo_st =>            -- le reste dure 20 coups d'horloge. Le fifo est reset� pour qu'un manque de pixel dans l'image actuelle n'affecte pas la suivante.
                  count <= count + 1;
                  if count = 20 then 
                     writer_fsm <= idle; 
                  end if;                  
                  
               
               when others =>
               
            end case;
            
         end if;
      end if;
   end process;
   
end rtl;
