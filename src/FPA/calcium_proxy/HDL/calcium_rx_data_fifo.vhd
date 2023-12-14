-------------------------------------------------------------------------------
--
-- Title       : calcium_rx_data_fifo
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



--
-------------------------------------------------------------------------------

library ieee;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.FPA_define.all;
use work.proxy_define.all;

entity calcium_rx_data_fifo is
   port(
      CLK            : in std_logic;
      
      -- RX_CLK domain
      RX_DATA        : in std_logic_vector(191 downto 0);
      RX_CLK         : in std_logic;
      RX_RDY         : in std_logic;
      
      -- CLK domain
      FPA_INTF_CFG   : in fpa_intf_cfg_type;
      TX_QUAD_DATA   : out calcium_quad_data_type;
      ERROR          : out std_logic_vector(2 downto 0)
      );
end calcium_rx_data_fifo;

architecture rtl of calcium_rx_data_fifo is
   
   component rst_conditioner is
      generic (
         RESET_PULSE_DELAY : natural := 80; 
         RESET_PULSE_LEN   : natural := 9
      );
      port ( 
         ARESET      : in std_logic;
         SLOWEST_CLK : in std_logic;
         ORST        : out std_logic   
      );
   end component;
   
   component sync_reset
      port (
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic
      );
   end component;
   
   component double_sync
      generic (
         INIT_VALUE : bit := '0'
      );
      port (
         D     : in STD_LOGIC;
         Q     : out STD_LOGIC := '0';
         RESET : in STD_LOGIC;
         CLK   : in STD_LOGIC
      );
   end component;
   
   component fwft_afifo_wr192_rd96_d16
      port (
         rst         : in std_logic;
         wr_clk      : in std_logic;
         rd_clk      : in std_logic;
         din         : in std_logic_vector(191 downto 0);
         wr_en       : in std_logic;
         rd_en       : in std_logic;
         dout        : out std_logic_vector(95 downto 0);
         full        : out std_logic;
         overflow    : out std_logic;
         empty       : out std_logic;
         valid       : out std_logic;
         wr_rst_busy : out std_logic;
         rd_rst_busy : out std_logic
      );
   end component;
   
   component sync_reset
      port (
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic
      );
   end component;
   
   signal cond_reset                : std_logic;
   signal sreset_rx_clk             : std_logic;
   signal sreset_clk                : std_logic;
   signal fifo_wr_i                 : std_logic;
   signal fifo_dval_i               : std_logic;
   signal fifo_dout_i               : std_logic_vector(95 downto 0);
   signal fifo_ovfl_i               : std_logic;
   signal wr_rst_busy               : std_logic;
   signal rd_rst_busy               : std_logic;
   signal unused_lval               : std_logic;
   signal unused_fval               : std_logic;
   signal quad_data_pipe1           : calcium_quad_data_type;
   signal quad_data_pipe2           : calcium_quad_data_type;
   signal lval_cnt                  : unsigned(FPA_INTF_CFG.active_line_end_num'LENGTH-1 downto 0);
   signal dval_cnt                  : unsigned(FPA_INTF_CFG.active_line_width_div4'LENGTH-1 downto 0);
   signal fifo_ovfl_sync            : std_logic;
   signal fifo_ovfl_err_i           : std_logic;
   signal fifo_rd_err_i             : std_logic;
   signal data_err_i                : std_logic;
   
   
   --   attribute keep : string;
   --   attribute keep of fifo_dval_i : signal is "true";
   --   attribute keep of fifo_dout_i : signal is "true";
   
begin
   
   -- Error mapping
   ERROR(2) <= data_err_i;
   ERROR(1) <= fifo_rd_err_i;
   ERROR(0) <= fifo_ovfl_err_i;
   
   -- Output data mapping
   TX_QUAD_DATA <= quad_data_pipe2;
   
   --------------------------------------------------
   -- Resets
   --------------------------------------------------   
   U1A : rst_conditioner
   generic map (
      RESET_PULSE_DELAY => 80,
      RESET_PULSE_LEN   => 9
   )
   port map (
      ARESET      => not RX_RDY,
      SLOWEST_CLK => RX_CLK,
      ORST        => cond_reset
   ); 
   
   U1B : sync_reset
   port map (
      ARESET => cond_reset,
      CLK    => RX_CLK,
      SRESET => sreset_rx_clk
   ); 
   
   U1C : sync_reset
   port map (
      ARESET => cond_reset,
      CLK    => CLK,
      SRESET => sreset_clk
   );
   
   --------------------------------------------------
   -- Double sync 
   --------------------------------------------------   
   U2A: double_sync
   generic map (
      INIT_VALUE => '0'
   )
   port map (
      RESET => sreset_clk,
      D => fifo_ovfl_i,
      CLK => CLK,
      Q => fifo_ovfl_sync
   );
   
   ---------------------------------------------------
   -- Fifo
   ---------------------------------------------------
   U3 : fwft_afifo_wr192_rd96_d16
   port map (
      rst         => cond_reset,
      wr_clk      => RX_CLK,
      rd_clk      => CLK,
      din         => RX_DATA,
      wr_en       => fifo_wr_i,
      rd_en       => fifo_dval_i,      -- data is read at the same time it is ready
      dout        => fifo_dout_i,
      full        => open,
      overflow    => fifo_ovfl_i,
      empty       => open,
      valid       => fifo_dval_i,
      wr_rst_busy => wr_rst_busy,  
      rd_rst_busy => rd_rst_busy      
   );
   
   ---------------------------------------------------
   -- Fifo write
   ---------------------------------------------------
   U4 : process(RX_CLK)   
   begin
      if rising_edge(RX_CLK) then
         if sreset_rx_clk = '1' then
            fifo_wr_i <= '0';                
         else
            -- Always writing when out of reset
            fifo_wr_i <= not wr_rst_busy;
         end if;
      end if;
   end process;
   
   ---------------------------------------------------
   -- Fifo read
   ---------------------------------------------------
   U5 : process(CLK)
   begin
      if rising_edge(CLK) then
         
         -- Pipe fifo dout
         -- FVAL are on odd ports and LVAL are on even ports
         unused_lval                   <= fifo_dout_i(95);
         quad_data_pipe1.pix_data(4)   <= fifo_dout_i(94 downto 72);
         unused_fval                   <= fifo_dout_i(71);
         quad_data_pipe1.pix_data(3)   <= fifo_dout_i(70 downto 48);
         quad_data_pipe1.lval          <= fifo_dout_i(47);
         quad_data_pipe1.pix_data(2)   <= fifo_dout_i(46 downto 24);
         quad_data_pipe1.fval          <= fifo_dout_i(23);
         quad_data_pipe1.pix_data(1)   <= fifo_dout_i(22 downto 0);
         quad_data_pipe1.dval          <= fifo_dval_i and fifo_dout_i(47);    -- only valid data transaction during LVAL
         -- WARNING: aoi_dval and aoi_last of quad_data_pipe1 are undefined
         
         -- 2nd pipe
         quad_data_pipe2 <= quad_data_pipe1;
         -- WARNING: aoi_dval and aoi_last of quad_data_pipe2 are managed below
         
         -- Manage LVAL counter
         -- Counter is updated at the end of a line to be ready for start of next line
         if quad_data_pipe1.fval = '0' then
            lval_cnt <= to_unsigned(1, lval_cnt'length);
         elsif quad_data_pipe2.lval = '1' and quad_data_pipe1.lval = '0' then    -- LVAL falling edge
            lval_cnt <= lval_cnt + 1;
         end if;
         
         -- Manage DVAL counter
         -- Counter starts at 1 and is updated when DVAL is high to be ready for next data
         if quad_data_pipe1.lval = '0' then
            dval_cnt <= to_unsigned(1, dval_cnt'length);
         elsif quad_data_pipe1.dval = '1' then
            dval_cnt <= dval_cnt + 1;
         end if;
         
         -- Manage area of interest data valid signal
         if lval_cnt >= FPA_INTF_CFG.active_line_start_num and lval_cnt <= FPA_INTF_CFG.active_line_end_num then
            quad_data_pipe2.aoi_dval <= quad_data_pipe1.dval;
         else
            quad_data_pipe2.aoi_dval <= '0';
         end if;
         
         -- Manage area of interest last data valid signal
         if lval_cnt = FPA_INTF_CFG.active_line_end_num and dval_cnt = FPA_INTF_CFG.active_line_width_div4 then
            quad_data_pipe2.aoi_last <= quad_data_pipe1.dval;
         else
            quad_data_pipe2.aoi_last <= '0';
         end if;
         
      end if;
   end process;
   
   ---------------------------------------------------
   -- Errors
   ---------------------------------------------------
   U6 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset_clk = '1' then
            fifo_ovfl_err_i <= '0';
            fifo_rd_err_i <= '0';
            data_err_i <= '0';
         else
            
            -- Fifo overflow. This error is latched
            if fifo_ovfl_sync = '1' then
               fifo_ovfl_err_i <= '1';
            end if;
            
            -- Fifo read while it is in reset. This error is latched
            if fifo_dval_i = '1' and rd_rst_busy = '1' then
               fifo_rd_err_i <= '1';
            end if;
            
            -- Invalid data. This error is latched
            if quad_data_pipe1.fval /= unused_fval or quad_data_pipe1.lval /= unused_lval or (quad_data_pipe1.fval = '0' and quad_data_pipe1.lval = '1') then
               data_err_i <= '1';
            end if;
            
         end if;   
      end if;
   end process;
   
end rtl;
