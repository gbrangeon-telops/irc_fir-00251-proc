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
      ARESET         : in std_logic;
      RX_CLK         : in std_logic;
      TX_CLK         : in std_logic;

      EVEN_LINE_MOSI : in t_ll_ext_mosi72;
      EVEN_LINE_MISO : out t_ll_ext_miso;
      
      ODD_LINE_MOSI  : in t_ll_ext_mosi72;
      ODD_LINE_MISO  : out t_ll_ext_miso;
      
      DOUT_MOSI      : out t_ll_ext_mosi72; 
      DOUT_MISO      : in t_ll_ext_miso;
      
      ERR            : out std_logic
      );
end scd_proxy2_line_mux;


architecture rtl of scd_proxy2_line_mux is
   
   type line_mux_fsm_type is (even_line_out_st, wait_eol_st, odd_line_out_st);
   
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
   signal even_line_fifo_din   : std_logic_vector(75 downto 0);
   signal even_line_fifo_wr_en : std_logic;                    
   signal even_line_fifo_dout  : std_logic_vector(75 downto 0);
   signal even_line_fifo_rd_en : std_logic;
   signal even_line_fifo_dval  : std_logic;
   signal even_line_fifo_ovfl  : std_logic;
   signal output_state         : std_logic; -- 0 : even line, 1: odd line
   
   signal odd_line_fifo_din    : std_logic_vector(75 downto 0);
   signal odd_line_fifo_wr_en  : std_logic;
   signal odd_line_fifo_dout   : std_logic_vector(75 downto 0);
   signal odd_line_fifo_rd_en  : std_logic;
   signal odd_line_fifo_dval   : std_logic;
   signal odd_line_fifo_ovfl   : std_logic;
   
   signal even_line_dout_mosi  : t_ll_ext_mosi72;
   signal odd_line_dout_mosi   : t_ll_ext_mosi72;
   
begin
   
   ERR <= err_i;
   EVEN_LINE_MISO <= DOUT_MISO;
   ODD_LINE_MISO <= DOUT_MISO;
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
   even_line_fifo_din   <= EVEN_LINE_MOSI.SOF & EVEN_LINE_MOSI.EOF & EVEN_LINE_MOSI.SOL & EVEN_LINE_MOSI.EOL & EVEN_LINE_MOSI.DATA;
   even_line_fifo_wr_en <= EVEN_LINE_MOSI.DVAL;   
   odd_line_fifo_din    <= ODD_LINE_MOSI.SOF & ODD_LINE_MOSI.EOF & ODD_LINE_MOSI.SOL & ODD_LINE_MOSI.EOL & ODD_LINE_MOSI.DATA;
   odd_line_fifo_wr_en  <= ODD_LINE_MOSI.DVAL; 
   
   
   ------------------------------------------------
   -- données sortant des fifos
   ------------------------------------------------
   even_line_dout_mosi.data <=  even_line_fifo_dout(71 downto 0);
   even_line_dout_mosi.eol  <=  even_line_fifo_dout(72);
   even_line_dout_mosi.sol  <=  even_line_fifo_dout(73);
   even_line_dout_mosi.eof  <=  even_line_fifo_dout(74);
   even_line_dout_mosi.sof  <=  even_line_fifo_dout(75);
   even_line_dout_mosi.dval <=  even_line_fifo_dval;
   
   odd_line_dout_mosi.data <=  odd_line_fifo_dout(71 downto 0);
   odd_line_dout_mosi.eol  <=  odd_line_fifo_dout(72);
   odd_line_dout_mosi.sol  <=  odd_line_fifo_dout(73);
   odd_line_dout_mosi.eof  <=  odd_line_fifo_dout(74);
   odd_line_dout_mosi.sof  <=  odd_line_fifo_dout(75);
   odd_line_dout_mosi.dval <=  odd_line_fifo_dval;  
   
   --------------------------------------------------
   -- fifo fwft even line
   -------------------------------------------------- 
   U2A : fwft_afifo_w76_d512
   port map (
      rst => sreset,
      wr_clk => RX_CLK,
      rd_clk => TX_CLK,
      din => even_line_fifo_din,
      wr_en => even_line_fifo_wr_en,
      rd_en => even_line_fifo_rd_en,
      dout => even_line_fifo_dout,
      valid  => even_line_fifo_dval,
      full => open,
      overflow => even_line_fifo_ovfl,
      empty => open,
      wr_rst_busy => open,
      rd_rst_busy => open
      );       
      
   
   
   --------------------------------------------------
   -- fifo fwft odd line
   -------------------------------------------------- 
   U2B : fwft_afifo_w76_d512
   port map ( 
      rst => sreset,
      wr_clk => RX_CLK,
      rd_clk => TX_CLK,
      din => odd_line_fifo_din,
      wr_en => odd_line_fifo_wr_en,
      rd_en => odd_line_fifo_rd_en,
      dout => odd_line_fifo_dout,
      valid  => odd_line_fifo_dval,
      full => open,
      overflow => odd_line_fifo_ovfl,
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
            line_mux_fsm <= even_line_out_st;
            even_line_fifo_rd_en <= '0';
            odd_line_fifo_rd_en <= '0';         
            output_state <= '0'; 
            dout_mosi_i.dval <= '0';
         else
            
            err_i <= DOUT_MISO.BUSY and (EVEN_LINE_MOSI.DVAL or ODD_LINE_MOSI.DVAL);
            
            case line_mux_fsm is 
               
               when even_line_out_st => 
               
                  dout_mosi_i.data <= (others => '0');
                  dout_mosi_i.eol  <= '0';
                  dout_mosi_i.sol  <= '0';
                  dout_mosi_i.sof  <= '0';  
                  dout_mosi_i.eof  <= '0';
                  dout_mosi_i.dval <= '0';
                        
                  if even_line_dout_mosi.sol = '1' and even_line_dout_mosi.dval = '1' then
                     even_line_fifo_rd_en <= even_line_dout_mosi.dval; 
                     line_mux_fsm <= wait_eol_st;
                  end if;
               
               when odd_line_out_st => 
               
                  dout_mosi_i.data <= (others => '0');
                  dout_mosi_i.eol  <= '0';
                  dout_mosi_i.sol  <= '0';
                  dout_mosi_i.sof  <= '0';  
                  dout_mosi_i.eof  <= '0';
                  dout_mosi_i.dval <= '0';
                  
                  if odd_line_dout_mosi.sol = '1' and odd_line_dout_mosi.dval = '1' then
                     odd_line_fifo_rd_en <= odd_line_dout_mosi.dval;
                     line_mux_fsm <= wait_eol_st;
                  end if;
                
               when wait_eol_st =>                  
               
                  if output_state = '0' then 
                     
                     if even_line_dout_mosi.eol = '1' and even_line_dout_mosi.dval = '1' then
                        even_line_fifo_rd_en <= '0';  
                        output_state <= '1';
                        line_mux_fsm <= odd_line_out_st; 
                     end if;
                        dout_mosi_i.data <= even_line_dout_mosi.data;
                        dout_mosi_i.eol  <= even_line_dout_mosi.eol;
                        dout_mosi_i.sol  <= even_line_dout_mosi.sol;
                        dout_mosi_i.sof  <= even_line_dout_mosi.sof;  
                        dout_mosi_i.eof  <= '0';
                        dout_mosi_i.dval <= even_line_dout_mosi.dval;   
                     
                     
                     
                  elsif output_state = '1' then
                     
                     if odd_line_dout_mosi.eol = '1' and odd_line_dout_mosi.dval = '1' then
                        odd_line_fifo_rd_en <= '0'; 
                        output_state <= '0';
                        line_mux_fsm <= even_line_out_st; 
                     end if;  
                     
                        dout_mosi_i.data <= odd_line_dout_mosi.data;
                        dout_mosi_i.eol  <= odd_line_dout_mosi.eol;
                        dout_mosi_i.sol  <= odd_line_dout_mosi.sol;
                        dout_mosi_i.sof  <= '0';  
                        dout_mosi_i.eof  <= odd_line_dout_mosi.eof;
                        dout_mosi_i.dval <= odd_line_dout_mosi.dval;   

                     
                        
                  end if;

               when others =>
               
            end case; 

         end if;
      end if;
      
   end process;   
   
   
end rtl;
