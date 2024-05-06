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
use work.proxy_define.all;


entity bb1920_data_gen_dispatcher is
   port(
      ARESET           : in std_logic;
      MCLK_SOURCE      : in std_logic;
   
      QUAD_DVAL        : in std_logic;
      QUAD_DATA        : in std_logic_vector(95 downto 0);
      QUAD_FVAL        : in std_logic;
	  
	  QUAD1_DVAL        : in std_logic;
      QUAD1_DATA        : in std_logic_vector(95 downto 0);
      QUAD1_FVAL        : in std_logic;
	  
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
	    	  
      DUAL2_BYTE_MOSI0 : out t_ll_ext_mosi8;
      DUAL2_BYTE_MOSI1 : out t_ll_ext_mosi8;
      DUAL2_BYTE_MOSI2 : out t_ll_ext_mosi8;
      DUAL2_BYTE_MOSI3 : out t_ll_ext_mosi8;
      
      DUAL2_BYTE_MISO  : in t_ll_ext_miso;
      
      DUAL3_BYTE_MOSI0 : out t_ll_ext_mosi8;
      DUAL3_BYTE_MOSI1 : out t_ll_ext_mosi8;
      DUAL3_BYTE_MOSI2 : out t_ll_ext_mosi8;
      DUAL3_BYTE_MOSI3 : out t_ll_ext_mosi8;
      
      DUAL3_BYTE_MISO  : in t_ll_ext_miso;
	  
	  
	  FPA_INTF_CFG     : in fpa_intf_cfg_type;
	  
      BYTE_DREM        : out std_logic_vector(3 downto 0)
      );
end bb1920_data_gen_dispatcher;


architecture rtl of bb1920_data_gen_dispatcher is  

   component sync_reset
   port (
      ARESET : in std_logic;
      CLK    : in std_logic;
      SRESET : out std_logic := '1'
      );
end component;

   signal fval_i           : std_logic;
   signal lval_i           : std_logic;
   signal quad_dval_i      : std_logic;
   signal quad_dval_temp   : std_logic;
   signal quad_data_temp   : std_logic_vector(95 downto 0);
   signal quad_data_i      : std_logic_vector(95 downto 0);	 
   signal quad1_dval_i      : std_logic;
   signal quad1_dval_temp   : std_logic;
   signal quad1_data_temp   : std_logic_vector(95 downto 0);
   signal quad1_data_i      : std_logic_vector(95 downto 0);
   signal ctrl_bits        : std_logic_vector(3 downto 0);
   signal binning_mode         : integer; 
   signal sreset               : std_logic;  
begin
   binning_mode <= to_integer(signed(FPA_INTF_CFG.op.binning));

   ---------------------------------------------------
   -- outputs maps
   ---------------------------------------------------
   
   BYTE_DREM <= x"8";

   ---------------------------------------------------
   -- inputs maps
   ---------------------------------------------------
   fval_i <= QUAD_DATA(58);
   lval_i <= QUAD_DATA(63);  
   
--   
--   DIAG_DATA(61)           <= aoi_dval_i;           -- aoi_dval          
--   DIAG_DATA(60)           <= aoi_eof_i;            -- eof
--   DIAG_DATA(59)           <= aoi_sof_i;            -- sof
--   DIAG_DATA(58)           <= aoi_fval_i;           -- fval
--   DIAG_DATA(57)           <= aoi_eol_i;            -- eol
--   DIAG_DATA(56)           <= aoi_sol_i;            -- sol
--
     -- pix11 byte1
   DUAL3_BYTE_MOSI3.SOL  <= quad1_data_i(56);                                                                                                                           
   DUAL3_BYTE_MOSI3.EOL  <= quad1_data_i(57);
   DUAL3_BYTE_MOSI3.SOF  <= quad1_data_i(59);                                                                                                                           
   DUAL3_BYTE_MOSI3.EOF  <= quad1_data_i(60); 
   DUAL3_BYTE_MOSI3.DVAL <= quad_dval_i;
   DUAL3_BYTE_MOSI3.DATA <= ctrl_bits(3)  & quad1_data_i(41) & quad1_data_i(37) & quad1_data_i(33) & quad1_data_i(29)& quad1_data_i(11) & quad1_data_i(7) & quad1_data_i(3);
   
   -- pix11 byte0                                                                                                                                                       
   DUAL3_BYTE_MOSI2.SOL  <= quad1_data_i(56);                                                                                                                           
   DUAL3_BYTE_MOSI2.EOL  <= quad1_data_i(57);
   DUAL3_BYTE_MOSI2.SOF  <= quad1_data_i(59);                                                                                                                           
   DUAL3_BYTE_MOSI2.EOF  <= quad1_data_i(60);                                                                                                                               
   DUAL3_BYTE_MOSI2.DVAL <= quad_dval_i;                                                                                                                               
   DUAL3_BYTE_MOSI2.DATA <= ctrl_bits(2)  & quad1_data_i(40) & quad1_data_i(36) & quad1_data_i(32) & quad1_data_i(28)& quad1_data_i(10) & quad1_data_i(6) & quad1_data_i(2);
   
   -- pix10 byte1                                                                                                                                                       
   DUAL3_BYTE_MOSI1.SOL  <= quad1_data_i(56);                                                                                                                           
   DUAL3_BYTE_MOSI1.EOL  <= quad1_data_i(57);
   DUAL3_BYTE_MOSI1.SOF  <= quad1_data_i(59);                                                                                                                           
   DUAL3_BYTE_MOSI1.EOF  <= quad1_data_i(60);                                                                                                                            
   DUAL3_BYTE_MOSI1.DVAL <= quad_dval_i;                                                                                                                               
   DUAL3_BYTE_MOSI1.DATA <= ctrl_bits(1) & quad1_data_i(39) & quad1_data_i(35) & quad1_data_i(31) & quad1_data_i(13)& quad1_data_i(9) & quad1_data_i(5) & quad1_data_i(1); 
   
   -- pix10 byte0
   DUAL3_BYTE_MOSI0.SOL  <= quad1_data_i(56);                                                                                                                           
   DUAL3_BYTE_MOSI0.EOL  <= quad1_data_i(57);
   DUAL3_BYTE_MOSI0.SOF  <= quad1_data_i(59);                                                                                                                           
   DUAL3_BYTE_MOSI0.EOF  <= quad1_data_i(60);                                                                                                                           
   DUAL3_BYTE_MOSI0.DVAL <= quad_dval_i;                                                                                                                               
   DUAL3_BYTE_MOSI0.DATA <= ctrl_bits(0)  & quad1_data_i(38) & quad1_data_i(34) & quad1_data_i(30) & quad1_data_i(12)& quad1_data_i(8) & quad1_data_i(4) & quad1_data_i(0); 
   ------
   -- pix13 byte1
   DUAL2_BYTE_MOSI3.SOL  <= quad1_data_i(56);
   DUAL2_BYTE_MOSI3.EOL  <= quad1_data_i(57);
   DUAL2_BYTE_MOSI3.SOF  <= quad1_data_i(59);
   DUAL2_BYTE_MOSI3.EOF  <= quad1_data_i(60);
   DUAL2_BYTE_MOSI3.DVAL <= quad_dval_i;
   DUAL2_BYTE_MOSI3.DATA <= ctrl_bits(3) & quad1_data_i(55) & quad1_data_i(51) & quad1_data_i(47) & quad1_data_i(43)& quad1_data_i(25) & quad1_data_i(21) & quad1_data_i(17);
  
   -- pix13 byte0
   DUAL2_BYTE_MOSI2.SOL  <= quad1_data_i(56);
   DUAL2_BYTE_MOSI2.EOL  <= quad1_data_i(57);
   DUAL2_BYTE_MOSI2.SOF  <= quad1_data_i(59);
   DUAL2_BYTE_MOSI2.EOF  <= quad1_data_i(60);
   DUAL2_BYTE_MOSI2.DVAL <= quad_dval_i;
   DUAL2_BYTE_MOSI2.DATA <= ctrl_bits(2) & quad1_data_i(54) & quad1_data_i(50) & quad1_data_i(46) & quad1_data_i(42)& quad1_data_i(24) & quad1_data_i(20) & quad1_data_i(16);
   
   -- pix11 byte1
   DUAL2_BYTE_MOSI1.SOL  <= quad1_data_i(56);
   DUAL2_BYTE_MOSI1.EOL  <= quad1_data_i(57);
   DUAL2_BYTE_MOSI1.SOF  <= quad1_data_i(59);
   DUAL2_BYTE_MOSI1.EOF  <= quad_data_i(60);
   DUAL2_BYTE_MOSI1.DVAL <= quad_dval_i;
   DUAL2_BYTE_MOSI1.DATA <=  ctrl_bits(1) & quad1_data_i(53) & quad1_data_i(49) & quad1_data_i(45) & quad1_data_i(27)& quad1_data_i(23) & quad1_data_i(19) & quad1_data_i(15);
   
   -- pix11 byte0
   DUAL2_BYTE_MOSI0.SOL  <= quad1_data_i(56);
   DUAL2_BYTE_MOSI0.EOL  <= quad1_data_i(57);
   DUAL2_BYTE_MOSI0.SOF  <= quad1_data_i(59);
   DUAL2_BYTE_MOSI0.EOF  <= quad1_data_i(60);
   DUAL2_BYTE_MOSI0.DVAL <= quad_dval_i;
   DUAL2_BYTE_MOSI0.DATA <=  ctrl_bits(0) & quad1_data_i(52) & quad1_data_i(48) & quad1_data_i(44) & quad1_data_i(26)& quad1_data_i(22) & quad1_data_i(18) & quad1_data_i(14); 
   
   -----------------------
   
   
  	   -- pix03 byte1
   DUAL1_BYTE_MOSI3.SOL  <= quad_data_i(56);                                                                                                                           
   DUAL1_BYTE_MOSI3.EOL  <= quad_data_i(57);
   DUAL1_BYTE_MOSI3.SOF  <= quad_data_i(59);                                                                                                                           
   DUAL1_BYTE_MOSI3.EOF  <= quad_data_i(60); 
   DUAL1_BYTE_MOSI3.DVAL <= quad_dval_i;
   DUAL1_BYTE_MOSI3.DATA <= ctrl_bits(3)  & quad_data_i(55) & quad_data_i(51) & quad_data_i(47) & quad_data_i(43)& quad_data_i(25) & quad_data_i(21) & quad_data_i(17);
   
   -- pix03 byte0                                                                                                                                                       
   DUAL1_BYTE_MOSI2.SOL  <= quad_data_i(56);                                                                                                                           
   DUAL1_BYTE_MOSI2.EOL  <= quad_data_i(57);
   DUAL1_BYTE_MOSI2.SOF  <= quad_data_i(59);                                                                                                                           
   DUAL1_BYTE_MOSI2.EOF  <= quad_data_i(60);                                                                                                                               
   DUAL1_BYTE_MOSI2.DVAL <= quad_dval_i;                                                                                                                               
   DUAL1_BYTE_MOSI2.DATA <= ctrl_bits(2)  & quad_data_i(54) & quad_data_i(50) & quad_data_i(46) & quad_data_i(42)& quad_data_i(24) & quad_data_i(20) & quad_data_i(16);
   
   -- pix01 byte1                                                                                                                                                       
   DUAL1_BYTE_MOSI1.SOL  <= quad_data_i(56);                                                                                                                           
   DUAL1_BYTE_MOSI1.EOL  <= quad_data_i(57);
   DUAL1_BYTE_MOSI1.SOF  <= quad_data_i(59);                                                                                                                           
   DUAL1_BYTE_MOSI1.EOF  <= quad_data_i(60);                                                                                                                            
   DUAL1_BYTE_MOSI1.DVAL <= quad_dval_i;                                                                                                                               
   DUAL1_BYTE_MOSI1.DATA <= ctrl_bits(1) & quad_data_i(53) & quad_data_i(49) & quad_data_i(45) & quad_data_i(27)& quad_data_i(23) & quad_data_i(19) & quad_data_i(15); 
   
   -- pix01 byte0
   DUAL1_BYTE_MOSI0.SOL  <= quad_data_i(56);                                                                                                                           
   DUAL1_BYTE_MOSI0.EOL  <= quad_data_i(57);
   DUAL1_BYTE_MOSI0.SOF  <= quad_data_i(59);                                                                                                                           
   DUAL1_BYTE_MOSI0.EOF  <= quad_data_i(60);                                                                                                                           
   DUAL1_BYTE_MOSI0.DVAL <= quad_dval_i;                                                                                                                               
   DUAL1_BYTE_MOSI0.DATA <= ctrl_bits(0)  & quad_data_i(52) & quad_data_i(48) & quad_data_i(44) & quad_data_i(26)& quad_data_i(22) & quad_data_i(18) & quad_data_i(14); 
   
   -- pix02 byte1
   DUAL0_BYTE_MOSI3.SOL  <= quad_data_i(56);
   DUAL0_BYTE_MOSI3.EOL  <= quad_data_i(57);
   DUAL0_BYTE_MOSI3.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI3.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI3.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI3.DATA <= ctrl_bits(3) & quad_data_i(41) & quad_data_i(37) & quad_data_i(33) & quad_data_i(29)& quad_data_i(11) & quad_data_i(7) & quad_data_i(3);
   
   -- pix02 byte0
   DUAL0_BYTE_MOSI2.SOL  <= quad_data_i(56);
   DUAL0_BYTE_MOSI2.EOL  <= quad_data_i(57);
   DUAL0_BYTE_MOSI2.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI2.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI2.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI2.DATA <= ctrl_bits(2) & quad_data_i(40) & quad_data_i(36) & quad_data_i(32) & quad_data_i(28)& quad_data_i(10) & quad_data_i(6) & quad_data_i(2);
   
   -- pix00 byte1
   DUAL0_BYTE_MOSI1.SOL  <= quad_data_i(56);
   DUAL0_BYTE_MOSI1.EOL  <= quad_data_i(57);
   DUAL0_BYTE_MOSI1.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI1.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI1.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI1.DATA <=  ctrl_bits(1) & quad_data_i(39) & quad_data_i(35) & quad_data_i(31) & quad_data_i(13)& quad_data_i(9) & quad_data_i(5) & quad_data_i(1);
   
   -- pix00 byte0
   DUAL0_BYTE_MOSI0.SOL  <= quad_data_i(56);
   DUAL0_BYTE_MOSI0.EOL  <= quad_data_i(57);
   DUAL0_BYTE_MOSI0.SOF  <= quad_data_i(59);
   DUAL0_BYTE_MOSI0.EOF  <= quad_data_i(60);
   DUAL0_BYTE_MOSI0.DVAL <= quad_dval_i;
   DUAL0_BYTE_MOSI0.DATA(0) <= quad_data_i(0); 
   DUAL0_BYTE_MOSI0.DATA(1) <= quad_data_i(4); 
   DUAL0_BYTE_MOSI0.DATA(2) <= quad_data_i(8); 
   DUAL0_BYTE_MOSI0.DATA(3) <= quad_data_i(12); 
   DUAL0_BYTE_MOSI0.DATA(4) <= quad_data_i(30); 
   DUAL0_BYTE_MOSI0.DATA(5) <= quad_data_i(34); 
   DUAL0_BYTE_MOSI0.DATA(6) <= quad_data_i(38); 
   DUAL0_BYTE_MOSI0.DATA(7) <=  ctrl_bits(0); 
   
   --ctrl_bits(0) & quad_data_i(38) & quad_data_i(34) & quad_data_i(30) & quad_data_i(12)& quad_data_i(8) & quad_data_i(4) & quad_data_i(0); 
     --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U2 : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => MCLK_SOURCE,
      SRESET => sreset
      );
      
	  
   U1: process(MCLK_SOURCE)
   begin
      if rising_edge(MCLK_SOURCE) then
         if sreset = '1' then  
		         quad_dval_temp     <= '0';
		         quad1_dval_temp    <= '0';	
				 quad_data_i <= (others => '0');  
				 quad1_data_i <= (others => '0');
				 ctrl_bits <=  (others => '0');
         else
	         if binning_mode = 0 then 
		         --quad_data_temp     <= QUAD_DATA;
		         quad_dval_temp     <= lval_i;
		         --quad1_data_temp     <= QUAD1_DATA;
		         quad1_dval_temp     <= lval_i;
		         if fval_i = '1' then 
		            if lval_i = '1' then 
		               ctrl_bits <= x"E";
		            else
		               ctrl_bits <= x"8";
		            end if;
		         else
		            ctrl_bits <= x"3";
		         end if;
		         
		         quad_data_i     <= QUAD_DATA;
		         quad_dval_i     <= not ARESET; -- quad_dval_temp;  -- on ecrit tout le temps à la sortie
		         quad1_data_i     <= QUAD1_DATA;
		         
		         --ctrl_bits(3);
		         --ctrl_bits(2);
			  else		 	
				  --ToDO
				quad_dval_i     <= not ARESET; -- quad_dval_temp;  -- on ecrit tout le temps à la sortie
		         --quad_data_temp     <= QUAD_DATA;
		         quad_dval_temp     <= lval_i;
		         --quad1_data_temp     <= QUAD1_DATA;
		         quad1_dval_temp     <= lval_i;
		         if fval_i = '1' then 
		            if lval_i = '1' then 
		               ctrl_bits <= x"E";
		            else
		               ctrl_bits <= x"8";
		            end if;
		         else
		            ctrl_bits <= x"3";
		         end if;
		         
		         quad_data_i     <= QUAD_DATA;
		         quad_dval_i     <= not ARESET; -- quad_dval_temp;  -- on ecrit tout le temps à la sortie
		         quad1_data_i     <= QUAD1_DATA;
			  end if;	  
		 
--         quad_data_i(63) <= ctrl_bits(3);
--         quad_data_i(62) <= ctrl_bits(2);
--         quad_data_i(61) <= ctrl_bits(1);
--         quad_data_i(60) <= ctrl_bits(0);
           end if;
      end if;
   end process;
   
   
end rtl;
