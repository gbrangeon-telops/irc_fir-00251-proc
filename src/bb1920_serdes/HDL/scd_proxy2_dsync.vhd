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
      
      ARESET        : in std_logic;
      
      -- ch0  
      CH0_DCLK      : in std_logic;
      CH0_DUAL_DATA : in std_logic_vector(31 downto 0);
      CH0_DUAL_DVAL : in std_logic;
      
      -- ch1 
      CH1_DCLK      : in std_logic;
      CH1_DUAL_DATA : in std_logic_vector(31 downto 0);
      CH1_DUAL_DVAL : in std_logic;
      
      -- out
      QUAD_DCLK         : in std_logic;     
      QUAD_DATA : out std_logic_vector(71 downto 0);
      QUAD_DVAL     : out std_logic
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
   signal valid_CH0_DUAL_DVAL : std_logic;
   signal valid_CH1_DUAL_DVAL : std_logic;
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
   
   fifo_rd_en <= valid_CH0_DUAL_DVAL and valid_CH1_DUAL_DVAL; -- lecture synchronisée des 2 fifos tout le temps. 
   
   QUAD_DATA(71 downto 68) <= "0000";
   QUAD_DATA(67) <= reg_3(62);
   QUAD_DATA(66) <= fval_pixel;
   QUAD_DATA(65 downto 64) <= reg_3(61 downto 60);
   QUAD_DATA(63 downto 62) <= "00";
   QUAD_DATA(61 downto 48) <= reg_3(59 downto 46);
   QUAD_DATA(47 downto 46) <= "00";
   QUAD_DATA(45 downto 32) <= reg_3(45 downto 32);
   QUAD_DATA(31 downto 30) <= "00";
   QUAD_DATA(29 downto 16) <= reg_3(27 downto 14);
   QUAD_DATA(15 downto 14) <= "00";
   QUAD_DATA(13 downto 0) <= reg_3(13 downto 0);
   
   QUAD_DVAL <= fifo_rd_en;
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => QUAD_DCLK,
      SRESET => sreset
      );   
   
   fifo_ch0 : fwft_afifo_w32_d16
   Port map( 
      rst         => ARESET,
      wr_clk      => CH0_DCLK,
      rd_clk      => QUAD_DCLK,
      din         => CH0_DUAL_DATA,
      wr_en       => CH0_DUAL_DVAL,
      rd_en       => fifo_rd_en,
      dout        => fifo_ch0_dout,
      full        => open,
      overflow    => fifo_ch0_ovfl,
      empty       => open,
      valid       => valid_CH0_DUAL_DVAL,
      wr_rst_busy => open,
      rd_rst_busy => open);
   
   fifo_ch1 : fwft_afifo_w32_d16
   Port map( 
      rst         => ARESET,
      wr_clk      => CH1_DCLK,
      rd_clk      => QUAD_DCLK,
      din         => CH1_DUAL_DATA,
      wr_en       => CH1_DUAL_DVAL,
      rd_en       => fifo_rd_en,
      dout        => fifo_ch1_dout,
      full        => open,
      overflow    => fifo_ch1_ovfl,
      empty       => open,
      valid       => valid_CH1_DUAL_DVAL,
      wr_rst_busy => open,
      rd_rst_busy => open);
   
   shift_register : process(QUAD_DCLK)
   begin
      if rising_edge(QUAD_DCLK) then
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
   
   fval_pixel_creation : process(QUAD_DCLK)
   begin
      if rising_edge(QUAD_DCLK) then
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
