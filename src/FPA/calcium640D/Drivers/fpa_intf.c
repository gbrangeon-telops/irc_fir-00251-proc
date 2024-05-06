/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision$
-- $Author$
-- $LastChangedDate$
--
-------------------------------------------------------------------------------
--
-- Description : 
--
------------------------------------------------------------------------------*/

#include "fpa_intf.h"
#include "flashSettings.h"
#include "Calibration.h"
#include "utils.h"
#include "exposure_time_ctrl.h"
#include <stdbool.h>
#include <math.h>
#include <string.h>                  
#include "mb_axi4l_bridge.h"
 

// Mode d'operation choisi pour le contrôleur de trig (voir fichier fpa_common_pkg.vhd)
#define MODE_READOUT_END_TO_TRIG_START             0x00     // delai pris en compte = fin du readout jusqu'au prochain trig d'integration 
#define MODE_TRIG_START_TO_TRIG_START              0x01     // delai pris en compte = periode entre le trig actuel et le prochain
#define MODE_INT_END_TO_TRIG_START                 0x02     // delai pris en compte = fin de l'integration jusqu'au prochain trig d'integration 
#define MODE_ITR_TRIG_START_TO_TRIG_START          0x03     // delai pris en compte = periode entre le trig actuel et le prochain. Une fois ce delai observé, on s'assure que le readout est terminé avant de considerer le prochain trig.
#define MODE_ITR_INT_END_TO_TRIG_START             0x04     // delai pris en compte = fin de l'integration jusqu'au prochain trig d'integration. Une fois ce delai observé, on s'assure que le readout est terminé avant de considerer le prochain trig.
#define MODE_ALL_END_TO_TRIG_START                 0x05     // delai pris en compte = fin de l'integration / readout (selon le plus long des deux) jusqu'au prochain trig d'integration. 

// identification des sources de données (voir fichier fpa_common_pkg.vhd)
#define DATA_SOURCE_INSIDE_FPGA                    0        // source de données est interne au FPGA (mode patron de tests Telops)
#define DATA_SOURCE_OUTSIDE_FPGA                   1        // source de données est externe au FPGA (ADc par exemple))

// informations sur le pilote C. Le vhd s'en sert pour compatibility check (voir fichier fpa_common_pkg.vhd)
#define FPA_ROIC                                   0x22     // 0x22 -> calcium. Provient du fichier fpa_common_pkg.vhd.
#define FPA_ROIC_UNKNOWN                           0xFF     // 0xFF -> ROIC inconnu. Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                            0x02     // 0x02 -> output numérique. Provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL
#define FPA_INPUT_TYPE                             0x07     // 0x04 -> input LVCMOS18. Provient du fichier fpa_common_pkg.vhd

// adresse de lecture des statuts VHD
#define AR_STATUS_BASE_ADD                         0x0400   // adresse de base
#define AR_FPA_TEMPERATURE                         0x002C   // adresse temperature
// adresse FPA_INTF_CFG feedback du module de statuts
#define AR_FPA_INTF_CFG_BASE_ADD                   (AR_STATUS_BASE_ADD + 0x0200)

// adresse d'écriture du registre du type du pilote C
#define AW_FPA_ROIC_SW_TYPE                        0xAE0    // adresse à laquelle on dit au VHD quel type de roic de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE                      0xAE4    // adresse à laquelle on dit au VHD quel type de sortie de fpa le pilote en C est conçu pour.
#define AW_FPA_INPUT_SW_TYPE                       0xAE8    // obligatoire pour les detecteurs analogiques

// adresse d'ecriture de la cfg des Dacs
#define AW_DAC_CFG_BASE_ADD                        0x0D00

// adresse d'écriture du registre du reset des erreurs
#define AW_RESET_ERR                               0xAEC

 // adresse d'écriture du registre du reset du module FPA
#define AW_CTRLED_RESET                            0xAF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de Mglk)
#define TELOPS_DIAG_CNST                           0xD1     // mode diag constant (patron de test generé par la carte d'acquisition : tous les pixels à la même valeur)
#define TELOPS_DIAG_DEGR                           0xD2     // mode diag dégradé linéaire(patron de test dégradé linéairement et généré par la carte d'acquisition).Requis en production
#define TELOPS_DIAG_DEGR_DYN                       0xD3     // mode diag dégradé linéaire dynamique(patron de test dégradé linéairement et variant d'image en image et généré par la carte d'acquisition)

// conversion temps d'intégration
#define EXP_TIME_CONV_DENOMINATOR_BIT_POS          26       // ne pas changer cette valeur sans changer le proxy_define

// lecture de température FPA
#define FPA_TEMP_READER_ADC_DATA_RES               16       // la donnée de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV              2048     // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN                       1        // gain du canal de lecture de temperature sur la carte ADC

// fleg
#define FLEG_DAC_RESOLUTION_BITS                   14       // le DAC est à 14 bits
#define FLEG_DAC_REF_VOLTAGE_V                     2.5      // on utilise la reference interne de 2.5V du DAC
#define FLEG_DAC_REF_GAIN                          2.0      // gain de référence du DAC


#define CALCIUM_VA1P8_DEFAULT_mV                   1800
#define CALCIUM_VA1P8_MIN_mV                       1500
#define CALCIUM_VA1P8_MAX_mV                       2100

#define CALCIUM_VPIXRST_DEFAULT_mV                 1500
#define CALCIUM_VPIXRST_MIN_mV                     0
#define CALCIUM_VPIXRST_MAX_mV                     3600

#define CALCIUM_VDHS1P8_DEFAULT_mV                 1800
#define CALCIUM_VDHS1P8_MIN_mV                     1650
#define CALCIUM_VDHS1P8_MAX_mV                     2100

#define CALCIUM_VD1P8_DEFAULT_mV                   1800
#define CALCIUM_VD1P8_MIN_mV                       1650
#define CALCIUM_VD1P8_MAX_mV                       2100

#define CALCIUM_VA3P3_DEFAULT_mV                   3450
#define CALCIUM_VA3P3_MIN_mV                       3000
#define CALCIUM_VA3P3_MAX_mV                       3600

#define CALCIUM_VDETGUARD_DEFAULT_mV               3300  //TODO déterminer la valeur par défaut
#define CALCIUM_VDETGUARD_MIN_mV                   3000
#define CALCIUM_VDETGUARD_MAX_mV                   3600

#define CALCIUM_VDETCOM_DEFAULT_mV                 3450
#define CALCIUM_VDETCOM_MIN_mV                     3000
#define CALCIUM_VDETCOM_MAX_mV                     3600

#define CALCIUM_VPIXQNB_DEFAULT_mV                 1750  //TODO déterminer la valeur par défaut
#define CALCIUM_VPIXQNB_MIN_mV                     1000
#define CALCIUM_VPIXQNB_MAX_mV                     2100

#define CALCIUM_DEFAULT_REGF                       2     // AOI commence à la ligne 2
#define CALCIUM_DEFAULT_REGH                       1     // le LDO de VPIXQNB est activé

#define CALCIUM_DEBUG_KPIX_MAX                     32768 // valeur min est 0

#define TOTAL_DAC_NUM                              8

struct s_ProximCfgConfig
{
   uint32_t  vdac_value[(uint8_t)TOTAL_DAC_NUM];
   uint32_t  spare1;
   uint32_t  spare2;
};
typedef struct s_ProximCfgConfig ProximCfg_t;

// structure interne pour les parametres du calcium
struct calcium_param_s
{
   uint32_t diag_x_to_readout_start_dly;
   uint32_t diag_fval_re_to_dval_re_dly;
   uint32_t diag_lval_pause_dly;
   uint32_t diag_x_to_next_fsync_re_dly;
   uint32_t diag_xsize_div_per_pixel_num;
   float integrationDelay;
   float itrReadoutDelay;
   float iwrReadoutDelay;
   float readoutRowTime;
   uint16_t numFrRows;
   float readoutTime;
   float frameTime;
   float frameRateMax;
   float itr_int_end_to_trig_start_dly;
   float int_end_to_trig_start_dly;
};
typedef struct calcium_param_s calcium_param_t;
 
// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;

// Private variables
static uint32_t sw_init_done = 0;
static uint32_t sw_init_success = 0;
static ProximCfg_t ProximCfg;
t_FpaResolutionCfg gFpaResolutionCfg[FPA_MAX_NUMBER_CONFIG_MODE] = {FPA_STANDARD_RESOLUTION};


// Prototypes fonctions internes
void FPA_Reset(const t_FpaIntf *ptrA);
void FPA_SpecificParams(calcium_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
void FPA_SoftwType(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA);


//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{
   // sw_init_done = 0;                                                     // ENO: 11-sept 2019: ligne en commentaire pour que plusieurs appels de FPA_init ne créent des bugs de flashsettings.
   sw_init_success = 0;
   
   FPA_Reset(ptrA);
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoyée au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_GetTemperature(ptrA);                                                // demande de lecture
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
   
   sw_init_done = 1;
   sw_init_success = 1;
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
   calcium_param_t hh;
   extern int32_t gFpaExposureTimeOffset;
   //extern int32_t gFpaDebugRegA;                       // reservé ELCORR pour correction électronique (gain et/ou offset)
   //extern int32_t gFpaDebugRegB;                       // reservé
   //extern int32_t gFpaDebugRegC;                       // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk
   //extern int32_t gFpaDebugRegD;                       // reservé adc_clk_source_phase pour ajustement fin phase adc_clk
   //extern int32_t gFpaDebugRegE;                       // reservé fpa_intf_data_source pour sortir les données des ADCs même lorsque le détecteur/flegX est absent
   extern int32_t gFpaDebugRegF;                       // reservé active_line_start_num pour ajustement du début AOI
   extern int32_t gFpaDebugRegG;                       // reservé pour le contrôle interne/externe du temps d'intégration
   extern int32_t gFpaDebugRegH;                       // reservé pour l'activation du LDO de VPIXQNB
   extern uint16_t gFpaVa1p8_mV;
   static uint16_t presentFpaVa1p8_mV = CALCIUM_VA1P8_DEFAULT_mV;
   extern uint16_t gFpaVPixRst_mV;
   static uint16_t presentFpaVPixRst_mV = CALCIUM_VPIXRST_DEFAULT_mV;
   extern uint16_t gFpaVdhs1p8_mV;
   static uint16_t presentFpaVdhs1p8_mV = CALCIUM_VDHS1P8_DEFAULT_mV;
   extern uint16_t gFpaVd1p8_mV;
   static uint16_t presentFpaVd1p8_mV = CALCIUM_VD1P8_DEFAULT_mV;
   extern uint16_t gFpaVa3p3_mV;
   static uint16_t presentFpaVa3p3_mV = CALCIUM_VA3P3_DEFAULT_mV;
   extern uint16_t gFpaVDetGuard_mV;
   static uint16_t presentFpaVDetGuard_mV = CALCIUM_VDETGUARD_DEFAULT_mV;
   extern uint16_t gFpaVDetCom_mV;
   static uint16_t presentFpaVDetCom_mV = CALCIUM_VDETCOM_DEFAULT_mV;
   extern uint16_t gFpaVPixQNB_mV;
   static uint16_t presentFpaVPixQNB_mV = CALCIUM_VPIXQNB_DEFAULT_mV;
   extern uint16_t gFpaDebugKPix;
   extern bool gFpaDebugKPixForced;
   extern float gFpaDebugComprRatio;
   extern bool gFpaDebugComprRatioForced;
   static uint8_t cfg_num;

   // on bâtit les parametres specifiques
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);

   // diag mode, diag type et data source
   ptrA->fpa_diag_mode = 0;                 // par defaut
   ptrA->fpa_diag_type = 0;                 // par defaut
   ptrA->fpa_intf_data_source = DATA_SOURCE_INSIDE_FPGA;     // fpa_intf_data_source n'est utilisé/regardé par le vhd que lorsque fpa_diag_mode = 1
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
   else if (pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage) {
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_intf_data_source = DATA_SOURCE_OUTSIDE_FPGA;
   }

   // allumage du détecteur
   ptrA->fpa_pwr_on = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   
   // config du contrôleur de trigs
   // On utilise toujours MODE_INT_END_TO_TRIG_START pour s'affranchir du ET variable.
   // En ACQ trig le délai est calculé en fonction du mode Diag et du mode ITR/IWR.
   // En XTRA et PROG trig le délai est calculé en fonction du mode Diag mais on force le mode ITR pour garantir un délai sécuritaire pendant les PROG trig.
   // Le timeout commence avec le trig donc il doit être d'une durée d'un frame complet avant de permettre le prochain trig.
   ptrA->fpa_acq_trig_mode          = (uint32_t)MODE_INT_END_TO_TRIG_START;
   ptrA->fpa_acq_trig_ctrl_dly      = (uint32_t)(hh.int_end_to_trig_start_dly * VHD_CLK_100M_RATE_HZ);
   ptrA->fpa_xtra_trig_mode         = (uint32_t)MODE_INT_END_TO_TRIG_START;
   ptrA->fpa_xtra_trig_ctrl_dly     = (uint32_t)(hh.itr_int_end_to_trig_start_dly * VHD_CLK_100M_RATE_HZ);
   ptrA->fpa_trig_ctrl_timeout_dly  = (uint32_t)(hh.frameTime * VHD_CLK_100M_RATE_HZ);
   
   // Élargit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
   // intégration des prog
   ptrA->fpa_xtra_trig_int_time = (uint32_t)(FPA_MIN_EXPOSURE/1e6F * VHD_CLK_100M_RATE_HZ);
   ptrA->fpa_prog_trig_int_time = (uint32_t)(FPA_MIN_EXPOSURE/1e6F * VHD_CLK_100M_RATE_HZ);
   
   // conversion du temps d'intégration
   ptrA->intclk_to_clk100_conv_numerator = (uint32_t)roundf(VHD_CLK_100M_RATE_HZ * exp2f((float)EXP_TIME_CONV_DENOMINATOR_BIT_POS) / CALCIUM_CLK_CORE_HZ);
   ptrA->clk100_to_intclk_conv_numerator = (uint32_t)roundf(CALCIUM_CLK_CORE_HZ * exp2f((float)EXP_TIME_CONV_DENOMINATOR_BIT_POS) / VHD_CLK_100M_RATE_HZ);
   
   // AOI
   ptrA->offsetx  = pGCRegs->OffsetX;
   ptrA->offsety  = pGCRegs->OffsetY;
   ptrA->width    = pGCRegs->Width;
   ptrA->height   = pGCRegs->Height;
   
   // Registre F : ajustement des lignes conservées
   if (sw_init_done == 0)
      gFpaDebugRegF = CALCIUM_DEFAULT_REGF;
   if (gFpaDebugRegF < 1)
      gFpaDebugRegF = 1;
   else if (gFpaDebugRegF > 3 + 2*CALCIUM_bTestRowsEn)
      gFpaDebugRegF = 3 + 2*CALCIUM_bTestRowsEn;
   ptrA->active_line_start_num = (uint32_t)gFpaDebugRegF;
   ptrA->active_line_end_num = ptrA->active_line_start_num + ptrA->height - 1;
   ptrA->active_line_width_div4 = ptrA->width/4;    // 4 pix de large
   
   // diag
   ptrA->diag_x_to_readout_start_dly = hh.diag_x_to_readout_start_dly;
   ptrA->diag_fval_re_to_dval_re_dly = hh.diag_fval_re_to_dval_re_dly;
   ptrA->diag_lval_pause_dly = hh.diag_lval_pause_dly;
   ptrA->diag_x_to_next_fsync_re_dly = hh.diag_x_to_next_fsync_re_dly;
   ptrA->diag_xsize_div_per_pixel_num = hh.diag_xsize_div_per_pixel_num;
   
   // offset du signal d'intégration
   ptrA->fpa_int_time_offset = gFpaExposureTimeOffset;   // aucune conversion puisqu'il est appliqué directement sur la commande venant du module Exp_Ctrl
   
   // feedback d'intégration
   ptrA->int_fdbk_dly = (uint32_t)(hh.integrationDelay * VHD_CLK_100M_RATE_HZ) + 3;    // on ajoute 3 clk pour le délai entre FPA_INT et CLK_FRM
   
   // KPix
   if (sw_init_done == 0 || gFpaDebugKPix > CALCIUM_DEBUG_KPIX_MAX)
   {
      gFpaDebugKPix = CALCIUM_DEBUG_KPIX_MAX;   // valeur max est la valeur par défaut
      gFpaDebugKPixForced = false;
   }
   if (ptrA->fpa_diag_mode ||
         gFpaDebugKPixForced ||
         !calibrationInfo.isValid ||
         !calibrationInfo.blocks[0].KPixDataPresence)
   {
      // On force le KPix par défaut ou transmis par l'usager
      ptrA->kpix_pgen_en = 1;
      ptrA->kpix_median_value = gFpaDebugKPix;
   }
   else
   {
      // On utilise la médiane disponible dans le bloc (les KPix sont les mêmes pour tous les blocs)
      ptrA->kpix_pgen_en = 0;
      ptrA->kpix_median_value = calibrationInfo.blocks[0].KPixData.KPix_Median;
   }
   gFpaDebugKPix = (uint16_t)ptrA->kpix_median_value;
   
   // activation du LDO de VPIXQNB (s'il est désactivé c'est la valeur du registre b3PixQNB qui est utilisée par le ROIC)
   if (sw_init_done == 0)
      gFpaDebugRegH = CALCIUM_DEFAULT_REGH;
   if (gFpaDebugRegH < 0)
      gFpaDebugRegH = 0;
   else if (gFpaDebugRegH > 1)
      gFpaDebugRegH = 1;
   ptrA->use_ext_pixqnb = (uint32_t)gFpaDebugRegH;
   
   // largeur du pulse de CLK_FRM en clk_100M pour un contrôle interne du temps d'intégration (registre bIntCnt)
   if (gFpaDebugRegG == 0)
      ptrA->clk_frm_pulse_width = (uint32_t)(0.5e-6F * VHD_CLK_100M_RATE_HZ); // pulse < ETMin
   else
      // 0 -> CLK_FRM est la réplique de FPA_INT pour un contrôle externe du temps d'intégration
      ptrA->clk_frm_pulse_width = 0;

   // serdes
   ptrA->fpa_serdes_lval_num = hh.numFrRows;
   ptrA->fpa_serdes_lval_len = ptrA->width/8;    // 8 pix de large
   
   // compression logarithmique
   if (sw_init_done == 0 || gFpaDebugComprRatio == 0.0F)
   {
      gFpaDebugComprRatio = 1.0F;   // valeur max est la valeur par défaut
      gFpaDebugComprRatioForced = false;
   }
   if (ptrA->fpa_diag_mode ||
         gFpaDebugComprRatioForced ||
         !calibrationInfo.isValid ||
         calibrationInfo.blocks[0].CompressionAlgorithm == 0)
   {
      // On force le compression ratio par défaut ou transmis par l'usager
      ptrA->compr_ratio_fp32 = gFpaDebugComprRatio;
   }
   else
   {
      // On utilise le compression ratio disponible dans le bloc (la compression est la même pour tous les blocs)
      ptrA->compr_ratio_fp32 = calibrationInfo.blocks[0].CompressionParameter;
   }
   gFpaDebugComprRatio = ptrA->compr_ratio_fp32;
   
   // changement de cfg_num des qu'une nouvelle cfg est envoyée au vhd. Il s'en sert pour detecter le mode hors acquisition et ainsi en profite pour calculer le gain electronique
   ptrA->cfg_num = ++cfg_num;
   
   // les DACs (1 à 8)
   ProximCfg.vdac_value[0] = FLEG_VccVoltage_To_DacWord((float)presentFpaVa1p8_mV, 1);       // DAC1 -> VA1P8
   ProximCfg.vdac_value[1] = FLEG_VccVoltage_To_DacWord((float)presentFpaVPixRst_mV, 2);     // DAC2 -> VPIXRST
   ProximCfg.vdac_value[2] = FLEG_VccVoltage_To_DacWord((float)presentFpaVdhs1p8_mV, 3);     // DAC3 -> VDHS1P8
   ProximCfg.vdac_value[3] = FLEG_VccVoltage_To_DacWord((float)presentFpaVd1p8_mV, 4);       // DAC4 -> VD1P8
   ProximCfg.vdac_value[4] = FLEG_VccVoltage_To_DacWord((float)presentFpaVa3p3_mV, 5);       // DAC5 -> VA3P3
   ProximCfg.vdac_value[5] = FLEG_VccVoltage_To_DacWord((float)presentFpaVDetGuard_mV, 6);   // DAC6 -> VDETGUARD
   ProximCfg.vdac_value[6] = FLEG_VccVoltage_To_DacWord((float)presentFpaVDetCom_mV, 7);     // DAC7 -> VDETCOM
   ProximCfg.vdac_value[7] = FLEG_VccVoltage_To_DacWord((float)presentFpaVPixQNB_mV, 8);     // DAC8 -> VPIXQNB

   if (sw_init_done == 0)
   {
      // valeurs par défaut pour les champs qui ne viennent pas des flash settings
      gFpaVa1p8_mV = CALCIUM_VA1P8_DEFAULT_mV;
      gFpaVPixRst_mV = CALCIUM_VPIXRST_DEFAULT_mV;
      gFpaVdhs1p8_mV = CALCIUM_VDHS1P8_DEFAULT_mV;
      gFpaVd1p8_mV = CALCIUM_VD1P8_DEFAULT_mV;
      gFpaVa3p3_mV = CALCIUM_VA3P3_DEFAULT_mV;
      gFpaVDetGuard_mV = CALCIUM_VDETGUARD_DEFAULT_mV;
      gFpaVDetCom_mV = CALCIUM_VDETCOM_DEFAULT_mV;
      gFpaVPixQNB_mV = CALCIUM_VPIXQNB_DEFAULT_mV;
   }

   // VA1P8
   if (gFpaVa1p8_mV != presentFpaVa1p8_mV)
   {
      if (gFpaVa1p8_mV >= CALCIUM_VA1P8_MIN_mV && gFpaVa1p8_mV <= CALCIUM_VA1P8_MAX_mV)
         ProximCfg.vdac_value[0] = FLEG_VccVoltage_To_DacWord((float)gFpaVa1p8_mV, 1);
   }
   presentFpaVa1p8_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[0], 1);
   gFpaVa1p8_mV = presentFpaVa1p8_mV;

   // VPIXRST
   if (gFpaVPixRst_mV != presentFpaVPixRst_mV)
   {
      if (gFpaVPixRst_mV >= CALCIUM_VPIXRST_MIN_mV && gFpaVPixRst_mV <= CALCIUM_VPIXRST_MAX_mV)
         ProximCfg.vdac_value[1] = FLEG_VccVoltage_To_DacWord((float)gFpaVPixRst_mV, 2);
   }
   presentFpaVPixRst_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[1], 2);
   gFpaVPixRst_mV = presentFpaVPixRst_mV;

   // VDHS1P8
   if (gFpaVdhs1p8_mV != presentFpaVdhs1p8_mV)
   {
      if (gFpaVdhs1p8_mV >= CALCIUM_VDHS1P8_MIN_mV && gFpaVdhs1p8_mV <= CALCIUM_VDHS1P8_MAX_mV)
         ProximCfg.vdac_value[2] = FLEG_VccVoltage_To_DacWord((float)gFpaVdhs1p8_mV, 3);
   }
   presentFpaVdhs1p8_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[2], 3);
   gFpaVdhs1p8_mV = presentFpaVdhs1p8_mV;

   // VD1P8
   if (gFpaVd1p8_mV != presentFpaVd1p8_mV)
   {
      if (gFpaVd1p8_mV >= CALCIUM_VD1P8_MIN_mV && gFpaVd1p8_mV <= CALCIUM_VD1P8_MAX_mV)
         ProximCfg.vdac_value[3] = FLEG_VccVoltage_To_DacWord((float)gFpaVd1p8_mV, 4);
   }
   presentFpaVd1p8_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[3], 4);
   gFpaVd1p8_mV = presentFpaVd1p8_mV;

   // VA3P3
   if (gFpaVa3p3_mV != presentFpaVa3p3_mV)
   {
      if (gFpaVa3p3_mV >= CALCIUM_VA3P3_MIN_mV && gFpaVa3p3_mV <= CALCIUM_VA3P3_MAX_mV)
         ProximCfg.vdac_value[4] = FLEG_VccVoltage_To_DacWord((float)gFpaVa3p3_mV, 5);
   }
   presentFpaVa3p3_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[4], 5);
   gFpaVa3p3_mV = presentFpaVa3p3_mV;

   // VDETGUARD
   // TODO ajouter protection VDETGUARD < VDETCOM
   if (gFpaVDetGuard_mV != presentFpaVDetGuard_mV)
   {
      if (gFpaVDetGuard_mV >= CALCIUM_VDETGUARD_MIN_mV && gFpaVDetGuard_mV <= CALCIUM_VDETGUARD_MAX_mV)
         ProximCfg.vdac_value[5] = FLEG_VccVoltage_To_DacWord((float)gFpaVDetGuard_mV, 6);
   }
   presentFpaVDetGuard_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[5], 6);
   gFpaVDetGuard_mV = presentFpaVDetGuard_mV;

   // VDETCOM
   // TODO ajouter protection VDETCOM > VA3P3 - b3PixPDIBias pour éviter polarisation positive des photodiodes
   if (gFpaVDetCom_mV != presentFpaVDetCom_mV)
   {
      if (gFpaVDetCom_mV >= CALCIUM_VDETCOM_MIN_mV && gFpaVDetCom_mV <= CALCIUM_VDETCOM_MAX_mV)
         ProximCfg.vdac_value[6] = FLEG_VccVoltage_To_DacWord((float)gFpaVDetCom_mV, 7);
   }
   presentFpaVDetCom_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[6], 7);
   gFpaVDetCom_mV = presentFpaVDetCom_mV;

   // VPIXQNB
   if (gFpaVPixQNB_mV != presentFpaVPixQNB_mV)
   {
      if (gFpaVPixQNB_mV >= CALCIUM_VPIXQNB_MIN_mV && gFpaVPixQNB_mV <= CALCIUM_VPIXQNB_MAX_mV)
         ProximCfg.vdac_value[7] = FLEG_VccVoltage_To_DacWord((float)gFpaVPixQNB_mV, 8);
   }
   presentFpaVPixQNB_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[7], 8);
   gFpaVPixQNB_mV = presentFpaVPixQNB_mV;
   
   // envoi de la configuration de l'électronique de proximité (les DACs en l'occurrence) par un autre canal 
   FPA_SendProximCfg(&ProximCfg, ptrA);
    
   // envoi du reste de la config 
   WriteStruct(ptrA);
}

//--------------------------------------------------------------------------
// Pour avoir les parametres propres au calcium avec une config
//--------------------------------------------------------------------------
void FPA_SpecificParams(calcium_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // Compile-time assertions
   _Static_assert((uint32_t)CALCIUM_CLK_DDR_HZ % (uint32_t)CALCIUM_CLK_CORE_HZ == 0, "Unsupported ClkDDR/ClkCore ratio");
   _Static_assert((uint32_t)CALCIUM_CLK_CORE_HZ % (uint32_t)CALCIUM_CLK_CTRL_DSM_HZ == 0, "Unsupported ClkCore/ClkCtrlDSM ratio");
   _Static_assert((uint32_t)CALCIUM_CLK_DDR_HZ % (uint32_t)CALCIUM_CLK_COL_HZ == 0, "Unsupported ClkDDR/ClkCol ratio");
   
   // Make sure exposure time is rounded to a factor of ClkCore
   float exposureTime = roundf(exposureTime_usec/1e6F * CALCIUM_CLK_CORE_HZ) / CALCIUM_CLK_CORE_HZ;
   
   // Diag config with shortest possible delays
   ptrH->diag_x_to_readout_start_dly = 0;
   ptrH->diag_fval_re_to_dval_re_dly = 0;
   ptrH->diag_lval_pause_dly = 6;         // min possible value
   ptrH->diag_x_to_next_fsync_re_dly = 0;
   ptrH->diag_xsize_div_per_pixel_num = pGCRegs->Width/4;   // 4 pix wide

   // Integration signal transmitted by ClkFrm has to be latched to ClkCore
   // domain. Therefore, the delay (and uncertainty) of the integration start
   // is one clock cycle of ClkCore.
   ptrH->integrationDelay = 1.0F / CALCIUM_CLK_CORE_HZ;

   // Readout delay.
   // - In ITR mode, the readout delay is the overhead time. The back-end reset is done between the
   //       readout end and the integration start so we have to add it to the readout delay.
   // - In IWR mode, the readout delay is the sum of all delays. The overhead time is also multiplied by 2.
   ptrH->itrReadoutDelay = ((CALCIUM_bPixOHCnt + 1.0F) + (CALCIUM_bPixRstBECnt + 1.0F)) / CALCIUM_CLK_CORE_HZ;
   ptrH->iwrReadoutDelay =
      ((CALCIUM_bPixRstHCnt + 1.0F) + (CALCIUM_bPixXferCnt + 1.0F) + 2.0F*(CALCIUM_bPixOHCnt + 1.0F) +
      (CALCIUM_bPixOH2Cnt + 1.0F) + (CALCIUM_bPixRstBECnt + 1.0F) + (CALCIUM_bRODelayCnt + 1.0F)) / CALCIUM_CLK_CORE_HZ;
   
   // Residue ADC conversion time is 130 ClkCol cycles and ADC reset time.
   float ADCConvTime = (130.0F + CALCIUM_bADRstCnt) / CALCIUM_CLK_COL_HZ;
   
   // Serializer transmission time.
   // 1st line is the transmission of a row and is done on both edges of ClkDDR.
   // 2nd line is an overhead time on ClkCol.
   float serializerTxTime = 8.0F * (pGCRegs->Width/8.0F + 4.0F) * CALCIUM_BITS_PER_PIX / (2.0F * CALCIUM_CLK_DDR_HZ * CALCIUM_TX_OUTPUTS)
      + 6.0F / CALCIUM_CLK_COL_HZ;
   
   // Readout row time must be longer than the ADC conversion time and the serializer transmission time.
   // We use floor() + 1 to make sure calculated time is longer and not equal to the other delays.
   ptrH->readoutRowTime = (floorf(MAX(ADCConvTime, serializerTxTime) * CALCIUM_CLK_COL_HZ) + 1.0F) / CALCIUM_CLK_COL_HZ;
   
   // Frame has image rows, 2 overhead rows and 2 test rows if enabled.
   ptrH->numFrRows = pGCRegs->Height + 2 + 2*CALCIUM_bTestRowsEn;
   
   // Total readout time.
   // 2 overhead rows are generated but not transmitted.
   // Readout begins on the next ClkRow so there is a 1 ClkRow jitter to add.
   ptrH->readoutTime = (ptrH->numFrRows + 2.0F + 1.0F) * ptrH->readoutRowTime;

   // Diag mode
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade ||
       pGCRegs->TestImageSelector == TIS_TelopsDynamicShade ||
       pGCRegs->TestImageSelector == TIS_TelopsConstantValue1)
   {
      // The Diag module readout delay is the sum of the config delays before DVAL and an overhead of 9 clk cycles.
      // It transmits the config width 1 out of 2 clk cycles and waits for the config pause at the end of each row.
      // The image rows are transmitted without overhead rows and there is a config delay at the end.
      float diagReadoutDelay = (ptrH->diag_x_to_readout_start_dly + ptrH->diag_fval_re_to_dval_re_dly + 9.0F) / VHD_CLK_100M_RATE_HZ;
      float diagReadoutRowTime = (ptrH->diag_xsize_div_per_pixel_num * 2.0F + ptrH->diag_lval_pause_dly) / VHD_CLK_100M_RATE_HZ;
      float diagReadoutTime = pGCRegs->Height * diagReadoutRowTime + ptrH->diag_x_to_next_fsync_re_dly / VHD_CLK_100M_RATE_HZ;

      // Replace ROIC parameters with diag values
      ptrH->readoutTime = diagReadoutTime;
      ptrH->itrReadoutDelay = diagReadoutDelay;
      ptrH->iwrReadoutDelay = diagReadoutDelay;
   }

   // Total frame time.
   // - In ITR mode, we add the delays, the readout and the integration.
   // - In IWR mode, we add the integration delay to the longer time between readout and integration.
   //       Readout delay is applied to the integration of N during the readout of N-1.
   float itrFrameTime = ptrH->integrationDelay + exposureTime + ptrH->itrReadoutDelay + ptrH->readoutTime;
   float iwrFrameTime = ptrH->integrationDelay + MAX(exposureTime + ptrH->iwrReadoutDelay, ptrH->readoutTime);
   ptrH->frameTime = (pGCRegs->IntegrationMode == IM_IntegrateThenRead) ? itrFrameTime : iwrFrameTime;
   ptrH->frameRateMax = 1.0F / ptrH->frameTime;

   // Trig controller delay between integration end and next trig.
   // - In ITR mode, we wait for the readout to end.
   // - In IWR mode, we wait for the readout to start.
   ptrH->itr_int_end_to_trig_start_dly = ptrH->itrReadoutDelay + ptrH->readoutTime;
   float iwr_int_end_to_trig_start_dly = ptrH->iwrReadoutDelay;
   ptrH->int_end_to_trig_start_dly = (pGCRegs->IntegrationMode == IM_IntegrateThenRead) ? ptrH->itr_int_end_to_trig_start_dly : iwr_int_end_to_trig_start_dly;
}

//--------------------------------------------------------------------------
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate;
   calcium_param_t hh;

   FPA_SpecificParams(&hh, (float)pGCRegs->ExposureTime, pGCRegs);

   // ENO: 10 sept 2016: Apply margin
   MaxFrameRate = hh.frameRateMax * (1.0F - gFpaPeriodMinMargin);

   // Round maximum frame rate
   MaxFrameRate = floorMultiple(MaxFrameRate, 0.01);

   return MaxFrameRate;
}

//--------------------------------------------------------------------------
// Pour avoir le ExposureMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   calcium_param_t hh;
   float presentPeriod_sec;
   float max_exposure_usec;
   float fpaAcquisitionFrameRate;

   // ENO: 10 sept 2016: d'entrée de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);

   // ENO: 10 sept 2016: tout reste inchangé
   FPA_SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition était nulle
   presentPeriod_sec = 1.0F/fpaAcquisitionFrameRate; // periode avec le frame rate actuel.

   // Calculate exposure time depending on mode ITR/IWR
   max_exposure_usec = (presentPeriod_sec - hh.integrationDelay - hh.int_end_to_trig_start_dly)*1e6F;

   // Round exposure time
   max_exposure_usec = floorMultiple(max_exposure_usec, 0.1);

   // Limit exposure time
   max_exposure_usec = MIN(MAX(max_exposure_usec, pGCRegs->ExposureTimeMin), FPA_MAX_EXPOSURE);

   return max_exposure_usec;
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
          (flashSettings.FPATemperatureConversionCoef0 == 0))
      {
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
// Pour avoir les statuts au complet
//--------------------------------------------------------------------------
void FPA_GetStatus(t_FpaStatus *Stat, const t_FpaIntf *ptrA)
{
   uint32_t temp_32b;

   Stat->adc_oper_freq_max_khz                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x00);
   Stat->adc_analog_channel_num                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x04);
   Stat->adc_resolution                         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x08);
   Stat->adc_brd_spare                          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x0C);
   Stat->ddc_fpa_roic                           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x10);
   Stat->ddc_brd_spare                          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x14);
   Stat->flex_fpa_roic                          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x18);
   Stat->flex_fpa_input                         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x1C);
   Stat->flex_ch_diversity_num                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x20);
   Stat->cooler_volt_min_mV                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x24);
   Stat->cooler_volt_max_mV                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x28);
   Stat->fpa_temp_raw                           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x2C);
   Stat->global_done                            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x30);
   Stat->fpa_powered                            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x34);
   Stat->cooler_powered                         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x38);
   Stat->errors_latchs                          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x3C);
   Stat->intf_seq_stat                          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x40);
   Stat->data_path_stat                         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x44);
   Stat->trig_ctler_stat                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x48);
   Stat->fpa_driver_stat                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x4C);
   Stat->adc_ddc_detect_process_done            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x50);
   Stat->adc_ddc_present                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x54);
   Stat->flex_flegx_detect_process_done         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x58);
   Stat->flex_flegx_present                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x5C);
   Stat->id_cmd_in_error                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x60);
   Stat->fpa_serdes_done                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x64);
   Stat->fpa_serdes_success                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x68);
   temp_32b                                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x6C);
   memcpy(Stat->fpa_serdes_delay, (uint8_t *)&temp_32b, sizeof(Stat->fpa_serdes_delay));
   Stat->fpa_serdes_edges[0]                    = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x70);
   Stat->fpa_serdes_edges[1]                    = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x74);
   Stat->fpa_serdes_edges[2]                    = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x78);
   Stat->fpa_serdes_edges[3]                    = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x7C);
   Stat->hw_init_done                           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x80);
   Stat->hw_init_success                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x84);
   Stat->flegx_present                          =((Stat->flex_flegx_present & Stat->adc_brd_spare) & 0x01);
   Stat->prog_init_done                         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x88);
   Stat->cooler_on_curr_min_mA                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x8C);
   Stat->cooler_off_curr_max_mA                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x90);
   Stat->acq_trig_cnt                           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x94);
   Stat->acq_int_cnt                            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x98);
   Stat->fpa_readout_cnt                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x9C);
   Stat->acq_readout_cnt                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA0);
   Stat->out_pix_cnt_min                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA4);
   Stat->out_pix_cnt_max                        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA8);
   Stat->trig_to_int_delay_min                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xAC);
   Stat->trig_to_int_delay_max                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB0);
   Stat->int_to_int_delay_min                   = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB4);
   Stat->int_to_int_delay_max                   = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB8);
   Stat->fast_hder_cnt                          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xBC);

   // generation de fpa_init_done et fpa_init_success
   Stat->fpa_init_success                       = (Stat->hw_init_success & sw_init_success);
   Stat->fpa_init_done                          = (Stat->hw_init_done & sw_init_done);
}

//--------------------------------------------------------------------------
// Pour afficher le feedback de FPA_INTF_CFG
//--------------------------------------------------------------------------
void FPA_PrintConfig(const t_FpaIntf *ptrA)
{
   uint32_t idx = 0;
   uint32_t temp_u32;
   float *p_temp_fp32 = (float *)(&temp_u32);

   FPA_INF("int_time = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("int_indx = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("int_signal_high_time = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_diag_mode = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_diag_type = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_pwr_on = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_acq_trig_mode = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_acq_trig_ctrl_dly = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_xtra_trig_mode = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_xtra_trig_ctrl_dly = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_trig_ctrl_timeout_dly = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_stretch_acq_trig = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_intf_data_source = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_xtra_trig_int_time = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.fpa_prog_trig_int_time = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.intclk_to_clk100_conv_numerator = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("comn.clk100_to_intclk_conv_numerator = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("offsetx = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("offsety = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("width = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("height = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("active_line_start_num = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("active_line_end_num = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("active_line_width_div4 = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("diag.x_to_readout_start_dly = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("diag.fval_re_to_dval_re_dly = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("diag.lval_pause_dly = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("diag.x_to_next_fsync_re_dly = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("diag.xsize_div_per_pixel_num = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("fpa_int_time_offset = %d", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("int_fdbk_dly = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("kpix_pgen_en = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("kpix_median_value = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("use_ext_pixqnb = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("clk_frm_pulse_width = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("fpa_serdes_lval_num = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("fpa_serdes_lval_len = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   temp_u32 = AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx); idx += 4;
   FPA_INF("compr_ratio_fp32 = " _PCF(6), _FFMT(*p_temp_fp32, 6));
   FPA_INF("cfg_num = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("vdac_value(1) = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("vdac_value(2) = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("vdac_value(3) = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("vdac_value(4) = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("vdac_value(5) = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("vdac_value(6) = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("vdac_value(7) = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
   FPA_INF("vdac_value(8) = %u", AXI4L_read32(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD + idx)); idx += 4;
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
// VccVoltage_mV : en milliVolt, tension de sortie des Vcc
// VccPosition   : position de la sortie du DAC (1 à 8)
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition)
{
   float Rs, Rd, RL, Is, DacVoltage_Volt, DacWordTemp;
   uint32_t DacWord;

   // Sur le EFA-00331-001, les canaux 2 et 6 sont des ampli-op en mode
   // suiveur. Tous les autres canaux sont des LDO avec la même config.
   if ((VccPosition == 2) || (VccPosition == 6))
   {
      // Calcul de la tension du DAC en fonction de la tension voulue de l'ampli-op
      DacVoltage_Volt = VccVoltage_mV/1000.0F;
   }
   else
   {
      Rs = 4.99e3F;    // R7
      Rd = 24.9F;      // R8
      RL = 806.0F;     // R9
      Is = 100e-6F;    // le courant du LT3045 (U2)
      
      // Calcul de la tension du DAC en fonction de la tension voulue du LDO
      DacVoltage_Volt =  ((1.0F + RL/Rd)*VccVoltage_mV/1000.0F - (Rs + RL + RL/Rd*Rs)*Is)/(RL/Rd);
   }
   
   // Deduction du bitstream du DAC
   DacWordTemp = exp2f((float)FLEG_DAC_RESOLUTION_BITS) * DacVoltage_Volt/((float)FLEG_DAC_REF_VOLTAGE_V*(float)FLEG_DAC_REF_GAIN);
   DacWord = (uint32_t) MAX(MIN(roundf(DacWordTemp), 16383.0F), 0.0F);

   return DacWord;
}

//--------------------------------------------------------------------------
// Conversion de DAC Word en VccVoltage_mV
//--------------------------------------------------------------------------
// VccVoltage_mV : en milliVolt, tension de sortie des Vcc
// VccPosition   : position de la sortie du DAC (1 à 8)
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition)
{
   float Rs, Rd, RL, Is, DacVoltage_Volt, VccVoltage_mV;
   uint32_t DacWordTemp;

   // Deduction de la tension du DAC
   DacWordTemp =  (uint32_t) MAX(MIN(DacWord, 16383), 0);
   DacVoltage_Volt = (float)DacWordTemp * ((float)FLEG_DAC_REF_VOLTAGE_V*(float)FLEG_DAC_REF_GAIN)/exp2f((float)FLEG_DAC_RESOLUTION_BITS);

   // Sur le EFA-00331-001, les canaux 2 et 6 sont des ampli-op en mode
   // suiveur. Tous les autres canaux sont des LDO avec la même config.
   if ((VccPosition == 2) || (VccPosition == 6))
   {
      // Calcul de la tension de l'ampli-op en fonction de la tension du DAC
      VccVoltage_mV = 1000.0F * DacVoltage_Volt;
   }
   else
   {
      Rs = 4.99e3F;    // R7
      Rd = 24.9F;      // R8
      RL = 806.0F;     // R9
      Is = 100e-6F;    // le courant du LT3045 (U2)
      
      // Calcul de la tension du LDO en fonction de la tension du DAC
      VccVoltage_mV = 1000.0F * (DacVoltage_Volt * (RL/Rd) + (Rs + RL + RL/Rd*Rs)*Is)/(1.0F + RL/Rd);
   }

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
