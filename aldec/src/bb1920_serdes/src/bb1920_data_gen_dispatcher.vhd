------------------------------------------------------------------
--!   @file : bb1920_data_gen_dispatcher
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
-- use work.FPA_define.all;
use work.fpa_common_pkg.all;
-- use work.proxy_define.all;


entity bb1920_data_gen_dispatcher is
   port(
      ARESET           : in std_logic;
      MCLK_SOURCE      : in std_logic;
      
      QUAD_DVAL        : in std_logic;
      QUAD_DATA        : in std_logic_vector(95 downto 0);
      QUAD_FVAL        : in std_logic;
      
      DUAL0_BYTE_MOSI0 : out t_ll_ext_mosi8;
      DUAL0_BYTE_MOSI1 : out t_ll_ext_mosi8;
      DUAL0_BYTE_MOSI2 : out t_ll_ext_mosi8;
      DUAL0_BYTE_MOSI3 : out t_ll_ext_mosi8;
      
      DUAL0_BYTE_MISO  : in t_ll_ext_miso;
      
      DUAL1_BYTE_MOSI0 : out t_ll_ext_mosi8;
      DUAL1_BYTE_MOSI1 : out t_ll_ext_mosi8;
      DUAL1_BYTE_MOSI2 : out t_ll_ext_mosi8;
      DUAL1_BYTE_MOSI3 : out t_ll_ext_mosi8;
      
      DUAL1_BYTE_MISO  : in t_ll_ext_miso;
      
      BYTE_DREM        : out std_logic_vector(3 downto 0)
      );
end bb1920_data_gen_dispatcher;


architecture rtl of bb1920_data_gen_dispatcher is 

signal fval_i           : std_logic;
signal lval_i           : std_logic;
signal quad_dval_i      : std_logic;
signal quad_dval_temp   : std_logic;
signal quad_data_temp   : std_logic_vector(95 downto 0);
signal quad_data_i      : std_logic_vector(95 downto 0);
signal ctrl_bits        : std_logic_vector(3 downto 0);

begin
   
   ---------------------------------------------------
   -- outputs maps
   ---------------------------------------------------
   
   BYTE_DREM <= x"8";
   
   -- pix3 byte1
   DUAL1_BYTE_MOSI3.SOF  <= quad_data_i(59);
   DUAL1_BYTE_MOSI3.EOF  <= quad_data_i(60);
   DUAL1_BYTE_MOSI3.DVAL <= quad_dval_i;
   DUAL1_BYTE_MOSI3.DATA <= quad_data_i(63) & quad_data_i(59) & quad_data_i(55) & quad_data_i(51) & quad_data_i(47) & quad_data_i(43) & quad_data_i(39) & quad_data_i(35);
   
   -- pix3 byte0
   DUAL1_BYTE_MOSI2.SOF  <= quad_data_i(59);
   DUAL1_BYTE_MOSI2.EOF  <= quad_data_i(60);
   DUAL1_BYTE_MOSI2.DVAL <= quad_dval_i;
   DUAL1_BYTE_MOSI2.DATA <= quad_data_i(62) & quad_data_i(58) & quad_data_i(54) & quad_data_i(50) & quad_data_i(46) & quad_data_i(42) & quad_data_i(38) & quad_data_i(34);
   
   -- pix2 byte1
   DUAL1_BYTE_MOSI1.SOF  <= quad_data_i(59);
   DUAL1_BYTE_MOSI1.EOF  <= quad_data_i(60);
   DUAL1_BYTE_MOSI1.DVAL <= quad_dval_i;
   DUAL1_BYTE_MOSI1.DATA <= quad_data_i(61) & quad_data_i(57) & quad_data_i(53) & quad_data_i(49) & quad_data_i(45) & quad_data_i(41) & quad_data_i(37) & quad_data_i(33);
   
   -- pix2 byte0
   DUAL1_BYTE_MOSI0.SOF  <= quad_data_i(59);
   DUAL1_BYTE_MOSI0.EOF  <= quad_data_i(60);
   DUAL1_BYTE_MOSI0.DVAL <= quad_dval_i;
   DUAL1_BYTE_MOSI0.DATA <= quad_data_i(60) & quad_data_i(56) & quad_data_i(52) & quad_data_i(48) & quad_data_i(44) & quad_data_i(40) & quad_data_i(36) & quad_data_i(32);
   
   -- pix1 byte1
   DUAL0_BYTE_MOSI3.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI3.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI3.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI3.DATA <= quad_data_i(31) & quad_data_i(27) & quad_data_i(23) & quad_data_i(19)& quad_data_i(15) & quad_data_i(11) & quad_data_i(7) & quad_data_i(3);
   
   -- pix1 byte0
   DUAL0_BYTE_MOSI2.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI2.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI2.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI2.DATA <= quad_data_i(30) & quad_data_i(26) & quad_data_i(22) & quad_data_i(18)& quad_data_i(14) & quad_data_i(10) & quad_data_i(6) & quad_data_i(2);
   
   -- pix0 byte1
   DUAL0_BYTE_MOSI1.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI1.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI1.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI1.DATA <= quad_data_i(29) & quad_data_i(25) & quad_data_i(21) & quad_data_i(17)& quad_data_i(13) & quad_data_i(9) & quad_data_i(5) & quad_data_i(1);
   
   -- pix0 byte0
   DUAL0_BYTE_MOSI0.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI0.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI0.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI0.DATA <= quad_data_i(28) & quad_data_i(24) & quad_data_i(20) & quad_data_i(16)& quad_data_i(12) & quad_data_i(8) & quad_data_i(4) & quad_data_i(0);
   ---------------------------------------------------
   -- inputs maps
   ---------------------------------------------------
   fval_i <= QUAD_DATA(58);
   lval_i <= QUAD_DATA(63); 
   
   
   U1: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         
         
         quad_data_temp     <= QUAD_DATA;
         quad_dval_temp     <= lval_i;
         
         if fval_i = '1' then 
            if lval_i = '1' then 
               ctrl_bits <= x"E";
            else
               ctrl_bits <= x"8";
            end if;
         else
            ctrl_bits <= x"3";
         end if;
         
         quad_data_i     <= quad_data_temp;
         quad_dval_i     <= not ARESET; -- quad_dval_temp;  -- on ecrit tout le temps à la sortie
         
         
         quad_data_i(31) <= ctrl_bits(3);
         quad_data_i(30) <= ctrl_bits(2);
         quad_data_i(29) <= ctrl_bits(1);
         quad_data_i(28) <= ctrl_bits(0);      
         
         quad_data_i(63) <= ctrl_bits(3);
         quad_data_i(62) <= ctrl_bits(2);
         quad_data_i(61) <= ctrl_bits(1);
         quad_data_i(60) <= ctrl_bits(0);
         
      end if;
   end process;
   
   
end rtl;
