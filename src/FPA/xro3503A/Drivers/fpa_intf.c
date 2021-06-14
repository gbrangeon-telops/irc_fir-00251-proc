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
#include "tec_intf.h"
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

// Mode d'operation choisi pour le contrôleur de trig (voir fichier fpa_common_pkg.vhd)
#define MODE_READOUT_END_TO_TRIG_START     0x00      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR uniquement
#define MODE_TRIG_START_TO_TRIG_START      0x01      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR et surtout IWR
#define MODE_INT_END_TO_TRIG_START         0x02      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du IWR et ITR
#define MODE_ITR_TRIG_START_TO_TRIG_START  0x03      // delai pris en compte = periode entre le trig actuel et le prochain. Une fois ce delai observé, on s'assure que le readout est terminé avant de considerer le prochain trig.
#define MODE_ITR_INT_END_TO_TRIG_START     0x04      // delai pris en compte = duree entre la fin de l'integration actuelle et le prochain trig. Une fois ce delai observé, on s'assure que le readout est terminé avant de considerer le prochain trig.

// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400    // adresse de base 
#define AR_FPA_TEMPERATURE                0x002C    // adresse temperature

// adresse d'écriture du régistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xAE0      // adresse à laquelle on dit au VHD quel type de roic de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xAE4      // adresse à laquelle on dit au VHD quel type de sortie de fpa le pilote en C est conçu pour.
#define AW_FPA_INPUT_SW_TYPE              0xAE8      // obligatoire pour les detecteurs analogiques

// adresse d'ecriture de la cfg des Dacs
#define AW_DAC_CFG_BASE_ADD               0x0D00   

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x21      // 0x21 -> xro3503A. Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique. Provient du fichier fpa_common_pkg.vhd. La valeur 0x01 est celle de OUTPUT_ANALOG
#define FPA_INPUT_TYPE                    0x04      // 0x04 -> input LVCMOS33. Provient du fichier fpa_common_pkg.vhd

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

// lecture de température FPA
#define FPA_TEMP_READER_ADC_DATA_RES      16            // la donnée de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV     2048          // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN              1             // gain du canal de lecture de temperature sur la carte ADC

// fleg
#define FLEG_DAC_RESOLUTION_BITS          14            // le DAC est à 14 bits
#define FLEG_DAC_REF_VOLTAGE_V            2.5           // on utilise la reference interne de 2.5V du DAC 
#define FLEG_DAC_REF_GAIN                 2.0           // gain de référence du DAC

#define GOOD_SAMP_MEAN_DIV_BIT_POS        21            // ne pas changer meme si le detecteur change.

#define XRO3503_CTIA_BIAS_MAX             0xF           // value must be in 0x0 to 0xF

#define XRO3503_POL_VOLTAGE_MIN_mV        100           // pas spécifié, VPOLmin = DETECTSUBmin - CTIA_REFmax
#define XRO3503_POL_VOLTAGE_MAX_mV        1400          // pas spécifié, VPOLmax = DETECTSUBmax - CTIA_REFmin

#define XRO3503_TAPREF_VOLTAGE_MIN_mV     500.0F        // limite du LDO
#define XRO3503_TAPREF_VOLTAGE_MAX_mV     5300.0F       // limite du LDO, AD8130 absolute max Vin est ±8.4V

#define TOTAL_DAC_NUM                     8

struct s_ProximCfgConfig 
{   
   uint32_t  vdac_value[(uint8_t)TOTAL_DAC_NUM];
   uint32_t  spare1;                       
   uint32_t  spare2;   
};                                  
typedef struct s_ProximCfgConfig ProximCfg_t;

// structure interne pour les parametres du xro3503
struct xro3503_param_s
{					   
   // parametres à rentrer
   float mclk_period_usec;
   float fpa_delay_mclk;
   float vhd_delay_mclk;
   float delay_mclk;
   float lovh_mclk;
   float fovh_line;
   float min_time_between_int_usec;
   
   // parametres calculés
   float readout_mclk;
   float readout_usec;
   float fpa_delay_usec;
   float vhd_delay_usec;
   float delay_usec;
   float frame_period_usec;
   float frame_rate_max_hz;
};
typedef struct xro3503_param_s xro3503_param_t;

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
uint8_t sw_init_done = 0;
ProximCfg_t ProximCfg;


// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV);
void FPA_SpecificParams(xro3503_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA);

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   extern int32_t gFpaDebugRegH;

   gFpaDebugRegH = 0;      //Make sure this debug is reset to power on FPA
   // sw_init_done = 0;                                                     // ENO: 11-sept 2019: ligne en commentaire pour que plusieurs appels de FPA_init ne créent des bugs de flashsettings.
   FPA_Reset(ptrA);
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides
   FPA_GetTemperature(ptrA);                                                // demande de lecture
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoyée au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
   TEC_Init();                                                              // initialize le firmware du TEC
   sw_init_done = 1;
}
 
//--------------------------------------------------------------------------
// pour reset des registres d'erreurs
//--------------------------------------------------------------------------
void FPA_ClearErr(const t_FpaIntf *ptrA)
{
   AXI4L_write32(1, ptrA->ADD + AW_RESET_ERR);
   AXI4L_write32(0, ptrA->ADD + AW_RESET_ERR);
}

//--------------------------------------------------------------------------
// pour reset du module
//--------------------------------------------------------------------------
// retenir qu'après reset, les IO sont en 'Z' après cela puisqu'on desactive le SoftwType dans le vhd. (voir vhd pour plus de details)
void FPA_Reset(const t_FpaIntf *ptrA)
{
   uint8_t ii;
   for(ii = 0; ii <= 10 ; ii++)
   { 
      AXI4L_write32(1, ptrA->ADD + AW_CTRLED_RESET);
   }
   for(ii = 0; ii <= 10 ; ii++)
   { 
      AXI4L_write32(0, ptrA->ADD + AW_CTRLED_RESET);
   }
}
 
//--------------------------------------------------------------------------
// pour power down (power management)
//--------------------------------------------------------------------------
void FPA_PowerDown(const t_FpaIntf *ptrA)
{
   FPA_Reset(ptrA);
}
 
//--------------------------------------------------------------------------                                                                            
//pour configurer le bloc vhd FPA_interface et le lancer
//--------------------------------------------------------------------------
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs)
{ 
   xro3503_param_t hh;
   //extern int16_t gFpaDetectorPolarizationVoltage;
   //static int16_t presentPolarizationVoltage = 150;
   //extern float gFpaDetectorElectricalTapsRef;
   //static float presentElectricalTapsRef = 10;       // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul
   //extern float gFpaDetectorElectricalRefOffset;
   //static float presentElectricalRefOffset = 0;        // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul
   extern int32_t gFpaDebugRegA;                       // reservé ELCORR pour correction électronique (gain et/ou offset)
   //extern int32_t gFpaDebugRegB;                       // reservé
   extern int32_t gFpaDebugRegC;                       // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk
   extern int32_t gFpaDebugRegD;                       // reservé adc_clk_source_phase pour ajustement fin phase adc_clk
   extern int32_t gFpaDebugRegE;                       // reservé fpa_intf_data_source pour sortir les données des ADCs même lorsque le détecteur/flegX est absent
   extern int32_t gFpaDebugRegF;                       // reservé real_mode_active_pixel_dly pour ajustement du début AOI
   //extern int32_t gFpaDebugRegG;                       // non utilisé
   extern int32_t gFpaDebugRegH;                       // non utilisé
   extern uint8_t gFpaDiodeBiasEnum;
   extern uint16_t gFpaDetectSub_mV;
   extern uint16_t gFpaCtiaRef_mV;
   extern uint16_t gFpaVTestG_mV;
   extern uint16_t gFpaCM_mV;
   extern uint16_t gFpaVCMO_mV;
   extern uint16_t gFpaTapRef_mV;
   extern uint8_t gFpaSubWindowMode;
   static uint8_t cfg_num = 0;
   static uint32_t presentSensorWellDepth = 0;

   // on bâtit les parametres specifiques
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);
   
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
   ptrA->fpa_pwr_on = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies

   // config du contrôleur de trigs
   ptrA->fpa_trig_ctrl_mode         = (uint32_t)MODE_TRIG_START_TO_TRIG_START;
   if (ptrA->fpa_diag_mode == 1)    // ENO : 03 jan 2021 : en mode diag, on impose un MODE_ITR_TRIG_START_TO_TRIG_START pour aller à la vitesse maximale imposée par le patron de tests. 
      ptrA->fpa_trig_ctrl_mode      = (uint32_t)MODE_ITR_TRIG_START_TO_TRIG_START;             
   
   ptrA->fpa_acq_trig_ctrl_dly      = (uint32_t)( (hh.frame_period_usec - hh.vhd_delay_usec)*1e-6F * (float)VHD_CLK_100M_RATE_HZ);  //frame period min calculée avec ET=0
   ptrA->fpa_spare                  = 0;
   ptrA->fpa_xtra_trig_ctrl_dly     = ptrA->fpa_acq_trig_ctrl_dly;
   ptrA->fpa_trig_ctrl_timeout_dly  = 0;     // non utilisé

   // Élargit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;

   // gFpaDebugRegE: mode diag vrai et fake
   ptrA->fpa_intf_data_source = DATA_SOURCE_INSIDE_FPGA;     // fpa_intf_data_source n'est utilisé/regardé par le vhd que lorsque fpa_diag_mode = 1
   if (ptrA->fpa_diag_mode == 1){
      if ((int32_t)gFpaDebugRegE != 0)
         ptrA->fpa_intf_data_source = DATA_SOURCE_OUTSIDE_FPGA;
   }
   
   // diag
   ptrA->diag_ysize              = pGCRegs->Height;
   ptrA->diag_xsize_div_tapnum   = pGCRegs->Width / FPA_NUMTAPS;

   // prog ctrl
   ptrA->xstart   = pGCRegs->OffsetX / FPA_NUMTAPS;
   ptrA->ystart   = pGCRegs->OffsetY / 4;
   ptrA->xstop    = (pGCRegs->OffsetX + pGCRegs->Width - 1) / FPA_NUMTAPS;
   ptrA->ystop    = (pGCRegs->OffsetY + pGCRegs->Height - 1) / 4;

   if (gFpaSubWindowMode > 1)
   {
      // valeur invalide, on utilise le défaut
      if ((pGCRegs->Width == FPA_WIDTH_MAX) && (pGCRegs->Height == FPA_HEIGHT_MAX))
         ptrA->sub_window_mode = 0;
      else
         ptrA->sub_window_mode = 1;
   }
   else
      ptrA->sub_window_mode = gFpaSubWindowMode;
   
   ptrA->read_dir_down = 0;
   ptrA->read_dir_left = 0;

   ptrA->gain = 0;   	//Low gain
   if (pGCRegs->SensorWellDepth == SWD_HighGain)
      ptrA->gain = 1;	//High gain

   if (gFpaDiodeBiasEnum > XRO3503_CTIA_BIAS_MAX)  // corrige une valeur invalide
      gFpaDiodeBiasEnum = XRO3503_CTIA_BIAS_MAX;   // valeur max est le défaut pour l'instant
   ptrA->ctia_bias_current = gFpaDiodeBiasEnum;
   
   // Registre F : ajustement des delais de la chaine
   if (sw_init_done == 0)
      gFpaDebugRegF = 13;
   ptrA->real_mode_active_pixel_dly = (uint32_t)gFpaDebugRegF;
   
   // readout ctrl
   ptrA->line_period_pclk                  = (pGCRegs->Width / FPA_NUMTAPS + (uint32_t)hh.lovh_mclk);
   ptrA->window_lsync_num                  = pGCRegs->Height + (uint32_t)hh.fovh_line;
   ptrA->readout_pclk_cnt_max              = ptrA->line_period_pclk * ptrA->window_lsync_num + 1;
   
   ptrA->active_line_start_num             = 1;
   ptrA->active_line_end_num               = ptrA->active_line_start_num + pGCRegs->Height - 1;
   
   ptrA->sof_posf_pclk                     = 1;
   ptrA->eof_posf_pclk                     = ptrA->active_line_end_num * ptrA->line_period_pclk - (uint32_t)hh.lovh_mclk;
   ptrA->sol_posl_pclk                     = 1;
   ptrA->eol_posl_pclk                     = ptrA->sol_posl_pclk + pGCRegs->Width / FPA_NUMTAPS - 1;
   ptrA->eol_posl_pclk_p1                  = ptrA->eol_posl_pclk + 1;

   // sample proc
   ptrA->pix_samp_num_per_ch               = 1;
   ptrA->good_samp_first_pos_per_ch        = ptrA->pix_samp_num_per_ch;   // position premier echantillon
   ptrA->good_samp_last_pos_per_ch         = ptrA->pix_samp_num_per_ch;   // position dernier echantillon
   ptrA->hgood_samp_sum_num                = ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->hgood_samp_mean_numerator         = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->hgood_samp_sum_num);                            
   ptrA->vgood_samp_sum_num                = 1;
   ptrA->vgood_samp_mean_numerator         = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->vgood_samp_sum_num);    // moyenne
   
   // gFpaDebugRegC dephasage grossier des adc_clk 
   if (sw_init_done == 0)
      gFpaDebugRegC = 0;
   ptrA->adc_clk_pipe_sel = (uint32_t)gFpaDebugRegC;                                              
 
   // gFpaDebugRegD dephasage fin des adc_clk 
   if (sw_init_done == 0)
      gFpaDebugRegD = 80;
   ptrA->adc_clk_source_phase = (uint32_t)gFpaDebugRegD;

   // image info
   ptrA->offsetx  = pGCRegs->OffsetX;
   ptrA->offsety  = pGCRegs->OffsetY;
   ptrA->width    = pGCRegs->Width;
   ptrA->height   = pGCRegs->Height;
   
   // digio
   ptrA->roic_cst_output_mode = 0;
   ptrA->fpa_pwr_override_mode = 0;
   if (gFpaDebugRegA != 0)
      ptrA->roic_cst_output_mode = 1;
   if (gFpaDebugRegH != 0)
      ptrA->fpa_pwr_override_mode = 1;

   // diag lovh
   ptrA->diag_lovh_mclk_source = (uint32_t)(hh.lovh_mclk * FPA_MCLK_SOURCE_RATE_HZ / FPA_MCLK_RATE_HZ);

   // changement de cfg_num des qu'une nouvelle cfg est envoyée au vhd. Il s'en sert pour detecter le mode hors acquisition et ainsi en profite pour calculer le gain electronique
   if (cfg_num == 255)  // protection contre depassement
      cfg_num = 0;   
   cfg_num++;
   ptrA->cfg_num  = (uint32_t)cfg_num;


   // les DACs (1 à 8)
   if (sw_init_done == 0)
   {
      // valeurs par défaut pour l'init
      gFpaDetectSub_mV = 3500;
      gFpaCtiaRef_mV = 2380;
      gFpaVTestG_mV = 3300;
      gFpaCM_mV = 1780;
      gFpaVCMO_mV = 1780;
      gFpaTapRef_mV = 0;
   }
   // Pour un changement de gain, on force certaines valeurs
   if (presentSensorWellDepth != pGCRegs->SensorWellDepth)
   {
      presentSensorWellDepth = pGCRegs->SensorWellDepth;
      if (pGCRegs->SensorWellDepth == SWD_HighGain)
      {
         gFpaCtiaRef_mV = 2500;
         gFpaCM_mV = 1910;
      }
      else
      {
         gFpaCtiaRef_mV = 2380;
         gFpaCM_mV = 1780;
      }
   }
   ProximCfg.vdac_value[0] = FLEG_VccVoltage_To_DacWord((float)gFpaDetectSub_mV); // DAC1 -> DETECTSUB 2.9V à 3.5V
   ProximCfg.vdac_value[1] = FLEG_VccVoltage_To_DacWord((float)gFpaCtiaRef_mV); // DAC2 -> CTIA_REF 2.1V à 2.8V
   ProximCfg.vdac_value[2] = FLEG_VccVoltage_To_DacWord((float)gFpaVTestG_mV); // DAC3 -> VTESTG (current skimming and antibloom disabled)
   ProximCfg.vdac_value[3] = FLEG_VccVoltage_To_DacWord((float)gFpaCM_mV); // DAC4 -> CM 1.5V à 2V
   ProximCfg.vdac_value[4] = FLEG_VccVoltage_To_DacWord((float)gFpaVCMO_mV); // DAC5 -> VCMO 1.5V à 2V
   ProximCfg.vdac_value[5] = FLEG_VccVoltage_To_DacWord((float)gFpaTapRef_mV); // DAC6 -> TAP_REF connecté au GND, le LDO (501mV) est non connecté
   ProximCfg.vdac_value[6] = 0;                                   // DAC7 -> non connecté
   ProximCfg.vdac_value[7] = 0;                                   // DAC8 -> non connecté

   gFpaDetectSub_mV  = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[0]);
   gFpaCtiaRef_mV    = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[1]);
   gFpaVTestG_mV     = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[2]);
   gFpaCM_mV         = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[3]);
   gFpaVCMO_mV       = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[4]);
   gFpaTapRef_mV     = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[5]);

/*
   // Reference of the taps (DAC6)
   if (gFpaDetectorElectricalTapsRef != presentElectricalTapsRef)
   {
      if ((gFpaDetectorElectricalTapsRef >= XRO3503_TAPREF_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalTapsRef <= XRO3503_TAPREF_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[5] = FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalTapsRef);
   }
   presentElectricalTapsRef = FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[5]);
   gFpaDetectorElectricalTapsRef = presentElectricalTapsRef;

   // Polarization voltage (VPOL = DETECTSUB - CTIA_REF)
   if (gFpaDetectorPolarizationVoltage != presentPolarizationVoltage)
   {
      if ((gFpaDetectorPolarizationVoltage >= XRO3503_POL_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= XRO3503_POL_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[1] = FLEG_VccVoltage_To_DacWord(FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[0]) - (float)gFpaDetectorPolarizationVoltage);
   }
   presentPolarizationVoltage = (int16_t)(FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[0]) - FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[1]));
   gFpaDetectorPolarizationVoltage = presentPolarizationVoltage;
*/
   
   // envoi de la configuration de l'électronique de proximité (les DACs en l'occurrence) par un autre canal 
   FPA_SendProximCfg(&ProximCfg, ptrA);
   
   // envoi du reste de la config        
   WriteStruct(ptrA);
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

   if (raw_temp == 0 || raw_temp == 0xFFFF)  // la diode est court-circuitée ou ouverte
   {
      return FPA_INVALID_TEMP;
   }
   else
   {
      diode_voltage = (float)raw_temp*((float)FPA_TEMP_READER_FULL_SCALE_mV/1000.0F)/(powf(2.0F, FPA_TEMP_READER_ADC_DATA_RES)*(float)FPA_TEMP_READER_GAIN);

      // utilisation  des valeurs de flashsettings
      temperature  = flashSettings.FPATemperatureConversionCoef4 * powf(diode_voltage,4);
      temperature += flashSettings.FPATemperatureConversionCoef3 * powf(diode_voltage,3);
      temperature += flashSettings.FPATemperatureConversionCoef2 * powf(diode_voltage,2);
      temperature += flashSettings.FPATemperatureConversionCoef1 * diode_voltage;
      temperature += flashSettings.FPATemperatureConversionCoef0;

      // Si flashsettings non programmés alors on utilise les valeurs par defaut
      if ((flashSettings.FPATemperatureConversionCoef4 == 0) && (flashSettings.FPATemperatureConversionCoef3 == 0) &&
          (flashSettings.FPATemperatureConversionCoef2 == 0) && (flashSettings.FPATemperatureConversionCoef1 == 0) &&
          (flashSettings.FPATemperatureConversionCoef0 == 0))
      {
         // La doc de Xenics donne Temp = 418°C – (voltage / 2mV/°C) pour un courant de 150uA
         temperature = 418.0F - diode_voltage/0.002F; // celsius
         temperature = C_TO_K(temperature); // kelvin
      }

      return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius
   }
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au xro3503 avec une config
//--------------------------------------------------------------------------
void FPA_SpecificParams(xro3503_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   extern uint16_t gFpaLovh_mclk;
   extern bool gFpaLovhFlag;

   // parametres statiques
   ptrH->mclk_period_usec           = 1e6F/(float)FPA_MCLK_RATE_HZ;
   ptrH->fpa_delay_mclk             = 32.0F + 12.0F;   // FPA: estimation delai max de sortie des pixels après integration
   // Ajout delai supplementaire pour la generation du header (bug en 640x8).
   // Delai mesure experimentalement a 2.5us en 640x8, c'est-a-dire environ le temps du header divise par 9.
   // TODO: enlever ce delai lorsque le header inserter sera sur 4 pix de large.
   ptrH->fpa_delay_mclk            += (float)pGCRegs->Width / 9.0F;
   ptrH->vhd_delay_mclk             = 3.5F;   // estimation des differents delais accumulés par le vhd
   ptrH->delay_mclk                 = ptrH->fpa_delay_mclk + ptrH->vhd_delay_mclk;
   if (FPA_MCLK_RATE_HZ <= 27E+6F)
   {
      if ((pGCRegs->Width == FPA_WIDTH_MAX) && (pGCRegs->Height == FPA_HEIGHT_MAX))
         ptrH->lovh_mclk            = 12.0F;
      else
         ptrH->lovh_mclk            = 15.0F;
   }
   else
      ptrH->lovh_mclk               = 36.0F;
   if (gFpaLovhFlag) // Overwrite with value from debug terminal
      ptrH->lovh_mclk               = (float)gFpaLovh_mclk;
   gFpaLovh_mclk                    = (uint16_t)ptrH->lovh_mclk;
   ptrH->fovh_line                  = 1.0F;
   ptrH->min_time_between_int_usec  = MAX(1.0F, 10.0F * ptrH->mclk_period_usec);
      
   // readout time
   ptrH->readout_mclk   = ((float)(pGCRegs->Width / FPA_NUMTAPS) + ptrH->lovh_mclk) * ((float)pGCRegs->Height + ptrH->fovh_line);
   ptrH->readout_usec   = ptrH->readout_mclk * ptrH->mclk_period_usec;
   
   // delay
   ptrH->vhd_delay_usec    = ptrH->vhd_delay_mclk * ptrH->mclk_period_usec;
   ptrH->fpa_delay_usec    = ptrH->fpa_delay_mclk * ptrH->mclk_period_usec;
   ptrH->delay_usec        = ptrH->delay_mclk * ptrH->mclk_period_usec;
      
   // calcul de la periode minimale
   if (pGCRegs->IntegrationMode == IM_IntegrateThenRead)
      ptrH->frame_period_usec = exposureTime_usec + MAX(ptrH->min_time_between_int_usec, ptrH->delay_usec + ptrH->readout_usec);
   else
      ptrH->frame_period_usec = MAX(exposureTime_usec + ptrH->min_time_between_int_usec, ptrH->delay_usec + ptrH->readout_usec);

   // calcul du frame rate maximal
   ptrH->frame_rate_max_hz = 1.0F/(ptrH->frame_period_usec*1e-6F);
}
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate; 
   xro3503_param_t hh;
   
   FPA_SpecificParams(&hh, (float)pGCRegs->ExposureTime, pGCRegs);
   
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
   xro3503_param_t hh;
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
      max_exposure_usec = (presentPeriod_sec*1e6F - hh.min_time_between_int_usec);

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

   Stat->adc_oper_freq_max_khz               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x00);
   Stat->adc_analog_channel_num              = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x04);
   Stat->adc_resolution                      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x08);
   Stat->adc_brd_spare                       = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x0C);
   Stat->ddc_fpa_roic                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x10);
   Stat->ddc_brd_spare                       = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x14);
   Stat->flex_fpa_roic                       = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x18);
   Stat->flex_fpa_input                      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x1C);
   Stat->flex_ch_diversity_num               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x20);
   Stat->cooler_volt_min_mV                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x24);
   Stat->cooler_volt_max_mV                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x28);
   Stat->fpa_temp_raw                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x2C);
   Stat->global_done                         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x30);
   Stat->fpa_powered                         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x34);
   Stat->cooler_powered                      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x38);
   Stat->errors_latchs                       = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x3C);
   Stat->intf_seq_stat                       = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x40);
   Stat->data_path_stat                      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x44);
   Stat->trig_ctler_stat                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x48);
   Stat->fpa_driver_stat                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x4C);
   Stat->adc_ddc_detect_process_done         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x50);
   Stat->adc_ddc_present                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x54);
   Stat->flex_flegx_detect_process_done      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x58);
   Stat->flex_flegx_present                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x5C);
   Stat->id_cmd_in_error                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x60);
   Stat->fpa_serdes_done                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x64);
   Stat->fpa_serdes_success                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x68);
   temp_32b                                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x6C);
   memcpy(Stat->fpa_serdes_delay, (uint8_t *)&temp_32b, sizeof(Stat->fpa_serdes_delay));
   Stat->fpa_serdes_edges[0]                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x70);
   Stat->fpa_serdes_edges[1]                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x74);
   Stat->fpa_serdes_edges[2]                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x78);
   Stat->fpa_serdes_edges[3]                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x7C);
   Stat->fpa_init_done                       = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x80);
   Stat->fpa_init_success                    = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x84);
   Stat->flegx_present                       =(Stat->flex_flegx_present & Stat->adc_brd_spare);
   
   Stat->prog_init_done                      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x88);
   Stat->cooler_on_curr_min_mA               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x8C);
   Stat->cooler_off_curr_max_mA              = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x90);
   
   Stat->acq_trig_cnt                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x94);
   Stat->acq_int_cnt                         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x98);
   Stat->fpa_readout_cnt                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x9C);
   Stat->acq_readout_cnt                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA0);
   Stat->out_pix_cnt_min                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA4);
   Stat->out_pix_cnt_max                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA8);
   Stat->trig_to_int_delay_min               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xAC);
   Stat->trig_to_int_delay_max               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB0);
   Stat->int_to_int_delay_min                = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB4);
   Stat->int_to_int_delay_max                = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB8);
   Stat->fast_hder_cnt                       = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xBC);
}


//////////////////////////////////////////////////////////////////////////////                                                                          
//  I N T E R N A L    F U N C T I O N S 
////////////////////////////////////////////////////////////////////////////// 

//--------------------------------------------------------------------------
// Informations sur les drivers C utilisés. 
//--------------------------------------------------------------------------
void FPA_SoftwType(const t_FpaIntf *ptrA)
{
   AXI4L_write32(FPA_ROIC, ptrA->ADD + AW_FPA_ROIC_SW_TYPE);          
   AXI4L_write32(FPA_OUTPUT_TYPE, ptrA->ADD + AW_FPA_OUTPUT_SW_TYPE);
   AXI4L_write32(FPA_INPUT_TYPE, ptrA->ADD + AW_FPA_INPUT_SW_TYPE);
}

//--------------------------------------------------------------------------
// Conversion de VccVoltage_mV en DAC Word
//--------------------------------------------------------------------------
// VccVoltage_mV : en milliVolt, tension de sortie des LDO du FLeG
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV)
{
   float Rs, Rd, RL, Is, DacVoltage_Volt, DacWordTemp;
   uint32_t DacWord;

   // Sur le EFA-00305-001, les canaux 1 à 6 du DAC sont identiques (7 et 8 ne sont pas connectés)
   Rs = 4.99e3F;    // R154
   Rd = 24.9F;      // R156
   RL = 806.0F;     // R155
   Is = 100e-6F;    // courant du LT3042 (U31)

   // calculs de la tension du dac en volt
   DacVoltage_Volt =  ((1.0F + RL/Rd)*VccVoltage_mV/1000.0F - (Rs + RL + RL/Rd*Rs)*Is)/(RL/Rd);

   // deduction du bitstream du DAC
   DacWordTemp = powf(2.0F, (float)FLEG_DAC_RESOLUTION_BITS) * DacVoltage_Volt/((float)FLEG_DAC_REF_VOLTAGE_V*(float)FLEG_DAC_REF_GAIN);
   DacWord = (uint32_t) MAX(MIN(roundf(DacWordTemp), 16383.0F), 0.0F);

   return DacWord;
}

//--------------------------------------------------------------------------
// Conversion de DAC Word  en VccVoltage_mV
//--------------------------------------------------------------------------
// VccVoltage_mV : en milliVolt, tension de sortie des LDO du FLeG
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord)
{
   float Rs, Rd, RL, Is, DacVoltage_Volt, VccVoltage_mV;
   uint32_t DacWordTemp;

   // Sur le EFA-00305-001, les canaux 1 à 6 du DAC sont identiques (7 et 8 ne sont pas connectés)
   Rs = 4.99e3F;    // R154
   Rd = 24.9F;      // R156
   RL = 806.0F;     // R155
   Is = 100e-6F;    // courant du LT3042 (U31)

   // deduction de la tension du DAC
   DacWordTemp =  (uint32_t) MAX(MIN(DacWord, 16383), 0);
   DacVoltage_Volt = (float)DacWordTemp * ((float)FLEG_DAC_REF_VOLTAGE_V*(float)FLEG_DAC_REF_GAIN)/powf(2.0F, (float)FLEG_DAC_RESOLUTION_BITS);

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
