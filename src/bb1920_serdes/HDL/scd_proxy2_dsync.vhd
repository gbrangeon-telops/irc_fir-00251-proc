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

entity scd_proxy2_dsync is
   port(
		CLK_CH0 : in std_logic;
      CLK_CH1 : in std_logic;
      D_CLK : in std_logic;
		ARESET : in std_logic;
		 
		CH0_DATA : in std_logic_vector(31 downto 0);
      CH0_DVAL : in std_logic;
      CH1_DATA : in std_logic_vector(31 downto 0);
      CH1_DVAL : in std_logic;
      
      QUAD_DATA_OUT : out std_logic_vector(71 downto 0);
	   QUAD_DVAL : out std_logic
      );
end scd_proxy2_dsync;



architecture scd_proxy2_dsync of scd_proxy2_dsync is  
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;

   component fwft_afifo_w32_d16 is
      Port ( 
         rst : in STD_LOGIC;
         wr_clk : in STD_LOGIC;
         rd_clk : in STD_LOGIC;
         din : in STD_LOGIC_VECTOR ( 31 downto 0 );
         wr_en : in STD_LOGIC;
         rd_en : in STD_LOGIC;
         dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
         full : out STD_LOGIC;
         overflow : out STD_LOGIC;
         empty : out STD_LOGIC;
         valid : out STD_LOGIC;
         wr_rst_busy : out STD_LOGIC;
         rd_rst_busy : out STD_LOGIC);
   end component;
   
   signal sreset : std_logic;
   signal fifo_rd_en : std_logic;
   signal valid_ch0_dval : std_logic;
   signal valid_ch1_dval : std_logic;
   signal fifo_ch0_dout : std_logic_vector(31 downto 0);
   signal fifo_ch1_dout : std_logic_vector(31 downto 0);
   signal fifo_ch0_ovfl : std_logic;
   signal fifo_ch1_ovfl : std_logic;
   
   signal reg_0 : std_logic_vector(63 downto 0);
   signal reg_1 : std_logic_vector(63 downto 0);
   signal reg_2 : std_logic_vector(63 downto 0);
   signal reg_3 : std_logic_vector(63 downto 0);
   signal fval_pixel : std_logic;         
   signal quad_dval_i : std_logic;
   
begin
   
   fifo_rd_en <= valid_ch0_dval and valid_ch1_dval; -- lecture synchronisée des 2 fifos tout le temps. 
   QUAD_DATA_OUT(71 downto 68) <= "0000";
   QUAD_DATA_OUT(67) <= reg_3(62);
   QUAD_DATA_OUT(66) <= fval_pixel;
   QUAD_DATA_OUT(65 downto 64) <= reg_3(61 downto 60);
   QUAD_DATA_OUT(63 downto 62) <= "00";
   QUAD_DATA_OUT(61 downto 48) <= reg_3(59 downto 46);
   QUAD_DATA_OUT(47 downto 46) <= "00";
   QUAD_DATA_OUT(45 downto 32) <= reg_3(45 downto 32);
   QUAD_DATA_OUT(31 downto 30) <= "00";
   QUAD_DATA_OUT(29 downto 16) <= reg_3(27 downto 14);
   QUAD_DATA_OUT(15 downto 14) <= "00";
   QUAD_DATA_OUT(13 downto 0) <= reg_3(13 downto 0);
   
   QUAD_DVAL <= fifo_rd_en;
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => D_CLK,
      SRESET => sreset
      );   
	  
	fifo_ch0 : fwft_afifo_w32_d16
  Port map( 
    rst => ARESET,
    wr_clk => CLK_CH0,
    rd_clk => D_CLK,
    din => CH0_DATA,
    wr_en => CH0_DVAL,
    rd_en => fifo_rd_en,
	dout => fifo_ch0_dout,
    full => open,
    overflow => fifo_ch0_ovfl,
    empty => open,
    valid => valid_ch0_dval,
    wr_rst_busy => open,
      rd_rst_busy => open);
   
	fifo_ch1 : fwft_afifo_w32_d16
  Port map( 
    rst => ARESET,
    wr_clk => CLK_CH1,
    rd_clk => D_CLK,
    din => CH1_DATA,
    wr_en => CH1_DVAL,
    rd_en => fifo_rd_en,
	dout => fifo_ch1_dout,
    full => open,
    overflow => fifo_ch1_ovfl,
    empty => open,
    valid => valid_ch1_dval,
    wr_rst_busy => open,
    rd_rst_busy => open);

   shift_register : process(D_CLK)
   begin
      if rising_edge(D_CLK) then
         if sreset = '1' then
            reg_0 <= (others => '0');
            reg_1 <= (others => '0');
            reg_2 <= (others => '0');
            reg_3 <= (others => '0');
         else
            if fifo_rd_en = '1' then
               reg_0 <= fifo_ch1_dout & fifo_ch0_dout;
               reg_1 <= reg_0;
               reg_2 <= reg_1;
               reg_3 <= reg_2;
            else
               reg_0 <= reg_0;
               reg_1 <= reg_1;
               reg_2 <= reg_2;
               reg_3 <= reg_3;
            end if;
            quad_dval_i <= fifo_rd_en;
         end if;
      end if;
   end process shift_register;
   
   fval_pixel_creation : process(D_CLK)
   begin
      if rising_edge(D_CLK) then
         if sreset = '1' then
            fval_pixel <= '0';
         else
            --Si on a un pixel suivi d'une fin d'image 4 packet plus tard (fin de fval_pixel)      
            --28 is dval, 30 is fval
            if reg_3(28) = '1' and reg_0(30) = '0' then
               fval_pixel <= '0';
            --Si on a une image débuté et un pixel ensuite (debut de fval_pixel)
            elsif reg_3(30) = '1' and reg_2(28) = '1' then
               fval_pixel <= '1';
            else  
               fval_pixel <= fval_pixel;
            end if;
         end if;
      end if;
   end process fval_pixel_creation;
   
end scd_proxy2_dsync;
