------------------------------------------------------------------
--!   @file : afpa_chn_diversity_ctrler
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
use work.Fpa_Common_Pkg.all;
use work.fpa_define.all;
use work.tel2000.all;

entity scd_proxy2_line_mux is
   port(
      ARESET        : in std_logic;
      RX_CLK        : in std_logic;
      TX_CLK        : in std_logic;
      
      QUAD2_ENABLED : in std_logic;
      
      QUAD1_MOSI    : in t_ll_ext_mosi72;
      QUAD1_MISO    : out t_ll_ext_miso;
      
      QUAD2_MOSI    : in t_ll_ext_mosi72;
      QUAD2_MISO    : out t_ll_ext_miso;
      
      DOUT_MOSI     : out t_ll_ext_mosi72; 
      DOUT_MISO     : in t_ll_ext_miso;
      
      ERR           : out std_logic
      );
end scd_proxy2_line_mux;


architecture rtl of scd_proxy2_line_mux is
   
   type line_mux_fsm_type is (pause_st, quad1_out_st, quad2_out_st);
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
 
   component fwft_afifo_w76_d1024
      port (
         rst : in STD_LOGIC;
         wr_clk : in STD_LOGIC;
         rd_clk : in STD_LOGIC;
         din : in STD_LOGIC_VECTOR ( 75 downto 0 );
         wr_en : in STD_LOGIC;
         rd_en : in STD_LOGIC;
         dout : out STD_LOGIC_VECTOR ( 75 downto 0 );
         full : out STD_LOGIC;
         overflow : out STD_LOGIC;
         empty : out STD_LOGIC;
         valid : out STD_LOGIC;
         wr_rst_busy : out STD_LOGIC;
         rd_rst_busy : out STD_LOGIC
         );
   end component; 
   

    
   signal err_i           : std_logic; 
   signal sreset          : std_logic;
   signal dout_mosi_i     : t_ll_ext_mosi72;
   signal line_mux_fsm    : line_mux_fsm_type;
   signal quad1_fifo_din  : std_logic_vector(75 downto 0);
   signal quad1_fifo_wr_en: std_logic;                    
   signal quad1_fifo_dout : std_logic_vector(75 downto 0);
   signal quad1_fifo_rd_en: std_logic;
   signal quad1_fifo_dval : std_logic;
   signal quad1_fifo_ovfl : std_logic;
   
   signal quad2_fifo_din  : std_logic_vector(75 downto 0);
   signal quad2_fifo_wr_en: std_logic;
   signal quad2_fifo_dout : std_logic_vector(75 downto 0);
   signal quad2_fifo_rd_en: std_logic;
   signal quad2_fifo_dval : std_logic;
   signal quad2_fifo_ovfl : std_logic;
   
   signal quad1_dout_mosi : t_ll_ext_mosi72;
   signal quad2_dout_mosi : t_ll_ext_mosi72;
   
begin
   
   ERR <= err_i;
   QUAD1_MISO <= DOUT_MISO;
   QUAD2_MISO <= DOUT_MISO;
   DOUT_MOSI <= dout_mosi_i;
   
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => TX_CLK,
      SRESET => sreset
      );
   
   
   ------------------------------------------------
   -- données entrant dans les fifos
   ------------------------------------------------
   quad1_fifo_din   <= QUAD1_MOSI.SOF & QUAD1_MOSI.EOF & QUAD1_MOSI.SOL & QUAD1_MOSI.EOL & QUAD1_MOSI.DATA;
   quad1_fifo_wr_en <= QUAD1_MOSI.DVAL;   
   quad2_fifo_din   <= QUAD2_MOSI.SOF & QUAD2_MOSI.EOF & QUAD2_MOSI.SOL & QUAD2_MOSI.EOL & QUAD2_MOSI.DATA;
   quad2_fifo_wr_en <= QUAD2_MOSI.DVAL; 
   
   
   ------------------------------------------------
   -- données sortant des fifos
   ------------------------------------------------
   quad1_dout_mosi.data <=  quad1_fifo_dout(71 downto 0);
   quad1_dout_mosi.eol  <=  quad1_fifo_dout(72);
   quad1_dout_mosi.sol  <=  quad1_fifo_dout(73);
   quad1_dout_mosi.eof  <=  quad1_fifo_dout(74);
   quad1_dout_mosi.sof  <=  quad1_fifo_dout(75);
   quad1_dout_mosi.dval <=  quad1_fifo_dval;
   
   quad2_dout_mosi.data <=  quad2_fifo_dout(71 downto 0);
   quad2_dout_mosi.eol  <=  quad2_fifo_dout(72);
   quad2_dout_mosi.sol  <=  quad2_fifo_dout(73);
   quad2_dout_mosi.eof  <=  quad2_fifo_dout(74);
   quad2_dout_mosi.sof  <=  quad2_fifo_dout(75);
   quad2_dout_mosi.dval <=  quad2_fifo_dval;  
   
   --------------------------------------------------
   -- fifo fwft line1_quad_DATA 
   -------------------------------------------------- 
   U2A : fwft_afifo_w76_d1024
   port map (
      rst => sreset,
      wr_clk => RX_CLK,
      rd_clk => TX_CLK,
      din => quad1_fifo_din,
      wr_en => quad1_fifo_wr_en,
      rd_en => quad1_fifo_rd_en,
      dout => quad1_fifo_dout,
      valid  => quad1_fifo_dval,
      full => open,
      overflow => quad1_fifo_ovfl,
      empty => open,
      wr_rst_busy => open,
      rd_rst_busy => open
      );       
      
   
   
   --------------------------------------------------
   -- fifo fwft line2_quad_DATA 
   -------------------------------------------------- 
   U2B : fwft_afifo_w76_d1024
   port map ( 
      rst => sreset,
      wr_clk => RX_CLK,
      rd_clk => TX_CLK,
      din => quad2_fifo_din,
      wr_en => quad2_fifo_wr_en,
      rd_en => quad2_fifo_rd_en,
      dout => quad2_fifo_dout,
      valid  => quad2_fifo_dval,
      full => open,
      overflow => quad2_fifo_ovfl,
      empty => open,
      wr_rst_busy => open,
      rd_rst_busy => open
      );
   
   --------------------------------------------------
   -- pipe1 : multiplexage
   -------------------------------------------------- 
   U3 :  process(TX_CLK) 
   begin
      if rising_edge(TX_CLK) then
         if sreset = '1' then  
            line_mux_fsm <= quad1_out_st;
            quad1_fifo_rd_en <= '0';
            quad2_fifo_rd_en <= '0';         
            
         else
            
            err_i <= DOUT_MISO.BUSY and (QUAD1_MOSI.DVAL or QUAD2_MOSI.DVAL);
            
            
            case line_mux_fsm is 
               
               when quad1_out_st =>                                       
                  if quad1_dout_mosi.dval = '1' then
                     quad1_fifo_rd_en <= '1';
                     if quad1_dout_mosi.eol = '1' then
                        quad1_fifo_rd_en <= '0';
                        line_mux_fsm <= pause_st;
                     end if;
                  end if;
               
               when pause_st =>                  
                  if QUAD2_ENABLED = '1' then 
                     if quad2_fifo_dval = '1' then
                        line_mux_fsm <= quad2_out_st;  
                     end if;
                  else
                     line_mux_fsm <= quad1_out_st;
                  end if;
               
               when quad2_out_st =>
                  if quad2_dout_mosi.dval = '1' then
                     quad2_fifo_rd_en <= '1';
                     if quad2_dout_mosi.eol = '1' then
                        quad2_fifo_rd_en <= '0';
                        line_mux_fsm <= quad1_out_st;
                     end if;
                  end if;
               
               when others =>
               
            end case; 
            
            
            
         end if;
      end if;
      
   end process;   
   
   --------------------------------------------------
   -- pipe2 : sortie des données
   -------------------------------------------------- 
   U4 :  process(TX_CLK) 
   begin
      if rising_edge(TX_CLK) then
         if sreset = '1' then  
            dout_mosi_i.dval <= '0';
            
         else
            
            if quad1_fifo_rd_en = '1' then               -- line 1
               dout_mosi_i.data <= quad1_dout_mosi.data;
               dout_mosi_i.eol  <= quad1_dout_mosi.eol;
               dout_mosi_i.sol  <= quad1_dout_mosi.sol;
               dout_mosi_i.sof  <= quad1_dout_mosi.sof;
               dout_mosi_i.eof  <= quad1_dout_mosi.eof and not QUAD2_ENABLED;
               dout_mosi_i.dval <= quad1_dout_mosi.dval;               
            elsif quad2_fifo_rd_en = '1' then            -- line 2
               dout_mosi_i.eol  <= quad2_dout_mosi.eol;
               dout_mosi_i.sol  <= quad2_dout_mosi.sol;
               dout_mosi_i.sof  <= quad2_dout_mosi.sof and not QUAD2_ENABLED;
               dout_mosi_i.eof  <= quad2_dout_mosi.eof;
               dout_mosi_i.dval <= quad2_dout_mosi.dval;
            else
               dout_mosi_i.dval <= '0';               
            end if;
            
         end if;
      end if;
      
   end process;
   
end rtl;
