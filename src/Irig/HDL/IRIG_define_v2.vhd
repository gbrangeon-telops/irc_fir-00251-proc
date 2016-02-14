--******************************************************************************
-- Destination: 
--
--	File: IRIG_define_v2.vhd
-- Hierarchy: Package file
-- Use: 
--	Project: IRCDEV
--	By: Edem Nofodjie
-- Date: 9 pctobre 2011	  
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


package IRIG_define_v2 is    
   
   --------------------------------------------
   -- PROJET: definition
   --------------------------------------------   
   constant IRIG_MORPHEME_PER_FRAME          : integer := 100;              -- il y a toujours 100 mophemes par trame.
   constant IRIG_CARRIER_FREQ_HZ             : integer := 1000;             -- frequence de la porteuse du signal IRIG à 1KHz
   constant SYS_CLK_FREQ_HZ                  : integer := 20_000_000;       -- frequence de l'horloge système   
   constant CLK_DETECTOR_DIV_FACTOR          : integer := 64;               -- absolument une puissance de 2, c'est le diviseur de l'horloge-systeme pour obtnenir l'horloge principale du module IRIG_CLK_DETECTOR 
   constant ADC_SAMPLE_CLK_DIV_FACTOR        : integer := 512;              -- absolument une puissance de 2, c'est le diviseur de l'horloge-systeme pour obtnenir la frequence d'echantillonnage de l'ADC
   constant IRIG_MORPHEME_RATE_HZ            : integer := 100;              -- frequence des elements de l,alphabet (morpheme) du signal IRIG B122 = 100 bits/sec
   constant IRIG_ADC_RANGE                   : integer := 2**8;             -- on a un ADC 8 bits    
   
   -- delais pour ajustement des canaux (inherents au Hardware)
   constant DATA_SYNC_DELAY_USEC             : integer := 820;              -- d'après l'étalonnage, il faut decaler l'horologe IRIG filtrée de 820 usec pour se synhcroniser avec les données IRIG
   constant PASSHIGH_FILTER_PHASE_SHIFT_USEC : real := 8.0 + 29.5;                -- d'après l'étalonnage, le filtre RC passe haut a induit une avance de phase de 8usec
   
   
   --------------------------------------------
   -- CALCULS : (ne pas changer)
   --------------------------------------------    
   constant CLK_DETECTOR_FREQ_HZ             : integer := SYS_CLK_FREQ_HZ/CLK_DETECTOR_DIV_FACTOR;   
   constant IRIG_CARRIER_PERIOD              : integer := SYS_CLK_FREQ_HZ/IRIG_CARRIER_FREQ_HZ; 
   constant CLK_DETECTOR_PERIOD              : integer := SYS_CLK_FREQ_HZ/CLK_DETECTOR_FREQ_HZ;
   constant IRIG_MORPHEME_PERIOD             : integer := SYS_CLK_FREQ_HZ/IRIG_MORPHEME_RATE_HZ;
   constant IRIG_CARRIER_PERIOD_FACTOR       : integer := integer(IRIG_CARRIER_PERIOD/CLK_DETECTOR_PERIOD);   
   constant CLK_DETECTOR_DIV_BIT             : integer := log2(CLK_DETECTOR_DIV_FACTOR)-1; -- position du bit diviseur d'horloge dans le module IRIG_CLK_DETECTOR
   constant IRIG_CARRIER_PERIOD_MIN_FACTOR   : integer := IRIG_CARRIER_PERIOD_FACTOR - 2*CLK_DETECTOR_DIV_FACTOR;
   constant IRIG_CARRIER_PERIOD_MAX_FACTOR   : integer := IRIG_CARRIER_PERIOD_FACTOR + 2*CLK_DETECTOR_DIV_FACTOR;
   constant ADC_SAMPLE_CLK_DIV_BIT           : integer := log2(ADC_SAMPLE_CLK_DIV_FACTOR)-1; -- position du bit diviseur d'horloge dans le module IRIG_CLK_DETECTOR
   constant IRIG_MORPHEME_RATE_FACTOR        : integer := IRIG_CARRIER_FREQ_HZ/IRIG_MORPHEME_RATE_HZ; -- nombre de cycles de la porteuse comprises dans un element d'alphabet (morpheme).
   constant IRIG_ALPHABET_ONE                : integer := (5*IRIG_MORPHEME_RATE_FACTOR)/10;   -- durée du morpheme '1' en cycles de porteuse 
   constant IRIG_ALPHABET_ZERO               : integer := (2*IRIG_MORPHEME_RATE_FACTOR)/10;   -- durée du morpheme '0' en cycles de porteuse 
   constant IRIG_ALPHABET_P                  : integer := 8*IRIG_MORPHEME_RATE_FACTOR/10;   -- durée du morpheme 'P' en cycles de porteuse 
   constant ADC_VALID_RANGE                  : integer := (18*IRIG_ADC_RANGE)/100;          -- on exigera 18% au minimum de la plage totale des ADC
   constant DATA_SYNC_DELAY                  : integer := (SYS_CLK_FREQ_HZ/1_000_000)*DATA_SYNC_DELAY_USEC; -- DATA_SYNC_DELAY_USEC en coups de clock système   
   constant PASSHIGH_FILTER_PHASE_SHIFT      : integer := integer(real(SYS_CLK_FREQ_HZ/1_000_000)*PASSHIGH_FILTER_PHASE_SHIFT_USEC); -- PASSHIGH_FILTER_PHASE_SHIFT_USEC en coups de clock système  
   
   --------------------------------------------
   -- TYPES DEFINIS PAR USAGER
   -------------------------------------------- 
   -- LocalLink ports
   type t_ll_mosi1 is record
      SOF	: std_logic;
      EOF	: std_logic;
      DATA	: std_logic;
      DVAL	: std_logic;
      SUPPORT_BUSY : std_logic;
   end record;   
   
   type t_ll_mosi8 is record
      SOF	: std_logic;
      EOF	: std_logic;
      DATA	: std_logic_vector(7 downto 0);
      DVAL	: std_logic;
      SUPPORT_BUSY : std_logic;
   end record;
   
   type t_ll_mosi is record
      SOF	: std_logic;
      EOF	: std_logic;
      DATA	: std_logic_vector(15 downto 0);
      DVAL	: std_logic;
      SUPPORT_BUSY : std_logic;
   end record; 
   
   type t_ll_miso is record
      AFULL	: std_logic;
      BUSY  : std_logic;
   end record;   
   
   type conditioner_cfg_type is
   record
      RESET_GAIN      : std_logic;   -- permet de reinitialiser le gain à 0  
      RESET_ERR       : std_logic;   -- permet d'effacer le registre des eruers
      INC_GAIN        : std_logic;   -- à '1', permet d'incrementer le gain
      DEC_GAIN        : std_logic;   -- à '1', permet de decrementer le gain
   end record conditioner_cfg_type;       
   
   type alphab_decoder_cfg_type is
   record
      INIT            : std_logic;   -- pulse qui permet de lancer l'initialisation du decodeur d'alphabet
   end record alphab_decoder_cfg_type;       
   
   type frame_decoder_cfg_type is
   record
      ENABLE          : std_logic;   -- permet de contrôler le decodeur de trame
   end record frame_decoder_cfg_type;
   
   
   type irig_data_type is
   record 
      seconds_reg     : std_logic_vector(15 downto 0);     
      minutes_reg     : std_logic_vector(15 downto 0);
      hours_reg       : std_logic_vector(15 downto 0);      
      dayofyear_reg   : std_logic_vector(15 downto 0);
      tenthsofsec_reg : std_logic_vector(15 downto 0);
      year_reg        : std_logic_vector(15 downto 0);        
      time_dval       : std_logic; 
      status_reg      : std_logic_vector(15 downto 0); 
      status_dval     : std_logic;
   end record irig_data_type;
   --------------------------------------------
   -- ROIC functions --
   --------------------------------------------  
   --function resize(a: std_logic_vector; len: natural) return std_logic_vector;
   
end IRIG_define_v2;



package body IRIG_define_v2 is
   
   --   -- function resize
   --   function resize(a: std_logic_vector; len: natural) return std_logic_vector is
   --   begin
   --      return std_logic_vector(resize(unsigned(a), len));
   --   end resize;   
   
end package body IRIG_define_v2; 

