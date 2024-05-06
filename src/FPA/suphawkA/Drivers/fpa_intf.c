/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 23278 $
-- $Author: elarouche $
-- $LastChangedDate: 2019-04-12 16:50:50 -0400 (ven., 12 avr. 2019) $
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
#define MODE_READOUT_END_TO_TRIG_START     0x00      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR uniquement
#define MODE_TRIG_START_TO_TRIG_START      0x01      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR et surtout IWR
#define MODE_INT_END_TO_TRIG_START         0x02      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du IWR et ITR
#define MODE_ITR_TRIG_START_TO_TRIG_START  0x03      // delai pris en compte = periode entre le trig actuel et le prochain. Une fois ce delai observé, on s'assure que le readout est terminé avant de considerer le prochain trig.
#define MODE_ITR_INT_END_TO_TRIG_START     0x04      // delai pris en compte = duree entre la fin de l'integration actuelle et le prochain trig. Une fois ce delai observé, on s'assure que le readout est terminé avant de considerer le prochain trig.

// Gains definis par Selex  
#define FPA_GAIN_0                        0x00      // gros puits
#define FPA_GAIN_1                        0x01      // petit puits
 
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
#define FPA_ROIC                          0x20      // 0x20 -> suphawkA . Provient du fichier fpa_common_pkg.vhd.
#define FPA_ROIC_UNKNOWN                  0xFF      // 0xFF -> ROIC inconnu. Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x01 est celle de OUTPUT_ANALOG
#define FPA_INPUT_TYPE                    0x04      // 0x04 -> input LVCMOS33 .provient du fichier fpa_common_pkg.vhd. La valeur 0x04 est celle de LVCMOS33


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
#define ADC_CLK_SOURCE_RATE_HZ            80000000
#define ADC_SAMPLING_RATE_HZ              FPA_MCLK_RATE_HZ    // les ADC  roulent à FPA_MCLK_RATE_HZ

// lecture de température FPA
#define FPA_TEMP_READER_ADC_DATA_RES      16            // la donnée de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV     2048          // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN              1             // gain du canal de lecture de temperature sur la carte ADC

// fleg
#define FLEG_DAC_RESOLUTION_BITS          14            // le DAC est à 14 bits
#define FLEG_DAC_REF_VOLTAGE_V            2.5           // on utilise la reference interne de 2.5V du DAC 
#define FLEG_DAC_REF_GAIN                 2.0           // gain de référence du DAC


#define VHD_PIXEL_PIPE_DLY_SEC            900E-9        // delai max du pipe des pixels

#define GOOD_SAMP_MEAN_DIV_BIT_POS        21            // ne pas changer meme si le detecteur change.

#define SUPHAWK_DIG_VOLTAGE_MIN_mV        50            // 50 mV
#define SUPHAWK_DIG_VOLTAGE_MAX_mV        2750          // 2750 mV
 
#define FPA_XTRA_TRIG_FREQ_MAX_HZ         30           // ENO: 25 janv 2016: la programmation du dtecteur se fera à cette vitesse au max. Cela donnera assez de coups d'horloges pour les resets quelle que soit la config de fenetre

#define SUPHAWK_TAPREF_VOLTAGE_MIN_mV     500          // valeur en provenance du fichier fpa_define
#define SUPHAWK_TAPREF_VOLTAGE_MAX_mV     5300         // valeur en provenance du fichier fpa_define

#define TOTAL_DAC_NUM                     8

// tension PRV à utiliser pour le supHawk
#define SUPHAWK_PRV_VOLTAGE_VALUE_mV      3900

// Electrical correction : references
#define ELCORR_REF1_VALUE_mV              SUPHAWK_PRV_VOLTAGE_VALUE_mV                //
#define ELCORR_REF2_VALUE_mV              3575
#define ELCORR_REF_DAC_ID                 6                   // position (entre 1 et 8) du dac dédié aux references 
#define ELCORR_REF_MAXIMUM_SAMP           120                 // le nombre de sample au max supporté par le vhd
#define ELCORR_REF_MAXIMUM_DLY            250                 // le delai max supporté par le vhd

// Electrical correction : embedded switches control
#define ELCORR_SW_TO_PATH1                0x01
#define ELCORR_SW_TO_PATH2                0x02
#define ELCORR_SW_TO_NORMAL_OP            0x03 

#define ELCORR_CONT_MODE_OFFSETX_MIN      640

// Electrical correction : valeurs par defaut si aucune mesure dispo dans les flashsettings
#define ELCORR_DEFAULT_STARVATION_DL      440        // @ centered pix (640, 512)
#define ELCORR_DEFAULT_SATURATION_DL      15700      // @ centered pix (640, 512)
#define ELCORR_DEFAULT_REFERENCE1_DL      642        // @ centered pix (640, 512)
#define ELCORR_DEFAULT_REFERENCE2_DL      2897       // @ centered pix (640, 512)

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
#define ELCORR_TARGET_STARVATION_DL       650         // @ centered pix (640, 512)
#define ELCORR_TARGET_SATURATION_DL       16000       // @ centered pix (640, 512)

// clk area (en provenance de fpa_define)
#define  VHD_DEFINE_FPA_NOMINAL_MCLK_ID         0    // horloge nominale (l'horloge par défaut)
#define  VHD_DEFINE_FPA_SIDEBAND_MCLK_ID        1    // horloge de la bande laterale
#define  VHD_DEFINE_FPA_LINEPAUSE_MCLK_ID       2    // horloge de la zone interligne

#define REGC_DEFAULT_VAL 2             // valeur pour le registre REGC
#define REGD_DEFAULT_VAL 528           // valeur pour le registre REGD
#define REGF_DEFAULT_VAL 12            // valeur pour le registre REGF

struct s_ProximCfgConfig 
{   
   uint32_t  vdac_value[(uint8_t)TOTAL_DAC_NUM];
   uint32_t  spare1;                       
   uint32_t  spare2;   
};                                  
typedef struct s_ProximCfgConfig ProximCfg_t;

// structure interne pour les parametres du suphawk
struct suphawk_param_s             // 
{					   
   // parametres à rentrer
   float mclk_period_usec;                       
   float tap_number;
   float pixnum_per_tap_per_mclk;
   float fpa_rst_dly_mclk;
   float vhd_delay_mclk;
   float delay_mclk;
   float lovh_mclk;
   float fovh_line;   
   float int_time_offset_mclk;   
   
   // parametres calculés
   float readout_mclk;   
   float readout_usec;
   float fpa_delay_usec;
   float vhd_delay_usec;
   float delay_usec;
   float lovh_usec;
   float fovh_usec;
   float int_time_offset_usec;
   float tri_min_usec;
   float frame_period_usec;
   float frame_rate_max_hz;       
};
typedef struct suphawk_param_s  suphawk_param_t;

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
uint8_t sw_init_done = 0;
t_FpaStatus gStat;                        // devient une variable globale
ProximCfg_t ProximCfg = {{ 7137, 0, 7137, 4387,  0,  10129, 0, 0}, 0, 0};   // les valeurs d'initisalisation des dacs sont les 8 premiers chiffres
t_FpaResolutionCfg gFpaResolutionCfg[FPA_MAX_NUMBER_CONFIG_MODE] = {FPA_STANDARD_RESOLUTION};

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA);
void FPA_SpecificParams(suphawk_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   // sw_init_done = 0;                                                     // ENO: 11-sept 2019: ligne en commentaire pour que plusieurs appels de FPA_init ne créent des bugs de flashsettings.
   FPA_Reset(ptrA);
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides Mglk Detector
   FPA_GetTemperature(ptrA);                                                // demande de lecture
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoyée au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
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
//pour configuer le bloc vhd FPA_interface et le lancer
//--------------------------------------------------------------------------
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs)
{ 
   suphawk_param_t hh;
   extern int16_t gFpaDetectorPolarizationVoltage;
   static int16_t presentPolarizationVoltage = 700;      //  700 mV comme valeur par defaut pour GPOL
   extern float gFpaDetectorElectricalTapsRef;
   // extern float gFpaDetectorElectricalRefOffset;
   extern int32_t gFpaDebugRegA;                         // reservé ELCORR pour correction électronique (gain et/ou offset)
   extern int32_t gFpaDebugRegB;                         // reservé mode sortie constante (on sort le niveau de PRV)
   extern int32_t gFpaDebugRegC;                         // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk
   extern int32_t gFpaDebugRegD;                         // reservé adc_clk_source_phase pour ajustement fin phase adc_clk
   extern int32_t gFpaDebugRegE;                         // reservé fpa_intf_data_source pour sortir les données des ADCs même lorsque le détecteur/flegX est absent
   extern int32_t gFpaDebugRegF;                         // reservé real_mode_active_pixel_dly pour ajustement du début AOI
   extern int32_t gFpaDebugRegG;                         // annulation de la bande latérale (par défaut, correction active)
   //extern int32_t gFpaDebugRegH;                       // non utilisé
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
   static uint8_t cfg_num;
   uint8_t need_rst_fpa_module;
   extern int32_t gFpaExposureTimeOffset;
   
   

   // on bâtit les parametres specifiques du suphawk
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);               //le temps d'integration est nul . Mais le VHD ajoutera le int_time pour avoir la vraie periode
   
   need_rst_fpa_module = 0;
   
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
   
   // mode diag vrai et faked
   ptrA->fpa_intf_data_source = DATA_SOURCE_INSIDE_FPGA;     // fpa_intf_data_source n'est utilisé/regardé par le vhd que lorsque fpa_diag_mode = 1
   if (ptrA->fpa_diag_mode == 1){
      if ((int32_t)gFpaDebugRegE != 0)
         ptrA->fpa_intf_data_source = DATA_SOURCE_OUTSIDE_FPGA;
   }
   
   // allumage du détecteur 
   ptrA->fpa_pwr_on  = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   
   // config du contrôleur de trigs
   ptrA->fpa_acq_trig_mode     = (uint32_t)MODE_INT_END_TO_TRIG_START;
   if (ptrA->fpa_diag_mode == 1) 
      ptrA->fpa_acq_trig_mode  = (uint32_t)MODE_READOUT_END_TO_TRIG_START;  //  ENO: 11 juillet 2022: mode patron de tests toujours en MODE_READOUT_END_TO_TRIG_START car le patron de tests est toujours plus lent et MODE_READOUT_END_TO_TRIG_START est plus sécuritaire
      
   ptrA->fpa_acq_trig_ctrl_dly     = (uint32_t)((hh.frame_period_usec*1e-6F - (float)VHD_PIXEL_PIPE_DLY_SEC) * (float)VHD_CLK_100M_RATE_HZ);
   ptrA->fpa_xtra_trig_mode        = (uint32_t)MODE_READOUT_END_TO_TRIG_START;
   ptrA->fpa_xtra_trig_ctrl_dly    = ptrA->fpa_acq_trig_ctrl_dly;
   ptrA->fpa_trig_ctrl_timeout_dly = (uint32_t)((float)VHD_CLK_100M_RATE_HZ * 2.0F*(float)FPA_MAX_EXPOSURE*1e-6F); // ENO: 11 juillet 2022: le delai de timeout est egale à 2 fois la durée du temps d'exposition max pour securiser le mode MODE_READOUT_END_TO_TRIG_START.
   
   // fenetrage
   ptrA->xstart    = pGCRegs->OffsetX;
   ptrA->ystart    = pGCRegs->OffsetY;
   ptrA->xsize     = pGCRegs->Width;
   ptrA->ysize     = pGCRegs->Height;
    
   // cropping en sous-fenetrage pour eliminer bande laterale
   if (pGCRegs->Width < FPA_WIDTH_MAX){
      ptrA->xstart    = pGCRegs->OffsetX - FPA_OFFSETX_MULT;
      ptrA->xsize     = pGCRegs->Width + FPA_WIDTH_MULT;
   }
   //  gain 
   ptrA->gain = FPA_GAIN_0;   //Low gain
   if (pGCRegs->SensorWellDepth == SWD_HighGain)
      ptrA->gain = FPA_GAIN_1;   //High gain
      
   // direction de readout
   ptrA->invert = 0;
   ptrA->revert = 0; 
   
   // formule implantée pour le mode normal (revert = 0, Invert = 0) 
   ptrA->colstart =  ptrA->xstart / FPA_NUMTAPS;
   ptrA->colstop  =  ptrA->colstart  + ptrA->xsize / FPA_NUMTAPS - 1;
   ptrA->rowstart =  ptrA->ystart;
   ptrA->rowstop  =  ptrA->rowstart  + pGCRegs->Height - 1;
   
   // CBIT 
   ptrA->cbit_en = 1;                    
   
   // mode windowing ou non
   if ((pGCRegs->Width == FPA_WIDTH_MAX) && (pGCRegs->Height == FPA_HEIGHT_MAX))
      ptrA->active_subwindow = 0;
   else
      ptrA->active_subwindow = 1;
      
   // DIG voltage
   if (sw_init_done == 0)
      ptrA->dig_code = 0x00D3;   
   if (gFpaDetectorPolarizationVoltage != presentPolarizationVoltage){
      if ((gFpaDetectorPolarizationVoltage >= (int16_t)SUPHAWK_DIG_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= (int16_t)SUPHAWK_DIG_VOLTAGE_MAX_mV))
         ptrA->dig_code = (uint32_t)MAX((0.000639F + (float)gFpaDetectorPolarizationVoltage/1000.0F)/0.005344F, 1.0F);  // dig_code change si la nouvelle valeur est conforme. Sinon la valeur precedente est conservée. (voir FpaIntf_Ctor) pour la valeur d'initialisation
	}                                                                                                       
   presentPolarizationVoltage = (int16_t)roundf(1000.0F*(0.005344F*(float)ptrA->dig_code -  0.000639F));             // DIGREF = -0.0055 x DDR + 2.8183   converti en mV
   gFpaDetectorPolarizationVoltage = presentPolarizationVoltage; 
   
   // quad2    
   ptrA->adc_quad2_en = 1;                          
   ptrA->chn_diversity_en = 0;             // ENO : 07 nov 2017 : pas besoin de la diversité de canal dans un suphawk

   // nombre d'échantillons par canal  de carte ADC
   ptrA->pix_samp_num_per_ch               = (uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)FPA_MCLK_RATE_HZ; 
   
   // echantillons choisis
   ptrA->good_samp_first_pos_per_ch        = MAX((uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)FPA_MCLK_RATE_HZ - 1, 1);     // position premier echantillon
   ptrA->good_samp_last_pos_per_ch         = (uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)FPA_MCLK_RATE_HZ;     // position dernier echantillon    ENO: 05 avril 2017: on prend juste un echantillon par canal pour reduire le Ghost. Le bruit augmentera à 6 cnts max sur 16 bits
   ptrA->hgood_samp_sum_num                = ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->hgood_samp_mean_numerator         = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->hgood_samp_sum_num);                            
   ptrA->vgood_samp_sum_num                = 1 + ptrA->chn_diversity_en;
   ptrA->vgood_samp_mean_numerator         = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->vgood_samp_sum_num);                              
      
   // calculs
   ptrA->xsize_div_tapnum                  = ptrA->xsize/(uint32_t)FPA_NUMTAPS;                                        
   
   // les DACs (1 à 8)
   ProximCfg.vdac_value[0]                 = FLEG_VccVoltage_To_DacWord(4200.0F, 1);   // VDDOP
   ProximCfg.vdac_value[1]                 = 0;
   ProximCfg.vdac_value[2]                 = FLEG_VccVoltage_To_DacWord(4200.0F, 3);   // VDDPIX
   ProximCfg.vdac_value[3]                 = FLEG_VccVoltage_To_DacWord(1800.0F, 4);   // VDD
   ProximCfg.vdac_value[4]                 = 0;
   ProximCfg.vdac_value[5]                 = FLEG_VccVoltage_To_DacWord((float)SUPHAWK_PRV_VOLTAGE_VALUE_mV, 6);   // PRV
   ProximCfg.vdac_value[7]                 = 0;                                                      
   
   ptrA->prv_dac_nominal_value = ProximCfg.vdac_value[5]; 
   
   // Registre F : ajustement des delais de la chaine
   if (sw_init_done == 0){
      gFpaDebugRegF = REGF_DEFAULT_VAL;
      if (ptrA->hgood_samp_sum_num > 1)
         gFpaDebugRegF = 3;
   }   
   ptrA->real_mode_active_pixel_dly = (uint32_t)gFpaDebugRegF;
   
   // TAPREF : VCC7 ou DAC7
   if (sw_init_done == 0)
      ProximCfg.vdac_value[6] = FLEG_VccVoltage_To_DacWord(1493.0F, 7); // FLEG_VccVoltage_To_DacWord(2980.0F, 7);
      
   if (gFpaDetectorElectricalTapsRef != presentElectricalTapsRef)
   {
      if ((gFpaDetectorElectricalTapsRef >= (float)SUPHAWK_TAPREF_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalTapsRef <= (float)SUPHAWK_TAPREF_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[6] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalTapsRef, 7);  // 
	}                                                                                                       
   presentElectricalTapsRef = (float) FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[6], 7);            
   gFpaDetectorElectricalTapsRef = presentElectricalTapsRef;
    
   // dephasage des adc_clk avec gFpaDebugRegC et gFpaDebugRegD
   if (sw_init_done == 0)
      gFpaDebugRegC = REGC_DEFAULT_VAL;
   if (ptrA->adc_clk_pipe_sel != (uint32_t)gFpaDebugRegC)
      need_rst_fpa_module = 1;
   ptrA->adc_clk_pipe_sel = (uint32_t)gFpaDebugRegC;                                              
   
   // adc clk source phase
   if (sw_init_done == 0)         
      gFpaDebugRegD = REGD_DEFAULT_VAL;
   if (ptrA->adc_clk_source_phase != (uint32_t)gFpaDebugRegD)
      need_rst_fpa_module = 1;   
   ptrA->adc_clk_source_phase = (uint32_t)gFpaDebugRegD; 
       
   // Élargit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
   // changement de cfg_num des qu'une nouvelle cfg est envoyée au vhd. Il s'en sert pour detecter le mode hors acquisition et ainsi en profite pour calculer le gain electronique
   ptrA->cfg_num  = ++cfg_num;
   
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
      gFpaDebugRegA = 0;
   elcorr_reg = (uint32_t)gFpaDebugRegA;
   
   if (ptrA->fpa_diag_mode == 1)
      elcorr_reg = 0;
  
   if (elcorr_reg == 7){         // pixeldata avec correction du gain et offset electroniques
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
    
   else if (elcorr_reg == 6){    // PRV data avec correction du gain et offset electroniques
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
   
   else if (elcorr_reg == 5){    // pixeldata avec correction de l'offset électronique seulement
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
 
   else if (elcorr_reg == 3){    // image map de la difference des references
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
    
   else if (elcorr_reg == 2){   // image map de la reference 2 (1 dans le vhd)
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
    
   else if (elcorr_reg == 1){    // image map de la reference 1 (0 dans le vhd)
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

   else if (elcorr_reg == 0){    // desactivation de toute correction electronique
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
   elcorr_comp_duration_usec                  = (hh.fpa_rst_dly_mclk - 60.0F) * hh.mclk_period_usec;  // le calcul se fait sur la ligne de reset                          
   
   ptrA->elcorr_enabled                       = elcorr_enabled;
   ptrA->elcorr_spare1                        = 0;              
   ptrA->elcorr_spare2                        = 0;                     
                                                  
   // vhd reference 0:                                              
   ptrA->elcorr_ref_cfg_0_ref_enabled         = 1;               
   ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode  = 0;              
   ptrA->elcorr_ref_cfg_0_start_dly_sampclk   = (uint32_t)MIN(40, (uint32_t)ELCORR_REF_MAXIMUM_DLY); //2;  on s'éloigne du debut de la ligne de reset car peu instabilité en focntion de ExposureTime       
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)(hh.pixnum_per_tap_per_mclk * elcorr_comp_duration_usec / hh.mclk_period_usec); // nombre brut d'échantillons par tap 
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     =  ptrA->elcorr_ref_cfg_0_samp_num_per_ch - (ptrA->elcorr_ref_cfg_0_start_dly_sampclk + 2.0F); // on eneleve le delai de ce chiffre et aussi 2.0 pour avoir de la marge
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)MIN(ptrA->elcorr_ref_cfg_0_samp_num_per_ch, (uint32_t)ELCORR_REF_MAXIMUM_SAMP);
   ptrA->elcorr_ref_cfg_0_samp_mean_numerator = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elcorr_ref_cfg_0_samp_num_per_ch);     
   ptrA->elcorr_ref_cfg_0_ref_value           = (uint32_t) FLEG_VccVoltage_To_DacWord((float)ELCORR_REF1_VALUE_mV, (int8_t)ELCORR_REF_DAC_ID);  //      
   ptrA->elcorr_ref_cfg_0_forced_val_enabled  = 0; // si actif la valeur forcee remplace la valeur echantillonnee
   ptrA->elcorr_ref_cfg_0_forced_val          = 0; // ignoree si le enabled est 0
    
   // vhd reference 1: 
   ptrA->elcorr_ref_cfg_1_ref_enabled         = 1;              
   ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode  = 0;              
   ptrA->elcorr_ref_cfg_1_start_dly_sampclk   = (uint32_t)MIN(40, (uint32_t)ELCORR_REF_MAXIMUM_DLY); //2;        
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     = (uint32_t)(hh.pixnum_per_tap_per_mclk * elcorr_comp_duration_usec / hh.mclk_period_usec); // nombre brut d'échantillons par tap 
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     =  ptrA->elcorr_ref_cfg_1_samp_num_per_ch - (ptrA->elcorr_ref_cfg_1_start_dly_sampclk + 2.0F); // on eneleve le delai de ce chiffre et aussi 2.0 pour avoir de la marge
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     = (uint32_t)MIN(ptrA->elcorr_ref_cfg_1_samp_num_per_ch, (uint32_t)ELCORR_REF_MAXIMUM_SAMP);
   ptrA->elcorr_ref_cfg_1_samp_mean_numerator = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elcorr_ref_cfg_1_samp_num_per_ch);     
   ptrA->elcorr_ref_cfg_1_ref_value           = (uint32_t) FLEG_VccVoltage_To_DacWord((float)ELCORR_REF2_VALUE_mV, (int8_t)ELCORR_REF_DAC_ID);  //
   ptrA->elcorr_ref_cfg_1_forced_val_enabled  = 0; // si actif la valeur forcee remplace la valeur echantillonnee
   ptrA->elcorr_ref_cfg_1_forced_val          = 0; // ignoree si le enabled est 0
    
   ptrA->elcorr_ref_dac_id                    = (uint32_t)ELCORR_REF_DAC_ID;  //       
   ptrA->elcorr_atemp_gain                    = (int32_t)elcorr_atemp_gain;      
   ptrA->elcorr_atemp_ofs                     = (int32_t)elcorr_atemp_ofs;
   
   if (ptrA->roic_cst_output_mode == 1){
      ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode = 1;    
      ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode = 1;
   }   
      
   // desactivation en mode patron de tests
   if (ptrA->fpa_diag_mode == 1){
      ptrA->elcorr_enabled = 0;
	   ptrA->elcorr_ref_cfg_0_ref_enabled = 0;
	   ptrA->elcorr_ref_cfg_1_ref_enabled = 0;	  
   }
   
   ptrA->roic_cst_output_mode = (uint32_t)gFpaDebugRegB; 
   
   // additional exposure time offset coming from flash 
   ptrA->additional_fpa_int_time_offset = (int32_t)((float)gFpaExposureTimeOffset*(float)FPA_MCLK_RATE_HZ/(float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ);

   // Contrôleur de readout

   // raw area (fenêtre en provenance du ROIC)
   ptrA->raw_area_line_start_num = 1;
   ptrA->raw_area_line_end_num = ptrA->raw_area_line_start_num + ptrA->ysize - 1;
   ptrA->raw_area_line_period_pclk = ptrA->xsize/FPA_NUMTAPS + (uint32_t)(hh.lovh_mclk * hh.pixnum_per_tap_per_mclk);
   ptrA->raw_area_sof_posf_pclk = (uint32_t)hh.lovh_mclk + 1;
   ptrA->raw_area_eof_posf_pclk = ptrA->raw_area_line_end_num * ptrA->raw_area_line_period_pclk;
   ptrA->raw_area_sol_posl_pclk = (uint32_t)hh.lovh_mclk + 1;
   ptrA->raw_area_eol_posl_pclk = ptrA->raw_area_line_period_pclk;
   ptrA->raw_area_readout_pclk_cnt_max =  ptrA->raw_area_line_period_pclk * ptrA->ysize + (uint32_t)(hh.fpa_rst_dly_mclk * hh.pixnum_per_tap_per_mclk);
            // ligne de reset du suphawk prise en compte;
   ptrA->raw_area_lsync_start_posl_pclk = 1;
   ptrA->raw_area_lsync_end_posl_pclk = 1;
   ptrA->raw_area_lsync_num = ptrA->raw_area_line_end_num;
   ptrA->raw_area_clk_id = VHD_DEFINE_FPA_NOMINAL_MCLK_ID;

   // user area (fenetre à envoyer à l'usager)
   ptrA->user_area_line_start_num = ptrA->raw_area_line_start_num;
   ptrA->user_area_line_end_num = ptrA->raw_area_line_end_num;
   ptrA->user_area_sol_posl_pclk = ptrA->raw_area_sol_posl_pclk;
   ptrA->user_area_eol_posl_pclk = ptrA->raw_area_eol_posl_pclk;
   ptrA->user_area_clk_id = VHD_DEFINE_FPA_NOMINAL_MCLK_ID;

   // cropping en sous-fenetrage pour eliminer bande laterale
   if (pGCRegs->Width < FPA_WIDTH_MAX)
      ++ptrA->user_area_sol_posl_pclk;

   // définition de la zone a (bande latérale)
   ptrA->clk_area_a_line_start_num = ptrA->user_area_line_start_num;
   ptrA->clk_area_a_line_end_num = ptrA->user_area_line_end_num;
   ptrA->clk_area_a_sol_posl_pclk = ptrA->user_area_sol_posl_pclk;
   ptrA->clk_area_a_eol_posl_pclk = ptrA->user_area_sol_posl_pclk;
   ptrA->clk_area_a_clk_id = VHD_DEFINE_FPA_SIDEBAND_MCLK_ID;
   ptrA->clk_area_a_spare = 0;

   // cropping en sous-fenetrage pour eliminer bande laterale
   if (pGCRegs->Width < FPA_WIDTH_MAX)
      ptrA->clk_area_a_clk_id = VHD_DEFINE_FPA_NOMINAL_MCLK_ID;

   // définition de la zone b (pause interligne)
   ptrA->clk_area_b_line_start_num = 0;
   ptrA->clk_area_b_line_end_num = ptrA->user_area_line_end_num;
   ptrA->clk_area_b_sol_posl_pclk = 1;
   ptrA->clk_area_b_eol_posl_pclk = ptrA->user_area_sol_posl_pclk - 1; // juste avant le debut de la zone user  ;
   ptrA->clk_area_b_clk_id = VHD_DEFINE_FPA_LINEPAUSE_MCLK_ID;
   ptrA->clk_area_b_spare = 0;

   // others
   ptrA->roic_rst_time_mclk = (uint32_t)hh.fpa_rst_dly_mclk;
   ptrA->sideband_cancel_en = (gFpaDebugRegG == 0 ? 1 : 0);
   ptrA->spare4 = 0;

   if (!ptrA->sideband_cancel_en){
      ptrA->clk_area_a_clk_id = VHD_DEFINE_FPA_NOMINAL_MCLK_ID;
      ptrA->clk_area_b_clk_id = VHD_DEFINE_FPA_NOMINAL_MCLK_ID;
   }

   // envoi de la configuration de l'électronique de proximité (les DACs en l'occurrence) par un autre canal 
   FPA_SendProximCfg(&ProximCfg, ptrA);

   // envoi du reste de la config 
   WriteStruct(ptrA);
   
   // reset du module vhd. Il va demarrer alors avec la config precedemment envoyée
   if (need_rst_fpa_module == 1){
      need_rst_fpa_module = 0;
      FPA_Reset(ptrA);
      FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
      FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides Mglk Detector
   }
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la température du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{
   float diode_voltage_mV, diode_voltage;
   float temperature;
   //float TempCoeff[2];
   
   FPA_GetStatus(&gStat, ptrA);

   diode_voltage_mV = (float)gStat.fpa_temp_raw * ((float)FPA_TEMP_READER_FULL_SCALE_mV)/(exp2f(FPA_TEMP_READER_ADC_DATA_RES)*(float)FPA_TEMP_READER_GAIN);
   diode_voltage = diode_voltage_mV / 1000.0F;
   
   if (gStat.fpa_init_done == 0){   
      return FPA_INVALID_TEMP;
   }
   else{
      // utilisation  des valeurs de flashsettings
      temperature  = flashSettings.FPATemperatureConversionCoef2 * powf(diode_voltage,2);
      temperature += flashSettings.FPATemperatureConversionCoef1 * diode_voltage;
      temperature += flashSettings.FPATemperatureConversionCoef0;
      
      // Si flashsettings non programmés alors on utilise les valeurs par defaut
      if ((flashSettings.FPATemperatureConversionCoef2 == 0) && (flashSettings.FPATemperatureConversionCoef1 == 0) &&
          (flashSettings.FPATemperatureConversionCoef0 == 0)) {
         // courbe de conversion selon Selex 
         temperature  =  -0.00014440F * powf(diode_voltage_mV,2) - 0.27652F * diode_voltage_mV + 524.0F;
      }
      return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius
   }   
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au suphawk avec une config 
//--------------------------------------------------------------------------
void FPA_SpecificParams(suphawk_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   extern int32_t gFpaExposureTimeOffset;

   // parametres statiques
   ptrH->mclk_period_usec        = 1e6F/(float)FPA_MCLK_RATE_HZ;
   ptrH->tap_number              = (float)FPA_NUMTAPS;
   ptrH->pixnum_per_tap_per_mclk = 1.0F;
   ptrH->fpa_rst_dly_mclk        = 165.0F;   // FPA: delai reglémentaire de 165 MCLK à la fin d'une image en ITR + 1 MCL en debut d'image
   ptrH->vhd_delay_mclk          = 12.0F;     // estimation des differerents delais accumulés par le vhd
   ptrH->delay_mclk              = ptrH->fpa_rst_dly_mclk + ptrH->vhd_delay_mclk;   //
   ptrH->lovh_mclk               = 3.0F;
   ptrH->fovh_line               = 0.0F;
   ptrH->int_time_offset_mclk    = fabs((float)gFpaExposureTimeOffset * (float)FPA_MCLK_RATE_HZ / (float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ); // eventuel offset en provenance de la calibration via flash. La valeur absolue permet de le considerer comme un delai supplémetaire dans le pire ds cas
      
   // readout time
   ptrH->readout_mclk            = (pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) + ptrH->lovh_mclk)*(pGCRegs->Height + ptrH->fovh_line);
   ptrH->readout_usec            = ptrH->readout_mclk * ptrH->mclk_period_usec;
   
   // delay
   ptrH->vhd_delay_usec          = ptrH->vhd_delay_mclk * ptrH->mclk_period_usec;
   ptrH->fpa_delay_usec          = ptrH->fpa_rst_dly_mclk * ptrH->mclk_period_usec;
   ptrH->delay_usec              = ptrH->delay_mclk * ptrH->mclk_period_usec; 
   
   // 
   ptrH->int_time_offset_usec    = ptrH->int_time_offset_mclk * ptrH->mclk_period_usec;
      
   // calcul de la periode minimale
   ptrH->frame_period_usec = exposureTime_usec + ptrH->int_time_offset_usec + ptrH->delay_usec + ptrH->readout_usec;
   
   //calcul du frame rate maximal
   ptrH->frame_rate_max_hz = 1.0F/(ptrH->frame_period_usec*1e-6F);
}
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate; 
   suphawk_param_t hh;
   
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
   suphawk_param_t hh;
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
