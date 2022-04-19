------------------------------------------------------------------
--!   @file : scd_proxy2_dsync
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.TEL2000.all;
use work.proxy_define.all;


entity scd_proxy2_dsync is
   
   generic (
      EOF_TO_FSYNC_DLY : integer range 1 to 200 := 16 -- delai (en coups de CH0_DCLK) entre la dernier pixel et la tomb�e de FSYNC.
      ); 
   
   port(
      
      ARESET           : in std_logic;
      
      -- ch0  
      CH0_DCLK         : in std_logic;
      CH0_DUAL_DATA    : in std_logic_vector(35 downto 0);
      CH0_DUAL_DVAL    : in std_logic;
      CH0_SUCCESS      : in std_logic;
      
      -- ch1 
      CH1_DCLK      : in std_logic;
      CH1_DUAL_DATA : in std_logic_vector(35 downto 0);
      CH1_DUAL_DVAL : in std_logic;
      CH1_SUCCESS      : in std_logic;
      
      -- out
      QUAD_DCLK        : in std_logic;     
      QUAD_DATA        : out std_logic_vector(71 downto 0);
      QUAD_DVAL        : out std_logic;
      
      
      FPA_INTF_CFG     : in fpa_intf_cfg_type;
      
      INIT_IN_PROGRESS : out std_logic;
      
      -- erreur
      ERR              : out std_logic_vector(1 downto 0)
      );
end scd_proxy2_dsync;


architecture rtl of scd_proxy2_dsync is  
   
   constant C_BITPOS : integer := log2(EOF_TO_FSYNC_DLY) + 1;
   
   
   component sync_reset
      port(
         areset : in std_logic;
         sreset : out std_logic;
         clk    : in std_logic);
   end component;
   
   component double_sync is
      generic(
         INIT_VALUE : bit := '0'
         );
      port(
         D     : in std_logic;
         Q     : out std_logic := '0';
         RESET : in std_logic;
         CLK   : in std_logic
         );
   end component;
   
   component fwft_afifo_w36_d512      
      port (
         rst         : in std_logic;
         wr_clk      : in std_logic;
         rd_clk      : in std_logic;
         din         : in std_logic_vector(35 downto 0);
         wr_en       : in std_logic;
         rd_en       : in std_logic;
         dout        : out std_logic_vector(35 downto 0);
         full        : out std_logic;
         overflow    : out std_logic;
         empty       : out std_logic;
         valid       : out std_logic;
         wr_rst_busy : out std_logic;
         rd_rst_busy : out std_logic
         );
   end component;
   
   type fifo_init_fsm_type is (init_st1, init_st2, init_st3, init_st4, init_done);
   signal fifo_init_fsm       : fifo_init_fsm_type;
   signal sreset              : std_logic;
   signal fifo_rd_en          : std_logic;
   signal fifo_areset         : std_logic;
   signal ch0_future_cbits_i  : std_logic_vector(3 downto 0);
   signal ch0_fval_i          : std_logic;
   signal ch0_lval_i          : std_logic;
   signal ch0_dval_i          : std_logic;
   signal ch0_dual_data_i     : std_logic_vector(27 downto 0);
   signal ch0_future_cbits_o  : std_logic_vector(3 downto 0);
   signal ch0_fval_o          : std_logic;
   signal ch0_lval_o          : std_logic;
   signal ch0_dval_o          : std_logic;
   signal ch0_dual_data_o     : std_logic_vector(27 downto 0);
   signal ch0_fifo_dout       : std_logic_vector(35 downto 0);
   signal ch0_fifo_ovfl       : std_logic;
   signal ch0_fifo_dval       : std_logic;
   signal ch1_fval_i          : std_logic;
   signal ch1_fifo_dout       : std_logic_vector(35 downto 0);
   signal ch1_fifo_ovfl       : std_logic;
   signal ch1_fifo_dval       : std_logic;
   signal quad_dout_o         : std_logic_vector(71 downto 0) := (others => '0');
   signal quad_dval_o         : std_logic;       
   signal rst_cnt             : unsigned(5 downto 0); 
   signal err_i               : std_logic_vector(ERR'length-1 downto 0);
   signal init_done_i         : std_logic;
   signal init_done_sync      : std_logic := '0';
   signal frame_init_tag      : std_logic_vector(3 downto 0) := CBITS_FRM_IDLE_ID;
   signal vid_if_bit_en_i     : std_logic := '1';
    
begin
   
   QUAD_DATA <= quad_dout_o;
   QUAD_DVAL <= quad_dval_o;
   
   ERR <= err_i;
   
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0A: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => QUAD_DCLK,
      SRESET => sreset
      );
   
   U0B: double_sync
   generic map (INIT_VALUE => '0')
   port map(D => init_done_i, Q => init_done_sync, RESET => sreset, CLK => QUAD_DCLK ); 
   
   U0C: double_sync
   generic map (INIT_VALUE => '1')
   port map(D => FPA_INTF_CFG.vid_if_bit_en, Q => vid_if_bit_en_i, RESET => sreset, CLK => QUAD_DCLK ); 

   --------------------------------------------------
   -- Inputs mapping
   --------------------------------------------------
   ch0_future_cbits_i <= CH0_DUAL_DATA(34 downto 31); -- ctrl_bits pr�c�dant de 1 CLK ch0_dual_data_i. Ils signalent � l'avance ch0_dual_data_i
   ch0_fval_i         <= CH0_DUAL_DATA(30);  
   ch0_lval_i         <= CH0_DUAL_DATA(29);
   ch0_dval_i         <= CH0_DUAL_DATA(28);
   ch0_dual_data_i    <= CH0_DUAL_DATA(27 downto 0);
   
   ch0_future_cbits_o <= ch0_fifo_dout(34 downto 31); -- ctrl_bits pr�c�dant de 1 CLK ch0_dual_data_i. Ils signalent � l'avance ch0_dual_data_i
   ch0_fval_o         <= ch0_fifo_dout(30);  
   ch0_lval_o         <= ch0_fifo_dout(29);
   ch0_dval_o         <= ch0_fifo_dout(28);
   
   ch1_fval_i         <= CH1_DUAL_DATA(30); 
   
   fifo_rd_en         <= ch0_fifo_dval and ch1_fifo_dval and init_done_sync; -- lecture synchronisee des 2 fifos tout le temps.
   
   INIT_IN_PROGRESS   <= not init_done_sync;
   
   
   
   --------------------------------------------------
   -- ch0 fifo
   --------------------------------------------------
   U1 : fwft_afifo_w36_d512
   Port map( 
      rst         => fifo_areset,
      wr_clk      => CH0_DCLK,
      rd_clk      => QUAD_DCLK,
      din         => CH0_DUAL_DATA,
      wr_en       => CH0_DUAL_DVAL,
      rd_en       => fifo_rd_en,
      dout        => ch0_fifo_dout,
      full        => open,
      overflow    => ch0_fifo_ovfl,
      empty       => open,
      valid       => ch0_fifo_dval,
      wr_rst_busy => open,
      rd_rst_busy => open);
   
   --------------------------------------------------
   -- ch1 fifo
   --------------------------------------------------
   U2 : fwft_afifo_w36_d512
   Port map( 
      rst         => fifo_areset,
      wr_clk      => CH1_DCLK,
      rd_clk      => QUAD_DCLK,
      din         => CH1_DUAL_DATA,
      wr_en       => CH1_DUAL_DVAL,
      rd_en       => fifo_rd_en,
      dout        => ch1_fifo_dout,
      full        => open,
      overflow    => ch1_fifo_ovfl,
      empty       => open,
      valid       => ch1_fifo_dval,
      wr_rst_busy => open,
      rd_rst_busy => open); 
   
      
        
   --------------------------------------------------
   -- fsm d'init
   --------------------------------------------------
   U3: process(CH0_DCLK)
   begin
      if rising_edge(CH0_DCLK) then 
         if sreset = '1' then
            fifo_init_fsm <= init_st1;
            fifo_areset   <= '1';
            rst_cnt       <= (others => '0');
            init_done_i     <= '0';           
         else
            case fifo_init_fsm is

               when init_st1 =>
                  fifo_areset  <= '0';  
                  if CH0_SUCCESS = '1' and CH1_SUCCESS = '1' then 
                     fifo_init_fsm <= init_st2;
                  end if;
               
               when init_st2 =>
                  if ch0_fval_i = '1' and CH0_DUAL_DVAL = '1' and ch1_fval_i = '1' and CH1_DUAL_DVAL = '1' then
                     fifo_init_fsm <= init_st3;
                  end if;
               
               when init_st3 =>                  
                  if ch0_fval_i = '0' and CH0_DUAL_DVAL = '1' and ch1_fval_i = '0' and CH1_DUAL_DVAL = '1'  then                     
                     fifo_init_fsm <= init_st4;
                  end if;

               when init_st4 =>                   
                  rst_cnt <= rst_cnt + 1;
                  if rst_cnt(2) = '1' then     -- 4 coups d'horloge de delai pour donner du temps � l'ecriture de s'achever
                     fifo_areset <= '1';
                  elsif rst_cnt(5) = '1' then  -- 32 coups d'horloge
                     fifo_areset <= '0';                 
                     fifo_init_fsm <= init_done;
                  end if; 
                  
               when init_done => 
                  init_done_i <= '1';
                  fifo_init_fsm <= init_done; 
                  
               when others =>
                   fifo_init_fsm <= init_st1;
            end case;
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- outputs
   --------------------------------------------------
   U5: process(QUAD_DCLK)
   begin
      if rising_edge(QUAD_DCLK) then 
         
         err_i(err_i'length-1 downto 1) <= (others => '0');
         err_i(0) <= (ch0_fifo_ovfl or ch1_fifo_ovfl) and init_done_sync;
         
         -- non utilis�s
         quad_dout_o(71 downto 67)  <= (others => '0');
         
         quad_dout_o(66)            <= ch0_fval_o;                          
         quad_dout_o(65)            <= ch0_lval_o;                          
         quad_dout_o(64)            <= ch0_dval_o;
         
         -- pixels
         quad_dout_o(63 downto 48)  <= "00" & ch1_fifo_dout(27 downto 14);  -- pix4
         quad_dout_o(47 downto 32)  <= "00" & ch0_fifo_dout(27 downto 14);  -- pix3
         quad_dout_o(31 downto 16)  <= "00" & ch1_fifo_dout(13 downto 0);   -- pix2
         quad_dout_o(15 downto  0)  <= "00" & ch0_fifo_dout(13 downto 0);   -- pix1
         quad_dval_o                <= fifo_rd_en;         
         
      end if;
   end process;
   
   U6: process(QUAD_DCLK)
   begin
      if rising_edge(QUAD_DCLK) then         
         if sreset = '1' then             
            frame_init_tag <= CBITS_FRM_IDLE_ID;
         else		 
            if FPA_INTF_CFG.vid_if_bit_en = '1' then 
               frame_init_tag <= CBITS_FRM_IDLE_TST_PTRN_ID;
            else  
               frame_init_tag <= CBITS_FRM_IDLE_ID;
            end if;
         end if;
      end if;	
   end process;
   
   
end rtl;
