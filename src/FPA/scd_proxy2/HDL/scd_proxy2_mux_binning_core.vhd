------------------------------------------------------------------
--!   @file : scd_proxy2_mux_binning_core
--!   @brief
--!   @details
--!
--!   $Rev: 27206 $
--!   $Author: pcouture $
--!   $Date: 2022-03-03 15:45:34 -0500 (jeu., 03 mars 2022) $
--!   $Id: scd_proxy2_line_mux.vhd 27206 2022-03-03 20:45:34Z pcouture $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2023-09-08-Binning-FPA/src/FPA/scd_proxy2/HDL/scd_proxy2_line_mux.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.Fpa_Common_Pkg.all;
use work.fpa_define.all;
use work.tel2000.all;

entity scd_proxy2_mux_binning_core is
   port(
      ARESET            : in std_logic;
      RX_CLK            : in std_logic;
      TX_CLK            : in std_logic;
      
      RX0_MOSI          : in t_ll_ext_mosi72; 	  -- L0 et L1
      RX0_MISO          : out t_ll_ext_miso; 
      											  
      RX1_MOSI          : in t_ll_ext_mosi72; 		 -- L2 et L3
      RX1_MISO          : out t_ll_ext_miso;
      
      TX_MOSI           : out t_ll_ext_mosi72; 
      TX_MISO           : in t_ll_ext_miso;
      
      ERR               : out std_logic
      );
end scd_proxy2_mux_binning_core;


architecture rtl of scd_proxy2_mux_binning_core is

type line_mux_fsm_type is (line0_out_st, wait_eol_st, line1_out_st, line2_out_st, line3_out_st);

component sync_reset
   port (
      ARESET : in std_logic;
      CLK    : in std_logic;
      SRESET : out std_logic := '1'
      );
end component;
   
component fwft_afifo_wr40_rd80_d1024
   port (
      rst : in STD_LOGIC;
      wr_clk : in STD_LOGIC;
      rd_clk : in STD_LOGIC;
      din : in STD_LOGIC_VECTOR ( 39 downto 0 );
      wr_en : in STD_LOGIC;
      rd_en : in STD_LOGIC;
      dout : out STD_LOGIC_VECTOR ( 79 downto 0 );
      full : out STD_LOGIC;
      empty : out STD_LOGIC;
      valid : out STD_LOGIC;
	  underflow : out STD_LOGIC;
	  overflow : out STD_LOGIC; 
	  wr_ack : out STD_LOGIC;
      wr_rst_busy : out STD_LOGIC;
      rd_rst_busy : out STD_LOGIC
      );
end component;   

signal err_i                : std_logic; 
signal sreset               : std_logic;
signal dout_mosi_i          : t_ll_ext_mosi72; 
signal dout_mosi_debug      : t_ll_ext_mosi72; 
signal din_l1_mosi_debug       : t_ll_ext_mosi72;  
signal din_l2_mosi_debug       : t_ll_ext_mosi72;
signal line_mux_fsm         : line_mux_fsm_type;
   
signal L0_P0   : std_logic_vector(17 downto 0);			--ligne 0 colonne 0
signal L0_P1   : std_logic_vector(17 downto 0);			--ligne 0 colonne 1
signal L1_P0   : std_logic_vector(17 downto 0);
signal L1_P1   : std_logic_vector(17 downto 0);
signal L2_P0   : std_logic_vector(17 downto 0);
signal L2_P1   : std_logic_vector(17 downto 0);
signal L3_P0   : std_logic_vector(17 downto 0);
signal L3_P1   : std_logic_vector(17 downto 0);   

signal line0_fifo_din   : std_logic_vector(39 downto 0); 
signal line1_fifo_din   : std_logic_vector(39 downto 0);
signal line2_fifo_din   : std_logic_vector(39 downto 0);
signal line3_fifo_din   : std_logic_vector(39 downto 0); 

signal line0_fifo_dout  : std_logic_vector(79 downto 0); 
signal line1_fifo_dout  : std_logic_vector(79 downto 0);
signal line2_fifo_dout  : std_logic_vector(79 downto 0);
signal line3_fifo_dout  : std_logic_vector(79 downto 0); 

signal line0_fifo_wr_en : std_logic;
signal line1_fifo_wr_en : std_logic;
signal line2_fifo_wr_en : std_logic;
signal line3_fifo_wr_en : std_logic;

signal line0_fifo_rd_en : std_logic;
signal line1_fifo_rd_en : std_logic;
signal line2_fifo_rd_en : std_logic;
signal line3_fifo_rd_en : std_logic;

signal line0_fifo_dval  : std_logic;
signal line1_fifo_dval  : std_logic;
signal line2_fifo_dval  : std_logic;
signal line3_fifo_dval  : std_logic;

signal line0_dout_mosi  : t_ll_ext_mosi72;
signal line1_dout_mosi  : t_ll_ext_mosi72;
signal line2_dout_mosi  : t_ll_ext_mosi72;
signal line3_dout_mosi  : t_ll_ext_mosi72;

signal output_state     : unsigned(1 downto 0); 

signal l0_full  : std_logic;
signal l1_full  : std_logic;
signal l2_full  : std_logic;
signal l3_full  : std_logic;
--debug--
signal l0_empty  : std_logic;
signal l1_empty  : std_logic;
signal l2_empty  : std_logic;
signal l3_empty  : std_logic;
signal l0_underflow  : std_logic;
signal l1_underflow  : std_logic;
signal l2_underflow  : std_logic;
signal l3_underflow  : std_logic;
signal l0_overflow  : std_logic;
signal l1_overflow  : std_logic;
signal l2_overflow  : std_logic;
signal l3_overflow  : std_logic;
signal l0_wr_ack : std_logic;
signal l1_wr_ack : std_logic;
signal l2_wr_ack  : std_logic;
signal l3_wr_ack  : std_logic;
begin
 
     
   
   ERR <= err_i;
   RX0_MISO <= TX_MISO;
   RX1_MISO <= TX_MISO;
   TX_MOSI <= dout_mosi_i;
   

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
   -- Donnï¿½es entrant dans les fifos
   ------------------------------------------------    	
   -- Dans les serdes, port 0 (Pixel 00 et P11) et 3(P10 et P01) sur RX0 en mode binning   
   -- Dans les serdes, port 1 (Pixel 20 et P31) et 2(P30 et P21) sur odd_line en mode binning 
   L0_P0 <= RX0_MOSI.DATA(17 downto 0);    			-- L0_P0 = Ligne 0 Premier pixel
   L1_P0 <= RX0_MOSI.DATA(35 downto 18);     
   L1_P1 <= RX0_MOSI.DATA(53 downto 36);   
   L0_P1 <= RX0_MOSI.DATA(71 downto 54);   
   
   L2_P0 <= RX1_MOSI.DATA(17 downto 0);   
   L3_P0 <= RX1_MOSI.DATA(35 downto 18);    
   L3_P1 <= RX1_MOSI.DATA(53 downto 36);  
   L2_P1 <= RX1_MOSI.DATA(71 downto 54);  

   
   line0_fifo_din   <= RX0_MOSI.SOF & RX0_MOSI.EOF & RX0_MOSI.SOL & RX0_MOSI.EOL & L0_P1 & L0_P0;
   line0_fifo_wr_en <= RX0_MOSI.DVAL;
                                                                     
   line1_fifo_din   <= RX0_MOSI.SOF & RX0_MOSI.EOF & RX0_MOSI.SOL & RX0_MOSI.EOL & L1_P1 & L1_P0;
   line1_fifo_wr_en <= RX0_MOSI.DVAL;
 
   line2_fifo_din   <= RX1_MOSI.SOF & RX1_MOSI.EOF & RX1_MOSI.SOL & RX1_MOSI.EOL & L2_P1 & L2_P0;
   line2_fifo_wr_en <= RX1_MOSI.DVAL;
   
   line3_fifo_din   <= RX1_MOSI.SOF & RX1_MOSI.EOF & RX1_MOSI.SOL & RX1_MOSI.EOL & L3_P1 & L3_P0;
   line3_fifo_wr_en <= RX1_MOSI.DVAL;
   
   ------------------------------------------------
   -- donnï¿½es sortant des fifos
   ------------------------------------------------		
   --fifo din line prend les deux premiers pixel au premier coup de clock (line_din=40), deuxieme coup de clock on stock les deux autres pixels(line_din=40) puis on ressort les 4 pixels (line_dout=80)     
   --line_dout sort en premier les deux dernier pixels reçus  
   line0_dout_mosi.data <=  line0_fifo_dout(35 downto 0) & line0_fifo_dout(75 downto 40);	  
   line0_dout_mosi.eol  <=  line0_fifo_dout(36);
   line0_dout_mosi.sol  <=  line0_fifo_dout(77);
   line0_dout_mosi.eof  <=  '0';  -- No EOF possible
   line0_dout_mosi.sof  <=  line0_fifo_dout(79);   
   line0_dout_mosi.dval <=  line0_fifo_dval;
   
   line1_dout_mosi.data <=  line1_fifo_dout(35 downto 0) & line1_fifo_dout(75 downto 40);
   line1_dout_mosi.eol  <=  line1_fifo_dout(36) or line1_fifo_dout(76);
   line1_dout_mosi.sol  <=  line1_fifo_dout(77);
   line1_dout_mosi.eof  <=  '0'; -- No EOF possible
   line1_dout_mosi.sof  <=  '0'; -- No SOF possible
   line1_dout_mosi.dval <=  line1_fifo_dval;    
   
   line2_dout_mosi.data <=  line2_fifo_dout(35 downto 0) & line2_fifo_dout(75 downto 40);
   line2_dout_mosi.eol  <=  line2_fifo_dout(36);
   line2_dout_mosi.sol  <=  line2_fifo_dout(77);
   line2_dout_mosi.eof  <=  '0'; -- No EOF possible
   line2_dout_mosi.sof  <=  '0'; -- No SOF possible
   line2_dout_mosi.dval <=  line2_fifo_dval; 
   
   line3_dout_mosi.data <=  line3_fifo_dout(35 downto 0) & line3_fifo_dout(75 downto 40);
   line3_dout_mosi.eol  <=  line3_fifo_dout(36);
   line3_dout_mosi.sol  <=  line3_fifo_dout(77);
   line3_dout_mosi.eof  <=  line3_fifo_dout(38);
   line3_dout_mosi.sof  <=  '0'; -- No SOF possible
   line3_dout_mosi.dval <=  line3_fifo_dval; 
   
   dout_mosi_debug.data <= "00000000" & dout_mosi_i.data(69 downto 54) & dout_mosi_i.data(51 downto 36) & dout_mosi_i.data(33 downto 18) & dout_mosi_i.data(15 downto 0);
   dout_mosi_debug.eol  <= dout_mosi_i.eol;
   dout_mosi_debug.sol  <= dout_mosi_i.sol;
   dout_mosi_debug.eof  <= dout_mosi_i.eof;
   dout_mosi_debug.sof  <= dout_mosi_i.sof;
   dout_mosi_debug.dval  <= dout_mosi_i.dval;
 
   din_l1_mosi_debug.data <="00000000" & RX0_MOSI.DATA(69 downto 54) & RX0_MOSI.DATA(51 downto 36) & RX0_MOSI.DATA(33 downto 18) & RX0_MOSI.DATA(15 downto 0);
   din_l1_mosi_debug.eol  <= RX0_MOSI.eol;
   din_l1_mosi_debug.sol  <= RX0_MOSI.sol;
   din_l1_mosi_debug.eof  <= RX0_MOSI.eof;
   din_l1_mosi_debug.sof  <= RX0_MOSI.sof;
   din_l1_mosi_debug.dval  <= RX0_MOSI.dval;
   
   din_l2_mosi_debug.data <="00000000" & RX1_MOSI.DATA(69 downto 54) & RX1_MOSI.DATA(51 downto 36) & RX1_MOSI.DATA(33 downto 18) & RX1_MOSI.DATA(15 downto 0);
   din_l2_mosi_debug.eol  <= RX1_MOSI.eol;
   din_l2_mosi_debug.sol  <= RX1_MOSI.sol;
   din_l2_mosi_debug.eof  <= RX1_MOSI.eof;
   din_l2_mosi_debug.sof  <= RX1_MOSI.sof;
   din_l2_mosi_debug.dval  <= RX1_MOSI.dval;
   
   --------------------------------------------------
   -- fifo fwft line 0
   -------------------------------------------------- 
   U2A : fwft_afifo_wr40_rd80_d1024
   port map (
      rst => sreset,
      wr_clk => RX_CLK,
      rd_clk => TX_CLK,
      din => line0_fifo_din,
      wr_en => line0_fifo_wr_en,
      rd_en => line0_fifo_rd_en,
      dout => line0_fifo_dout,
      valid  => line0_fifo_dval,
      full => l0_full,
      empty => l0_empty, 
	  underflow => l0_underflow,
	  overflow => l0_overflow,
	  wr_ack => l0_wr_ack,
      wr_rst_busy => open,
      rd_rst_busy => open
      );       
      
   --------------------------------------------------
   -- fifo fwft line 1
   -------------------------------------------------- 
   U2B : fwft_afifo_wr40_rd80_d1024
   port map (
      rst => sreset,
      wr_clk => RX_CLK,
      rd_clk => TX_CLK,
      din => line1_fifo_din,
      wr_en => line1_fifo_wr_en,
      rd_en => line1_fifo_rd_en,
      dout => line1_fifo_dout,
      valid  => line1_fifo_dval,
      full => l1_full,
      empty => l1_empty,
	  underflow => l1_underflow,
	  overflow => l1_overflow,
	  wr_ack => l1_wr_ack,
      wr_rst_busy => open,
      rd_rst_busy => open
      );
      
   --------------------------------------------------
   -- fifo fwft line 2
   -------------------------------------------------- 
   U2C : fwft_afifo_wr40_rd80_d1024
   port map (
      rst => sreset,
      wr_clk => RX_CLK,
      rd_clk => TX_CLK,
      din => line2_fifo_din,
      wr_en => line2_fifo_wr_en,
      rd_en => line2_fifo_rd_en,
      dout => line2_fifo_dout,
      valid  => line2_fifo_dval,
      full => l2_full,
      empty => l2_empty,
	  underflow => l2_underflow, 
	  overflow => l2_overflow,
	  wr_ack => l2_wr_ack,
      wr_rst_busy => open,
      rd_rst_busy => open
      );
      
   --------------------------------------------------
   -- fifo fwft line 3
   -------------------------------------------------- 
   U2D : fwft_afifo_wr40_rd80_d1024
   port map (
      rst => sreset,
      wr_clk => RX_CLK,
      rd_clk => TX_CLK,
      din => line3_fifo_din,
      wr_en => line3_fifo_wr_en,
      rd_en => line3_fifo_rd_en,
      dout => line3_fifo_dout,
      valid  => line3_fifo_dval,
      full => l3_full,
      empty => l3_empty,
	  underflow => l3_underflow, 
	  overflow => l3_overflow,
	  wr_ack => l3_wr_ack,
      wr_rst_busy => open,
      rd_rst_busy => open
      );
      
      
 U3 :  process(TX_CLK) 
   begin
      if rising_edge(TX_CLK) then
         if sreset = '1' then  
            line_mux_fsm <= line0_out_st;
            line0_fifo_rd_en <= '0';
            line1_fifo_rd_en <= '0';
            line2_fifo_rd_en <= '0'; 
            line3_fifo_rd_en <= '0'; 
            
            output_state <= to_unsigned(0,output_state'length); 
            dout_mosi_i.dval <= '0';
         else
            
            err_i <= TX_MISO.BUSY and (RX0_MOSI.DVAL or RX1_MOSI.DVAL);
            
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
                 
               when line2_out_st => 
               
                  dout_mosi_i.data <= (others => '0');
                  dout_mosi_i.eol  <= '0';
                  dout_mosi_i.sol  <= '0';
                  dout_mosi_i.sof  <= '0';  
                  dout_mosi_i.eof  <= '0';
                  dout_mosi_i.dval <= '0';
                  
                  if line2_dout_mosi.sol = '1' and line2_dout_mosi.dval = '1' then
                     line2_fifo_rd_en <= line2_dout_mosi.dval;
                     line_mux_fsm <= wait_eol_st;
                  end if;
                  
               when line3_out_st => 
               
                  dout_mosi_i.data <= (others => '0');
                  dout_mosi_i.eol  <= '0';
                  dout_mosi_i.sol  <= '0';
                  dout_mosi_i.sof  <= '0';  
                  dout_mosi_i.eof  <= '0';
                  dout_mosi_i.dval <= '0';
                  
                  if line3_dout_mosi.sol = '1' and line3_dout_mosi.dval = '1' then
                     line3_fifo_rd_en <= line3_dout_mosi.dval;
                     line_mux_fsm <= wait_eol_st;
                  end if;
                  
                  
               when wait_eol_st =>                  
               
                  if output_state = 0 then 
                     
                     if line0_dout_mosi.eol = '1' and line0_dout_mosi.dval = '1' then
                        line0_fifo_rd_en <= '0';  
                        output_state <= to_unsigned(1,output_state'length); 
                        line_mux_fsm <= line1_out_st; 
                     end if;
                        dout_mosi_i.data <= line0_dout_mosi.data;
                        dout_mosi_i.eol  <= line0_dout_mosi.eol;
                        dout_mosi_i.sol  <= line0_dout_mosi.sol;
                        dout_mosi_i.sof  <= line0_dout_mosi.sof;  
                        dout_mosi_i.eof  <= '0';
                        dout_mosi_i.dval <= line0_dout_mosi.dval;   

                  elsif output_state = 1 then
                     
                     if line1_dout_mosi.eol = '1' and line1_dout_mosi.dval = '1' then
                        line1_fifo_rd_en <= '0'; 
                        output_state <= to_unsigned(2,output_state'length); 
                        line_mux_fsm <= line2_out_st; 
                     end if;  
                     
                        dout_mosi_i.data <= line1_dout_mosi.data;
                        dout_mosi_i.eol  <= line1_dout_mosi.eol;
                        dout_mosi_i.sol  <= line1_dout_mosi.sol;
                        dout_mosi_i.sof  <= '0';  
                        dout_mosi_i.eof  <= line1_dout_mosi.eof;
                        dout_mosi_i.dval <= line1_dout_mosi.dval;   

                  elsif output_state = 2 then
                     
                     if line2_dout_mosi.eol = '1' and line2_dout_mosi.dval = '1' then
                        line2_fifo_rd_en <= '0'; 
                        output_state <= to_unsigned(3,output_state'length);
                        line_mux_fsm <= line3_out_st; 
                     end if;  
                     
                        dout_mosi_i.data <= line2_dout_mosi.data;
                        dout_mosi_i.eol  <= line2_dout_mosi.eol;
                        dout_mosi_i.sol  <= line2_dout_mosi.sol;
                        dout_mosi_i.sof  <= '0';  
                        dout_mosi_i.eof  <= line2_dout_mosi.eof;
                        dout_mosi_i.dval <= line2_dout_mosi.dval;   
                        
                  elsif output_state = 3 then
                     
                     if line3_dout_mosi.eol = '1' and line3_dout_mosi.dval = '1' then
                        line3_fifo_rd_en <= '0'; 
                        output_state <= to_unsigned(0,output_state'length);
                        line_mux_fsm <= line0_out_st; 
                     end if;  
                     
                        dout_mosi_i.data <= line3_dout_mosi.data;
                        dout_mosi_i.eol  <= line3_dout_mosi.eol;
                        dout_mosi_i.sol  <= line3_dout_mosi.sol;
                        dout_mosi_i.sof  <= '0';  
                        dout_mosi_i.eof  <= line3_dout_mosi.eof;
                        dout_mosi_i.dval <= line3_dout_mosi.dval;                      
                                              
                  end if;

               when others =>
               
            end case; 

         end if;
      end if;
      
   end process;       
end rtl;
