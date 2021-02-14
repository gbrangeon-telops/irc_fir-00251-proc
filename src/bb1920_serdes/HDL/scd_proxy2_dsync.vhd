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



entity scd_proxy2_dsync is
   
   generic (
      EOF_TO_FSYNC_DLY : integer range 1 to 200 := 16 -- delai (en coups de CH0_DCLK) entre la dernier pixel et la tombée de FSYNC.
      ); 
   
   port(
      
      ARESET        : in std_logic;
      
      -- ch0  
      CH0_DCLK      : in std_logic;
      CH0_DUAL_DATA : in std_logic_vector(35 downto 0);
      CH0_DUAL_DVAL : in std_logic;
      
      -- ch1 
      CH1_DCLK      : in std_logic;
      CH1_DUAL_DATA : in std_logic_vector(35 downto 0);
      CH1_DUAL_DVAL : in std_logic;
      
      -- out
      QUAD_DCLK     : in std_logic;     
      QUAD_DATA     : out std_logic_vector(71 downto 0);
      QUAD_DVAL     : out std_logic;
      
      -- erreur
      ERR           : out std_logic_vector(1 downto 0)
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
   
   type fsm_type is (init_st1, init_st2, idle, dly_st, first_line_st, last_line_st, read_end_st);
   
   signal fsm                 : fsm_type;
   signal sreset              : std_logic;
   signal fifo_rd_en          : std_logic;
   signal fifo_areset         : std_logic;
   signal active_write        : std_logic;
   signal active_read         : std_logic;
   signal active_sof          : std_logic;
   signal active_eof          : std_logic;
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
   signal ch1_fifo_dout       : std_logic_vector(35 downto 0);
   signal ch1_fifo_ovfl       : std_logic;
   signal ch1_fifo_dval       : std_logic;
   signal quad_dout_o         : std_logic_vector(71 downto 0);
   signal quad_dval_o         : std_logic;
   
   signal dly_cnt             : unsigned(C_BITPOS downto 0);
   signal err_i               : std_logic_vector(ERR'length-1 downto 0);
   
begin
   
   
   QUAD_DATA <= quad_dout_o;
   QUAD_DVAL <= quad_dval_o;
   
   ERR <= err_i;
   
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => QUAD_DCLK,
      SRESET => sreset
      );
   fifo_areset <= not active_write or ARESET;
   
   --------------------------------------------------
   -- Inputs mapping
   --------------------------------------------------
   ch0_future_cbits_i <= CH0_DUAL_DATA(34 downto 31); -- ctrl_bits précédant de 1 CLK ch0_dual_data_i. Ils signalent à l'avance ch0_dual_data_i
   ch0_fval_i         <= CH0_DUAL_DATA(30);  
   ch0_lval_i         <= CH0_DUAL_DATA(29);
   ch0_dval_i         <= CH0_DUAL_DATA(28);
   ch0_dual_data_i    <= CH0_DUAL_DATA(27 downto 0);
   
   ch0_future_cbits_o <= ch0_fifo_dout(34 downto 31); -- ctrl_bits précédant de 1 CLK ch0_dual_data_i. Ils signalent à l'avance ch0_dual_data_i
   ch0_fval_o         <= ch0_fifo_dout(30);  
   ch0_lval_o         <= ch0_fifo_dout(29);
   ch0_dval_o         <= ch0_fifo_dout(28);
   
   fifo_rd_en         <= ch0_fifo_dval and ch1_fifo_dval and active_read; -- lecture synchronisee des 2 fifos tout le temps.
   
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
   -- fsm de contrôle
   --------------------------------------------------
   U3: process(QUAD_DCLK)
   begin
      if rising_edge(QUAD_DCLK) then 
         if sreset = '1' then
            fsm <= init_st1;
            active_read  <= '0';
            active_sof   <= '0';
            active_eof   <= '0';
            active_write <= '0';
         else
            
            case fsm is
               
               -- on s'assure de ne pas avoir d'image tronquée
               when init_st1 =>
                  if ch0_fval_i = '1' then 
                     fsm <= init_st2;
                  end if;
               
               when init_st2 =>                  
                  if ch0_fval_i = '0' then
                     active_write <= '1';
                     fsm <= idle;
                  end if;
                  
               --  on attend le debut d'une image              
               when idle =>
                  dly_cnt <= (others => '0');
                  if ch0_fval_i = '1' then
                     fsm <= dly_st; 
                  end if;               
                  
               --  on decale la lecture du fifo de 8 données
               when dly_st =>
                  if ch0_dval_i = '1' then
                     dly_cnt <= dly_cnt + 1;
                  end if;
                  if dly_cnt(C_BITPOS) = '1' then    -- un peu plus que EOF_TO_FSYNC_DLY coups d'horloge de delai avant debut de lecture du fifo
                     fsm <= first_line_st;
                  end if;
                  
               --  on permet la lecture des données du fifo
               when first_line_st =>
                  active_read  <= '1';
                  active_sof <= '1';
                  if ch0_lval_o = '1' and ch0_future_cbits_o /= x"3" then
                     active_sof <= '0';
                     fsm <= last_line_st;
                  end if;
                  
               -- on attend que fval tombe à l'entrée du fifo   
               when last_line_st =>
                  if ch0_fval_i = '0' then
                     active_eof <= '1';
                     fsm <= read_end_st;
                  end if;
                  
               --  on attend que fval tombe à la sortie du fifo
               when read_end_st =>
                  if ch0_fval_o = '0' and fifo_rd_en = '1' then  
                     active_read  <= '0';
                     active_eof <= '1';
                     fsm <= idle;
                  end if;
               
               when others =>
               
            end case;
            
            
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- outputs
   --------------------------------------------------
   U4: process(QUAD_DCLK)
   begin
      if rising_edge(QUAD_DCLK) then 
         
         err_i(err_i'length-1 downto 1) <= (others => '0');
         err_i(0) <= ch0_fifo_ovfl or ch1_fifo_ovfl;
         
         -- non utilisés
         quad_dout_o(71 downto 68)  <= (others => '0');
         
         -- fval
         quad_dout_o(67)            <= ch0_fval_o;                          
         
         -- pix_fval
         if ch0_lval_o = '1' and active_sof = '1' then   
            quad_dout_o(66)         <= '1';                                 
         elsif ch0_lval_o = '1' and ch0_future_cbits_o /= x"3" and active_eof = '1' then
            quad_dout_o(66)         <= '0';
         end if;
         
         -- pix_lval
         quad_dout_o(65)            <= ch0_lval_o;                          
         
         -- pix_dval
         quad_dout_o(64)            <= ch0_dval_o;
         
         -- pixels
         quad_dout_o(63 downto 48)  <= "00" & ch1_fifo_dout(27 downto 14);  -- pix4
         quad_dout_o(47 downto 32)  <= "00" & ch1_fifo_dout(13 downto 0);  -- pix3
         quad_dout_o(31 downto 16)  <= "00" & ch0_fifo_dout(27 downto 14);  -- pix2
         quad_dout_o(15 downto  0)  <= "00" & ch0_fifo_dout(13 downto  0);  -- pix1
         quad_dval_o                <= fifo_rd_en;         
         
      end if;
   end process;
   
end rtl;
