------------------------------------------------------------------
--!   @file : scd_proxy2_mux_std_core
--!   @brief
--!   @details
--!
--!   $Rev: 27206 $
--!   $Author: pcouture $
--!   $Date: 2022-03-03 15:45:34 -0500 (jeu., 03 mars 2022) $
--!   $Id: scd_proxy2_mux_std_core.vhd 27206 2022-03-03 20:45:34Z pcouture $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2023-09-08-Binning-FPA/src/FPA/scd_proxy2/HDL/scd_proxy2_line_mux.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.Fpa_Common_Pkg.all;
use work.fpa_define.all;
use work.tel2000.all;

entity scd_proxy2_mux_std_core is
   port(
      ARESET         : in std_logic;
      RX_CLK         : in std_logic;
      TX_CLK         : in std_logic;

      LINE0_MOSI : in t_ll_ext_mosi72;
      LINE0_MISO : out t_ll_ext_miso;
      
      LINE1_MOSI  : in t_ll_ext_mosi72;
      LINE1_MISO  : out t_ll_ext_miso;
      
      DOUT_MOSI      : out t_ll_ext_mosi72; 
      DOUT_MISO      : in t_ll_ext_miso;
      
      ERR            : out std_logic
      );
end scd_proxy2_mux_std_core;


architecture rtl of scd_proxy2_mux_std_core is
   
   type line_mux_fsm_type is (line0_out_st, wait_eol_st, line1_out_st);
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
 
   component fwft_afifo_w76_d512
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
   

    
   signal err_i                : std_logic; 
   signal sreset               : std_logic;
   signal dout_mosi_i          : t_ll_ext_mosi72;
   signal line_mux_fsm         : line_mux_fsm_type;
   signal line0_fifo_din       : std_logic_vector(75 downto 0);
   signal line0_fifo_wr_en     : std_logic;                    
   signal line0_fifo_dout      : std_logic_vector(75 downto 0);
   signal line0_fifo_rd_en     : std_logic;
   signal line0_fifo_dval      : std_logic;
   signal line0_fifo_ovfl      : std_logic;
   signal output_state         : std_logic; -- 0 : even line, 1: odd line
   
   signal line1_fifo_din       : std_logic_vector(75 downto 0);
   signal line1_fifo_wr_en     : std_logic;
   signal line1_fifo_dout      : std_logic_vector(75 downto 0);
   signal line1_fifo_rd_en     : std_logic;
   signal line1_fifo_dval      : std_logic;
   signal line1_fifo_ovfl      : std_logic;
   
   signal line0_dout_mosi  : t_ll_ext_mosi72;
   signal line1_dout_mosi   : t_ll_ext_mosi72;
   
begin
   
   ERR <= err_i;
   LINE0_MISO <= DOUT_MISO;
   LINE1_MISO <= DOUT_MISO;
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
   line0_fifo_din    <= LINE0_MOSI.SOF & LINE0_MOSI.EOF & LINE0_MOSI.SOL & LINE0_MOSI.EOL & LINE0_MOSI.DATA;
   line0_fifo_wr_en  <= LINE0_MOSI.DVAL;   
   line1_fifo_din    <= LINE1_MOSI.SOF & LINE1_MOSI.EOF & LINE1_MOSI.SOL & LINE1_MOSI.EOL & LINE1_MOSI.DATA;
   line1_fifo_wr_en  <= LINE1_MOSI.DVAL; 
   
   
   ------------------------------------------------
   -- données sortant des fifos
   ------------------------------------------------
   line0_dout_mosi.data <=  line0_fifo_dout(71 downto 0);
   line0_dout_mosi.eol  <=  line0_fifo_dout(72);
   line0_dout_mosi.sol  <=  line0_fifo_dout(73);
   line0_dout_mosi.eof  <=  line0_fifo_dout(74);
   line0_dout_mosi.sof  <=  line0_fifo_dout(75);
   line0_dout_mosi.dval <=  line0_fifo_dval;
   
   line1_dout_mosi.data <=  line1_fifo_dout(71 downto 0);
   line1_dout_mosi.eol  <=  line1_fifo_dout(72);
   line1_dout_mosi.sol  <=  line1_fifo_dout(73);
   line1_dout_mosi.eof  <=  line1_fifo_dout(74);
   line1_dout_mosi.sof  <=  line1_fifo_dout(75);
   line1_dout_mosi.dval <=  line1_fifo_dval;  
   
   --------------------------------------------------
   -- fifo fwft line 0
   -------------------------------------------------- 
   U2A : fwft_afifo_w76_d512
   port map (
      rst => sreset,
      wr_clk => RX_CLK,
      rd_clk => TX_CLK,
      din => line0_fifo_din,
      wr_en => line0_fifo_wr_en,
      rd_en => line0_fifo_rd_en,
      dout => line0_fifo_dout,
      valid  => line0_fifo_dval,
      full => open,
      overflow => line0_fifo_ovfl,
      empty => open,
      wr_rst_busy => open,
      rd_rst_busy => open
      );       
      
   
   
   --------------------------------------------------
   -- fifo fwft line 1
   -------------------------------------------------- 
   U2B : fwft_afifo_w76_d512
   port map ( 
      rst => sreset,
      wr_clk => RX_CLK,
      rd_clk => TX_CLK,
      din => line1_fifo_din,
      wr_en => line1_fifo_wr_en,
      rd_en => line1_fifo_rd_en,
      dout => line1_fifo_dout,
      valid  => line1_fifo_dval,
      full => open,
      overflow => line1_fifo_ovfl,
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
            line_mux_fsm <= line0_out_st;
            line0_fifo_rd_en <= '0';
            line1_fifo_rd_en <= '0';         
            output_state <= '0'; 
            dout_mosi_i.dval <= '0';
         else
            
            err_i <= DOUT_MISO.BUSY and (LINE0_MOSI.DVAL or LINE1_MOSI.DVAL);
            
            case line_mux_fsm is 
               
               when line0_out_st => 
               
                  dout_mosi_i.data <= (others => '0');
                  dout_mosi_i.eol  <= '0';
                  dout_mosi_i.sol  <= '0';
                  dout_mosi_i.sof  <= '0';  
                  dout_mosi_i.eof  <= '0';
                  dout_mosi_i.dval <= '0';
                        
                  if line0_dout_mosi.sol = '1' and line0_dout_mosi.dval = '1' then
                     line0_fifo_rd_en <= line0_dout_mosi.dval; 
                     line_mux_fsm <= wait_eol_st;
                  end if;
               
               when line1_out_st => 
               
                  dout_mosi_i.data <= (others => '0');
                  dout_mosi_i.eol  <= '0';
                  dout_mosi_i.sol  <= '0';
                  dout_mosi_i.sof  <= '0';  
                  dout_mosi_i.eof  <= '0';
                  dout_mosi_i.dval <= '0';
                  
                  if line1_dout_mosi.sol = '1' and line1_dout_mosi.dval = '1' then
                     line1_fifo_rd_en <= line1_dout_mosi.dval;
                     line_mux_fsm <= wait_eol_st;
                  end if;
                
               when wait_eol_st =>                  
               
                  if output_state = '0' then 
                     
                     if line0_dout_mosi.eol = '1' and line0_dout_mosi.dval = '1' then
                        line0_fifo_rd_en <= '0';  
                        output_state <= '1';
                        line_mux_fsm <= line1_out_st; 
                     end if;
                        dout_mosi_i.data <= line0_dout_mosi.data;
                        dout_mosi_i.eol  <= line0_dout_mosi.eol;
                        dout_mosi_i.sol  <= line0_dout_mosi.sol;
                        dout_mosi_i.sof  <= line0_dout_mosi.sof;  
                        dout_mosi_i.eof  <= '0';
                        dout_mosi_i.dval <= line0_dout_mosi.dval;   
                     
                     
                     
                  elsif output_state = '1' then
                     
                     if line1_dout_mosi.eol = '1' and line1_dout_mosi.dval = '1' then
                        line1_fifo_rd_en <= '0'; 
                        output_state <= '0';
                        line_mux_fsm <= line0_out_st; 
                     end if;  
                     
                        dout_mosi_i.data <= line1_dout_mosi.data;
                        dout_mosi_i.eol  <= line1_dout_mosi.eol;
                        dout_mosi_i.sol  <= line1_dout_mosi.sol;
                        dout_mosi_i.sof  <= '0';  
                        dout_mosi_i.eof  <= line1_dout_mosi.eof;
                        dout_mosi_i.dval <= line1_dout_mosi.dval;   

                     
                        
                  end if;

               when others =>
               
            end case; 

         end if;
      end if;
      
   end process;   
   
   
end rtl;
