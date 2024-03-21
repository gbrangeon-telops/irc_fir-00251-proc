/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 27563 $
-- $Author: enofodjie $
-- $LastChangedDate: 2022-06-12 18:37:18 -0400 (dim., 12 juin 2022) $
--
-------------------------------------------------------------------------------
--
-- Description : 
--
------------------------------------------------------------------------------*/

#include "GeniCam.h"
#include "fpa_intf.h"
#include "flashSettings.h"
#include "utils.h"
#include "IRC_status.h"
#include "CRC.h"
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include "exposure_time_ctrl.h"

#ifdef SIM
   #include "proc_ctrl.h" // Contains the class SC_MODULE for SystemC simulation
   #include "mb_transactor.h" // Contains virtual functions that emulates microblaze functions
   #include "mb_axi4l_bridge_SC.h" // Used to bridge Microblaze AXI4-Lite transaction in SystemC transaction
#else                  
   //#include "dosfs.h"
   //#include "xtime_l.h"
   //#include "xcache_l.h"
   #include "mb_axi4l_bridge.h"
#endif


// Periode minimale des xtratrigs (utilisé par le hw pour avoir le temps de programmer le détecteur entre les trigs. Commande operationnelle et syhthetique seulement)
#define XTRA_TRIG_FREQ_MAX_HZ              10        // soit une frequence de 10Hz         
  
// Mode d'operation choisi pour le contrôleur de trig 
#define MODE_READOUT_END_TO_TRIG_START     0x00      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR uniquement
#define MODE_TRIG_START_TO_TRIG_START      0x01      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR et surtout IWR
#define MODE_INT_END_TO_TRIG_START         0x02      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du IWR et ITR
#define MODE_ITR_TRIG_START_TO_TRIG_START  0x03      // delai pris en compte = periode entre le trig actuel et le prochain. Une fois ce delai observé, on s'assure que le readout est terminé avant de considerer le prochain trig.
#define MODE_ITR_INT_END_TO_TRIG_START     0x04      // delai pris en compte = duree entre la fin de l'integration actuelle et le prochain trig. Une fois ce delai observé, on s'assure que le readout est terminé avant de considerer le prochain trig.

// Gains definis par Indigo  
#define FPA_GAIN_0                        0x00      // High gain
#define FPA_GAIN_1                        0x01      // Low gain                               
 
// la structure Command_t a 4 bytes d'overhead(CmdID et CmdCharNum)

// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400    // adresse de base 
#define AR_FPA_TEMPERATURE                0x002C    // adresse temperature
// adresse FPA_INTF_CFG feedback du module de statuts
#define AR_FPA_INTF_CFG_BASE_ADD          (AR_STATUS_BASE_ADD + 0x0200)

// adresse d'écriture du régistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xAE0      // adresse à lauquelle on dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xAE4      // adresse à lauquelle on dit au VHD quel type de sortie de fpa e pilote en C est conçu pour.
#define AW_FPA_INPUT_SW_TYPE              0xAE8      // obligaoire pour les deteceteurs analogiques

// identification des sources de données
#define DATA_SOURCE_INSIDE_FPGA           0         // Provient du fichier fpa_common_pkg.vhd.
#define DATA_SOURCE_OUTSIDE_FPGA          1         // Provient du fichier fpa_common_pkg.vhd.

// adresse d'ecriture de la cfg des Dacs
#define AW_DAC_CFG_BASE_ADD               0x0D00

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x19      // 0x19 -> 0804 . Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL
#define FPA_INPUT_TYPE                    0x04      // 0x04 -> input LVCMOS33 .provient du fichier fpa_common_pkg.vhd. La valeur 0x03 est celle de LVTTL50


// adresse d'écriture du régistre du reset des erreurs
#define AW_RESET_ERR                      0xAEC

 // adresse d'écriture du régistre du reset du module FPA
#define AW_CTRLED_RESET                   0xAF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de Mglk)
#define TELOPS_DIAG_CNST                  0xD1      // mode diag constant (patron de test generé par la carte d'acquisition : tous les pixels à la même valeur) 
#define TELOPS_DIAG_DEGR                  0xD2      // mode diag dégradé linéaire(patron de test dégradé linéairement et généré par la carte d'acquisition).Requis en production
#define TELOPS_DIAG_DEGR_DYN              0xD3      // mode diag dégradé linéaire dynamique(patron de test dégradé linéairement et variant d'image en image et généré par la carte d'acquisition)  

#define VHD_INVALID_TEMP                  0xFFFFFFFF                                                  

// horloges du module FPA
#define VHD_CLK_100M_RATE_HZ              100000000
#define VHD_CLK_80M_RATE_HZ                80000000


// horloges des zones FASTRD
#define FAST_CLK_FACTOR                      (8.0/6.0)  // facteur multiplicatif de l'horloge détecteur
#define ROIC_LSYDEL_AREA_FAST_CLK_RATE_HZ    (FAST_CLK_FACTOR*FPA_MCLK_RATE_HZ)                  // horloge rapide de la zone en question lorsqu,on active le fastwd
#define ROIC_SAMPLE_ROW_FAST_CLK_RATE_HZ     (FAST_CLK_FACTOR*FPA_MCLK_RATE_HZ)    // horloge rapide de la zone en question lorsqu,on active le fastwd
#define ROIC_LSYNC_FAST_CLK_RATE_HZ          (FAST_CLK_FACTOR*FPA_MCLK_RATE_HZ)    // horloge rapide de la zone en question lorsqu,on active le fastwd
#define ROIC_REMAINING_LOVH_FAST_CLK_RATE_HZ (FAST_CLK_FACTOR*FPA_MCLK_RATE_HZ)    // horloge rapide de la zone en question lorsqu,on active le fastwd
#define ROIC_UNUSED_AREA_FAST_CLK_RATE_HZ    (FAST_CLK_FACTOR*FPA_MCLK_RATE_HZ)    // horloge rapide de la zone en question lorsqu,on active le fastwd


#define ADC_SAMPLING_RATE_HZ              (2*FPA_MCLK_RATE_HZ)

// lecture de température FPA
#define FPA_TEMP_READER_ADC_DATA_RES      16            // la donnée de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV     2048          // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN              1             // gain du canal de lecture de temperature sur la carte ADC

// fleg
#define FLEG_DAC_RESOLUTION_BITS          14            // le DAC est à 14 bits
#define FLEG_DAC_REF_VOLTAGE_V            2.5           // on utilise la reference interne de 2.5V du DAC 
#define FLEG_DAC_REF_GAIN                 2             // le gain est de 2 sur VREF

#define TEST_PATTERN_LINE_DLY             12            // J'Estime que mon patron de test actuel a besoin de 12 clks de 10 ns entre chaque ligne.

#define GOOD_SAMP_MEAN_DIV_BIT_POS        21            // ne pas changer meme si le detecteur change.

#define ISC0804_TAPREF_VOLTAGE_MIN_mV     700
#define ISC0804_TAPREF_VOLTAGE_MAX_mV     3300

#define ISC0804_DET_BIAS_VOLTAGE_MIN_mV   -475          // 
#define ISC0804_DET_BIAS_VOLTAGE_MAX_mV    185           //

#define ISC0804_REFOFS_VOLTAGE_MIN_mV     502
#define ISC0804_REFOFS_VOLTAGE_MAX_mV     3300 

#define TOTAL_DAC_NUM                     8            // 8 dac au total

#define ISC0804_2K_FASTWINDOW_STRECTHING_AREA_MCLK  1

// Electrical correction : references
#define ELCORR_REF1_VALUE_mV              1730     //2227     // ref0 au milieu de la plage dynamique
#define ELCORR_REF2_VALUE_mV              1200
#define ELCORR_REF_DAC_ID                 5                   // position (entre 1 et 8) du dac dédié aux references 
#define ELCORR_REF_MAXIMUM_SAMP           120                 // le nombre de sample au max supporté par le vhd

// Electrical correction : embedded switches control
#define ELCORR_SW_TO_PATH1                0x01
#define ELCORR_SW_TO_PATH2                0x02
#define ELCORR_SW_TO_NORMAL_OP            0x03 

#define ELCORR_CONT_MODE_OFFSETX_MIN      640

// Electrical correction : valeurs par defaut si aucune mesure dispo dans les flashsettings
#define ELCORR_DEFAULT_STARVATION_DL      1300        // @ centered pix (320, 256)
#define ELCORR_DEFAULT_SATURATION_DL      15500       // @ centered pix (320, 256)
#define ELCORR_DEFAULT_REFERENCE1_DL      4100        // @ centered pix (320, 256)
#define ELCORR_DEFAULT_REFERENCE2_DL      475         // @ centered pix (320, 256)

// Electrical correction : limites des valeurs en provenance de la flash
#define ELCORR_STARVATION_MIN_DL          100
#define ELCORR_STARVATION_MAX_DL          1500

#define ELCORR_SATURATION_MIN_DL          14000
#define ELCORR_SATURATION_MAX_DL          16300

#define ELCORR_REFERENCE1_MIN_DL          50
#define ELCORR_REFERENCE1_MAX_DL          16300

#define ELCORR_REFERENCE2_MIN_DL          50
#define ELCORR_REFERENCE2_MAX_DL          16300

// Electrical correction : valeurs cibles (desirées) apres correction
#define ELCORR_TARGET_STARVATION_DL       650 //1500  // @ centered pix (320, 256)
#define ELCORR_TARGET_SATURATION_DL       16000       // @ centered pix (320, 256)

// Electrical correction : les differents modes
#define ELCORR_MODE_OFF                               0
#define ELCORR_MODE_OFF_WITH_DYN_RANGE_COMP           10
#define ELCORR_MODE_REF1_IMG                          1
#define ELCORR_MODE_REF2_IMG                          2
#define ELCORR_MODE_DIFF_REF_IMG                      3
#define ELCORR_MODE_OFFSET_CORR                       5
#define ELCORR_MODE_OFFSET_CORR_WITH_DYN_RANGE_COMP   15
#define ELCORR_MODE_ROIC_OUTPUT_CST_IMG               6
#define ELCORR_MODE_OFFSET_AND_GAIN_CORR              7
#define ELCORR_MODE_FREE_WHEELING_CORR                9
#define ELCORR_MODE_FREE_WHEELING_WITH_REF_CORR       19

// Déphasage de ligne
#define ISC0804_DEFAULT_REGF             16

#define ISC0804_BITSTREAM_FG   53696343  // bitstream ROIC standard de ForrestGump pour M1k
#define ISC0804_BITSTREAM_FAST 322131831 // bitstream ROIC avec meilleur slew rate (M2k UD)

// clk area (en provenance de fpa_define)
#define  VHD_DEFINE_FPA_NOMINAL_MCLK_ID            0    // horloge nominale
#define  VHD_DEFINE_FPA_MCLK1_ID                   1    // 
#define  VHD_DEFINE_FPA_MCLK2_ID                   2    // 
#define  VHD_DEFINE_FPA_MCLK3_ID                   3    // 

#define DEFINE_FPA_NOMINAL_MCLK_RATE_HZ      FPA_NOMINAL_MCLK_RATE_HZ
#define DEFINE_DEFINE_FPA_MCLK1_RATE_HZ      (8.0/12.0*DEFINE_FPA_NOMINAL_MCLK_RATE_HZ)
#define DEFINE_DEFINE_FPA_MCLK2_RATE_HZ      (FAST_CLK_FACTOR*DEFINE_FPA_NOMINAL_MCLK_RATE_HZ)
#define DEFINE_DEFINE_FPA_MCLK3_RATE_HZ      (1.0*DEFINE_FPA_NOMINAL_MCLK_RATE_HZ)

#define LINE_PAUSE                1.0F
#define OVH_LINES_NUM             2.0F

#define DYNAMIC_RANGE_DIV_BIT_POS                  21     // précision fractionnaire
#define DYNAMIC_RANGE_SCALER_SATURATION_LEVEL      16000  // niveau de restauration des données sur le modèle M2K-UD
#define DYNAMIC_RANGE_CLIPPING_LEVEL               8191   //8000  // niveau d'ecretage des donnnées du modèle M2K-UD
#define DYNAMIC_RANGE_GLOBAL_OFFSET                0      //1675   // offset de base


struct s_ProximCfgConfig 
{   
   uint32_t  vdac_value[(uint8_t)TOTAL_DAC_NUM];
   uint32_t  spare1;                       
   uint32_t  spare2;   
};                                  
typedef struct s_ProximCfgConfig ProximCfg_t;

// structure interne pour les parametres du 0804
struct isc0804_2k_param_s             //
{	
  // parametres pour timing ROIC 
   float mclk_period_usec;
   float pclk_rate_hz;
   float tap_number;
   float pixnum_per_tap_per_mclk;
   float reset_time_usec;                              
   float int_signal_high_time_usec; 
   float lsydel_mclk;
   float lsydel_usec;
   float fpa_delay_mclk;
   float fpa_delay_usec;
   float vhd_delay_mclk; 
   float vhd_delay_usec;
   float delay_mclk; 
   float delay_usec;
   float lovh_mclk;
   float fovh_line;
   float int_time_offset_usec;
   
   // fenetre du ROIC
   float roic_xsize; 
   float roic_ysize; 
   float roic_xstart;
   float roic_ystart;
   
   // parametrage du fastwindowing
   float lsydel_clock_factor;
   float ovh_lines_clock_factor;
   float lsync_clock_factor;
   float raw_area_clock_factor;
   
   // misc
   float readout_mclk;
   float readout_usec;
   float frame_period_min_usec;
   float frame_rate_max_hz;
   float mode_int_end_to_trig_start_dly_usec;
   float mode_readout_end_to_trig_start_dly_usec;
   float mode_trig_start_to_trig_start_dly_usec;
   float adc_sync_dly_mclk;
   float line_stretch_mclk;
   float frame_period_coef;   // pour limitation artificielle du frame rate  
};
typedef struct isc0804_2k_param_s isc0804_2k_param_t;

struct s_area_cfg_type 
{   
   uint32_t  roic_xstart;
   uint32_t  roic_ystart;
   uint32_t  roic_xsize;
   uint32_t  roic_ysize;
   uint32_t  raw_area_clk_id;
   uint32_t  user_area_clk_id;                       
   uint32_t  clk_area_a_sol_posl_pclk;
   uint32_t  clk_area_a_eol_posl_pclk;
   uint32_t  clk_area_a_clk_id;
   uint32_t  clk_area_b_sol_posl_pclk;
   uint32_t  clk_area_b_eol_posl_pclk;
   uint32_t  clk_area_b_clk_id;
   uint32_t  user_area_odd_lines_only;
   uint32_t  user_area_even_lines_only;
};                                  
typedef struct s_area_cfg_type area_cfg_t;


// Global variables
t_FpaStatus gStat;                        // devient une variable globale
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
uint32_t sw_init_done = 0;
uint32_t sw_init_success = 0;
ProximCfg_t ProximCfg = {{4518, 4518, 4518, 1046,  5738, 6075, 8507, 4518}, 0, 0};   // les valeurs d'initisalisation des dacs sont les 8 premiers chiffres
t_FpaStatus gStat;


// definition et activation des accelerateurs
uint8_t speedup_lsydel = 1;      // les speed_up n'ont que deux valeurs : 0 ou 1
uint8_t speedup_ovh_lines = 1;
uint8_t speedup_lsync = 0; // Les LSYNC de la user area ne sont pas accélérés.
uint8_t speedup_raw_area = 1;
uint32_t roic_xsize = (uint32_t)FPA_WIDTH_MAX;

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA);
void FPA_SpecificParams(isc0804_2k_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   sw_init_done = 0;
   sw_init_success = 0;
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd permet de populer gStat
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // FPA_SendConfigGC appelle toujours FPA_SpecificParams avant d'envoyer les configs
   FPA_Reset(ptrA);                                                         // le reste après l'envoi de la nouvelle cfg permetau module FPA de demarrer avec une config d'initialiation = celle envoyée 
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides Mglk Detector
   FPA_GetTemperature(ptrA);                                                // demande de lecture
}
 
//--------------------------------------------------------------------------
// pour reset des registres d'erreurs
//--------------------------------------------------------------------------
void  FPA_ClearErr(const t_FpaIntf *ptrA)
{
   AXI4L_write32(1, ptrA->ADD + AW_RESET_ERR);           //on active l'effacement
   AXI4L_write32(0, ptrA->ADD + AW_RESET_ERR);		      //on desactive l'effacement
}

//--------------------------------------------------------------------------
// pour reset du module
//--------------------------------------------------------------------------
// retenir qu'après reset, les IO sont en 'Z' après cela puisqu'on desactive le SoftwType dans le vhd. (voir vhd pour plus de details)
void  FPA_Reset(const t_FpaIntf *ptrA)
{
   uint16_t ii;
   for(ii = 0; ii <= 100 ; ii++)
   { 
      AXI4L_write32(1, ptrA->ADD + AW_CTRLED_RESET);             //on active le reset
   }
   for(ii = 0; ii <= 100 ; ii++)
   { 
      AXI4L_write32(0, ptrA->ADD + AW_CTRLED_RESET);             //on active l'effacement
   }
}
 
//--------------------------------------------------------------------------
// pour power down (power management)
//--------------------------------------------------------------------------
void  FPA_PowerDown(const t_FpaIntf *ptrA)
{
  FPA_Reset(ptrA);   
}
 
//--------------------------------------------------------------------------                                                                            
//pour configuer le bloc vhd FPA_interface et le lancer
//--------------------------------------------------------------------------
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs)
{ 
   isc0804_2k_param_t hh;
   
   extern int16_t gFpaDetectorPolarizationVoltage;
   static int16_t presentPolarizationVoltage = 700;      //  700 mV comme valeur par defaut pour GPOL
   extern float gFpaDetectorElectricalTapsRef;
   // extern float gFpaDetectorElectricalRefOffset;
   extern int32_t gFpaDebugRegA;                         // reservé ELCORR pour correction électronique (gain et/ou offset)
   extern int32_t gFpaDebugRegB;                         // reservé ROIC Bistream après validation du mot de passe 
   extern int32_t gFpaDebugRegC;                         // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk du quad1
   extern int32_t gFpaDebugRegD;                         // reservé adc_clk_source_phase pour ajustement fin phase adc_clk du quad1
   extern int32_t gFpaDebugRegE;                         // reservé fpa_intf_data_source pour sortir les données des ADCs même lorsque le détecteur/flegX est absent
   extern int32_t gFpaDebugRegF;                         // reservé real_mode_active_pixel_dly pour ajustement du début AOI
   extern int32_t gFpaDebugRegG;                         // clipping level
   extern int32_t gFpaDebugRegH;                         // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk du quad2
   extern int32_t gFpaDebugRegI;                         // reservé adc_clk_source_phase pour ajustement fin phase adc_clk du quad2
   extern int32_t gFpaDebugRegJ;                         // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk du quad3
   extern int32_t gFpaDebugRegK;                         // reservé adc_clk_source_phase pour ajustement fin phase adc_clk du quad3
   extern int32_t gFpaDebugRegL;                         // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk du quad4
   extern int32_t gFpaDebugRegM;                         // reservé adc_clk_source_phase pour ajustement fin phase adc_clk du quad4
   extern uint16_t gFpaADCQuad1CoarsePhase;              // ajustemnt grossier phase adc_clk du quad1 provenant des FS
   extern uint16_t gFpaADCQuad2CoarsePhase;              // ajustemnt grossier phase adc_clk du quad2 provenant des FS
   extern uint16_t gFpaADCQuad3CoarsePhase;              // ajustemnt grossier phase adc_clk du quad3 provenant des FS
   extern uint16_t gFpaADCQuad4CoarsePhase;              // ajustemnt grossier phase adc_clk du quad4 provenant des FS
   extern uint16_t gFpaADCQuad1FinePhase;                // ajustement fin phase adc_clk du quad1 provenant des FS
   extern uint16_t gFpaADCQuad2FinePhase;                // ajustement fin phase adc_clk du quad2 provenant des FS
   extern uint16_t gFpaADCQuad3FinePhase;                // ajustement fin phase adc_clk du quad3 provenant des FS
   extern uint16_t gFpaADCQuad4FinePhase;                // ajustement fin phase adc_clk du quad4 provenant des FS
   uint32_t elcorr_reg;
   static float presentElectricalTapsRef;       // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul
   static uint16_t presentElCorrMeasAtStarvation;
   static uint16_t presentElCorrMeasAtSaturation;
   static uint16_t presentElCorrMeasAtReference1;
   static uint16_t presentElCorrMeasAtReference2;

   extern uint16_t gFpaElCorrMeasAtStarvation;
   extern uint16_t gFpaElCorrMeasAtSaturation;
   extern uint16_t gFpaElCorrMeasAtReference1;
   extern uint16_t gFpaElCorrMeasAtReference2;

   uint32_t elcorr_enabled = 1;
   uint32_t elcorr_gain_corr_enabled = 0;
   float elcorr_comp_duration_usec;                 // la duree en usec disponible pour la prise des references
   float elcorr_atemp_gain;
   float elcorr_atemp_ofs;
   float dynrange_factor;
   static uint8_t cfg_num;
   static uint8_t roic_dbg_reg_unlocked;
   
   // on bâtit les parametres specifiques du 0804
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);               //le temps d'integration est nul . Mais le VHD ajoutera le int_time pour avoir la vraie periode
   
   // need_rst_fpa_module = 0;

   // diag mode and diagType
   ptrA->fpa_diag_mode = 0;                 // par defaut
   ptrA->fpa_diag_type = 0;                 // par defaut   
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade) {               // mode diagnostique degradé lineaire
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR;
   }
   else if (pGCRegs->TestImageSelector == TIS_TelopsConstantValue1) {      // mode diagnostique avec valeur constante
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_CNST;
   }
   else if (pGCRegs->TestImageSelector == TIS_TelopsDynamicShade) {
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR_DYN;
   }
   
   // Élargit le pulse de trig au besoin
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig; 
    
   // mode diag vrai et faked
   ptrA->fpa_intf_data_source = DATA_SOURCE_INSIDE_FPGA;     // fpa_intf_data_source n'est utilisé/regardé par le vhd que lorsque fpa_diag_mode = 1
   if (ptrA->fpa_diag_mode == 1){
      if ((int32_t)gFpaDebugRegE != 0)
         ptrA->fpa_intf_data_source = DATA_SOURCE_OUTSIDE_FPGA;
   }
   
   // allumage du détecteur 
   ptrA->fpa_pwr_on  = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   
   // config du contrôleur de trigs
   if (ptrA->fpa_diag_mode == 1) {
      ptrA->fpa_acq_trig_mode        = (uint32_t)MODE_ITR_INT_END_TO_TRIG_START; // pour ne pas bousculer le generateur de patron
      ptrA->fpa_acq_trig_ctrl_dly    = (uint32_t)((hh.mode_int_end_to_trig_start_dly_usec*1e-6F) * (float)VHD_CLK_100M_RATE_HZ);
   }
   else {
      ptrA->fpa_acq_trig_mode        = (uint32_t)MODE_INT_END_TO_TRIG_START;
      if (TDCStatusTst(WaitingForImageCorrectionMask) == 1)      // lorsqu'une actualisation est en cours, on passe en MODE_ITR_INT_END_TO_TRIG_START pour que le throughput_ctrl ajuste le throughput à celle de l'actualisation
         ptrA->fpa_acq_trig_mode     = (uint32_t)MODE_ITR_INT_END_TO_TRIG_START;
      ptrA->fpa_acq_trig_ctrl_dly    = (uint32_t)((hh.mode_int_end_to_trig_start_dly_usec*1e-6F) * (float)VHD_CLK_100M_RATE_HZ);
   }

   ptrA->fpa_xtra_trig_mode          = (uint32_t)MODE_READOUT_END_TO_TRIG_START;
   ptrA->fpa_xtra_trig_ctrl_dly      = ptrA->fpa_acq_trig_ctrl_dly;
   ptrA->fpa_trig_ctrl_timeout_dly   = (uint32_t)((hh.mode_trig_start_to_trig_start_dly_usec*1e-6F) * (float)VHD_CLK_100M_RATE_HZ);

   // mode par défaut : 1 sample par pixel
   ptrA->single_samp_mode_en = 1;
   
   // diag window param   
   ptrA->diag_ysize            = (uint32_t)pGCRegs->Height;
   ptrA->diag_xsize_div_tapnum = (uint32_t)pGCRegs->Width/(uint32_t)FPA_NUMTAPS;
   
   // Roic window param                                    
   ptrA->roic_ystart           = (uint32_t)hh.roic_ystart;
   ptrA->roic_ysize_div4_m1    = (uint32_t)pGCRegs->Height/4 - 1;   //
    
   //  gain n'est pas configurable sur le ISC0804

   // OUTR est delaissé
   ptrA->ref_mode_en = 0;
   ptrA->ref_chn_en = 0;
   
   ptrA->clamping_level = 4;   
    
   // electronique de proximité
   ptrA->proxim_is_flegx = 1;

   ptrA->roic_test_row_en = 0;
 
   // speedup_lsydel et autres ont été déjà assignés dans FPA_SpecificParams qui est déjà appelé au debut de la fonction FPA_SendConfigGC 
   ptrA->speedup_lsydel            = 1;

   /* General info regarding area definition (configuration of the readout controller)
   * 1. For the current implementation, fpa mclk can be 2 differents frequency (nominal mclk & fast mclk)
   * 2. Clock area index are defined in pclk (pclk index = [1,2,...,42]). There is 2 pclk cycles for each mclk. ROIC always output line on 21 mclk.
   * 3. LSYNC is located at pclk index 1 & 2
   * 4. Inside one line, there is 2 differents clock area (raw area & user area). Raw area is accelerated on fast mclk. User area work on nominal mclk
   * 5. Each readout has M + 2 lines of 21 mclk cycle (M = pGCRegs->Height)
   * 6. The 2 overhead lines are not part of the raw area, but are still accelerated on the fast mclk (except the LSYNC).
   * 7. All LSYNC of the M + 2 lines are not accelerated (alway on nominal clk).
   * 8. In full window, the raw area equal the user area.
   * 9. Lsydel delay is accelerated on fast mclk but is not part of the raw area.
   *  */

   // Raw area (fast mclk domain)
   ptrA->raw_area_line_start_num          = 2;
   ptrA->raw_area_line_end_num            = (uint32_t)hh.roic_ysize + ptrA->raw_area_line_start_num - 1;
   ptrA->raw_area_line_period_pclk        = ((uint32_t)hh.roic_xsize/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)+ hh.lovh_mclk) *  hh.pixnum_per_tap_per_mclk;
   ptrA->raw_area_sof_posf_pclk           = ptrA->raw_area_line_period_pclk * (ptrA->raw_area_line_start_num - 1) + 1;                 
   ptrA->raw_area_eof_posf_pclk           = ptrA->raw_area_line_end_num * ptrA->raw_area_line_period_pclk - (uint32_t)(hh.lovh_mclk * hh.pixnum_per_tap_per_mclk);                 
   ptrA->raw_area_sol_posl_pclk           = 1;                 
   ptrA->raw_area_eol_posl_pclk           = ((uint32_t)hh.roic_xsize/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)) * hh.pixnum_per_tap_per_mclk;
   ptrA->raw_area_readout_pclk_cnt_max    = ptrA->raw_area_line_period_pclk * ((uint32_t)hh.roic_ysize + hh.fovh_line + ptrA->raw_area_line_start_num - 1) + 1;
   ptrA->raw_area_lsync_start_posl_pclk   = 1;
   ptrA->raw_area_lsync_end_posl_pclk     = 2;
   ptrA->raw_area_lsync_num               = (uint32_t)hh.roic_ysize + 2;   
   ptrA->raw_area_clk_id                  = (uint32_t)VHD_DEFINE_FPA_MCLK2_ID;
   
   // user area (nominal mclk domain)
   ptrA->user_area_line_start_num         = ptrA->raw_area_line_start_num;
   ptrA->user_area_line_end_num           = (uint32_t)pGCRegs->Height + ptrA->user_area_line_start_num - 1;
   ptrA->user_area_sol_posl_pclk          = (((uint32_t)hh.roic_xsize - (uint32_t)pGCRegs->Width)/2)/FPA_NUMTAPS + 3;
   ptrA->user_area_eol_posl_pclk          = ptrA->user_area_sol_posl_pclk + ((uint32_t)pGCRegs->Width/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)) * hh.pixnum_per_tap_per_mclk - 1;
   ptrA->user_area_clk_id                 = (uint32_t)VHD_DEFINE_FPA_NOMINAL_MCLK_ID;
   
   // Stretching of the user area by one mclk cycle to account for fpa pipe delay.
   ptrA->clk_area_a_line_start_num        = ptrA->user_area_line_start_num;
   ptrA->clk_area_a_line_end_num          = ptrA->user_area_line_end_num;
   ptrA->clk_area_a_sol_posl_pclk         = MIN( ptrA->user_area_eol_posl_pclk + 1 , ptrA->raw_area_line_period_pclk - 1);
   ptrA->clk_area_a_eol_posl_pclk         = ptrA->clk_area_a_sol_posl_pclk + 1;
   ptrA->clk_area_a_clk_id                = (uint32_t)VHD_DEFINE_FPA_NOMINAL_MCLK_ID;
   ptrA->clk_area_a_spare                 = 0;
   
   // Overriding of LSYNC frequency with nominal mclk (LSYNC is always on nominal mlck even for the 2 overhead lines)
   ptrA->clk_area_b_line_start_num        = ptrA->raw_area_line_start_num - 1;
   ptrA->clk_area_b_line_end_num          = ptrA->raw_area_line_end_num + 1;
   ptrA->clk_area_b_sol_posl_pclk         = ptrA->raw_area_lsync_start_posl_pclk;
   ptrA->clk_area_b_eol_posl_pclk         = ptrA->raw_area_lsync_end_posl_pclk;
   ptrA->clk_area_b_clk_id                = (uint32_t)VHD_DEFINE_FPA_NOMINAL_MCLK_ID;
   ptrA->clk_area_b_spare                 = 0;

   // nombre d'échantillons par canal  de carte ADC
   ptrA->pix_samp_num_per_ch           = (uint32_t)((float)ADC_SAMPLING_RATE_HZ/(hh.pclk_rate_hz));
   
   // echantillons choisis
   ptrA->good_samp_first_pos_per_ch    = ptrA->pix_samp_num_per_ch;     // position premier echantillon
   ptrA->good_samp_last_pos_per_ch     = ptrA->pix_samp_num_per_ch;     // position dernier echantillon
   ptrA->hgood_samp_sum_num            = ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->hgood_samp_mean_numerator     = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/(float)ptrA->hgood_samp_sum_num);                            
   ptrA->vgood_samp_sum_num            = 1;
   ptrA->vgood_samp_mean_numerator     = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/(float)ptrA->vgood_samp_sum_num);                              
   
   // les Alimentations
   ProximCfg.vdac_value[0]             = FLEG_VccVoltage_To_DacWord(3600.0F, 1);           // VCC1 -> VPOS_OUT à 3.6V
   ProximCfg.vdac_value[1]             = FLEG_VccVoltage_To_DacWord(3600.0F, 2);           // VCC2 -> VPOS     à 3.6V
   ProximCfg.vdac_value[7]             = FLEG_VccVoltage_To_DacWord(3600.0F, 8);           // VCC8 -> VPD      à 3.6V
   
   // VOUTREF (VCC5)  : il est à la valeur de la reference 1 soit ELCORR_REF1_VALUE_mV
   //if (sw_init_done == 0) 
   ProximCfg.vdac_value[4] = (uint32_t)FLEG_VccVoltage_To_DacWord((float)ELCORR_REF1_VALUE_mV, (int8_t)ELCORR_REF_DAC_ID);  //  Il est placé à la valeur milieu des taps au début. Mais par la suite elcorr prend la releve
   
   // DetPol voltage
   if (gFpaDetectorPolarizationVoltage != presentPolarizationVoltage){
      if ((gFpaDetectorPolarizationVoltage >= (int16_t)ISC0804_DET_BIAS_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= (int16_t)ISC0804_DET_BIAS_VOLTAGE_MAX_mV))
         ptrA->vdet_code = (uint32_t)roundf((-1.0F*(float)gFpaDetectorPolarizationVoltage + 185.0F)/5.1969F);  // dig_code change si la nouvelle valeur est conforme. Sinon la valeur precedente est conservée. (voir FpaIntf_Ctor) pour la valeur d'initialisation
   }
   presentPolarizationVoltage = (int16_t)roundf(-5.1969F*(float)ptrA->vdet_code + 185.0F);
   gFpaDetectorPolarizationVoltage = presentPolarizationVoltage;
   
   // OUTR déconnecté du FPA mais remplacé désormais par notre électronique pour assurer l'offset global(VCC6 / TAPREF)
   if (gFpaDetectorElectricalTapsRef != presentElectricalTapsRef){
      if ((gFpaDetectorElectricalTapsRef >= (int16_t)ISC0804_TAPREF_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalTapsRef <= (int16_t)ISC0804_TAPREF_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[5] = (uint32_t) FLEG_VccVoltage_To_DacWord((float)gFpaDetectorElectricalTapsRef, 6);  // 
   }
   presentElectricalTapsRef = (float) FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[5], 6);
   gFpaDetectorElectricalTapsRef = presentElectricalTapsRef;

   // Registre F : ajustement des delais de la chaine
   if (sw_init_done == 0){
      gFpaDebugRegF = ISC0804_DEFAULT_REGF;    //
      if (ptrA->pix_samp_num_per_ch > 1)
         gFpaDebugRegF = ISC0804_DEFAULT_REGF;
   }   
   ptrA->real_mode_active_pixel_dly = (uint32_t)gFpaDebugRegF; 
     
   // boostr mode
   ptrA->boost_mode = 0x17;         //ne sert plus à rien dans le vhd    
    
   // dephasage des adc_clk avec gFpaDebugRegC et gFpaDebugRegD
   // adc clk source phase
   if (sw_init_done == 0){
      gFpaDebugRegC = gFpaADCQuad1CoarsePhase;
      gFpaDebugRegH = gFpaADCQuad2CoarsePhase;
      gFpaDebugRegJ = gFpaADCQuad3CoarsePhase;
      gFpaDebugRegL = gFpaADCQuad4CoarsePhase;
   }       
   ptrA->adc_clk_pipe_sel1 = (uint32_t)gFpaDebugRegC;
   ptrA->adc_clk_pipe_sel2 = (uint32_t)gFpaDebugRegH;
   ptrA->adc_clk_pipe_sel3 = (uint32_t)gFpaDebugRegJ;
   ptrA->adc_clk_pipe_sel4 = (uint32_t)gFpaDebugRegL;
   
   // adc clk source phase
   if (sw_init_done == 0){         
      gFpaDebugRegD = gFpaADCQuad1FinePhase;
      gFpaDebugRegI = gFpaADCQuad2FinePhase;
      gFpaDebugRegK = gFpaADCQuad3FinePhase;
      gFpaDebugRegM = gFpaADCQuad4FinePhase;
   }
   ptrA->adc_clk_source_phase1 = (uint32_t)gFpaDebugRegD;
   ptrA->adc_clk_source_phase2 = (uint32_t)gFpaDebugRegI;
   ptrA->adc_clk_source_phase3 = (uint32_t)gFpaDebugRegK;
   ptrA->adc_clk_source_phase4 = (uint32_t)gFpaDebugRegM;
         
   // autres
   ptrA->lsydel_mclk  = (uint32_t)(hh.lsydel_mclk - 1.0F);  // ajustement tenant compte des delais de chaine vhd   
   
   // synchronisateur de l'horloge fast sur celle des ADCs
   // ptrA->fastrd_sync_pos   = 0;   // n'est plus utilisé dans le vhd
   
   // bistream du detecteur via regB ( pour tests de changement du bistream suggéré par Flir)
   if (gFpaDebugRegB == 1413141314){                 // code requis pour debloquer le registre du bistream du detecteur (EDEDE)
      roic_dbg_reg_unlocked = 1;
      gFpaDebugRegB = (int32_t)ptrA->roic_dbg_reg;   // ainsi la valeur 1413141314 ne sera pas envoyée comme bistream
   }   

   if (sw_init_done == 0)
      ptrA->roic_dbg_reg = ISC0804_BITSTREAM_FAST;  //ISC0804_BITSTREAM_FG; // valeur à l'initialisation
   if ((gFpaDebugRegB != (int32_t)ptrA->roic_dbg_reg) && (sw_init_done == 1) && (roic_dbg_reg_unlocked == 1))  // une fois debloqué, le registre peut etre changé 
      ptrA->roic_dbg_reg = (int32_t)gFpaDebugRegB;
   gFpaDebugRegB = (int32_t)ptrA->roic_dbg_reg;                                   
     
   /*----------------------------------------------------                         
    ELCORR : definition parametres                                                
   ------------------------------------------------------*/ 
   
   // starvation
   if (sw_init_done == 0)
      presentElCorrMeasAtStarvation = (uint16_t)ELCORR_DEFAULT_STARVATION_DL;      
   if (gFpaElCorrMeasAtStarvation != presentElCorrMeasAtStarvation){
      if ((gFpaElCorrMeasAtStarvation >= (uint16_t)ELCORR_STARVATION_MIN_DL) && (gFpaElCorrMeasAtStarvation <= (uint16_t)ELCORR_STARVATION_MAX_DL))
         presentElCorrMeasAtStarvation = gFpaElCorrMeasAtStarvation;  // 
   }
   gFpaElCorrMeasAtStarvation = presentElCorrMeasAtStarvation;
   
   // saturation
   if (sw_init_done == 0)
      presentElCorrMeasAtSaturation = (uint16_t)ELCORR_DEFAULT_SATURATION_DL;      
   if (gFpaElCorrMeasAtSaturation != presentElCorrMeasAtSaturation){
      if ((gFpaElCorrMeasAtSaturation >= (uint16_t)ELCORR_SATURATION_MIN_DL) && (gFpaElCorrMeasAtSaturation <= (uint16_t)ELCORR_SATURATION_MAX_DL))
         presentElCorrMeasAtSaturation = gFpaElCorrMeasAtSaturation;  // 
   }
   gFpaElCorrMeasAtSaturation = presentElCorrMeasAtSaturation;
   
   // reference1
   if (sw_init_done == 0)
      presentElCorrMeasAtReference1 = (uint16_t)ELCORR_DEFAULT_REFERENCE1_DL;      
   if (gFpaElCorrMeasAtReference1 != presentElCorrMeasAtReference1){
      if ((gFpaElCorrMeasAtReference1 >= (uint16_t)ELCORR_REFERENCE1_MIN_DL) && (gFpaElCorrMeasAtReference1 <= (uint16_t)ELCORR_REFERENCE1_MAX_DL))
         presentElCorrMeasAtReference1 = gFpaElCorrMeasAtReference1;  // 
   }
   gFpaElCorrMeasAtReference1 = presentElCorrMeasAtReference1;
   
   // reference2
   if (sw_init_done == 0)
      presentElCorrMeasAtReference2 = (uint16_t)ELCORR_DEFAULT_REFERENCE2_DL;      
   if (gFpaElCorrMeasAtReference2 != presentElCorrMeasAtReference2){
      if ((gFpaElCorrMeasAtReference2 >= (uint16_t)ELCORR_REFERENCE2_MIN_DL) && (gFpaElCorrMeasAtReference2 <= (uint16_t)ELCORR_REFERENCE2_MAX_DL))
         presentElCorrMeasAtReference2 = gFpaElCorrMeasAtReference2;  // 
   }
   gFpaElCorrMeasAtReference2 = presentElCorrMeasAtReference2;
   
   
   // ELCORR : activation via registreA
   if (sw_init_done == 0)
      gFpaDebugRegA = (int32_t)ELCORR_MODE_OFFSET_AND_GAIN_CORR;
   elcorr_reg = (uint32_t)gFpaDebugRegA;
   
   if (ptrA->fpa_diag_mode == 1)
      elcorr_reg = (uint32_t)ELCORR_MODE_OFF;
   
   if (elcorr_reg == (uint32_t)ELCORR_MODE_FREE_WHEELING_WITH_REF_CORR){         // pixeldata avec correction du gain et offset electroniques en mode continuel puis ref dans l'image
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 1;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_NORMAL_OP;  // pas necessaire
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP;
      ptrA->sat_ctrl_en             = 1;
      ptrA->real_mode_active_pixel_dly = 4;    //  
   }
      
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_FREE_WHEELING_CORR){             // pixeldata avec correction du gain et offset electroniques en mode continuel
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 1;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_NORMAL_OP;  // pas necessaire
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP;
      ptrA->sat_ctrl_en             = 1;
   }
  
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_OFFSET_AND_GAIN_CORR){           // pixeldata avec correction du gain et offset electroniques
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 1;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_NORMAL_OP;  // pas necessaire
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP;
      ptrA->sat_ctrl_en             = 1;
   }
    
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_ROIC_OUTPUT_CST_IMG){            // voutref data avec correction du gain et offset electroniques
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 1;
      ptrA->roic_cst_output_mode    = 1;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->sat_ctrl_en             = 1;                      
   }
   
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_OFFSET_CORR){                    // pixeldata avec correction de l'offset électronique seulement
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP;     
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH1;         
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;         
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH1;         
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP;     
      ptrA->sat_ctrl_en             = 1;                            
   }
 
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_DIFF_REF_IMG){                   // image map de la difference des references
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH1;    
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;    
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH2;    
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_PATH1;    
      ptrA->sat_ctrl_en             = 0;                       
   }                                                         
    
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_REF2_IMG){                       // image map de la reference 2 (1 dans le vhd)
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH1; // pas necessaire
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH2;                  
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;                  
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH2;                  
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_PATH1;                  
      ptrA->sat_ctrl_en             = 0;                                     
   }
    
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_REF1_IMG){                       // image map de la reference 1 (0 dans le vhd)
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH2;                    
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH1;  // pas necessaire 
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_PATH1;                    
      ptrA->sat_ctrl_en             = 0;                                     
   }

   else if (elcorr_reg == (uint32_t)ELCORR_MODE_OFF){                            // desactivation de toute correction electronique
      elcorr_enabled                = 0;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH2; // pas necessaire  
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_PATH1;                        
      ptrA->sat_ctrl_en             = 0;                                             
   } 
  
   // Electronic chain correction parameters
   if (elcorr_gain_corr_enabled == 1){
      elcorr_atemp_gain = (((float)ELCORR_TARGET_SATURATION_DL - (float)ELCORR_TARGET_STARVATION_DL) * ((float)presentElCorrMeasAtReference1 - (float)presentElCorrMeasAtReference2)/((float)presentElCorrMeasAtSaturation - (float)presentElCorrMeasAtStarvation));
      elcorr_atemp_ofs  = (float)ELCORR_TARGET_SATURATION_DL - elcorr_atemp_gain * ((float)presentElCorrMeasAtSaturation - (float)presentElCorrMeasAtReference1)/((float)presentElCorrMeasAtReference1 - (float)presentElCorrMeasAtReference2);
   }
   else {
      elcorr_atemp_gain = 1.0F;
      elcorr_atemp_ofs  = (float)ELCORR_TARGET_STARVATION_DL -  ((float)presentElCorrMeasAtStarvation - (float)presentElCorrMeasAtReference1);
   }  
  
   // valeurs par defaut (mode normal)                                                                                                                                               
   elcorr_comp_duration_usec                 = hh.reset_time_usec - ((float)FPA_WIDTH_MAX/(hh.pixnum_per_tap_per_mclk*hh.tap_number) + hh.lovh_mclk)*hh.mclk_period_usec;
   
   ptrA->elcorr_enabled                       = elcorr_enabled;
   ptrA->elcorr_spare1                        = 0;              
   ptrA->elcorr_spare2                        = 0;                     
                                                  
   // vhd reference 0:                                               
   ptrA->elcorr_ref_cfg_0_ref_enabled         = 1;               
   ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode  = 0;              
   ptrA->elcorr_ref_cfg_0_start_dly_sampclk   = 6; //2;        
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)(hh.pixnum_per_tap_per_mclk * elcorr_comp_duration_usec / hh.mclk_period_usec); // nombre brut d'échantillons par tap 
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     =  ptrA->elcorr_ref_cfg_0_samp_num_per_ch - (ptrA->elcorr_ref_cfg_0_start_dly_sampclk + 2.0F); // on eneleve le delai de ce chiffre et aussi 2.0 pour avoir de la marge
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)MIN(ptrA->elcorr_ref_cfg_0_samp_num_per_ch, ELCORR_REF_MAXIMUM_SAMP);
   ptrA->elcorr_ref_cfg_0_samp_mean_numerator = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elcorr_ref_cfg_0_samp_num_per_ch);     
   ptrA->elcorr_ref_cfg_0_ref_value           = (uint32_t) FLEG_VccVoltage_To_DacWord((float)ELCORR_REF1_VALUE_mV, (int8_t)ELCORR_REF_DAC_ID);  //      
   ptrA->elcorr_ref_cfg_0_forced_val_enabled  = 0; // si actif la valeur forcee remplace la valeur echantillonnee
   ptrA->elcorr_ref_cfg_0_forced_val          = 0; // ignoree si le enabled est 0
    
   // vhd reference 1: 
   ptrA->elcorr_ref_cfg_1_ref_enabled         = 1; 
   ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode  = 0;              
   ptrA->elcorr_ref_cfg_1_start_dly_sampclk   = 6; //2;        
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     = (uint32_t)(hh.pixnum_per_tap_per_mclk * elcorr_comp_duration_usec / hh.mclk_period_usec); // nombre brut d'échantillons par tap 
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     =  ptrA->elcorr_ref_cfg_1_samp_num_per_ch - (ptrA->elcorr_ref_cfg_1_start_dly_sampclk + 2.0F); // on eneleve le delai de ce chiffre et aussi 2.0 pour avoir de la marge
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     = (uint32_t)MIN(ptrA->elcorr_ref_cfg_1_samp_num_per_ch, ELCORR_REF_MAXIMUM_SAMP);
   ptrA->elcorr_ref_cfg_1_samp_mean_numerator = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elcorr_ref_cfg_1_samp_num_per_ch);     
   ptrA->elcorr_ref_cfg_1_ref_value           = (uint32_t) FLEG_VccVoltage_To_DacWord((float)ELCORR_REF2_VALUE_mV, (int8_t)ELCORR_REF_DAC_ID);  //
   ptrA->elcorr_ref_cfg_1_forced_val_enabled  = 0; // si actif la valeur forcee remplace la valeur echantillonnee
   ptrA->elcorr_ref_cfg_1_forced_val          = 0; // ignoree si le enabled est 0
    
   ptrA->elcorr_ref_dac_id                    = (uint32_t)ELCORR_REF_DAC_ID;  //       
   ptrA->elcorr_atemp_gain                    = (int32_t)elcorr_atemp_gain;      
   ptrA->elcorr_atemp_ofs                     = (int32_t)elcorr_atemp_ofs;
   
   // mode continuel
   if ((((float)hh.roic_xsize - (float)pGCRegs->Width)/2 >= (float)ELCORR_CONT_MODE_OFFSETX_MIN)  // en fenetrage centré (à réviser si decentrage), on s'assure que le AOI commence au min à ELCORR_CONT_MODE_OFFSETX_MIN pour ne pas souffrir des 64 premieres colonnes bads provenanant du changement de reference
      ||((elcorr_gain_corr_enabled == 1) && ((ptrA->roic_cst_output_mode == 1)|| (elcorr_reg == (uint32_t)ELCORR_MODE_FREE_WHEELING_CORR) || (elcorr_reg == ELCORR_MODE_FREE_WHEELING_WITH_REF_CORR))))
      ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode = 1;
     
   // desactivation en mode patron de tests
   if (ptrA->fpa_diag_mode == 1){
      ptrA->elcorr_enabled = 0;
	   ptrA->elcorr_ref_cfg_0_ref_enabled = 0;
	   ptrA->elcorr_ref_cfg_0_ref_enabled = 0;	  
   }
   
   // changement de cfg_num des qu'une nouvelle cfg est envoyée au vhd. Il s'en sert pour detecter le mode hors acquisition et ainsi en profite pour calculer le gain electronique
   ptrA->cfg_num  = ++cfg_num;
   
   // mode single sample
   ptrA->nominal_clk_id_sample_pos    = MAX(MIN((uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)(2*DEFINE_FPA_NOMINAL_MCLK_RATE_HZ), 1000), 1);
   ptrA->mclk1_id_sample_pos          = MAX(MIN((uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)(2*DEFINE_DEFINE_FPA_MCLK1_RATE_HZ), 1000), 1);
   ptrA->mclk2_id_sample_pos          = MAX(MIN((uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)(2*DEFINE_DEFINE_FPA_MCLK2_RATE_HZ), 1000), 1);
   ptrA->mclk3_id_sample_pos          = MAX(MIN((uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)(2*DEFINE_DEFINE_FPA_MCLK3_RATE_HZ), 1000), 1);

   // clipper configuration
   if (sw_init_done == 0)
      gFpaDebugRegG = (int32_t)DYNAMIC_RANGE_CLIPPING_LEVEL;
   //dynrange_factor = (float)DYNAMIC_RANGE_SCALER_SATURATION_LEVEL / (float)ptrA->dynrange_clipping_level;
   dynrange_factor                   = 1.0F;  /* on ne fait pas de rescaling */
   ptrA->dynrange_clipping_level     = (uint32_t)gFpaDebugRegG;
   ptrA->dynrange_scaling_numerator  = (uint32_t)(dynrange_factor * powf(2.0F, (float)DYNAMIC_RANGE_DIV_BIT_POS));
   //ptrA->dynrange_global_offset      = -(float)DYNAMIC_RANGE_GLOBAL_OFFSET * (dynrange_factor-1.0);
   ptrA->dynrange_global_offset      = 0; /* on ne corrige pas l'offset */
   ptrA->dynrange_op_sel             = (uint32_t)ELCORR_SW_TO_NORMAL_OP;

   // Affichage de debug
         FPA_PRINTF(" ptrA->fpa_diag_mode                         =  %d", (int32_t)( ptrA->fpa_diag_mode                          ) );
         FPA_PRINTF(" ptrA->fpa_diag_type                         =  %d", (int32_t)( ptrA->fpa_diag_type                          ) );
         FPA_PRINTF(" ptrA->fpa_pwr_on                            =  %d", (int32_t)( ptrA->fpa_pwr_on                             ) );
         FPA_PRINTF(" ptrA->fpa_acq_trig_mode                     =  %d", (int32_t)( ptrA->fpa_acq_trig_mode                      ) );
         FPA_PRINTF(" ptrA->fpa_acq_trig_ctrl_dly                 =  %d", (int32_t)( ptrA->fpa_acq_trig_ctrl_dly                  ) );
         FPA_PRINTF(" ptrA->fpa_xtra_trig_mode                    =  %d", (int32_t)( ptrA->fpa_xtra_trig_mode                     ) );
         FPA_PRINTF(" ptrA->fpa_xtra_trig_ctrl_dly                =  %d", (int32_t)( ptrA->fpa_xtra_trig_ctrl_dly                 ) );
         FPA_PRINTF(" ptrA->fpa_trig_ctrl_timeout_dly             =  %d", (int32_t)( ptrA->fpa_trig_ctrl_timeout_dly              ) );
         FPA_PRINTF(" ptrA->fpa_stretch_acq_trig                  =  %d", (int32_t)( ptrA->fpa_stretch_acq_trig                   ) );
         FPA_PRINTF(" ptrA->fpa_intf_data_source                  =  %d", (int32_t)( ptrA->fpa_intf_data_source                   ) );
         FPA_PRINTF(" ptrA->diag_ysize                            =  %d", (int32_t)( ptrA->diag_ysize                             ) );
         FPA_PRINTF(" ptrA->diag_xsize_div_tapnum                 =  %d", (int32_t)( ptrA->diag_xsize_div_tapnum                  ) );
         FPA_PRINTF(" ptrA->roic_ystart                           =  %d", (int32_t)( ptrA->roic_ystart                            ) );
         FPA_PRINTF(" ptrA->roic_ysize_div4_m1                    =  %d", (int32_t)( ptrA->roic_ysize_div4_m1                     ) );
         FPA_PRINTF(" ptrA->vdet_code                             =  %d", (int32_t)( ptrA->vdet_code                              ) );
         FPA_PRINTF(" ptrA->ref_mode_en                           =  %d", (int32_t)( ptrA->ref_mode_en                            ) );
         FPA_PRINTF(" ptrA->ref_chn_en                            =  %d", (int32_t)( ptrA->ref_chn_en                             ) );
         FPA_PRINTF(" ptrA->clamping_level                        =  %d", (int32_t)( ptrA->clamping_level                         ) );
         FPA_PRINTF(" ptrA->real_mode_active_pixel_dly            =  %d", (int32_t)( ptrA->real_mode_active_pixel_dly             ) );
         FPA_PRINTF(" ptrA->user_area_line_start_num_m1           =  %d", (int32_t)( ptrA->user_area_line_start_num_m1            ) );
         FPA_PRINTF(" ptrA->proxim_is_flegx                       =  %d", (int32_t)( ptrA->proxim_is_flegx                        ) );
         FPA_PRINTF(" ptrA->raw_area_line_start_num               =  %d", (int32_t)( ptrA->raw_area_line_start_num                ) );
         FPA_PRINTF(" ptrA->raw_area_line_end_num                 =  %d", (int32_t)( ptrA->raw_area_line_end_num                  ) );
         FPA_PRINTF(" ptrA->raw_area_sof_posf_pclk                =  %d", (int32_t)( ptrA->raw_area_sof_posf_pclk                 ) );
         FPA_PRINTF(" ptrA->raw_area_eof_posf_pclk                =  %d", (int32_t)( ptrA->raw_area_eof_posf_pclk                 ) );
         FPA_PRINTF(" ptrA->raw_area_sol_posl_pclk                =  %d", (int32_t)( ptrA->raw_area_sol_posl_pclk                 ) );
         FPA_PRINTF(" ptrA->raw_area_eol_posl_pclk                =  %d", (int32_t)( ptrA->raw_area_eol_posl_pclk                 ) );
         FPA_PRINTF(" ptrA->raw_area_lsync_start_posl_pclk        =  %d", (int32_t)( ptrA->raw_area_lsync_start_posl_pclk         ) );
         FPA_PRINTF(" ptrA->raw_area_lsync_end_posl_pclk          =  %d", (int32_t)( ptrA->raw_area_lsync_end_posl_pclk           ) );
         FPA_PRINTF(" ptrA->raw_area_lsync_num                    =  %d", (int32_t)( ptrA->raw_area_lsync_num                     ) );
         FPA_PRINTF(" ptrA->raw_area_clk_id                       =  %d", (int32_t)( ptrA->raw_area_clk_id                        ) );
         FPA_PRINTF(" ptrA->raw_area_line_period_pclk             =  %d", (int32_t)( ptrA->raw_area_line_period_pclk              ) );
         FPA_PRINTF(" ptrA->raw_area_readout_pclk_cnt_max         =  %d", (int32_t)( ptrA->raw_area_readout_pclk_cnt_max          ) );
         FPA_PRINTF(" ptrA->user_area_line_start_num              =  %d", (int32_t)( ptrA->user_area_line_start_num               ) );
         FPA_PRINTF(" ptrA->user_area_line_end_num                =  %d", (int32_t)( ptrA->user_area_line_end_num                 ) );
         FPA_PRINTF(" ptrA->user_area_sol_posl_pclk               =  %d", (int32_t)( ptrA->user_area_sol_posl_pclk                ) );
         FPA_PRINTF(" ptrA->user_area_eol_posl_pclk               =  %d", (int32_t)( ptrA->user_area_eol_posl_pclk                ) );
         FPA_PRINTF(" ptrA->user_area_clk_id                      =  %d", (int32_t)( ptrA->user_area_clk_id                       ) );
         FPA_PRINTF(" ptrA->clk_area_a_line_start_num             =  %d", (int32_t)( ptrA->clk_area_a_line_start_num              ) );
         FPA_PRINTF(" ptrA->clk_area_a_line_end_num               =  %d", (int32_t)( ptrA->clk_area_a_line_end_num                ) );
         FPA_PRINTF(" ptrA->clk_area_a_sol_posl_pclk              =  %d", (int32_t)( ptrA->clk_area_a_sol_posl_pclk               ) );
         FPA_PRINTF(" ptrA->clk_area_a_eol_posl_pclk              =  %d", (int32_t)( ptrA->clk_area_a_eol_posl_pclk               ) );
         FPA_PRINTF(" ptrA->clk_area_a_spare                      =  %d", (int32_t)( ptrA->clk_area_a_spare                       ) );
         FPA_PRINTF(" ptrA->clk_area_a_clk_id                     =  %d", (int32_t)( ptrA->clk_area_a_clk_id                      ) );
         FPA_PRINTF(" ptrA->clk_area_b_line_start_num             =  %d", (int32_t)( ptrA->clk_area_b_line_start_num              ) );
         FPA_PRINTF(" ptrA->clk_area_b_line_end_num               =  %d", (int32_t)( ptrA->clk_area_b_line_end_num                ) );
         FPA_PRINTF(" ptrA->clk_area_b_sol_posl_pclk              =  %d", (int32_t)( ptrA->clk_area_b_sol_posl_pclk               ) );
         FPA_PRINTF(" ptrA->clk_area_b_eol_posl_pclk              =  %d", (int32_t)( ptrA->clk_area_b_eol_posl_pclk               ) );
         FPA_PRINTF(" ptrA->clk_area_b_spare                      =  %d", (int32_t)( ptrA->clk_area_b_spare                       ) );
         FPA_PRINTF(" ptrA->clk_area_b_clk_id                     =  %d", (int32_t)( ptrA->clk_area_b_clk_id                      ) );
         FPA_PRINTF(" ptrA->pix_samp_num_per_ch                   =  %d", (int32_t)( ptrA->pix_samp_num_per_ch                    ) );
         FPA_PRINTF(" ptrA->hgood_samp_sum_num                    =  %d", (int32_t)( ptrA->hgood_samp_sum_num                     ) );
         FPA_PRINTF(" ptrA->hgood_samp_mean_numerator             =  %d", (int32_t)( ptrA->hgood_samp_mean_numerator              ) );
         FPA_PRINTF(" ptrA->vgood_samp_sum_num                    =  %d", (int32_t)( ptrA->vgood_samp_sum_num                     ) );
         FPA_PRINTF(" ptrA->vgood_samp_mean_numerator             =  %d", (int32_t)( ptrA->vgood_samp_mean_numerator              ) );
         FPA_PRINTF(" ptrA->good_samp_first_pos_per_ch            =  %d", (int32_t)( ptrA->good_samp_first_pos_per_ch             ) );
         FPA_PRINTF(" ptrA->good_samp_last_pos_per_ch             =  %d", (int32_t)( ptrA->good_samp_last_pos_per_ch              ) );
         FPA_PRINTF(" ptrA->adc_clk_source_phase1                 =  %d", (int32_t)( ptrA->adc_clk_source_phase1                  ) );
         FPA_PRINTF(" ptrA->adc_clk_pipe_sel1                     =  %d", (int32_t)( ptrA->adc_clk_pipe_sel1                      ) );
         FPA_PRINTF(" ptrA->spare2a                               =  %d", (int32_t)( ptrA->spare2a                                ) );
         FPA_PRINTF(" ptrA->lsydel_mclk                           =  %d", (int32_t)( ptrA->lsydel_mclk                            ) );
         FPA_PRINTF(" ptrA->boost_mode                            =  %d", (int32_t)( ptrA->boost_mode                             ) );
         FPA_PRINTF(" ptrA->speedup_lsydel                        =  %d", (int32_t)( ptrA->speedup_lsydel                         ) );
         FPA_PRINTF(" ptrA->adc_clk_source_phase2                 =  %d", (int32_t)( ptrA->adc_clk_source_phase2                  ) );
         FPA_PRINTF(" ptrA->adc_clk_pipe_sel2                     =  %d", (int32_t)( ptrA->adc_clk_pipe_sel2                      ) );
         FPA_PRINTF(" ptrA->elcorr_enabled                        =  %d", (int32_t)( ptrA->elcorr_enabled                         ) );
         FPA_PRINTF(" ptrA->elcorr_spare1                         =  %d", (int32_t)( ptrA->elcorr_spare1                          ) );
         FPA_PRINTF(" ptrA->elcorr_spare2                         =  %d", (int32_t)( ptrA->elcorr_spare2                          ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_0_ref_enabled          =  %d", (int32_t)( ptrA->elcorr_ref_cfg_0_ref_enabled           ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode   =  %d", (int32_t)( ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode    ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_0_start_dly_sampclk    =  %d", (int32_t)( ptrA->elcorr_ref_cfg_0_start_dly_sampclk     ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_0_samp_num_per_ch      =  %d", (int32_t)( ptrA->elcorr_ref_cfg_0_samp_num_per_ch       ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_0_samp_mean_numerator  =  %d", (int32_t)( ptrA->elcorr_ref_cfg_0_samp_mean_numerator   ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_0_ref_value            =  %d", (int32_t)( ptrA->elcorr_ref_cfg_0_ref_value             ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_1_ref_enabled          =  %d", (int32_t)( ptrA->elcorr_ref_cfg_1_ref_enabled           ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode   =  %d", (int32_t)( ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode    ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_1_start_dly_sampclk    =  %d", (int32_t)( ptrA->elcorr_ref_cfg_1_start_dly_sampclk     ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_1_samp_num_per_ch      =  %d", (int32_t)( ptrA->elcorr_ref_cfg_1_samp_num_per_ch       ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_1_samp_mean_numerator  =  %d", (int32_t)( ptrA->elcorr_ref_cfg_1_samp_mean_numerator   ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_1_ref_value            =  %d", (int32_t)( ptrA->elcorr_ref_cfg_1_ref_value             ) );
         FPA_PRINTF(" ptrA->elcorr_ref_dac_id                     =  %d", (int32_t)( ptrA->elcorr_ref_dac_id                      ) );
         FPA_PRINTF(" ptrA->elcorr_atemp_gain                     =  %d", (int32_t)( ptrA->elcorr_atemp_gain                      ) );
         FPA_PRINTF(" ptrA->elcorr_atemp_ofs                      =  %d", (int32_t)( ptrA->elcorr_atemp_ofs                       ) );
         FPA_PRINTF(" ptrA->elcorr_ref0_op_sel                    =  %d", (int32_t)( ptrA->elcorr_ref0_op_sel                     ) );
         FPA_PRINTF(" ptrA->elcorr_ref1_op_sel                    =  %d", (int32_t)( ptrA->elcorr_ref1_op_sel                     ) );
         FPA_PRINTF(" ptrA->elcorr_mult_op_sel                    =  %d", (int32_t)( ptrA->elcorr_mult_op_sel                     ) );
         FPA_PRINTF(" ptrA->elcorr_div_op_sel                     =  %d", (int32_t)( ptrA->elcorr_div_op_sel                      ) );
         FPA_PRINTF(" ptrA->elcorr_add_op_sel                     =  %d", (int32_t)( ptrA->elcorr_add_op_sel                      ) );
         FPA_PRINTF(" ptrA->elcorr_spare3                         =  %d", (int32_t)( ptrA->elcorr_spare3                          ) );
         FPA_PRINTF(" ptrA->sat_ctrl_en                           =  %d", (int32_t)( ptrA->sat_ctrl_en                            ) );
         FPA_PRINTF(" ptrA->cfg_num                               =  %d", (int32_t)( ptrA->cfg_num                                ) );
         FPA_PRINTF(" ptrA->elcorr_spare4                         =  %d", (int32_t)( ptrA->elcorr_spare4                          ) );
         FPA_PRINTF(" ptrA->roic_cst_output_mode                  =  %d", (int32_t)( ptrA->roic_cst_output_mode                   ) );
         FPA_PRINTF(" ptrA->adc_clk_source_phase3                 =  %d", (int32_t)( ptrA->adc_clk_source_phase3                  ) );
         FPA_PRINTF(" ptrA->adc_clk_pipe_sel3                     =  %d", (int32_t)( ptrA->adc_clk_pipe_sel3                      ) );
         FPA_PRINTF(" ptrA->roic_dbg_reg                          =  %d", (int32_t)( ptrA->roic_dbg_reg                           ) );
         FPA_PRINTF(" ptrA->roic_test_row_en                      =  %d", (int32_t)( ptrA->roic_test_row_en                       ) );
         FPA_PRINTF(" ptrA->adc_clk_source_phase4                 =  %d", (int32_t)( ptrA->adc_clk_source_phase4                  ) );
         FPA_PRINTF(" ptrA->adc_clk_pipe_sel4                     =  %d", (int32_t)( ptrA->adc_clk_pipe_sel4                      ) );
         FPA_PRINTF(" ptrA->single_samp_mode_en                   =  %d", (int32_t)( ptrA->single_samp_mode_en                    ) );
         FPA_PRINTF(" ptrA->nominal_clk_id_sample_pos             =  %d", (int32_t)( ptrA->nominal_clk_id_sample_pos              ) );
         FPA_PRINTF(" ptrA->mclk1_id_sample_pos                   =  %d", (int32_t)( ptrA->mclk1_id_sample_pos                    ) );
         FPA_PRINTF(" ptrA->mclk2_id_sample_pos                   =  %d", (int32_t)( ptrA->mclk2_id_sample_pos                    ) );
         FPA_PRINTF(" ptrA->mclk3_id_sample_pos                   =  %d", (int32_t)( ptrA->mclk3_id_sample_pos                    ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_0_forced_val_enabled   =  %d", (int32_t)( ptrA->elcorr_ref_cfg_0_forced_val_enabled    ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_0_forced_val           =  %d", (int32_t)( ptrA->elcorr_ref_cfg_0_forced_val            ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_1_forced_val_enabled   =  %d", (int32_t)( ptrA->elcorr_ref_cfg_1_forced_val_enabled    ) );
         FPA_PRINTF(" ptrA->elcorr_ref_cfg_1_forced_val           =  %d", (int32_t)( ptrA->elcorr_ref_cfg_1_forced_val            ) );
         FPA_PRINTF(" ptrA->dynrange_scaling_numerator            =  %d", (int32_t)( ptrA->dynrange_scaling_numerator             ) );
         FPA_PRINTF(" ptrA->dynrange_clipping_level               =  %d", (int32_t)( ptrA->dynrange_clipping_level                ) );
         FPA_PRINTF(" ptrA->dynrange_global_offset                =  %d", (int32_t)( ptrA->dynrange_global_offset                 ) );
         FPA_PRINTF(" ptrA->dynrange_op_sel                       =  %d", (int32_t)( ptrA->dynrange_op_sel                        ) );

   // envoi de la configuration de l'électronique de proximité (les DACs en l'occurrence) par un autre canal 
   FPA_SendProximCfg(&ProximCfg, ptrA);
    
   // envoi du reste de la config 
   WriteStruct(ptrA);
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la température du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(t_FpaIntf *ptrA)
{
   float diode_voltage;
   float temperature;

   FPA_GetStatus(&gStat, ptrA);

   diode_voltage = (float)gStat.fpa_temp_raw * ((float)FPA_TEMP_READER_FULL_SCALE_mV/1000.0F) / (exp2f(FPA_TEMP_READER_ADC_DATA_RES) * (float)FPA_TEMP_READER_GAIN);
   
   if (gStat.fpa_init_done == 0) {
      return FPA_INVALID_TEMP;
   }
   else{ 
      // utilisation  des valeurs de flashsettings
      temperature  = flashSettings.FPATemperatureConversionCoef4 * powf(diode_voltage,4);
      temperature += flashSettings.FPATemperatureConversionCoef3 * powf(diode_voltage,3);
      temperature += flashSettings.FPATemperatureConversionCoef2 * powf(diode_voltage,2);
      temperature += flashSettings.FPATemperatureConversionCoef1 * diode_voltage;
      temperature += flashSettings.FPATemperatureConversionCoef0;
   
      // Si flashsettings non programmés alors on utilise les valeurs par defaut
      if ((flashSettings.FPATemperatureConversionCoef4 == 0) && (flashSettings.FPATemperatureConversionCoef3 == 0) &&
          (flashSettings.FPATemperatureConversionCoef2 == 0) && (flashSettings.FPATemperatureConversionCoef1 == 0) &&
          (flashSettings.FPATemperatureConversionCoef0 == 0)) {
   	   // courbe de conversion de Sofradir pour une polarisation de 100µA
   	   temperature  =  -170.50F * powf(diode_voltage,4);
   	   temperature +=   173.45F * powf(diode_voltage,3);
   	   temperature +=   137.86F * powf(diode_voltage,2);
         temperature += (-667.07F * diode_voltage) + 623.1F - 0.5F;  // 625 remplacé par 623.1- 0.5 en guise de calibration de la diode
   
         // courbe de conversion de D670 avec une polarisation de 10µA sur carte EFa-00291 qui est un fleX
         if (gStat.flegx_present == 0){
            temperature  =  -426.6946F * powf(diode_voltage,4);
            temperature +=  1089.8000F * powf(diode_voltage,3);
            temperature += -1082.8000F * powf(diode_voltage,2);
            temperature += (  50.8778F * diode_voltage) + 461.5899F;
         }
      }
      
      return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius
   }     
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au isc0804 avec une config 
//--------------------------------------------------------------------------
void FPA_SpecificParams(isc0804_2k_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{                                                                                                          
   // parametres statiques
   ptrH->mclk_period_usec        = 1e6F/(float)FPA_MCLK_RATE_HZ;   
   ptrH->tap_number              = (float)FPA_NUMTAPS;
   ptrH->pixnum_per_tap_per_mclk = 2.0F;
   ptrH->reset_time_usec         = 7.0F; 
   ptrH->int_time_offset_usec    = 0.3F;
   ptrH->fovh_line               = 1.0F;     // ligne de tests du ISC0804
   ptrH->lovh_mclk               = LINE_PAUSE;    //1.0F;     // duree du lsync + line pause;
   ptrH->lsydel_mclk             = 144.0F;
   ptrH->vhd_delay_mclk          = 7.0F;
   ptrH->adc_sync_dly_mclk       = (float)FPA_MCLK_RATE_HZ/(float)ADC_SAMPLING_RATE_HZ;  // le coût maximal par ligne de lecture du synchronisateur en coup de MCLK
   ptrH->pclk_rate_hz            = ptrH->pixnum_per_tap_per_mclk * (float)FPA_MCLK_RATE_HZ;

   /*--------------------- CALCULS-------------------------------------------------------------
      Attention aux modifs en dessous de cette ligne! Y bien réfléchir avant de les faire
   -----------------------------------------------------------------------------------------  */ 
   speedup_ovh_lines               = 1; // Acceleration of the 2 overhead lines (first & last)
   speedup_lsync                   = 0; // Acceleration of all lSYNC.
   speedup_raw_area                = 1; // Acceleration of raw area
   
   // fast windowing
   ptrH->lsydel_clock_factor         =  MAX(1.0F, ((float)ROIC_LSYDEL_AREA_FAST_CLK_RATE_HZ/(float)FPA_MCLK_RATE_HZ)*(float)speedup_lsydel);
   ptrH->ovh_lines_clock_factor     =  MAX(1.0F, ((float)ROIC_SAMPLE_ROW_FAST_CLK_RATE_HZ/(float)FPA_MCLK_RATE_HZ)*(float)speedup_ovh_lines);
   ptrH->lsync_clock_factor          =  MAX(1.0F, ((float)ROIC_LSYNC_FAST_CLK_RATE_HZ/(float)FPA_MCLK_RATE_HZ)*(float)speedup_lsync);
   ptrH->raw_area_clock_factor       =  MAX(1.0F, ((float)ROIC_UNUSED_AREA_FAST_CLK_RATE_HZ/(float)FPA_MCLK_RATE_HZ)*(float)speedup_raw_area);
   ptrH->roic_xsize                  = (float)FPA_WIDTH_MAX;
   // fenetre qui sera demandée au ROIC du FPA
   //   if ((uint8_t)FPA_FORCE_CENTER == 1)
      ptrH->roic_xstart = ((float)FPA_WIDTH_MAX - ptrH->roic_xsize)/2.0F;          // à cause du centrage
   //   else
   // ptrH->roic_xstart    = (ptrH->tap_number*ptrH->pixnum_per_tap_per_mclk)*floorf(pGCRegs->OffsetX/(ptrH->tap_number*ptrH->pixnum_per_tap_per_mclk)); // on prend le multiple de 32 immediatement inférieur à OffsetX    
   
   ptrH->roic_ystart    = (uint32_t)pGCRegs->OffsetY;
   ptrH->roic_ysize     = (float)pGCRegs->Height;

   // Stretching of the user area to account for ROIC pipe delay application (domain clock change on FPA_MCLK are applied with 1 cycle of delay).
   if ((float)pGCRegs->Width < (float)FPA_WIDTH_MAX) {
      if (speedup_raw_area == 1)
         ptrH->line_stretch_mclk = (float)ISC0804_2K_FASTWINDOW_STRECTHING_AREA_MCLK;
      else
         ptrH->line_stretch_mclk = 0.0F;
   }
   else {
      ptrH->line_stretch_mclk = 0.0F;
   }
      
   // readout time
   // readout part 1 (user area): All user area (excluding LSYNC). Maximum of 20 Nominal MCLK cycles.
   ptrH->readout_mclk  = (pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) +  ptrH->line_stretch_mclk)*pGCRegs->Height;

   // readout part 2 (2 lines ovh) :  Overhead lines (first and last) are accelerated (excluding LSYNC)
   ptrH->readout_mclk  += (OVH_LINES_NUM*ptrH->roic_xsize/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number))/ptrH->ovh_lines_clock_factor;

   // readout part 3 (lovh : lsync) : All LSYNC (including the one of first and last overhead line) are on nominal mclk (they are not accelerated)
   ptrH->readout_mclk  += (ptrH->roic_ysize + OVH_LINES_NUM)*(1.0F/ptrH->lsync_clock_factor);
   
   // readout part 4 (raw area) : This represent the accelerated area (only present in subwindow)
   ptrH->readout_mclk  += (1.0F/ptrH->raw_area_clock_factor)*((ptrH->roic_xsize - pGCRegs->Width)/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) -  ptrH->line_stretch_mclk)*(ptrH->roic_ysize);

   // readout part 5 fpa mclk is resynchronized on transition from raw area to user area. Resynchronisation can take up to maximum one "adc ref clock cycle" (half the period of the fast mclk)
   ptrH->readout_mclk  +=  (ptrH->adc_sync_dly_mclk*pGCRegs->Height)/ptrH->raw_area_clock_factor;
   
   // readout en usec
   ptrH->readout_usec   = ptrH->readout_mclk * ptrH->mclk_period_usec;

   // delay
   ptrH->lsydel_usec          = (ptrH->lsydel_mclk/ptrH->lsydel_clock_factor) * ptrH->mclk_period_usec; // lsydel delay is accelerated on fast mclk
   ptrH->fpa_delay_usec       = ptrH->lsydel_usec + ptrH->reset_time_usec + ptrH->int_time_offset_usec;
   ptrH->vhd_delay_usec       = ptrH->vhd_delay_mclk * ptrH->mclk_period_usec;
   ptrH->delay_usec           = ptrH->fpa_delay_usec + ptrH->vhd_delay_usec;
   
   if (exposureTime_usec - ptrH->int_time_offset_usec >= 1.0F*ptrH->mclk_period_usec)
      ptrH->int_signal_high_time_usec = exposureTime_usec - ptrH->int_time_offset_usec;
   else
      ptrH->int_signal_high_time_usec = 1.0F*ptrH->mclk_period_usec;   // ne doit jamais arriver

   //calcul de la periode minimale
   ptrH->frame_period_min_usec = ptrH->int_signal_high_time_usec + ptrH->delay_usec + ptrH->readout_usec;

   //autres calculs
   ptrH->frame_period_coef = MAX(1.0F, (float)flashSettings.AcquisitionFrameRateMaxDivider);   // protection contre les valeurs accidentelles negatives ou nulles
   ptrH->mode_int_end_to_trig_start_dly_usec     = ptrH->frame_period_min_usec - ptrH->int_signal_high_time_usec - ptrH->vhd_delay_usec;  // utilisé en mode int_end_trig_start. % pour le isc0804, ptrH.reset_time_usec est vu dans le vhd comme un prolongement du temps d'integration
   ptrH->mode_readout_end_to_trig_start_dly_usec = 0.3;
   ptrH->mode_trig_start_to_trig_start_dly_usec  = (ptrH->frame_period_coef*ptrH->frame_period_min_usec - ptrH->int_time_offset_usec - 2.0F*ptrH->vhd_delay_usec);  // on se donne des marges supplémentaires

   //calcul du frame rate maximal
   ptrH->frame_rate_max_hz = 1.0F/(ptrH->frame_period_min_usec*1e-6);
}
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate, MaxFrameRate_limit;
   isc0804_2k_param_t hh;
   
   // Find max frame rate limit at null exposure time
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);
   MaxFrameRate_limit = hh.frame_rate_max_hz / hh.frame_period_coef;

   // Find max frame rate at current exposure time and limit the result
   FPA_SpecificParams(&hh,(float)pGCRegs->ExposureTime, pGCRegs);
   MaxFrameRate = MIN(hh.frame_rate_max_hz, MaxFrameRate_limit);

   // ENO: 10 sept 2016: Apply margin 
   MaxFrameRate = MaxFrameRate * (1.0F - gFpaPeriodMinMargin);
   
   // Round maximum frame rate
   MaxFrameRate = floorMultiple(MaxFrameRate, 0.01);

   return MaxFrameRate;                          
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir le ExposureMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   isc0804_2k_param_t hh;
   float periodMinWithNullExposure_usec;
   float presentPeriod_sec;
   float max_exposure_usec;
   float fpaAcquisitionFrameRate;

   // ENO: 10 sept 2016: d'entrée de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur   
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);
   
   // ENO: 10 sept 2016: tout reste inchangé
   FPA_SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition était nulle
   periodMinWithNullExposure_usec = hh.frame_period_min_usec;
   presentPeriod_sec = 1.0F/fpaAcquisitionFrameRate; // periode avec le frame rate actuel.
   
   max_exposure_usec = (presentPeriod_sec*1e6F - periodMinWithNullExposure_usec);

   // Round exposure time
   max_exposure_usec = floorMultiple(max_exposure_usec, 0.1);

   // Limit exposure time
   max_exposure_usec = MIN(MAX(max_exposure_usec, pGCRegs->ExposureTimeMin), FPA_MAX_EXPOSURE);
   
   return max_exposure_usec;
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir les statuts au complet
//--------------------------------------------------------------------------
void FPA_GetStatus(t_FpaStatus *Stat, t_FpaIntf *ptrA)
{ 
   uint32_t temp_32b;
   extern gcRegistersData_t gcRegsData;

   Stat->adc_oper_freq_max_khz   = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x00);    
   Stat->adc_analog_channel_num  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x04);   
   Stat->adc_resolution          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x08);   
   Stat->adc_brd_spare           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x0C);  
   Stat->ddc_fpa_roic            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x10);    
   Stat->ddc_brd_spare           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x14);  
   Stat->flex_fpa_roic           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x18);   
   Stat->flex_fpa_input          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x1C);        
   Stat->flex_ch_diversity_num   = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x20);                        
   Stat->cooler_volt_min_mV      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x24); 
   Stat->cooler_volt_max_mV      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x28); 
   Stat->fpa_temp_raw            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x2C);                                
   Stat->global_done             = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x30);        
   Stat->fpa_powered             = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x34);        
   Stat->cooler_powered          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x38);                                     
   Stat->errors_latchs           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x3C);
   Stat->intf_seq_stat                       = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x40);
   Stat->data_path_stat                      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x44);
   Stat->trig_ctler_stat                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x48);
   Stat->fpa_driver_stat                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x4C);
   Stat->adc_ddc_detect_process_done   = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x50);
   Stat->adc_ddc_present               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x54);
   Stat->flex_flegx_detect_process_done      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x58);
   Stat->flex_flegx_present                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x5C);
   Stat->id_cmd_in_error               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x60);
   Stat->fpa_serdes_done               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x64);
   Stat->fpa_serdes_success            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x68);
   temp_32b                            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x6C);
   memcpy(Stat->fpa_serdes_delay, (uint8_t *)&temp_32b, sizeof(Stat->fpa_serdes_delay));
   Stat->fpa_serdes_edges[0]           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x70);
   Stat->fpa_serdes_edges[1]           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x74);
   Stat->fpa_serdes_edges[2]           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x78);
   Stat->fpa_serdes_edges[3]           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x7C);
   Stat->hw_init_done                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x80);
   Stat->hw_init_success               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x84);
   Stat->flegx_present                 =((Stat->flex_flegx_present & Stat->adc_brd_spare) & 0x01);
   
   Stat->prog_init_done                = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x88);
   Stat->cooler_on_curr_min_mA         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x8C);
   Stat->cooler_off_curr_max_mA        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x90);   
                 
   Stat->acq_trig_cnt                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x94);
   Stat->acq_int_cnt                   = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x98);
   Stat->fpa_readout_cnt               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x9C);        
   Stat->acq_readout_cnt               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA0);  
   Stat->out_pix_cnt_min               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA4);  
   Stat->out_pix_cnt_max               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA8);
   Stat->trig_to_int_delay_min         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xAC);
   Stat->trig_to_int_delay_max         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB0);
   Stat->int_to_int_delay_min          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB4);
   Stat->int_to_int_delay_max          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB8);
   Stat->fast_hder_cnt                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xBC);
   
   // generation de fpa_init_done et fpa_init_success
   Stat->fpa_init_success = (Stat->hw_init_success & sw_init_success);
   Stat->fpa_init_done = (Stat->hw_init_done & sw_init_done);
   
   // profiter pour mettre à jour la variable globale (interne au driver) de statut  
   gStat = *Stat;
  
  // generation de sw_init_done et sw_init_success
   if ((gStat.hw_init_done == 1) && (sw_init_done == 0)){
      FPA_SendConfigGC(ptrA, &gcRegsData);    // cet envoi permet de reinitialiser le vhd avec les params requis puisque le type de hw présent est conniu maintenant (Stat->hw_init_done == 1).
      sw_init_done = 1;                       // le sw est initialisé. il ne restera que le vhd qui doit s'initialiser de nouveau 
      sw_init_success = 1;
   } 
}

//--------------------------------------------------------------------------
// Pour afficher le feedback de FPA_INTF_CFG
//--------------------------------------------------------------------------
void FPA_PrintConfig(const t_FpaIntf *ptrA)
{
   FPA_INF("This functionality is not supported for this FPA");
//   uint32_t idx = 0;
//
//   FPA_INF("int_time = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;

}


//////////////////////////////////////////////////////////////////////////////                                                                          
//  I N T E R N A L    F U N C T I O N S 
////////////////////////////////////////////////////////////////////////////// 

//--------------------------------------------------------------------------
// Informations sur les drivers C utilisés. 
//--------------------------------------------------------------------------
void  FPA_SoftwType(const t_FpaIntf *ptrA)
{
   AXI4L_write32(FPA_ROIC, ptrA->ADD + AW_FPA_ROIC_SW_TYPE);          
   AXI4L_write32(FPA_OUTPUT_TYPE, ptrA->ADD + AW_FPA_OUTPUT_SW_TYPE);
   AXI4L_write32(FPA_INPUT_TYPE, ptrA->ADD + AW_FPA_INPUT_SW_TYPE);
}

//--------------------------------------------------------------------------
// Conversion de VccVoltage_mV en DAC Word 
//-------------------------------------------------------------------------- 
// VccVoltage_mV : en milliVolt, tension de sortie des LDO du FLeG 
// VccPosition   : position du LDO . Attention! VccPosition = FLEG_VCC_POSITION où FLEG_VCC_POSITION est la position sur le FLEG (il va de 1 à 8) 
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition)
{  
   float Rs, Rd, RL, Is, DacVoltage_Volt, DacWordTemp;
   uint32_t DacWord;
   
   if ((VccPosition == 1) || (VccPosition == 2) || (VccPosition == 3) || (VccPosition == 8)){   // les canaux VCC1, VCC2, VCC3 et VCC8 sont identiques à VCC1
      Rs = 24.9e3F;    // sur EFA-00266-001, vaut R42
      Rd = 1000.0F;    // sur EFA-00266-001, vaut R41
      RL = 3.01e3F;    // sur EFA-00266-001, vaut R35
      Is = 100e-6F;    // sur EFA-00266-001, vaut le courant du LT3042
   }
   else{                                                   // les canaux VCC4, VCC5, VCC6, et VCC7 sont identiques à VCC4
      Rs = 4.99e3F;    // sur EFA-00266-001, vaut R30
      Rd = 24.9F;      // sur EFA-00266-001, vaut R29
      RL = 806.0F;     // sur EFA-00266-001, vaut R28
      Is = 100e-6F;    // sur EFA-00266-001, vaut le courant du LT3042
   }
   // calculs de la tension du dac en volt
   DacVoltage_Volt =  ((1.0F + RL/Rd)*VccVoltage_mV/1000.0F - (Rs + RL + RL/Rd*Rs)*Is)/(RL/Rd);
            
   // deduction du bitstream du DAC
   DacWordTemp = exp2f((float)FLEG_DAC_RESOLUTION_BITS) * DacVoltage_Volt/((float)FLEG_DAC_REF_VOLTAGE_V*(float)FLEG_DAC_REF_GAIN);
   DacWord = (uint32_t) MAX(MIN(roundf(DacWordTemp), 16383.0F), 0.0F);
   
   return DacWord;
}

//--------------------------------------------------------------------------
// Conversion de DAC Word  en VccVoltage_mV
//-------------------------------------------------------------------------- 
// VccVoltage_mV : en milliVolt, tension de sortie des LDO du FLeG 
// VccPosition   : position du LDO . Attention! VccPosition = FLEG_VCC_POSITION où FLEG_VCC_POSITION est la position sur le FLEG (il va de 1 à 8) 
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition)
{  
   float Rs, Rd, RL, Is, DacVoltage_Volt, VccVoltage_mV;
   uint32_t DacWordTemp;
   
   if ((VccPosition == 1) || (VccPosition == 2) || (VccPosition == 3) || (VccPosition == 8)){   // les canaux VCC1, VCC2, VCC3 et VCC8 sont identiques à VCC1
      Rs = 24.9e3F;    // sur EFA-00266-001, vaut R42
      Rd = 1000.0F;    // sur EFA-00266-001, vaut R41
      RL = 3.01e3F;    // sur EFA-00266-001, vaut R35
      Is = 100e-6F;    // sur EFA-00266-001, vaut le courant du LT3042
   }
   else{                                                   // les canaux VCC4, VCC5, VCC6, et VCC7 sont identiques à VCC4
      Rs = 4.99e3F;    // sur EFA-00266-001, vaut R30
      Rd = 24.9F;      // sur EFA-00266-001, vaut R29
      RL = 806.0F;     // sur EFA-00266-001, vaut R28
      Is = 100e-6F;    // sur EFA-00266-001, vaut le courant du LT3042
   }
   
   // deduction de la tension du DAC 
   DacWordTemp =  (uint32_t) MAX(MIN(DacWord, 16383), 0);   
   DacVoltage_Volt = (float)DacWordTemp * ((float)FLEG_DAC_REF_VOLTAGE_V*(float)FLEG_DAC_REF_GAIN)/exp2f((float)FLEG_DAC_RESOLUTION_BITS);
   
   //calculs de la tension du LDO en volt
   VccVoltage_mV = 1000.0F * (DacVoltage_Volt * (RL/Rd) + (Rs + RL + RL/Rd*Rs)*Is)/(1.0F + RL/Rd);
   
   return roundf(VccVoltage_mV);
}

//------------------------------------------------
// Envoi de la config des dacs
//-----------------------------------------------
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA)
{
   uint8_t ii = 0;
   
   // envoi config des Dacs
   while(ii < TOTAL_DAC_NUM)
   {
      AXI4L_write32(ptrD->vdac_value[ii], ptrA->ADD + AW_DAC_CFG_BASE_ADD + 4*ii);  // dans le vhd, division par 4 avant entrée dans ram
      ii++;
   }
}

