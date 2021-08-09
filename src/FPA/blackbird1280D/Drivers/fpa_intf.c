/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Philippe Couture
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

#include "GeniCam.h"
#include "fpa_intf.h"
#include "flashSettings.h"
#include "utils.h"
#include "IRC_status.h"
#include <math.h>
#include <string.h>
#include "mb_axi4l_bridge.h"

// Periode minimale des xtratrigs (utilisé par le hw pour avoir le temps de programmer le détecteur entre les trigs. Commande operationnelle et syhthetique seulement)
#define SCD_XTRA_TRIG_FREQ_MAX_HZ           SCD_MIN_OPER_FPS

// Parametres de la commande serielle du BB1280
#define SCD_LONGEST_CMD_BYTES_NUM           33      // longueur en bytes de la plus longue commande serielle du BB1280
#define SCD_CMD_OVERHEAD_BYTES_NUM          6       // longueur des bytes autres que ceux des données

// Mode d'operation choisi pour le contrôleur de trig 
#define MODE_READOUT_END_TO_TRIG_START      0x00    // provient du fichier fpa_common_pkg.vhd. Ce mode est choisi car plus simple pour le PelicanD
#define MODE_TRIG_START_TO_TRIG_START       0x01
#define MODE_INT_END_TO_TRIG_START          0x02
#define MODE_ITR_TRIG_START_TO_TRIG_START   0x03
#define MODE_ITR_INT_END_TO_TRIG_START      0x04
#define MODE_ALL_END_TO_TRIG_START          0x05

// Operational command parameters (D15F0002 REV3 section 3.2.3.2)
#define OP_CMD_IWR_FRAME_DLY_DEFAULT        10E-6F // "Frame read delay" parameter, in seconds
#define OP_CMD_IWR_INTG_DLY_DEFAULT         1E-6F  // "Integration delay" parameter, in seconds (200us recommended in SCD doc)
#define OP_CMD_ITR_INTG_DLY_DEFAULT         10E-6F
#define MODEL_CORR_FACTOR_IWR_M200hd        0.9536F
#define MODEL_CORR_FACTOR_ITR_M200hd        0.9655F
#define MODEL_CORR_FACTOR_IWR_M100hd        1.7F
#define MODEL_CORR_FACTOR_ITR_M100hd        1.7F

// "Boost mode off" parameter
#define OP_CMD_BOOST_MODE                   0x00 // "Boost mode off" is activated  (specific delay added to prevent image obstruction)
#define OP_CMD_NORMAL_MODE                  0x01 // "Boost mode off" is desactivated (no delay added)
// "Pixel gain modes" parameter
#define MEDIUM_GAIN_IWR                     0x00 // default mode
#define HIGH_GAIN_2_IWR                     0x01
#define MEDIUM_GAIN_ITR                     0x02
#define LOW_GAIN_ITR_IWR                    0x03
#define HIGH_GAIN_1_ITR                     0x04

// "Display mode" parameter
#define NORMAL_READOUT                     0x00 // default mode
#define BINNING_MODE                       0x02

// "Number of channels" parameter
#define CLINK_BASE                         0x00  // Not supported by VHDL FPA module
#define CLINK_MEDIUM                       0x01  // default mode
#define CLINK_FULL                         0x02  // BB1280

// For BB1280 the integration mode is determine by the "Pixel gain mode" parameter
#define SCD_ITR_MODE                       0x00
#define SCD_IWR_MODE                       0x01


// "Photo-diode bias" parameter
static const uint8_t Scd_DiodeBiasValues[] = {
      0x00,    // 100fA
      0x01,    // 300fA
      0x02,    // 1pA
      0x03,    // 3pA
      0x04,    // 10pA
      0x05,    // 30pA (default mode)
      0x06,    // 100pA
      0x07,    // 300pA
      0x08,    // 1nA
      0x09,    // 3nA
      0x0A,    // 10nA
      0x0B,    // 30nA
      0x0C,    // 100nA
      0x0D,    // 300nA

};
#define SCD_BIAS_DEFAULT_IDX              5     // 30pA (default)
#define SCD_BIAS_VALUES_NUM               (sizeof(Scd_DiodeBiasValues) / sizeof(Scd_DiodeBiasValues[0]))

// "Resolution" parameter (for BB1280, only 13 bits is available)
#define SCD_PIX_RESOLUTION_13BITS         0x02    // 13 bits

// adresse de base pour l'aiguilleur de config dans le vhd.
#define AW_SERIAL_CFG_SWITCH_ADD          0x0800  // l'aiguilleur enverra la config en ram

//partition dans la ram Vhd des config (mappées sur FPA_define)
#define AW_SERIAL_OP_CMD_RAM_BASE_ADD          0       // adresse de base en ram pour la cmd opertaionnelle
#define AW_SERIAL_INT_CMD_RAM_BASE_ADD         64      // adresse de base en ram pour la cmd int_time (la commande est implémentée uniquement dans le vhd)
#define AW_SERIAL_DIAG_CMD_RAM_BASE_ADD        128     // adresse de base en ram pour la cmd diag de scd
#define AW_SERIAL_TEMP_CMD_RAM_BASE_ADD        192     // adresse de base en ram pour la cmd read temperature
#define AW_SERIAL_FRAME_RES_CMD_RAM_BASE_ADD   256     // adresse de base en ram pour la cmd frame resolution


// les ID des commandes
#define SCD_INT_CMD_ID                    0x8001
#define SCD_OP_CMD_ID                     0x8002
#define SCD_DIAG_CMD_ID                   0x8004
#define SCD_FR_RES_CMD_ID                 0x8010
#define SCD_TEMP_CMD_ID                   0x8021
                      
// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400  // adresse de base 
#define AR_PRIVATE_STATUS_BASE_ADD        0x0800  // adresse de base des statuts specifiques ou privées
#define AR_FPA_TEMPERATURE                0x002C  // adresse temperature
#define AR_FPA_INT_TIME                   0x00C0  // adresse temps d'intégration


// adresse d'ecriture de la config diag du manufacturier
#define AW_FPA_SCD_FRAME_RES_ADD          0xA0

// adresse d'ecriture du registre signifiant que l'IDDCA est prêt pour démarrer l'intialisation des SERDES (temperature du fpa en régime permanent et configuration initiale complétée)
#define AW_FPA_SCD_IDDC_RDY_ADD                          0xA4
#define AW_FPA_SCD_FAILURE_RESP_MANAGEMENT_ADD           0xA8

// adresse d'ecriture du signal declencant la lecture de temperature
#define AW_TEMP_READ_NUM_ADD              0xD0

// adresse d'écriture du régistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xE0   // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xE4   // dit au VHD quel type de sortie de fpa e pilote en C est conçu pour.

// adresse d'ecriture signifiant la fin de la commande serielle pour le vhd
#define AW_SERIAL_CFG_END_ADD             0xFC    

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC_SCD_PROXY1               0x16   // provient du fichier fpa_common_pkg.vhd. Regroupe Pelican et BB1280.
#define OUTPUT_DIGITAL                    0x02   // provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL

// adresse d'écriture du régistre du reset des erreurs
#define AW_RESET_ERR                      0xEC

// adresse d'écriture du régistre du reset du module FPA
#define AW_CTRLED_RESET                   0xF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de SCD)
#define TELOPS_DIAG_CNST                  0xD1      // mode diag constant (patron de test generé par la carte d'acquisition : tous les pixels à la même valeur) 
#define TELOPS_DIAG_DEGR                  0xD2      // mode diag dégradé linéaire (patron de test dégradé linéairement et généré par la carte d'acquisition). Requis en production
#define TELOPS_DIAG_DEGR_DYN              0xD3      // mode diag dégradé linéaire dynamique (patron de test dégradé linéairement et variant d'image en image et généré par la carte d'acquisition)

#define SCD_PE_NORM_OUTPUT                0 // Normal detector output
#define SCD_PE_TEST1                      1 // line gradient pattern (source = SCD proxy)
#define SCD_PE_TEST2                      2 // pixel counter pattern (source = SCD proxy)
#define SCD_PE_TEST3                      3 // square centered pattern (source = SCD proxy)
#define SCD_FPA_TEST1                     4 // column counter (source = FPA)
#define SCD_FPA_TEST2                     5 // mixed counter (source = FPA)
#define SCD_FPA_TEST3                     6 // row counter (source = FPA)

#define VHD_INVALID_TEMP                  0xFFFFFFFF
#define VHD_ITR_PIPE_DLY_SEC              500E-9F     // estimation des differerents delais accumulés par le vhd
#define VHD_IWR_PIPE_DLY_SEC              250E-9F     // estimation des differerents delais accumulés par le vhd


// Struct field are in seconds
struct Scd_Param_s
{
   float Tfpp_clk;          // in second
   float Tclink_clk;        // in second
   float frame_resolution;  // in second
   float exposure_time;     // in second
   float adc_conv;          // in second
   float videoRate;
   float ro;                // in second
   float Tframe_init;       // in second
   float ro_itr;            // in second
   float fr_dly;            // in second
   float intg_dly;          // in second
   float m;
   float ro_iwr;            // in second
   float int_eg_rlx;        // in second
   float x_to_next_fsync;   // in second, x can be refer to the integration end or readout end (the longest between the two).
   float frame_period_min;  // in second

   float fig8_t1;           // in second
   float fig8_t2;           // in second
   float fig8_t3;           // in second
   float fig8_t4;           // in second
   float fig8_t5;           // in second
   float fig8_t6;           // in second
};
typedef struct Scd_Param_s Scd_Param_t;


// structure interne pour les commandes de Scd
struct Command_s             // 
{					   
   uint8_t  Header;
   uint16_t ID;
   uint16_t DataLength;
   uint8_t  Data[SCD_LONGEST_CMD_BYTES_NUM - SCD_CMD_OVERHEAD_BYTES_NUM];
   uint16_t  SerialCmdRamBaseAdd;  // ajouté pour envoyé la commande à la bonne adresse dans la RAM
   // cheksum est calculé seulement lors de l'envoi 
};
typedef struct Command_s Command_t;

// structure interne pour les packets de Scd
struct ScdPacketTx_s             // 
{					   
   uint8_t  ScdPacketTotalBytesNum;
   uint16_t  SerialCmdRamBaseAdd;
   uint8_t  ScdPacketArrayTx[SCD_LONGEST_CMD_BYTES_NUM];
};
typedef struct ScdPacketTx_s ScdPacketTx_t;

// statuts privés du module fpa
struct s_FpaPrivateStatus
{
   uint32_t fpa_frame_resolution;
};
typedef struct s_FpaPrivateStatus t_FpaPrivateStatus;


// Global variables
t_FpaPrivateStatus gPrivateStat;
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
uint32_t sw_init_done = 0;
uint32_t sw_init_success = 0;
float gIntg_dly = 0.0F;
float gFr_dly = 0.0F;

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_SpecificParams(Scd_Param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
void FPA_SendSyntheticVideo_SerialCmd(const t_FpaIntf *ptrA);
void FPA_SendOperational_SerialCmd(const t_FpaIntf *ptrA);
void FPA_ReadTemperature_StructCmd(const t_FpaIntf *ptrA);
void FPA_ReadTemperature_SerialCmd(const t_FpaIntf *ptrA);
void FPA_SendFrameResolution_SerialCmd(const t_FpaIntf *ptrA);
void FPA_SendFrameResolution_SerialCmd_V2(const t_FpaIntf *ptrA);
void FPA_FrameResolution_StructCmd(const t_FpaIntf *ptrA);
void FPA_FrameResolution_StructCmd_V2(const t_FpaIntf *ptrA);
void FPA_BuildCmdPacket(ScdPacketTx_t *ptrE, const Command_t *ptrC);
void FPA_SendCmdPacket(ScdPacketTx_t *ptrE, const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FPA_ConvertSecondToFrameTimeResolution(float seconds);
void FPA_GetPrivateStatus(t_FpaPrivateStatus *PrivateStat, const t_FpaIntf *ptrA);

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{

   sw_init_done = 0;
   sw_init_success = 0;

   FPA_Reset(ptrA);                                                         // on fait un reset du module FPA. 
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides SCD Detector   
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
   FPA_iddca_rdy(ptrA, false);
   FPA_TurnOnProxyFailureResponseManagement(ptrA, false);
   FPA_GetPrivateStatus(&gPrivateStat, ptrA);
   FPA_GetTemperature(ptrA);
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoyée au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer

   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.

   sw_init_done = 1;
   if(gPrivateStat.fpa_frame_resolution >= 2 && gPrivateStat.fpa_frame_resolution <= 127) // see D15F0002_3.pdf
      sw_init_success = 1;
}
 
void FPA_ConfigureFrameResolution(t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{
   FPA_GetPrivateStatus(&gPrivateStat, ptrA);
   FPA_SetFrameResolution(ptrA);
   FPA_SendConfigGC(ptrA, pGCRegs);
}


//*--------------------------------------------------------------------------
//   BB1280 need a specific initialisation sequence. This was demontrated by test performed on proxy electronic alone and with the first detector lend by SCD (also confirmed by SCD).
//   SCD said that they will probably correct the problem in futur firmware release.
//   1. No "Integration time command" or "frame resolution command" should be sent before a the first operational command.
//   2. The serdes initialisation will fail if the 2 following conditions aren't met (for more detail see redmine http://hawking/redmine/issues/17590):
//       * An operational command followed by a frame resolution command must have been sent.
//       * The fpa temperature must be in steady state (cooldown finish).
//--------------------------------------------------------------------------
void  FPA_iddca_rdy(t_FpaIntf *ptrA, bool state)
{
  uint8_t ii;
  for(ii = 0; ii <= 10 ; ii++)
  {
     AXI4L_write32((uint32_t)state, ptrA->ADD + AW_FPA_SCD_IDDC_RDY_ADD);
  }
}

void FPA_TurnOnProxyFailureResponseManagement(t_FpaIntf *ptrA, bool state)
{
   uint8_t ii;
   for(ii = 0; ii <= 10 ; ii++)
   {
      AXI4L_write32((uint32_t)state, ptrA->ADD + AW_FPA_SCD_FAILURE_RESP_MANAGEMENT_ADD);
   }
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
// pour reset du module
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
   Scd_Param_t hh;
   float fpaAcquisitionFrameRate;
   float scd_frame_period_min;
   float diag_corr_factor, diag_lval_high_duration;
   extern uint8_t gFpaScdDiodeBiasEnum;
   static uint8_t cfg_num = 0;
   extern int32_t gFpaDebugRegG;
   extern int32_t gFpaDebugRegH;
   extern float gIntg_dly;
   extern float gFr_dly;


   // Frame time calculation : define the maximum trig frequency allowed by the proxy for this set of operational parameters.
   fpaAcquisitionFrameRate    = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin); //on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur
   scd_frame_period_min       = 1.0F/MAX(SCD_MIN_OPER_FPS, fpaAcquisitionFrameRate);

   ptrA->scd_frame_period_min = (uint32_t)(scd_frame_period_min* FPA_VHD_INTF_CLK_RATE_HZ);


   // Calcul "integration mode dependent" parameters
   if (pGCRegs->IntegrationMode == IM_IntegrateWhileRead){
      if(gFpaDebugRegH != 0)
         gIntg_dly = (float)gFpaDebugRegH/1E+6F;
      else
         gIntg_dly = OP_CMD_IWR_INTG_DLY_DEFAULT;

      if(gFpaDebugRegG != 0)
         gFr_dly = (float)gFpaDebugRegG/1E+6F;
      else
         gFr_dly = OP_CMD_IWR_FRAME_DLY_DEFAULT;

      FPA_SpecificParams(&hh, 0.0F, pGCRegs); // Specific parameters are independent of exposure time.

      ptrA->scd_gain             = MEDIUM_GAIN_IWR;         // for BB1280, integration mode is determine by the "Pixel gain" operational parameter
      ptrA->scd_int_mode         = SCD_IWR_MODE;            // Not used in operational command (but used in FPA VHDL module).
      ptrA->scd_boost_mode       = OP_CMD_NORMAL_MODE;      // Mode of operation

      // Trig controller configuration : any trig pulse that don't respect the minimum frame time period will be discarded.
      ptrA->fpa_trig_ctrl_mode        = (uint32_t)MODE_TRIG_START_TO_TRIG_START;
      ptrA->fpa_acq_trig_ctrl_dly     = ptrA->scd_frame_period_min - (uint32_t)((hh.intg_dly + VHD_IWR_PIPE_DLY_SEC)* FPA_VHD_INTF_CLK_RATE_HZ);

      ptrA->fpa_xtra_trig_ctrl_dly    = (uint32_t)((float)FPA_VHD_INTF_CLK_RATE_HZ / (float)SCD_XTRA_TRIG_FREQ_MAX_HZ);
      ptrA->fpa_trig_ctrl_timeout_dly = (uint32_t)((float)ptrA->fpa_xtra_trig_ctrl_dly);

   }
    else{

      if(gFpaDebugRegH != 0)
         gIntg_dly = (float)gFpaDebugRegH/1E+6F;
      else
         gIntg_dly =  OP_CMD_ITR_INTG_DLY_DEFAULT;

      FPA_SpecificParams(&hh, 0.0F, pGCRegs); // Specific parameters are independent of exposure time.

      if(gFpaDebugRegG != 0){
         gFr_dly = (float)gFpaDebugRegG/1E+6F;
      }
      else{
         // gFr_dly doit toujours être plus petit que : gIntg_dly + exposure_time
         gFr_dly = scd_frame_period_min - (hh.ro_itr + hh.x_to_next_fsync);
      }

      ptrA->scd_gain             = MEDIUM_GAIN_ITR;         // for BB1280, integration mode is determine by the "Pixel gain" operational parameter
      ptrA->scd_int_mode         = SCD_ITR_MODE;            // Not used in operational command (but used in FPA VHDL module);
      ptrA->scd_boost_mode       = OP_CMD_BOOST_MODE;       // Mode of operation

      // Trig controller configuration : any trig pulse that don't respect the minimum frame time period will be discarded.
      ptrA->fpa_trig_ctrl_mode        = (uint32_t)MODE_TRIG_START_TO_TRIG_START;
      ptrA->fpa_acq_trig_ctrl_dly     = ptrA->scd_frame_period_min - (uint32_t)((hh.intg_dly + VHD_ITR_PIPE_DLY_SEC)* FPA_VHD_INTF_CLK_RATE_HZ);

      ptrA->fpa_xtra_trig_ctrl_dly    = (uint32_t)((float)FPA_VHD_INTF_CLK_RATE_HZ / (float)SCD_XTRA_TRIG_FREQ_MAX_HZ);
      ptrA->fpa_trig_ctrl_timeout_dly = (uint32_t)((float)ptrA->fpa_xtra_trig_ctrl_dly);
    }


   ptrA->scd_xstart           = pGCRegs->OffsetX;        // Image horizontal offset
   ptrA->scd_ystart           = pGCRegs->OffsetY;        // Image vertical offset
   ptrA->scd_xsize            = pGCRegs->Width;          // Image width
   ptrA->scd_ysize            = pGCRegs->Height;         // Image height
   ptrA->scd_out_chn          = CLINK_FULL;              // Only Full is available for BB1280 (3 channels, 4 pixels).  Not used in VHDL FPA module.

   ptrA->aoi_data_sol_pos          = (uint32_t)pGCRegs->OffsetX/4 + 1;    // Cropping: + 1 car le generateur de position dans le vhd a pour valeur d'origine 1. Et division par 4 car le bus dudit generateur est de largeur 4 pix
   ptrA->aoi_data_eol_pos          =  ptrA->aoi_data_sol_pos - 1 + (uint32_t)pGCRegs->Width/4; // En effet,  (ptrA->aoi_data_eol_pos - ptrA->aoi_data_sol_pos) + 1  = pGCRegs->Width/4

   if (gFpaScdDiodeBiasEnum >= SCD_BIAS_VALUES_NUM)      // Photo-diode bias
      gFpaScdDiodeBiasEnum    = SCD_BIAS_DEFAULT_IDX;    // Corrige une valeur invalide
   ptrA->scd_diode_bias       = Scd_DiodeBiasValues[gFpaScdDiodeBiasEnum];

   ptrA->scd_pix_res          = SCD_PIX_RESOLUTION_13BITS;
   ptrA->fpa_pwr_on           = 1;                       // Allumage du détecteur (Le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies)
   ptrA->fpa_spare            = 0;
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig; // Élargit le pulse de trig

   // The following parameters are only required for "Telops" test pattern generation.
   ptrA->scd_fsync_re_to_intg_start_dly = (uint32_t)((hh.intg_dly) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_x_to_readout_start_dly     = (uint32_t)((hh.fig8_t1) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_x_to_next_fsync_re_dly     = (uint32_t)(0.0F);
   ptrA->scd_fsync_re_to_fval_re_dly    = ptrA->scd_x_to_readout_start_dly;
   ptrA->scd_fval_re_to_dval_re_dly     = (uint32_t)((hh.fig8_t2) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_lval_high_duration         = (uint32_t)((hh.fig8_t3) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_hdr_start_to_lval_re_dly   = (uint32_t)((hh.fig8_t5) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_hdr_high_duration          = (uint32_t)((hh.fig8_t6) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_xsize_div_per_pixel_num    =  (uint32_t)FPA_WIDTH_MAX/FPA_CLINK_PIX_NUM; // Seulement utilisé par le générateur de patron de test.


   diag_lval_high_duration =  (float)(ptrA->scd_xsize/FPA_CLINK_PIX_NUM) / (float)FPA_VHD_INTF_CLK_RATE_HZ;
   diag_corr_factor = hh.fig8_t3 - diag_lval_high_duration;
   ptrA->scd_lval_pause_dly = (uint32_t)((hh.fig8_t4 + diag_corr_factor) * (float)FPA_VHD_INTF_CLK_RATE_HZ); // We add a delay to account for time difference between test pattern clock (100 MHz) and real data clock (80 MHz).
   
   // ---------------  Operation mode configuration (test pattern or real data mode) ----------------------------
   ptrA->fpa_diag_mode = 0;                 // default value => 0 : Test pattern deactivated (data coming from SCD proxy)
   ptrA->fpa_diag_type = 0;                 // default value => 0 : Telops static shade (dégradé linéaire)
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade)
   {
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR;
      ptrA->scd_int_mode  = SCD_IWR_MODE; // Test pattern only available in IWR.
   }
   else if (pGCRegs->TestImageSelector == TIS_TelopsConstantValue1)      // mode diagnostique avec valeur constante
   {
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_CNST;
      ptrA->scd_int_mode  = SCD_IWR_MODE; // Test pattern only available in IWR.
   }
   else if (pGCRegs->TestImageSelector == TIS_TelopsDynamicShade)
   {
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR_DYN;
      ptrA->scd_int_mode  = SCD_IWR_MODE; // Test pattern only available in IWR.
   }
   ptrA->scd_bit_pattern = SCD_PE_NORM_OUTPUT; // SCD test pattern mode is deactivated by default.
   if ((pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage1) ||
         (pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage2) ||
         (pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage3))
      ptrA->scd_bit_pattern = SCD_FPA_TEST1; // column counter (source = FPP)

   // Changement de cfg_num dès qu'une nouvelle cfg est envoyée au vhd. Permet de forcer la reprogramation du proxy à chaque fois que cette fonction est appelée.
   if (cfg_num == 255)  // protection contre depassement
      cfg_num = 0;
   cfg_num++;
   ptrA->cfg_num = (uint32_t)cfg_num;

   //-----------------------------------------                                           
   // Envoyer commande synthetique
   ptrA->proxy_cmd_to_update_id = SCD_DIAG_CMD_ID;
   WriteStruct(ptrA);   // on envoie au complet les parametres pour toutes les parties (partie common etc...)
   FPA_SendSyntheticVideo_SerialCmd(ptrA);         // on envoie la partie serielle de la commande video synthetique (elle est stockée dans une partie de la RAM en vhd)

   // Envoyer commande operationnelle
   ptrA->proxy_cmd_to_update_id = SCD_OP_CMD_ID;
   WriteStruct(ptrA);   // on envoie de nouveau au complet les parametres pour toutes les parties (partie common etc...). Ce nouvel envoi vise à a;erter l'arbitreur vhd
   FPA_SendOperational_SerialCmd(ptrA);            // on envoie la partie serielle de la commande operationnelle (elle est stockée dans une autre partie de la RAM en vhd)// ensuite on envoie la partie serielle de la commande pour la RAM vhd
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la température du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{
   uint32_t raw_temp;
   float diode_voltage;
   float temperature = 0.0F;
   
   // demande de lecture de la temperature temp(n)
   FPA_ReadTemperature_StructCmd(ptrA);      // envoi un interrupt au contrôleur du hw driver
   FPA_ReadTemperature_SerialCmd(ptrA);      // envoi la commande serielle    
   
   // lecture et conversion de la temperature temp(n-1)
   raw_temp = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_TEMPERATURE);  // lit le registre de temperature (fort probablement pas le présent mais le passé) 

   if (raw_temp == (uint32_t)VHD_INVALID_TEMP)
   {
      return FPA_INVALID_TEMP;
   }
   else
   {
      diode_voltage = (float)(raw_temp & 0x0000FFFF) * 1.25F * 1.0e-4F;
   
      // utilisation  des valeurs de flashsettings
      temperature  = flashSettings.FPATemperatureConversionCoef5 * powf(diode_voltage,5);
      temperature += flashSettings.FPATemperatureConversionCoef4 * powf(diode_voltage,4);
      temperature += flashSettings.FPATemperatureConversionCoef3 * powf(diode_voltage,3);
      temperature += flashSettings.FPATemperatureConversionCoef2 * powf(diode_voltage,2);
      temperature += flashSettings.FPATemperatureConversionCoef1 * diode_voltage;
      temperature += flashSettings.FPATemperatureConversionCoef0;  
 
      // Si flashsettings non programmés alors on utilise les valeurs par defaut
      if ((flashSettings.FPATemperatureConversionCoef5 == 0) && (flashSettings.FPATemperatureConversionCoef4 == 0) &&
            (flashSettings.FPATemperatureConversionCoef3 == 0) && (flashSettings.FPATemperatureConversionCoef2 == 0) &&
            (flashSettings.FPATemperatureConversionCoef1 == 0) && (flashSettings.FPATemperatureConversionCoef0 == 0))
      {
         // courbe de conversion de SCD
         temperature  = 1655.2F * powf(diode_voltage,5);
         temperature -= 6961.7F * powf(diode_voltage,4);
         temperature += 11235.0F * powf(diode_voltage,3);
         temperature -= 8844.0F * powf(diode_voltage,2);
         temperature += (2941.5F * diode_voltage) + 77.3F;
      }
      return K_TO_CC(temperature); // Centi celsius
   }
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la température du FPA
//--------------------------------------------------------------------------
void FPA_SetFrameResolution(t_FpaIntf *ptrA)
{
   FPA_FrameResolution_StructCmd(ptrA);      // envoi un interrupt au contrôleur du hw driver
   FPA_SendFrameResolution_SerialCmd(ptrA);      // envoi la commande serielle
}

// TODO: A enlever a la fin du debug. Sert à envoyer des requete de statut au détecteur.
void FPA_SetFrameResolution_V2(t_FpaIntf *ptrA)
{
   FPA_FrameResolution_StructCmd_V2(ptrA);      // envoi un interrupt au contrôleur du hw driver
   FPA_SendFrameResolution_SerialCmd_V2(ptrA);      // envoi la commande serielle
}


//--------------------------------------------------------------------------
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float fr_max;
   Scd_Param_t params;
   FPA_SpecificParams(&params, (float)pGCRegs->ExposureTime, pGCRegs);

   fr_max = 1.0F / params.frame_period_min;
   fr_max = fr_max * (1.0F - gFpaPeriodMinMargin);
   fr_max = floorMultiple(fr_max, 0.01);

   return fr_max;
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir le ExposureMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   float maxExposure_us, periodMinWithNullExposure, Ta;
   float operatingPeriod, fpaAcquisitionFrameRate;
   Scd_Param_t hh;

   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin); // On enleve la marge artificielle pour retrouver la vitesse reelle du detecteur
   FPA_SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition était nul
   periodMinWithNullExposure = hh.frame_period_min;
   operatingPeriod = 1.0F / MAX(SCD_MIN_OPER_FPS, fpaAcquisitionFrameRate); // periode avec le frame rate actuel. Doit tenir compte de la contrainte d'opération du détecteur
   maxExposure_us = (operatingPeriod - periodMinWithNullExposure)*1e6F;

   if (pGCRegs->IntegrationMode == IM_IntegrateWhileRead){
      Ta = (hh.fr_dly + hh.ro_iwr) - hh.intg_dly;
      if (Ta > 0)
         maxExposure_us = maxExposure_us + Ta*1E6F;
   }

   maxExposure_us = floorMultiple(maxExposure_us, 0.1);
   maxExposure_us = MIN(MAX(maxExposure_us, pGCRegs->ExposureTimeMin),FPA_MAX_EXPOSURE);
   
   return maxExposure_us;
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
   Stat->hw_init_done                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x80);
   Stat->hw_init_success               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x84);
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

   // generation de fpa_init_done et fpa_init_success
   Stat->fpa_init_success = (Stat->hw_init_success & sw_init_success);
   Stat->fpa_init_done = (Stat->hw_init_done & sw_init_done);

}

void  FPA_SoftwType(const t_FpaIntf *ptrA)
{
   AXI4L_write32(FPA_ROIC_SCD_PROXY1, ptrA->ADD + AW_FPA_ROIC_SW_TYPE);
   AXI4L_write32(OUTPUT_DIGITAL, ptrA->ADD + AW_FPA_OUTPUT_SW_TYPE);		     
}

void FPA_SpecificParams(Scd_Param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // Consulter le document D15F0002 REV3
   extern float gFr_dly;
   extern float gIntg_dly;

   //float fpaAcquisitionFrameRate;
   float corr_factor;

   if (pGCRegs->IntegrationMode == IM_IntegrateWhileRead){
      if (flashSettings.AcquisitionFrameRateMaxDivider > 1.0F)
         corr_factor = MODEL_CORR_FACTOR_IWR_M100hd;
      else
         corr_factor = MODEL_CORR_FACTOR_IWR_M200hd;
   }
   else{
      if (flashSettings.AcquisitionFrameRateMaxDivider > 1.0F)
         corr_factor = MODEL_CORR_FACTOR_ITR_M100hd;
      else
         corr_factor = MODEL_CORR_FACTOR_ITR_M200hd;
   }

   ptrH->Tfpp_clk          = 1.0F / ((float)FPA_FPP_CLK_RATE_HZ);                         // in second
   ptrH->Tclink_clk        = 1.0F / ((float)FPA_CLINK_CLK_RATE_HZ);                       // in second
   ptrH->frame_resolution  = ((float)gPrivateStat.fpa_frame_resolution)*ptrH->Tfpp_clk;   // in second
   ptrH->exposure_time     = exposureTime_usec*1E-6F;                                     // in second
   ptrH->adc_conv          = 10.65E-6F*corr_factor;                                 // in second
   ptrH->videoRate         = 2.0F;
   ptrH->ro                = ptrH->adc_conv/ptrH->videoRate;                              // in second
   ptrH->Tframe_init       = 40E-6F*corr_factor;                                    // in second
   ptrH->ro_itr            = ptrH->ro*(2.0F + (float)pGCRegs->Height)+ptrH->Tframe_init;  // in second
   ptrH->fr_dly            = gFr_dly;                                                     // in second
   ptrH->intg_dly          = gIntg_dly;                                                   // in second

   if((ptrH->fr_dly <= ptrH->intg_dly) && ((ptrH->fr_dly + ptrH->ro_itr) > (ptrH->intg_dly + ptrH->exposure_time)))
   {
      ptrH->m = 2.0F;
   }
   else
   {
      if(ptrH->fr_dly <= ptrH->intg_dly)
         ptrH->m = 1.0F;
      else
         ptrH->m = 0.0F;
   }
   ptrH->int_eg_rlx       = 17.2E-6F*corr_factor;

   if (pGCRegs->IntegrationMode == IM_IntegrateWhileRead){
      ptrH->ro_iwr           = ptrH->ro_itr + ptrH->m*(ptrH->int_eg_rlx + MAX(ptrH->adc_conv, ptrH->frame_resolution));
      ptrH->x_to_next_fsync  = 315.0E-6F*corr_factor; // Delay between the end of integration or readout (whichever one happening last) and the next fsync
      ptrH->frame_period_min = MAX(ptrH->fr_dly + ptrH->ro_iwr, ptrH->intg_dly + ptrH->exposure_time) + ptrH->x_to_next_fsync;
   }
   else{
      ptrH->x_to_next_fsync  = 190.0E-6F*corr_factor; // Delay between the end of readout and the next fsync
      ptrH->frame_period_min = ptrH->intg_dly + ptrH->exposure_time + ptrH->ro_itr + ptrH->x_to_next_fsync;

   }

   // Camera Link output timing -> calcul based on figure 8 (D15F0002 REV3)
   ptrH->fig8_t1 = ptrH->fr_dly + ptrH->Tframe_init;
   ptrH->fig8_t2 = ceilMultiple(6.0F*ptrH->Tclink_clk, 1.0F/FPA_VHD_INTF_CLK_RATE_HZ);
   ptrH->fig8_t3 = ((float)FPA_WIDTH_MAX/(float)FPA_CLINK_PIX_NUM)*ptrH->Tclink_clk;
   ptrH->fig8_t4 = 800E-9F;


   ptrH->fig8_t5 = 100E-6F;
   //ptrH->fig8_t6 = 16E-6F/(float)FPA_CLINK_PIX_NUM;
   ptrH->fig8_t6 = 0.0F; // No header
}


//-------------------------------------------------------
// Commande temperature : envoi partie structurale
//-------------------------------------------------------
void FPA_ReadTemperature_StructCmd(const t_FpaIntf *ptrA)    
{      
   static uint8_t tempReadNum = 0;

   // Changement de cfg_num dès qu'une nouvelle cfg est envoyée au vhd. Permet de forcer la reprogramation du proxy à chaque fois que cette fonction est appelée.
   if (tempReadNum == 255)  // protection contre depassement
      tempReadNum = 0;
   tempReadNum++;
   
   // 3 envois juste pour donner du temps à l'arbitreur de prendre la commande
   AXI4L_write32((uint32_t)tempReadNum, ptrA->ADD + AW_TEMP_READ_NUM_ADD);  // cela envoi un signal au contrôleur du hw_driver pour la lecture de la temperature
   AXI4L_write32((uint32_t)tempReadNum, ptrA->ADD + AW_TEMP_READ_NUM_ADD);   
   AXI4L_write32((uint32_t)tempReadNum, ptrA->ADD + AW_TEMP_READ_NUM_ADD);
} 

//-------------------------------------------------------
// Commande frame resolution : envoi partie structurale
//-------------------------------------------------------
void FPA_FrameResolution_StructCmd(const t_FpaIntf *ptrA)
{
   static uint8_t cfg_num = 0;

   if (cfg_num == 255)
      cfg_num = 0;
   cfg_num++;

   // 3 envois juste pour donner du temps à l'arbitreur de prendre la commande
   AXI4L_write32((uint32_t)cfg_num, ptrA->ADD + AW_FPA_SCD_FRAME_RES_ADD);
   AXI4L_write32((uint32_t)cfg_num, ptrA->ADD + AW_FPA_SCD_FRAME_RES_ADD);
   AXI4L_write32((uint32_t)cfg_num, ptrA->ADD + AW_FPA_SCD_FRAME_RES_ADD);
}


//TODO : À supprimer
void FPA_FrameResolution_StructCmd_V2(const t_FpaIntf *ptrA)
{
   static uint8_t cfg_num = 0;

   if (cfg_num == 255)
      cfg_num = 0;
   cfg_num++;

   // 3 envois juste pour donner du temps à l'arbitreur de prendre la commande
   AXI4L_write32((uint32_t)cfg_num, ptrA->ADD + AW_FPA_SCD_FRAME_RES_ADD);
   AXI4L_write32((uint32_t)cfg_num, ptrA->ADD + AW_FPA_SCD_FRAME_RES_ADD);
   AXI4L_write32((uint32_t)cfg_num, ptrA->ADD + AW_FPA_SCD_FRAME_RES_ADD);
}

float FPA_ConvertSecondToFrameTimeResolution(float seconds)
{
   float regValue;
   regValue =  seconds*FPA_FPP_CLK_RATE_HZ; // in 70 MHz clks
   regValue =  regValue/((float)gPrivateStat.fpa_frame_resolution); // in frame_res
   return regValue;
}

//------------------------------------------------------
// Commande operationnelle : envoi partie serielle               
//------------------------------------------------------
void FPA_SendOperational_SerialCmd(const t_FpaIntf *ptrA)
{
   Command_t Cmd;
   ScdPacketTx_t ScdPacketTx;
   uint8_t scd_gain;
   uint32_t vhd_int_time;
   float Tint, Tframe, fr_dly, intg_dly;
   uint8_t scd_hder_disable  = 1;  // 0 => enabled, 1 => disabled
   uint8_t FSyncMode         = 0;  // 0 => external "slave" sync mode, 1 => internal "master" sync mode (default)
   uint8_t ReadDirLR         = 0;  // 0 => left to right (default), 1 => right to left
   uint8_t ReadDirUP         = 1;  // 0 => Up to down (default), 1 => down to up
   uint8_t FRM_SYNC_MOD      = 0;  // 0 => Integ@start, 1 => Integ@end
   uint8_t FPP_power_on_mode = 0;  // 00 => FPP PS On, only at cryogenic temperature (conditional power up)
   extern float gFr_dly;
   extern float gIntg_dly;


   scd_gain = (uint8_t)(ptrA->scd_gain);
   uint32_t scd_ystart = ptrA->scd_ystart >> 1;           // in step of 2 rows
   uint32_t scd_xstart = 0;                               // in step of 4 pixels
   uint32_t scd_ysize  = ptrA->scd_ysize  >> 1;           // in step of 2 rows
   uint32_t scd_xsize  = (uint32_t)FPA_WIDTH_MAX  >> 2;   // in step of 4 pixels

   if (GC_FWSynchronouslyRotatingModeIsActive)
      vhd_int_time = 0.0F;
   else
      vhd_int_time = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_INT_TIME); // read from vhdl (in 100MHz clks)

   Tint = (float)vhd_int_time*(1E6F/FPA_VHD_INTF_CLK_RATE_HZ); // in us
   Tint = MIN(MAX(Tint, FPA_MIN_EXPOSURE), FPA_MAX_EXPOSURE);  // protection
   Tint = Tint/1E6F; // in second
   Tint = FPA_ConvertSecondToFrameTimeResolution(Tint);

   Tframe = ptrA->scd_frame_period_min/FPA_VHD_INTF_CLK_RATE_HZ; // in second
   Tframe = FPA_ConvertSecondToFrameTimeResolution(Tframe);

   intg_dly = FPA_ConvertSecondToFrameTimeResolution(gIntg_dly);
   fr_dly = FPA_ConvertSecondToFrameTimeResolution(gFr_dly);

   // on bâtit la commande
   Cmd.Header       =  0xAA;
   Cmd.ID           =  0x8002;
   Cmd.DataLength   =  27;
   Cmd.Data[0]      =  (uint32_t)Tint & 0xFF;             //Integration time lsb
   Cmd.Data[1]      = ((uint32_t)Tint >> 8) & 0xFF;
   Cmd.Data[2]      = ((uint32_t)Tint >> 16) & 0x0F;      //Integration time msb
                    
   Cmd.Data[3]      =  0;                               // Reserved
   Cmd.Data[4]      =  0;                               // Reserved
   Cmd.Data[5]      =  0;                               // Reserved
                    
   Cmd.Data[6]      =  scd_ystart & 0xFF;                // Image Vertical Offset lsb
   Cmd.Data[7]      = (scd_ystart >> 8) & 0xFF;          // Image Vertical Offset msb

   Cmd.Data[8]      =  scd_ysize & 0xFF;                 // Image Vertical Length lsb
   Cmd.Data[9]      = (scd_ysize >> 8) & 0xFF;           // Image Vertical Length msb
                        
   Cmd.Data[10]     =  scd_xsize & 0xFF;                 // Image Horizontal Length lsb
   Cmd.Data[11]     = (scd_xsize >> 8) & 0xFF;           // Image Horizontal Length msb
                        
   Cmd.Data[12]     =  scd_xstart & 0xFF;                // Image Horizontal Offset lsb
   Cmd.Data[13]     = (scd_xstart >> 8) & 0xFF;          // Image Horizontal Offset msb
                        
   Cmd.Data[14]     =((scd_hder_disable & 0x01) << 7) + ((ptrA->scd_diode_bias & 0x0F) << 3) + (scd_gain & 0x07);

   Cmd.Data[15]     =  (uint32_t)Tframe & 0xFF;         // Frame period lsb
   Cmd.Data[16]     = ((uint32_t)Tframe >> 8) & 0xFF;
   Cmd.Data[17]     = ((uint32_t)Tframe >> 16) & 0x0F;  // Frame period msb
                         
   Cmd.Data[18]     = (0x00 << 7) + ((((uint32_t)NORMAL_READOUT) & 0x0F) << 3) + ((FSyncMode & 0x01) << 2) + ((ReadDirLR & 0x01) << 1) + (ReadDirUP & 0x01);
   Cmd.Data[19]     = 0;                                          // Reserved
   Cmd.Data[20]     = ((FPP_power_on_mode & 0x03) << 6) + ((ptrA->scd_boost_mode & 0x01) << 5) + ((FRM_SYNC_MOD & 0x01) << 4) + (((ptrA->scd_out_chn) & 0x03) << 2)  + (ptrA->scd_pix_res & 0x03);
   
   Cmd.Data[21]     =  (uint32_t)fr_dly & 0xFF;                   // Frame read delay lsb
   Cmd.Data[22]     = ((uint32_t)fr_dly >> 8) & 0xFF;
   Cmd.Data[23]     = ((uint32_t)fr_dly >> 16) & 0x0F;            // Frame read delay  msb

   Cmd.Data[24]     =  (uint32_t)intg_dly & 0xFF;                 // Integration delay lsb
   Cmd.Data[25]     = ((uint32_t)intg_dly >> 8) & 0xFF;
   Cmd.Data[26]     = ((uint32_t)intg_dly >> 16) & 0x0F;          // Integration delay  msb

   Cmd.SerialCmdRamBaseAdd = (uint16_t)AW_SERIAL_OP_CMD_RAM_BASE_ADD; // Adresse à laquelle envoyer la commande en RAM
   // on batit les packets de bytes
   FPA_BuildCmdPacket(&ScdPacketTx, &Cmd);
   
   // on envoit les packets
   FPA_SendCmdPacket(&ScdPacketTx, ptrA);

}

//--------------------------------------------------------
// Commande video synthetique : envoi partie serielle
//--------------------------------------------------------
void FPA_SendSyntheticVideo_SerialCmd(const t_FpaIntf *ptrA)
{    
   uint8_t ii;
   Command_t Cmd;
   ScdPacketTx_t ScdPacketTx;
	
   // on bâtit la commande
   Cmd.Header              = 0xAA;
   Cmd.ID                  = 0x8004;
   Cmd.DataLength          = 2;
   Cmd.Data[0]             = ptrA->scd_bit_pattern & 0x0F;
   Cmd.SerialCmdRamBaseAdd = (uint16_t)AW_SERIAL_DIAG_CMD_RAM_BASE_ADD;
   for(ii = 1; ii < Cmd.DataLength; ii++)
      Cmd.Data[ii] = 0;
   
   // on batit les packets de bytes
   FPA_BuildCmdPacket(&ScdPacketTx, &Cmd);
   
   // on envoit les packets
   FPA_SendCmdPacket(&ScdPacketTx, ptrA);
}

//--------------------------------------------------------
// Commande lecture de température : envoi partie serielle
//--------------------------------------------------------
void FPA_ReadTemperature_SerialCmd(const t_FpaIntf *ptrA)
{    
   uint8_t ii;
   Command_t Cmd;
   ScdPacketTx_t ScdPacketTx;
	
   // on bâtit la commande
   Cmd.Header       =  0xAA;
   Cmd.ID           =  0x8021;
   Cmd.DataLength   =  0;
   Cmd.Data[0]      =  0;
   for(ii = 1; ii < Cmd.DataLength; ii++)
      Cmd.Data[ii] = 0;   
   Cmd.SerialCmdRamBaseAdd = (uint16_t)AW_SERIAL_TEMP_CMD_RAM_BASE_ADD;
   FPA_BuildCmdPacket(&ScdPacketTx, &Cmd); // on batit les packets de bytes
   FPA_SendCmdPacket(&ScdPacketTx, ptrA);  // on envoit les packets
}

void FPA_SendFrameResolution_SerialCmd(const t_FpaIntf *ptrA)
{
   uint8_t ii;
   Command_t Cmd;
   ScdPacketTx_t ScdPacketTx;

   // on bâtit la commande
   Cmd.Header              = 0xAA;
   Cmd.ID                  = 0x8010;
   Cmd.DataLength          = 2;
   Cmd.Data[0]             = ((uint8_t)gPrivateStat.fpa_frame_resolution) & 0x7F;
   for(ii = 1; ii < Cmd.DataLength; ii++)
      Cmd.Data[ii] = 0;
   Cmd.SerialCmdRamBaseAdd = (uint16_t)AW_SERIAL_FRAME_RES_CMD_RAM_BASE_ADD;
   FPA_BuildCmdPacket(&ScdPacketTx, &Cmd); // on batit les packets de bytes
   FPA_SendCmdPacket(&ScdPacketTx, ptrA);  // on envoit les packets
}

void FPA_SendFrameResolution_SerialCmd_V2(const t_FpaIntf *ptrA)
{
   Command_t Cmd;
   ScdPacketTx_t ScdPacketTx;
   extern int32_t gFpaDebugRegA;
   // on bâtit la commande
   Cmd.Header              = 0xAA;
   Cmd.ID                  = 0x8000 + (uint8_t)gFpaDebugRegA;
   PRINTF("Cmd.ID = %d \n",Cmd.ID );
   Cmd.DataLength          = 0;
   Cmd.SerialCmdRamBaseAdd = (uint16_t)AW_SERIAL_FRAME_RES_CMD_RAM_BASE_ADD;
   FPA_BuildCmdPacket(&ScdPacketTx, &Cmd); // on batit les packets de bytes
   FPA_SendCmdPacket(&ScdPacketTx, ptrA);  // on envoit les packets
}


//-------------------------------
// scd commands packets build
//-------------------------------
void FPA_BuildCmdPacket(ScdPacketTx_t *ptrE, const Command_t *ptrC)
{
   uint16_t index;
   uint8_t chksum;
   uint16_t total_length;
   
   total_length = ptrC->DataLength + SCD_CMD_OVERHEAD_BYTES_NUM;
   ptrE->ScdPacketTotalBytesNum = total_length;
   ptrE->SerialCmdRamBaseAdd = ptrC->SerialCmdRamBaseAdd; 
   
   chksum  = ptrE->ScdPacketArrayTx[0] =  ptrC->Header;
   chksum += ptrE->ScdPacketArrayTx[1] =  ptrC->ID & 0x00FF;
   chksum += ptrE->ScdPacketArrayTx[2] = (ptrC->ID & 0xFF00) >> 8;
   chksum += ptrE->ScdPacketArrayTx[3] =  ptrC->DataLength & 0x00FF;
   chksum += ptrE->ScdPacketArrayTx[4] = (ptrC->DataLength & 0xFF00) >> 8;
        
   // Now copy the array locally
   index = 0;
   while(index < ptrC->DataLength)
   {
      ptrE->ScdPacketArrayTx[index+5] = ptrC->Data[index];
      chksum += ptrC->Data[index];
      index++;
   }
   
   // compute finally the checksum
   chksum %= 256;
   chksum = (~chksum) + 1;                      
   ptrE->ScdPacketArrayTx[total_length-1] = chksum;

}

//-----------------------------------
// Envoi des packets
//-----------------------------------
void FPA_SendCmdPacket(ScdPacketTx_t *ptrE, const t_FpaIntf *ptrA)
{
   uint16_t index = 0;
   uint8_t ii;
   
   while(index < ptrE->ScdPacketTotalBytesNum)
   {
      AXI4L_write32(ptrE->ScdPacketArrayTx[index], ptrA->ADD + AW_SERIAL_CFG_SWITCH_ADD + 4*(ptrE->SerialCmdRamBaseAdd + index));  // dans le vhd, division par 4 avant entrée dans ram
      index++;
   }
   for(ii = 0; ii <= 3 ; ii++)
   {      
      AXI4L_write32(0, ptrA->ADD + + AW_SERIAL_CFG_SWITCH_ADD + AW_SERIAL_CFG_END_ADD);  // envoi de '0' à l'adresse de fin pour donner du temps à l'arbitreur pour detecter la fin qui s'en vient.
   };
   AXI4L_write32(1, ptrA->ADD + AW_SERIAL_CFG_SWITCH_ADD + AW_SERIAL_CFG_END_ADD); 
}

//--------------------------------------------------------------------------
// Pour avoir les statuts privés du module détecteur
//--------------------------------------------------------------------------
void FPA_GetPrivateStatus(t_FpaPrivateStatus *PrivateStat, const t_FpaIntf *ptrA)
{
   // config retournée par le vhd
   PrivateStat->fpa_frame_resolution = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x00);
}

