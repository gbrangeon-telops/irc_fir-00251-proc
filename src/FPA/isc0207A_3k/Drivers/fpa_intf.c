/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 23777 $
-- $Author: enofodjie $
-- $LastChangedDate: 2019-06-21 06:39:32 -0400 (ven., 21 juin 2019) $
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
#define XTRA_TRIG_FREQ_MAX_HZ             10        // soit une frequence de 10Hz         
  
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
#define AR_PRIVATE_STATUS_BASE_ADD        0x04C4    // adresse de base des statuts specifiques ou privées
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

// adresse d'ecriture signifiant la fin de la commande serielle pour le vhd
#define AW_SERIAL_CFG_END_ADD             (0x0FFC | AW_SERIAL_CFG_SWITCH_ADD)   

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x12      // 0x12 -> 0207 . Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL
#define FPA_INPUT_TYPE                    0x03      // 0x03 -> input LVTTL50 .provient du fichier fpa_common_pkg.vhd. La valeur 0x03 est celle de LVTTL50

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

// horloge des ADCs
#define ADC_SAMPLING_RATE_HZ  (2*FPA_MCLK_RATE_HZ)

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

#define ISC0207_REF_VOLTAGE_MIN_mV         700
#define ISC0207_REF_VOLTAGE_MAX_mV        4500

#define ISC0207_VDETCOM_VOLTAGE_MIN_mV    1700
#define ISC0207_VDETCOM_VOLTAGE_MAX_mV    5300

#define ISC0207_REFOFS_VOLTAGE_MIN_mV     502
#define ISC0207_REFOFS_VOLTAGE_MAX_mV     5300

#define TOTAL_DAC_NUM                     8            // 8 dac au total
#define ISC0207_FASTWINDOW_STRECTHING_AREA_MCLK  1     // largeur de la zone d'exclusion/etirement du fast windowing 
#define ROIC_UNUSED_AREA_CLK_RATE_HZ     (2*FPA_MCLK_RATE_HZ)

// Electrical correction : references
#define ELCORR_REF1_VALUE_mV              1800                
#define ELCORR_REF2_VALUE_mV              4100
#define ELCORR_REF_DAC_ID                 4           // position (entre 1 et 8) du dac dédié aux references 
#define ELCORR_REF_MAXIMUM_SAMP           120         // le nombre de sample au max supporté par le vhd

// Electrical correction : embedded switches control
#define ELCORR_SW_TO_PATH1                0x01
#define ELCORR_SW_TO_PATH2                0x02
#define ELCORR_SW_TO_NORMAL_OP            0x03 

#define ELCORR_CONT_MODE_OFFSETX_MIN      320 // 128 // FPA_WIDTH_MAX permet de ne plus être en mode continuel de calcul du gain. ENO 27 avril 2019: Pour le ISC020, ne jamais le faire car OUTR n'est pas deconnecté

// Electrical correction : valeurs par defaut si aucune mesure dispo dans les flashsettings
#define ELCORR_DEFAULT_STARVATION_DL      560         // @ centered pix (160, 128)
#define ELCORR_DEFAULT_SATURATION_DL      16200       // @ centered pix (160, 128)
#define ELCORR_DEFAULT_REFERENCE1_DL      8225        // @ centered pix (160, 128)
#define ELCORR_DEFAULT_REFERENCE2_DL      458         // @ centered pix (160, 128)

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
#define ELCORR_TARGET_STARVATION_DL       650         // @ centered pix (160, 128)
#define ELCORR_TARGET_SATURATION_DL       16000       // @ centered pix (160, 128)

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

// mandatory columns
#define ISC0207_WINDOW_MANDATORY_COLUMN_POS1       128
#define ISC0207_WINDOW_MANDATORY_COLUMN_POS2       191

struct s_ProximCfgConfig 
{   
   uint32_t  vdac_value[(uint8_t)TOTAL_DAC_NUM];
   uint32_t  spare1;                       
   uint32_t  spare2;   
};                                  
typedef struct s_ProximCfgConfig ProximCfg_t;

// structure interne pour les parametres du 0207
struct isc0207_param_s             // 
{					   
   float mclk_period_usec;
   float tap_number;
   float pixnum_per_tap_per_mclk;
   float fpa_delay_mclk;
   float vhd_delay_mclk;
   float delay_mclk;
   float lovh_mclk;
   float fovh_line;
   float tsh_min_usec;
   float trst_min_usec;
   float itr_tri_min_usec;
   float int_time_offset_usec;     
   
   // fenetre demandée par l'usager
   float user_xstart;        // colonne de depart de la fenetre usager (premiere position = 0)
   float user_xend;          // colonne de fin de la fenetre usager
   float user_ystart;
   float user_yend;   
   
   // fenetre qui sera demandée au détecteur
   float roic_xstart;
   float roic_xsize;
   float roic_xend;
   float roic_ystart;
   float roic_ysize;   
   float roic_yend;
   
   float readout_mclk;
   float readout_usec;
   float fpa_delay_usec;
   float vhd_delay_usec;
   float delay_usec;
   float fsync_high_min_usec;
   float fsync_low_usec;
   float tri_int_part_usec;
   float tri_min_window_part_usec;
   float tri_min_usec;
   float frame_period_min_usec;
   float frame_rate_max_hz;
   float unused_area_clock_factor;
   float adc_sync_dly_mclk;
   float line_stretch_mclk;

   float pclk_rate_hz;
};
typedef struct isc0207_param_s  isc0207_param_t;

// Global variables
t_FpaStatus gStat;                        // devient une variable globale
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
uint32_t sw_init_done = 0;
uint32_t sw_init_success = 0;
ProximCfg_t ProximCfg = {{12812, 12812, 12812, 8372, 8440, 12663, 5062, 12812}, 0, 0};   // les valeurs d'initisalisation des dacs sont les 8 premiers chiffres

// definition et activation des accelerateurs
uint8_t speedup_unused_area = 1;          // les speed_up n'ont que deux valeurs : 0 ou 1
uint8_t itr_mode_enabled;
uint8_t burst_mode_enabled = 0;

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA);
void FPA_SpecificParams(isc0207_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
// void FPA_GetPrivateStatus(t_FpaPrivateStatus *PrivateStat, const t_FpaIntf *ptrA);

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
   for(ii = 0; ii <= 100 ; ii++){
      AXI4L_write32(1, ptrA->ADD + AW_CTRLED_RESET);             //on active le reset
   }
   for(ii = 0; ii <= 100 ; ii++){
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
   isc0207_param_t hh;   
   uint32_t test_pattern_dly;
   extern int16_t gFpaDetectorPolarizationVoltage;
   static int16_t presentPolarizationVoltage = 700;       //  700 mV comme valeur par defaut pour GPOL
   extern float gFpaDetectorElectricalTapsRef;
   // extern float gFpaDetectorElectricalRefOffset;
   extern int32_t gFpaDebugRegA;                         // reservé ELCORR pour correction électronique (gain et/ou offset)
   extern int32_t gFpaDebugRegB;                         // reservé ROIC Bistream après validation du mot de passe
   extern int32_t gFpaDebugRegC;                         // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk
   extern int32_t gFpaDebugRegD;                         // reservé adc_clk_source_phase pour ajustement fin phase adc_clk
   extern int32_t gFpaDebugRegE;                         // reservé fpa_intf_data_source pour sortir les données des ADCs même lorsque le détecteur/flegX est absent
   extern int32_t gFpaDebugRegF;                         // reservé real_mode_active_pixel_dly pour ajustement du début AOI
   extern int32_t gFpaDebugRegG;                         // non utilisé
   // extern int32_t gFpaDebugRegH;                      // non utilisé
   uint32_t elcorr_config_mode;
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
   static uint8_t cfg_num;

   
   //if ((gStat.hw_init_done == 1) && (sw_init_done == 1))
   //   FPA_GetStatus(&gStat, ptrA);    // n'appeler dans FPA_SendConfigGC que sous condition pour eviter une boucle infinie avec FPA_GetStatus qui l'appelle egalement 


   // on bâtit les parametres specifiques du 0207
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);               //le temps d'integration est nul . Mais le VHD ajoutera le int_time pour avoir la vraie periode
   
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
   ptrA->fpa_acq_trig_mode         = (uint32_t)MODE_INT_END_TO_TRIG_START;  // permet de supporter le mode ITR et IWR et la pleine vitesse 
   ptrA->fpa_acq_trig_ctrl_dly     = 0;                                     // ENO: 20 août 2015: pour isc0207, valeur arbitraire car valeur reelle sera calculée dans le vhd à partir du temps d'integration
   ptrA->fpa_xtra_trig_mode        = (uint32_t)MODE_ITR_INT_END_TO_TRIG_START;   
   ptrA->fpa_trig_ctrl_timeout_dly = (uint32_t)((float)VHD_CLK_100M_RATE_HZ * (hh.readout_usec + hh.delay_usec)*1e-6F);   // ENO: 29 janv 2020: pour isc0207 en mode MODE_INT_END_TO_TRIG_START, la duree du timeout est fixée à celle d'une trame
   ptrA->fpa_xtra_trig_ctrl_dly    = ptrA->fpa_trig_ctrl_timeout_dly;       // ENO: 20 août 2015: pour isc0207, valeur arbitraire car valeur reelle sera calculée dans le vhd à partir du temps d'integration
   
   // parametres envoyés au VHD pour calculer fpa_acq_trig_ctrl_dly, fpa_trig_ctrl_timeout_dly, fpa_xtra_trig_ctrl_dly
   ptrA->readout_plus_delay            =  (uint32_t)((float)VHD_CLK_100M_RATE_HZ * (hh.readout_usec + hh.delay_usec - hh.vhd_delay_usec)*1e-6F);  // (readout_time + delay -vhd_delay) converti en coups de 100MHz
   ptrA->tri_min_window_part           =  (int32_t)((float)VHD_CLK_100M_RATE_HZ * hh.tri_min_window_part_usec*1e-6F);        //   tri_min_window_part_usec converti en coups de 100MHz
   ptrA->int_time_offset_mclk          =  (int32_t)((float)FPA_MCLK_RATE_HZ * hh.int_time_offset_usec*1e-6F);
   ptrA->spare2                        =  0;
   ptrA->tsh_min_minus_int_time_offset =  (int32_t)((float)VHD_CLK_100M_RATE_HZ * (hh.tsh_min_usec - hh.int_time_offset_usec)*1e-6F);    // premisse pour calcul de tri_min_int_part dans le vhd
   
   // ENO 22 sept 2015 : patch temporaire pour tenir compte des delais du patron de tests.
   // Conséquence: le patron de tests sera plus lent que le detecteur mais il ne plantera plus la camera
   if (ptrA->fpa_diag_mode == 1){
      ptrA->fpa_acq_trig_mode         = (uint32_t)MODE_ITR_INT_END_TO_TRIG_START;
      test_pattern_dly  = (uint32_t)pGCRegs->Height * (uint32_t)TEST_PATTERN_LINE_DLY;    // delay total en coups de 10 ns sur une image de patron de tests 
	   ptrA->readout_plus_delay         =  (uint32_t)((float)VHD_CLK_100M_RATE_HZ * (hh.readout_usec + hh.delay_usec - hh.vhd_delay_usec)*1e-6F) + test_pattern_dly;  // (readout_time + delay -vhd_delay) converti en coups de 100MHz + test_pattern_dly qui est deja en coups de 10 ns
   }
      
   // configuration envoyée donc au ROIC du FPA
   ptrA->roic_xsize   = (uint32_t)hh.roic_xsize;
   ptrA->roic_xstart  = (uint32_t)hh.roic_xstart;
   ptrA->roic_ystart  = (uint32_t)hh.roic_ystart;
   ptrA->roic_ysize_div2_m1 = (uint32_t)hh.roic_ysize/2 - 1;
   
   // diag window param   
   ptrA->diag_ysize             = (uint32_t)pGCRegs->Height;
   ptrA->diag_xsize_div_tapnum  = (uint32_t)pGCRegs->Width/(uint32_t)FPA_NUMTAPS;
   
   //  gain 
   ptrA->gain = FPA_GAIN_1;	//Low gain
   if (pGCRegs->SensorWellDepth == SWD_HighGain)
      ptrA->gain = FPA_GAIN_0;	//High gain
      
   // misc
   ptrA->internal_outr = 0;
   ptrA->boost_mode = 0;
   
   // delai LsyDel
   ptrA->lsydel_mclk = 2;           // LSYDEL en MCLK
   
   // Registre F : ajustement des delais de la chaine
   if (sw_init_done == 0)
      gFpaDebugRegF =  6;    // la valeur 10 est obtenue lorsque ptrA->lsydel_mclk = 0
   ptrA->real_mode_active_pixel_dly = (uint32_t)gFpaDebugRegF; 
   
   // accélerateurs 
   //  a été déjà assigné dans FPA_SpecificParams qui est déjà appelé au debut de la fonction FPA_SendConfigGC
   ptrA->speedup_lsydel          = 0;
   ptrA->speedup_sample_row      = 0;
   ptrA->speedup_lsync           = 0;
   ptrA->speedup_unused_area     = speedup_unused_area;
  
  // raw area
   ptrA->raw_area_line_start_num       = 1;
   ptrA->raw_area_line_end_num         = (uint32_t)hh.roic_ysize + ptrA->raw_area_line_start_num - 1;
   ptrA->raw_area_line_period_pclk     = ((uint32_t)hh.roic_xsize/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)+ hh.lovh_mclk) *  hh.pixnum_per_tap_per_mclk; 
   ptrA->raw_area_sof_posf_pclk        = ptrA->raw_area_line_period_pclk * (ptrA->raw_area_line_start_num - 1) + 1;                 
   ptrA->raw_area_eof_posf_pclk        = ptrA->raw_area_line_end_num * ptrA->raw_area_line_period_pclk - hh.lovh_mclk*hh.pixnum_per_tap_per_mclk;                 
   ptrA->raw_area_sol_posl_pclk        = 1;                 
   ptrA->raw_area_eol_posl_pclk        = ((uint32_t)hh.roic_xsize/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)) * hh.pixnum_per_tap_per_mclk;                 
   ptrA->raw_area_eol_posl_pclk_p1     = ptrA->raw_area_eol_posl_pclk + 1;
   ptrA->raw_area_readout_pclk_cnt_max = ptrA->raw_area_line_period_pclk * ((uint32_t)hh.roic_ysize + hh.fovh_line + ptrA->raw_area_line_start_num - 1) + 1;
   ptrA->raw_area_window_lsync_num     = (uint32_t)hh.roic_ysize;     // même si pas LSYNC pas envoyé au ROIC en mode ZDT, Le VHD le genere

   // user area
   ptrA->user_area_line_start_num      = ptrA->raw_area_line_start_num; 
   ptrA->user_area_line_end_num        = (uint32_t)pGCRegs->Height + ptrA->user_area_line_start_num - 1;     
   ptrA->user_area_sol_posl_pclk       = (uint32_t)(hh.user_xstart - hh.roic_xstart)/FPA_NUMTAPS + 1;
   ptrA->user_area_eol_posl_pclk       = ptrA->user_area_sol_posl_pclk + ((uint32_t)pGCRegs->Width/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)) * hh.pixnum_per_tap_per_mclk - 1;         
   ptrA->user_area_eol_posl_pclk_p1    = ptrA->user_area_eol_posl_pclk + 1;
   
   // stretching area
   ptrA->stretch_area_eol_posl_pclk    = ptrA->raw_area_eol_posl_pclk - (uint32_t)gFpaDebugRegG;
   if (ptrA->speedup_unused_area == 0)
      ptrA->stretch_area_sol_posl_pclk = ptrA->stretch_area_eol_posl_pclk + 1; // si ptrA->stretch_area_eol_posl_pclk < ptrA->stretch_area_sol_posl_pclk (ie largeur de zone nulle) alors le vhd comprend qu'il n'y a pas de zone d'étirement
   else
      ptrA->stretch_area_sol_posl_pclk = ptrA->stretch_area_eol_posl_pclk - hh.pixnum_per_tap_per_mclk *(uint32_t)hh.line_stretch_mclk + 1;  
   
   // nombre d'échantillons par canal  de carte ADC
   ptrA->pix_samp_num_per_ch           = (uint32_t)((float)ADC_SAMPLING_RATE_HZ/(hh.pclk_rate_hz));
   
   // echantillons choisis
   ptrA->good_samp_first_pos_per_ch    = ptrA->pix_samp_num_per_ch;     // position premier echantillon
   ptrA->good_samp_last_pos_per_ch     = ptrA->pix_samp_num_per_ch;     // position dernier echantillon
   ptrA->hgood_samp_sum_num            = ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->hgood_samp_mean_numerator     = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->hgood_samp_sum_num);                            
   ptrA->vgood_samp_sum_num            = 1;
   ptrA->vgood_samp_mean_numerator     = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->vgood_samp_sum_num);                              
   
   // les DACs (1 à 8)
   ProximCfg.vdac_value[0]             = FLEG_VccVoltage_To_DacWord(5500.0F, 1);           // DAC1 -> VPOS_OUT à 5.5V
   ProximCfg.vdac_value[1]             = FLEG_VccVoltage_To_DacWord(5500.0F, 2);           // DAC2 -> VPOS     à 5.5V
   ProximCfg.vdac_value[2]             = FLEG_VccVoltage_To_DacWord(5500.0F, 3);           // DAC3 -> VPOS_UC  à 5.5V
   ProximCfg.vdac_value[4]             = FLEG_VccVoltage_To_DacWord(2050.0F, 5);           // DAC5 -> VOS      à 1.95V   (ajustable)
   ProximCfg.vdac_value[7]             = FLEG_VccVoltage_To_DacWord(5500.0F, 8);           // DAC8 -> VPD      à 5.5V
   
   // Reference of the tap (VCC4)      
   if (gFpaDetectorElectricalTapsRef != presentElectricalTapsRef)
   {
      if ((gFpaDetectorElectricalTapsRef >= (float)ISC0207_REF_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalTapsRef <= (float)ISC0207_REF_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[3] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalTapsRef, 4);  //
   }                                                                                                       
   presentElectricalTapsRef = (float) FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[3], 4);          
   gFpaDetectorElectricalTapsRef = presentElectricalTapsRef;
   
   // VdetCom Voltage (VCC6)
   if (gFpaDetectorPolarizationVoltage != presentPolarizationVoltage)      // gFpaDetectorPolarizationVoltage est en milliVolt
   {
      if ((gFpaDetectorPolarizationVoltage >= (int16_t)ISC0207_VDETCOM_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= (int16_t)ISC0207_VDETCOM_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[5] = (int32_t) FLEG_VccVoltage_To_DacWord((float)gFpaDetectorPolarizationVoltage, 6);  // vdetCom change si la nouvelle valeur est conforme. Sinon la valeur precedente est conservée. (voir FpaIntf_Ctor) pour la valeur d'initialisation
   }
   presentPolarizationVoltage = (int16_t)(FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[5], 6));
   gFpaDetectorPolarizationVoltage = presentPolarizationVoltage;                    
   
   // adc clk source phase   
   if (sw_init_done == 0){
      gFpaDebugRegC = 2;                   //  ajustement fait avec IRC1843 qui utilise un FLEGX
      if ((gStat.hw_init_done == 1) && (gStat.flegx_present == 0))  // 
         gFpaDebugRegC = 2;                //  ajustement fait avec IRC1405 refurbished qui utilise un FLEX264
   }       
   ptrA->adc_clk_pipe_sel = (uint32_t)gFpaDebugRegC;                                              
   
   // adc clk source phase (suite)
   if (sw_init_done == 0){         
      gFpaDebugRegD = 48000;                //  ajustement refait sur M3k decentré qui utilise un FLEGX
      if ((gStat.hw_init_done == 1) && (gStat.flegx_present == 0))  // cas particulier des systèmes avec Flex 264
         gFpaDebugRegD = 144000;            //  ajustement fait avec IRC1405 refurbished qui utilise un FLEX264
   }
   ptrA->adc_clk_source_phase = (uint32_t)gFpaDebugRegD;    
   // autres    
   ptrA->boost_mode              = 0;                    
   ptrA->adc_clk_pipe_sync_pos   = 2;   // obtenu par simulation
   
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
  
     
  // correction electronique // registreA :
   if (sw_init_done == 0)
      gFpaDebugRegA = (int32_t)ELCORR_MODE_OFFSET_CORR;               // l'utilisation de OUTR sur l'électronique de proximité (FleX ou FLEGX) oblige à ne utiliser que la correction d'offset (donc la valeur 5)

   elcorr_config_mode = (uint32_t)gFpaDebugRegA;
   
   if (ptrA->fpa_diag_mode == 1)
      elcorr_config_mode = 0;
	  
   if ((elcorr_config_mode == (uint32_t)ELCORR_MODE_OFFSET_AND_GAIN_CORR) && (gStat.flegx_present == 1)){         // pixeldata avec correction du gain et offset electroniques.  N'est possible qu'avec un FLEGX avec OUTR debranché 
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 1;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_NORMAL_OP;   // pas necessaire
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP;
      ptrA->sat_ctrl_en             = 1;
   }
    
   else if ((elcorr_config_mode == (uint32_t)ELCORR_MODE_ROIC_OUTPUT_CST_IMG) && (gStat.flegx_present == 1)){      // voutref data avec correction du gain et offset electroniques. N'est possible qu'avec un FLEGX avec OUTR debranché 
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
   
   else if (elcorr_config_mode == (uint32_t)ELCORR_MODE_OFFSET_CORR){                                    // pixeldata avec correction de l'offset électronique seulement
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
 
   else if ((elcorr_config_mode == (uint32_t)ELCORR_MODE_DIFF_REF_IMG) && (gStat.flegx_present == 1)){  // image map de la difference des references
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
    
   else if ((elcorr_config_mode == (uint32_t)ELCORR_MODE_REF2_IMG)&& (gStat.flegx_present == 1)){   // image map de la reference 2 (1 dans le vhd)
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
    
   else if (elcorr_config_mode == (uint32_t)ELCORR_MODE_REF1_IMG){                                   // image map de la reference 1 (0 dans le vhd)
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

   else if (elcorr_config_mode == (uint32_t)ELCORR_MODE_OFF){                                        // desactivation de toute correction electronique
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
   elcorr_comp_duration_usec                  = hh.tsh_min_usec/2.0F; // ENO 21 juin 2020 : pour isc0207, la valeur de lsydel_mclk détermine la largeur de la zone de sampling de la reference 1
   
   ptrA->elcorr_enabled                       = elcorr_enabled;
   ptrA->elcorr_spare1                        = 0;              
   ptrA->elcorr_spare2                        = 0;                        
   
   // vhd reference 0:                                              
   ptrA->elcorr_ref_cfg_0_ref_enabled         = ptrA->elcorr_enabled;               
   ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode  = 0;              
   ptrA->elcorr_ref_cfg_0_start_dly_sampclk   = 4;        
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)(hh.pixnum_per_tap_per_mclk * elcorr_comp_duration_usec / hh.mclk_period_usec); // nombre brut d'échantillons par tap 
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     =  ptrA->elcorr_ref_cfg_0_samp_num_per_ch - (ptrA->elcorr_ref_cfg_0_start_dly_sampclk + 2.0F); // on eneleve le delai de ce chiffre et aussi 2.0 pour avoir de la marge
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)MIN(ptrA->elcorr_ref_cfg_0_samp_num_per_ch, ELCORR_REF_MAXIMUM_SAMP);
   ptrA->elcorr_ref_cfg_0_samp_mean_numerator = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elcorr_ref_cfg_0_samp_num_per_ch);     
   ptrA->elcorr_ref_cfg_0_ref_value           = ProximCfg.vdac_value[3]; // FLEG_VccVoltage_To_DacWord((float)ELCORR_REF1_VALUE_mV, (int8_t)ELCORR_REF_DAC_ID);  //      
   ptrA->elcorr_ref_cfg_0_forced_val_enabled  = 0; // si actif la valeur forcee remplace la valeur echantillonnee
   ptrA->elcorr_ref_cfg_0_forced_val          = 0; // ignoree si le enabled est 0
    
   // vhd reference 1: 
   ptrA->elcorr_ref_cfg_1_ref_enabled         = 0;  // on n'active pas la reference la reference 2 que si on a un fleGX avec un OUTR deconnecté        
   ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode  = 0;              
   ptrA->elcorr_ref_cfg_1_start_dly_sampclk   = 4;        
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
   
   // changement de cfg_num des qu'une nouvelle cfg est envoyée au vhd. Il s'en sert pour detecter le mode hors acquisition et ainsi en profite pour calculer le gain electronique
   ptrA->cfg_num = ++cfg_num;
   
   //   if ((((float)hh.roic_xsize - (float)pGCRegs->Width)/2 >= (float)ELCORR_CONT_MODE_OFFSETX_MIN)  // en fenetrage centré (à réviser si decentrage), on s'assure que le AOI commence au min à ELCORR_CONT_MODE_OFFSETX_MIN pour ne pas souffrir des 64 premieres colonnes bads provenanant du changement de reference
   //      ||((elcorr_gain_corr_enabled == 1) && (ptrA->roic_cst_output_mode == 1)))
   //      ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode = 1;
   
   // desactivation en mode patron de tests
   if (ptrA->fpa_diag_mode == 1){
      ptrA->elcorr_enabled = 0;
	   ptrA->elcorr_ref_cfg_0_ref_enabled = 0;
	   ptrA->elcorr_ref_cfg_0_ref_enabled = 0;	  
   }
   
   FPA_PRINTF("RegC Present Value = %d", gFpaDebugRegC);
   FPA_PRINTF("RegD Present Value = %d", gFpaDebugRegD);
   
   // envoi de la configuration de l'électronique de proximité (les DACs en l'occurrence) par un autre canal 
   FPA_SendProximCfg(&ProximCfg, ptrA);
   
   WriteStruct(ptrA);
   
   // statuts privés
   if (gFpaDebugRegB == 1)
   {
      FPA_INF("hh.user_xstart                     = %d", (uint32_t)hh.user_xstart                  ); 
      FPA_INF("hh.user_xend                       = %d", (uint32_t)hh.user_xend                    ); 
      FPA_INF("hh.user_ystart                     = %d", (uint32_t)hh.user_ystart                  ); 
      FPA_INF("hh.user_yend                       = %d", (uint32_t)hh.user_yend                    ); 
      FPA_INF("hh.roic_xstart                     = %d", (uint32_t)hh.roic_xstart                  ); 
      FPA_INF("hh.roic_xsize                      = %d", (uint32_t)hh.roic_xsize                   ); 
      FPA_INF("hh.roic_xend                       = %d", (uint32_t)hh.roic_xend                    ); 
      FPA_INF("hh.roic_ystart                     = %d", (uint32_t)hh.roic_ystart                  ); 
      FPA_INF("hh.roic_ysize                      = %d", (uint32_t)hh.roic_ysize                   ); 
      FPA_INF("hh.roic_yend                       = %d", (uint32_t)hh.roic_yend                    ); 
      
      
      
      
      
      FPA_INF("ptrA->fpa_diag_mode                = %d", ptrA->fpa_diag_mode                  );
      FPA_INF("ptrA->fpa_diag_type                = %d", ptrA->fpa_diag_type                  );
      FPA_INF("ptrA->fpa_pwr_on                   = %d", ptrA->fpa_pwr_on                     );
      FPA_INF("ptrA->fpa_acq_trig_mode            = %d", ptrA->fpa_acq_trig_mode              );
      FPA_INF("ptrA->fpa_acq_trig_ctrl_dly        = %d", ptrA->fpa_acq_trig_ctrl_dly          );
      FPA_INF("ptrA->fpa_xtra_trig_mode           = %d", ptrA->fpa_xtra_trig_mode             );
      FPA_INF("ptrA->fpa_xtra_trig_ctrl_dly       = %d", ptrA->fpa_xtra_trig_ctrl_dly         );
      FPA_INF("ptrA->fpa_trig_ctrl_timeout_dly    = %d", ptrA->fpa_trig_ctrl_timeout_dly      );
      FPA_INF("ptrA->fpa_stretch_acq_trig         = %d", ptrA->fpa_stretch_acq_trig           );
      FPA_INF("ptrA->diag_ysize                   = %d", ptrA->diag_ysize                     );
      FPA_INF("ptrA->diag_xsize_div_tapnum        = %d", ptrA->diag_xsize_div_tapnum          );
      FPA_INF("ptrA->roic_xstart                  = %d", ptrA->roic_xstart                    );
      FPA_INF("ptrA->roic_ystart                  = %d", ptrA->roic_ystart                    );
      FPA_INF("ptrA->roic_xsize                   = %d", ptrA->roic_xsize                     );
      FPA_INF("ptrA->roic_ysize_div2_m1           = %d", ptrA->roic_ysize_div2_m1             );
      FPA_INF("ptrA->gain                         = %d", ptrA->gain                           );
      FPA_INF("ptrA->internal_outr                = %d", ptrA->internal_outr                  );
      FPA_INF("ptrA->real_mode_active_pixel_dly   = %d", ptrA->real_mode_active_pixel_dly     );
      FPA_INF("ptrA->speedup_lsync                = %d", ptrA->speedup_lsync                  );
      FPA_INF("ptrA->speedup_sample_row           = %d", ptrA->speedup_sample_row             );
      FPA_INF("ptrA->speedup_unused_area          = %d", ptrA->speedup_unused_area            );
      FPA_INF("ptrA->raw_area_line_start_num      = %d", ptrA->raw_area_line_start_num        );
      FPA_INF("ptrA->raw_area_line_end_num        = %d", ptrA->raw_area_line_end_num          );
      FPA_INF("ptrA->raw_area_sof_posf_pclk       = %d", ptrA->raw_area_sof_posf_pclk         );
      FPA_INF("ptrA->raw_area_eof_posf_pclk       = %d", ptrA->raw_area_eof_posf_pclk         );
      FPA_INF("ptrA->raw_area_sol_posl_pclk       = %d", ptrA->raw_area_sol_posl_pclk         );
      FPA_INF("ptrA->raw_area_eol_posl_pclk       = %d", ptrA->raw_area_eol_posl_pclk         );
      FPA_INF("ptrA->raw_area_eol_posl_pclk_p1    = %d", ptrA->raw_area_eol_posl_pclk_p1      );
      FPA_INF("ptrA->raw_area_window_lsync_num    = %d", ptrA->raw_area_window_lsync_num      );
      FPA_INF("ptrA->raw_area_line_period_pclk    = %d", ptrA->raw_area_line_period_pclk      );
      FPA_INF("ptrA->raw_area_readout_pclk_cnt_max= %d", ptrA->raw_area_readout_pclk_cnt_max  );
      FPA_INF("ptrA->user_area_line_start_num     = %d", ptrA->user_area_line_start_num       );
      FPA_INF("ptrA->user_area_line_end_num       = %d", ptrA->user_area_line_end_num         );
      FPA_INF("ptrA->user_area_sol_posl_pclk      = %d", ptrA->user_area_sol_posl_pclk        );
      FPA_INF("ptrA->user_area_eol_posl_pclk      = %d", ptrA->user_area_eol_posl_pclk        );
      FPA_INF("ptrA->user_area_eol_posl_pclk_p1   = %d", ptrA->user_area_eol_posl_pclk_p1     );
      FPA_INF("ptrA->stretch_area_sol_posl_pclk   = %d", ptrA->stretch_area_sol_posl_pclk     );
      FPA_INF("ptrA->stretch_area_eol_posl_pclk   = %d", ptrA->stretch_area_eol_posl_pclk     );
      FPA_INF("ptrA->pix_samp_num_per_ch          = %d", ptrA->pix_samp_num_per_ch            );
      FPA_INF("ptrA->hgood_samp_sum_num           = %d", ptrA->hgood_samp_sum_num             );
      FPA_INF("ptrA->hgood_samp_mean_numerator    = %d", ptrA->hgood_samp_mean_numerator      );
      FPA_INF("ptrA->vgood_samp_sum_num           = %d", ptrA->vgood_samp_sum_num             );
      FPA_INF("ptrA->vgood_samp_mean_numerator    = %d", ptrA->vgood_samp_mean_numerator      );
      FPA_INF("ptrA->good_samp_first_pos_per_ch   = %d", ptrA->good_samp_first_pos_per_ch     );
      FPA_INF("ptrA->good_samp_last_pos_per_ch    = %d", ptrA->good_samp_last_pos_per_ch      );
      FPA_INF("ptrA->adc_clk_source_phase         = %d", ptrA->adc_clk_source_phase           );
      FPA_INF("ptrA->adc_clk_pipe_sel             = %d", ptrA->adc_clk_pipe_sel               );
      FPA_INF("ptrA->spare1                       = %d", ptrA->spare1                         );
      FPA_INF("ptrA->lsydel_mclk                  = %d", ptrA->lsydel_mclk                    );
      FPA_INF("ptrA->boost_mode                   = %d", ptrA->boost_mode                     );
      FPA_INF("ptrA->speedup_lsydel               = %d", ptrA->speedup_lsydel                 );
      FPA_INF("ptrA->adc_clk_pipe_sync_pos        = %d", ptrA->adc_clk_pipe_sync_pos          );
      FPA_INF("ptrA->readout_plus_delay           = %d", ptrA->readout_plus_delay             );
      FPA_INF("ptrA->tri_min_window_part          = %d", ptrA->tri_min_window_part            );
      FPA_INF("ptrA->int_time_offset_mclk         = %d", ptrA->int_time_offset_mclk           );
      FPA_INF("ptrA->spare2                       = %d", ptrA->spare2                         ); 
      
   }
}  

//--------------------------------------------------------------------------                                                                            
// Pour avoir la température du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(t_FpaIntf *ptrA)
{
   float diode_voltage;
   float temperature;
   // t_FpaStatus Stat;
   // uint8_t flegx_present;

   FPA_GetStatus(&gStat, ptrA);

   diode_voltage = (float)gStat.fpa_temp_raw * ((float)FPA_TEMP_READER_FULL_SCALE_mV/1000.0F) / (exp2f(FPA_TEMP_READER_ADC_DATA_RES) * (float)FPA_TEMP_READER_GAIN);
   
   if (gStat.fpa_init_done == 0) {
      return FPA_INVALID_TEMP;
   }
   else{ 
      // utilisation  des valeurs de flashsettings
      temperature = flashSettings.FPATemperatureConversionCoef4 * powf(diode_voltage,4);
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
   	   temperature += (-667.07F * diode_voltage) + 623.1F;  // 625 remplacé par 623 en guise de calibration de la diode
      }
      return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius
   
   }
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au ISc0207 avec une config 
//--------------------------------------------------------------------------
void FPA_SpecificParams(isc0207_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{

   extern int32_t gFpaExposureTimeOffset;
   extern int32_t gFpaDebugRegH;
   uint8_t loop_cnt;
   uint8_t smooth_img_mode;    // en smooth_img_mode, on elimine (si possible) les bandes laterales dans les sous-fenetres. Donc ce cas, il peut être necessaire de demander au detecteur une fenetre plus grande que celle demandée par l'usager.
                               // On prend plus large en vue de faire du stretching sur la fin de ligne (LSYNC). Le reste de la partie nonAI est eliminée par fastwindowing.
                               // C'est cela qui explique la diminution du frame rate lorsque le smooth_img_mode est activé. 
   // parametres statiques
   ptrH->mclk_period_usec        = 1e6F/(float)FPA_MCLK_RATE_HZ;
   ptrH->tap_number              = (float)FPA_NUMTAPS;
   ptrH->pixnum_per_tap_per_mclk = 2.0F;
   ptrH->fpa_delay_mclk          = 6.0F;   // FPA: delai de sortie des pixels après integration
   
   ptrH->vhd_delay_mclk          = 2.55F;
      
   ptrH->delay_mclk              = ptrH->fpa_delay_mclk + ptrH->vhd_delay_mclk;   //
   ptrH->lovh_mclk               = 0.0F;
   ptrH->fovh_line               = 0.0F;
  
   ptrH->tsh_min_usec            = 7.8F;
   ptrH->trst_min_usec           = 0.2F;
   
   ptrH->line_stretch_mclk       = (float)ISC0207_FASTWINDOW_STRECTHING_AREA_MCLK;

   ptrH->itr_tri_min_usec        = 2.0F; // limite inférieure de tri pour le mode ITR . Imposée par les tests de POFIMI
   ptrH->int_time_offset_usec    = 0.8F + ((float)gFpaExposureTimeOffset /(float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ)* 1e6F;  // offset total du temps d'integration
   
   ptrH->adc_sync_dly_mclk       = 0.0F;
   
   ptrH->pclk_rate_hz            = ptrH->pixnum_per_tap_per_mclk * (float)FPA_MCLK_RATE_HZ;
   
   // valeurs par defaut
   speedup_unused_area = 1;        
   itr_mode_enabled    = 1;        // ITR
   smooth_img_mode     = 1;        // par defaut, M3K est en smooth_img_mode
      
   /*--------------------- CALCULS-------------------------------------------------------------
      Attention aux modifs en dessous de cette ligne! Y bien réfléchir avant de les faire
   -----------------------------------------------------------------------------------------  */
   
   if ((pGCRegs->IntegrationMode == IM_IntegrateWhileRead) || (gFpaDebugRegH != 0))
      itr_mode_enabled = 0; 
   
   if (pGCRegs->DetectorMode == DM_Burst)       // le mode burst est explicitement demandé par l'usager
      smooth_img_mode = 0;                      // dans ce cas, on abandonne le smooth_img_mode
     
   // fenetre demandée par l'usager
   ptrH->user_xstart  = (float)pGCRegs->OffsetX;                             // colonne de depart de la fenetre usager (premiere position = 0)
   ptrH->user_xend    =  ptrH->user_xstart + (float)pGCRegs->Width - 1.0F;   // colonne de fin de la fenetre usager. (-1 à cause de l'origine à 0)
   ptrH->user_ystart  = (float)pGCRegs->OffsetY;  
   ptrH->user_yend    =  ptrH->user_ystart + (float)pGCRegs->Height - 1.0F;  // ligne de fin de la fenetre usager. (-1 à cause de l'origine à 0) 
   
   // fenetre qui sera demandée au ROIC du FPA par defaut
   ptrH->roic_xstart  = ptrH->user_xstart;          // au prime abord, la fenetre à demander au detecteur = celle de l'usager
   ptrH->roic_xend    = ptrH->user_xend;
   
   // on valide que la premiere colonne de la fenetre demandée au ROIC précède la colonne ISC0207_WINDOW_MANDATORY_COLUMN_POS1
   while(ptrH->roic_xstart > (float)ISC0207_WINDOW_MANDATORY_COLUMN_POS1){
      ptrH->roic_xstart = ptrH->roic_xstart - (float)FPA_OFFSETX_MULT;
      smooth_img_mode = 1;    // dès que la fenetre usager n'est pas centrée, on prendra plus large et donc on active obligatoirement le smooth_mode pour que la fenetre comporte peu de bandes.
   }                          // car en effet, dès que l'usager decentre sa fenetre, c'est qu'il accepte de perdre de la performance en vitesse.
   
   // on valide que la derniere colonne de la fenetre demandée au ROIC vient après la colonne ISC0207_WINDOW_MANDATORY_COLUMN_POS2
   while(ptrH->roic_xend < (float)ISC0207_WINDOW_MANDATORY_COLUMN_POS2){
      ptrH->roic_xend = ptrH->roic_xend + (float)FPA_OFFSETX_MULT;
      smooth_img_mode = 1;   // dès que la fenetre usager n'est pas centrée, on prendra plus large et donc on active obligatoirement le smooth_mode pour que la fenetre comporte peu de bandes.
   }   
   
   // taille requise lorsqu'on doit eliminer les bandes laterales, on regarde si on peut le faire. 
   loop_cnt = 0;
   while (loop_cnt < 2)            // on parcourt la boucle deux fois car la fenetre peut n'etre suffisament grande à droite au depart, et être ajustée à droite. Il va donc rester à voir à gauche. 
   {   
      if (smooth_img_mode == 1)    // smooth_img_mode explicitement demandé par l'usager
      {   
         if (ptrH->roic_xend - ptrH->user_xend >= (float)ISC0207_FASTWINDOW_STRECTHING_AREA_MCLK * ptrH->pixnum_per_tap_per_mclk * ptrH->tap_number)
         {
            if (ptrH->user_xstart - ptrH->roic_xstart >= (float)FPA_OFFSETX_MULT){
                  // les deux conditions remplies signifient qu'on pourra avoir effectivement le smooth_im_mode comme demandé par l'usager
            }
            else  // si la fenetre n'est pas suffisamment grande à gauche pour le smooth_img_mode, on voit si on peut prendre large à gauche 
            {
               if (ptrH->roic_xstart - (float)FPA_OFFSETX_MULT >= 0.0F)
                  ptrH->roic_xstart = ptrH->roic_xstart - (float)FPA_OFFSETX_MULT;
               else // sinon c'est que le smooth_img_mode, même si c'est voulu par l'usager, ne sera pas possible
                  smooth_img_mode = 0;
            }
         }
         else   // si la fenetre n'est pas suffisamment grande à droite, on regarde si on peut la prendre plus grande à droite
         {    
            if (ptrH->roic_xend + (float)ISC0207_FASTWINDOW_STRECTHING_AREA_MCLK * ptrH->pixnum_per_tap_per_mclk * ptrH->tap_number <= (float)FPA_WIDTH_MAX) // si oui, c'est parfait on la prend
               ptrH->roic_xend =  ptrH->roic_xend + (float)ISC0207_FASTWINDOW_STRECTHING_AREA_MCLK * ptrH->pixnum_per_tap_per_mclk * ptrH->tap_number;
            else // sinon c'est que le smooth_img_mode, même si c'est voulu par l'usager, ne sera pas possible
               smooth_img_mode = 0;
         }
      }
      loop_cnt = loop_cnt + 1;
   }
   
   // enfin, on valide que la taille en X demandée au roic est multiple de FPA_WIDTH_INC sinon on reajuste
   ptrH->roic_xsize = ptrH->roic_xend - ptrH->roic_xstart + 1.0F; 
   if ((uint32_t)ptrH->roic_xsize % (uint32_t)FPA_WIDTH_INC != 0)
   {
      if (ptrH->roic_xstart - (float)FPA_OFFSETX_MULT >= 0.0F)             // de préférence, on prend plus large à gauche
         ptrH->roic_xstart = ptrH->roic_xstart - (float)FPA_OFFSETX_MULT;
      else 
         ptrH->roic_xend = ptrH->roic_xend + (float)FPA_OFFSETX_MULT;     // sinon on prend plus large à droite 
   }
    
   // ainsi, au sortir de toutes les conditions/recalculs, la taille finalement demandée au detecteur
   ptrH->roic_xsize     = ptrH->roic_xend - ptrH->roic_xstart + 1.0F;
   ptrH->roic_ysize     = (float)pGCRegs->Height;
   ptrH->roic_ystart    = ptrH->user_ystart; 
   ptrH->roic_yend      = ptrH->user_yend;   
   
   // egalement, au sortir de toutes les conditions/recalculs, on sait si le smooth_img_mode est permis ou non et on s'ajuste
   if (smooth_img_mode == 1){
      speedup_unused_area = 1;
      ptrH->line_stretch_mclk   = (ptrH->roic_xend - ptrH->user_xend)/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number);  // tout ce qui est à droite n'est pas en speed-up
      ptrH->unused_area_clock_factor =  (float)ROIC_UNUSED_AREA_CLK_RATE_HZ/(float)FPA_MCLK_RATE_HZ;
   }
   else{
      speedup_unused_area = 0;
      ptrH->line_stretch_mclk   = 0.0F;
      ptrH->unused_area_clock_factor =  1.0F; 
   }
   
   // on calcule maintenant les vitesses
   //readout part1 (zone en slow_clock)
   ptrH->readout_mclk         = ((float)pGCRegs->Width /(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) +  ptrH->line_stretch_mclk)*(float)pGCRegs->Height;
   
   //readout part2 (zone à rejeter en fast clock)
   ptrH->readout_mclk         = ptrH->readout_mclk + (1.0F/ptrH->unused_area_clock_factor)*((ptrH->roic_xsize - (float)pGCRegs->Width)/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) -  ptrH->line_stretch_mclk)*(float)pGCRegs->Height;
   
   //readout part5 (coût du synchronisateur)
   ptrH->readout_mclk         = ptrH->readout_mclk + ptrH->adc_sync_dly_mclk*(float)pGCRegs->Height;
   ptrH->readout_usec         = ptrH->readout_mclk * ptrH->mclk_period_usec;
   
   // delay
   ptrH->vhd_delay_usec       = ptrH->vhd_delay_mclk * ptrH->mclk_period_usec;
   ptrH->fpa_delay_usec       = ptrH->fpa_delay_mclk * ptrH->mclk_period_usec;
   ptrH->delay_usec           = ptrH->delay_mclk * ptrH->mclk_period_usec;
   
   // fsync_high_min
   ptrH->fsync_high_min_usec  = ptrH->trst_min_usec + 0.6F;
   
   // FsyncLow
   ptrH->fsync_low_usec       = exposureTime_usec + ptrH->int_time_offset_usec;
   
   // T_ri int part
   ptrH->tri_int_part_usec    = ptrH->tsh_min_usec - ptrH->fsync_low_usec;
   
   // T_ri window part
   ptrH->tri_min_window_part_usec = ptrH->fsync_high_min_usec - ptrH->delay_usec - ptrH->readout_usec;
   
   //T_ri window part couplé au mode ITR ou IWR
   if (itr_mode_enabled == 1) // ITR
      ptrH->tri_min_window_part_usec = MAX(ptrH->tri_min_window_part_usec, ptrH->itr_tri_min_usec);  // seulement ITR supporté pour le moment
   else                       // IWR
      ptrH->tri_min_window_part_usec = ptrH->tri_min_window_part_usec;
   
   // T_ri
   ptrH->tri_min_usec = MAX(ptrH->tri_int_part_usec , ptrH->tri_min_window_part_usec);
      
   // calcul de la periode minimale
   ptrH->frame_period_min_usec = ptrH->fsync_low_usec + ptrH->delay_usec + ptrH->readout_usec + ptrH->tri_min_usec;
   
   //calcul du frame rate maximal
   ptrH->frame_rate_max_hz = 1.0F/(ptrH->frame_period_min_usec*1e-6);
}
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate; 
   isc0207_param_t hh;
   
   FPA_SpecificParams(&hh,(float)pGCRegs->ExposureTime, pGCRegs);
   MaxFrameRate = floorMultiple(hh.frame_rate_max_hz, 0.01);

   return MaxFrameRate;                          
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir le ExposureMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   isc0207_param_t hh;
   float tri_part1_usec, tri_min_usec;
   float max_fsync_low_usec__plus__tri_min_usec;
   float max_fsync_low_usec, max_exposure_usec, frame_period_usec;
   
   // cherchons les parametres specifiques
   FPA_SpecificParams(&hh,(float)pGCRegs->ExposureTime, pGCRegs);
   
   // cherchons la periode associée au frame rate donné
   frame_period_usec  =  1e6F/pGCRegs->AcquisitionFrameRate;
                                                       
   // calculons  max_fsync_low_usec + tri_min_usec pour la periode ainsi calculée                                                   
   max_fsync_low_usec__plus__tri_min_usec = frame_period_usec - (hh.readout_usec + hh.delay_usec);
   
   // determinons le tri induite par la fenetre  choisie et le mode
   tri_part1_usec = hh.tri_min_window_part_usec;
   
   // rappel  : tri_min_usec = max(tri_min_window_part_usec, tri_int_part_usec)
   //d'où tri_min_usec = max(tri_part1_usec, tri_int_part_usec)
   
   // 1er cas : tri_min_usec = tri_part1_usec <=> tri_int_part_usec < tri_part1_usec  <=> fsync_low > tsh_min_usec - tri_part1_usec
   // dans ce cas, 
   tri_min_usec = tri_part1_usec;
   max_fsync_low_usec = max_fsync_low_usec__plus__tri_min_usec - tri_min_usec;
   
   // voyons si l'hypothese de debut est incorrecte (verification a posteriori)
   // le cas echeant, c'est le 2e cas qui prevaut
   // 2e cas : tri_min_usec = tri_int_part_usec <=> tri_int_part_usec > tri_part1_usec  <=> fsync_low < tsh_min_usec - tri_part1_usec
   // dans ce cas,
   if (max_fsync_low_usec <= hh.tsh_min_usec - tri_part1_usec)
     max_fsync_low_usec = hh.tsh_min_usec - tri_part1_usec;  // la valeur max de fync_low selon l'hypothese fsync_low < tsh_min_usec - tri_part1_usec
   
   // dans tous les cas         
   max_exposure_usec = max_fsync_low_usec - hh.int_time_offset_usec;
   
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
      AXI4L_write32(ptrD->vdac_value[ii], ptrA->ADD + AW_DAC_CFG_BASE_ADD + 4*ii);  
      ii++;
   }
}
