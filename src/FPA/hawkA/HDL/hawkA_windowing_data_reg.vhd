-------------------------------------------------------------------------------
--
-- Title       : hawkA_windowing_data_reg
-- Design      : hawk_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\FPA\Hawk\src\hawkA_windowing_data_reg.vhd
-- Generated   : Mon Dec 20 13:46:24 2010
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
use work.fpa_common_pkg.all;
use work.FPA_define.all;


entity hawkA_windowing_data_reg is
   port(
      ARESET        : in std_logic;
      CLK           : in std_logic;
      USER_CFG      : in fpa_intf_cfg_type;
      TX_MISO       : in t_ll_ext_miso;
      TX_MOSI       : out t_ll_ext_mosi8;
      TX_DREM       : out std_logic_vector(3 downto 0);
      FIFO_EMPTY    : out std_logic;
      WINDOW_CHANGE : out std_logic;
      ERR           : out std_logic
      );
end hawkA_windowing_data_reg;

architecture RTL of hawkA_windowing_data_reg is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;  
   
   
   component concat_1_to_8
      generic(
         INPUT_1st_BIT_IS_MSB : boolean:= true 
         );
      port (
         ARESET     : in std_logic;
         CLK        : in std_logic;
         RX_MOSI    : in t_ll_ext_mosi1; 
         RX_MISO    : out t_ll_ext_miso;
         TX_MOSI    : out t_ll_ext_mosi8;
         TX_MISO    : in t_ll_ext_miso;
         ERR        : out std_logic
         );
   end component; 
   
   
   component LL8_ext_fifo8 
      generic(
         FifoSize		   : integer := 256; 
         Latency        : integer := 32;      
         ASYNC          : boolean := true);	
      port(
         RX_LL_MOSI  : in  t_ll_ext_mosi8;
         RX_LL_MISO  : out t_ll_ext_miso;
         CLK_RX 		: in 	std_logic;
         FULL        : out std_logic;
         WR_ERR      : out std_logic;
         TX_LL_MOSI  : out t_ll_ext_mosi8;
         TX_LL_MISO  : in  t_ll_ext_miso;
         CLK_TX 		: in 	std_logic;
         EMPTY       : out std_logic;
         ARESET		: in std_logic
         );
   end component; 
   
   
   type wdr_fsm_type is (idle, rqst_and_send);
   type wdr_change_fsm_type is (idle, wdr_change_st, pause_st);
   type sub_frame_sm_type is (idle, null_st, done_st);
   
   signal wdr_change_fsm      : wdr_change_fsm_type;
   signal wdr_fsm             : wdr_fsm_type;         
   signal sub_frame_sm        : sub_frame_sm_type;
   signal wdr_tx_mosi         : t_ll_ext_mosi1;
   signal wdr_tx_miso         : t_ll_ext_miso;
   signal sreset              : std_logic;
   signal wdr_reg             : std_logic_vector(7 downto 0);
   signal wdr_reg_last        : std_logic_vector(7 downto 0);
   signal j_pos, j_pos_last   : unsigned(15 downto 0);
   signal k_pos, k_pos_last   : unsigned(15 downto 0);
   signal l_pos, l_pos_last   : unsigned(15 downto 0);
   signal m_pos, m_pos_last   : unsigned(15 downto 0);
   signal bit_cnt             : unsigned(15 downto 0);
   signal wdr_len             : unsigned(15 downto 0);
   signal fifo_tx_mosi        : t_ll_ext_mosi8;
   signal fifo_tx_miso        : t_ll_ext_miso;
   signal fifo_rx_mosi        : t_ll_ext_mosi8;
   signal fifo_rx_miso        : t_ll_ext_miso;  
   signal fifo_wr_err         : std_logic;
   signal concat_err          : std_logic;
   signal err_i               : std_logic;
   signal wdr_fsm_done        : std_logic;
   signal j_pos_change        : std_logic;
   signal k_pos_change        : std_logic;
   signal l_pos_change        : std_logic;
   signal m_pos_change        : std_logic;
   signal wdr_change          : std_logic; 
   signal tx_mosi_i           : t_ll_ext_mosi8;
   signal sub_frame_sm_busy   : std_logic;
   signal tx_drem_i           : std_logic_vector(3 downto 0);
   
begin  
   
   --------------------------------------------------
   -- Outputs map
   -------------------------------------------------- 
   TX_MOSI  <= tx_mosi_i;   
   fifo_tx_miso.busy <= TX_MISO.BUSY or sub_frame_sm_busy;
   fifo_tx_miso.afull <= TX_MISO.AFULL; 
   ERR <= err_i;
   TX_DREM <= tx_drem_i;
   
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U0 : sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset); 
   
   
   --------------------------------------------------
   -- Etape 0: determiner les positions j, k, l, m et autres
   -------------------------------------------------- 
   j_pos <= unsigned(USER_CFG.JPOS(15 downto 0));              
   k_pos <= unsigned(USER_CFG.KPOS(15 downto 0));
   l_pos <= unsigned(USER_CFG.LPOS(15 downto 0));
   m_pos <= unsigned(USER_CFG.MPOS(15 downto 0));
   wdr_len <= unsigned(USER_CFG.WDR_LEN(15 downto 0));--to_unsigned(16,wdr_len'length); --
   
   
   --------------------------------------------------
   -- Etape 1: traquer toute modification 
   --------------------------------------------------    
   U1 : process(CLK) 
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            wdr_change_fsm <=  idle;
            j_pos_last <= (others => '0');
            k_pos_last <= (others => '0');
            l_pos_last <= (others => '0');
            m_pos_last <= (others => '0'); 
            j_pos_change <= '0';
            k_pos_change <= '0';
            l_pos_change <= '0';
            m_pos_change <= '0';
            wdr_change <= '0';
            WINDOW_CHANGE <= '0';   -- requis pour demander à MCR de faire un reset de la memoire (MRS)
         else         
            
            WINDOW_CHANGE <= wdr_change;
            
            if  j_pos_last /= j_pos then 
               j_pos_change <= '1';
            else
               j_pos_change <= '0';
            end if;
            if  k_pos_last /= k_pos then 
               k_pos_change <= '1';
            else
               k_pos_change <= '0';
            end if;
            if  l_pos_last /= l_pos then 
               l_pos_change <= '1';
            else
               l_pos_change <= '0';
            end if;
            if  m_pos_last /= m_pos then 
               m_pos_change <= '1';
            else
               m_pos_change <= '0';
            end if;
            
            case wdr_change_fsm is
               
               when idle =>
                  wdr_change <= '0';            
                  if (j_pos_change or k_pos_change or l_pos_change or m_pos_change) = '1' and wdr_fsm_done = '1' then  
                     wdr_change_fsm <=  wdr_change_st;
                     j_pos_last <= j_pos;    -- fait office de lacth en même temps
                     k_pos_last <= k_pos;
                     l_pos_last <= l_pos;
                     m_pos_last <= m_pos;                    
                  end if;
               
               when wdr_change_st =>
                  wdr_change <= '1';
                  if wdr_fsm_done = '0' then
                     wdr_change <= '0'; 
                     wdr_change_fsm <=  pause_st; 
                  end if;
               
               when pause_st =>
                  if  wdr_fsm_done = '1' then
                     wdr_change_fsm <=  idle; 
                  end if;   
               
               when others =>
                  
               
            end case;          
            
         end if;
      end if;
   end process;
   
   
   --------------------------------------------------
   -- Etape 2: bâtir le long vecteur 1 bit du wdr
   --------------------------------------------------  
   U2: process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then 
            wdr_reg_last <= (others => '0');
            wdr_fsm <= idle;
            wdr_tx_mosi.dval <= '0'; 
            wdr_tx_mosi.sof <= '0';
            wdr_tx_mosi.eof <= '0'; 
            wdr_tx_mosi.support_busy <= '1';
            bit_cnt <= (others => '0');
            err_i <= '0';
            wdr_fsm_done <= '0';
         else
            
            if fifo_wr_err = '1' or concat_err = '1' then 
               --err_i <= '1';
            end if;
            
            if wdr_tx_miso.busy = '0' then     --   
               
               case wdr_fsm is 
                  
                  when idle => 
                     wdr_tx_mosi.dval <= '0';
                     wdr_fsm_done <= '1';
                     if  wdr_change = '1' then 
                        wdr_fsm <= rqst_and_send;
                        bit_cnt <= wdr_len;
                     end if;                   
                  
                  when rqst_and_send => 
                     wdr_tx_mosi.dval <= '1';          -- demande d'envoi, meme si le downstream_busy est à '1'
                     wdr_fsm_done <= '0';
                     -- sof
                     if bit_cnt = wdr_len then
                        wdr_tx_mosi.sof <= '1';
                     else
                        wdr_tx_mosi.sof <= '0';
                     end if;                 
                     
                     -- eof
                     if bit_cnt = 1 then
                        wdr_tx_mosi.eof <= '1';
                     else
                        wdr_tx_mosi.eof <= '0';
                     end if;  
                     
                     -- data  retenir que j > k > l > m et qu'ils doivent aussi sortir en file indienne dans cet ordre
                     if bit_cnt = j_pos_last then        -- j .. 
                        wdr_tx_mosi.data <=  '1'; 
                     elsif bit_cnt = k_pos_last then     -- k
                        wdr_tx_mosi.data <=  '1'; 
                     elsif bit_cnt = l_pos_last then     -- l
                        wdr_tx_mosi.data <=  '1';
                     elsif bit_cnt = m_pos_last then     -- m
                        wdr_tx_mosi.data <=  '1';
                     else
                        wdr_tx_mosi.data <=  '0';
                     end if;
                     
                     -- envoi                     
                     bit_cnt <= bit_cnt - 1;
                     if bit_cnt = 1 then 
                        wdr_fsm <= idle;                         
                     end if;                                                  
                  
                  when others =>          
                  
               end case;        
            end if;     
         end if;
      end if;      
   end process;    
   
   
   --------------------------------------------------
   -- Etape 3: envoyer le vecteur à un concatenateur
   -------------------------------------------------- 
   -- requis car le module detector_ctler sur lequel est
   -- branché le bloc impose un lien LL 8 bits
   U3 : concat_1_to_8 
   generic map(
      INPUT_1st_BIT_IS_MSB => true)   
   port map(
      ARESET   => ARESET, 
      CLK      => CLK, 
      RX_MOSI  => wdr_tx_mosi,    -- entrée du long vecteur de 1 bit dans le concatenateur
      RX_MISO  => wdr_tx_miso,
      TX_MOSI  => fifo_rx_mosi,   -- sortie de données concatenées sur 8 bits et qui s'en vont dans un fifo
      TX_MISO  => fifo_rx_miso,
      ERR      => concat_err);  
   
   
   --------------------------------------------------
   -- Etape 4: mettre à la sortie du bloc un fifo
   --------------------------------------------------   
   --  detector_ctler sur lequel est
   --  branché le bloc impose un DVAL à '1' pour signifier 
   --  une demande d'envoi, meme si busy est à '1' 
   U4: LL8_ext_fifo8 
   generic map(
      FifoSize	=> 256, 
      Latency => 3,      
      ASYNC   => false)	
   port map(
      RX_LL_MOSI => fifo_rx_mosi,
      RX_LL_MISO => fifo_rx_miso,
      CLK_RX     => CLK,
      FULL       => open,
      WR_ERR     => fifo_wr_err,
      TX_LL_MOSI => fifo_tx_mosi,
      TX_LL_MISO => fifo_tx_miso,
      CLK_TX     => CLK,
      EMPTY      => FIFO_EMPTY,
      ARESET     => ARESET ); 
   
   
   --------------------------------------------------
   -- Etape 5: passe-passe pour ajustement de DREM
   --------------------------------------------------   
   --  ENO 12 nov 2011: Suite à la nouvelle doc de Selex, en sous-fenetrage, WDR a une taille de 1344 bits + 7 bits NULL (voir page 61 du manuel)
   -- 
   U5: process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            tx_mosi_i.support_busy <= '1'; 
            tx_mosi_i.dval <= '0';
            sub_frame_sm <= idle; 
            sub_frame_sm_busy <= '1';
         else                           
            
            if  TX_MISO.BUSY = '0' then 
               
               case sub_frame_sm is
                  
                  when idle =>
                     sub_frame_sm_busy <= '0';
                     tx_drem_i <= "1000"; -- la taille de WDR en mode full vaut 1344 et c'est un multiple de 8                
                     --if USER_CFG.FPA_FULL_WINDOW = '1' or USER_CFG.FPA_WDR_IGNORE_NULL = '1' then 
                     tx_mosi_i <= fifo_tx_mosi;                        
                     --else
                     --   tx_mosi_i <= fifo_tx_mosi;
                     --   tx_mosi_i.eof <= '0';   -- eof est ainsi elimniné  
                     --   if fifo_tx_mosi.eof = '1' and fifo_tx_mosi.dval = '1' then
                     --      sub_frame_sm <= null_st; 
                     --      sub_frame_sm_busy <= '1';
                     --   end if;
                     --end if;     
                  
                  when null_st =>
                     tx_mosi_i.eof <= '1'; 
                     tx_mosi_i.dval <= '1'; 
                     tx_mosi_i.data <= (others => '0');
                     sub_frame_sm <= done_st;
                     tx_drem_i <= "0111"; -- envoi des 7 NULL selon le manuel 
                  
                  when done_st =>
                     tx_mosi_i.eof <= '0'; 
                     tx_mosi_i.dval <= '0'; 
                     sub_frame_sm <= idle;                      
                  
                  when others =>
                  
               end case;
               
            end if;              
         end if;                        
      end if;
      
   end process;
   
   
   
end RTL;
