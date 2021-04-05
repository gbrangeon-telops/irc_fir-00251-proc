-------------------------------------------------------------------------------
--
-- Title       : quad_data_sync_v2
-- Design      : quad_intf_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\telops\FIR-00251-Proc\src\quad_serdes\HDL\quad_data_sync_v2.vhd
-- Generated   : Wed May 27 09:14:02 2015
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description :

-- fifo_dout_i (71:58)   :  misc_flags
-- fifo_dout_i (57)      : frame_flag_sync
-- fifo_dout_i (56)      : line_flag_sync
-- fifo_dout_i (55:0)    : échantillons des ADCs



--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity quad_data_sync_v2 is
   generic(
      G_INVERT_VIDEO_DATA : std_logic := '0'
      );
   port(
      ARESET         : in std_logic;
      CLKD           : in std_logic; -- same as output clock of the iserdes
      DVAL_IN        : in std_logic; -- same as output clock of the iserdes
      D0             : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      D1             : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      D2             : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      D3             : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      CLK_DOUT       : in std_logic;
      SYNC_FLAG      : in std_logic_vector(15 downto 0); -- signaux de synchro à usage divers. (Peut dépendre de chaque détecteur)
      Q              : out std_logic_vector(71 downto 0);-- CLK_DOUT domain
      DVAL           : out std_logic -- CLK_DOUT domain
      );
end quad_data_sync_v2;

architecture rtl of quad_data_sync_v2 is
   
   constant C_FIFO_RDY_DLY  : natural := 100;
   
   component fwft_afifo_w72_d16 is
      port (
         RST            : in std_logic;
         WR_CLK         : in std_logic;
         RD_CLK         : in std_logic;
         DIN            : in std_logic_vector (71 downto 0);
         WR_EN          : in std_logic;
         RD_EN          : in std_logic;
         DOUT           : out std_logic_vector (71 downto 0);
         FULL           : out std_logic;         
         ALMOST_FULL    : out std_logic;
         OVERFLOW       : out std_logic;
         EMPTY          : out std_logic;
         VALID          : out std_logic;
         WR_RST_BUSY    : out std_logic;
         RD_RST_BUSY    : out std_logic
         );
   end component;
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;
   
   signal sreset_clkout             : std_logic;
   signal fifo_wr_i, fifo_dval_i    : std_logic;
   signal fifo_din_i, fifo_dout_i   : std_logic_vector(Q'length-1 downto 0);
   signal fifo_rd_i                 : std_logic;
   signal adc_clk_ref               : std_logic;
   signal adc_clk_ref_last          : std_logic;
   signal dly_cnt                   : natural range 0 to C_FIFO_RDY_DLY + 1;
   signal fifo_rst                  : std_logic := '1'; 
   signal wr_rst_busy               : std_logic := '1';
   signal sreset_clkd               : std_logic := '1';
   
   
   --   attribute keep : string;
   --   attribute keep of fifo_dval_i : signal is "true";
   --   attribute keep of fifo_dout_i : signal is "true";
   
begin
   
   Q    <= std_logic_vector(SYNC_FLAG & fifo_dout_i(55 downto 0));  
   DVAL <= fifo_rd_i;
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1A : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK_DOUT,
      SRESET => sreset_clkout
      ); 
   
   U1B : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLKD,
      SRESET => sreset_clkd
      ); 
   
   U2 : process(CLK_DOUT)    -- permet de prolonger le delai d'inactivité sur les signaux de contrôle au delà du reset du fifo
   begin
      if rising_edge(CLK_DOUT) then
         if sreset_clkout = '1' then
            adc_clk_ref_last   <= '0';
            adc_clk_ref        <= '0'; 
            fifo_rd_i          <= '0';
         else
            
            adc_clk_ref        <= SYNC_FLAG(5);  -- en realité c'est un clock enable.
            adc_clk_ref_last   <= adc_clk_ref;   -- adc_clk_ref doit être toujours vivant. Sinon le fifo debordera.
            
            fifo_rd_i          <= (not adc_clk_ref_last and adc_clk_ref) and fifo_dval_i;
            
         end if;   
      end if;
      
   end process;
   
   ---------------------------------------------------
   --
   ---------------------------------------------------
   G0: if G_INVERT_VIDEO_DATA = '0' generate
      fifo_din_i <= x"0000" & D3 & D2 & D1 & D0;
   end generate;
   
   G1: if G_INVERT_VIDEO_DATA = '1' generate
      fifo_din_i <= x"0000" & not (D3 & D2 & D1 & D0);
   end generate;   
   
   fifo_wr_i  <= DVAL_IN 
   -- pragma translate_off
   and not wr_rst_busy 
   -- pragma translate_on
   ;
   
   U3 : fwft_afifo_w72_d16
   port map(
      rst         => fifo_rst,
      wr_clk      => CLKD,
      rd_clk      => CLK_DOUT,
      din         => fifo_din_i,
      wr_en       => fifo_wr_i,
      rd_en       => fifo_rd_i,
      dout        => fifo_dout_i,
      full        => open,
      almost_full => open,
      overflow    => open,
      empty       => open,
      valid       => fifo_dval_i,
      wr_rst_busy => wr_rst_busy,  
      rd_rst_busy => open      
      );
   
   ---------------------------------------------------
   --  rst rallongé du fifo
   ---------------------------------------------------
   U4 : process(CLKD)   
   begin
      if rising_edge(CLKD) then
         if sreset_clkd = '1' then
            dly_cnt <= 0;
            fifo_rst <= '1'; 
         else
            if dly_cnt < C_FIFO_RDY_DLY then
               dly_cnt <= dly_cnt + 1;
            else
               fifo_rst <= '0';    
            end if;   
         end if;
      end if;
   end process;
   
end rtl;
