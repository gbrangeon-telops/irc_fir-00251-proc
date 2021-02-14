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
   DUAL1_BYTE_MOSI3.DATA <= quad_data_i(63) & quad_data_i(62 downto 56);
   
   -- pix3 byte0
   DUAL1_BYTE_MOSI2.SOF  <= quad_data_i(59);
   DUAL1_BYTE_MOSI2.EOF  <= quad_data_i(60);
   DUAL1_BYTE_MOSI2.DVAL <= quad_dval_i;
   DUAL1_BYTE_MOSI2.DATA <= quad_data_i(55) & quad_data_i(54 downto 48);
   
   -- pix2 byte1
   DUAL1_BYTE_MOSI1.SOF  <= quad_data_i(59);
   DUAL1_BYTE_MOSI1.EOF  <= quad_data_i(60);
   DUAL1_BYTE_MOSI1.DVAL <= quad_dval_i;
   DUAL1_BYTE_MOSI1.DATA <= quad_data_i(47) & quad_data_i(46 downto 40);
   
   -- pix2 byte0
   DUAL1_BYTE_MOSI0.SOF  <= quad_data_i(59);
   DUAL1_BYTE_MOSI0.EOF  <= quad_data_i(60);
   DUAL1_BYTE_MOSI0.DVAL <= quad_dval_i;
   DUAL1_BYTE_MOSI0.DATA <= quad_data_i(39) & quad_data_i(38 downto 32);
   
   -- pix1 byte1
   DUAL0_BYTE_MOSI3.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI3.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI3.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI3.DATA <= quad_data_i(31) & quad_data_i(30 downto 24);
   
   -- pix1 byte0
   DUAL0_BYTE_MOSI2.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI2.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI2.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI2.DATA <= quad_data_i(23) & quad_data_i(22 downto 16);
   
   -- pix0 byte1
   DUAL0_BYTE_MOSI1.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI1.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI1.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI1.DATA <= quad_data_i(15) & quad_data_i(14 downto 8);
   
   -- pix0 byte0
   DUAL0_BYTE_MOSI0.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI0.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI0.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI0.DATA <= quad_data_i(7) & quad_data_i(6 downto 0);
   
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
         quad_dval_i     <= quad_dval_temp;
         
         
         quad_data_i(31) <= ctrl_bits(3);
         quad_data_i(23) <= ctrl_bits(2);
         quad_data_i(15) <= ctrl_bits(1);
         quad_data_i(7)  <= ctrl_bits(0);      
         
         quad_data_i(63) <= ctrl_bits(3);
         quad_data_i(55) <= ctrl_bits(2);
         quad_data_i(47) <= ctrl_bits(1);
         quad_data_i(39) <= ctrl_bits(0);
         
      end if;
   end process;
   
   
end rtl;
