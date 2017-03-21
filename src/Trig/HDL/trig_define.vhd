--******************************************************************************
-- Destination: 
--
--	File: trig_ctrl_define.vhd
-- Hierarchy: Package file
-- Use: 
--	Project: TEL-2000
--	By: Edem Nofodjie
-- Date: 03 fevrier 2013	  
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
use work.tel2000.all; 

package trig_define is    	  
   
   -- les differents modes d'operation du controleur
   constant INTTRIG                : std_logic_vector(7 downto 0) := x"00";  -- trig interne
   constant EXTTRIG                : std_logic_vector(7 downto 0) := x"01";  -- trig externe
   constant SINGLE_TRIG            : std_logic_vector(7 downto 0) := x"02";  -- un seul trig (mode speciale calibration) 
   constant SFW_TRIG               : std_logic_vector(7 downto 0) := x"03";  -- trig quand un nouveau filtre spectral est valide sur le FPA
   constant SEQ_TRIG               : std_logic_vector(7 downto 0) := x"04";  -- trig de sequence
   constant GATING                 : std_logic_vector(7 downto 0) := x"05";  -- gating des trigs internes
   
   -- Mapping des types d'activation du Trig: doit etre rigoureusement les valeurs dans le fichier trig.h
   constant RisingEdge             : std_logic_vector(7 downto 0) := x"00";   -- TriggerActivation  sur  RisingEdge  
   constant FallingEdge            : std_logic_vector(7 downto 0) := x"01";
   constant AnyEdge                : std_logic_vector(7 downto 0) := x"02";
   constant LevelHigh              : std_logic_vector(7 downto 0) := x"03";
   constant LevelLow               : std_logic_vector(7 downto 0) := x"04";
   
   constant TRIGSEQ_HARDWARE     : std_logic := '0';
   constant TRIGSEQ_SOFTWARE     : std_logic := '1';
   
   -------------------------------------------------------							
   -- parametres de config du trigger reçus du µblaze
   -------------------------------------------------------
   type trig_cfg_type is
   record 
      mode          : std_logic_vector(7 downto 0);   -- mode du controleur de trig
      period	     : unsigned(31 downto 0);          -- periode du generateur local de trigs, en coup de cloks de 100 MHz       
      fpatrig_dly   : unsigned(31 downto 0);          -- delai pour le trig du FPA local,, en coup de cloks de 100 MHz      
      force_high    : std_logic;                      -- Trig à mettre toujours à HIGH, pour avoir frame rate max                    
      trig_activ    : std_logic_vector(7 downto 0);   -- permet de savoir comment declencher le trig.
      acq_window	  : std_logic;                      -- acq_ window à '1' permet de generer les trigs d'acquisition(image envoyées dans la chaine);-- à '0' permet de generer des extra_trigs (images non envoyées dans la chaine) 
      seq_framecount    : unsigned(31 downto 0);          -- en trig de sequence, le nombre de frame a acquerir
      seq_trigsource    : std_logic;                 -- '0' = Trig Hardware, '1' = Trig Software
      
      high_time     : unsigned(31 downto 0);          -- durée pendant laquelle le trig generé doit être high(en coups de 100MHz). Provient du module de contrôle du temps d'intégration
      run           : std_logic;                      -- RUN ou STOP      
   end record trig_cfg_type;
   
   signal s_trig_cfg : trig_cfg_type;
   
   constant trig_cfg_default : trig_cfg_type := (
   INTTRIG,
   to_unsigned(10_000_000,s_trig_cfg.PERIOD'LENGTH), 
   (others =>'0'),
   '0',
   RisingEdge,
   '0',
   to_unsigned(0,s_trig_cfg.seq_FRAMECOUNT'LENGTH), 
   TRIGSEQ_HARDWARE,
   to_unsigned(10_000,s_trig_cfg.PERIOD'LENGTH), 
   '0'
   );
   
   -------------------------------------------------------							
   -- parametres des sous blocs de conditionnement des trigs 
   -------------------------------------------------------	  	
   type trig_conditioner_type is
   record      
      run           : std_logic;    -- run
      high_time     : unsigned(s_trig_cfg.HIGH_TIME'LENGTH-1 downto 0);    -- temps durant lequel rester à on
      acq_window	  : std_logic;    -- acq_ window à '1' permet de generer les trigs d'acquisiiotn(image envoyées dans la chaine), à '0' permet de generer des extra_trigs (images non envoyées dans la chaine)
   end record trig_conditioner_type; 
   
end trig_define;

package body trig_define is
   
end package body trig_define; 
