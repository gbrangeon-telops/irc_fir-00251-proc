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

// Mode d'operation choisi pour le contr�leur de trig (voir fichier fpa_common_pkg.vhd)
#define MODE_READOUT_END_TO_TRIG_START             0x00     // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR uniquement
#define MODE_TRIG_START_TO_TRIG_START              0x01     // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR et surtout IWR
#define MODE_INT_END_TO_TRIG_START                 0x02     // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du IWR et ITR
#define MODE_ITR_TRIG_START_TO_TRIG_START          0x03     // delai pris en compte = periode entre le trig actuel et le prochain. Une fois ce delai observ�, on s'assure que le readout est termin� avant de considerer le prochain trig.
#define MODE_ITR_INT_END_TO_TRIG_START             0x04     // delai pris en compte = duree entre la fin de l'integration actuelle et le prochain trig. Une fois ce delai observ�, on s'assure que le readout est termin� avant de considerer le prochain trig.

// Delais internes du controleur de trig
#define TRIG_START_TO_TRIG_START_INTERNAL_DELAY    16       // coups de CLK internes au fonctionnement de ce mode qui s'ajoutent au delai configur�.

// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                         0x0400   // adresse de base
#define AR_FPA_TEMPERATURE                         0x002C   // adresse temperature
// adresse FPA_INTF_CFG feedback du module de statuts
#define AR_FPA_INTF_CFG_BASE_ADD                   (AR_STATUS_BASE_ADD + 0x0200)

// adresse d'�criture du r�gistre du type du pilote C
#define AW_FPA_ROIC_SW_TYPE                        0xAE0    // adresse � laquelle on dit au VHD quel type de roic de fpa le pilote en C est con�u pour.
#define AW_FPA_OUTPUT_SW_TYPE                      0xAE4    // adresse � laquelle on dit au VHD quel type de sortie de fpa le pilote en C est con�u pour.
#define AW_FPA_INPUT_SW_TYPE                       0xAE8    // obligatoire pour les detecteurs analogiques

// adresse d'ecriture de la cfg des Dacs
#define AW_DAC_CFG_BASE_ADD                        0x0D00

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                                   0x21     // 0x21 -> xro3503A. Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                            0x01     // 0x01 -> output analogique. Provient du fichier fpa_common_pkg.vhd. La valeur 0x01 est celle de OUTPUT_ANALOG
#define FPA_INPUT_TYPE                             0x04     // 0x04 -> input LVCMOS33. Provient du fichier fpa_common_pkg.vhd

// identification des sources de donn�es
#define DATA_SOURCE_INSIDE_FPGA                    0        // Provient du fichier fpa_common_pkg.vhd.
#define DATA_SOURCE_OUTSIDE_FPGA                   1        // Provient du fichier fpa_common_pkg.vhd.

// adresse d'�criture du r�gistre du reset des erreurs
#define AW_RESET_ERR                               0xAEC

 // adresse d'�criture du r�gistre du reset du module FPA
#define AW_CTRLED_RESET                            0xAF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de Mglk)
#define TELOPS_DIAG_CNST                           0xD1     // mode diag constant (patron de test gener� par la carte d'acquisition : tous les pixels � la m�me valeur)
#define TELOPS_DIAG_DEGR                           0xD2     // mode diag d�grad� lin�aire(patron de test d�grad� lin�airement et g�n�r� par la carte d'acquisition).Requis en production
#define TELOPS_DIAG_DEGR_DYN                       0xD3     // mode diag d�grad� lin�aire dynamique(patron de test d�grad� lin�airement et variant d'image en image et g�n�r� par la carte d'acquisition)

#define VHD_INVALID_TEMP                           0xFFFFFFFF

// horloges du module FPA
#define VHD_CLK_100M_RATE_HZ                       100000000

// lecture de temp�rature FPA
#define FPA_TEMP_READER_ADC_DATA_RES               16       // la donn�e de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV              2048     // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN                       1        // gain du canal de lecture de temperature sur la carte ADC
#define FPA_TEMP_PWROFF_CORRECTION                 1000     // correction de la temp�rature avec le FPA ferm�<

// fleg
#define FLEG_DAC_RESOLUTION_BITS                   14       // le DAC est � 14 bits
#define FLEG_DAC_REF_VOLTAGE_V                     2.5      // on utilise la reference interne de 2.5V du DAC
#define FLEG_DAC_REF_GAIN                          2.0      // gain de r�f�rence du DAC

#define GOOD_SAMP_MEAN_DIV_BIT_POS                 21       // ne pas changer meme si le detecteur change.

#define XRO3503_CTIA_BIAS_MAX                      0xF      // value must be in 0x0 to 0xF
#define XRO3503_CTIA_BIAS_DEFAULT                  0xA      // value must be in 0x0 to 0xF

#define XRO3503_DETECT_SUB_DEFAULT_mV              3500     // Default DetectSub = 3500 mV
#define XRO3503_DETECT_SUB_MIN_mV                  2800     // 2800 mV <= DetectSub <= 3500 mV
#define XRO3503_DETECT_SUB_MAX_mV                  3500

#define XRO3503_CTIA_REF_DEFAULT_mV                2600     // Default CTIA Ref = 2600 mV
#define XRO3503_CTIA_REF_MIN_mV                    2100     // 2100 mV <= CTIA Ref <= 2700 mV
#define XRO3503_CTIA_REF_MAX_mV                    2700

#define XRO3503_VTESTG_DEFAULT_mV                  3300     // Default VTestG = 3300 mV (current skimming and antibloom disabled)
#define XRO3503_VTESTG_MIN_mV                      0        // 0 mV <= VTestG <= 3300 mV
#define XRO3503_VTESTG_MAX_mV                      3300

#define XRO3503_CM_DEFAULT_mV                      1750     // Default CM = 1750 mV
#define XRO3503_CM_MIN_mV                          1500     // 1500 mV <= CM <= 2000 mV
#define XRO3503_CM_MAX_mV                          2000

#define XRO3503_VCMO_DEFAULT_mV                    1750     // Default VCMO = 1750 mV
#define XRO3503_VCMO_MIN_mV                        1500     // 1500 mV <= VCMO <= 2000 mV
#define XRO3503_VCMO_MAX_mV                        2000

#define XRO3503_DEFAULT_REGC                       2        // Default RegC value = 2
#define XRO3503_DEFAULT_REGD                       192      // Default RegD value = 192
#define XRO3503_DEFAULT_REGF                       26       // Default RegF value = 26

#define TOTAL_DAC_NUM                              8

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
   // parametres � rentrer
   float mclk_period_usec;
   float fpa_delay_mclk;
   float vhd_delay_mclk;
   float delay_mclk;
   float lovh_mclk;
   float fovh_line;
   float min_time_between_int_usec;

   // parametres calcul�s
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
t_FpaResolutionCfg gFpaResolutionCfg[FPA_MAX_NUMBER_CONFIG_MODE] = {FPA_STANDARD_RESOLUTION};


// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV);
void FPA_SpecificParams(xro3503_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA);

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de d�part
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{
   extern int32_t gFpaDebugRegH;

   gFpaDebugRegH = 0;      //Make sure this debug is reset to power on FPA
   // sw_init_done = 0;                                                     // ENO: 11-sept 2019: ligne en commentaire pour que plusieurs appels de FPA_init ne cr�ent des bugs de flashsettings.
   FPA_Reset(ptrA);
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est con�u pour.
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides
   FPA_GetTemperature(ptrA);                                                // demande de lecture
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoy�e au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
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
// retenir qu'apr�s reset, les IO sont en 'Z' apr�s cela puisqu'on desactive le SoftwType dans le vhd. (voir vhd pour plus de details)
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
   uint32_t roicAdditionalPix;
   uint32_t roicWidth;
   uint32_t roicOffsetX;
   extern int32_t gFpaDebugRegA;                       // reserv� ELCORR pour correction �lectronique (gain et/ou offset)
   //extern int32_t gFpaDebugRegB;                       // reserv�
   extern int32_t gFpaDebugRegC;                       // reserv� adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk
   extern int32_t gFpaDebugRegD;                       // reserv� adc_clk_source_phase pour ajustement fin phase adc_clk
   extern int32_t gFpaDebugRegE;                       // reserv� fpa_intf_data_source pour sortir les donn�es des ADCs m�me lorsque le d�tecteur/flegX est absent
   extern int32_t gFpaDebugRegF;                       // reserv� real_mode_active_pixel_dly pour ajustement du d�but AOI
   //extern int32_t gFpaDebugRegG;                       // non utilis�
   extern int32_t gFpaDebugRegH;                       // non utilis�
   extern uint8_t gFpaCtiaBiasEnum;
   extern uint16_t gFpaDetectSub_mV;
   static uint16_t presentFpaDetectSub_mV = XRO3503_DETECT_SUB_DEFAULT_mV;
   extern uint16_t gFpaCtiaRef_mV;
   static uint16_t presentFpaCtiaRef_mV = XRO3503_CTIA_REF_DEFAULT_mV;
   extern uint16_t gFpaVTestG_mV;
   static uint16_t presentFpaVTestG_mV = XRO3503_VTESTG_DEFAULT_mV;
   extern uint16_t gFpaCM_mV;
   static uint16_t presentFpaCM_mV = XRO3503_CM_DEFAULT_mV;
   extern uint16_t gFpaVCMO_mV;
   static uint16_t presentFpaVCMO_mV = XRO3503_VCMO_DEFAULT_mV;
   extern uint8_t gFpaSubWindowMode;
   static uint8_t cfg_num;
   //static uint32_t presentSensorWellDepth = 0;

   // on b�tit les parametres specifiques
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);

   // diag mode and diagType
   ptrA->fpa_diag_mode = 0;                 // par defaut
   ptrA->fpa_diag_type = 0;                 // par defaut
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade) {              // mode diagnostique degrad� lineaire
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

   // allumage du d�tecteur
   ptrA->fpa_pwr_on = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas r�unies

   // config du contr�leur de trigs
   ptrA->fpa_trig_ctrl_mode         = (uint32_t)MODE_TRIG_START_TO_TRIG_START;
   if (ptrA->fpa_diag_mode == 1)    // ENO : 03 jan 2021 : en mode diag, on impose un MODE_ITR_TRIG_START_TO_TRIG_START pour aller � la vitesse maximale impos�e par le patron de tests.
      ptrA->fpa_trig_ctrl_mode      = (uint32_t)MODE_ITR_TRIG_START_TO_TRIG_START;

   ptrA->fpa_acq_trig_ctrl_dly      =  (uint32_t)(hh.frame_period_usec * 1e-6F * (float)VHD_CLK_100M_RATE_HZ);  //frame period min calcul�e avec ET=0
   ptrA->fpa_acq_trig_ctrl_dly      -= (uint32_t)TRIG_START_TO_TRIG_START_INTERNAL_DELAY;
   ptrA->fpa_spare                  = 0;
   ptrA->fpa_xtra_trig_ctrl_dly     = ptrA->fpa_acq_trig_ctrl_dly;
   ptrA->fpa_trig_ctrl_timeout_dly  = 0;     // non utilis�

   // �largit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;

   // gFpaDebugRegE: mode diag vrai et fake
   ptrA->fpa_intf_data_source = DATA_SOURCE_INSIDE_FPGA;     // fpa_intf_data_source n'est utilis�/regard� par le vhd que lorsque fpa_diag_mode = 1
   if (ptrA->fpa_diag_mode == 1){
      if ((int32_t)gFpaDebugRegE != 0)
         ptrA->fpa_intf_data_source = DATA_SOURCE_OUTSIDE_FPGA;
   }

   // Pour corriger la calibration en sous-fenetre on lit les 16 colonnes pr�c�dentes.
   // Ensuite on utilise le cropping pour se d�barasser des colonnes suppl�mentaires.
   if (pGCRegs->OffsetX == 0)
      roicAdditionalPix = 0;
   else
      roicAdditionalPix = FPA_NUMTAPS;
   roicOffsetX    = pGCRegs->OffsetX - roicAdditionalPix;
   roicWidth      = pGCRegs->Width + roicAdditionalPix;

   // diag (pour simplifier la config, on applique la correction pour la calibration en sous-fen�tre)
   ptrA->diag_ysize              = pGCRegs->Height;
   ptrA->diag_xsize_div_tapnum   = roicWidth / FPA_NUMTAPS;

   // prog ctrl
   ptrA->xstart   = roicOffsetX / FPA_NUMTAPS;
   ptrA->ystart   = pGCRegs->OffsetY / 4;
   ptrA->xstop    = (roicOffsetX + roicWidth - 1) / FPA_NUMTAPS;
   ptrA->ystop    = (pGCRegs->OffsetY + pGCRegs->Height - 1) / 4;

   if (gFpaSubWindowMode > 1)
   {
      // valeur invalide, on utilise le d�faut
      if ((roicWidth == FPA_CONFIG_GET(width_max)) && (pGCRegs->Height == FPA_CONFIG_GET(height_max)))
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

   // CTIA Bias Current
   if (gFpaCtiaBiasEnum > XRO3503_CTIA_BIAS_MAX)  // corrige une valeur invalide
      gFpaCtiaBiasEnum = XRO3503_CTIA_BIAS_DEFAULT;   // valeur max est le d�faut pour l'instant
   ptrA->ctia_bias_current = gFpaCtiaBiasEnum;

   // Registre F : ajustement des delais de la chaine
   if (sw_init_done == 0)
      gFpaDebugRegF = XRO3503_DEFAULT_REGF;
   ptrA->real_mode_active_pixel_dly = (uint32_t)gFpaDebugRegF;

   // readout ctrl
   ptrA->line_period_pclk                  = (roicWidth / FPA_NUMTAPS + (uint32_t)hh.lovh_mclk);
   ptrA->window_lsync_num                  = pGCRegs->Height + (uint32_t)hh.fovh_line;
   ptrA->readout_pclk_cnt_max              = ptrA->line_period_pclk * ptrA->window_lsync_num + 1;

   ptrA->active_line_start_num             = 1;
   ptrA->active_line_end_num               = ptrA->active_line_start_num + pGCRegs->Height - 1;

   ptrA->sof_posf_pclk                     = 1;
   ptrA->eof_posf_pclk                     = ptrA->active_line_end_num * ptrA->line_period_pclk - (uint32_t)hh.lovh_mclk;
   ptrA->sol_posl_pclk                     = 1;
   ptrA->eol_posl_pclk                     = ptrA->sol_posl_pclk + roicWidth / FPA_NUMTAPS - 1;
   ptrA->eol_posl_pclk_p1                  = ptrA->eol_posl_pclk + 1;

   // sample proc
   ptrA->pix_samp_num_per_ch               = 1;
   ptrA->good_samp_first_pos_per_ch        = ptrA->pix_samp_num_per_ch;   // position premier echantillon
   ptrA->good_samp_last_pos_per_ch         = ptrA->pix_samp_num_per_ch;   // position dernier echantillon
   ptrA->hgood_samp_sum_num                = ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->hgood_samp_mean_numerator         = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->hgood_samp_sum_num);
   ptrA->vgood_samp_sum_num                = 1;
   ptrA->vgood_samp_mean_numerator         = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->vgood_samp_sum_num);    // moyenne

   // gFpaDebugRegC dephasage grossier des adc_clk
   if (sw_init_done == 0)
      gFpaDebugRegC = XRO3503_DEFAULT_REGC;
   ptrA->adc_clk_pipe_sel = (uint32_t)gFpaDebugRegC;

   // gFpaDebugRegD dephasage fin des adc_clk
   if (sw_init_done == 0)
      gFpaDebugRegD = XRO3503_DEFAULT_REGD;
   ptrA->adc_clk_source_phase = (uint32_t)gFpaDebugRegD;

   // image info (sans la correction pour la calibration en sous-fen�tre)
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

   // fpa temp correction
   ptrA->fpa_temp_pwroff_correction = FPA_TEMP_PWROFF_CORRECTION;

   // changement de cfg_num des qu'une nouvelle cfg est envoy�e au vhd. Il s'en sert pour detecter le mode hors acquisition et ainsi en profite pour calculer le gain electronique
   ptrA->cfg_num  = ++cfg_num;
   
   // cropping
   // le compteur de position d�marre � 1 avec le SOL du readout et incr�mente de 1 � chaque transaction du bus de 4 pixels (d'o� les divisions par 4).
   // aoi_data repr�sente les pixels � conserver.
   ptrA->aoi_data_sol_pos          = roicAdditionalPix/4 + 1;  // les pixels � conserver commencent au 1er pixel apr�s les pixels suppl�mentaires
   ptrA->aoi_data_eol_pos          = roicWidth/4;              // aoi_data conserve les pixels jusqu'au dernier. Nombre de pixels = Width.
   // aoi_flag repr�sente les flags (SOF, EOF, SOL et EOL) � conserver. Ils s'accrochent 1 � 1 aux pixels conserv�s, donc aoi_data et aoi_flag doivent �tre de m�me taille.
   // aoi_flag1 et aoi_flag2 ne doivent pas se chevaucher.
   ptrA->aoi_flag1_sol_pos         = 1;                        // SOF et SOL sont toujours sur le 1er pixel
   ptrA->aoi_flag1_eol_pos         = pGCRegs->Width/4 - 1;     // aoi_flag1 conserve les flags des Width-1 premiers pixels. Nombre de pixels = Width-1.
   ptrA->aoi_flag2_sol_pos         = roicWidth/4;              // EOF et EOL sont toujours sur le dernier pixel
   ptrA->aoi_flag2_eol_pos         = ptrA->aoi_flag2_sol_pos;  // aoi_flag2 conserve les flags du dernier pixel de la ligne. Nombre de pixels = 1.


   // les DACs (1 � 8)
   ProximCfg.vdac_value[0] = FLEG_VccVoltage_To_DacWord((float)presentFpaDetectSub_mV);   // DAC1 -> DETECTSUB
   ProximCfg.vdac_value[1] = FLEG_VccVoltage_To_DacWord((float)presentFpaCtiaRef_mV);     // DAC2 -> CTIA_REF
   ProximCfg.vdac_value[2] = FLEG_VccVoltage_To_DacWord((float)presentFpaVTestG_mV);      // DAC3 -> VTESTG
   ProximCfg.vdac_value[3] = FLEG_VccVoltage_To_DacWord((float)presentFpaCM_mV);          // DAC4 -> CM
   ProximCfg.vdac_value[4] = FLEG_VccVoltage_To_DacWord((float)presentFpaVCMO_mV);        // DAC5 -> VCMO
   ProximCfg.vdac_value[5] = 0;                                                           // DAC6 -> non connect�
   ProximCfg.vdac_value[6] = 0;                                                           // DAC7 -> non connect�
   ProximCfg.vdac_value[7] = 0;                                                           // DAC8 -> non connect�

   if (sw_init_done == 0)
   {
      // valeurs par d�faut pour les champs qui ne viennent pas des flash settings
      gFpaVTestG_mV = XRO3503_VTESTG_DEFAULT_mV;
      gFpaVCMO_mV = XRO3503_VCMO_DEFAULT_mV;
   }

   // DETECTSUB
   if (gFpaDetectSub_mV != presentFpaDetectSub_mV)
   {
      if (gFpaDetectSub_mV >= XRO3503_DETECT_SUB_MIN_mV && gFpaDetectSub_mV <= XRO3503_DETECT_SUB_MAX_mV)
         ProximCfg.vdac_value[0] = FLEG_VccVoltage_To_DacWord((float)gFpaDetectSub_mV);
   }
   presentFpaDetectSub_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[0]);
   gFpaDetectSub_mV = presentFpaDetectSub_mV;

   // CTIA_REF
   if (gFpaCtiaRef_mV != presentFpaCtiaRef_mV)
   {
      if (gFpaCtiaRef_mV >= XRO3503_CTIA_REF_MIN_mV && gFpaCtiaRef_mV <= XRO3503_CTIA_REF_MAX_mV)
         ProximCfg.vdac_value[1] = FLEG_VccVoltage_To_DacWord((float)gFpaCtiaRef_mV);
   }
   presentFpaCtiaRef_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[1]);
   gFpaCtiaRef_mV = presentFpaCtiaRef_mV;

   // VTESTG
   if (gFpaVTestG_mV != presentFpaVTestG_mV)
   {
      if (gFpaVTestG_mV >= XRO3503_VTESTG_MIN_mV && gFpaVTestG_mV <= XRO3503_VTESTG_MAX_mV)
         ProximCfg.vdac_value[2] = FLEG_VccVoltage_To_DacWord((float)gFpaVTestG_mV);
   }
   presentFpaVTestG_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[2]);
   gFpaVTestG_mV = presentFpaVTestG_mV;

   // CM
   if (gFpaCM_mV != presentFpaCM_mV)
   {
      if (gFpaCM_mV >= XRO3503_CM_MIN_mV && gFpaCM_mV <= XRO3503_CM_MAX_mV)
         ProximCfg.vdac_value[3] = FLEG_VccVoltage_To_DacWord((float)gFpaCM_mV);
   }
   presentFpaCM_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[3]);
   gFpaCM_mV = presentFpaCM_mV;

   // VCMO
   if (gFpaVCMO_mV != presentFpaVCMO_mV)
   {
      if (gFpaVCMO_mV >= XRO3503_VCMO_MIN_mV && gFpaVCMO_mV <= XRO3503_VCMO_MAX_mV)
         ProximCfg.vdac_value[4] = FLEG_VccVoltage_To_DacWord((float)gFpaVCMO_mV);
   }
   presentFpaVCMO_mV = (uint16_t)FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[4]);
   gFpaVCMO_mV = presentFpaVCMO_mV;

   // envoi de la configuration de l'�lectronique de proximit� (les DACs en l'occurrence) par un autre canal
   FPA_SendProximCfg(&ProximCfg, ptrA);

   // envoi du reste de la config
   WriteStruct(ptrA);
}

//--------------------------------------------------------------------------
// Pour avoir la temp�rature du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{
   uint32_t raw_temp;
   float diode_voltage;
   float temperature;

   raw_temp = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_TEMPERATURE);  // lit le registre de temperature (fort probablement pas le pr�sent mais le pass�)
   raw_temp = (raw_temp & 0x0000FFFF);

   if (raw_temp == 0 || raw_temp == 0xFFFF)  // la diode est court-circuit�e ou ouverte
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

      // Si flashsettings non programm�s alors on utilise les valeurs par defaut
      if ((flashSettings.FPATemperatureConversionCoef4 == 0) && (flashSettings.FPATemperatureConversionCoef3 == 0) &&
          (flashSettings.FPATemperatureConversionCoef2 == 0) && (flashSettings.FPATemperatureConversionCoef1 == 0) &&
          (flashSettings.FPATemperatureConversionCoef0 == 0))
      {
         // La doc de Xenics donne Temp = 418�C � (voltage / 2mV/�C) pour un courant de 150uA
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
   uint32_t readoutWidth;

   // parametres statiques
   ptrH->mclk_period_usec           = 1e6F/(float)FPA_MCLK_RATE_HZ;
   ptrH->fpa_delay_mclk             = 32.0F + 12.0F;   // FPA: estimation delai max de sortie des pixels apr�s integration
   // Ajout delai supplementaire pour la generation du header (bug en 640x8).
   // Delai mesure experimentalement a 2.5us en 640x8, c'est-a-dire environ le temps du header divise par 9.
   // TODO: enlever ce delai lorsque le header inserter sera sur 4 pix de large.
   ptrH->fpa_delay_mclk            += (float)pGCRegs->Width / 9.0F;
   ptrH->vhd_delay_mclk             = 3.5F;   // estimation des differents delais accumul�s par le vhd
   ptrH->delay_mclk                 = ptrH->fpa_delay_mclk + ptrH->vhd_delay_mclk;
   if (FPA_MCLK_RATE_HZ <= 27E+6F)
   {
      if ((pGCRegs->Width == FPA_CONFIG_GET(width_max)) && (pGCRegs->Height == FPA_CONFIG_GET(height_max)))
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
   if (pGCRegs->Width == FPA_CONFIG_GET(width_max))
      readoutWidth = pGCRegs->Width;
   else
      // Pour corriger la calibration en sous-fenetre on lit 16 colonnes de plus.
      // En r�alit� ces colonnes sont lues seulement si OffsetX != 0, mais on ignore ce d�tail pour le calcul du FRmax.
      readoutWidth = pGCRegs->Width + FPA_NUMTAPS;
   ptrH->readout_mclk   = ((float)(readoutWidth / FPA_NUMTAPS) + ptrH->lovh_mclk) * ((float)pGCRegs->Height + ptrH->fovh_line);
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
// Pour avoir le frameRateMax avec une config donn�e
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
// Pour avoir le ExposureMax avec une config donn�e
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   xro3503_param_t hh;
   float periodMinWithNullExposure_usec;
   float presentPeriod_sec;
   float max_exposure_usec;
   float fpaAcquisitionFrameRate;

   // ENO: 10 sept 2016: d'entr�e de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);

   // ENO: 10 sept 2016: tout reste inchang�
   FPA_SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition �tait nulle
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
// Informations sur les drivers C utilis�s.
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

   // Sur le EFA-00305-001, les canaux 1 � 6 du DAC sont identiques (7 et 8 ne sont pas connect�s)
   Rs = 4.99e3F;    // R154
   Rd = 24.9F;      // R156
   RL = 806.0F;     // R155
   Is = 100e-6F;    // courant du LT3042 (U31)

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
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord)
{
   float Rs, Rd, RL, Is, DacVoltage_Volt, VccVoltage_mV;
   uint32_t DacWordTemp;

   // Sur le EFA-00305-001, les canaux 1 � 6 du DAC sont identiques (7 et 8 ne sont pas connect�s)
   Rs = 4.99e3F;    // R154
   Rd = 24.9F;      // R156
   RL = 806.0F;     // R155
   Is = 100e-6F;    // courant du LT3042 (U31)

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
      AXI4L_write32(ptrD->vdac_value[ii], ptrA->ADD + AW_DAC_CFG_BASE_ADD + 4*ii);  // dans le vhd, division par 4 avant entr�e dans ram
      ii++;
   }
}
