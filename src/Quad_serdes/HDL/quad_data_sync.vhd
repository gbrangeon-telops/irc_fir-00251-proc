-------------------------------------------------------------------------------
--
-- Title       : quad_data_sync
-- Design      : quad_intf_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\telops\FIR-00251-Proc\src\quad_serdes\HDL\quad_data_sync.vhd
-- Generated   : Wed May 27 09:14:02 2015
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description :

-- data_o (71:58)   :  misc_flags
-- data_o (57)      : frame_flag_sync
-- data_o (56)      : line_flag_sync
-- data_o (55:0)    : �chantillons des ADCs



--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity quad_data_sync is
   port(
      ARESET         : in std_logic;
      CLKD           : in std_logic; -- same as output clock of the iserdes
      DVAL_IN        : in std_logic; -- same as output clock of the iserdes
      D0             : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      D1             : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      D2             : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      D3             : in std_logic_vector(13 downto 0); -- parallel data from the iserdes (CLKD domain)
      CLK_DOUT       : in std_logic;
      SYNC_FLAG      : in std_logic_vector(15 downto 0); -- signaux de synchro � usage divers. (Peut d�poendre de chaque d�tecteur)
      Q              : out std_logic_vector(71 downto 0);-- CLK_DOUT domain
      DVAL           : out std_logic -- CLK_DOUT domain
      );
end quad_data_sync;

architecture rtl of quad_data_sync is
   
   constant C_FIFO_RDY_DLY  : natural := 1000;
   
   component double_sync is
      port(
         D : in std_logic;
         Q : out std_logic;
         RESET : in std_logic;
         CLK : in std_logic
         );
   end component; 
   
   component double_sync_vector is       -- ENO : 10 oct 2017: necessaire pour ce module
      port(
         D : in STD_LOGIC_vector;
         Q : out STD_LOGIC_vector;
         CLK : in STD_LOGIC
         );
   end component;
   
   component afifo_w72_d16 is
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
   
   signal sreset_clkout    : std_logic := '1';
   signal sreset_clkd      : std_logic := '1';
   signal dval_i, dval_out : std_logic;
   signal data_i, data_o   : std_logic_vector(Q'length-1 downto 0);
   signal sync_flag_i      : std_logic_vector(SYNC_FLAG'length-1 downto 0);
   
   signal full_i, empty_i  : std_logic;
   signal fifo_rdy         : std_logic;
   signal wr_rst_busy      : std_logic;
   signal rd_rst_busy      : std_logic;
   
   --   attribute keep : string;
   --   attribute keep of dval_out : signal is "true";
   --   attribute keep of data_o : signal is "true";
   
begin
   
   Q <= std_logic_vector(data_o);
   DVAL <= dval_out;
   
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
      
   sync_en : double_sync_vector  
   port map(
      D => SYNC_FLAG,
      Q => sync_flag_i,
      CLK => CLKD);   
   
   merge_proc : process(CLKD)
   begin
      if rising_edge(CLKD) then
         if sreset_clkd = '1' then
            dval_i <= '0';
         else
            if DVAL_IN = '1' and wr_rst_busy = '0' then
               dval_i <= '1';
            else
               dval_i <= '0';
            end if;
         end if;
         data_i <= sync_flag_i & D3 & D2 & D1 & D0;
      end if;
   end process;
   
   rd_proc : process(CLK_DOUT)
   begin
      if rising_edge(CLK_DOUT) then
         if sreset_clkout = '1' then
            fifo_rdy <= '0'; 
         else
            fifo_rdy <= not rd_rst_busy;    
         end if;
      end if;
   end process;
   
   fifo : afifo_w72_d16
   port map(
      rst => ARESET,
      wr_clk => CLKD,
      rd_clk => CLK_DOUT,
      din => data_i,
      wr_en => dval_i,
      rd_en => fifo_rdy,
      dout => data_o,
      full => full_i,
      almost_full => open,
      overflow => open,
      empty => empty_i,
      valid => dval_out,
      wr_rst_busy => wr_rst_busy,  
      rd_rst_busy => rd_rst_busy      
      );
   
end rtl;
