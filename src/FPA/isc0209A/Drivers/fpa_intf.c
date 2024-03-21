/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 12286 $
-- $Author: pdaraiche $
-- $LastChangedDate: 2013-01-25 14:24:16 -0500 (ven., 25 janv. 2013) $
--
-------------------------------------------------------------------------------
--
-- Description : 
--
------------------------------------------------------------------------------*/

#include "fpa_intf.h"
#include "flashSettings.h"
#include "utils.h"
#include <math.h>
#include <string.h>

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

// Mode d'operation choisi pour le contrôleur de trig 
#define MODE_READOUT_END_TO_TRIG_START    0x00      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR uniquement
#define MODE_TRIG_START_TO_TRIG_START     0x01
#define MODE_INT_END_TO_TRIG_START        0x02      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du IWR et ITR

// Gains definis par Indigo  
#define FPA_GAIN_0                        0x00      // lowest gain
#define FPA_GAIN_1                        0x01      // 
#define FPA_GAIN_2                        0x02      // 
#define FPA_GAIN_3                        0x03      // highest gain                               
 
// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400    // adresse de base 
#define AR_FPA_TEMPERATURE                0x002C    // adresse temperature
// adresse FPA_INTF_CFG feedback du module de statuts
#define AR_FPA_INTF_CFG_BASE_ADD          (AR_STATUS_BASE_ADD + 0x0200)

// adresse d'écriture du régistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xAE0      // adresse à lauquelle on dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xAE4      // adresse à lauquelle on dit au VHD quel type de sortie de fpa e pilote en C est conçu pour.
#define AW_FPA_INPUT_SW_TYPE              0xAE8      // obligaoire pour les deteceteurs analogiques

// adresse d'ecriture de la cfg des Dacs
#define AW_DAC_CFG_BASE_ADD               0x0D00   

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x11      // 0x11 -> isc0209A . Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x01 est celle de OUTPUT_ANALOG
#define FPA_INPUT_TYPE                    0x03      // 0x03 -> input LVTTL50 .provient du fichier fpa_common_pkg.vhd

// identification des sources de données
#define DATA_SOURCE_INSIDE_FPGA           0         // Provient du fichier fpa_common_pkg.vhd.
#define DATA_SOURCE_OUTSIDE_FPGA          1         // Provient du fichier fpa_common_pkg.vhd.

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
#define ADC_SAMPLING_RATE_HZ              (2*FPA_MCLK_RATE_HZ)    // les ADC  roulent à 10 MHz

// lecture de température FPA
#define FPA_TEMP_READER_ADC_DATA_RES      16            // la donnée de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV     2048          // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN              1             // gain du canal de lecture de temperature sur la carte ADC

// fleg
#define FLEG_DAC_RESOLUTION_BITS          14            // le DAC est à 14 bits
#define FLEG_DAC_REF_VOLTAGE_V            2.5           // on utilise la reference interne de 2.5V du DAC 
#define FLEG_DAC_REF_GAIN                 2.0           // gain de référence du DAC


#define VHD_PIXEL_PIPE_DLY_SEC            360E-9        // delai max du pipe des pixels

#define GOOD_SAMP_MEAN_DIV_BIT_POS        21            // ne pas changer meme si le detecteur change.

#define ISC0209_DET_BIAS_VOLTAGE_MIN_mV   100           // voltage minimale de 100 mV pour detBias (selon rapport Qmagiq)
#define ISC0209_DET_BIAS_VOLTAGE_MAX_mV   518           // voltage maximale de 518 mV pour detBias (on ne peut atteindre les 700 mV du rapport Q magiq en mode commande)

#define ISC0209_REFOFS_VOLTAGE_MIN_mV     2810           // valeur en provenance du fichier fpa_define
#define ISC0209_REFOFS_VOLTAGE_MAX_mV     6200           // valeur en provenance du fichier fpa_define

#define TOTAL_DAC_NUM                     8

// Electrical correction : references
#define ELCORR_REF_MAXIMUM_SAMP           120                 // le nombre de sample au max supporté par le vhd

// Electrical correction : embedded switches control
#define ELCORR_SW_TO_PATH1                0x01
#define ELCORR_SW_TO_PATH2                0x02
#define ELCORR_SW_TO_NORMAL_OP            0x03

// Electrical correction : valeurs par defaut si aucune mesure dispo dans les flashsettings
#define ELCORR_DEFAULT_STARVATION_DL      1250        // @ centered pix (160, 128)
#define ELCORR_DEFAULT_SATURATION_DL      14800       // @ centered pix (160, 128)
#define ELCORR_DEFAULT_REFERENCE1_DL      358         // @ centered pix (160, 128)
#define ELCORR_DEFAULT_REFERENCE2_DL      213         // @ centered pix (160, 128)

// Electrical correction : limites des valeurs en provenance de la flash
#define ELCORR_STARVATION_MIN_DL          100
#define ELCORR_STARVATION_MAX_DL          3000

#define ELCORR_SATURATION_MIN_DL          12000
#define ELCORR_SATURATION_MAX_DL          16300

#define ELCORR_REFERENCE1_MIN_DL          50
#define ELCORR_REFERENCE1_MAX_DL          16300

#define ELCORR_REFERENCE2_MIN_DL          50
#define ELCORR_REFERENCE2_MAX_DL          16300

// Electrical correction : valeurs cibles (desirées) apres correction
#define ELCORR_TARGET_STARVATION_DL       850         // @ centered pix (160, 128)
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

struct s_ProximCfgConfig 
{   
   uint32_t  vdac_value[(uint8_t)TOTAL_DAC_NUM];
   uint32_t  spare1;                       
   uint32_t  spare2;   
};                                  
typedef struct s_ProximCfgConfig ProximCfg_t;

// structure interne pour les parametres du isc0209
struct isc0209_param_s             //
{					   
   // parametres à rentrer
   float mclk_period_usec;
   float pclk_rate_hz;
   float tap_number;
   float pixnum_per_tap_per_mclk;
   float fpa_delay_mclk;
   float vhd_delay_mclk;
   float delay_mclk;
   float lovh_mclk;
   float fovh_line;
   float int_time_offset_mclk;   
   float fsync_width_min_usec;
   
   // parametres calculés
   float readout_mclk;   
   float readout_usec;
   float fpa_delay_usec;
   float vhd_delay_usec;
   float delay_usec;
   float lovh_usec;
   float fovh_usec;
   float int_time_offset_usec;
   float int_signal_high_time_usec;
   float tri_min_usec;
   float frame_period_usec;
   float frame_rate_max_hz;
   float mode_int_end_to_trig_start_dly_usec;
   float mode_readout_end_to_trig_start_dly_usec;
};
typedef struct isc0209_param_s  isc0209_param_t;

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
uint8_t init_done = 0;
ProximCfg_t ProximCfg = {{0, 0, 0, 0, 0, 0, 0, 9163}, 0, 0};   // les valeurs d'initisalisation des dacs sont les 8 premiers chiffres


// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);


void FPA_SpecificParams(isc0209_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA);

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   init_done = 0;
   FPA_Reset(ptrA);
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides Mglk Detector
   FPA_GetTemperature(ptrA);                                                // demande de lecture
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoyée au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
   init_done = 1;
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
   uint8_t ii;
   for(ii = 0; ii <= 10 ; ii++)
   { 
      AXI4L_write32(1, ptrA->ADD + AW_CTRLED_RESET);             //on active le reset
   }
   for(ii = 0; ii <= 10 ; ii++)
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
   isc0209_param_t hh;
   extern int16_t gFpaDetectorPolarizationVoltage;
   static int16_t presentPolarizationVoltage = 150;
   extern float gFpaDetectorElectricalTapsRef;
   extern float gFpaDetectorElectricalRefOffset;
   //static float presentElectricalTapsRef = 10;       // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul 
   static float presentElectricalRefOffset = 0;        // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul
   extern int32_t gFpaDebugRegA;                       // reservé ELCORR pour correction électronique (gain et/ou offset)
   //extern int32_t gFpaDebugRegB;                       // reservé
   extern int32_t gFpaDebugRegC;                       // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk
   extern int32_t gFpaDebugRegD;                       // reservé adc_clk_source_phase pour ajustement fin phase adc_clk
   extern int32_t gFpaDebugRegE;                       // reservé fpa_intf_data_source pour sortir les données des ADCs même lorsque le détecteur/flegX est absent
   extern int32_t gFpaDebugRegF;                       // reservé real_mode_active_pixel_dly pour ajustement du début AOI
   //extern int32_t gFpaDebugRegG;                       // non utilisé
   //extern int32_t gFpaDebugRegH;                      // non utilisé
   uint32_t elcorr_reg;
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
   uint32_t elcorr_ref1_const = 1;
   float elcorr_atemp_gain;
   float elcorr_atemp_ofs;
   static uint8_t cfg_num;

   // on bâtit les parametres specifiques du isc0209
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);               //
   
   // diag mode and diagType
   ptrA->fpa_diag_mode = 0;                 // par defaut
   ptrA->fpa_diag_type = 0;                 // par defaut   
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade) {              // mode diagnostique degradé lineaire
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
   
   // gFpaDebugRegE: mode diag vrai et faked
   ptrA->fpa_intf_data_source = DATA_SOURCE_INSIDE_FPGA;     // fpa_intf_data_source n'est utilisé/regardé par le vhd que lorsque fpa_diag_mode = 1
   if (ptrA->fpa_diag_mode == 1){
      if ((int32_t)gFpaDebugRegE != 0)
         ptrA->fpa_intf_data_source = DATA_SOURCE_OUTSIDE_FPGA;
   }
   
   // allumage du détecteur 
   ptrA->fpa_pwr_on  = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   
   // config du contrôleur de trigs
   if (pGCRegs->IntegrationMode == IM_IntegrateThenRead)
   {
      ptrA->fpa_acq_trig_mode          = (uint32_t)MODE_INT_END_TO_TRIG_START;
      ptrA->fpa_acq_trig_ctrl_dly      = (uint32_t)((hh.mode_int_end_to_trig_start_dly_usec*1e-6F - (float)VHD_PIXEL_PIPE_DLY_SEC) * (float)VHD_CLK_100M_RATE_HZ);
      ptrA->fpa_xtra_trig_mode         = (uint32_t)MODE_READOUT_END_TO_TRIG_START;
      ptrA->fpa_trig_ctrl_timeout_dly  = (uint32_t)(0.8F*(hh.mode_int_end_to_trig_start_dly_usec*1e-6F)* (float)VHD_CLK_100M_RATE_HZ);
      ptrA->fpa_xtra_trig_ctrl_dly     = ptrA->fpa_trig_ctrl_timeout_dly;                          // je n'ai pas enlevé le int_time, ni le readout_time mais pas grave car c'est en xtra_trig
   }
   else
   {
      ptrA->fpa_acq_trig_mode          = (uint32_t)MODE_TRIG_START_TO_TRIG_START;
      ptrA->fpa_acq_trig_ctrl_dly      = (uint32_t)( (hh.frame_period_usec*1e-6F) * (float)VHD_CLK_100M_RATE_HZ);  //frame period min calculée avec ET=0
      ptrA->fpa_xtra_trig_mode         = (uint32_t)MODE_TRIG_START_TO_TRIG_START;
      ptrA->fpa_trig_ctrl_timeout_dly  = ptrA->fpa_acq_trig_ctrl_dly;
      ptrA->fpa_xtra_trig_ctrl_dly     = ptrA->fpa_acq_trig_ctrl_dly;
   }

   // fenetrage
   ptrA->xstart    = (uint32_t)pGCRegs->OffsetX;
   ptrA->ystart    = (uint32_t)pGCRegs->OffsetY;
   ptrA->xsize     = (uint32_t)pGCRegs->Width;
   ptrA->ysize     = (uint32_t)pGCRegs->Height;
    
   //  gain 
   ptrA->gain = FPA_GAIN_0;   	//Low gain
   if (pGCRegs->SensorWellDepth == SWD_HighGain)
      ptrA->gain = FPA_GAIN_3;	//High gain
      
   // direction de readout
   ptrA->invert = 0;
   ptrA->revert = 0;
      
    // DIG voltage 
   if (gFpaDetectorPolarizationVoltage != presentPolarizationVoltage)
   {
      if ((gFpaDetectorPolarizationVoltage >= (int16_t)ISC0209_DET_BIAS_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= (int16_t)ISC0209_DET_BIAS_VOLTAGE_MAX_mV))
         ptrA->detpol_code = (uint32_t)(127.0F * ((float)gFpaDetectorPolarizationVoltage/1000.0F + 0.1F)/0.62F);  // dig_code change si la nouvelle valeur est conforme. Sinon la valeur precedente est conservée. (voir FpaIntf_Ctor) pour la valeur d'initialisation
   }
   presentPolarizationVoltage = (int16_t)roundf(1000.0F * (0.62F * (float)ptrA->detpol_code/127.0F - 0.1F));
   gFpaDetectorPolarizationVoltage = presentPolarizationVoltage;
   
   // skimming                     
   ptrA->skimming_en = 0;                          
   
   // Registre F : ajustement des delais de la chaine
   if (init_done == 0)
      gFpaDebugRegF = 19;
   ptrA->real_mode_active_pixel_dly = (uint32_t)gFpaDebugRegF;   
   
   // quad2
#ifdef DEFINE_HSI
   ptrA->adc_quad2_en = 1;
   ptrA->chn_diversity_en = 1;
#else
   ptrA->adc_quad2_en = 0;                                            // ENO : 14 aout 2017 : plus besoin de la diversité de canal dans un iSC0209
   ptrA->chn_diversity_en = 0;                                        // ENO : 14 aout 2017 : plus besoin de la diversité de canal dans un iSC0209
#endif
   
   //
   ptrA->line_period_pclk                  = (ptrA->xsize/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)+ hh.lovh_mclk) *  hh.pixnum_per_tap_per_mclk;
   ptrA->readout_pclk_cnt_max              = ptrA->line_period_pclk*(ptrA->ysize + hh.fovh_line) + 1;                    // ligne de reset du isc0209 prise en compte
   
   ptrA->active_line_start_num             = 3;                    // pour le isc0209, numero de la première ligne active
   ptrA->active_line_end_num               = ptrA->ysize + ptrA->active_line_start_num - 1;          // pour le isc0209, numero de la derniere ligne active
   ptrA->window_lsync_num                  = ptrA->ysize + ptrA->active_line_start_num - 1;
   
   // nombre d'échantillons par canal  de carte ADC
   ptrA->pix_samp_num_per_ch               = (uint32_t)((float)ADC_SAMPLING_RATE_HZ/(hh.pclk_rate_hz));
   
   // identificateurs de trames
   ptrA->sof_posf_pclk                     = ptrA->line_period_pclk * (ptrA->active_line_start_num - 1) + 1;
   ptrA->eof_posf_pclk                     = ptrA->active_line_end_num * ptrA->line_period_pclk - hh.lovh_mclk*hh.pixnum_per_tap_per_mclk;
   ptrA->sol_posl_pclk                     = 1;
   ptrA->eol_posl_pclk                     = (ptrA->xsize/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)) * hh.pixnum_per_tap_per_mclk;
   ptrA->eol_posl_pclk_p1                  = ptrA->eol_posl_pclk + 1;

   // echantillons choisis
   ptrA->good_samp_first_pos_per_ch        = ptrA->pix_samp_num_per_ch;     // position premier echantillon
   ptrA->good_samp_last_pos_per_ch         = ptrA->pix_samp_num_per_ch;     // position dernier echantillon
   ptrA->hgood_samp_sum_num                = ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->hgood_samp_mean_numerator         = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->hgood_samp_sum_num);                            
   ptrA->vgood_samp_sum_num                =  1 + ptrA->chn_diversity_en;
#ifdef DEFINE_HSI
   ptrA->vgood_samp_mean_numerator         = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS));                             // somme
#else
   ptrA->vgood_samp_mean_numerator         = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->vgood_samp_sum_num);    // moyenne
#endif
      
   // calculs
   ptrA->xsize_div_tapnum                  = ptrA->xsize/(uint32_t)FPA_NUMTAPS;                                        
   
   // les DACs (1 à 8)
   ProximCfg.vdac_value[0]                     = FLEG_VccVoltage_To_DacWord(5500.0F, 1); //12812;          // DAC1 -> VPD à 5.5V
   ProximCfg.vdac_value[1]                     = FLEG_VccVoltage_To_DacWord(5500.0F, 2); //12812;          // DAC2 -> VPOSOUT à 5.5V
   ProximCfg.vdac_value[2]                     = FLEG_VccVoltage_To_DacWord(5500.0F, 3); //12812;          // DAC3 -> VPOS à 5.5V
   ProximCfg.vdac_value[3]                     = FLEG_VccVoltage_To_DacWord(1600.0F, 4); //3711;           // DAC4 -> Vref à 1.6V  
   ProximCfg.vdac_value[4]                     = FLEG_VccVoltage_To_DacWord(1600.0F, 5); //3711;           // DAC5 -> Voutref à 1.6V
   ProximCfg.vdac_value[5]                     = FLEG_VccVoltage_To_DacWord(1600.0F, 6); //3711;           // DAC6 -> VOS à 1.6V 
   ProximCfg.vdac_value[6]                     = 0;              // DAC7 -> non utilisé, à 501 mV
   //ProximCfg.vdac_value[7]                     = 5300;           // DAC8 -> à 3.779V
   
   // offset of the tap_reference (VCC8)      
   if (gFpaDetectorElectricalRefOffset != presentElectricalRefOffset)
   {
      if ((gFpaDetectorElectricalRefOffset >= (float)ISC0209_REFOFS_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalRefOffset <= (float)ISC0209_REFOFS_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[7] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalRefOffset, 8);  // 
	}                                                                                                       
   presentElectricalRefOffset = (float) FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[7], 8);            
   gFpaDetectorElectricalRefOffset = presentElectricalRefOffset; 
 
   // reference des taps = VOUTREF (VCC5). Elle ne peut être changée ni via debug terminal, ni via matlab
   gFpaDetectorElectricalTapsRef = (float) FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[4], 5);             // affichage dans le debug terminal uniquement. Tout changement est impossible.
     
   // gFpaDebugRegC dephasage grossier des adc_clk 
   if (init_done == 0)
      gFpaDebugRegC = 2;
   ptrA->adc_clk_pipe_sel = (uint32_t)gFpaDebugRegC;                                              
 
   // gFpaDebugRegD dephasage fin des adc_clk 
   if (init_done == 0)         
      gFpaDebugRegD = 0;
   ptrA->adc_clk_source_phase = (uint32_t)gFpaDebugRegD; 
      
   // Élargit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
   /*----------------------------------------------------                         
    ELCORR : definition parametres                                                
   ------------------------------------------------------*/ 
   
   // starvation
   if (init_done == 0)
      presentElCorrMeasAtStarvation = (uint16_t)ELCORR_DEFAULT_STARVATION_DL;      
   if (gFpaElCorrMeasAtStarvation != presentElCorrMeasAtStarvation){
      if ((gFpaElCorrMeasAtStarvation >= (uint16_t)ELCORR_STARVATION_MIN_DL) && (gFpaElCorrMeasAtStarvation <= (uint16_t)ELCORR_STARVATION_MAX_DL))
         presentElCorrMeasAtStarvation = gFpaElCorrMeasAtStarvation;  // 
   }
   gFpaElCorrMeasAtStarvation = presentElCorrMeasAtStarvation;
   
   // saturation
   if (init_done == 0)
      presentElCorrMeasAtSaturation = (uint16_t)ELCORR_DEFAULT_SATURATION_DL;      
   if (gFpaElCorrMeasAtSaturation != presentElCorrMeasAtSaturation){
      if ((gFpaElCorrMeasAtSaturation >= (uint16_t)ELCORR_SATURATION_MIN_DL) && (gFpaElCorrMeasAtSaturation <= (uint16_t)ELCORR_SATURATION_MAX_DL))
         presentElCorrMeasAtSaturation = gFpaElCorrMeasAtSaturation;  // 
   }
   gFpaElCorrMeasAtSaturation = presentElCorrMeasAtSaturation;
   
   // reference1
   if (init_done == 0)
      presentElCorrMeasAtReference1 = (uint16_t)ELCORR_DEFAULT_REFERENCE1_DL;      
   if (gFpaElCorrMeasAtReference1 != presentElCorrMeasAtReference1){
      if ((gFpaElCorrMeasAtReference1 >= (uint16_t)ELCORR_REFERENCE1_MIN_DL) && (gFpaElCorrMeasAtReference1 <= (uint16_t)ELCORR_REFERENCE1_MAX_DL))
         presentElCorrMeasAtReference1 = gFpaElCorrMeasAtReference1;  // 
   }
   gFpaElCorrMeasAtReference1 = presentElCorrMeasAtReference1;
   
   // reference2
   if (init_done == 0)
      presentElCorrMeasAtReference2 = (uint16_t)ELCORR_DEFAULT_REFERENCE2_DL;      
   if (gFpaElCorrMeasAtReference2 != presentElCorrMeasAtReference2){
      if ((gFpaElCorrMeasAtReference2 >= (uint16_t)ELCORR_REFERENCE2_MIN_DL) && (gFpaElCorrMeasAtReference2 <= (uint16_t)ELCORR_REFERENCE2_MAX_DL))
         presentElCorrMeasAtReference2 = gFpaElCorrMeasAtReference2;  // 
   }
   gFpaElCorrMeasAtReference2 = presentElCorrMeasAtReference2;
   
   
   // ELCORR : activation via registreA
   if (init_done == 0)
      gFpaDebugRegA = (int32_t)ELCORR_MODE_OFFSET_CORR_WITH_DYN_RANGE_COMP;
   elcorr_reg = (uint32_t)gFpaDebugRegA;
   
   if (ptrA->fpa_diag_mode == 1)
      elcorr_reg = (uint32_t)ELCORR_MODE_OFF;      
   
   if (elcorr_reg == (uint32_t)ELCORR_MODE_OFFSET_AND_GAIN_CORR){           // pixeldata avec correction du gain et offset electroniques
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 1;
      ptrA->roic_cst_output_mode    = 0;
      elcorr_ref1_const             = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP;
      ptrA->sat_ctrl_en             = 1;
   }
    
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_ROIC_OUTPUT_CST_IMG){            // voutref data avec correction du gain et offset electroniques
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 1;
      ptrA->roic_cst_output_mode    = 1;
      elcorr_ref1_const             = 0;
      
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
      elcorr_ref1_const             = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP;     
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH1;         
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;         
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH1;         
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP;     
      ptrA->sat_ctrl_en             = 1;                            
   }
   
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_OFFSET_CORR_WITH_DYN_RANGE_COMP){   // pixeldata avec correction de l'offset électronique seulement
      elcorr_enabled                = 1;                                            // et ajout d'une compensation du range dynamique
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      // Dans ce mode la reference 1 est utilisee comme une constante et la valeur echantillonnee est ignoree.
      // On utilise cette constante dans le calcul de ATEMP_GAIN. Etant donne que ATEMP_GAIN est un entier,
      // on le multiplie par la constante pour eviter que ses decimales soient tronques. Il faut ensuite diviser
      // le resultat par la meme constante, donc il faut aussi connecter la reference 1 directement a la division.
      elcorr_ref1_const             = 1;

      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP;     
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH2;   // la reference 1 passe directement vers la division
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP;
      ptrA->sat_ctrl_en             = 1;
   }

   else if (elcorr_reg == (uint32_t)ELCORR_MODE_OFF_WITH_DYN_RANGE_COMP){        // pixeldata sans correction électronique
      elcorr_enabled                = 0;                                         // mais ajout d'une compensation du range dynamique
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      // Dans ce mode la reference 1 est utilisee comme une constante et la valeur echantillonnee est ignoree.
      // On utilise cette constante dans le calcul de ATEMP_GAIN. Etant donne que ATEMP_GAIN est un entier,
      // on le multiplie par la constante pour eviter que ses decimales soient tronques. Il faut ensuite diviser
      // le resultat par la meme constante, donc il faut aussi connecter la reference 1 directement a la division.
      elcorr_ref1_const             = 1;

      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH1;   // la reference 0 est ignoree
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH2;   // la reference 1 passe directement vers la division
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_NORMAL_OP;         
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP;     
      ptrA->sat_ctrl_en             = 1;                            
   }
 
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_DIFF_REF_IMG){                   // image map de la difference des references
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      elcorr_ref1_const             = 0;
      
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
      elcorr_ref1_const             = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH1;
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
      elcorr_ref1_const             = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH2;                    
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH1;
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_PATH1;                    
      ptrA->sat_ctrl_en             = 0;                                     
   }

   else if (elcorr_reg == (uint32_t)ELCORR_MODE_OFF){                            // desactivation de toute correction electronique
      elcorr_enabled                = 0;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      elcorr_ref1_const             = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH2;
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_PATH1;                        
      ptrA->sat_ctrl_en             = 0;                                             
   }  
  
   // valeurs par defaut (mode normal)                                                                                                                                               
   ptrA->elcorr_enabled                       = elcorr_enabled;
   ptrA->elcorr_spare1                        = 0; // not used
   ptrA->elcorr_spare2                        = 0; // not used

   // vhd reference 0:
   ptrA->elcorr_ref_cfg_0_ref_enabled         = 1;
   ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode  = 0; // not used
   ptrA->elcorr_ref_cfg_0_start_dly_sampclk   = 0; // un echantillon de plus que ce registre est ignore
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)(hh.pixnum_per_tap_per_mclk * (hh.lovh_mclk + hh.delay_mclk)); // la pause de fin de ligne et le delai min entre 2 images
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = ptrA->elcorr_ref_cfg_0_samp_num_per_ch - (ptrA->elcorr_ref_cfg_0_start_dly_sampclk + 1.0F); // on enleve le delai et l'echantillon supplementaire de ce chiffre
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)MIN(ptrA->elcorr_ref_cfg_0_samp_num_per_ch, ELCORR_REF_MAXIMUM_SAMP);
   ptrA->elcorr_ref_cfg_0_samp_mean_numerator = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elcorr_ref_cfg_0_samp_num_per_ch);     
   ptrA->elcorr_ref_cfg_0_ref_value           = 0; // not used
   ptrA->elcorr_ref_cfg_0_forced_val_enabled  = 0; // si actif la valeur forcee remplace la valeur echantillonnee
   ptrA->elcorr_ref_cfg_0_forced_val          = 0; // ignoree si le enabled est 0
    
   // vhd reference 1: 
   ptrA->elcorr_ref_cfg_1_ref_enabled         = 1;
   ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode  = 0; // not used
   ptrA->elcorr_ref_cfg_1_start_dly_sampclk   = 0; // un echantillon de plus que ce registre est ignore
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     = ptrA->xsize_div_tapnum; // on prend une ligne complete
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     = ptrA->elcorr_ref_cfg_1_samp_num_per_ch - (ptrA->elcorr_ref_cfg_1_start_dly_sampclk + 1.0F); // on enleve le delai et l'echantillon supplementaire de ce chiffre
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     = (uint32_t)MIN(ptrA->elcorr_ref_cfg_1_samp_num_per_ch, ELCORR_REF_MAXIMUM_SAMP);
   ptrA->elcorr_ref_cfg_1_samp_mean_numerator = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elcorr_ref_cfg_1_samp_num_per_ch);     
   ptrA->elcorr_ref_cfg_1_ref_value           = 0; // not used
   ptrA->elcorr_ref_cfg_1_forced_val_enabled  = elcorr_ref1_const; // si actif la valeur forcee remplace la valeur echantillonnee
   ptrA->elcorr_ref_cfg_1_forced_val          = 1000; // valeur choisie pour avoir 3 decimales dans le calcul elcorr_atemp_gain, ignoree si le enabled est 0
   
   ptrA->elcorr_ref_dac_id                    = 0; // not used
   ptrA->elcorr_spare3                        = 0; // not used
   ptrA->elcorr_spare4                        = 0; // not used

   // Electronic chain correction parameters
   if (elcorr_gain_corr_enabled == 1){
      elcorr_atemp_gain = ((float)ELCORR_TARGET_SATURATION_DL - (float)ELCORR_TARGET_STARVATION_DL) * ((float)presentElCorrMeasAtReference1 - (float)presentElCorrMeasAtReference2)/((float)presentElCorrMeasAtSaturation - (float)presentElCorrMeasAtStarvation);
      elcorr_atemp_ofs  = (float)ELCORR_TARGET_SATURATION_DL - elcorr_atemp_gain * ((float)presentElCorrMeasAtSaturation - (float)presentElCorrMeasAtReference1)/((float)presentElCorrMeasAtReference1 - (float)presentElCorrMeasAtReference2);
   }
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_OFFSET_CORR_WITH_DYN_RANGE_COMP){
      elcorr_atemp_gain = ((float)ELCORR_TARGET_SATURATION_DL - (float)ELCORR_TARGET_STARVATION_DL) * ((float)ptrA->elcorr_ref_cfg_1_forced_val)/((float)presentElCorrMeasAtSaturation - (float)presentElCorrMeasAtStarvation);
      elcorr_atemp_ofs  = (float)ELCORR_TARGET_STARVATION_DL - elcorr_atemp_gain * ((float)presentElCorrMeasAtStarvation - (float)presentElCorrMeasAtReference1)/((float)ptrA->elcorr_ref_cfg_1_forced_val);
   }
   else if (elcorr_reg == (uint32_t)ELCORR_MODE_OFF_WITH_DYN_RANGE_COMP){
      elcorr_atemp_gain = ((float)ELCORR_TARGET_SATURATION_DL - (float)ELCORR_TARGET_STARVATION_DL) * ((float)ptrA->elcorr_ref_cfg_1_forced_val)/((float)presentElCorrMeasAtSaturation - (float)presentElCorrMeasAtStarvation);
      elcorr_atemp_ofs  = (float)ELCORR_TARGET_STARVATION_DL - elcorr_atemp_gain * ((float)presentElCorrMeasAtStarvation)/((float)ptrA->elcorr_ref_cfg_1_forced_val);
   }
   else {
      elcorr_atemp_gain = 1.0F;
      elcorr_atemp_ofs  = (float)ELCORR_TARGET_STARVATION_DL - ((float)presentElCorrMeasAtStarvation - (float)presentElCorrMeasAtReference1);
   }

   ptrA->elcorr_atemp_gain = (int32_t)elcorr_atemp_gain;
   ptrA->elcorr_atemp_ofs  = (int32_t)elcorr_atemp_ofs;

   
   // changement de cfg_num des qu'une nouvelle cfg est envoyée au vhd. Il s'en sert pour detecter le mode hors acquisition et ainsi en profite pour calculer le gain electronique
   ptrA->cfg_num  = ++cfg_num;
   
   // envoi de la configuration de l'électronique de proximité (les DACs en l'occurrence) par un autre canal 
   FPA_SendProximCfg(&ProximCfg, ptrA);
   
   // envoi du reste de la config        
   WriteStruct(ptrA);

//   FPA_PRINTF("ptrA->fpa_diag_mode                = %d", ptrA->fpa_diag_mode                  );
//   FPA_PRINTF("ptrA->fpa_diag_type                = %d", ptrA->fpa_diag_type                  );
//   FPA_PRINTF("ptrA->fpa_pwr_on                   = %d", ptrA->fpa_pwr_on                     );
//   FPA_PRINTF("ptrA->fpa_acq_trig_mode            = %d", ptrA->fpa_acq_trig_mode              );
//   FPA_PRINTF("ptrA->fpa_acq_trig_ctrl_dly        = %d", ptrA->fpa_acq_trig_ctrl_dly          );
//   FPA_PRINTF("ptrA->fpa_xtra_trig_mode           = %d", ptrA->fpa_xtra_trig_mode             );
//   FPA_PRINTF("ptrA->fpa_xtra_trig_ctrl_dly       = %d", ptrA->fpa_xtra_trig_ctrl_dly         );
//   FPA_PRINTF("ptrA->fpa_trig_ctrl_timeout_dly    = %d", ptrA->fpa_trig_ctrl_timeout_dly      );
//   FPA_PRINTF("ptrA->fpa_stretch_acq_trig         = %d", ptrA->fpa_stretch_acq_trig           );
//   FPA_PRINTF("ptrA->xstart                   = %d", ptrA->xstart                     );
//   FPA_PRINTF("ptrA->ystart        = %d", ptrA->ystart          );
//   FPA_PRINTF("ptrA->xsize                  = %d", ptrA->xsize                    );
//   FPA_PRINTF("ptrA->ysize                  = %d", ptrA->ysize                    );
//   FPA_PRINTF("ptrA->gain                   = %d", ptrA->gain                     );
//   FPA_PRINTF("ptrA->invert           = %d", ptrA->invert             );
//   FPA_PRINTF("ptrA->revert                         = %d", ptrA->revert                           );
//   FPA_PRINTF("ptrA->detpol_code                = %d", ptrA->detpol_code                  );
//   FPA_PRINTF("ptrA->skimming_en   = %d", ptrA->skimming_en     );
//   FPA_PRINTF("ptrA->real_mode_active_pixel_dly   = %d", ptrA->real_mode_active_pixel_dly     );
//   FPA_PRINTF("ptrA->adc_quad2_en                = %d", ptrA->adc_quad2_en                  );
//   FPA_PRINTF("ptrA->chn_diversity_en           = %d", ptrA->chn_diversity_en             );
//   FPA_PRINTF("ptrA->line_period_pclk          = %d", ptrA->line_period_pclk            );
//   FPA_PRINTF("ptrA->readout_pclk_cnt_max      = %d", ptrA->readout_pclk_cnt_max        );
//   FPA_PRINTF("ptrA->active_line_start_num        = %d", ptrA->active_line_start_num          );
//   FPA_PRINTF("ptrA->active_line_end_num       = %d", ptrA->active_line_end_num         );
//   FPA_PRINTF("ptrA->window_lsync_num       = %d", ptrA->window_lsync_num         );
//   FPA_PRINTF("ptrA->pix_samp_num_per_ch       = %d", ptrA->pix_samp_num_per_ch         );
//   FPA_PRINTF("ptrA->sof_posf_pclk       = %d", ptrA->sof_posf_pclk         );
//   FPA_PRINTF("ptrA->eof_posf_pclk    = %d", ptrA->eof_posf_pclk      );
//   FPA_PRINTF("ptrA->sol_posl_pclk    = %d", ptrA->sol_posl_pclk      );
//   FPA_PRINTF("ptrA->eol_posl_pclk    = %d", ptrA->eol_posl_pclk      );
//   FPA_PRINTF("ptrA->eol_posl_pclk_p1= %d", ptrA->eol_posl_pclk_p1  );
//   FPA_PRINTF("ptrA->hgood_samp_sum_num           = %d", ptrA->hgood_samp_sum_num             );
//   FPA_PRINTF("ptrA->hgood_samp_mean_numerator    = %d", ptrA->hgood_samp_mean_numerator      );
//   FPA_PRINTF("ptrA->vgood_samp_sum_num           = %d", ptrA->vgood_samp_sum_num             );
//   FPA_PRINTF("ptrA->vgood_samp_mean_numerator    = %d", ptrA->vgood_samp_mean_numerator      );
//   FPA_PRINTF("ptrA->good_samp_first_pos_per_ch   = %d", ptrA->good_samp_first_pos_per_ch     );
//   FPA_PRINTF("ptrA->good_samp_last_pos_per_ch    = %d", ptrA->good_samp_last_pos_per_ch      );
//   FPA_PRINTF("ptrA->xsize_div_tapnum                       = %d", ptrA->xsize_div_tapnum                         );
//   FPA_PRINTF("ptrA->adc_clk_source_phase         = %d", ptrA->adc_clk_source_phase           );
//   FPA_PRINTF("ptrA->adc_clk_pipe_sel             = %d", ptrA->adc_clk_pipe_sel               );
//   FPA_PRINTF("ptrA->cfg_num                       = %d", ptrA->cfg_num                         );
//   FPA_PRINTF("ptrA->fpa_stretch_acq_trig                  = %d", ptrA->fpa_stretch_acq_trig                    );
//   FPA_PRINTF("ptrA->fpa_intf_data_source                   = %d", ptrA->fpa_intf_data_source                     );
//   FPA_PRINTF("ptrA->elcorr_enabled               = %d", ptrA->elcorr_enabled                 );
//   FPA_PRINTF("ptrA->elcorr_spare1        = %d", ptrA->elcorr_spare1          );
//   FPA_PRINTF("ptrA->elcorr_spare2           = %d", ptrA->elcorr_spare2             );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_0_ref_enabled           = %d", ptrA->elcorr_ref_cfg_0_ref_enabled            );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode    = %d", ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode           );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_0_start_dly_sampclk     = %d", ptrA->elcorr_ref_cfg_0_start_dly_sampclk                         );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_0_samp_num_per_ch       = %d", ptrA->elcorr_ref_cfg_0_samp_num_per_ch            );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_0_samp_mean_numerator   = %d", ptrA->elcorr_ref_cfg_0_samp_mean_numerator           );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_0_ref_value             = %d", ptrA->elcorr_ref_cfg_0_ref_value                         );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_1_ref_enabled           = %d", ptrA->elcorr_ref_cfg_1_ref_enabled            );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode    = %d", ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode           );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_1_start_dly_sampclk     = %d", ptrA->elcorr_ref_cfg_1_start_dly_sampclk                         );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_1_samp_num_per_ch       = %d", ptrA->elcorr_ref_cfg_1_samp_num_per_ch            );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_1_samp_mean_numerator   = %d", ptrA->elcorr_ref_cfg_1_samp_mean_numerator           );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_1_ref_value             = %d", ptrA->elcorr_ref_cfg_1_ref_value                         );
//   FPA_PRINTF("ptrA->elcorr_ref_dac_id                = %d", ptrA->elcorr_ref_dac_id                  );
//   FPA_PRINTF("ptrA->elcorr_atemp_gain                = %d", ptrA->elcorr_atemp_gain                  );
//   FPA_PRINTF("ptrA->elcorr_atemp_ofs                   = %d", ptrA->elcorr_atemp_ofs                     );
//   FPA_PRINTF("ptrA->elcorr_ref0_op_sel                = %d", ptrA->elcorr_ref0_op_sel                  );
//   FPA_PRINTF("ptrA->elcorr_ref1_op_sel                = %d", ptrA->elcorr_ref1_op_sel                  );
//   FPA_PRINTF("ptrA->elcorr_mult_op_sel                   = %d", ptrA->elcorr_mult_op_sel                     );
//   FPA_PRINTF("ptrA->elcorr_div_op_sel            = %d", ptrA->elcorr_div_op_sel              );
//   FPA_PRINTF("ptrA->elcorr_add_op_sel        = %d", ptrA->elcorr_add_op_sel          );
//   FPA_PRINTF("ptrA->elcorr_spare3           = %d", ptrA->elcorr_spare3             );
//   FPA_PRINTF("ptrA->sat_ctrl_en       = %d", ptrA->sat_ctrl_en         );
//   FPA_PRINTF("ptrA->roic_cst_output_mode    = %d", ptrA->roic_cst_output_mode      );
//   FPA_PRINTF("ptrA->elcorr_spare4         = %d", ptrA->elcorr_spare4           );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_0_forced_val_enabled           = %d", ptrA->elcorr_ref_cfg_0_forced_val_enabled             );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_0_forced_val       = %d", ptrA->elcorr_ref_cfg_0_forced_val         );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_1_forced_val_enabled    = %d", ptrA->elcorr_ref_cfg_1_forced_val_enabled      );
//   FPA_PRINTF("ptrA->elcorr_ref_cfg_1_forced_val         = %d", ptrA->elcorr_ref_cfg_1_forced_val           );
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la température du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{
   uint32_t raw_temp;
   float diode_voltage;
   float temperature;
   
   raw_temp = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_TEMPERATURE);  // lit le registre de temperature (fort probablement pas le présent mais le passé) 
   raw_temp = (raw_temp & 0x0000FFFF);

   diode_voltage = (float)raw_temp*((float)FPA_TEMP_READER_FULL_SCALE_mV/1000.0F)/(exp2f(FPA_TEMP_READER_ADC_DATA_RES)*(float)FPA_TEMP_READER_GAIN);

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
     temperature += (-667.07F * diode_voltage) + 623.1F;  // 625 remplacé par 623 en guise de calibration de la diode
  }	

   return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au isc0209 avec une config
//--------------------------------------------------------------------------
void FPA_SpecificParams(isc0209_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // parametres statiques
   ptrH->mclk_period_usec        = 1e6F/(float)FPA_MCLK_RATE_HZ;
   ptrH->tap_number              = (float)FPA_NUMTAPS;
   ptrH->pixnum_per_tap_per_mclk = 2.0F;
   ptrH->fpa_delay_mclk          = 5.0F;   // FPA: estimation delai max de sortie des pixels après integration
   ptrH->vhd_delay_mclk          = 3.5F;   // estimation des differerents delais accumulés par le vhd
   ptrH->delay_mclk              = ptrH->fpa_delay_mclk + ptrH->vhd_delay_mclk;   //
   ptrH->lovh_mclk               = 16.0F;
   ptrH->fovh_line               = 2.0F;
   ptrH->int_time_offset_mclk    = (5.0E-6F) * (float)FPA_MCLK_RATE_HZ;
   ptrH->pclk_rate_hz            = ptrH->pixnum_per_tap_per_mclk * (float)FPA_MCLK_RATE_HZ;
      
   // readout time
   ptrH->readout_mclk         = (pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) + ptrH->lovh_mclk)*(pGCRegs->Height + ptrH->fovh_line);
   ptrH->readout_usec         = ptrH->readout_mclk * ptrH->mclk_period_usec;
   
   // delay
   ptrH->vhd_delay_usec       = ptrH->vhd_delay_mclk * ptrH->mclk_period_usec;
   ptrH->fpa_delay_usec       = ptrH->fpa_delay_mclk * ptrH->mclk_period_usec;
   ptrH->delay_usec           = ptrH->delay_mclk * ptrH->mclk_period_usec; 
   
   // 
   ptrH->int_time_offset_usec  = ptrH->int_time_offset_mclk * ptrH->mclk_period_usec;
   ptrH->int_signal_high_time_usec = MAX(exposureTime_usec - ptrH->int_time_offset_usec, 0.0F);

   ptrH->fsync_width_min_usec = 11.8;
      
   // calcul de la periode minimale
   if (pGCRegs->IntegrationMode == IM_IntegrateThenRead)
      ptrH->frame_period_usec = exposureTime_usec + ptrH->delay_usec + ptrH->readout_usec;
   else
      ptrH->frame_period_usec = MAX(exposureTime_usec + ptrH->fsync_width_min_usec, ptrH->delay_usec + ptrH->readout_usec);

   //calcul du frame rate maximal
   ptrH->frame_rate_max_hz = 1.0F/(ptrH->frame_period_usec*1e-6F);

   //autres calculs
   ptrH->mode_int_end_to_trig_start_dly_usec = ptrH->frame_period_usec - ptrH->int_signal_high_time_usec;   
   ptrH->mode_readout_end_to_trig_start_dly_usec = 1.0F;                                                   // utilisé en mode readout_end_trig_start
}
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate; 
   isc0209_param_t hh;
   
   FPA_SpecificParams(&hh,(float)pGCRegs->ExposureTime, pGCRegs);
   
   // ENO: 10 sept 2016: Apply margin 
   MaxFrameRate = hh.frame_rate_max_hz * (1.0F - gFpaPeriodMinMargin);
   
   // Round maximum frame rate
   MaxFrameRate = floorMultiple(MaxFrameRate, 0.01);

   return MaxFrameRate;                          
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir le ExposureMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   isc0209_param_t hh;
   float periodMinWithNullExposure_usec;
   float presentPeriod_sec;
   float max_exposure_usec;
   float fpaAcquisitionFrameRate;
   
   // ENO: 10 sept 2016: d'entrée de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur   
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);
   
   // ENO: 10 sept 2016: tout reste inchangé
   FPA_SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition était nulle
   periodMinWithNullExposure_usec = hh.frame_period_usec;
   presentPeriod_sec = 1.0F/fpaAcquisitionFrameRate; // periode avec le frame rate actuel.
   
   if (pGCRegs->IntegrationMode == IM_IntegrateThenRead)
      max_exposure_usec = (presentPeriod_sec*1e6F - periodMinWithNullExposure_usec);
   else
      max_exposure_usec = (presentPeriod_sec*1e6F - hh.fsync_width_min_usec);

   // Round exposure time
   max_exposure_usec = floorMultiple(max_exposure_usec, 0.1);
     
   // Limit exposure time
   max_exposure_usec = MIN(MAX(max_exposure_usec, pGCRegs->ExposureTimeMin), FPA_MAX_EXPOSURE);
   
   return max_exposure_usec;
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir les statuts au complet
//--------------------------------------------------------------------------
void FPA_GetStatus(t_FpaStatus *Stat, const t_FpaIntf *ptrA)
{ 
   uint32_t temp_32b;

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
   Stat->fpa_init_done                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x80);
   Stat->fpa_init_success              = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x84);
   Stat->flegx_present                 =(Stat->flex_flegx_present & Stat->adc_brd_spare);
   
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
}

//--------------------------------------------------------------------------
// Pour afficher le feedback de FPA_INTF_CFG
//--------------------------------------------------------------------------
void FPA_PrintConfig(const t_FpaIntf *ptrA)
{
   FPA_INF("This functionality is not supported for this FPA");
//   uint32_t idx = 0;
//
//   FPA_INF("int_time = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx));
//   idx += 4;
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
