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
      
      DIN_DVAL      : in std_logic;
      DIN           : in std_logic_vector(71 downto 0);
      DIN_CLK       : in std_logic;
      
      DOUT_CLK      : in std_logic;
      DOUT_DVAL     : out std_logic;
      DOUT          : out std_logic_vector(71 downto 0)
      );
end scd_proxy2_dsync;



architecture scd_proxy2_dsync of scd_proxy2_dsync is  
   
   component fwft_afifo_wr72_rd72_d512 is
      Port ( 
         rst : in STD_LOGIC;
         wr_clk : in STD_LOGIC;
         rd_clk : in STD_LOGIC;
         din : in STD_LOGIC_VECTOR ( 71 downto 0 );
         wr_en : in STD_LOGIC;
         rd_en : in STD_LOGIC;
         dout : out STD_LOGIC_VECTOR ( 71 downto 0 );
         full : out STD_LOGIC;
         empty : out STD_LOGIC;
         valid : out STD_LOGIC
         );
   end component;	
   
   signal full : std_logic;
   signal empty : std_logic;
   signal valid : std_logic;
   signal rd_en : std_logic;
   
begin
   
   rd_en <= not(empty);  
   DOUT_DVAL <= rd_en and valid;
   
   fifo: fwft_afifo_wr72_rd72_d512
   port map ( 
      rst 	=> ARESET,
      wr_clk  => DIN_CLK,
      rd_clk  => DOUT_CLK,
      din 	=> DIN,
      wr_en 	=> DIN_DVAL,
      rd_en   => rd_en,
      dout    => DOUT,
      full 	=> full,
      empty   => empty,
      valid   => valid);
   
end scd_proxy2_dsync;
