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
      CLK           : in std_logic;
      
      MUX_ENABLED   : in std_logic;
      
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
   
   type line_mux_fsm_type is (idle, quad1_out_st, pause_st1, quad2_out_st, pause_st2);
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   component fwft_afifo_w76_d1024
      port (
         wr_clk   : in std_logic;
         rd_clk   : in std_logic;
         rst      : in std_logic;
         din      : in std_logic_vector(75 downto 0);
         wr_en    : in std_logic;
         rd_en    : in std_logic;
         dout     : out std_logic_vector(75 downto 0);
         full     : out std_logic;
         overflow : out std_logic;
         empty    : out std_logic;
         valid    : out std_logic;
         wr_rst_busy : out std_logic;
         rd_rst_busy : out std_logic
         );
   end component; 
   
   constant C_EOL_POS     : integer := 72;
   
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
      CLK    => CLK,
      SRESET => sreset
      );
   
   
   ------------------------------------------------
   -- données entrant dans les fifos
   ------------------------------------------------
   quad1_fifo_din  <= QUAD1_MOSI.SOF & QUAD1_MOSI.EOF & QUAD1_MOSI.SOL & QUAD1_MOSI.EOL & QUAD1_MOSI.DATA;
   quad1_fifo_wr_en <= QUAD1_MOSI.DVAL;   
   quad2_fifo_din  <= QUAD2_MOSI.SOF & QUAD2_MOSI.EOF & QUAD2_MOSI.SOL & QUAD2_MOSI.EOL & QUAD2_MOSI.DATA;
   quad2_fifo_wr_en <= QUAD2_MOSI.DVAL; 
   
   --------------------------------------------------
   -- fifo fwft line1_quad_DATA 
   -------------------------------------------------- 
   U2A : fwft_afifo_w76_d1024
   port map (
      rst => ARESET,
      wr_clk => CLK,
      rd_clk => CLK,
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
      rst => ARESET,
      wr_clk => CLK,
      rd_clk => CLK,
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
   U3 :  process(CLK) 
   begin
      if rising_edge(CLK) then
         if sreset = '1' then  
            line_mux_fsm <= idle;
            quad1_fifo_rd_en <= '0';
            quad2_fifo_rd_en <= '0';         
            
         else
            
            err_i <= DOUT_MISO.BUSY and (QUAD1_MOSI.DVAL or QUAD2_MOSI.DVAL);
            
            
            case line_mux_fsm is 
               
               when idle =>
                  if MUX_ENABLED = '1' then
                     line_mux_fsm <= quad1_out_st;
                  end if;
               
               when quad1_out_st =>                     
                  -- quad1_fifo_rd_en <= quad1_fifo_dval;                   
                  if quad1_fifo_dval = '1' then
                     quad1_fifo_rd_en <= '1';
                     if quad1_fifo_dout(C_EOL_POS) = '1' then
                        quad1_fifo_rd_en <= '0';
                        line_mux_fsm <= pause_st1;
                     end if;
                  end if;
               
               when pause_st1 =>                  
                  if quad2_fifo_dval = '1' then
                     line_mux_fsm <= quad2_out_st;  
                  end if;                 
               
               when quad2_out_st =>
                  -- quad2_fifo_rd_en <= quad2_fifo_dval; 
                  if quad2_fifo_dval = '1' then
                     quad2_fifo_rd_en <= '1';
                     if quad2_fifo_dout(C_EOL_POS) = '1' then 
                        quad2_fifo_rd_en <= '0';
                        line_mux_fsm <= pause_st2;
                     end if;
                  end if;
               
               when pause_st2 =>                  
                  if quad1_fifo_dval = '1' then
                     line_mux_fsm <= quad1_out_st;  
                  end if; 
               
               when others =>
               
            end case; 
            
            
            
         end if;
      end if;
      
   end process;   
   
   --------------------------------------------------
   -- pipe2 : sortie des données
   -------------------------------------------------- 
   U4 :  process(CLK) 
   begin
      if rising_edge(CLK) then
         if sreset = '1' then  
            dout_mosi_i.dval <= '0';
            
         else
            
            if quad1_fifo_rd_en = '1' then               -- line 1
               dout_mosi_i.data <= quad1_fifo_dout(71 downto 0);
               dout_mosi_i.eol  <= quad1_fifo_dout(72);
               dout_mosi_i.sol  <= quad1_fifo_dout(73);
               dout_mosi_i.sof  <= quad1_fifo_dout(75);
               dout_mosi_i.eof  <= '0';
               dout_mosi_i.dval <= quad1_fifo_dval;               
            elsif quad2_fifo_rd_en = '1' then            -- line 2
               dout_mosi_i.data <= quad2_fifo_dout(71 downto 0);
               dout_mosi_i.eol  <= quad2_fifo_dout(72);
               dout_mosi_i.sol  <= quad2_fifo_dout(73);               
               dout_mosi_i.sof  <= '0'; 
               dout_mosi_i.eof  <= quad2_fifo_dout(74);
               dout_mosi_i.dval <= quad2_fifo_dval;
            else
               dout_mosi_i.dval <= '0';               
            end if;
            
         end if;
      end if;
      
   end process;
   
end rtl;
