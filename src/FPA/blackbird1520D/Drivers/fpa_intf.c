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

#include "GeniCam.h"
#include "fpa_intf.h"
#include "flashSettings.h"
#include "utils.h"
#include "IRC_status.h"
#include "exposure_time_ctrl.h"
#include <stdbool.h>
#include <math.h>
#include <string.h>

#ifdef SIM
   #include "proc_ctrl.h" // Contains the class SC_MODULE for SystemC simulation
   #include "mb_transactor.h" // Contains virtual functions that emulates microblaze functions
   #include "mb_axi4l_bridge_SC.h" // Used to bridge Microblaze AXI4-Lite transaction in SystemC transaction
#else                  
   #include "mb_axi4l_bridge.h"
#endif
 

// Peride minimale des xtratrigs (utilisé par le hw pour avoir le temps de programmer le détecteur entre les trigs. Commande operationnelle et syhthetique seulement)
#define XTRA_TRIG_FREQ_MAX_HZ              SCD_MIN_OPER_FPS

// Parametres de la commande serielle du bb1920D
#define CMD_DATA_BYTES_NUM_MAX              32      // longueur maximale admise pour la partie donnée des commandes

// Mode d'operation choisi pour le contrôleur de trig 
#define MODE_READOUT_END_TO_TRIG_START     0x00    // provient du fichier fpa_common_pkg.vhd. Ce mode est choisi car plus simple pour le bb1920D
#define MODE_TRIG_START_TO_TRIG_START      0x01
#define MODE_INT_END_TO_TRIG_START         0x02
#define MODE_ITR_TRIG_START_TO_TRIG_START  0x03    
#define MODE_ITR_INT_END_TO_TRIG_START     0x04
#define MODE_ALL_END_TO_TRIG_START         0x05

// identification des sources de données
#define DATA_SOURCE_INSIDE_FPGA            0       // Provient du fichier fpa_common_pkg.vhd.
#define DATA_SOURCE_OUTSIDE_FPGA           1       // Provient du fichier fpa_common_pkg.vhd.

// bb1920D integration modes definies par SCD  
#define ITR_MODE                           0x00    // valeur provenant du manuel de SCD
#define IWR_MODE                           0x01    // valeur provenant du manuel de SCD

#define LOW_GAIN                           0x00   // LowGain: "Hercules-like" pixel operation IWR/ITR
#define HIGH_GAIN                          0x01   // A/B pixel caps operation, lowest noise, ITR/IWR
#define UNIFIED_CAP_LOW_GAIN               0x02   // UnifiedCap-LowGain: same capacity as LowGain with lower noise, ITR only
#define HIGH_CAPACITY                      0x03   // High Capacity: largest capacity, ITR/IWR
#define UNIFIED_CAP_MEDIUM_GAIN            0x04   // UnifiedCap-Medium Gain: ITR only

// bb1920D Pixel resolution 
#define PIX_RESOLUTION_15BITS              0x00    // 15 bits selon SCD
#define PIX_RESOLUTION_14BITS              0x01    // 14 bits selon SCD
#define PIX_RESOLUTION_13BITS              0x02    // 13 bits selon SCD

// adresse de base pour l'aiguilleur de config dans le vhd.
#define AW_SERIAL_CFG_RAM_BASE_ADD         0x0C00  // l'aiguilleur enverra la config en ram

//partition dans la ram Vhd des config (mappées sur FPA_define)
#define AW_SERIAL_OP_CMD_RAM_ADD           0       // adresse de base en ram pour la cmd opertaionnelle
#define AW_SERIAL_ROIC_REG_CMD_RAM_ADD     32      // adresse de base en ram pour la cmd d'écriture/lecture de registre du roic
#define AW_SERIAL_INT_CMD_RAM_ADD          64      // adresse de base en ram pour la cmd int_time (la commande est implémentée uniquement dans le vhd)
#define AW_SERIAL_TEMP_CMD_RAM_ADD         96      // adresse de base en ram pour la cmd read temperature
                      
// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                 0x0400  // adresse de base des statuts generiques
#define AR_PRIVATE_STATUS_BASE_ADD         0x0800  // adresse de base des statuts specifiques ou privées
#define AR_FPA_TEMPERATURE                 0x002C  // adresse temperature

// adresse d'ecriture du signal declencant la lecture de temperature
#define AW_TEMP_STRUCT_CFG_ADD             0x200

// adresse d'ecriture du signal declencant la lecture d'un registre du roic
#define AW_ROIC_REG_STRUCT_CFG_ADD         0x300

// adresse d'écriture du régistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE                0xAE0   // adresse à lauquelle on dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE              0xAE4   // adresse à lauquelle on dit au VHD quel type de sortie de fpa e pilote en C est conçu pour.
#define AW_FPA_INPUT_SW_TYPE               0xAE8   // obligaoire pour les deteceteurs analogiques

#define AW_FPA_SCD_EN_SERDES_INIT_ADD       0xAA0 // Sert à retarder l'init de SERDES après le cooldown.
#define AW_FPA_SCD_EN_EXPTIME_CMD_ADD       0xAA4 // Active l'envoi de config de temps d'intégration par commande serielle
#define AW_FPA_SCD_EN_OP_CMD_ADD            0xAA8 // Active l'envoi de config operationnelle par commande serielle
#define AW_FPA_SCD_EN_FAILURE_RESP_MNGT_ADD 0xAAC // Active la gestion des erreurs retournés par le proxy
#define AW_FPA_SCD_EN_EXT_INT_CTRL_ADD      0xAB0 // Active le controle externe du temps d'intégration (non testé)

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                           0x16   // provient du fichier fpa_common_pkg.vhd. La valeur 0x16 est celle de FPA_ROIC_BLACKBIRD1920
#define OUTPUT_DIGITAL                     0x02   // provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL
#define INPUT_LVDS25                       0x01   // provient du fichier fpa_common_pkg.vhd. La valeur 0x01 est celle de LVDS25



// adresse d'écriture du régistre du reset des erreurs
#define AW_RESET_ERR                       0xAEC

 // adresse d'écriture du régistre du reset du module FPA
#define AW_CTRLED_RESET                    0xAF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de SCD)
#define TELOPS_DIAG_CNST                   0xD1  // mode diag constant (patron de test generé par la carte d'acquisition : tous les pixels à la même valeur) 
#define TELOPS_DIAG_DEGR                   0xD2  // mode diag dégradé linéaire(patron de test dégradé linéairement et généré par la carte d'acquisition).Requis en production
#define TELOPS_DIAG_DEGR_DYN               0xD3  // mode diag dégradé linéaire dynamique(patron de test dégradé linéairement et variant d'image en image et généré par la carte d'acquisition)  

#define VHD_INVALID_TEMP                   0xFFFFFFFF
#define VHD_PIPE_DLY_SEC                   500E-9F     // estimation des differerents delais accumulés par le vhd

#define DONOT_SEND_THIS_BYTE               0xFF        // ce code permet de ne pas envoyer le byte qui le contient

#define VHD_CLK_100M_RATE_HZ               100E+6F 

// INTG_DLY should be lesser than FR_DLY to avoid integration time inconsistency (see atlasdatasheet2.17ext section 9.2)
#define OP_CMD_IWR_FRAME_DLY_DEFAULT       2E-6F // "Frame read delay" parameter, in seconds
#define OP_CMD_IWR_INTG_DLY_DEFAULT        1E-6F  // "Integration delay" parameter, in seconds
#define OP_CMD_ITR_INTG_DLY_DEFAULT        1E-6F // "Integration delay" parameter, in seconds


// Les performances du détecteur ne suivent pas le modèle du frame rate calculator de SCD (ex : le détecteur est barré a 114Hz en plein fenêtre).
// En d'autre mots, le détecteur commence à ignorer des trigs pour des frame rates inférieurs aux prédictions du modèle du frame rate calculator de SCD (validées par des mesures).
// Ce facteur d'ajustement vient corriger le modèle pour être à l'intérieur des performances réelles observées.
#define MODEL_FR_CORR_FACTOR_ITR                  1.881815F
#define MODEL_FR_CORR_FACTOR_IWR                  1.880432F
#define MODEL_EXPTIME_CORR_FACTOR_IWR_US          300E-6F // in us

// La résolution maximale supportée par le vhdl est 44 (0.63us). (Sinon overflow).
#define FRAME_RESOLUTION_DEFAULT           7  // 0.1us


// "Photo-diode bias" parameter (and anti-blooming control)
static const uint8_t Scd_DiodeBiasValues_Vdet[] = {
      0x00,    // 1mV
      0x01,    // 20mV
      0x02,    // 40mV
      0x03,    // 60mV
      0x04,    // 80mV
      0x05,    // 100mV(default mode)
      0x06,    // 150mV
      0x07,    // 200mV
      0x08,    // 250mV
      0x09,    // 300mV
      0x0A,    // 350mV
      0x0B,    // 400mV
      0x0C,    // 450mV
      0x0D,    // 500mV
      0x0E,    // 600mV  FORBIDDEN!!! WILL DAMAGE THE ROIC !!!
      0x0F,    // 700mV  FORBIDDEN!!! WILL DAMAGE THE ROIC !!!

};
// WARNING !!! At room temperature, Vdet and Idet sould be kept at their minimum. The ROIC will be damage otherwise(see atlasdatasheet2.17ext.pdf p. 42).
#define SCD_VDET_BIAS_FORBIDDEN_THRESHOLD_IDX  14  //Vdet = 600mV or 700mV will damage de ROIC (see atlasdatasheet2.17ext.pdf p. 42)
#define SCD_VDET_BIAS_DEFAULT_IDX              3     // 60mV
#define SCD_VDET_BIAS_VALUES_NUM               (sizeof(Scd_DiodeBiasValues_Vdet) / sizeof(Scd_DiodeBiasValues_Vdet[0]))

static const uint8_t Scd_DiodeBiasValues_Idet[] = {
      0x00,    // 10pA
      0x01,    // 30pA
      0x02,    // 100pA
      0x03,    // 300pA
};
// WARNING !!! At room temperature, Vdet and Idet sould be kept at their minimum. The ROIC will be damage otherwise(see atlasdatasheet2.17ext.pdf p. 42).
#define SCD_IDET_BIAS_DEFAULT_IDX              1     // 30pA (default)
#define SCD_IDET_BIAS_VALUES_NUM               (sizeof(Scd_DiodeBiasValues_Idet) / sizeof(Scd_DiodeBiasValues_Idet[0]))

struct bb1920D_param_s
{					   
   float Fclock_MHz                          ;
   float Pixel_Reset                         ;
   float Pixel_Sample                        ;
   float Frame_read_Init_1                   ;
   float Frame_read_Init_2                   ;
   float Frame_read_Init_3_clk               ;
   float Pch1                                ;
   float Pch2                                ;
   float Ramp1_Start                         ;
   float Ramp1_Count                         ;
   float No_Ramp                             ;
   float ramp2_Start                         ;
   float ramp2_Count                         ;
   float Frame_read_Init_3                   ;
   float number_of_conversions               ;
   float number_of_Rows                      ;
   float number_of_Columns                   ;
   float Line_Readout                        ;
   float Frame_Read                          ;
   float number_of_Ref_Rows                  ;
   float number_of_pixel_per_clk_per_output  ;
   float pixel_control_time                  ;
   float Line_Conversion                     ;
   float int_time_offset_usec                ;
   float Frame_Initialization                ;
   float Frame_Time                          ;
   float fpa_intg_clk_rate_hz                ;
   float frame_period_min                    ;
   float fr_dly                              ;
   float intg_dly                            ;
   float x_to_next_fsync                     ;
   float exposure_time                       ;

};
typedef struct bb1920D_param_s bb1920D_param_t;

// Structure interne pour les commandes de Scd
struct Command_s             // 
{					   
   uint8_t  hder;
   uint16_t id;
   uint16_t dlen;
   uint16_t offs_add;
   uint8_t  data[(uint8_t)CMD_DATA_BYTES_NUM_MAX-1];
   uint16_t data_size;
   uint16_t total_len;
   uint16_t bram_sof_add;              // ajouté pour envoyer la commande à la bonne adresse dans la RAM
   // cheksum est calculé seulement lors de l'envoi 
};
typedef struct Command_s Command_t;

// Structure interne pour les packets de Scd
struct ScdPacketTx_s                      // 
{					   
   uint8_t   ScdPacketTotalBytesNum;
   uint16_t  bram_sof_add;
   uint8_t   ScdPacketArrayTx[(uint8_t)CMD_DATA_BYTES_NUM_MAX-1];
};
typedef struct ScdPacketTx_s ScdPacketTx_t;

// Statuts privés du module fpa
struct s_FpaPrivateStatus    
{  
   uint32_t fpa_diag_mode                             ;  
   uint32_t fpa_diag_type                             ;  
   uint32_t fpa_pwr_on                                ;  
   uint32_t fpa_acq_trig_mode                         ;
   uint32_t fpa_acq_trig_ctrl_dly                     ;
   uint32_t fpa_xtra_trig_mode                        ;
   uint32_t fpa_xtra_trig_ctrl_dly                    ;
   uint32_t fpa_trig_ctrl_timeout_dly                 ;
   uint32_t fpa_stretch_acq_trig                      ;
   uint32_t clk100_to_intclk_conv_numerator           ;
   uint32_t intclk_to_clk100_conv_numerator           ;
   uint32_t diag_ysize                                ;
   uint32_t diag_xsize_div_tapnum                     ;
   uint32_t diag_lovh_mclk_source                     ;
   uint32_t real_mode_active_pixel_dly                ;
   uint32_t aoi_data_sol_pos                          ;
   uint32_t aoi_data_eol_pos                          ;
   uint32_t aoi_flag1_sol_pos                         ;
   uint32_t aoi_flag1_eol_pos                         ;
   uint32_t aoi_flag2_sol_pos                         ;
   uint32_t aoi_flag2_eol_pos                         ;
   uint32_t op_xstart                                 ;
   uint32_t op_ystart                                 ;
   uint32_t op_xsize                                  ;
   uint32_t op_ysize                                  ;
   uint32_t op_frame_time                             ;
   uint32_t op_gain                                   ;
   uint32_t op_int_mode                               ;
   uint32_t op_det_vbias                              ;
   uint32_t op_det_ibias                              ;
   uint32_t op_binning                                ;
   uint32_t op_output_rate                            ;
   uint32_t op_cfg_num                                ;
   uint32_t int_cmd_id                                ;
   uint32_t int_cmd_dlen                              ;
   uint32_t int_cmd_offs                              ;
   uint32_t int_cmd_sof_add                           ;
   uint32_t int_cmd_eof_add                           ;
   uint32_t int_cmd_sof_add_m1                        ;
   uint32_t int_checksum_add                          ;
   uint32_t frame_dly_cst                             ;
   uint32_t int_dly_cst                               ;
   uint32_t op_cmd_id                                 ;
   uint32_t op_cmd_sof_add                            ;
   uint32_t op_cmd_eof_add                            ;
   uint32_t temp_cmd_id                               ;
   uint32_t temp_cmd_sof_add                          ;
   uint32_t temp_cmd_eof_add                          ;
   uint32_t outgoing_com_hder                         ;
   uint32_t incoming_com_hder                         ;
   uint32_t incoming_com_fail_id                      ;
   uint32_t incoming_com_ovh_len                      ;
   uint32_t fpa_serdes_lval_num                       ;
   uint32_t fpa_serdes_lval_len                       ;
   uint32_t int_clk_period_factor                     ;
   uint32_t fpa_exp_time_conv_denom_bit_pos           ;
   uint32_t frame_dly                                 ;                   
   uint32_t int_dly                                   ;
   uint32_t int_time                                  ;
   uint32_t int_clk_source_rate_hz                    ;
   uint32_t roic_read_reg                             ;
   };
typedef struct s_FpaPrivateStatus t_FpaPrivateStatus;
 
// Global variables
t_FpaStatus gStat;
t_FpaPrivateStatus gPrivateStat;
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
static uint32_t sw_init_done = 0;
static uint32_t sw_init_success = 0;
static float gIntg_dly = 0.0F;
static float gFr_dly = 0.0F;
static bool gFpaInit = true;
static bool gExtIntCtrl = false;
static uint8_t gRoicReg19 = 0xFF;

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_SpecificParams(bb1920D_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
void FPA_SendOperational_SerialCmd(const t_FpaIntf *ptrA);
void FPA_ReadTemperature_StructCmd(const t_FpaIntf *ptrA);
void FPA_ReadTemperature_SerialCmd(const t_FpaIntf *ptrA);
void FPA_BuildCmdPacket(ScdPacketTx_t *ptrE, const Command_t *ptrC);
void FPA_SendCmdPacket(ScdPacketTx_t *ptrE, const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FPA_ConvertSecondToFrameTimeResolution(float seconds);
void FPA_GetPrivateStatus(t_FpaPrivateStatus *PrivateStat, const t_FpaIntf *ptrA);
void FPA_SendRoicRead_SerialCmd(const t_FpaIntf *ptrA, uint8_t regAdd);
void FPA_SendRoicWrite_SerialCmd(const t_FpaIntf *ptrA, uint8_t regAdd, uint8_t regVal);
void FPA_SendRoicReg_StructCmd(const t_FpaIntf *ptrA);
void FPA_EnableSerdesInit(t_FpaIntf *ptrA, bool state); // pour retarder l'init de SERDES après le cooldown.
void FPA_EnableFailureResponseManagement(t_FpaIntf *ptrA, bool state); // pour activer/désactiver la gestion des erreurs retournés par le proxy.
void FPA_EnableSerialOpCMD(t_FpaIntf *ptrA, bool state); // pour désactiver l'envoi de commande operationelle
void FPA_EnableExternalIntegrationCtrl(t_FpaIntf *ptrA, bool state); // Active le controle externe du temps d'intégration (non testé)
void FPA_ReadRoicReg19(t_FpaIntf *ptrA);


/* Fonction d'initialization du module fpa */
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{ 
   sw_init_done = 0;
   sw_init_success = 0;
   
   FPA_Reset(ptrA);                                                         // on fait un reset du module FPA. 
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides SCD Detector   
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.

   FPA_EnableSerdesInit(ptrA, false);
   FPA_EnableSerialOpCMD(ptrA, false);
   FPA_EnableSerialExposureTimeCMD(ptrA, false); //pour éviter qu'une scène saturée fasse échouer l'initialisation des SERDES
   FPA_EnableFailureResponseManagement(ptrA, true); // Ce mode permet d'activer la gestion des "response failures" en provenance du détecteur.

   // Commande d'activation mode "External integration control" (voir section 2.3.3 du document atlasdatasheet2.17ext.pdf)
   // Ce mode "externe d'intégration" n'a pas été testé. On l'utilise pour l'instant la commande sérielle pour configurer le temps d'intégration.
   FPA_EnableExternalIntegrationCtrl(ptrA, false);

   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd y compris les statuts privés. Il faut que les status privés soient là avant qu'on appelle le FPA_SendConfigGC. 
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoyée au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
   
   sw_init_done = 1;                                                        // le sw est initialisé. il ne restera que le vhd qui doit s'initialiser
   sw_init_success = 1;
}


/* Cette machine d'état permet de */
bool FPA_Specific_Init_SM(t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs, bool run)
{
    static fpaInitState_t fpaInitState = IDLE;
    static bool proxy_init_status = false;
    static uint64_t tic_delay;
    extern bool gFpaInit;
    extern uint8_t gRoicReg19;

    switch (fpaInitState)
    {
       case IDLE:
          proxy_init_status = false;
          if(run == true)
             fpaInitState = READ_ROIC_REG19;
          break;

       case READ_ROIC_REG19:
             GETTIME(&tic_delay);
             FPA_ReadRoicReg19(ptrA); // Doit être fait lorsque le cooler est en régime permanent, sinon le roic ne retourne pas la bonne valeur.
             fpaInitState = WAIT_RESPONSE;
          break;

       case WAIT_RESPONSE:
          if(elapsed_time_us(tic_delay) > SEND_CONFIG_DELAY)
          {
             if(gRoicReg19 == 0xFF)
             {
                fpaInitState = READ_ROIC_REG19;
             }
             else
             {
                GETTIME(&tic_delay);
                FPA_SendConfigGC(ptrA, pGCRegs);
                fpaInitState = SEND_1ST_CFG;
             }
          }
          break;

       case SEND_1ST_CFG:
          if(elapsed_time_us(tic_delay) > SEND_CONFIG_DELAY)
          {
             GETTIME(&tic_delay);
             FPA_EnableSerialOpCMD(ptrA, true);
             fpaInitState = START_SERDES_INITIALIZATION;
          }
          break;

       case START_SERDES_INITIALIZATION:
          if(elapsed_time_us(tic_delay) > SEND_CONFIG_DELAY)
          {
             FPA_EnableSerdesInit(ptrA, true);
             proxy_init_status = true;
             fpaInitState = IDLE;
          }
          break;
    }

    gFpaInit = !proxy_init_status;
    return proxy_init_status;
}

/* Fonction principale de configuration du module fpa. */
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs)
{
   bb1920D_param_t hh;
   float frame_period, fpaAcquisitionFrameRate;
   uint8_t det_vbias_idx;
   static uint8_t cfg_num = 0;
   extern int32_t gFpaDebugRegA, gFpaDebugRegB, gFpaDebugRegC, gFpaDebugRegE, gFpaDebugRegF, gFpaDebugRegG, gFpaDebugRegH;
   extern uint8_t gFpaScdDiodeBiasEnum;

   FPA_GetPrivateStatus(&gPrivateStat, ptrA);

   //-----------------------------------------                                           
   // Common
   //-----------------------------------------   
   // diag mode and diagType
   ptrA->fpa_diag_mode = 0;                              // par defaut
   ptrA->fpa_diag_type = 0;                              // par defaut   
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade) {          // mode diagnostique degradé lineaire
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR;
   }   
   else if (pGCRegs->TestImageSelector == TIS_TelopsConstantValue1) {     // mode diagnostique avec valeur constante
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_CNST;
   }
   else if (pGCRegs->TestImageSelector == TIS_TelopsDynamicShade) {
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR_DYN;   
   }
   
   /* Contrairement à ce que dit la doc le paramètre vid_if_bit_en est write only...
    * Il est toujours à '1' lors de sa lecture et ce peut importe ce qu'on y écrit.
    * On utilise ce paramètre pour configurer le module SERDES afin qu'il se base sur le bon "ctrl bit" pour générer le fval.
    * Si vid_if_bit_en = 1,  il faut se référer à la figure 13 du document atlasdatasheet2.17ext.pdf (ctrl bits = 0x3 en frame read idle)
    * Si vid_if_bit_en = 0,  il faut se référer à la figure 3 de l'appendix F du document DXU_0003_1.pdf (ctrl bits = 0x0 en frame read idle)
   */
   ptrA->vid_if_bit_en  = 1;

   ptrA->fpa_pwr_on     = 1;     // allumage du détecteur, le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   ptrA->op_binning     = 0;     // binning ou non
   ptrA->op_output_rate = 3;     // vitesse de sortie : full rate (2 simultaneous lines)
   ptrA->op_frm_res     = FRAME_RESOLUTION_DEFAULT;  // valeur minimale est de 2 et la résolution maximale supportée par le vhdl est 44 (0.63us).

   
   // Frame time calculation : define the maximum trig frequency allowed by the proxy for this set of operational parameters.
   fpaAcquisitionFrameRate    = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin); //on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur
   frame_period               = 1.0F/MAX(SCD_MIN_OPER_FPS, fpaAcquisitionFrameRate);

   if ((pGCRegs->IntegrationMode == IM_IntegrateThenRead) || (ptrA->fpa_diag_mode == 1)) {
      if(gFpaDebugRegH != 0)
         gIntg_dly = (float)gFpaDebugRegH/1E+6F;
      else
         gIntg_dly =  OP_CMD_ITR_INTG_DLY_DEFAULT;

      FPA_SpecificParams(&hh, 0.0F, pGCRegs);

      if(gFpaDebugRegG != 0){
         gFr_dly = (float)gFpaDebugRegG/1E+6F;
      }
      else{
         // gFr_dly doit toujours être plus grand que : gIntg_dly + exposure_time
         gFr_dly = frame_period - (hh.Frame_Time + hh.x_to_next_fsync);
      }
      ptrA->op_int_mode = ITR_MODE;
      ptrA->op_gain = (uint32_t)UNIFIED_CAP_LOW_GAIN;
   }
   else {

      if(gFpaDebugRegH != 0)
         gIntg_dly = (float)gFpaDebugRegH/1E+6F;
      else
         gIntg_dly = OP_CMD_IWR_INTG_DLY_DEFAULT;

      if(gFpaDebugRegG != 0)
         gFr_dly = (float)gFpaDebugRegG/1E+6F;
      else
         gFr_dly = OP_CMD_IWR_FRAME_DLY_DEFAULT;

      FPA_SpecificParams(&hh, 0.0F, pGCRegs);

      ptrA->op_int_mode = IWR_MODE;
      ptrA->op_gain = (uint32_t)LOW_GAIN;
   }

   ptrA->frame_dly_cst   = (uint32_t)FPA_ConvertSecondToFrameTimeResolution(gFr_dly);
   ptrA->int_dly_cst     = (uint32_t)FPA_ConvertSecondToFrameTimeResolution(gIntg_dly);
   ptrA->op_frame_time   = (uint32_t)FPA_ConvertSecondToFrameTimeResolution(frame_period);
   ptrA->op_frame_time   = ptrA->op_frame_time - 3; // La période réelle configuré dans le ROIC doit être légèrement inférieure à celle des trigs générés.

   // config du contrôleur pour les acq_trigs (il est sur l'horloge de 100MHz)
   ptrA->fpa_acq_trig_mode      = (uint32_t)MODE_TRIG_START_TO_TRIG_START;
   ptrA->fpa_acq_trig_ctrl_dly  = (uint32_t)((frame_period - (gIntg_dly + VHD_PIPE_DLY_SEC))*(float)VHD_CLK_100M_RATE_HZ);

   // config du contrôleur pour les xtra trigs (il est sur l'horloge de 100MHz)
   ptrA->fpa_xtra_trig_mode        = (uint32_t)MODE_TRIG_START_TO_TRIG_START;
   ptrA->fpa_xtra_trig_ctrl_dly    = (uint32_t)((float)VHD_CLK_100M_RATE_HZ / (float)XTRA_TRIG_FREQ_MAX_HZ);
   ptrA->fpa_trig_ctrl_timeout_dly = (uint32_t)((float)ptrA->fpa_xtra_trig_ctrl_dly);
  
   ptrA->clk100_to_intclk_conv_numerator = (uint32_t)roundf(hh.fpa_intg_clk_rate_hz * exp2f(gPrivateStat.fpa_exp_time_conv_denom_bit_pos)/(float)VHD_CLK_100M_RATE_HZ);
   ptrA->intclk_to_clk100_conv_numerator = (uint32_t)roundf((float)VHD_CLK_100M_RATE_HZ * exp2f(gPrivateStat.fpa_exp_time_conv_denom_bit_pos)/hh.fpa_intg_clk_rate_hz);
   
   // Élargit le pulse de trig au besoin
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
   ptrA->fpa_intf_data_source = DATA_SOURCE_OUTSIDE_FPGA;
   if (ptrA->fpa_diag_mode == 1){
      ptrA->fpa_intf_data_source = DATA_SOURCE_INSIDE_FPGA;     // fpa_intf_data_source n'est utilisé/regardé par le vhd que lorsque fpa_diag_mode = 1
   }
   
   //-----------------------------------------
   // aoi
   //-----------------------------------------
   ptrA->aoi_xsize                 = (uint32_t)pGCRegs->Width;     
   ptrA->aoi_ysize                 = (uint32_t)pGCRegs->Height; 
   ptrA->aoi_data_sol_pos          = (uint32_t)pGCRegs->OffsetX/4 + 1;    // Cropping: + 1 car le generateur de position dans le vhd a pour valeur d'origine 1. Et division par 4 car le bus dudit generateur est de largeur 4 pix
   ptrA->aoi_data_eol_pos          =  ptrA->aoi_data_sol_pos - 1 + (uint32_t)pGCRegs->Width/4; // En effet,  (ptrA->aoi_data_eol_pos - ptrA->aoi_data_sol_pos) + 1  = pGCRegs->Width/4 
   ptrA->aoi_flag1_sol_pos         =  1;
   ptrA->aoi_flag1_eol_pos         = (uint32_t)pGCRegs->Width/4 - 1;      // ainsi, on considère la premiere partie des flags qui vont du premier pixel (SOL) jusqu'à l'avant-dernier pixel de la ligne.
   ptrA->aoi_flag2_sol_pos         = (uint32_t)FPA_WIDTH_MAX/4;           // quand à la seconde partie des flags, elle se resume au EOL qui se retrouve toujours à la fin de la ligne complète (pleine ligne)
   ptrA->aoi_flag2_eol_pos         = (uint32_t)FPA_WIDTH_MAX/4;
      
   //  parametres de la commande opérationnelle
   ptrA->op_xstart  = 0;    
   ptrA->op_ystart  = pGCRegs->OffsetY/4;      // parametre strow à la page p.20 de atlascmd_datasheet2.17   
   
   if (ptrA->op_binning == 1)
      ptrA->op_ystart  = pGCRegs->OffsetY/8;
   
   ptrA->op_xsize  = (uint32_t)FPA_WIDTH_MAX;     
   ptrA->op_ysize  = pGCRegs->Height/2;        // parametre wsize à la page p.20 de atlascmd_datasheet2.17   

   // polarisation et saturation 
   if (gFpaScdDiodeBiasEnum >= SCD_IDET_BIAS_VALUES_NUM)      // Photo-diode bias (Idet)
       gFpaScdDiodeBiasEnum    = SCD_IDET_BIAS_DEFAULT_IDX;    // Corrige une valeur invalide
   ptrA->op_det_ibias     = Scd_DiodeBiasValues_Idet[gFpaScdDiodeBiasEnum];

   det_vbias_idx = (uint8_t)gFpaDebugRegC;
   if (det_vbias_idx == 0){// Photo-diode bias (Vdet)
      ptrA->op_det_vbias     = (uint32_t)SCD_VDET_BIAS_DEFAULT_IDX;
   }
   else{
      if (det_vbias_idx >= SCD_VDET_BIAS_FORBIDDEN_THRESHOLD_IDX)
         ptrA->op_det_vbias = SCD_VDET_BIAS_DEFAULT_IDX;
      else
         ptrA->op_det_vbias = Scd_DiodeBiasValues_Vdet[det_vbias_idx];
   }
      
   if(gFpaDebugRegE != 0 && gFpaDebugRegE <= 0xD)
      ptrA->op_mtx_int_low = (uint32_t)gFpaDebugRegE;
   else
      ptrA->op_mtx_int_low = 0xB; // default value

   if(ptrA->op_mtx_int_low > 0xD) //Protection, car 0xE et 0xF sont des valeurs interdites
      ptrA->op_mtx_int_low = 0xD;

   //Test pattern Telops
   ptrA->diag_ysize = ptrA->aoi_ysize/2;                                          // pour tenir compte de la seconde ligne qui sort aussi au même moment
   ptrA->diag_xsize_div_tapnum           = (uint32_t)FPA_WIDTH_MAX/4 ;            // toujours diviser par 4 même si on a 8 pixels/clk
   ptrA->diag_lovh_mclk_source           = 287;                                   // à reviser si necessaire
   ptrA->real_mode_active_pixel_dly      = 2;                                     // valeur arbitraire utilisée par le système en mode diag
   ptrA->outgoing_com_ovh_len            = 5;          // pour la cmd sortante, nombre de bytes avant le champ d'offset

   // Test pattern manufacturier

   ptrA->op_frm_dat   = 0;                     // parametre frm_dat à la page p.21 de atlascmd_datasheet2.17
   if ((pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage1) ||
         (pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage2) ||
         (pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage3) ||
         (pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage))
      ptrA->op_frm_dat = (uint32_t)gFpaDebugRegB;

   // cfg_num 
   if (cfg_num == 255)
      cfg_num = 0;
   cfg_num++;
   ptrA->op_cfg_num = (uint32_t)cfg_num;
   
   //-----------------------------------------
   // int : cmd structurelle + serielle
   //-----------------------------------------   
   ptrA->int_cmd_id                      = 0x8500;           // est utilisé par le vhd pour bâtir la cmd serielle de l'integration
   ptrA->int_cmd_data_size               = 9;                // la taille de la partie cmd_data de la commande. L'adresse d'offset est exclue
   ptrA->int_cmd_dlen                    = ptrA->int_cmd_data_size + 1;            // +1 pour tenir compte du roic_cmd_offs_add
   ptrA->int_cmd_offs                    = 8;                // voir p.46 de atlascmd_datasheet 2.17
   ptrA->int_cmd_sof_add                 = (uint32_t)AW_SERIAL_INT_CMD_RAM_ADD;
   ptrA->int_cmd_eof_add                 = ptrA->int_cmd_sof_add + ptrA->outgoing_com_ovh_len + ptrA->int_cmd_dlen;
   ptrA->int_cmd_sof_add_m1              = ptrA->int_cmd_sof_add - 1;
   ptrA->int_checksum_add                = ptrA->int_cmd_eof_add;

   //-----------------------------------------
   // op : cmd serielle
   //-----------------------------------------
   ptrA->op_cmd_id                       = 0x8500;                          // n'est pas utilisé par le vhd mais par le diverC
   ptrA->op_cmd_data_size                = 23;                              // taille de la partie donnée exclusivement
   ptrA->op_cmd_dlen                     = ptrA->op_cmd_data_size + 1;      // taille de la partie donnée + taille de l'adresse d'offset
   ptrA->op_cmd_sof_add                  = (uint32_t)AW_SERIAL_OP_CMD_RAM_ADD;
   ptrA->op_cmd_eof_add                  = ptrA->op_cmd_sof_add + ptrA->outgoing_com_ovh_len + ptrA->op_cmd_dlen;

   //-----------------------------------------
   // roic read : cmd serielle
   //-----------------------------------------
   ptrA->roic_reg_cmd_id                    = 0x8501;                             // n'est pas utilisé par le vhd mais par le diverC
   ptrA->roic_reg_cmd_data_size             = 1;                                  // taille de la partie donnée exclusivement
   ptrA->roic_reg_cmd_dlen                  = ptrA->roic_reg_cmd_data_size + 1;   // taille de la partie donnée + taille de l'adresse d'offset
   ptrA->roic_reg_cmd_sof_add               = (uint32_t)AW_SERIAL_ROIC_REG_CMD_RAM_ADD;
   ptrA->roic_reg_cmd_eof_add               = ptrA->roic_reg_cmd_sof_add + ptrA->outgoing_com_ovh_len + ptrA->roic_reg_cmd_dlen;   // dlen = 23 + 1

   //-----------------------------------------
   // temp : cmd serielle
   //-----------------------------------------

   if (gFpaDebugRegF == 0) // Normal temp cmd
   {
      ptrA->temp_cmd_id                     = 0x8503;                         // n'est pas utilisé par le vhd mais par le diverC
      ptrA->temp_cmd_data_size              = 0;
      ptrA->temp_cmd_dlen                   = ptrA->temp_cmd_data_size + 2;
   }
   else // Overide temp cmd
   {
      ptrA->temp_cmd_id                     = 0x8500 + (uint32_t)gFpaDebugRegA;                         // n'est pas utilisé par le vhd mais par le diverC

      if (gFpaDebugRegA == 2) //  proxy write
      {
         ptrA->temp_cmd_data_size              = 1;
         ptrA->temp_cmd_dlen                   = ptrA->temp_cmd_data_size + 2;
      }
      else if(gFpaDebugRegA == 3) //  proxy read
      {
         ptrA->temp_cmd_data_size              = 0;
         ptrA->temp_cmd_dlen                   = ptrA->temp_cmd_data_size + 2;
      }
      else//  detector read/write
      {
         ptrA->temp_cmd_data_size              = 1;
         ptrA->temp_cmd_dlen                   = ptrA->temp_cmd_data_size + 1;
      }
   }

   ptrA->temp_cmd_sof_add                = (uint32_t)AW_SERIAL_TEMP_CMD_RAM_ADD;
   ptrA->temp_cmd_eof_add                = ptrA->temp_cmd_sof_add + ptrA->outgoing_com_ovh_len + ptrA->temp_cmd_dlen;     // voir la cmd 0x8503 pour comprendre
   
   //-----------------------------------------
   // misc
   //----------------------------------------- 
   ptrA->outgoing_com_hder               = 0xAA;
   ptrA->incoming_com_hder               = 0x55;
   ptrA->incoming_com_fail_id            = 0xFFFF;
   ptrA->incoming_com_ovh_len            = 6;

   // Configuration des SERDES (independante du nombre du canaux)
   ptrA->fpa_serdes_lval_num = ptrA->aoi_ysize;
      ptrA->fpa_serdes_lval_num >>= 1;
   ptrA->fpa_serdes_lval_len = (uint32_t)FPA_WIDTH_MAX / 4; // toujours diviser par 4 même si on a 8 pixels/clk (en réalité on a 2 lignes simultannés à 4 pixels/clk).

   ptrA->int_clk_period_factor           = MAX(gPrivateStat.int_clk_source_rate_hz/(uint32_t)hh.fpa_intg_clk_rate_hz, 1);
   ptrA->int_time_offset                 = (int32_t)(hh.fpa_intg_clk_rate_hz * hh.int_time_offset_usec*1e-6F);

   FPA_SendOperational_SerialCmd(ptrA);            // on envoie la partie serielle de la commande operationnelle (elle est stockée dans une autre partie de la RAM en vhd)
   WriteStruct(ptrA);                              // on envoie la partie structurelle
}

/* Cette fonction calcule les timings spécifiques au BB1920.
 * Le modèle est tiré du frame rate calculator fournit par SCD.
 */
void FPA_SpecificParams(bb1920D_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{

   extern int32_t gFpaExposureTimeOffset;

   ptrH->Fclock_MHz                         = (float)FPA_MCLK_RATE_HZ/1E+6;
   ptrH->Pixel_Reset                        =  140.0F; // in us
   ptrH->Pixel_Sample                       =  14.0F;  // in us
   ptrH->Frame_read_Init_1                  =  28.0F;  // in us
   ptrH->Frame_read_Init_2                  =  14.0F;  // in us
   ptrH->Frame_read_Init_3_clk              =  10.0F;  // in clks
   ptrH->Pch1                               =  55.0F;  // in clks
   ptrH->Pch2                               =  50.0F;  // in clks
   ptrH->Ramp1_Start                        =  40.0F;  // in clks
   ptrH->Ramp1_Count                        =  255.0F; // in clks
   ptrH->No_Ramp                            =  70.0F;  // in clks
   ptrH->ramp2_Start                        =  30.0F;  // in clks
   ptrH->ramp2_Count                        =  190.0F; // in clks
   ptrH->fpa_intg_clk_rate_hz               =  (float)FPA_MCLK_RATE_HZ/(float)FRAME_RESOLUTION_DEFAULT;
   ptrH->int_time_offset_usec               = ((float)gFpaExposureTimeOffset /(float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ)* 1e6F;
   ptrH->exposure_time                      = exposureTime_usec*1E-6F;
   ptrH->Frame_read_Init_3                  = ptrH->Frame_read_Init_3_clk/ptrH->Fclock_MHz;
   ptrH->number_of_Columns                  = (float)FPA_WIDTH_MAX;
   ptrH->number_of_Rows                     = (float)pGCRegs->Height;
   ptrH->number_of_Ref_Rows                 = 0.0F;
   ptrH->number_of_pixel_per_clk_per_output = 4.0f; // Full rate par défaut

   //if (ptrA->op_binning == 0)
      ptrH->number_of_conversions  =  floorf(ptrH->number_of_Rows / 2.0F) +  2.0F  +  ptrH->number_of_Ref_Rows / 2.0F;
   // else
   //   ptrH->number_of_conversions  =  floorf(ptrH->number_of_Rows / 8.0F) +  2.0F  +  ptrH->number_of_Ref_Rows / 4.0F;

   ptrH->Line_Readout = (2.0F * ptrH->number_of_Columns + 18.0F) /2.0F / ptrH->number_of_pixel_per_clk_per_output / ptrH->Fclock_MHz;
   ptrH->Line_Conversion =  (ptrH->Pch1 + ptrH->Pch2 + ptrH->Ramp1_Start + ptrH->Ramp1_Count + ptrH->No_Ramp + ptrH->ramp2_Start + ptrH->ramp2_Count) / ptrH->Fclock_MHz;
   ptrH->Frame_Read      =  ptrH->number_of_conversions *  MAX(ptrH->Line_Readout, ptrH->Line_Conversion);

   ptrH->Frame_Initialization  = ptrH->Frame_read_Init_1 + ptrH->Frame_read_Init_2 + ptrH->Frame_read_Init_3;
   ptrH->pixel_control_time    = 2* ptrH->Pixel_Reset + ptrH->Pixel_Sample + 10.0F;

   ptrH->fr_dly                = gFr_dly;                                                     // in second

   if (pGCRegs->IntegrationMode == IM_IntegrateThenRead){
      ptrH->intg_dly                           = gIntg_dly;                // in second
      ptrH->Frame_Time = ((ptrH->pixel_control_time + ptrH->Frame_Initialization  + ptrH->Frame_Read)/1E6F)*MODEL_FR_CORR_FACTOR_ITR; // en seconde
      ptrH->x_to_next_fsync  = 0.0F; // Delay between the end of readout (or integration) and the next fsync (in second)
      ptrH->frame_period_min = ptrH->intg_dly + ptrH->exposure_time + ptrH->Frame_Time + ptrH->x_to_next_fsync;
   }
   else{
      ptrH->intg_dly         = gIntg_dly + MODEL_EXPTIME_CORR_FACTOR_IWR_US;                // in second
      ptrH->Frame_Time       = ((ptrH->pixel_control_time + ptrH->Frame_Initialization  + ptrH->Frame_Read)/1E6F)*MODEL_FR_CORR_FACTOR_IWR; // en seconde
      ptrH->x_to_next_fsync  = 0.0F; // Delay between the end of readout (or integration) and the next fsync (in second)
      ptrH->frame_period_min = MAX(ptrH->fr_dly + ptrH->Frame_Time, ptrH->intg_dly + ptrH->exposure_time) + ptrH->x_to_next_fsync;
   }
}

/* Cette fonction calcule le frame rate maximal associé à une configuration donnée. */
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float fr_max;
   bb1920D_param_t hh;

   FPA_SpecificParams(&hh, (float)pGCRegs->ExposureTime, pGCRegs);
   fr_max = 1.0F / hh.frame_period_min;
   fr_max = fr_max * (1.0F - gFpaPeriodMinMargin);
   fr_max = floorMultiple(fr_max, 0.01);

   return fr_max;
}

/* Cette fonction calcule le exposure time associé à une configuration donnée. */
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   float maxExposure_us, periodMinWithNullExposure;
   float Ta = 0.0F;
   float operatingPeriod, fpaAcquisitionFrameRate;
   bb1920D_param_t hh;

   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin); // On enleve la marge artificielle pour retrouver la vitesse reelle du detecteur
   FPA_SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition était nulle
   periodMinWithNullExposure = hh.frame_period_min;
   operatingPeriod = 1.0F / MAX(SCD_MIN_OPER_FPS, fpaAcquisitionFrameRate); // periode avec le frame rate actuel. Doit tenir compte de la contrainte d'opération du détecteur
   maxExposure_us = (operatingPeriod - periodMinWithNullExposure)*1e6F;

   if (pGCRegs->IntegrationMode == IM_IntegrateWhileRead){
      Ta = ((hh.fr_dly + hh.Frame_Time) - hh.intg_dly);
      if (Ta > 0)
         maxExposure_us = maxExposure_us + Ta*1E6F;
   }

   maxExposure_us = maxExposure_us/1.001F;    // cette division tient du fait que dans la formule de T0, le temps d'exposition intervient avec un facteur 1 + 0.1/100
   maxExposure_us = floorMultiple(maxExposure_us, 0.1); // Round exposure time
   maxExposure_us = MIN(MAX(maxExposure_us, pGCRegs->ExposureTimeMin),FPA_MAX_EXPOSURE);
   return maxExposure_us;
}

/* Fonction permettant de récupérer et convertir la température du fpa */
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{

   extern int32_t gFpaDebugRegF;
   float diode_voltage;
   float temperature = 0.0F;

   if (gFpaDebugRegF == 0) // Normal temp cmd
   {
      FPA_GetStatus(&gStat, ptrA);
      FPA_ReadTemperature_SerialCmd(ptrA);      // envoi la commande serielle
      FPA_ReadTemperature_StructCmd(ptrA);      // envoi un interrupt au contrôleur du hw driver

      if ((uint32_t)(gStat.fpa_temp_raw & 0x0000FFFF) == (uint32_t)VHD_INVALID_TEMP){
         return FPA_INVALID_TEMP;
      }
      else
      {
         diode_voltage = (float)(gStat.fpa_temp_raw & 0x0000FFFF) * 0.000125F;

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
            temperature  =  1655.2F * powf(diode_voltage,5);
            temperature -=  6961.7F * powf(diode_voltage,4);
            temperature += 11235.0F * powf(diode_voltage,3);
            temperature -=  8844.0F * powf(diode_voltage,2);
            temperature += (2941.5F * diode_voltage) + 77.3F;
         }
           return K_TO_CC(temperature); // Centi celsius
      }
   }
   else
   {
      FPA_ReadTemperature_SerialCmd(ptrA);      // envoi la commande serielle
      FPA_ReadTemperature_StructCmd(ptrA);      // envoi un interrupt au contrôleur du hw driver
      return FPA_COOLER_TEMP_THRES;
   }
}

/* Envoi de la partie structurale d'une commande pour lire la température du fpa */
void FPA_ReadTemperature_StructCmd(const t_FpaIntf *ptrA)
{
   static uint8_t tempReadNum = 0;

   if (tempReadNum == 255)  // protection contre depassement
      tempReadNum = 0;

   tempReadNum++;

   // envoie de la cfg structurale
   AXI4L_write32((uint32_t)tempReadNum, ptrA->ADD + AW_TEMP_STRUCT_CFG_ADD);
   AXI4L_write32(0, ptrA->ADD + AW_TEMP_STRUCT_CFG_ADD + 4);
}

/* Envoi de la partie sérielle d'une commande pour lire la température du fpa */
void FPA_ReadTemperature_SerialCmd(const t_FpaIntf *ptrA)
{
   Command_t Cmd;
   ScdPacketTx_t ScdPacketTx;
   extern int32_t gFpaDebugRegA, gFpaDebugRegB, gFpaDebugRegD, gFpaDebugRegF ;

   // on bâtit la commande
   Cmd.hder           =  ptrA->outgoing_com_hder;
   Cmd.id             =  ptrA->temp_cmd_id;
   Cmd.dlen           =  ptrA->temp_cmd_dlen;

   if(gFpaDebugRegF == 0)
   {
      Cmd.offs_add       =  0;
   }
   else
   {
      if (gFpaDebugRegA > 1)
         Cmd.offs_add       =  (uint16_t)gFpaDebugRegD;
      else
         Cmd.offs_add       =  (((uint8_t)DONOT_SEND_THIS_BYTE & 0xFF) << 8) + (uint16_t)gFpaDebugRegD;
      Cmd.data[0]        = (uint8_t)gFpaDebugRegB;
   }

   Cmd.data_size      =  ptrA->temp_cmd_data_size;
   Cmd.total_len      =  ptrA->outgoing_com_ovh_len + ptrA->temp_cmd_dlen + 1;     // +1 pour le checksum
   Cmd.bram_sof_add   =  ptrA->temp_cmd_sof_add;

   FPA_BuildCmdPacket(&ScdPacketTx, &Cmd); // on batit les packets de bytes
   FPA_SendCmdPacket(&ScdPacketTx, ptrA); // on envoit les packets
}

/* Cette fonction envoi la partie sérielle de la commande operationnelle */
void FPA_SendOperational_SerialCmd(const t_FpaIntf *ptrA)
{
   Command_t Cmd;
   ScdPacketTx_t ScdPacketTx;

   uint8_t cgf_updt_en   = 1;
   uint8_t frame_en      = 1; // 1 : Enable frame sequence operation (system control)
   uint8_t vdir          = 1; // 1 : Up: Readout from 1'st row up (decrement)
   uint8_t hdir          = 0; // 0 : Left to right row readout;
   uint8_t frm_sync_mod  = 0; // 0 : INTG_DLY start is referred at FSYNC
   uint16_t strow        = 0; // Start address for row readout (0 to 767)
   uint16_t wsize        = 0; // Vertical window size in 2-row resolution when BINN=0
   uint8_t slv_adr       = 0x18;  // valeur par defaut
   uint32_t int_time     = 0;
   uint32_t min_int_time = 0;
   uint32_t max_int_time = 0;
   uint8_t reg19Val;
   uint8_t reg19Val_default  = 0xb1;
   extern bool gExtIntCtrl;
   extern uint8_t gRoicReg19;
   min_int_time = (uint32_t)FPA_ConvertSecondToFrameTimeResolution(FPA_MIN_EXPOSURE/1E6F);
   max_int_time = (uint32_t)FPA_ConvertSecondToFrameTimeResolution(FPA_MAX_EXPOSURE/1E6F);

   if(gExtIntCtrl)
   {
      int_time = 0; // Activate external integration mode (see atlasdatasheet2.17 section 2.3.3)
   }
   else if (GC_FWSynchronouslyRotatingModeIsActive || gFpaInit)
   {
      int_time = min_int_time;
   }
   else{
      int_time = MIN(MAX(gPrivateStat.int_time, min_int_time), max_int_time);  // protection
   }


   if(gRoicReg19 == 0xFF)
      reg19Val  = ((ptrA->op_mtx_int_low & 0x0F) << 4) + (reg19Val_default & 0x0F);
   else
      reg19Val  = ((ptrA->op_mtx_int_low & 0x0F) << 4) + (gRoicReg19 & 0x0F);

   if(ptrA->op_binning == 0)
   {
      strow = (uint16_t)((ptrA->op_ystart >> 1) & 0x000003FF);
      wsize = ptrA->op_ysize;
   }
   else
   {
      if(ptrA->op_output_rate == 3)
         strow = (uint16_t)((ptrA->op_ystart >> 3) & 0x000003FF);
      else
         strow = (uint16_t)((ptrA->op_ystart >> 2) & 0x000003FF);

      wsize = (uint16_t)((ptrA->op_ysize >> 1) & 0x000003FF);
   }

   // on bâtit la commande
   Cmd.hder           =  ptrA->outgoing_com_hder;
   Cmd.id             =  ptrA->op_cmd_id;
   Cmd.dlen           =  ptrA->op_cmd_dlen;
   Cmd.offs_add       = (((uint8_t)DONOT_SEND_THIS_BYTE & 0xFF) << 8) + 0; // on evite ainsi l'envoi du MSB de offs_add                                  
   Cmd.data[0]        = ((cgf_updt_en & 0x01) << 7) + (frame_en & 0x01) ;  
   Cmd.data[1]        =   strow & 0xFF;
   Cmd.data[2]        = ((ptrA->op_binning & 0x01) << 7) + ((vdir & 0x01) << 6) + ((hdir & 0x01) << 5) + ((strow & 0x0300) >> 8);
   Cmd.data[3]        =   wsize & 0xFF;
   Cmd.data[4]        = ((wsize & 0x0300) >> 8);
   Cmd.data[5]        =   ptrA->op_frame_time & 0xFF;
   Cmd.data[6]        = ((ptrA->op_frame_time & 0xFF00) >> 8);
   Cmd.data[7]        = ((frm_sync_mod & 0x01) << 7) + ((ptrA->op_gain & 0x07) << 4) + ((ptrA->op_frame_time & 0xF0000) >> 16);
   Cmd.data[8]        =   ptrA->frame_dly_cst & 0xFF;
   Cmd.data[9]        = ((ptrA->frame_dly_cst & 0xFF00) >> 8);
   Cmd.data[10]       = ((ptrA->frame_dly_cst & 0xF0000) >> 16);
   Cmd.data[11]       =   ptrA->int_dly_cst & 0xFF;
   Cmd.data[12]       = ((ptrA->int_dly_cst & 0xFF00) >> 8);
   Cmd.data[13]       = ((ptrA->int_dly_cst & 0xF0000) >> 16);
   Cmd.data[14]       =	  int_time & 0xFF;
   Cmd.data[15]       = ((int_time & 0xFF00) >> 8);
   Cmd.data[16]       = ((int_time & 0xF0000) >> 16);
   Cmd.data[17]       =  ((uint8_t)ptrA->op_output_rate & 0x03);
   Cmd.data[18]       = ((ptrA->op_det_vbias & 0x0F) << 4) + ((ptrA->op_det_ibias & 0x03) << 2);
   Cmd.data[19]        = (reg19Val & 0xFF);
   Cmd.data[20]        = (slv_adr & 0x7F);
   Cmd.data[21]        =  ptrA->op_frm_res & 0x7F;
   Cmd.data[22]        = ((ptrA->op_frm_dat & 0x03) << 6) +  ((uint8_t)ptrA->vid_if_bit_en & 0x01);

   Cmd.data_size      =  ptrA->op_cmd_data_size;
   Cmd.total_len      =  ptrA->outgoing_com_ovh_len + ptrA->op_cmd_dlen + 1;     // +1 pour le checksum
   Cmd.bram_sof_add   =  ptrA->op_cmd_sof_add;
   
   FPA_BuildCmdPacket(&ScdPacketTx, &Cmd); // on batit les packets de bytes
   FPA_SendCmdPacket(&ScdPacketTx, ptrA); // on envoit les packets
}

// pour permettre le démarrage de la procédure d'initialisation des SERDES
void  FPA_EnableSerdesInit(t_FpaIntf *ptrA, bool state)
{
  uint8_t ii;
  for(ii = 0; ii <= 10 ; ii++)
  {
     AXI4L_write32((uint32_t)state, ptrA->ADD + AW_FPA_SCD_EN_SERDES_INIT_ADD);
  }
}

/* Cette fonction active/désactive la gestion des erreurs retournés par le proxy (debug). */
void FPA_EnableFailureResponseManagement(t_FpaIntf *ptrA, bool state)
{
   uint8_t ii;
   for(ii = 0; ii <= 10 ; ii++)
   {
      AXI4L_write32((uint32_t)state, ptrA->ADD + AW_FPA_SCD_EN_FAILURE_RESP_MNGT_ADD);
   }
}

/* Cette fonction active/désactive l'envoi sérielle de toute commande de changement de temps d'intégration
 *  au détecteur */
void FPA_EnableSerialExposureTimeCMD(t_FpaIntf *ptrA, bool state)
{
   uint8_t ii;
   for(ii = 0; ii <= 10 ; ii++)
   {
      AXI4L_write32((uint32_t)state, ptrA->ADD + AW_FPA_SCD_EN_EXPTIME_CMD_ADD);
   }
}

/* Cette fonction active/désactive l'envoi sérielle de toute commande operationelle au détecteur */
void FPA_EnableSerialOpCMD(t_FpaIntf *ptrA, bool state)
{
   uint8_t ii;
   extern uint8_t gRoicReg19;

   /* Protection : On désactive l'envoi de toute commande opérationnelle,
    * tant que la valeur des bits reservés du registre 19 du ROIC n'a pas été récupérée,
    */

   if(gRoicReg19 != 0xFF)
   {
      for(ii = 0; ii <= 10 ; ii++)
      {
         AXI4L_write32((uint32_t)state, ptrA->ADD + AW_FPA_SCD_EN_OP_CMD_ADD);
      }
   }
}

/* Cette fonction active/désactive le mode externe de controle de l'intégration (non testé). */
void FPA_EnableExternalIntegrationCtrl(t_FpaIntf *ptrA, bool state)
{
   extern bool gExtIntCtrl;
   uint8_t ii;

   gExtIntCtrl = state;
   for(ii = 0; ii <= 10 ; ii++)
   {
      AXI4L_write32((uint32_t)state, ptrA->ADD + AW_FPA_SCD_EN_EXT_INT_CTRL_ADD);
   }
}

/* Cette fonction récupère les statuts du module fpa */
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

   Stat->fpa_init_success                       = (Stat->hw_init_success & sw_init_success);
   Stat->fpa_init_done                          = (Stat->hw_init_done & sw_init_done);
   FPA_GetPrivateStatus(&gPrivateStat, ptrA); // statuts privés
}

/* Cette fonction récupère les statuts privées du module fpa */
void FPA_GetPrivateStatus(t_FpaPrivateStatus *PrivateStat, const t_FpaIntf *ptrA)
{
   // config retournée par le vhd
   PrivateStat->fpa_diag_mode                            = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x00);
   PrivateStat->fpa_diag_type                            = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x04);
   PrivateStat->fpa_pwr_on                               = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x08);
   PrivateStat->fpa_acq_trig_mode                        = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x0C);
   PrivateStat->fpa_acq_trig_ctrl_dly                    = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x10);
   PrivateStat->fpa_xtra_trig_mode                       = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x14);
   PrivateStat->fpa_xtra_trig_ctrl_dly                   = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x18);
   PrivateStat->fpa_trig_ctrl_timeout_dly                = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x1C);
   PrivateStat->fpa_stretch_acq_trig                     = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x20);
   PrivateStat->clk100_to_intclk_conv_numerator          = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x24);
   PrivateStat->intclk_to_clk100_conv_numerator          = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x28);
   PrivateStat->diag_ysize                               = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x2C);
   PrivateStat->diag_xsize_div_tapnum                    = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x30);
   PrivateStat->diag_lovh_mclk_source                    = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x34);
   PrivateStat->real_mode_active_pixel_dly               = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x38);
   PrivateStat->aoi_data_sol_pos                         = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x3C);
   PrivateStat->aoi_data_eol_pos                         = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x40);
   PrivateStat->aoi_flag1_sol_pos                        = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x44);
   PrivateStat->aoi_flag1_eol_pos                        = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x48);
   PrivateStat->aoi_flag2_sol_pos                        = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x4C);
   PrivateStat->aoi_flag2_eol_pos                        = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x50);
   PrivateStat->op_xstart                                = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x54);
   PrivateStat->op_ystart                                = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x58);
   PrivateStat->op_xsize                                 = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x5C);
   PrivateStat->op_ysize                                 = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x60);
   PrivateStat->op_frame_time                            = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x64);
   PrivateStat->op_gain                                  = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x68);
   PrivateStat->op_int_mode                              = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x6C);
   PrivateStat->op_det_vbias                             = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x70);
   PrivateStat->op_det_ibias                             = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x74);
   PrivateStat->op_binning                               = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x78);
   PrivateStat->op_output_rate                           = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x7C);
   PrivateStat->op_cfg_num                               = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x80);
   PrivateStat->int_cmd_id                               = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x84);
   PrivateStat->int_cmd_dlen                             = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x88);
   PrivateStat->int_cmd_offs                             = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x8C);
   PrivateStat->int_cmd_sof_add                          = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x90);
   PrivateStat->int_cmd_eof_add                          = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x94);
   PrivateStat->int_cmd_sof_add_m1                       = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x98);
   PrivateStat->int_checksum_add                         = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x9C);
   PrivateStat->frame_dly_cst                            = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xA0);
   PrivateStat->int_dly_cst                              = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xA4);
   PrivateStat->op_cmd_id                                = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xA8);
   PrivateStat->op_cmd_sof_add                           = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xAC);
   PrivateStat->op_cmd_eof_add                           = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xB0);
   PrivateStat->temp_cmd_id                              = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xB4);
   PrivateStat->temp_cmd_sof_add                         = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xB8);
   PrivateStat->temp_cmd_eof_add                         = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xBC);
   PrivateStat->outgoing_com_hder                        = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xC0);
   PrivateStat->incoming_com_hder                        = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xC4);
   PrivateStat->incoming_com_fail_id                     = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xC8);
   PrivateStat->incoming_com_ovh_len                     = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xCC);
   PrivateStat->fpa_serdes_lval_num                      = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xD0);
   PrivateStat->fpa_serdes_lval_len                      = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xD4);
   PrivateStat->int_clk_period_factor                    = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xD8);
   PrivateStat->fpa_exp_time_conv_denom_bit_pos          = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xDC);
   PrivateStat->frame_dly                                = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xE0);
   PrivateStat->int_dly                                  = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xE4);
   PrivateStat->int_time                                 = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xE8);
   PrivateStat->int_clk_source_rate_hz                   = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xEC);
   PrivateStat->roic_read_reg                            = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0xF0);
}

/* Construction des packets de la commande sérielle */
void FPA_BuildCmdPacket(ScdPacketTx_t *ptrE, const Command_t *ptrC)
{
   uint16_t index;
   uint8_t chksum;
   uint8_t add_offs_msb;
   uint8_t index_offs;

   ptrE->ScdPacketTotalBytesNum = ptrC->total_len;
   ptrE->bram_sof_add = ptrC->bram_sof_add;

   // cmd ovh
   chksum  = ptrE->ScdPacketArrayTx[0] =  ptrC->hder;
   chksum += ptrE->ScdPacketArrayTx[1] =  ptrC->id & 0x00FF;
   chksum += ptrE->ScdPacketArrayTx[2] = (ptrC->id & 0xFF00) >> 8;
   chksum += ptrE->ScdPacketArrayTx[3] =  ptrC->dlen & 0x00FF;
   chksum += ptrE->ScdPacketArrayTx[4] = (ptrC->dlen & 0xFF00) >> 8;
   chksum += ptrE->ScdPacketArrayTx[5] = (ptrC->offs_add & 0x00FF);          // LSB de offs_add

   // traitement special pour le MSB
   add_offs_msb = ((ptrC->offs_add & 0xFF00) >> 8);
   if (add_offs_msb != (uint8_t)DONOT_SEND_THIS_BYTE){
      chksum += ptrE->ScdPacketArrayTx[6] = add_offs_msb;                    // MSB de offs_add est inexistant pour certaines commandes
      index_offs = 7;
   }
   else
      index_offs = 6;

   // Now copy the array locally
   index = 0;
   while(index < ptrC->data_size){
      ptrE->ScdPacketArrayTx[index + index_offs] = ptrC->data[index];
      chksum += ptrC->data[index];
      index++;
   }

   // compute finally the checksum
   chksum %= 256;
   chksum = (~chksum) + 1;
   ptrE->ScdPacketArrayTx[ptrC->total_len-1] = chksum;
}

/* Envoi des packets de la commande sérielle */
void FPA_SendCmdPacket(ScdPacketTx_t *ptrE, const t_FpaIntf *ptrA)
{
   uint16_t index = 0;

   while(index < ptrE->ScdPacketTotalBytesNum){
      AXI4L_write32(ptrE->ScdPacketArrayTx[index], ptrA->ADD + AW_SERIAL_CFG_RAM_BASE_ADD + 4*(ptrE->bram_sof_add + index));  // dans le vhd, division par 4 avant entrée dans ram
      index++;
   }
}

/* Tous les paramètres de configuration temporels du ROIC sont représentés sur 20 bits et sont fonction
 * de la résolution de frame configuré dans le ROIC. Cette fonction fait la conversion d'un temps en seconde
 * vers une valeur de registre définie par cette résolution de frame.
 */
float FPA_ConvertSecondToFrameTimeResolution(float seconds)
{
   float regValue;

   regValue =  seconds*FPA_MCLK_RATE_HZ; // in 70 MHz clks
   regValue =  regValue/((float)FRAME_RESOLUTION_DEFAULT); // in frame_res
   return regValue;
}

/* Cette fonction reset les registres d'erreurs du module fpa*/
 void  FPA_ClearErr(const t_FpaIntf *ptrA)
{
   AXI4L_write32(1, ptrA->ADD + AW_RESET_ERR);           //on active l'effacement
   AXI4L_write32(0, ptrA->ADD + AW_RESET_ERR);           //on desactive l'effacement
}

 /* Cette fonction reset le module fpa.
  * Note : retenir qu'après reset, les IO sont en 'Z' après cela puisqu'on desactive
  * le SoftwType dans le vhd. (voir vhd pour plus de details)
  */
 void  FPA_Reset(const t_FpaIntf *ptrA)
{
   uint8_t ii;
   for(ii = 0; ii <= 10 ; ii++) {
      AXI4L_write32(1, ptrA->ADD + AW_CTRLED_RESET);             //on active le reset
   }
   for(ii = 0; ii <= 10 ; ii++) {
      AXI4L_write32(0, ptrA->ADD + AW_CTRLED_RESET);             //on active l'effacement
   }
}

/* Cette fonction reset le module fpa. */
 void  FPA_PowerDown(const t_FpaIntf *ptrA)
{
   FPA_Reset(ptrA);
}

 /* Informations sur les drivers C utilisés. */
 void  FPA_SoftwType(const t_FpaIntf *ptrA)
 {
    AXI4L_write32(FPA_ROIC, ptrA->ADD + AW_FPA_ROIC_SW_TYPE);
    AXI4L_write32(OUTPUT_DIGITAL, ptrA->ADD + AW_FPA_OUTPUT_SW_TYPE);
    AXI4L_write32(INPUT_LVDS25, ptrA->ADD + AW_FPA_INPUT_SW_TYPE);
 }

 /*
  * Lecture du registre du roic à l'adresse 19.
  * Les bits 0 à 3 du registre 19 sont reservés et les bits 4 à 7 contiennent la config du MTX_INTG_LOW.
  * SCD mentionne explicitement de ne pas modifier la valeur de bits réservés.
  * Cette fonction permet de lire la valeur des bits réservés afin de pouvoir configurer le MTX_INTG_LOW
  * sans danger.
  */
 void FPA_ReadRoicReg19(t_FpaIntf *ptrA)
 {
    extern uint8_t gRoicReg19;

    FPA_EnableSerialOpCMD(ptrA, false); // On ne doit pas activer l'envoi de commande sérielle tant que le registre 19 n'a pas été lu.
    ptrA->roic_reg_cmd_id = 0x8501;
    FPA_SendConfigGC(ptrA, &gcRegsData);

    FPA_SendRoicRead_SerialCmd(ptrA, 19);       // envoi la commande serielle
    FPA_SendRoicReg_StructCmd(ptrA);            // envoi un interrupt au contrôleur du hw driver

    FPA_GetPrivateStatus(&gPrivateStat, ptrA);
    gRoicReg19 = (uint8_t)gPrivateStat.roic_read_reg;
 }

 /* Pour du debug (no testé)*/
 void FPA_WriteRoicReg(t_FpaIntf *ptrA, uint8_t regAdd, uint8_t regVal)
 {
       FPA_EnableSerialOpCMD(ptrA, false);
       ptrA->roic_reg_cmd_id = 0x8500;
       FPA_SendConfigGC(ptrA, &gcRegsData);
       FPA_EnableSerialOpCMD(ptrA, true);

       FPA_SendRoicWrite_SerialCmd(ptrA, regAdd, regVal); // envoi la commande serielle
       FPA_SendRoicReg_StructCmd(ptrA); // envoi un interrupt au contrôleur du hw driver
 }


 /* Envoi de la partie structurale d'une commande pour lire un registre du ROIC */
 void FPA_SendRoicReg_StructCmd(const t_FpaIntf *ptrA)
 {
    static uint8_t RoicRegNum = 0;

    if (RoicRegNum == 255)  // protection contre depassement
       RoicRegNum = 0;

    RoicRegNum++;

    // envoie de la cfg structurale
    AXI4L_write32((uint32_t)RoicRegNum, ptrA->ADD + AW_ROIC_REG_STRUCT_CFG_ADD);
    AXI4L_write32(0, ptrA->ADD + AW_ROIC_REG_STRUCT_CFG_ADD + 4);
 }

 /* Envoi de la partie sérielle d'une commande pour lire un registre du ROIC */
 void FPA_SendRoicRead_SerialCmd(const t_FpaIntf *ptrA, uint8_t regAdd)
 {
    Command_t Cmd;
    ScdPacketTx_t ScdPacketTx;

    // on bâtit la commande
    Cmd.hder           =  ptrA->outgoing_com_hder;
    Cmd.id             =  ptrA->roic_reg_cmd_id;
    Cmd.dlen           =  ptrA->roic_reg_cmd_dlen;
    Cmd.offs_add       =  (((uint8_t)DONOT_SEND_THIS_BYTE & 0xFF) << 8) + regAdd; // on evite ainsi l'envoi du MSB de offs_add
    Cmd.data[0]        =  1;
    Cmd.data_size      =  ptrA->roic_reg_cmd_data_size;
    Cmd.total_len      =  ptrA->outgoing_com_ovh_len + ptrA->roic_reg_cmd_dlen + 1;     // +1 pour le checksum
    Cmd.bram_sof_add   =  ptrA->roic_reg_cmd_sof_add;

    FPA_BuildCmdPacket(&ScdPacketTx, &Cmd); // on batit les packets de bytes
    FPA_SendCmdPacket(&ScdPacketTx, ptrA); // on envoit les packets
 }

 /* Envoi de la partie sérielle d'une commande pour lire un registre du ROIC */
 void FPA_SendRoicWrite_SerialCmd(const t_FpaIntf *ptrA, uint8_t regAdd, uint8_t regVal)
 {
    Command_t Cmd;
    ScdPacketTx_t ScdPacketTx;

    // on bâtit la commande
    Cmd.hder           =  ptrA->outgoing_com_hder;
    Cmd.id             =  ptrA->roic_reg_cmd_id;
    Cmd.dlen           =  ptrA->roic_reg_cmd_dlen;
    Cmd.offs_add       =  (((uint8_t)DONOT_SEND_THIS_BYTE & 0xFF) << 8) + regAdd; // on evite ainsi l'envoi du MSB de offs_add
    Cmd.data[0]        =  regVal;
    Cmd.data_size      =  ptrA->roic_reg_cmd_data_size;
    Cmd.total_len      =  ptrA->outgoing_com_ovh_len + ptrA->roic_reg_cmd_dlen + 1;     // +1 pour le checksum
    Cmd.bram_sof_add   =  ptrA->roic_reg_cmd_sof_add;

    FPA_BuildCmdPacket(&ScdPacketTx, &Cmd); // on batit les packets de bytes
    FPA_SendCmdPacket(&ScdPacketTx, ptrA); // on envoit les packets
 }
