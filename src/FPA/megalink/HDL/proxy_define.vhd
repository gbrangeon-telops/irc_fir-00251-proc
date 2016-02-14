--******************************************************************************
-- Destination: 
--
--	File: Proxy_define.vhd
-- Hierarchy: Package file
-- Use: 
--	Project: IRCDEV
--	By: Edem Nofodjie
-- Date: 22 october 2009	  
--
--******************************************************************************
--Description
--******************************************************************************
-- 1- Defines the global variables 
-- 2- Defines the project function
--******************************************************************************


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
use work.fpa_common_pkg.all;
use work.fpa_define.all;  

package Proxy_define is       
   
   ----------------------------------------------
   -- Proxy 
   ---------------------------------------------- 
   constant PROXY_GAIN_0                 : std_logic_vector(7 downto 0) := x"00";
   constant PROXY_GAIN_1                 : std_logic_vector(7 downto 0) := x"02";
   constant PROXY_ITR                    : std_logic_vector(7 downto 0) := x"00";
   constant PROXY_IWR                    : std_logic_vector(7 downto 0) := x"01";
   constant PROXY_FSYNC_HIGH_TIME_US     : integer := 5;           -- duree de FSYNC en usec
   constant PROXY_POWER_WAIT_US          : integer := 1_000_000;   -- duree d'attente après allumage en usec. selon la doc, le proxy prend 1 sec. Pour plus de securité, j'en mets 2
   constant PROXY_TEMP_TRIG_PERIOD_US    : integer := 1_000_000;   -- le trig de lecture de la temperature a une periode de 1sec pour ne pas submerger le proxy
   constant PROXY_POWER_ON_RESET_US      : integer := 10;          -- 10 us pour la durée du reset au demarrage de la carte MGLK
   
   -- commandes
   constant PROXY_CMD_OVERHEAD_BYTES_NUM   : integer := 4;     -- nombre de bytes de l'overhead (cmdID, length)
   constant PROXY_LONGEST_CMD_BYTES_NUM    : integer := 128;   -- longueur maximale en byte de la config d'un mglk (incluant le header, checksum etc). Ce nombre doit être inférieur ou egale à 128 à cause d'un fifo dans le copieur
   constant PROXY_SERIAL_BAUD_RATE         : integer := 9_600  --9_600; -- baud rate utilisé pour Megalink mglk (utilisé juste pour generateur de delai)
   -- pragma translate_off
   *96  --921_600;                           -- 921_600 pour simulation
   -- pragma translate_on 
   ;
   constant PROXY_COM_RESP_SOF             : std_logic_vector(7 downto 0)  := x"40";  -- caractere '@'
   constant PROXY_COM_RESP_FAILURE_ID      : std_logic_vector(7 downto 0)  := x"4E";  -- caractere 'N'
   constant PROXY_COM_CMD_SOF              : std_logic_vector(7 downto 0)  := x"40";  -- caractere '@'
   constant PROXY_COM_RESP_SUCCESS_ID      : std_logic_vector(7 downto 0)  := x"59";  -- caractere 'Y'
   
   -- serial int time cmd (bâtie par ENO car n'existe pas en réalité dans le doc du Megalink)
   -- cette commande est montée de toute pièce par ENO.
   -- elle permet d'envoyer les parametres statiques au megalink
   constant PROXY_STATIC_CMD_ID            : std_logic_vector(15 downto 0) := x"C000";
   constant PROXY_INT_CMD_ID               : std_logic_vector(15 downto 0) := x"C001";
   constant PROXY_DIAG_CMD_ID              : std_logic_vector(15 downto 0) := x"C002";   
   constant PROXY_WINDW_CMD_ID             : std_logic_vector(15 downto 0) := x"C003";
   constant PROXY_TEMP_CMD_ID              : std_logic_vector(15 downto 0) := x"C004";
   constant PROXY_OP_CMD_ID                : std_logic_vector(15 downto 0) := x"C005";
   --constant PROXY_MISC_CMD_ID              : std_logic_vector(15 downto 0) := x"C006";
   --constant COMN_CMD_ID                    : std_logic_vector(15 downto 0) := x"C00F";
   
   -- partition de la ram de cfg serielle (la partie d'ecriture reservée à la config serielle a une plage d'adresse < 255)
   constant PROXY_STATIC_CMD_RAM_BASE_ADD  : integer  := 0;  
   constant PROXY_INT_CMD_RAM_BASE_ADD     : integer  := 128;      -- adresse de base où est logée la commande du temps d'integration en ram
   constant PROXY_DIAG_CMD_RAM_BASE_ADD    : integer  := 168;
   constant PROXY_WINDW_CMD_RAM_BASE_ADD   : integer  := 208;
   constant PROXY_TEMP_CMD_RAM_BASE_ADD    : integer  := 338;
   constant PROXY_OP_CMD_RAM_BASE_ADD      : integer  := 378;      -- adresse de base où est logée la commande operationnelle en ram
   
   -- adresse de base de la zone securisée
   constant PROXY_CMD_SECUR_RAM_BASE_ADD   : integer  := 1024; -- adresse où se retrouve la commande copiée dans la zone securisee
   
   -- quelques constantes 
   constant SERIAL_CFG_END_ADD             : std_logic_vector(15 downto 0) := x"0FFC"; -- adresse de fin d'envoi de la config serielle
   constant SERIAL_CFG_COPIER_START_DLY    : integer := 10; -- delai ajusté par simulation pour eviter corruption de config dans la RAM
   constant SERIAL_CFG_COPIER_END_DLY      : integer := 10; -- delai ajusté par simulation pour eviter corruption de config dans la RAM
   
   ----------------------------------------------
   -- Calculs 
   ---------------------------------------------- 
   constant PROXY_FSYNC_HIGH_TIME_FACTOR     : integer := integer((FPA_INTF_CLK_RATE_HZ/1000000)*PROXY_FSYNC_HIGH_TIME_US);
   constant PROXY_POWER_WAIT_FACTOR          : integer := integer((FPA_INTF_CLK_RATE_HZ/1000000)*PROXY_POWER_WAIT_US);
   constant PROXY_POWER_ON_RESET_FACTOR      : integer := integer((FPA_INTF_CLK_RATE_HZ/1000000)*PROXY_POWER_ON_RESET_US);
   constant PROXY_SERIAL_TX_CLK_FACTOR       : integer := integer((FPA_INTF_CLK_RATE_HZ)/PROXY_SERIAL_BAUD_RATE); -- utilisé juste pour generateur de delai
   constant PROXY_OP_INT_TIME_DEFAULT_FACTOR : integer := integer((FPA_INTF_CLK_RATE_HZ/1000000)*(2*FPA_INT_TIME_MIN_NS))/1000; --
   constant PROXY_TEMP_TRIG_PERIOD_FACTOR    : integer := integer((FPA_INTF_CLK_RATE_HZ/1000000)*PROXY_TEMP_TRIG_PERIOD_US);
   constant FPA_MCLK_RATE_FACTOR             : integer := integer(FPA_INTF_CLK_RATE_HZ/FPA_MCLK_RATE_HZ);
   constant FPA_INT_TIME_MIN_FACTOR          : integer := integer((real(FPA_INT_TIME_MIN_NS)*real(FPA_INTF_CLK_RATE_HZ)/1_000_000_000.0));
   constant PROXY_LVAL_TIMEOUT_FACTOR        : integer := integer(MGLK_LVAL_TIMEOUT_MCLK*FPA_INTF_CLK_RATE_HZ/FPA_MCLK_RATE_HZ);
   
   -- pour convertir le temps d'integration en coups de 100MHz vers les coups de MCLK
   constant PROXY_EXP_TIME_CONV_DENOMINATOR_BIT_POS : natural := 26;  -- log2 de PROXY_EXP_TIME_CONV_DENOMINATOR  
   constant PROXY_EXP_TIME_CONV_DENOMINATOR  : integer := 2**PROXY_EXP_TIME_CONV_DENOMINATOR_BIT_POS;
   constant PROXY_EXP_TIME_CONV_NUMERATOR    : unsigned(PROXY_EXP_TIME_CONV_DENOMINATOR_BIT_POS-1 downto 0):= to_unsigned(integer(real(FPA_MCLK_RATE_HZ)*(real(2**PROXY_EXP_TIME_CONV_DENOMINATOR_BIT_POS)/real(FPA_INTF_CLK_RATE_HZ))), PROXY_EXP_TIME_CONV_DENOMINATOR_BIT_POS);     -- (4MHz x 2^26 )/100MHz
   
   constant FPA_XTRA_IMAGE_NUM_TO_SKIP : integer := 3; -- on doit laisser une image dès qu'on change le frameRate car le changement de framerate s'opere toujours en temps d'integration minimale pour ne pas planter mon code
   
   --------------------------------------------------------------------------------								
   -- Configuration regroupant les éléments vraiment propres au détecteur
   ---------------------------------------------------------------------------------
   -- mglk integration
   type proxy_int_cfg_type is
   record
      proxy_int_time            : unsigned(23 downto 0);  --! temps d'integration en coups de FPA_MCLK
      proxy_int_indx            : std_logic_vector(7 downto 0);
   end record;
   
   -- mglk video synthetic
   type proxy_diag_cfg_type is
   record
      proxy_test_pattern_activ  : std_logic; -- '0' mode normal., '1' mode diag du proxy
   end record;
   
   -- mglk windowing command
   type proxy_windw_cfg_type is
   record  
      proxy_x1min               : unsigned(10 downto 0); 
      proxy_y1min               : unsigned(10 downto 0);
      proxy_x1max               : unsigned(10 downto 0);
      proxy_y1max               : unsigned(10 downto 0);
      proxy_xsize               : unsigned(10 downto 0);
      proxy_ysize               : unsigned(10 downto 0);
   end record;
   
   -- mglk operational command
   type proxy_op_cfg_type is
   record  
      proxy_gpol_mv             : unsigned(15 downto 0);
      proxy_gain                : std_logic_vector(7 downto 0);   -- Gains
      proxy_int_mode            : std_logic_vector(7 downto 0);   -- ITR, IWR  
   end record;
   
   -- mglk temperature
   type proxy_temp_cfg_type is
   record
      proxy_temp_read_num       : unsigned(7 downto 0);
   end record; 
   
   -- mglk statique
   type proxy_static_cfg_type is
   record
      proxy_static_cmd_num      : unsigned(7 downto 0);
   end record; 
   
   -- mglk misc                 --  quelques valeurs propres au mglk LW. Elles sont utilisées en mode diag  
   -- Pour les definitionf ds termes, voir fichier dans le dossier \FIR-00251-Proc\src\FPA\Megalink\Doc\                          
   type proxy_misc_cfg_type is
   record
      proxy_fig2_t6_dly         : unsigned(15 downto 0);
      proxy_fig4_t1_dly         : unsigned(15 downto 0);
      proxy_fig4_t2_dly         : unsigned(15 downto 0);
      proxy_fig4_t6_dly         : unsigned(15 downto 0);
      proxy_fig4_t3_dly         : unsigned(15 downto 0);
      proxy_fig4_t5_dly         : unsigned(15 downto 0);
      proxy_fig4_t4_dly         : unsigned(15 downto 0);
      proxy_fig2_t5_dly         : unsigned(15 downto 0);
      proxy_fig2_t4_dly         : unsigned(15 downto 0);
      proxy_xsize_div2          : unsigned(9 downto 0);
   end record;
   
   ------------------------------------------------								
   -- Configuration du Bloc FPA_interface
   ------------------------------------------------
   type fpa_intf_cfg_type is
   record     
      cmd_to_update_id : std_logic_vector(15 downto 0); -- cet ide permet de saoir quelle partie de la commande rentrante est à mettre à jour. Important pour regler bugs
      comn             : fpa_comn_cfg_type;     -- partie commune (utilisée par les modules communs)      
      proxy_diag       : proxy_diag_cfg_type;   -- tout changement dans proxy_diag entraine la programmation du detecteur (commnde PE Syntehtique) 
      proxy_windw      : proxy_windw_cfg_type;  -- tout changement dans proxy_diag entraine la programmation du detecteur (commnde PE Syntehtique)
      proxy_op         : proxy_op_cfg_type;     -- tout changement dans proxy_op entraine la programmation du detecteur (commnde operationnelle)
      proxy_misc       : proxy_misc_cfg_type;   -- les changements dans proxy_misc ne font pas programmer le detecteur      
      proxy_int        : proxy_int_cfg_type;    -- tout changement dans proxy_int entraine la programmation du detecteur (commnde temps d'intégration)
      proxy_temp       : proxy_temp_cfg_type;   -- tout changement dans proxy_temp entraine la programmation du detecteur (commnde temperature read)
      proxy_static     : proxy_static_cfg_type; -- tout changement dans proxy_temp entraine la programmation du detecteur (commnde temperature read)
      
   end record;
   
   ----------------------------------------------								
   -- Type hder_param
   ----------------------------------------------
   type hder_param_type is
   record
      exp_time            : unsigned(31 downto 0);         -- temps d'integration en coups de 100 MHz
      frame_id            : unsigned(31 downto 0);
      sensor_temp_raw     : std_logic_vector(15 downto 0);
      exp_index           : unsigned(7 downto 0);
      rdy                 : std_logic;                     -- pulse signifiant que les parametres du header sont prêts
   end record;
   
   
   ----------------------------------------------	
   --Constantes pour le CRC16                             
   ----------------------------------------------  
   type crcTableType is array (0 to 8*32-1) of unsigned(15 downto 0);
   constant crcTable : crcTableType := (
   x"0000", x"C0C1", x"C181", x"0140", x"C301", x"03C0", x"0280", x"C241",
   x"C601", x"06C0", x"0780", x"C741", x"0500", x"C5C1", x"C481", x"0440",
   x"CC01", x"0CC0", x"0D80", x"CD41", x"0F00", x"CFC1", x"CE81", x"0E40",
   x"0A00", x"CAC1", x"CB81", x"0B40", x"C901", x"09C0", x"0880", x"C841",
   x"D801", x"18C0", x"1980", x"D941", x"1B00", x"DBC1", x"DA81", x"1A40",
   x"1E00", x"DEC1", x"DF81", x"1F40", x"DD01", x"1DC0", x"1C80", x"DC41",
   x"1400", x"D4C1", x"D581", x"1540", x"D701", x"17C0", x"1680", x"D641",
   x"D201", x"12C0", x"1380", x"D341", x"1100", x"D1C1", x"D081", x"1040",
   x"F001", x"30C0", x"3180", x"F141", x"3300", x"F3C1", x"F281", x"3240",
   x"3600", x"F6C1", x"F781", x"3740", x"F501", x"35C0", x"3480", x"F441",
   x"3C00", x"FCC1", x"FD81", x"3D40", x"FF01", x"3FC0", x"3E80", x"FE41",
   x"FA01", x"3AC0", x"3B80", x"FB41", x"3900", x"F9C1", x"F881", x"3840",
   x"2800", x"E8C1", x"E981", x"2940", x"EB01", x"2BC0", x"2A80", x"EA41",
   x"EE01", x"2EC0", x"2F80", x"EF41", x"2D00", x"EDC1", x"EC81", x"2C40",
   x"E401", x"24C0", x"2580", x"E541", x"2700", x"E7C1", x"E681", x"2640",
   x"2200", x"E2C1", x"E381", x"2340", x"E101", x"21C0", x"2080", x"E041",
   x"A001", x"60C0", x"6180", x"A141", x"6300", x"A3C1", x"A281", x"6240",
   x"6600", x"A6C1", x"A781", x"6740", x"A501", x"65C0", x"6480", x"A441",
   x"6C00", x"ACC1", x"AD81", x"6D40", x"AF01", x"6FC0", x"6E80", x"AE41",
   x"AA01", x"6AC0", x"6B80", x"AB41", x"6900", x"A9C1", x"A881", x"6840",
   x"7800", x"B8C1", x"B981", x"7940", x"BB01", x"7BC0", x"7A80", x"BA41",
   x"BE01", x"7EC0", x"7F80", x"BF41", x"7D00", x"BDC1", x"BC81", x"7C40",
   x"B401", x"74C0", x"7580", x"B541", x"7700", x"B7C1", x"B681", x"7640",
   x"7200", x"B2C1", x"B381", x"7340", x"B101", x"71C0", x"7080", x"B041",
   x"5000", x"90C1", x"9181", x"5140", x"9301", x"53C0", x"5280", x"9241",
   x"9601", x"56C0", x"5780", x"9741", x"5500", x"95C1", x"9481", x"5440",
   x"9C01", x"5CC0", x"5D80", x"9D41", x"5F00", x"9FC1", x"9E81", x"5E40",
   x"5A00", x"9AC1", x"9B81", x"5B40", x"9901", x"59C0", x"5880", x"9841",
   x"8801", x"48C0", x"4980", x"8941", x"4B00", x"8BC1", x"8A81", x"4A40",
   x"4E00", x"8EC1", x"8F81", x"4F40", x"8D01", x"4DC0", x"4C80", x"8C41",
   x"4400", x"84C1", x"8581", x"4540", x"8701", x"47C0", x"4680", x"8641",
   x"8201", x"42C0", x"4380", x"8341", x"4100", x"81C1", x"8081", x"4040" );
   
   ----------------------------------------------								
   -- Type diag_data_ofs_type
   ----------------------------------------------
   --type diag_data_ofs_type is array (1 to 9) of natural range 0 to ((2**16)*9)/XSIZE_MAX; -- (1 to 9) pour accommoder 4 ou 8 taps
   
   
   ----------------------------------------------
   -- quues fontions                                    
   ----------------------------------------------
   function hex_to_ascii_func(a:std_logic_vector(3 downto 0)) return character;
   function ascii_to_hex_func(a:std_logic_vector(7 downto 0)) return std_logic_vector;
   function reverse_bit_func(a:std_logic_vector) return std_logic_vector;
   --function to_fpa_word_func(a:fpa_intf_cfg_type) return fpa_word_type;
   
end Proxy_define;

package body Proxy_define is
   
   ---
   function hex_to_ascii_func(a:std_logic_vector(3 downto 0)) return character is
      variable y  : character;    
   begin
      case a is 
         when x"0" => y := '0';
         when x"1" => y := '1';
         when x"2" => y := '2';
         when x"3" => y := '3';
         when x"4" => y := '4';
         when x"5" => y := '5';
         when x"6" => y := '6';
         when x"7" => y := '7';
         when x"8" => y := '8';
         when x"9" => y := '9';
         when x"A" => y := 'A';
         when x"B" => y := 'B';
         when x"C" => y := 'C';
         when x"D" => y := 'D';
         when x"E" => y := 'E';
         when x"F" => y := 'F';
         when others =>
      end case;
      return y;                 
   end hex_to_ascii_func; 
   
   function ascii_to_hex_func(a:std_logic_vector(7 downto 0))return std_logic_vector is
      variable y  : std_logic_vector(3 downto 0);    
   begin
      case a is 
         when x"30" => y := x"0";
         when x"31" => y := x"1";
         when x"32" => y := x"2";
         when x"33" => y := x"3";
         when x"34" => y := x"4";
         when x"35" => y := x"5";
         when x"36" => y := x"6";
         when x"37" => y := x"7";
         when x"38" => y := x"8";
         when x"39" => y := x"9";
         when x"41" => y := x"A";
         when x"42" => y := x"B";
         when x"43" => y := x"C";
         when x"44" => y := x"D";
         when x"45" => y := x"E";
         when x"46" => y := x"F";
         when others => y := x"0";
      end case;
      return y;                 
   end ascii_to_hex_func;
   
   function reverse_bit_func(a:std_logic_vector) return std_logic_vector is
      variable y  : std_logic_vector(a'length-1 downto 0);    
   begin
      for ii in 0 to a'length-1 loop
         y(ii) := a(a'length-1 - ii);
      end loop;
      return y;                 
   end reverse_bit_func;   
   
end package body Proxy_define; 
