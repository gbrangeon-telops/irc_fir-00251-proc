--******************************************************************************
-- Destination: 
--
--	File: hder_define.vhd
-- Hierarchy: Package file
-- Use: 
--	Project: tel-2000
--	By: Edem Nofodjie
-- Date: 06 fevrier 2010	  
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


package hder_define is    	  
   
   
   constant FAST_HDER_CLIENT_NUMBER          : natural := 7; -- les entités pouvant envoyer des fast headers sont : Fpa_intf, trig_gen, filterWheel, EHDRI, Calibration, flagging, ADC readout
  -- constant ACTIVE_FAST_HDER_CLIENT_NUMBER   : natural := 2; --  07 fev2014: Pour la version alpha, les entités envoyant effectivement des fast headers sont : Fpa_intf, trig_gen.
   constant ALEN                             : integer := 6; -- largeur du bus d'adresse des données fast du header; 
   constant FAST_HDER_EOF_CODE               : std_logic_vector(15 downto 0) := x"FFFF"; -- code de reconnaissance de fin d'envoi de trame header fast
   constant ALEN_M1                          : integer := ALEN - 1; -- calcul   
   -----------------------------------------------------							
   -- parametres de config 
   -------------------------------------------------------
   type hder_insert_cfg_type is
   record    
      eff_hder_len            : unsigned(7 downto 0);  -- taille pertinente/effective du HDER (sans zero padd)en pixels
      zero_pad_len            : unsigned(12 downto 0); -- taille du zero padd en pixels 
      hder_len                : unsigned(12 downto 0); -- longueur totale du HDER en pixels(depend de SizeX et SizeY)
      eff_hder_len_div2_m1    : unsigned(6 downto 0);
      zero_pad_len_div2_m1    : unsigned(11 downto 0);      
      need_padding            : std_logic;	-- need padding
      hder_tlast_en           : std_logic;   -- à '1' si le header doit être terminé par un TLAST ou pas lors de l'envoi 
      --run                     : std_logic;   -- run ou stop
   end record hder_insert_cfg_type;
   
   signal s_hder_insert_cfg : hder_insert_cfg_type;
   
   constant hder_insert_cfg_default : hder_insert_cfg_type := (
   to_unsigned(64,s_hder_insert_cfg.eff_hder_len'length),
   to_unsigned(0,s_hder_insert_cfg.zero_pad_len'length),
   to_unsigned(0,s_hder_insert_cfg.hder_len'length),
   to_unsigned(0,s_hder_insert_cfg.eff_hder_len_div2_m1'length),
   to_unsigned(0,s_hder_insert_cfg.zero_pad_len_div2_m1'length),
   '0',
   '0'
   --'0'
   ); 
   
end hder_define; 




package body hder_define is
   
end package body hder_define; 
