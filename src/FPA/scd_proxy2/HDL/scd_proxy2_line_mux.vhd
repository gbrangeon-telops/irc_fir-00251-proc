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
   
   type line_mux_fsm_type is (quad1_out_st, quad2_out_st);
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   component fwft_sfifo_w76_d1024
      port (
         clk : in std_logic;
         srst : in std_logic;
         din : in std_logic_vector(75 downto 0);
         wr_en : in std_logic;
         rd_en : in std_logic;
         dout : out std_logic_vector(75 downto 0);
         full : out std_logic;
         overflow : out std_logic;
         empty : out std_logic;
         valid : out std_logic
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
   U2A : fwft_sfifo_w76_d1024
   port map (
      srst => sreset,
      clk => CLK,
      din => quad1_fifo_din,
      wr_en => quad1_fifo_wr_en,
      rd_en => quad1_fifo_rd_en,
      dout => quad1_fifo_dout,
      valid  => quad1_fifo_dval,
      full => open,
      overflow => quad1_fifo_ovfl,
      empty => open
      ); 
    
   --------------------------------------------------
   -- fifo fwft line2_quad_DATA 
   -------------------------------------------------- 
   U2B : fwft_sfifo_w76_d1024
   port map (
      srst => sreset,
      clk => CLK,
      din => quad2_fifo_din,
      wr_en => quad2_fifo_wr_en,
      rd_en => quad2_fifo_rd_en,
      dout => quad2_fifo_dout,
      valid  => quad2_fifo_dval,
      full => open,
      overflow => quad2_fifo_ovfl,
      empty => open
      );
   
   
   --------------------------------------------------
   -- multiplexage
   -------------------------------------------------- 
   U3 :  process(CLK) 
   begin
      if rising_edge(CLK) then
         if sreset = '1' then  
            dout_mosi_i.dval <= '0';	
            line_mux_fsm <= quad1_out_st;
            quad1_fifo_rd_en <= '0';
            quad2_fifo_rd_en <= '0';
            -- pragma translate_off
            dout_mosi_i.sof <= '0';
            dout_mosi_i.eof <= '0';          
            -- pragma translate_on 
            
            
         else
            
            err_i <= DOUT_MISO.BUSY and (QUAD1_MOSI.DVAL or QUAD2_MOSI.DVAL);
            
            -- valeurs par defaut
            quad1_fifo_rd_en <= '0';
            quad2_fifo_rd_en <= '0';
            
            case line_mux_fsm is 
               
               when quad1_out_st =>                     
                  dout_mosi_i <= quad1_dout_mosi;           -- line1           
                  quad1_fifo_rd_en <= quad1_fifo_dval;  
                  if MUX_ENABLED = '1' then                  -- provient du MB
                     if quad1_fifo_dval = '1' and quad1_dout_mosi.eol = '1' then   
                        line_mux_fsm <= quad2_out_st;                        
                     end if;
                  end if;
               
               when quad2_out_st =>
                  dout_mosi_i <= quad2_dout_mosi;         -- line2  
                  quad2_fifo_rd_en <= quad2_fifo_dval; 
                  if quad2_fifo_dval = '1' and quad2_dout_mosi.eol = '1' then   
                     line_mux_fsm <= quad1_out_st;                        
                  end if;
               
               when others =>
               
            end case; 	
            
         end if;
      end if;
      
   end process;
   
end rtl;
