/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 26972 $
-- $Author: enofodjie $
-- $LastChangedDate: 2021-11-18 15:25:09 -0500 (jeu., 18 nov. 2021) $
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

// Mode d'operation choisi pour le contrôleur de trig 
#define MODE_READOUT_END_TO_TRIG_START    0x00
#define MODE_TRIG_START_TO_TRIG_START     0x01
#define MODE_INT_END_TO_TRIG_START        0x02
#define MODE_ITR_TRIG_START_TO_TRIG_START 0x03
#define MODE_ITR_INT_END_TO_TRIG_START    0x04
#define MODE_ALL_END_TO_TRIG_START        0x05
 
 
// mode xtra trig freq
#define FPA_XTRA_TRIG_FREQ_MAX_HZ         50        // en extra trig, rouler à au max 50 fps afin que meme en changemet de fenetre, le delai tri soit toujours respecté pour le détecteur 

// Gains  
#define FPA_GAIN_0                        0x00      // lowest gain
                               
 
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
#define FPA_ROIC                          0x18      // 0x18 -> FPA_ROIC_SCORPIO_MW . Provient du fichier fpa_common_pkg.vhd.
#define FPA_ROIC_UNKNOWN                  0xFF      // 0xFF -> ROIC inconnu. Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x01 est celle de OUTPUT_ANALOG
#define FPA_INPUT_TYPE                    0x04      // 0x04 -> input LVCMOS33 .provient du fichier fpa_common_pkg.vhd


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

// horloge des ADCs
#define ADC_SAMPLING_RATE_HZ              18000000    // les ADC roulent à 18MHz

// lecture de température FPA
#define FPA_TEMP_READER_ADC_DATA_RES      16            // la donnée de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV     2048          // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN              1             // gain du canal de lecture de temperature sur la carte ADC

// fleg
#define FLEG_DAC_RESOLUTION_BITS          14            // le DAC est à 14 bits
#define FLEG_DAC_REF_VOLTAGE_V            2.5           // on utilise la reference interne de 2.5V du DAC 
#define FLEG_DAC_REF_GAIN                 2             // le gain est de 2 sur VREF

#define VHD_PIXEL_PIPE_DLY_SEC            500E-9        // delai max du pipe des pixels

#define GOOD_SAMP_MEAN_DIV_BIT_POS        21            // ne pas changer meme si le detecteur change.

#define SCORPIOMW_DET_BIAS_VOLTAGE_MIN_mV 500
#define SCORPIOMW_DET_BIAS_VOLTAGE_MAX_mV 1000

#define SCORPIOMWA_TAPREF_VOLTAGE_MIN_mV  510
#define SCORPIOMWA_TAPREF_VOLTAGE_MAX_mV  5310

#define SCORPIOMWA_REFOFS_VOLTAGE_MIN_mV  3000 
#define SCORPIOMWA_REFOFS_VOLTAGE_MAX_mV  6200

#define SCORPIOMWA_CONST_ELEC_OFFSET_VALUE 340            // aussi pour ne pas provoquer saturation au dela de (2^14 - 1) soit 16383

#define SCORPIOMWA_DEFAULT_REGC              2           // Default RegC value = 2
#define SCORPIOMWA_DEFAULT_REGD              160         // Default RegD value = 160
#define SCORPIOMWA_DEFAULT_REGF              8           // Default RegF value = 8
#define SCORPIOMWA_DEFAULT_POL               900         // Default detector polarization = 900 mV


#define TOTAL_DAC_NUM                     8

#define MODEL_M100_FR_DIVIDER             1.65F          // Requis du PLM: FRmax M100 >= 125 Hz en pleine fenêtre

// clk area (en provenance de fpa_define)
#define  VHD_DEFINE_FPA_NOMINAL_MCLK_ID       0    // horloge nominale
#define  VHD_DEFINE_FPA_MCLK1_ID              1    // horloge MCLK1
#define  VHD_DEFINE_FPA_MCLK2_ID              2    // horloge MCLK2

#define DEFINE_FPA_NOMINAL_MCLK_RATE_HZ       18000000
#define DEFINE_FPA_FAST1_MCLK_RATE_HZ         (0.5*DEFINE_FPA_NOMINAL_MCLK_RATE_HZ)
#define DEFINE_FPA_FAST2_MCLK_RATE_HZ         (2*DEFINE_FPA_NOMINAL_MCLK_RATE_HZ)

struct s_ProximCfgConfig 
{   
   uint32_t  vdac_value[(uint8_t)TOTAL_DAC_NUM];
   uint32_t  spare1;                       
   uint32_t  spare2;   
};                                  
typedef struct s_ProximCfgConfig ProximCfg_t;
  
// structure interne pour les parametres du scorpiomw
struct scorpiomw_param_s             //
{					   
   // parametres à rentrer
   float mclk_period_usec;
   float pclk_rate_hz;
   float tap_number;
   float pixnum_per_tap_per_mclk;
   float fpa_itr_delay_mclk;
   float fpa_iwr_delay_mclk;
   float vhd_delay_mclk;
   float lovh_mclk;
   float fovh_line;
   float fpa_reset_time_mclk;   
   
   // parametres calculés
   float readout_mclk;   
   float readout_usec;
   float fpa_itr_delay_usec;
   float fpa_iwr_delay_usec;
   float vhd_delay_usec;
   float lovh_usec;
   float fovh_usec;
   float fpa_reset_time_usec;
   float int_signal_high_time_usec;
   float tri_min_usec;
   float frame_period_usec;
   float frame_rate_max_hz;
   float mode_int_end_to_trig_start_dly_usec;
   float mode_readout_end_to_trig_start_dly_usec;
   float mode_trig_start_to_trig_start_dly_usec;
   float mode_all_end_to_trig_start_dly_usec;
};
typedef struct scorpiomw_param_s  scorpiomw_param_t;

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F; 
ProximCfg_t ProximCfg = {{0, 0, 0, 0,  0, 0, 5096, 2594}, 0, 0};   // les valeurs d'initisalisation des dacs sont les 8 premiers chiffres
uint8_t sw_init_done = 0;
t_FpaResolutionCfg gFpaResolutionCfg[FPA_MAX_NUMBER_CONFIG_MODE] = {FPA_STANDARD_RESOLUTION};


// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);
void FPA_SpecificParams(scorpiomw_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA);




//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   // sw_init_done = 0;                                               
   FPA_Reset(ptrA);
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides Mglk Detector
   FPA_GetTemperature(ptrA);                                                // demande de lecture
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoyée au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour. placé en dernier lieu afin que la config d'initialisation soit latchée avant allumage du détecteur
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
   FPA_GetTemperature(ptrA); 
   sw_init_done = 1;                                              
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
// pour configuer le bloc vhd FPA_interface et le lancer
//--------------------------------------------------------------------------
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs)
{ 
   scorpiomw_param_t hh;
   //gcRegistersData_t localGCRegs;
   
   uint32_t Cmin, Cmax, Rmin, Rmax;
   extern int16_t gFpaDetectorPolarizationVoltage;
   static int16_t presentPolarizationVoltage = SCORPIOMWA_DEFAULT_POL;      // ELA 29 Août 2022: 900 mV comme valeur par defaut pour GPOL (avant: 700 mV)
   extern float gFpaDetectorElectricalTapsRef;
   extern float gFpaDetectorElectricalRefOffset;
   static float presentElectricalTapsRef = 10;       // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul 
   static float presentElectricalRefOffset = 0;      // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul
   extern int32_t gFpaDebugRegA;                         // reservé ELCORR pour correction électronique (gain et/ou offset)
   //extern int32_t gFpaDebugRegB;                         // reservé
   extern int32_t gFpaDebugRegC;                         // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk
   extern int32_t gFpaDebugRegD;                         // reservé adc_clk_source_phase pour ajustement fin phase adc_clk
   extern int32_t gFpaDebugRegE;                         // reservé fpa_intf_data_source pour sortir les données des ADCs même lorsque le détecteur/flegX est absent
   extern int32_t gFpaDebugRegF;                         // reservé real_mode_active_pixel_dly pour ajustement du début AOI
   //extern int32_t gFpaDebugRegG;                         // non utilisé
   static uint8_t cfg_num;
   extern int32_t gFpaExposureTimeOffset;
   
   // on bâtit les parametres specifiques du scorpiomw
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
   
   // allumage du détecteur 
   ptrA->fpa_pwr_on   = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   
   // gFpaDebugRegE :  mode diag vrai et faked
   ptrA->fpa_intf_data_source = DATA_SOURCE_INSIDE_FPGA;     // fpa_intf_data_source n'est utilisé/regardé par le vhd que lorsque fpa_diag_mode = 1
   if (ptrA->fpa_diag_mode == 1){
      if ((int32_t)gFpaDebugRegE != 0)
         ptrA->fpa_intf_data_source = DATA_SOURCE_OUTSIDE_FPGA;
   }
   
   //  itr forcé
   //if (pGCRegs->IntegrationMode == IM_IntegrateThenRead) // mode ITR
      ptrA->roic_itr = 1;
   //else  // mode IWR
   //   ptrA->roic_itr = 0;
   
   
   // config du contrôleur de trigs
  // if (ptrA->roic_itr == 1) {
   ptrA->fpa_acq_trig_mode         = (uint32_t)MODE_INT_END_TO_TRIG_START;
   ptrA->fpa_acq_trig_ctrl_dly     = (uint32_t)((hh.mode_int_end_to_trig_start_dly_usec*1e-6F) * (float)VHD_CLK_100M_RATE_HZ);
   // }
   // else {
   //   ptrA->fpa_acq_trig_mode         = (uint32_t)MODE_ALL_END_TO_TRIG_START;
   //   ptrA->fpa_acq_trig_ctrl_dly     = (uint32_t)((hh.mode_all_end_to_trig_start_dly_usec*1e-6F) * (float)VHD_CLK_100M_RATE_HZ);  //
   // }
   
   ptrA->fpa_xtra_trig_mode        = (uint32_t)MODE_READOUT_END_TO_TRIG_START;
   ptrA->fpa_xtra_trig_ctrl_dly    = (uint32_t)((1.0*1e-6F) * (float)VHD_CLK_100M_RATE_HZ); // ENO 20 juin 2022: delai de 1usec pour eviter que IMG_IN_PROGRESS ne soit toujours à '1' d'aune image à l'autreen mode XTRA_TRIG ou PROG_TRIG
   ptrA->fpa_trig_ctrl_timeout_dly = (uint32_t)((float)VHD_CLK_100M_RATE_HZ/(float)FPA_XTRA_TRIG_FREQ_MAX_HZ);
   
   // fenetrage
   ptrA->roic_xstart    = (uint32_t)pGCRegs->OffsetX;
   ptrA->roic_ystart    = (uint32_t)pGCRegs->OffsetY;
   ptrA->roic_xsize     = (uint32_t)pGCRegs->Width;
   ptrA->roic_ysize     = (uint32_t)pGCRegs->Height;
   
   // direction de lecture
   ptrA->roic_uprow_upcol = 1;      //  (uprow_upcol = 1 => uprow = 1 and upcol = 1) or (uprow_upcol = 0 => uprow = 0 and upcol = 0)
   
   // calculé specialement pour le ScorpioMW
   Cmin  = ptrA->roic_xstart/4;
   Cmax  = ptrA->roic_xstart/4 + ptrA->roic_xsize/4 - 1;
   Rmin  = ptrA->roic_ystart;
   Rmax  = ptrA->roic_ystart + ptrA->roic_ysize - 1;
    
   // config détecteur 
   if (ptrA->roic_uprow_upcol == 1){   
      ptrA->roic_windcfg_part1 = Rmin;
      ptrA->roic_windcfg_part2 = Rmax;
      ptrA->roic_windcfg_part3 = Cmin;
      ptrA->roic_windcfg_part4 = Cmax;
   }
   else{   
      ptrA->roic_windcfg_part1 = Rmax;
      ptrA->roic_windcfg_part2 = Rmin;
      ptrA->roic_windcfg_part3 = Cmax;
      ptrA->roic_windcfg_part4 = Cmin;
   }
   
   //  windowing
   ptrA->roic_sizea_sizeb = 0;           // 0 --> toujours en mode windowing 2020-05-06 ODI: pour conservation de la calibration en sous-fenêtre
   //if (((uint32_t)pGCRegs->Width == (uint32_t)FPA_WIDTH_MAX) && ((uint32_t)pGCRegs->Height == (uint32_t)FPA_HEIGHT_MAX))
      //ptrA->roic_sizea_sizeb = 1;        // mode pleine fenetre à l'initialisation

   //  gain 
   ptrA->roic_gain = FPA_GAIN_0;   	//Low gain only 
   
   ptrA->roic_reset_time_mclk  = (uint32_t)hh.fpa_reset_time_mclk;
      
   // GPOL voltage 
   if (sw_init_done == 0){
      ProximCfg.vdac_value[5] = FLEG_VccVoltage_To_DacWord((float)SCORPIOMWA_DEFAULT_POL, 6);
      ptrA->roic_gpol_code = (int32_t)ProximCfg.vdac_value[5];
   }      
   if (gFpaDetectorPolarizationVoltage != presentPolarizationVoltage){      // gFpaDetectorPolarizationVoltage est en milliVolt
      if ((gFpaDetectorPolarizationVoltage >= (int16_t)SCORPIOMW_DET_BIAS_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= (int16_t)SCORPIOMW_DET_BIAS_VOLTAGE_MAX_mV)){
         ProximCfg.vdac_value[5] = FLEG_VccVoltage_To_DacWord((float)gFpaDetectorPolarizationVoltage, 6);  // roic_gpol_code change si la nouvelle valeur est conforme. Sinon la valeur precedente est conservée. (voir FpaIntf_Ctor) pour la valeur d'initialisation
         ptrA->roic_gpol_code = (int32_t)ProximCfg.vdac_value[5];
      }   
   }
   presentPolarizationVoltage = (int16_t)(FLEG_DacWord_To_VccVoltage((uint32_t)ptrA->roic_gpol_code, 6));
   gFpaDetectorPolarizationVoltage = presentPolarizationVoltage;                        
   
   // Registre F : ajustement des delais de la chaine
   if (sw_init_done == 0)
      gFpaDebugRegF = SCORPIOMWA_DEFAULT_REGF;
   ptrA->real_mode_active_pixel_dly = (uint32_t)gFpaDebugRegF;  
      
   ptrA->diag_ysize             = ptrA->roic_ysize;
   ptrA->diag_xsize_div_tapnum  = ptrA->roic_xsize/(uint32_t)hh.tap_number;
    
   // quad2                                                                
   ptrA->adc_quad2_en = 0;   //                                            
   ptrA->chn_diversity_en = ptrA->adc_quad2_en;                      // 
   
   // raw area 
   ptrA->raw_area_line_start_num          = 1;
   ptrA->raw_area_line_end_num            = ptrA->roic_ysize + ptrA->raw_area_line_start_num - 1;
   ptrA->raw_area_line_period_pclk        = (ptrA->roic_xsize/((uint32_t)FPA_NUMTAPS * (uint32_t)hh.pixnum_per_tap_per_mclk)+ (uint32_t)hh.lovh_mclk) *  (uint32_t)hh.pixnum_per_tap_per_mclk;
   ptrA->raw_area_sof_posf_pclk           = ptrA->raw_area_line_period_pclk * (ptrA->raw_area_line_start_num - 1) + 1;                 
   ptrA->raw_area_eof_posf_pclk           = ptrA->raw_area_line_end_num * ptrA->raw_area_line_period_pclk - (uint32_t)(hh.lovh_mclk * hh.pixnum_per_tap_per_mclk);                 
   ptrA->raw_area_sol_posl_pclk           = 1;                 
   ptrA->raw_area_eol_posl_pclk           = (ptrA->roic_xsize/((uint32_t)FPA_NUMTAPS * (uint32_t)hh.pixnum_per_tap_per_mclk)) * (uint32_t)hh.pixnum_per_tap_per_mclk;
   ptrA->raw_area_readout_pclk_cnt_max    = ptrA->raw_area_line_period_pclk * (ptrA->roic_ysize + (uint32_t)hh.fovh_line + ptrA->raw_area_line_start_num - 1) + 1;
   ptrA->raw_area_lsync_start_posl_pclk   = 1;
   ptrA->raw_area_lsync_end_posl_pclk     = 2;
   ptrA->raw_area_lsync_num               = ptrA->raw_area_line_end_num;   
   ptrA->raw_area_clk_id                  = VHD_DEFINE_FPA_NOMINAL_MCLK_ID;
  
   // user area 
   ptrA->user_area_line_start_num         = ptrA->raw_area_line_start_num;    // ligne de debut à 1 et comme on n'utilise plus fpa_data_valid, on a ne ligne avant les données
   ptrA->user_area_line_end_num           = ptrA->raw_area_line_end_num;     
   ptrA->user_area_sol_posl_pclk          = ptrA->raw_area_sol_posl_pclk;
   ptrA->user_area_eol_posl_pclk          = ptrA->raw_area_eol_posl_pclk;         
   ptrA->user_area_clk_id                 = VHD_DEFINE_FPA_NOMINAL_MCLK_ID;
   
   // definition de la zone a. Zone additionnelle de changement d'horloge
   ptrA->clk_area_a_line_start_num        = ptrA->user_area_line_start_num;
   ptrA->clk_area_a_line_end_num          = ptrA->user_area_line_end_num;
   ptrA->clk_area_a_sol_posl_pclk         = ptrA->user_area_sol_posl_pclk;
   ptrA->clk_area_a_eol_posl_pclk         = ptrA->user_area_eol_posl_pclk;   
   ptrA->clk_area_a_clk_id                = VHD_DEFINE_FPA_NOMINAL_MCLK_ID;
   ptrA->clk_area_a_spare                 = 0;
   
   // definition de la zone b. Zone additionnelle de changement d'horloge
   ptrA->clk_area_b_line_start_num        = ptrA->user_area_line_start_num;
   ptrA->clk_area_b_line_end_num          = ptrA->user_area_line_end_num;  
   ptrA->clk_area_b_sol_posl_pclk         = ptrA->user_area_sol_posl_pclk;         
   ptrA->clk_area_b_eol_posl_pclk         = ptrA->user_area_eol_posl_pclk;      
   ptrA->clk_area_b_clk_id                = VHD_DEFINE_FPA_NOMINAL_MCLK_ID;                
   ptrA->clk_area_b_spare                 = 0;  
                        
   ptrA->int_time_offset_mclk    = ptrA->roic_reset_time_mclk;

   // echantillons choisis
   ptrA->good_samp_first_pos_per_ch        = 1;     // n'est pas utilisé
   ptrA->good_samp_last_pos_per_ch         = 1;     // n'est pas utilisé
   ptrA->hgood_samp_sum_num                = ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->hgood_samp_mean_numerator         = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->hgood_samp_sum_num);                            
   ptrA->vgood_samp_sum_num                = ptrA->chn_diversity_en + 1;
   ptrA->vgood_samp_mean_numerator         = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->vgood_samp_sum_num);                              
      
   // calculs
   // ptrA->xsize_div_tapnum                  = ptrA->xsize/(uint32_t)FPA_NUMTAPS;
   
   // les DACs (1 à 8)
   ProximCfg.vdac_value[0]                 = FLEG_VccVoltage_To_DacWord(3300.0F, 1);      // VCC1 -> VDDA = 3300 mV
   ProximCfg.vdac_value[1]                 = FLEG_VccVoltage_To_DacWord(3600.0F, 2);      // VCC2 -> VDDO = 3600 mV
   ProximCfg.vdac_value[2]                 = FLEG_VccVoltage_To_DacWord(3400.0F, 3);      // VCC3 -> VLED = 3400 mV  // pour allumer la LED
   ProximCfg.vdac_value[3]                 = FLEG_VccVoltage_To_DacWord(3300.0F, 4);      // VCC4 -> VDD  = 3300 mV
   ProximCfg.vdac_value[4]                 = FLEG_VccVoltage_To_DacWord(3000.0F, 5);      // VCC5 -> VR   = 3000 mV
   ProximCfg.vdac_value[5]                 = ptrA->roic_gpol_code;                             // VCC6 -> GPOL

   // Reference of the tap (VCC7 ou DAC6)      
   if (gFpaDetectorElectricalTapsRef != presentElectricalTapsRef)
   {
      if ((gFpaDetectorElectricalTapsRef >= (float)SCORPIOMWA_TAPREF_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalTapsRef <= (float)SCORPIOMWA_TAPREF_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[6] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalTapsRef, 7);  // 
	}                                                                                                       
   presentElectricalTapsRef = (float) FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[6], 7);            
   gFpaDetectorElectricalTapsRef = presentElectricalTapsRef;   
   
   // offset of the tap_reference (VCC8 ou DAC7)      
   if (gFpaDetectorElectricalRefOffset != presentElectricalRefOffset)
   {
      if ((gFpaDetectorElectricalRefOffset >= (float)SCORPIOMWA_REFOFS_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalRefOffset <= (float)SCORPIOMWA_REFOFS_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[7] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalRefOffset, 8);  // 
	}                                                                                                       
   presentElectricalRefOffset = (float) FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[7], 8);            
   gFpaDetectorElectricalRefOffset = presentElectricalRefOffset;
   
   // gFpaDebugRegC dephasage grossier des adc_clk 
   if (sw_init_done == 0)
      gFpaDebugRegC = SCORPIOMWA_DEFAULT_REGC;
   ptrA->adc_clk_pipe_sel = (uint32_t)gFpaDebugRegC;                                              
 
   // gFpaDebugRegD dephasage fin des adc_clk 
   if (sw_init_done == 0)         
      gFpaDebugRegD = SCORPIOMWA_DEFAULT_REGD;
   ptrA->adc_clk_source_phase = (uint32_t)gFpaDebugRegD;  
   
   // Élargit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
   // delai tir observé dans le mode où on ignore fpa_data_valid
   ptrA->tir_dly_adc_clk              = (uint32_t)(hh.fpa_itr_delay_mclk);   
   ptrA->nominal_clk_id_sample_pos    = 1;
   ptrA->fast1_clk_id_sample_pos      = 1;
   ptrA->fast2_clk_id_sample_pos      = 1;
   
   // changement de cfg_num des qu'une nouvelle cfg est envoyée au vhd. Il s'en sert pour detecter le mode hors acquisition et ainsi en profite pour calculer le gain electronique
   ptrA->cfg_num  = ++cfg_num;
   
   // additional exposure time offset coming from flash 
   //ptrA->int_time_offset_mclk = (int32_t)((float)gFpaExposureTimeOffset*(float)FPA_MCLK_RATE_HZ/(float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ);
   
   // envoi de la configuration de l'électronique de proximité (les DACs en l'occurrence) par un autre canal 
   FPA_SendProximCfg(&ProximCfg, ptrA);

   // envoi du reste de la config              
   WriteStruct(ptrA);
   
   // printf
   if ((uint32_t)gFpaDebugRegA == 1)
   {
      FPA_INF("ptrA->fpa_diag_mode                         = %d", ptrA->fpa_diag_mode                          );
      FPA_INF("ptrA->fpa_diag_type                         = %d", ptrA->fpa_diag_type                          );
      FPA_INF("ptrA->fpa_pwr_on                            = %d", ptrA->fpa_pwr_on                             );
      FPA_INF("ptrA->fpa_init_cfg                          = %d", ptrA->fpa_init_cfg                           );
      FPA_INF("ptrA->fpa_init_cfg_received                 = %d", ptrA->fpa_init_cfg_received                  );
      FPA_INF("ptrA->fpa_acq_trig_mode                     = %d", ptrA->fpa_acq_trig_mode                      );
      FPA_INF("ptrA->fpa_acq_trig_ctrl_dly                 = %d", ptrA->fpa_acq_trig_ctrl_dly                  );
      FPA_INF("ptrA->fpa_xtra_trig_mode                    = %d", ptrA->fpa_xtra_trig_mode                     );
      FPA_INF("ptrA->fpa_xtra_trig_ctrl_dly                = %d", ptrA->fpa_xtra_trig_ctrl_dly                 );
      FPA_INF("ptrA->fpa_trig_ctrl_timeout_dly             = %d", ptrA->fpa_trig_ctrl_timeout_dly              );
      FPA_INF("ptrA->fpa_stretch_acq_trig                  = %d", ptrA->fpa_stretch_acq_trig                   );
      FPA_INF("ptrA->fpa_intf_data_source                  = %d", ptrA->fpa_intf_data_source                   );
      FPA_INF("ptrA->roic_xstart                           = %d", ptrA->roic_xstart                            );
      FPA_INF("ptrA->roic_ystart                           = %d", ptrA->roic_ystart                            );
      FPA_INF("ptrA->roic_xsize                            = %d", ptrA->roic_xsize                             );
      FPA_INF("ptrA->roic_ysize                            = %d", ptrA->roic_ysize                             );
      FPA_INF("ptrA->roic_windcfg_part1                    = %d", ptrA->roic_windcfg_part1                     );
      FPA_INF("ptrA->roic_windcfg_part2                    = %d", ptrA->roic_windcfg_part2                     );
      FPA_INF("ptrA->roic_windcfg_part3                    = %d", ptrA->roic_windcfg_part3                     );
      FPA_INF("ptrA->roic_windcfg_part4                    = %d", ptrA->roic_windcfg_part4                     );
      FPA_INF("ptrA->roic_uprow_upcol                      = %d", ptrA->roic_uprow_upcol                       );
      FPA_INF("ptrA->roic_sizea_sizeb                      = %d", ptrA->roic_sizea_sizeb                       );
      FPA_INF("ptrA->roic_itr                              = %d", ptrA->roic_itr                               );
      FPA_INF("ptrA->roic_gain                             = %d", ptrA->roic_gain                              );
      FPA_INF("ptrA->roic_gpol_code                        = %d", ptrA->roic_gpol_code                         );
      FPA_INF("ptrA->roic_reset_time_mclk                  = %d", ptrA->roic_reset_time_mclk                   );
      FPA_INF("ptrA->diag_ysize                            = %d", ptrA->diag_ysize                             );
      FPA_INF("ptrA->diag_xsize_div_tapnum                 = %d", ptrA->diag_xsize_div_tapnum                  );
      FPA_INF("ptrA->real_mode_active_pixel_dly            = %d", ptrA->real_mode_active_pixel_dly             );
      FPA_INF("ptrA->adc_quad2_en                          = %d", ptrA->adc_quad2_en                           );
      FPA_INF("ptrA->chn_diversity_en                      = %d", ptrA->chn_diversity_en                       );
      FPA_INF("ptrA->raw_area_line_start_num               = %d", ptrA->raw_area_line_start_num                );
      FPA_INF("ptrA->raw_area_line_end_num                 = %d", ptrA->raw_area_line_end_num                  );
      FPA_INF("ptrA->raw_area_sof_posf_pclk                = %d", ptrA->raw_area_sof_posf_pclk                 );
      FPA_INF("ptrA->raw_area_eof_posf_pclk                = %d", ptrA->raw_area_eof_posf_pclk                 );
      FPA_INF("ptrA->raw_area_sol_posl_pclk                = %d", ptrA->raw_area_sol_posl_pclk                 );
      FPA_INF("ptrA->raw_area_eol_posl_pclk                = %d", ptrA->raw_area_eol_posl_pclk                 );
      FPA_INF("ptrA->raw_area_lsync_start_posl_pclk        = %d", ptrA->raw_area_lsync_start_posl_pclk         );
      FPA_INF("ptrA->raw_area_lsync_end_posl_pclk          = %d", ptrA->raw_area_lsync_end_posl_pclk           );
      FPA_INF("ptrA->raw_area_lsync_num                    = %d", ptrA->raw_area_lsync_num                     );
      FPA_INF("ptrA->raw_area_clk_id                       = %d", ptrA->raw_area_clk_id                        );
      FPA_INF("ptrA->raw_area_line_period_pclk             = %d", ptrA->raw_area_line_period_pclk              );
      FPA_INF("ptrA->raw_area_readout_pclk_cnt_max         = %d", ptrA->raw_area_readout_pclk_cnt_max          );
      FPA_INF("ptrA->user_area_line_start_num              = %d", ptrA->user_area_line_start_num               );
      FPA_INF("ptrA->user_area_line_end_num                = %d", ptrA->user_area_line_end_num                 );
      FPA_INF("ptrA->user_area_sol_posl_pclk               = %d", ptrA->user_area_sol_posl_pclk                );
      FPA_INF("ptrA->user_area_eol_posl_pclk               = %d", ptrA->user_area_eol_posl_pclk                );
      FPA_INF("ptrA->user_area_clk_id                      = %d", ptrA->user_area_clk_id                       );
      FPA_INF("ptrA->clk_area_a_line_start_num             = %d", ptrA->clk_area_a_line_start_num              );
      FPA_INF("ptrA->clk_area_a_line_end_num               = %d", ptrA->clk_area_a_line_end_num                );
      FPA_INF("ptrA->clk_area_a_sol_posl_pclk              = %d", ptrA->clk_area_a_sol_posl_pclk               );
      FPA_INF("ptrA->clk_area_a_eol_posl_pclk              = %d", ptrA->clk_area_a_eol_posl_pclk               );
      FPA_INF("ptrA->clk_area_a_clk_id                     = %d", ptrA->clk_area_a_clk_id                      );
      FPA_INF("ptrA->clk_area_a_spare                      = %d", ptrA->clk_area_a_spare                       );
      FPA_INF("ptrA->clk_area_b_line_start_num             = %d", ptrA->clk_area_b_line_start_num              );
      FPA_INF("ptrA->clk_area_b_line_end_num               = %d", ptrA->clk_area_b_line_end_num                ); 
      FPA_INF("ptrA->clk_area_b_sol_posl_pclk              = %d", ptrA->clk_area_b_sol_posl_pclk               );
      FPA_INF("ptrA->clk_area_b_eol_posl_pclk              = %d", ptrA->clk_area_b_eol_posl_pclk               );
      FPA_INF("ptrA->clk_area_b_clk_id                     = %d", ptrA->clk_area_b_clk_id                      );
      FPA_INF("ptrA->clk_area_b_spare                      = %d", ptrA->clk_area_b_spare                       );
      FPA_INF("ptrA->hgood_samp_sum_num                    = %d", ptrA->hgood_samp_sum_num                     );
      FPA_INF("ptrA->hgood_samp_mean_numerator             = %d", ptrA->hgood_samp_mean_numerator              );
      FPA_INF("ptrA->vgood_samp_sum_num                    = %d", ptrA->vgood_samp_sum_num                     );
      FPA_INF("ptrA->vgood_samp_mean_numerator             = %d", ptrA->vgood_samp_mean_numerator              );
      FPA_INF("ptrA->good_samp_first_pos_per_ch            = %d", ptrA->good_samp_first_pos_per_ch             );
      FPA_INF("ptrA->good_samp_last_pos_per_ch             = %d", ptrA->good_samp_last_pos_per_ch              );
      FPA_INF("ptrA->adc_clk_source_phase                  = %d", ptrA->adc_clk_source_phase                   );
      FPA_INF("ptrA->adc_clk_pipe_sel                      = %d", ptrA->adc_clk_pipe_sel                       );
      FPA_INF("ptrA->cfg_num                               = %d", ptrA->cfg_num                                );
      FPA_INF("ptrA->int_time_offset_mclk                  = %d", ptrA->int_time_offset_mclk                   );
      FPA_INF("ptrA->nominal_clk_id_sample_pos             = %d", ptrA->nominal_clk_id_sample_pos              ); 
      FPA_INF("ptrA->fast1_clk_id_sample_pos               = %d", ptrA->fast1_clk_id_sample_pos                ); 
      FPA_INF("ptrA->fast2_clk_id_sample_pos               = %d", ptrA->fast2_clk_id_sample_pos                ); 
      // FPA_INF("reference_image_mode_en                     = %d", reference_image_mode_en                      );
      FPA_INF("ptrA->single_samp_mode_en                   = %d", ptrA->single_samp_mode_en                    ); 
   }
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
     // courbe de conversion de Sofradir pour une polarisation de 25µA   
    temperature  =  -302.64F * powf(diode_voltage,4);
    temperature +=   687.45F * powf(diode_voltage,3);
    temperature +=  -595.36F * powf(diode_voltage,2);
    temperature += (-188.47F * diode_voltage) + 490.33F;
  }	
  
   return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius
}      

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au scorpiomw avec une config
//--------------------------------------------------------------------------
void FPA_SpecificParams(scorpiomw_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // Période d'horloge selon la variante de modèle
   if (flashSettings.AcquisitionFrameRateMaxDivider > 1.0F)             // 2021-02-26 ELA: modèle SPARK M100 dès que le diviseur > 1.0
      ptrH->mclk_period_usec     = MODEL_M100_FR_DIVIDER * 1e6F/(float)FPA_MCLK_RATE_HZ; // FR diminué
   else
      ptrH->mclk_period_usec     = 1e6F/(float)FPA_MCLK_RATE_HZ;        // modèle M200

   // parametres statiques
   ptrH->tap_number              = (float)FPA_NUMTAPS;
   ptrH->pixnum_per_tap_per_mclk = 1.0F;
   ptrH->fpa_reset_time_mclk     = 3076.0F;
   ptrH->fpa_itr_delay_mclk      = 4.0F + pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number);
   ptrH->fpa_iwr_delay_mclk      = 4.0F + pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) + 40.0F;// FPA: estimation delai max de sortie des pixels après integration + delai après readout. 
   ptrH->vhd_delay_mclk          = (float)VHD_PIXEL_PIPE_DLY_SEC * (1e6F/ptrH->mclk_period_usec) + 14.0F;   // estimation des differerents delais accumulés par le vhd. ENO 11 juillet 2021: delai supplémentaire de 14 MCLK rajouté à tous les modes (ITR et IWR)
   ptrH->lovh_mclk               = 0.0F;
   ptrH->fovh_line               = 0.0F;   
   ptrH->pclk_rate_hz            = ptrH->pixnum_per_tap_per_mclk * (float)FPA_MCLK_RATE_HZ;

   // readout time
   ptrH->readout_mclk         = (pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) + ptrH->lovh_mclk)*(pGCRegs->Height + ptrH->fovh_line);
   ptrH->readout_usec         = ptrH->readout_mclk * ptrH->mclk_period_usec;
   
   // delay
   ptrH->vhd_delay_usec       = ptrH->vhd_delay_mclk * ptrH->mclk_period_usec;
   ptrH->fpa_itr_delay_usec   = ptrH->fpa_itr_delay_mclk * ptrH->mclk_period_usec;
   ptrH->fpa_iwr_delay_usec   = ptrH->fpa_iwr_delay_mclk * ptrH->mclk_period_usec;
   
   // integration time/signal
   ptrH->fpa_reset_time_usec  = ptrH->fpa_reset_time_mclk * ptrH->mclk_period_usec;
   ptrH->int_signal_high_time_usec = exposureTime_usec + ptrH->fpa_reset_time_usec;
      
   // calcul de la periode minimale
   //if (pGCRegs->IntegrationMode == IM_IntegrateThenRead) 
   // mode ITR
      ptrH->frame_period_usec = ptrH->int_signal_high_time_usec + ptrH->vhd_delay_usec + ptrH->fpa_itr_delay_usec + ptrH->readout_usec;
   //else  
   // mode IWR
   //   ptrH->frame_period_usec = MAX(ptrH->int_signal_high_time_usec, ptrH->fpa_reset_time_usec + ptrH->fpa_iwr_delay_usec + ptrH->readout_usec) + ptrH->vhd_delay_usec;

   //calcul du frame rate maximal
   ptrH->frame_rate_max_hz = 1.0F/(ptrH->frame_period_usec*1e-6F);

   //autres calculs
   ptrH->mode_int_end_to_trig_start_dly_usec = ptrH->frame_period_usec - ptrH->int_signal_high_time_usec - ptrH->vhd_delay_usec;  // utilisé en mode int_end_trig_start. // pour le scorpiomW, ptrH->fpa_reset_time_usec est vu dans le vhd comme un prolongement du temps d'integration
   ptrH->mode_readout_end_to_trig_start_dly_usec = 0.0F;
   ptrH->mode_trig_start_to_trig_start_dly_usec  = ptrH->frame_period_usec - ptrH->vhd_delay_usec;
   ptrH->mode_all_end_to_trig_start_dly_usec = 1.0F * ptrH->mclk_period_usec;  // on se donne un delai de 1 MCLK en mode ALL_END_TRIG_START
}
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate; 
   scorpiomw_param_t hh;
   
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
   scorpiomw_param_t hh;
   float presentPeriod_sec;
   float max_exposure_usec;
   float fpaAcquisitionFrameRate;
   
   // ENO: 10 sept 2016: d'entrée de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur   
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);
   
   // ENO: 10 sept 2016: tout reste inchangé
   FPA_SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition était nulle
   presentPeriod_sec = 1.0F/fpaAcquisitionFrameRate; // periode avec le frame rate actuel.
   //if (pGCRegs->IntegrationMode == IM_IntegrateThenRead) // mode ITR
   //{
      float periodMinWithNullExposure_usec = hh.frame_period_usec;
      max_exposure_usec = (presentPeriod_sec*1e6F - periodMinWithNullExposure_usec);
   //}
   //else  // mode IWR
   //{
   //   max_exposure_usec = (presentPeriod_sec*1e6F - hh.vhd_delay_usec) - hh.fpa_reset_time_usec;
   //}

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
//   uint32_t *p_addr = (uint32_t *)(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD);
//
//   FPA_INF("int_time = %u", *p_addr++);

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
// Pour activer/désactiver la LED de warning.
//--------------------------------------------------------------------------
void FPA_SetWarningLed(const t_FpaIntf *ptrA, const bool enable)
{
   if (enable)
   {
      AXI4L_write32(FPA_ROIC_UNKNOWN, ptrA->ADD + AW_FPA_ROIC_SW_TYPE);
   }
   else
   {
      AXI4L_write32(FPA_ROIC, ptrA->ADD + AW_FPA_ROIC_SW_TYPE);
      FPA_ClearErr(ptrA);
   }
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
