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
#include "axil_clk_wiz.h"
 

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

// adresse d'écriture du registre du reset des données reçues du ROIC
#define AW_RESET_ROIC_RX_DATA                      0xB04

// division de l'address space AXIL par un demux
#define ARW_CLK_WIZ_BASE_ADD                       0x4000   // adresse de base de l'IP Clock Wizard
#define ARW_PROG_MEM_BASE_ADD                      0x8000   // adresse de base de la mémoire de programmation du ROIC
#define ARW_UNUSED_BASE_ADD                        0xC000   // pour l'instant cet adress space n'est pas utilisé

// division des adresses de la mémoire de programmation en 2 sections pour le TX et le RX
#define PROG_MEM_TX_OFFSET                         0
#define PROG_MEM_RX_OFFSET                         256

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
#define TOTAL_DAC_NUM                              8

// specific parameters
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
#define CALCIUM_DEFAULT_REGG                       1     // contrôle interne (registre bIntCnt) du temps d'intégration
#define CALCIUM_DEFAULT_REGH                       1     // le LDO de VPIXQNB est activé

#define CALCIUM_DEBUG_KPIX_MAX                     32768 // valeur min est 0

#define CALCIUM_COMPRESSION_PARAM_DEFAULT          (16.0F / 23.0F)


// Programmation des registres du ROIC
/* Définitions du header */
#define HDR_START_PATTERN           (2 << 13)                  // [15:13] sync word
#define HDR_LOAD_BIT(write)         (((write) & 0x01) << 12)   // [12] 1 = write, 0 = read
#define HDR_FRM_SYNC                (0 << 11)                  // [11] not used (SPI Frame Mode)
#define HDR_PAGE_ID                 (0 << 8)                   // [10:8] not used for this ROIC
#define HDR_NBR_DATA(x)             ((x) & 0xFF)               // [7:0] number of words (addr, data) sent (header word excluded)
/* Indices des registres dans RoicRegs */
#define bGenCtrl_idx                0
#define bGenCtrl2_idx               1
#define bRowStartLSB_idx            2
#define bRowStartMSB_idx            3
#define bRowStopLSB_idx             4
#define bRowStopMSB_idx             5
#define bFrmCtrl_idx                6
#define bClkRowCntLSB_idx           7
#define bClkRowCntMSB_idx           8
#define bPixRstHCnt_idx             9
#define bPixXferCnt_idx             10
#define bPixOHCnt_idx               11
#define bPixOH2Cnt_idx              12
#define bPixRstBECnt_idx            13
#define bRODelayCnt_idx             14
#define bPixBECtrl_idx              15
#define bPixClampDelayCnt_idx       16
#define bPixTstNOCCnt_idx           17
#define bIntCntLSB_idx              18
#define bIntCnt_idx                 19
#define bIntCntMSB_idx              20
#define bFrmHoldOffLSB_idx          21
#define bFrmHoldOff_idx             22
#define bFrmHoldOffMSB_idx          23
#define bClkRowDelayCnt_idx         24
#define bClkCtrlDSMDiv_idx          25
#define bDSMCyclesLSB_idx           26
#define bDSMCyclesMSB_idx           27
#define bDSMDeltaCnt_idx            28
#define bDSMOHCnt_idx               29
#define bDSMQRstCnt_idx             30
#define bDSMDelayCntLSB_idx         31
#define bDSMDelayCntMSB_idx         32
#define bDSMInitDelayCntLSB_idx     33
#define bDSMInitDelayCntMSB_idx     34
#define bDSMSeedRowsSel_idx         35
#define bColGrpStart_idx            36
#define bColGrpStop_idx             37
#define bTstDig_idx                 38
#define bTstAddrDig1_idx            39
#define bTstAddrDig2_idx            40
#define bADCtrl_idx                 41
#define bADOSamp_idx                42
#define bADDigOSLSB_idx             43
#define bADDigOS_idx                44
#define bADDigOSMSB_idx             45
#define bADRstCnt_idx               46
#define bADCalCtrl_idx              47
#define bADCalOSampCtrl_idx         48
#define bADCalConstLSB_idx          49
#define bADCalConstMSB_idx          50
#define bADCal2Const_idx            51
#define bADCalClkLSB_idx            52
#define bADCalClkMSB_idx            53
#define bADCal2ClkLSB_idx           54
#define bADCal2ClkMSB_idx           55
#define bADCalDigOSLSB_idx          56
#define bADCalDigOS_idx             57
#define bADCalDigOSMSB_idx          58
#define bADCalCnt1_idx              59
#define bADCalCnt2_idx              60
#define bDVPOffsetLSB_idx           61
#define bDVPOffset_idx              62
#define bDVPOffsetMSB_idx           63
#define bResidueHandler_idx         64
#define bResDataMaxLSB_idx          65
#define bResDataMax_idx             66
#define bResDataMaxMSB_idx          67
#define bDataHandler_idx            68
#define bOutCtrl_idx                69
#define bTxCtrl_idx                 70
#define bLVDSCtrl_idx               71
#define bSkewXCLK_idx               72
#define bSkewX1_idx                 73
#define bSkewX2_idx                 74
#define bSkewX3_idx                 75
#define bSkewX4_idx                 76
#define bSkewX5_idx                 77
#define bSkewX6_idx                 78
#define bSkewX7_idx                 79
#define bSkewX8_idx                 80
#define bClkCoreCnt_idx             81
#define bClkColCnt_idx              82
#define b3PixBiasMstr1_idx          83
#define b3PixPDIBias_idx            84
#define b3PixCPDIBias_idx           85
#define b3PixCompRef_idx            86
#define b3PixCompRefBias1_idx       87
#define b3PixCompRefBias2_idx       88
#define b3PixQNB_idx                89
#define b3PixQNBBias1_idx           90
#define b3PixQNBBias2_idx           91
#define b3PixAnaCtrl_idx            92
#define b3RstLimRamp_idx            93
#define b3PixRstLim_idx             94
#define b3PixAnaEn_idx              95
#define b3TstAna_idx                96
#define b3TR2I_idx                  97
#define b3PixBiasMstr2_idx          98
#define b3PixClamp_idx              99
#define b3PixClampCtrl_idx          100
#define b3BISTRmpCtrl_3p3_idx       101
#define b3BISTSlope_idx             102
#define b3BISTOffset_idx            103
#define b3BISTRmpBias_idx           104
#define b3ColBias_idx               105
#define b3ColCtrl_idx               106
#define b3ColDRBias_idx             107
#define b3ADCtrl_idx                108
#define b3ADBiasMstr_idx            109
#define b3ADBiasBuf_idx             110
#define b3ADBiasComp_idx            111
#define b3ADRamp_idx                112
#define b3ADRampTrim_idx            113
#define b3ADBiasRampBuf_idx         114
#define b3ADRefLow_idx              115
#define b3ADRmpI1Ctrl_idx           116
#define b3ADBiasRmpI1DR_idx         117
#define b3LVDSBiasMstr_idx          118
#define b3LVDSBias_idx              119
#define b3LVDSBiasRec_idx           120
#define b3TstAddrAna_idx            121
/* Macros GET et SET pour certains champs des registres */
#define REG_FIELD_GET(idx, mask, shift)            ((RoicRegs[idx].data & (mask)) >> (shift))
#define REG_FIELD_SET(idx, mask, shift, val)       BitMaskClr(RoicRegs[idx].data, (mask)); BitMaskSet(RoicRegs[idx].data, ((val) << (shift)) & (mask))
#define bGenCtrl_bLoGn_mask                        0x01
#define bGenCtrl_bLoGn_shift                       0
#define bGenCtrl_bLoGn_GET()                       REG_FIELD_GET(bGenCtrl_idx, bGenCtrl_bLoGn_mask, bGenCtrl_bLoGn_shift)
#define bGenCtrl_bLoGn_SET(val)                    REG_FIELD_SET(bGenCtrl_idx, bGenCtrl_bLoGn_mask, bGenCtrl_bLoGn_shift, val)
#define bGenCtrl2_bTestRowsEn_mask                 0x08
#define bGenCtrl2_bTestRowsEn_shift                3
#define bGenCtrl2_bTestRowsEn_GET()                REG_FIELD_GET(bGenCtrl2_idx, bGenCtrl2_bTestRowsEn_mask, bGenCtrl2_bTestRowsEn_shift)
#define bGenCtrl2_bTestRowsEn_SET(val)             REG_FIELD_SET(bGenCtrl2_idx, bGenCtrl2_bTestRowsEn_mask, bGenCtrl2_bTestRowsEn_shift, val)
#define bFrmCtrl_bITREn_mask                       0x10
#define bFrmCtrl_bITREn_shift                      4
#define bFrmCtrl_bITREn_GET()                      REG_FIELD_GET(bFrmCtrl_idx, bFrmCtrl_bITREn_mask, bFrmCtrl_bITREn_shift)
#define bFrmCtrl_bITREn_SET(val)                   REG_FIELD_SET(bFrmCtrl_idx, bFrmCtrl_bITREn_mask, bFrmCtrl_bITREn_shift, val)
#define bFrmCtrl_bClkFrmIntCntEn_mask              0x20
#define bFrmCtrl_bClkFrmIntCntEn_shift             5
#define bFrmCtrl_bClkFrmIntCntEn_GET()             REG_FIELD_GET(bFrmCtrl_idx, bFrmCtrl_bClkFrmIntCntEn_mask, bFrmCtrl_bClkFrmIntCntEn_shift)
#define bFrmCtrl_bClkFrmIntCntEn_SET(val)          REG_FIELD_SET(bFrmCtrl_idx, bFrmCtrl_bClkFrmIntCntEn_mask, bFrmCtrl_bClkFrmIntCntEn_shift, val)
#define bOutCtrl_bTestModeSel_mask                 0x20
#define bOutCtrl_bTestModeSel_shift                5
#define bOutCtrl_bTestModeSel_GET()                REG_FIELD_GET(bOutCtrl_idx, bOutCtrl_bTestModeSel_mask, bOutCtrl_bTestModeSel_shift)
#define bOutCtrl_bTestModeSel_SET(val)             REG_FIELD_SET(bOutCtrl_idx, bOutCtrl_bTestModeSel_mask, bOutCtrl_bTestModeSel_shift, val)
#define b3PixAnaCtrl_b3PixQNBOvr_mask              0x04
#define b3PixAnaCtrl_b3PixQNBOvr_shift             2
#define b3PixAnaCtrl_b3PixQNBOvr_GET()             REG_FIELD_GET(b3PixAnaCtrl_idx, b3PixAnaCtrl_b3PixQNBOvr_mask, b3PixAnaCtrl_b3PixQNBOvr_shift)
#define b3PixAnaCtrl_b3PixQNBOvr_SET(val)          REG_FIELD_SET(b3PixAnaCtrl_idx, b3PixAnaCtrl_b3PixQNBOvr_mask, b3PixAnaCtrl_b3PixQNBOvr_shift, val)
#define b3PixAnaCtrl_b3PixQNBExtEn_mask            0x20
#define b3PixAnaCtrl_b3PixQNBExtEn_shift           5
#define b3PixAnaCtrl_b3PixQNBExtEn_GET()           REG_FIELD_GET(b3PixAnaCtrl_idx, b3PixAnaCtrl_b3PixQNBExtEn_mask, b3PixAnaCtrl_b3PixQNBExtEn_shift)
#define b3PixAnaCtrl_b3PixQNBExtEn_SET(val)        REG_FIELD_SET(b3PixAnaCtrl_idx, b3PixAnaCtrl_b3PixQNBExtEn_mask, b3PixAnaCtrl_b3PixQNBExtEn_shift, val)
#define b3PixAnaEn_b3PixQNBEn_mask                 0x02
#define b3PixAnaEn_b3PixQNBEn_shift                1
#define b3PixAnaEn_b3PixQNBEn_GET()                REG_FIELD_GET(b3PixAnaEn_idx, b3PixAnaEn_b3PixQNBEn_mask, b3PixAnaEn_b3PixQNBEn_shift)
#define b3PixAnaEn_b3PixQNBEn_SET(val)             REG_FIELD_SET(b3PixAnaEn_idx, b3PixAnaEn_b3PixQNBEn_mask, b3PixAnaEn_b3PixQNBEn_shift, val)
/* Timeout de la réponse */
// Le temps de transmission/réception du message n'est pas déterminant puisque le contrôleur
// doit attendre entre 2 images pour communiquer. Des mesures montrent que 10 ms est
// généralement suffisant pour obtenir une réponse.
//#define WAITING_FOR_ROIC_RX_DATA_TIMEOUT_US        ((NUM_OF(RoicRegs) + 1 + 2) * 16)    // (nbRegs + header + RX overhead) x 16b @ 1MHz
#define WAITING_FOR_ROIC_RX_DATA_TIMEOUT_US        10000    // 10ms

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

// Structure d'un registre de ROIC
typedef union
{
   uint16_t word;       // pour accéder à la concaténation de addr et data
   struct {
      // data est le LSB alors il doit être en 1er dans le µBlaze (little-endian)
      uint8_t data;     // valeur du registre
      uint8_t addr;     // adresse du registre
   };
} t_RoicRegister;
 
// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
t_FpaResolutionCfg gFpaResolutionCfg[FPA_MAX_NUMBER_CONFIG_MODE] = {FPA_STANDARD_RESOLUTION};

// Private variables
static uint32_t sw_init_done = 0;
static uint32_t sw_init_success = 0;
static ProximCfg_t ProximCfg;
static t_RoicRegister RoicRegs[] = {
      /* bGenCtrl */             {.addr = 1,   .data = 101},
      /* bGenCtrl2 */            {.addr = 2,   .data = 27},
      /* bRowStartLSB */         {.addr = 3,   .data = 1},
      /* bRowStartMSB */         {.addr = 4,   .data = 0},
      /* bRowStopLSB */          {.addr = 5,   .data = 0},
      /* bRowStopMSB */          {.addr = 6,   .data = 2},
      /* bFrmCtrl */             {.addr = 10,  .data = 48},
      /* bClkRowCntLSB */        {.addr = 11,  .data = 2},
      /* bClkRowCntMSB */        {.addr = 12,  .data = 1},
      /* bPixRstHCnt */          {.addr = 13,  .data = 0},
      /* bPixXferCnt */          {.addr = 14,  .data = 0},
      /* bPixOHCnt */            {.addr = 15,  .data = 0},
      /* bPixOH2Cnt */           {.addr = 16,  .data = 0},
      /* bPixRstBECnt */         {.addr = 17,  .data = 0},
      /* bRODelayCnt */          {.addr = 18,  .data = 0},
      /* bPixBECtrl */           {.addr = 19,  .data = 7},
      /* bPixClampDelayCnt */    {.addr = 20,  .data = 0},
      /* bPixTstNOCCnt */        {.addr = 21,  .data = 8},
      /* bIntCntLSB */           {.addr = 22,  .data = 9},
      /* bIntCnt */              {.addr = 23,  .data = 0},
      /* bIntCntMSB */           {.addr = 24,  .data = 0},
      /* bFrmHoldOffLSB */       {.addr = 25,  .data = 0},
      /* bFrmHoldOff */          {.addr = 26,  .data = 0},
      /* bFrmHoldOffMSB */       {.addr = 27,  .data = 0},
      /* bClkRowDelayCnt */      {.addr = 28,  .data = 0},
      /* bClkCtrlDSMDiv */       {.addr = 29,  .data = 1},
      /* bDSMCyclesLSB */        {.addr = 30,  .data = 0},
      /* bDSMCyclesMSB */        {.addr = 31,  .data = 0},
      /* bDSMDeltaCnt */         {.addr = 32,  .data = 1},
      /* bDSMOHCnt */            {.addr = 33,  .data = 0},
      /* bDSMQRstCnt */          {.addr = 34,  .data = 3},
      /* bDSMDelayCntLSB */      {.addr = 35,  .data = 0},
      /* bDSMDelayCntMSB */      {.addr = 36,  .data = 0},
      /* bDSMInitDelayCntLSB */  {.addr = 37,  .data = 0},
      /* bDSMInitDelayCntMSB */  {.addr = 38,  .data = 0},
      /* bDSMSeedRowsSel */      {.addr = 39,  .data = 6},
      /* bColGrpStart */         {.addr = 40,  .data = 1},
      /* bColGrpStop */          {.addr = 41,  .data = 80},
      /* bTstDig */              {.addr = 56,  .data = 0},
      /* bTstAddrDig1 */         {.addr = 57,  .data = 0},
      /* bTstAddrDig2 */         {.addr = 58,  .data = 0},
      /* bADCtrl */              {.addr = 64,  .data = 67},
      /* bADOSamp */             {.addr = 75,  .data = 0},
      /* bADDigOSLSB */          {.addr = 76,  .data = 0},
      /* bADDigOS */             {.addr = 77,  .data = 0},
      /* bADDigOSMSB */          {.addr = 78,  .data = 0},
      /* bADRstCnt */            {.addr = 79,  .data = (uint8_t)ceilf(337.5e-9f * CALCIUM_CLK_COL_HZ - 1.0f)}, // delay is bADRstCnt + 1},
      /* bADCalCtrl */           {.addr = 80,  .data = 22},
      /* bADCalOSampCtrl */      {.addr = 81,  .data = 5},
      /* bADCalConstLSB */       {.addr = 82,  .data = 0},
      /* bADCalConstMSB */       {.addr = 83,  .data = 2},
      /* bADCal2Const */         {.addr = 84,  .data = 16},
      /* bADCalClkLSB */         {.addr = 85,  .data = 0},
      /* bADCalClkMSB */         {.addr = 86,  .data = 8},
      /* bADCal2ClkLSB */        {.addr = 87,  .data = 0},
      /* bADCal2ClkMSB */        {.addr = 88,  .data = 4},
      /* bADCalDigOSLSB */       {.addr = 89,  .data = 0},
      /* bADCalDigOS */          {.addr = 90,  .data = 64},
      /* bADCalDigOSMSB */       {.addr = 91,  .data = 0},
      /* bADCalCnt1 */           {.addr = 92,  .data = 0},
      /* bADCalCnt2 */           {.addr = 93,  .data = 40},
      /* bDVPOffsetLSB */        {.addr = 100, .data = 0},
      /* bDVPOffset */           {.addr = 101, .data = 0},
      /* bDVPOffsetMSB */        {.addr = 102, .data = 0},
      /* bResidueHandler */      {.addr = 103, .data = 0},
      /* bResDataMaxLSB */       {.addr = 104, .data = 0},
      /* bResDataMax */          {.addr = 105, .data = 64},
      /* bResDataMaxMSB */       {.addr = 106, .data = 0},
      /* bDataHandler */         {.addr = 107, .data = 3},
      /* bOutCtrl */             {.addr = 111, .data = 133},
      /* bTxCtrl */              {.addr = 112, .data = 26},
      /* bLVDSCtrl */            {.addr = 115, .data = 34},
      /* bSkewXCLK */            {.addr = 117, .data = 32},
      /* bSkewX<1> */            {.addr = 118, .data = 32},
      /* bSkewX<2> */            {.addr = 119, .data = 32},
      /* bSkewX<3> */            {.addr = 120, .data = 32},
      /* bSkewX<4> */            {.addr = 121, .data = 32},
      /* bSkewX<5> */            {.addr = 122, .data = 32},
      /* bSkewX<6> */            {.addr = 123, .data = 32},
      /* bSkewX<7> */            {.addr = 124, .data = 32},
      /* bSkewX<8> */            {.addr = 125, .data = 32},
      /* bClkCoreCnt */          {.addr = 126, .data = 20},
      /* bClkColCnt */           {.addr = 127, .data = 4},
      /* b3PixBiasMstr1 */       {.addr = 128, .data = 7},
      /* b3PixPDIBias */         {.addr = 129, .data = 85},
      /* b3PixCPDIBias */        {.addr = 130, .data = 105},
      /* b3PixCompRef */         {.addr = 131, .data = 100},
      /* b3PixCompRefBias1 */    {.addr = 132, .data = 78},
      /* b3PixCompRefBias2 */    {.addr = 133, .data = 8},
      /* b3PixQNB */             {.addr = 134, .data = 94},
      /* b3PixQNBBias1 */        {.addr = 135, .data = 39},
      /* b3PixQNBBias2 */        {.addr = 136, .data = 8},
      /* b3PixAnaCtrl */         {.addr = 137, .data = 61},
      /* b3RstLimRamp */         {.addr = 138, .data = 1},
      /* b3PixRstLim */          {.addr = 139, .data = 16},
      /* b3PixAnaEn */           {.addr = 140, .data = 125},
      /* b3TstAna */             {.addr = 141, .data = 0},
      /* b3TR2I */               {.addr = 142, .data = 0},
      /* b3PixBiasMstr2 */       {.addr = 150, .data = 7},
      /* b3PixClamp */           {.addr = 151, .data = 50},
      /* b3PixClampCtrl */       {.addr = 152, .data = 2},
      /* b3BISTRmpCtrl_3p3 */    {.addr = 160, .data = 0},
      /* b3BISTSlope */          {.addr = 161, .data = 16},
      /* b3BISTOffset */         {.addr = 162, .data = 7},
      /* b3BISTRmpBias */        {.addr = 163, .data = 0},
      /* b3ColBias */            {.addr = 165, .data = 50},
      /* b3ColCtrl */            {.addr = 166, .data = 8},
      /* b3ColDRBias */          {.addr = 167, .data = 3},
      /* b3ADCtrl */             {.addr = 193, .data = 88},
      /* b3ADBiasMstr */         {.addr = 194, .data = 7},
      /* b3ADBiasBuf */          {.addr = 195, .data = 15},
      /* b3ADBiasComp */         {.addr = 196, .data = 9},
      /* b3ADRamp */             {.addr = 197, .data = (uint8_t)roundf(3.662e-6f * CALCIUM_CLK_COL_HZ * 0.65f)},
      /* b3ADRampTrim */         {.addr = 198, .data = 32},
      /* b3ADBiasRampBuf */      {.addr = 199, .data = 3},
      /* b3ADRefLow */           {.addr = 200, .data = 16},
      /* b3ADRmpI1Ctrl */        {.addr = 201, .data = 8},
      /* b3ADBiasRmpI1DR */      {.addr = 202, .data = 3},
      /* b3LVDSBiasMstr */       {.addr = 208, .data = 167},
      /* b3LVDSBias */           {.addr = 209, .data = 50},
      /* b3LVDSBiasRec */        {.addr = 210, .data = 110},
      /* b3TstAddrAna */         {.addr = 240, .data = 0}
};


// Prototypes fonctions internes
void FPA_Reset(const t_FpaIntf *ptrA);
void FPA_SpecificParams(calcium_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_BuildRoicRegs(const gcRegistersData_t *pGCRegs, calcium_param_t *ptrH);
void FPA_SendRoicRegs(const t_FpaIntf *ptrA);
void FPA_ReadRoicRegs(const t_FpaIntf *ptrA);
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

   //TODO: ajouter la vérification de la révision du ROIC

   static float lastDesiredFreq = 0.0f;
   extern float gFpaDesiredFreq_MHz;

   if (sw_init_done == 0)
      gFpaDesiredFreq_MHz = CALCIUM_CLK_DDR_HZ / 1e6F;

   if(lastDesiredFreq != gFpaDesiredFreq_MHz) {
      float clkFreq[7] = {gFpaDesiredFreq_MHz};
      if(axil_clk_wiz_setFreq((void *)(ptrA->ADD + ARW_CLK_WIZ_BASE_ADD), VHD_CLK_100M_RATE_HZ / 1e6f, clkFreq, clkFreq) == 0) {
         extern float gFpaActualFreq_MHz;
         gFpaActualFreq_MHz = clkFreq[0];
         axil_clk_wiz_doReconfig((void *)(ptrA->ADD + ARW_CLK_WIZ_BASE_ADD), FALSE);
         FPA_PRINTF("FPA Clock Wizard has been configured with the desired frequency");
      } else {
         FPA_ERR("FPA Clock Wizard cannot be configured with the desired frequency");
      }
      lastDesiredFreq = gFpaDesiredFreq_MHz;
   }
   
   FPA_Reset(ptrA);
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roic de fpa le pilote en C est conçu pour.
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoyée au vhd. Il attendra l'allumage du proxy pour le programmer
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
   extern int32_t gFpaDebugRegH;                       // reservé pour l'activation/désactivation du LDO de VPIXQNB
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
   extern CompressionAlgorithm_t gCompressionAlgorithm;
   extern float gCompressionParameter;
   extern bool gCompressionParameterForced;
   extern bool gFpaReadReg;
   static uint8_t cfg_num;

   // on bâtit les données de programmation du ROIC
   FPA_BuildRoicRegs(pGCRegs, &hh);

   // on bâtit les parametres specifiques (est maintenant appelée dans FPA_BuildRoicRegs)
   //FPA_SpecificParams(&hh, 0.0F, pGCRegs);

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
   int32_t maxDebugRegF = hh.numFrRows - ptrA->height + 1;
   if (sw_init_done == 0)
      gFpaDebugRegF = CALCIUM_DEFAULT_REGF;
   if (gFpaDebugRegF < 1)
      gFpaDebugRegF = 1;
   else if (gFpaDebugRegF > maxDebugRegF)
      gFpaDebugRegF = maxDebugRegF;
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
   ptrA->use_ext_pixqnb = (uint32_t)gFpaDebugRegH;
   
   // largeur du pulse de CLK_FRM en clk_100M pour un contrôle interne du temps d'intégration (registre bIntCnt)
   if (gFpaDebugRegG == 1)
      ptrA->clk_frm_pulse_width = (uint32_t)(0.5e-6F * VHD_CLK_100M_RATE_HZ); // pulse < ETMin
   else
      // 0 -> CLK_FRM est la réplique de FPA_INT pour un contrôle externe du temps d'intégration
      ptrA->clk_frm_pulse_width = 0;

   // serdes
   ptrA->fpa_serdes_lval_num = hh.numFrRows;
   ptrA->fpa_serdes_lval_len = ptrA->width/8;    // 8 pix de large
   
   // compression loi de puissance
   gCompressionAlgorithm = CA_PowerLaw;
   if (sw_init_done == 0 || gCompressionParameter == 0.0F)
   {
      gCompressionParameter = CALCIUM_COMPRESSION_PARAM_DEFAULT;
      gCompressionParameterForced = false;
   }
   if (ptrA->fpa_diag_mode ||
         gCompressionParameterForced ||
         !calibrationInfo.isValid ||
         calibrationInfo.blocks[0].CompressionAlgorithm != CA_PowerLaw)
   {
      // On force le compression parameter par défaut ou transmis par l'usager
      ptrA->compr_ratio_fp32 = gCompressionParameter;
   }
   else
   {
      // On utilise le compression parameter disponible dans le bloc (la compression est la même pour tous les blocs)
      ptrA->compr_ratio_fp32 = calibrationInfo.blocks[0].CompressionParameter;
   }
   gCompressionParameter = ptrA->compr_ratio_fp32;
   
   // Nombre de données envoyées pour la programmation du ROIC
   // Si 0, il n'y aura pas de programmation du ROIC, mais la nouvelle fpa cfg sera appliquée.
   ptrA->roic_tx_nb_data = NUM_OF(RoicRegs) + 1;  // on envoie toujours tous les registres + le header

   // changement de cfg_num des qu'une nouvelle cfg est envoyée au vhd. Déclenche la programmation du ROIC
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

   // envoi des données de programmation du ROIC
   FPA_SendRoicRegs(ptrA);
    
   // envoi du reste de la config 
   WriteStruct(ptrA);

   if (gFpaReadReg)
   {
      // lecture du feedback
      FPA_ReadRoicRegs(ptrA);
      // Reset de la demande du debug terminal
      gFpaReadReg = false;
   }
}

//--------------------------------------------------------------------------
// Pour avoir les parametres propres au calcium avec une config
//--------------------------------------------------------------------------
void FPA_SpecificParams(calcium_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
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
   ptrH->itrReadoutDelay = ((RoicRegs[bPixOHCnt_idx].data + 1.0F) + (RoicRegs[bPixRstBECnt_idx].data + 1.0F)) / CALCIUM_CLK_CORE_HZ;
   ptrH->iwrReadoutDelay =
      ((RoicRegs[bPixRstHCnt_idx].data + 1.0F) + (RoicRegs[bPixXferCnt_idx].data + 1.0F) + 2.0F*(RoicRegs[bPixOHCnt_idx].data + 1.0F) +
      (RoicRegs[bPixOH2Cnt_idx].data + 1.0F) + (RoicRegs[bPixRstBECnt_idx].data + 1.0F) + (RoicRegs[bRODelayCnt_idx].data + 1.0F)) / CALCIUM_CLK_CORE_HZ;
   
   // Residue ADC conversion time is 130 ClkCol cycles and ADC reset time.
   float ADCConvTime = (130.0F + RoicRegs[bADRstCnt_idx].data) / CALCIUM_CLK_COL_HZ;
   
   // Serializer transmission time.
   // 1st line is the transmission of a row and is done on both edges of ClkDDR.
   // 2nd line is an overhead time on ClkCol.
   float serializerTxTime = 8.0F * (pGCRegs->Width/8.0F + 4.0F) * CALCIUM_BITS_PER_PIX / (2.0F * CALCIUM_CLK_DDR_HZ * CALCIUM_TX_OUTPUTS)
      + 6.0F / CALCIUM_CLK_COL_HZ;
   
   // Readout row time must be longer than the ADC conversion time and the serializer transmission time.
   // We use floor() + 1 to make sure calculated time is longer and not equal to the other delays.
   ptrH->readoutRowTime = (floorf(MAX(ADCConvTime, serializerTxTime) * CALCIUM_CLK_COL_HZ) + 1.0F) / CALCIUM_CLK_COL_HZ;
   
   // Frame has image rows, 2 overhead rows and 2 test rows if enabled.
   ptrH->numFrRows = pGCRegs->Height + 2 + 2*bGenCtrl2_bTestRowsEn_GET();
   
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
   uint32_t *p_addr = (uint32_t *)(ptrA->ADD + AR_STATUS_BASE_ADD);
   uint32_t temp_32b;

   Stat->adc_oper_freq_max_khz                  = *p_addr++;
   Stat->adc_analog_channel_num                 = *p_addr++;
   Stat->adc_resolution                         = *p_addr++;
   Stat->adc_brd_spare                          = *p_addr++;
   Stat->ddc_fpa_roic                           = *p_addr++;
   Stat->ddc_brd_spare                          = *p_addr++;
   Stat->flex_fpa_roic                          = *p_addr++;
   Stat->flex_fpa_input                         = *p_addr++;
   Stat->flex_ch_diversity_num                  = *p_addr++;
   Stat->cooler_volt_min_mV                     = *p_addr++;
   Stat->cooler_volt_max_mV                     = *p_addr++;
   Stat->fpa_temp_raw                           = *p_addr++;
   Stat->global_done                            = *p_addr++;
   Stat->fpa_powered                            = *p_addr++;
   Stat->cooler_powered                         = *p_addr++;
   Stat->errors_latchs                          = *p_addr++;
   Stat->intf_seq_stat                          = *p_addr++;
   Stat->data_path_stat                         = *p_addr++;
   Stat->trig_ctler_stat                        = *p_addr++;
   Stat->fpa_driver_stat                        = *p_addr++;
   Stat->adc_ddc_detect_process_done            = *p_addr++;
   Stat->adc_ddc_present                        = *p_addr++;
   Stat->flex_flegx_detect_process_done         = *p_addr++;
   Stat->flex_flegx_present                     = *p_addr++;
   Stat->id_cmd_in_error                        = *p_addr++;
   Stat->fpa_serdes_done                        = *p_addr++;
   Stat->fpa_serdes_success                     = *p_addr++;
   temp_32b                                     = *p_addr++;
   memcpy(Stat->fpa_serdes_delay, (uint8_t *)&temp_32b, sizeof(Stat->fpa_serdes_delay));
   Stat->fpa_serdes_edges[0]                    = *p_addr++;
   Stat->fpa_serdes_edges[1]                    = *p_addr++;
   Stat->fpa_serdes_edges[2]                    = *p_addr++;
   Stat->fpa_serdes_edges[3]                    = *p_addr++;
   Stat->hw_init_done                           = *p_addr++;
   Stat->hw_init_success                        = *p_addr++;
   Stat->flegx_present                          = (Stat->flex_flegx_present & Stat->adc_brd_spare) & 0x01;
   Stat->prog_init_done                         = *p_addr++;
   Stat->cooler_on_curr_min_mA                  = *p_addr++;
   Stat->cooler_off_curr_max_mA                 = *p_addr++;
   Stat->acq_trig_cnt                           = *p_addr++;
   Stat->acq_int_cnt                            = *p_addr++;
   Stat->fpa_readout_cnt                        = *p_addr++;
   Stat->acq_readout_cnt                        = *p_addr++;
   Stat->out_pix_cnt_min                        = *p_addr++;
   Stat->out_pix_cnt_max                        = *p_addr++;
   Stat->trig_to_int_delay_min                  = *p_addr++;
   Stat->trig_to_int_delay_max                  = *p_addr++;
   Stat->int_to_int_delay_min                   = *p_addr++;
   Stat->int_to_int_delay_max                   = *p_addr++;
   Stat->fast_hder_cnt                          = *p_addr++;

   // generation de fpa_init_done et fpa_init_success
   Stat->fpa_init_success                       = (Stat->hw_init_success & sw_init_success);
   Stat->fpa_init_done                          = (Stat->hw_init_done & sw_init_done);
}

//--------------------------------------------------------------------------
// Pour afficher le feedback de FPA_INTF_CFG
//--------------------------------------------------------------------------
void FPA_PrintConfig(const t_FpaIntf *ptrA)
{
   uint32_t *p_addr = (uint32_t *)(ptrA->ADD + AR_FPA_INTF_CFG_BASE_ADD);
   uint32_t temp_u32;
   float *p_temp_fp32 = (float *)(&temp_u32);

   FPA_INF("int_time = %u", *p_addr++);
   FPA_INF("int_indx = %u", *p_addr++);
   FPA_INF("int_signal_high_time = %u", *p_addr++);
   FPA_INF("comn.fpa_diag_mode = %u", *p_addr++);
   FPA_INF("comn.fpa_diag_type = %u", *p_addr++);
   FPA_INF("comn.fpa_pwr_on = %u", *p_addr++);
   FPA_INF("comn.fpa_acq_trig_mode = %u", *p_addr++);
   FPA_INF("comn.fpa_acq_trig_ctrl_dly = %u", *p_addr++);
   FPA_INF("comn.fpa_xtra_trig_mode = %u", *p_addr++);
   FPA_INF("comn.fpa_xtra_trig_ctrl_dly = %u", *p_addr++);
   FPA_INF("comn.fpa_trig_ctrl_timeout_dly = %u", *p_addr++);
   FPA_INF("comn.fpa_stretch_acq_trig = %u", *p_addr++);
   FPA_INF("comn.fpa_intf_data_source = %u", *p_addr++);
   FPA_INF("comn.fpa_xtra_trig_int_time = %u", *p_addr++);
   FPA_INF("comn.fpa_prog_trig_int_time = %u", *p_addr++);
   FPA_INF("comn.intclk_to_clk100_conv_numerator = %u", *p_addr++);
   FPA_INF("comn.clk100_to_intclk_conv_numerator = %u", *p_addr++);
   FPA_INF("offsetx = %u", *p_addr++);
   FPA_INF("offsety = %u", *p_addr++);
   FPA_INF("width = %u", *p_addr++);
   FPA_INF("height = %u", *p_addr++);
   FPA_INF("active_line_start_num = %u", *p_addr++);
   FPA_INF("active_line_end_num = %u", *p_addr++);
   FPA_INF("active_line_width_div4 = %u", *p_addr++);
   FPA_INF("diag.x_to_readout_start_dly = %u", *p_addr++);
   FPA_INF("diag.fval_re_to_dval_re_dly = %u", *p_addr++);
   FPA_INF("diag.lval_pause_dly = %u", *p_addr++);
   FPA_INF("diag.x_to_next_fsync_re_dly = %u", *p_addr++);
   FPA_INF("diag.xsize_div_per_pixel_num = %u", *p_addr++);
   FPA_INF("fpa_int_time_offset = %d", *p_addr++);
   FPA_INF("int_fdbk_dly = %u", *p_addr++);
   FPA_INF("kpix_pgen_en = %u", *p_addr++);
   FPA_INF("kpix_median_value = %u", *p_addr++);
   FPA_INF("use_ext_pixqnb = %u", *p_addr++);
   FPA_INF("clk_frm_pulse_width = %u", *p_addr++);
   FPA_INF("fpa_serdes_lval_num = %u", *p_addr++);
   FPA_INF("fpa_serdes_lval_len = %u", *p_addr++);
   temp_u32 = *p_addr++;
   FPA_INF("compr_ratio_fp32 = " _PCF(6), _FFMT(*p_temp_fp32, 6));
   FPA_INF("roic_tx_nb_data = %u", *p_addr++);
   FPA_INF("cfg_num = %u", *p_addr++);
   FPA_INF("vdac_value(1) = %u", *p_addr++);
   FPA_INF("vdac_value(2) = %u", *p_addr++);
   FPA_INF("vdac_value(3) = %u", *p_addr++);
   FPA_INF("vdac_value(4) = %u", *p_addr++);
   FPA_INF("vdac_value(5) = %u", *p_addr++);
   FPA_INF("vdac_value(6) = %u", *p_addr++);
   FPA_INF("vdac_value(7) = %u", *p_addr++);
   FPA_INF("vdac_value(8) = %u", *p_addr++);
}


//////////////////////////////////////////////////////////////////////////////
//  I N T E R N A L    F U N C T I O N S
//////////////////////////////////////////////////////////////////////////////

//--------------------------------------------------------------------------
// Informations sur les drivers C utilisés
//--------------------------------------------------------------------------
void FPA_SoftwType(const t_FpaIntf *ptrA)
{
   AXI4L_write32(FPA_ROIC, ptrA->ADD + AW_FPA_ROIC_SW_TYPE);
   AXI4L_write32(FPA_OUTPUT_TYPE, ptrA->ADD + AW_FPA_OUTPUT_SW_TYPE);
   AXI4L_write32(FPA_INPUT_TYPE, ptrA->ADD + AW_FPA_INPUT_SW_TYPE);
}

//--------------------------------------------------------------------------
// Pour activer/désactiver la LED de warning
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
// Pour bâtir les données de programmation du ROIC
// ptrH retourne les paramètres de FPA_SpecificParams
//--------------------------------------------------------------------------
void FPA_BuildRoicRegs(const gcRegistersData_t *pGCRegs, calcium_param_t *ptrH)
{
   extern bool gFpaWriteReg;
   extern uint8_t gFpaWriteRegAddr;
   extern uint8_t gFpaWriteRegValue;
   extern int32_t gFpaDebugRegG;       // réservé pour le contrôle interne/externe du temps d'intégration
   extern int32_t gFpaDebugRegH;       // réservé pour l'activation/désactivation du LDO de VPIXQNB

   uint8_t ii;

   // Compile-time assertions
   _Static_assert((uint32_t)CALCIUM_CLK_DDR_HZ % (uint32_t)CALCIUM_CLK_CORE_HZ == 0, "Unsupported ClkDDR/ClkCore ratio");
   _Static_assert((uint32_t)CALCIUM_CLK_CORE_HZ % (uint32_t)CALCIUM_CLK_CTRL_DSM_HZ == 0, "Unsupported ClkCore/ClkCtrlDSM ratio");
   _Static_assert((uint32_t)CALCIUM_CLK_DDR_HZ % (uint32_t)CALCIUM_CLK_COL_HZ == 0, "Unsupported ClkDDR/ClkCol ratio");

   // Traitement des demandes du debug terminal
   if (gFpaWriteReg)
   {
      // On trouve l'adresse du registre pour le modifier
      for (ii = 0; ii < NUM_OF(RoicRegs); ii++)
      {
         if (RoicRegs[ii].addr == gFpaWriteRegAddr)
         {
            RoicRegs[ii].data = gFpaWriteRegValue;
            break;
         }
      }

      // Reset de la demande du debug terminal
      gFpaWriteReg = false;
   }

   // on bâtit les paramètres spécifiques en tenant compte des valeurs possiblement changées par le debug terminal
   FPA_SpecificParams(ptrH, 0.0F, pGCRegs);

   /**
    * On calcule tous les registres qui ont une valeur imposée.
    * Le debug terminal ne peut pas les modifier.
    */

   // Clocks
   RoicRegs[bClkCoreCnt_idx].data = (uint8_t)(CALCIUM_CLK_DDR_HZ / CALCIUM_CLK_CORE_HZ);
   RoicRegs[bClkCtrlDSMDiv_idx].data = (uint8_t)(CALCIUM_CLK_CORE_HZ / CALCIUM_CLK_CTRL_DSM_HZ);
   RoicRegs[bClkColCnt_idx].data = (uint8_t)(CALCIUM_CLK_DDR_HZ / CALCIUM_CLK_COL_HZ);

   // vPixQNB
   if (sw_init_done == 0)
      gFpaDebugRegH = CALCIUM_DEFAULT_REGH;
   if (gFpaDebugRegH < 0)
      gFpaDebugRegH = 0;
   else if (gFpaDebugRegH > 1)
      gFpaDebugRegH = 1;
   b3PixAnaCtrl_b3PixQNBOvr_SET(gFpaDebugRegH);
   b3PixAnaCtrl_b3PixQNBExtEn_SET(gFpaDebugRegH);
   b3PixAnaEn_b3PixQNBEn_SET(!gFpaDebugRegH);

   // Modes
   bGenCtrl_bLoGn_SET(pGCRegs->SensorWellDepth == SWD_LowGain);
   bFrmCtrl_bITREn_SET(pGCRegs->IntegrationMode == IM_IntegrateThenRead);
   bOutCtrl_bTestModeSel_SET(pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage);

   // Integration source
   if (sw_init_done == 0)
      gFpaDebugRegG = CALCIUM_DEFAULT_REGG;
   if (gFpaDebugRegG < 0)
      gFpaDebugRegG = 0;
   else if (gFpaDebugRegG > 1)
      gFpaDebugRegG = 1;
   bFrmCtrl_bClkFrmIntCntEn_SET(gFpaDebugRegG);

   // Columns
   uint32_t bColGrpStart = pGCRegs->OffsetX/8 + 1; // first ColGrp is 1
   uint32_t bColGrpStop = (pGCRegs->OffsetX + pGCRegs->Width)/8; // last ColGrp is 80
   RoicRegs[bColGrpStart_idx].data = (uint8_t)bColGrpStart;
   RoicRegs[bColGrpStop_idx].data = (uint8_t)bColGrpStop;

   // Rows
   uint32_t bRowStart = pGCRegs->OffsetY + 1; // first row is 1
   uint32_t bRowStop = pGCRegs->OffsetY + pGCRegs->Height; // last row is 512
   RoicRegs[bRowStartLSB_idx].data = (uint8_t)bRowStart;
   RoicRegs[bRowStartMSB_idx].data = (uint8_t)(bRowStart >> 8);
   RoicRegs[bRowStopLSB_idx].data = (uint8_t)bRowStop;
   RoicRegs[bRowStopMSB_idx].data = (uint8_t)(bRowStop >> 8);

   // Row clock
   uint32_t bClkRowCnt = (uint32_t)roundf(ptrH->readoutRowTime * CALCIUM_CLK_COL_HZ - 1.0f); // delay is bClkRowCnt + 1
   RoicRegs[bClkRowCntLSB_idx].data = (uint8_t)bClkRowCnt;
   RoicRegs[bClkRowCntMSB_idx].data = (uint8_t)(bClkRowCnt >> 8);

   // Exposure time
   uint32_t bIntCnt = (uint32_t)roundf(pGCRegs->ExposureTime/1e6f * CALCIUM_CLK_CORE_HZ - 1.0f); // delay is bIntCnt + 1
   RoicRegs[bIntCntLSB_idx].data = (uint8_t)bIntCnt;
   RoicRegs[bIntCnt_idx].data    = (uint8_t)(bIntCnt >> 8);
   RoicRegs[bIntCntMSB_idx].data = (uint8_t)(bIntCnt >> 16);
   float exposureTime = (float)(bIntCnt + 1) / CALCIUM_CLK_CORE_HZ;

   // DSM
   float tDSMDelta = (float)(RoicRegs[bDSMDeltaCnt_idx].data + 1) / CALCIUM_CLK_CTRL_DSM_HZ;
   float tDSMOH = (float)(RoicRegs[bDSMOHCnt_idx].data + 1) / CALCIUM_CLK_CTRL_DSM_HZ;
   float tDSMQRst = (float)(RoicRegs[bDSMQRstCnt_idx].data + 1) / CALCIUM_CLK_CTRL_DSM_HZ;
   // on commence avec le délai minimum et la valeur finale sera calculée plus tard
   uint32_t bDSMDelayCnt = 0;
   float tDSMDelay = (float)(bDSMDelayCnt + 1) / CALCIUM_CLK_CTRL_DSM_HZ;
   // on commence avec le nombre de cycles maximum et la valeur finale sera calculée plus tard
   uint32_t bDSMCycles = 255;
   float tDSMPeriod = tDSMDelta + tDSMOH + tDSMQRst + tDSMDelay;
   float tDSMTotal = tDSMDelay + (float)(bDSMCycles + 1) * tDSMPeriod;
   // on calcule bDSMDelayCnt and bDSMCycles en fonction du temps d'intégration.
   if (exposureTime > tDSMTotal)
   {
      // le temps d'intégration est plus long que le temps total
      // - on conserve le maximum de cycles
      // - on augmente le délai pour que le temps total soit aussi long que le temps d'intégration
      tDSMDelay = (exposureTime - (float)(bDSMCycles + 1) * (tDSMDelta + tDSMOH + tDSMQRst)) / (float)(bDSMCycles + 2);
      bDSMDelayCnt = MAX((uint32_t)(tDSMDelay * CALCIUM_CLK_CTRL_DSM_HZ - 1.0f), 0); // delay is bDSMDelayCnt + 1
   }
   else
   {
      // le temps d'intégration est plus court que le temps total de DSM
      // - on conserve le délai minimum
      // - on diminue le nombre de cycles jusqu'à ce que le temps total soit aussi long que le temps d'intégration
      bDSMCycles = MAX((uint32_t)((exposureTime - tDSMDelay) / tDSMPeriod - 1.0f), 0);
   }
   RoicRegs[bDSMCyclesLSB_idx].data = (uint8_t)bDSMCycles;
   RoicRegs[bDSMCyclesMSB_idx].data = (uint8_t)(bDSMCycles >> 8);
   RoicRegs[bDSMDelayCntLSB_idx].data = (uint8_t)bDSMDelayCnt;
   RoicRegs[bDSMDelayCntMSB_idx].data = (uint8_t)(bDSMDelayCnt >> 8);
   // on utilise bDSMInitDelayCnt = bDSMDelayCnt
   RoicRegs[bDSMInitDelayCntLSB_idx].data = (uint8_t)bDSMDelayCnt;
   RoicRegs[bDSMInitDelayCntMSB_idx].data = (uint8_t)(bDSMDelayCnt >> 8);
}

//--------------------------------------------------------------------------
// Pour envoyer les données de programmation au ROIC
//--------------------------------------------------------------------------
void FPA_SendRoicRegs(const t_FpaIntf *ptrA)
{
   extern bool gFpaReadReg;

   uint32_t *p_addr = (uint32_t *)(ptrA->ADD + ARW_PROG_MEM_BASE_ADD) + PROG_MEM_TX_OFFSET;  // l'offset est divisé par 4 dans le vhd
   uint8_t nbRegs = ptrA->roic_tx_nb_data;   // header inclus
   uint8_t ii;
   uint8_t writeFlag = 1;  // par défaut on écrit la config contenue dans RoicRegs
   t_RoicRegister dataMask = {.word = 0xFFFF};   // par défaut l'adresse et le data ne sont pas masqués

   // Reset des données reçues
   AXI4L_write32(1, ptrA->ADD + AW_RESET_ROIC_RX_DATA);
   AXI4L_write32(0, ptrA->ADD + AW_RESET_ROIC_RX_DATA);

   // Traitement des demandes du debug terminal
   if (gFpaReadReg)
   {
      writeFlag = 0;
      dataMask.data = 0;   // le data est forcé à 0
   }

   FPA_PRINTF("%u registers sent to ROIC", nbRegs);
   nbRegs--;   // on enlève le header

   // Envoi du header
   uint16_t header = (uint16_t)(HDR_START_PATTERN | HDR_LOAD_BIT(writeFlag) | HDR_FRM_SYNC | HDR_PAGE_ID | HDR_NBR_DATA(nbRegs));
   *p_addr++ = (uint32_t)header;
   FPA_PRINTF(" 0x%04X", header);

   // Envoi des registres
   for (ii = 0; ii < nbRegs; ii++)
   {
      *p_addr++ = (uint32_t)(RoicRegs[ii].word & dataMask.word);
      FPA_PRINTF(" 0x%04X", (RoicRegs[ii].word & dataMask.word));
   }
}

//--------------------------------------------------------------------------
// Pour lire les données reçues du ROIC
//--------------------------------------------------------------------------
void FPA_ReadRoicRegs(const t_FpaIntf *ptrA)
{
   uint32_t *p_addr = (uint32_t *)(ptrA->ADD + ARW_PROG_MEM_BASE_ADD) + PROG_MEM_RX_OFFSET;  // l'offset est divisé par 4 dans le vhd
   uint8_t nbRegs;
   uint8_t ii;
   uint64_t tic_timeout;

   // On attend que les données soient reçues
   GETTIME(&tic_timeout);
   do
      nbRegs = (uint8_t)AXI4L_read32(ptrA->ADD + AR_ROIC_RX_NB_DATA);
   while ((nbRegs == 0) && (elapsed_time_us(tic_timeout) < WAITING_FOR_ROIC_RX_DATA_TIMEOUT_US));

   FPA_INF("%u registers read from ROIC", nbRegs);

   // Lecture des registres
   for (ii = 0; ii < nbRegs; ii++)
   {
      FPA_INF(" 0x%04X", *p_addr++);
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
      AXI4L_write32(ptrD->vdac_value[ii], ptrA->ADD + AW_DAC_CFG_BASE_ADD + 4*ii);
      ii++;
   }
}
