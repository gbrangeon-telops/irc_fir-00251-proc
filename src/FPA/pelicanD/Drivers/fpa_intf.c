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

#include "GeniCam.h"
#include "fpa_intf.h"
#include "flashSettings.h"
#include "utils.h"
#include "IRC_status.h"
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
 

// Peride minimale des xtratrigs (utilis� par le hw pour avoir le temps de programmer le d�tecteur entre les trigs. Commande operationnelle et syhthetique seulement)
#define SCD_XTRA_TRIG_FREQ_MAX_HZ         SCD_MIN_OPER_FPS

//  PCO 23 avril 2020 : Correction par rapport � la doc de SCD (d1k3008-rev1).
#define T0_CORR                           -40.0E-6F // [s],  N�cessaire pour maintenir des specs �quivalentes entre IWR et ITR (voir redmine 14065 pour justifications).
#define T_lINE_CONV_CORR                  12.0F     // [TFPP clks], N�cessaire pour ne pas faire planter le proxy (voir redmine 14065 pour justifications).
  

// Parametres de la commande serielle du PelicanD
#define SCD_LONGEST_CMD_BYTES_NUM         33      // longueur en bytes de la plus longue commande serielle du PelicanD
#define SCD_CMD_OVERHEAD_BYTES_NUM        6       // longueur des bytes autres que ceux des donn�es

// Mode d'operation choisi pour le contr�leur de trig 
#define MODE_READOUT_END_TO_TRIG_START     0x00    // provient du fichier fpa_common_pkg.vhd. Ce mode est choisi car plus simple pour le PelicanD
#define MODE_TRIG_START_TO_TRIG_START      0x01
#define MODE_INT_END_TO_TRIG_START         0x02
#define MODE_ITR_TRIG_START_TO_TRIG_START  0x03    
#define MODE_ITR_INT_END_TO_TRIG_START     0x04
#define MODE_ALL_END_TO_TRIG_START         0x05



// PelicanD integration modes definies par SCD  
#define SCD_ITR_MODE                      0x00    // valeur provenant du manuel de SCD
#define SCD_IWR_MODE                      0x01    // valeur provenant du manuel de SCD

// PelicanD mode of operation define by SCD
#define SCD_BOOST_MODE                    0x00    // valeur provenant du manuel de SCD
#define SCD_NORMAL_MODE                   0x01    // valeur provenant du manuel de SCD

// PelicanD gains definis par SCD  
#define SCD_GAIN_0                        0x00   // plus gros puits
#define SCD_GAIN_1                        0x02   // plus petit puits

// PelicanD Clink modes
#define SCD_CLINK_1_CHN                   0x01   // mode clink 1 channel (base) tel que d�fini par scd
#define SCD_CLINK_2_CHN                   0x00   // mode clink 2 channel (medium) tel que d�fini par scd

// PelicanD Bias
static const uint8_t Scd_DiodeBiasValues[] = {
      0x0A,    // 1pA
      0x0B,    // 10pA
      0x0C,    // 100pA
      0x02,    // 300pA
      0x03,    // 1nA
      0x04,    // 3nA
      0x0D     // 10nA
};
#define SCD_BIAS_DEFAULT_IDX              2     // 100pA (default)
#define SCD_BIAS_VALUES_NUM               (sizeof(Scd_DiodeBiasValues) / sizeof(Scd_DiodeBiasValues[0]))

// PelicanD Pixel resolution 
#define SCD_PIX_RESOLUTION_15BITS         0x00    // 15 bits selon SCD
#define SCD_PIX_RESOLUTION_14BITS         0x01    // 14 bits selon SCD
#define SCD_PIX_RESOLUTION_13BITS         0x02    // 13 bits selon SCD

// adresse de base pour l'aiguilleur de config dans le vhd.
#define AW_SERIAL_CFG_SWITCH_ADD          0x0800  // l'aiguilleur enverra la config en ram

//partition dans la ram Vhd des config (mapp�es sur FPA_define)
#define AW_SERIAL_OP_CMD_RAM_BASE_ADD     0       // adresse de base en ram pour la cmd opertaionnelle
#define AW_SERIAL_INT_CMD_RAM_BASE_ADD    64      // adresse de base en ram pour la cmd int_time (la commande est impl�ment�e uniquement dans le vhd)
#define AW_SERIAL_DIAG_CMD_RAM_BASE_ADD   128     // adresse de base en ram pour la cmd diag de scd
#define AW_SERIAL_TEMP_CMD_RAM_BASE_ADD   192     // adresse de base en ram pour la cmd read temperature
#define AW_SERIAL_FRAME_RES_CMD_RAM_BASE_ADD   256     // Only use by BB1280

// les ID des commandes
#define SCD_INT_CMD_ID                    0x8001
#define SCD_OP_CMD_ID                     0x8002
#define SCD_DIAG_CMD_ID                   0x8004
#define SCD_TEMP_CMD_ID                   0x8021
                      
// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400  // adresse de base 
#define AR_PRIVATE_STATUS_BASE_ADD        0x0800  // adresse de base des statuts specifiques ou priv�es
#define AR_FPA_TEMPERATURE                0x002C  // adresse temperature
#define AR_FPA_INT_TIME                   0x00C0  // adresse temps d'int�gration

// adresse d'ecriture du signal declencant la lecture de temperature
#define AW_TEMP_READ_NUM_ADD              0xD0

// adresse d'�criture du r�gistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xE0   // dit au VHD quel type de roiC de fpa le pilote en C est con�u pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xE4   // dit au VHD quel type de sortie de fpa e pilote en C est con�u pour.

// adresse d'ecriture signifiant la fin de la commande serielle pour le vhd
#define AW_SERIAL_CFG_END_ADD             0xFC    

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC_PELICAND                 0x16   // provient du fichier fpa_common_pkg.vhd. La valeur 0x16 est celle de FPA_ROIC_PELICAND
#define OUTPUT_DIGITAL                    0x02   // provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL

// adresse d'�criture du r�gistre du reset des erreurs
#define AW_RESET_ERR                      0xEC

// adresse d'�criture du r�gistre du reset du module FPA
#define AW_CTRLED_RESET                   0xF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de SCD)
#define TELOPS_DIAG_CNST                  0xD1      // mode diag constant (patron de test gener� par la carte d'acquisition : tous les pixels � la m�me valeur) 
#define TELOPS_DIAG_DEGR                  0xD2      // mode diag d�grad� lin�aire(patron de test d�grad� lin�airement et g�n�r� par la carte d'acquisition).Requis en production
#define TELOPS_DIAG_DEGR_DYN              0xD3      // mode diag d�grad� lin�aire dynamique(patron de test d�grad� lin�airement et variant d'image en image et g�n�r� par la carte d'acquisition)  

#define SCD_PE_NORM_OUTPUT 0
#define SCD_PE_IO_TEST1    2
#define SCD_PE_IO_TEST2    3
#define SCD_PE_TEST1       4

#define VHD_INVALID_TEMP   0xFFFFFFFF
#define VHD_ITR_PIPE_DLY_SEC             500E-9F     // estimation des differerents delais accumul�s par le vhd
#define VHD_IWR_PIPE_DLY_SEC             250E-9F     // estimation des differerents delais accumul�s par le vhd


// structure interne pour les parametres des figure1 et 2 ( se reporter au document Communication Protocol Appendix A5 (SPEC. NO: DPS3008) de SCD) 
struct Scd_Fig1orFig2Param_s             // 
{					   
   float TFPP_CLK;                       
   float Trelax;
   float Tline_conv;
   float Tframe_init;
   float T_lc2int;
   float T_iwr_delay;
   float T0;
   float T1;
   float T2;
   float T3;
   float T4;
   float T5min;
   float T5;
   float T6;
   float T7;
   float T8;
};
typedef struct Scd_Fig1orFig2Param_s Scd_Fig1orFig2Param_t;

// structure interne pour les parametres de la figure 4 ( se reporter au document Communication Protocol Appendix A5 (SPEC. NO: DPS3008) de SCD) 
struct Scd_Fig4Param_s             // 
{					   
   float T1;
   float T2;
   float T3;
   float T4;
   float T5;
   float T6;      
};
typedef struct Scd_Fig4Param_s Scd_Fig4Param_t;

// structure interne pour les commandes de Scd
struct Command_s             // 
{					   
   uint8_t  Header;
   uint16_t ID;
   uint16_t DataLength;
   uint8_t  Data[SCD_LONGEST_CMD_BYTES_NUM - SCD_CMD_OVERHEAD_BYTES_NUM];
   uint16_t  SerialCmdRamBaseAdd;  // ajout� pour envoyer la commande � la bonne adresse dans la RAm
   // cheksum est calcul� seulement lors de l'envoi 
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


// statuts priv�s du module fpa
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

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Fig1orFig2SpecificParams(Scd_Fig1orFig2Param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
void FPA_Fig4SpecificParams(Scd_Fig4Param_t *ptrK, const gcRegistersData_t *pGCRegs);
void FPA_SendSyntheticVideo_SerialCmd(const t_FpaIntf *ptrA);
void FPA_SendOperational_SerialCmd(const t_FpaIntf *ptrA);
void FPA_ReadTemperature_StructCmd(const t_FpaIntf *ptrA);
void FPA_ReadTemperature_SerialCmd(const t_FpaIntf *ptrA);
void FPA_BuildCmdPacket(ScdPacketTx_t *ptrE, const Command_t *ptrC);
void FPA_SendCmdPacket(ScdPacketTx_t *ptrE, const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
void FPA_GetPrivateStatus(t_FpaPrivateStatus *PrivateStat, const t_FpaIntf *ptrA);


// Global variables (Only used by BB1280), TODO : A supprimer lorsque les commandes de debug du BB1280 ne seront plus necessaire.
uint32_t gSCD_frame_dly = 0;
uint32_t gSCD_intg_dly  = 0;
uint32_t gSCD_frame_res = 0;

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de d�part
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{
   sw_init_done = 0;
   sw_init_success = 0;
   
   FPA_Reset(ptrA);                                                         // on fait un reset du module FPA. 
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides SCD Detector   
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est con�u pour.
   FPA_GetTemperature(ptrA);
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoy�e au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
   
   sw_init_done = 1;
   sw_init_success = 1;
}
 
void FPA_SetFrameResolution(t_FpaIntf *ptrA)// TODO : A supprimer apr�s le debug de BB1280
{
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
// retenir qu'apr�s reset, les IO sont en 'Z' apr�s cela puisqu'on desactive le SoftwType dans le vhd. (voir vhd pour plus de details)
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
   Scd_Fig1orFig2Param_t hh;
   Scd_Fig4Param_t kk;
   float fpaAcquisitionFrameRate;
   extern uint8_t gFpaScdDiodeBiasEnum;
   static uint8_t cfg_num = 0;
   
   //-----------------------------------------                                           
   // b�tir les configurations
   
   // on appelle les fonctions pour b�tir les parametres specifiques du pelicanD
   FPA_Fig1orFig2SpecificParams(&hh, 0.0F, pGCRegs);               //le temps d'integration est nul car aucune influence sur les parametres sauf sur la periode. Mais le VHD ajoutera le int_time pour avoir la vraie periode
   FPA_Fig4SpecificParams(&kk, pGCRegs);
   
   // diag mode and diagType
   ptrA->fpa_diag_mode = 0;                 // par defaut
   ptrA->fpa_diag_type = 0;                 // par defaut   
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade)           // mode diagnostique degrad� lineaire
   {  
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR;
   }   
   else if (pGCRegs->TestImageSelector == TIS_TelopsConstantValue1)      // mode diagnostique avec valeur constante
   {   
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_CNST;
   }
   else if (pGCRegs->TestImageSelector == TIS_TelopsDynamicShade)
   {
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR_DYN;   
   }
   
   // allumage du d�tecteur 
   ptrA->fpa_pwr_on  = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas r�unies
   
   // config du contr�leur de trigs (il est sur l'horolge de 100MHz)
   if (pGCRegs->IntegrationMode == IM_IntegrateThenRead)
   {
      ptrA->fpa_trig_ctrl_mode        = (uint32_t)MODE_INT_END_TO_TRIG_START;    // ENO : 21 juin 2016: Op�rer le PelicanD en mode MODE_INT_END_TO_TRIG_START pour s'affranchir du temps d'int�gration
      ptrA->fpa_acq_trig_ctrl_dly     = (uint32_t)(MAX((hh.T3 + hh.T5 + hh.T6 - (float)VHD_ITR_PIPE_DLY_SEC), 0.0F) * (float)FPA_VHD_INTF_CLK_RATE_HZ); 
   }
   else
   {
      ptrA->fpa_trig_ctrl_mode     = (uint32_t)MODE_ALL_END_TO_TRIG_START; // ENO : 30 mars 2020 : T5 is referenced to the end of integration or readout depending which is the longest. Thus the recommended mode is MODE_ALL_END_TO_TRIG_START
      ptrA->fpa_acq_trig_ctrl_dly  = (uint32_t)((hh.T5 - (float)VHD_IWR_PIPE_DLY_SEC) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   }

   ptrA->fpa_spare                 = 0;   //
   ptrA->fpa_xtra_trig_ctrl_dly    = (uint32_t)((float)FPA_VHD_INTF_CLK_RATE_HZ / (float)SCD_XTRA_TRIG_FREQ_MAX_HZ);
   ptrA->fpa_trig_ctrl_timeout_dly = (uint32_t)((float)ptrA->fpa_xtra_trig_ctrl_dly);
   if (ptrA->fpa_diag_mode == 1)
   {
      ptrA->fpa_trig_ctrl_mode        = (uint32_t)MODE_READOUT_END_TO_TRIG_START;    // ENO : 21 fev 2019: pour les detecteurs numeriques, operer le diag mode en MODE_READOUT_END_TO_TRIG_START car le diag_mode est plus lent que le d�tecteur 
      ptrA->fpa_acq_trig_ctrl_dly     = 0; 
   }
   
#ifdef SIM
   ptrA->fpa_trig_ctrl_timeout_dly = (uint32_t)((float)FPA_VHD_INTF_CLK_RATE_HZ / 2.5e3F);     //  2.5 KHz en simulation
   ptrA->fpa_xtra_trig_ctrl_dly    = ptrA->fpa_trig_ctrl_timeout_dly;
#endif
   
   
   //  window
   ptrA->scd_xstart = pGCRegs->OffsetX;    
   ptrA->scd_ystart = pGCRegs->OffsetY;     
   ptrA->scd_xsize  = pGCRegs->Width;     
   ptrA->scd_ysize  = pGCRegs->Height;
    
   //  gain 
   ptrA->scd_gain = SCD_GAIN_0;
   if (pGCRegs->SensorWellDepth == SWD_HighGain)
      ptrA->scd_gain = SCD_GAIN_1;
    
   // nombre de canaux de sorties     
   ptrA->scd_out_chn    = SCD_CLINK_2_CHN;           // nombre de canaux CLINK. Nous serons en full tout le temps car le vhd a �t� con�u ainsi 
   //if ((uint32_t)FPA_NUM_CH == 1)
      //ptrA->scd_out_chn    = SCD_CLINK_1_CHN;
                                           
   // bias 
   if (gFpaScdDiodeBiasEnum >= SCD_BIAS_VALUES_NUM)
      gFpaScdDiodeBiasEnum = SCD_BIAS_DEFAULT_IDX;    // corrige une valeur invalide
   ptrA->scd_diode_bias = Scd_DiodeBiasValues[gFpaScdDiodeBiasEnum];

   // integration modes
   ptrA->scd_int_mode = SCD_IWR_MODE;
   if (pGCRegs->IntegrationMode == IM_IntegrateThenRead) 
      ptrA->scd_int_mode = SCD_ITR_MODE; 

   //Mode of operation
   ptrA->scd_boost_mode = SCD_BOOST_MODE;

   // Resolution des pixels (13, 14 ou 15 bits)
   ptrA->scd_pix_res = SCD_PIX_RESOLUTION_13BITS;    // resolution pour l'instant fig�e � 13 bits   
    
   // frame_period_min
   //on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur   
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);
   ptrA->scd_frame_period_min = (uint32_t)(1.0F/MAX(SCD_MIN_OPER_FPS, fpaAcquisitionFrameRate) * (float)FPA_MCLK_RATE_HZ);
   FPGA_PRINTF("scd_frame_period_min = %d x 12.5ns\n", ptrA->scd_frame_period_min);
   
   // mode diag scd
   ptrA->scd_bit_pattern = 0;
   if ((pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage1) ||
         (pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage2) ||
         (pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage3))
      ptrA->scd_bit_pattern = SCD_PE_TEST1;
   
   // valeurs converties en coups d'horloge du module FPA_INTF
   // valeurs utilis�es en mode patron de test seulement
   ptrA->scd_fsync_re_to_intg_start_dly = (uint32_t)((hh.T4) * (float)FPA_VHD_INTF_CLK_RATE_HZ); //horloge VHD � 100 MHz
   ptrA->scd_x_to_readout_start_dly = (uint32_t)((hh.T6) * (float)FPA_VHD_INTF_CLK_RATE_HZ); //horloge VHD � 100 MHz
   ptrA->scd_x_to_next_fsync_re_dly = (uint32_t)(0.80F * (hh.T5) * (float)FPA_VHD_INTF_CLK_RATE_HZ); // 0.80 pour s'assurer le fonctionnement pleine vitesse en mode diag
   ptrA->scd_fsync_re_to_fval_re_dly = (uint32_t)((kk.T1) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_fval_re_to_dval_re_dly = (uint32_t)((kk.T2) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_lval_high_duration = (uint32_t)((kk.T3) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_lval_pause_dly = (uint32_t)((kk.T4) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_hdr_start_to_lval_re_dly = (uint32_t)((kk.T5) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_hdr_high_duration = (uint32_t)((kk.T6) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_xsize_div_per_pixel_num  =  ptrA->scd_xsize/FPA_CLINK_PIX_NUM;  // Les test patterns sont g�n�r�s sur 2 channels, peu importe FPA_NUM_CH.
   
   // �largit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;

   // Changement de cfg_num d�s qu'une nouvelle cfg est envoy�e au vhd. Permet de forcer la reprogramation du proxy � chaque fois que cette fonction est appel�e.
   if (cfg_num == 255)  // protection contre depassement
      cfg_num = 0;
   cfg_num++;
   ptrA->cfg_num = (uint32_t)cfg_num;

   //-----------------------------------------                                           
   // Envoyer commande synthetique
   ptrA->proxy_cmd_to_update_id = SCD_DIAG_CMD_ID;
   WriteStruct(ptrA);   // on envoie au complet les parametres pour toutes les parties (partie common etc...)                           
   FPA_SendSyntheticVideo_SerialCmd(ptrA);         // on envoie la partie serielle de la commande video synthetique (elle est stock�e dans une partie de la RAM en vhd)
   
   // Envoyer commande operationnelle
   ptrA->proxy_cmd_to_update_id = SCD_OP_CMD_ID;
   WriteStruct(ptrA);   // on envoie de nouveau au complet les parametres pour toutes les parties (partie common etc...). Ce nouvel envoi vise � a;erter l'arbitreur vhd 
   FPA_SendOperational_SerialCmd(ptrA);            // on envoie la partie serielle de la commande operationnelle (elle est stock�e dans une autre partie de la RAM en vhd)// ensuite on envoie la partie serielle de la commande pour la RAM vhd 
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la temp�rature du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{
   uint32_t raw_temp;
   float diode_voltage;
   float temperature = 0.0F;
   
   // demande de lecture de la temperature temp(n)
   FPA_ReadTemperature_StructCmd(ptrA);      // envoi un interrupt au contr�leur du hw driver
   FPA_ReadTemperature_SerialCmd(ptrA);      // envoi la commande serielle    
   
   // lecture et conversion de la temperature temp(n-1)
   raw_temp = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_TEMPERATURE);  // lit le registre de temperature (fort probablement pas le pr�sent mais le pass�) 

   if (raw_temp == (uint32_t)VHD_INVALID_TEMP)
   {
      return FPA_INVALID_TEMP;
   }
   else
   {
      diode_voltage = (float)(raw_temp & 0x0000FFFF) * 4.5776F * 1.0e-5F;
   
      // utilisation  des valeurs de flashsettings
      temperature  = flashSettings.FPATemperatureConversionCoef5 * powf(diode_voltage,5);
      temperature += flashSettings.FPATemperatureConversionCoef4 * powf(diode_voltage,4);
      temperature += flashSettings.FPATemperatureConversionCoef3 * powf(diode_voltage,3);
      temperature += flashSettings.FPATemperatureConversionCoef2 * powf(diode_voltage,2);
      temperature += flashSettings.FPATemperatureConversionCoef1 * diode_voltage;
      temperature += flashSettings.FPATemperatureConversionCoef0;  
 
      // Si flashsettings non programm�s alors on utilise les valeurs par defaut
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
// Pour avoir le frameRateMax avec une config donn�e
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float period, MaxFrameRate;   
   Scd_Fig1orFig2Param_t Scd_Fig1orFig2Param;
   FPA_Fig1orFig2SpecificParams(&Scd_Fig1orFig2Param, (float)pGCRegs->ExposureTime, pGCRegs);
   period = Scd_Fig1orFig2Param.T0;      // selon scd : T0 = frame period

#ifdef SIM
   PRINTF("FPA_Period_Min_usec = %f\n", 1e6F*period);
#endif
   MaxFrameRate = 1.0F / period;

   // ENO: 10 sept 2016: Apply margin 
   MaxFrameRate = MaxFrameRate * (1.0F - gFpaPeriodMinMargin);
   
   // Round maximum frame rate
   MaxFrameRate = floorMultiple(MaxFrameRate, 0.01);

   return MaxFrameRate;
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir le ExposureMax avec une config donn�e
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   float maxExposure_us, periodMinWithNullExposure;
   float operatingPeriod, fpaAcquisitionFrameRate;
   Scd_Fig1orFig2Param_t hh;

   // ENO: 10 sept 2016: d'entr�e de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur   
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);

   // ENO: 10 sept 2016: tout reste inchang�
   FPA_Fig1orFig2SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition �tait nulle
   periodMinWithNullExposure = hh.T0;
   operatingPeriod = 1.0F / MAX(SCD_MIN_OPER_FPS, fpaAcquisitionFrameRate); // periode avec le frame rate actuel. Doit tenir compte de la contrainte d'op�ration du d�tecteur
   
   maxExposure_us = (operatingPeriod - periodMinWithNullExposure)*1e6F;
   
   maxExposure_us = maxExposure_us/1.001F;    // cette division tient du fait que dans la formule de T0, le temps d'exposition intervient avec un facteur 1 + 0.1/100
   
   if (pGCRegs->IntegrationMode == IM_IntegrateWhileRead)
      maxExposure_us += (hh.T3 + hh.T6 + T0_CORR)*1e6F;
   // Round exposure time
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
   Stat->hw_init_done                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x80);
   Stat->hw_init_success              = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x84);
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


//////////////////////////////////////////////////////////////////////////////                                                                          
//  I N T E R N A L    F U N C T I O N S 
////////////////////////////////////////////////////////////////////////////// 

//--------------------------------------------------------------------------
// Informations sur les drivers C utilis�s. 
//--------------------------------------------------------------------------
void  FPA_SoftwType(const t_FpaIntf *ptrA)
{
   AXI4L_write32(FPA_ROIC_PELICAND, ptrA->ADD + AW_FPA_ROIC_SW_TYPE);          
   AXI4L_write32(OUTPUT_DIGITAL, ptrA->ADD + AW_FPA_OUTPUT_SW_TYPE);		     
}

//-------------------------------------------------------
// Pelicand specifics timings
//-------------------------------------------------------
void FPA_Fig1orFig2SpecificParams(Scd_Fig1orFig2Param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // Se reporter au document d1k3008-rev1 et d1k3004-rev0 de SCD
   
   uint8_t PELICAND_1CH_EMULATOR = 0;
   if (flashSettings.AcquisitionFrameRateMaxDivider > 1.0F)         // 2019-07-15 ODI: emulateur 1 channel des que le diviseur > 1 (valeur par d�faut)
      PELICAND_1CH_EMULATOR = 1;
   
   if (pGCRegs->IntegrationMode == IM_IntegrateWhileRead)
   {
      ptrH->TFPP_CLK  = 1.0F / ((float)FPA_MCLK_RATE_HZ);
      if (PELICAND_1CH_EMULATOR)
         ptrH->Tline_conv = 1296.0F * ptrH->TFPP_CLK;      // ENO 24 juin 2019 : on emule un PelicanD 1 canal
      else
         ptrH->Tline_conv = (804.0F + T_lINE_CONV_CORR) * ptrH->TFPP_CLK;       //  PCO 23 avril 2020 : Non respect de la doc d1k3008-rev1 (voir redmine 14065 pour justifications).

      ptrH->Tframe_init = 2128.0F * ptrH->TFPP_CLK;
      ptrH->T2        = exposureTime_usec * 1E-6F;
      ptrH->T4        = 1E-6F;
      ptrH->T5min     = (6448.0F * ptrH->TFPP_CLK) + (2 * ptrH->Tline_conv) + 8.88E-6F;
      ptrH->Trelax    = 5E-6F;
      ptrH->T_lc2int  = 5E-6F;
      ptrH->T_iwr_delay = ptrH->T_lc2int + ptrH->Trelax;

      ptrH->T6 = 5.4E-6F + (ptrH->Tframe_init + ptrH->T_iwr_delay); //  PCO 23 avril 2020 : Non respect de la doc d1k3008-rev1 (voir redmine 14065 pour justifications).

      ptrH->T8        = 250E-6F; // worst case
      ptrH->T3        = ptrH->Tframe_init + (ptrH->Tline_conv * ((float)pGCRegs->Height / 2.0F + 3.0F)) + ptrH->T_iwr_delay;

      // Use the longest between integration and readout times
      if (ptrH->T2 > (ptrH->T3 + ptrH->T6))
         // T0 = T2 + T4 + T5  and  T5 = T5min + 0.1%T0
         ptrH->T0        = (ptrH->T2 + ptrH->T4 + ptrH->T5min) / (99.9F / 100.0F);
      else
      // T0 = T3 + T4 + T5 + T6  and  T5 = T5min + 0.1%T0
      ptrH->T0        = (ptrH->T3 + ptrH->T4 + ptrH->T5min + ptrH->T6) / (99.9F / 100.0F);

      ptrH->T0        = ptrH->T0 + T0_CORR;    //  PCO 23 avril 2020 : Non respect de la doc d1k3008-rev1 (voir redmine 14065 pour justifications).
      ptrH->T0        = MIN(ptrH->T0, 90E-3F); // don't forget that T0 must be < 90msec

      ptrH->T5        = ptrH->T5min + (ptrH->T0 * 0.1F / 100.0F);
      ptrH->T7        = 300E-6F + (ptrH->T0 * 0.1F / 100.0F);
   }
   else // ITR mode
   {      
      ptrH->TFPP_CLK  = 1.0F / ((float)FPA_MCLK_RATE_HZ);
      if (PELICAND_1CH_EMULATOR)
         ptrH->Tline_conv = 1296.0F * ptrH->TFPP_CLK;       // ENO 24 juin 2019 : on emule un PelicanD 1 canal
      else
         ptrH->Tline_conv = 816.0F * ptrH->TFPP_CLK;        //13 bit resolution

      ptrH->Tframe_init = 2128.0F * ptrH->TFPP_CLK;
      ptrH->T2        = exposureTime_usec * 1E-6F;
      ptrH->T4        = 1E-6F;
      ptrH->T5min     = (6448.0F * ptrH->TFPP_CLK) + (2 * ptrH->Tline_conv);
      ptrH->Trelax    = 10E-6F;
      ptrH->T6        = ptrH->Trelax;
      ptrH->T8        = 250E-6F;
      ptrH->T3        = ptrH->Tframe_init + (ptrH->Tline_conv * ((float)pGCRegs->Height / 2.0F + 4.0F));

      // T0 = T2 + T3 + T4 + T5 + T6  and  T5 = T5min + 0.1%T0
      ptrH->T0        = (ptrH->T2 + ptrH->T3 + ptrH->T4 + ptrH->T5min + ptrH->T6) / (99.9F / 100.0F);
      ptrH->T0        = MIN(ptrH->T0, 90E-3F); // don't forget that T0 must be < 90msec

      ptrH->T5        = ptrH->T5min + (ptrH->T0 * 0.1F / 100.0F);
      ptrH->T7        = 300E-6F + (ptrH->T0 * 0.1F / 100.0F);
   }
   
   // verification des calculs en simulation
#ifdef SIM
   PRINTF("1e10 * ptrH->TFPP_CLK = %d\n", (uint32_t)(1e10*ptrH->TFPP_CLK));
   PRINTF("1e10 * ptrH->T2 = %d\n", (uint32_t)(1e10*ptrH->T2));
   PRINTF("1e10 * ptrH->T4 = %d\n", (uint32_t)(1e10*ptrH->T4));
   PRINTF("1e10 * ptrH->T5min = %d\n", (uint32_t)(1e10*ptrH->T5min));
   PRINTF("1e10 * ptrH->T6 = %d\n", (uint32_t)(1e10*ptrH->T6));
   PRINTF("1e10 * ptrH->T7 = %d\n", (uint32_t)(1e10*ptrH->T7));
   PRINTF("1e10 * ptrH->T8 = %d\n", (uint32_t)(1e10*ptrH->T8));
   PRINTF("1e10 * ptrH->Tline_conv = %d\n", (uint32_t)(1e10*ptrH->Tline_conv));
   PRINTF("1e10 * ptrH->T3 = %d\n", (uint32_t)(1e10*ptrH->T3));
   PRINTF("1e10 * ptrH->T5 = %d\n", (uint32_t)(1e10*ptrH->T5));
   PRINTF("1e10 * ptrH->T0 = %d\n", (uint32_t)(1e10*ptrH->T0));
#endif
   
}

void FPA_Fig4SpecificParams(Scd_Fig4Param_t *ptrK, const gcRegistersData_t *pGCRegs)
{
   // ATTENTION!! ne pas changer l'ordre des calculs des parametres
   // se reporter au document Communication Protocol Appendix A5 (SPEC. NO: DPS3008) de SCD
   
   // Update on 2016-04-28 with spec D1K3008-RevA.1 from SCD

   Scd_Fig1orFig2Param_t hh;
   FPA_Fig1orFig2SpecificParams(&hh, 0.0F, pGCRegs);
   
   ptrK->T2  = 5.0F * hh.TFPP_CLK;  // un peu plus de 0
   if (pGCRegs->IntegrationMode == IM_IntegrateThenRead)
      ptrK->T1  = ptrK->T2;
   else
      ptrK->T1  = hh.Tline_conv + 2e-6F;

   // Ces timings sont utilis�s pour la g�n�ration des test patterns seulement.
   // Les test patterns sont g�n�r�s sur 2 channels, peu importe FPA_NUM_CH.
   // Pour les pauses, on utilise le plus long.
   ptrK->T3  = 320.0F * hh.TFPP_CLK;   // 2ch
   ptrK->T4  = 22.0F * hh.TFPP_CLK;    // plus long 1 ou 2ch
   ptrK->T5  = 80e-6F;                 // plus long 1 ou 2ch
   ptrK->T6  = 64.0F * hh.TFPP_CLK;    // 2ch
}


// process time non requis pour l'instant pour Tel-2000 car l'�lectronique ne devrait pas limiter la vitesse du FPA 
 
////-------------------------------------------------------
//// FPGA Process Time
////-------------------------------------------------------
//float FPGA_ProcessTime()
//{
//   float effective_LL_CLK;
//   float processTime;
//   float readoutTime;
//   
//   readout_time = FPA_ReadoutTime();   
//   
//   if(pGCRegs->ClConfiguration == CC_Base)
//      effective_LL_CLK = MIN( (float) LL_CLOCK_FREQ_HZ_BASE / 1.004F, gLimited_LL_CLK );
//   else
//      effective_LL_CLK = MIN( (float) LL_CLOCK_FREQ_HZ / 1.004F, gLimited_LL_CLK );   
//   
//   processTime = (float) (pGCRegs->Width * (pGCRegs->Height + 2)) / effective_LL_CLK;
//   processTime = MAX(processTime, readoutTime);
//   return processTime;
//}

//-------------------------------------------------------
// Commande temperature : envoi partie structurale
//-------------------------------------------------------
void FPA_ReadTemperature_StructCmd(const t_FpaIntf *ptrA)    
{      
   static uint8_t tempReadNum = 0;
                 
   if (tempReadNum == 255)  // protection contre depassement
      tempReadNum = 0;
      
   tempReadNum++;
   
   // 3 envois juste pour donner du temps � l'arbitreur de prendre la commande
   AXI4L_write32((uint32_t)tempReadNum, ptrA->ADD + AW_TEMP_READ_NUM_ADD);  // cela envoi un signal au contr�leur du hw_driver pour la lecture de la temperature
   AXI4L_write32((uint32_t)tempReadNum, ptrA->ADD + AW_TEMP_READ_NUM_ADD);   
   AXI4L_write32((uint32_t)tempReadNum, ptrA->ADD + AW_TEMP_READ_NUM_ADD);
} 
 
//------------------------------------------------------
// Commande operationnelle : envoi partie serielle               
//------------------------------------------------------
void FPA_SendOperational_SerialCmd(const t_FpaIntf *ptrA)
{
   uint32_t vhd_int_time;
   Command_t Cmd;
   ScdPacketTx_t ScdPacketTx;
   uint8_t scd_gain;
   uint8_t scd_int_mode;
   uint8_t scd_hder_disable = 0;
   float Tint;
   
   // quelques definitions
   //uint32_t frame_period_default = 4000000;  //20 fps en coups de 12.5 ns
   uint8_t DisplayMode = 0; // 0 = no dilution
   uint8_t FSyncMode   = 0;  // 0 => external "slave" sync mode (default), 1 => internal "master" sync mode 
   uint8_t ReadDirLR   = 0;  // 0 => left to right (default), 1 => right to left
   uint8_t ReadDirUP   = 1;  // 0 => Up to down (default), 1 => down to up
   
   vhd_int_time     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_INT_TIME);
   Tint = (float)vhd_int_time*(1E6F/FPA_VHD_INTF_CLK_RATE_HZ); // in us
   Tint = MIN(MAX(Tint, FPA_MIN_EXPOSURE), FPA_MAX_EXPOSURE);  // protection
   Tint = Tint/1E6F; // in second
   Tint = Tint*FPA_MCLK_RATE_HZ; // in 80 MHz clks
   
   scd_gain = (uint8_t)(ptrA->scd_gain);
   scd_int_mode = (uint8_t)(ptrA->scd_int_mode);         
   
   // on b�tit la commande
   Cmd.Header       =  0xAA;
   Cmd.ID           =  0x8002;
   Cmd.DataLength   =  21;
   Cmd.Data[0]      =  (uint32_t)Tint & 0xFF;             //integration time lsb
   Cmd.Data[1]      = ((uint32_t)Tint >> 8) & 0xFF;
   Cmd.Data[2]      = ((uint32_t)Tint >> 16) & 0xFF;      //integration time msb
                    
   Cmd.Data[3]      =  0;                                   // reserved
   Cmd.Data[4]      =  0;                                   // reserved
   Cmd.Data[5]      =  0;                                   // reserved
                    
   Cmd.Data[6]      =  ptrA->scd_ystart & 0xFF;                // Image Vertical Offset lsb
   Cmd.Data[7]      = (ptrA->scd_ystart >> 8) & 0xFF;          // Image Vertical Offset msb

   Cmd.Data[8]      =  ptrA->scd_ysize & 0xFF;                 // Image Vertical Length lsb
   Cmd.Data[9]      = (ptrA->scd_ysize >> 8) & 0xFF;           // Image Vertical Length msb
                        
   Cmd.Data[10]     =  ptrA->scd_xsize & 0xFF;                 // Image Horizontal Length lsb
   Cmd.Data[11]     = (ptrA->scd_xsize >> 8) & 0xFF;           // Image Horizontal Length msb
                        
   Cmd.Data[12]     =  ptrA->scd_xstart & 0xFF;                // Image Horizontal Offset lsb
   Cmd.Data[13]     = (ptrA->scd_xstart >> 8) & 0xFF;          // Image Horizontal Offset msb
                        
   Cmd.Data[14]     =((scd_hder_disable & 0x01) << 7) + ((ptrA->scd_diode_bias & 0x0F) << 3) + (scd_gain & 0x07);

   Cmd.Data[15]     =  ptrA->scd_frame_period_min & 0xFF;         // Frame period lsb
   Cmd.Data[16]     = (ptrA->scd_frame_period_min >> 8) & 0xFF;   // Frame period lsb
   Cmd.Data[17]     = (ptrA->scd_frame_period_min >> 16) & 0xFF;  // Frame period lsb
                         
   Cmd.Data[18]     = (((ptrA->scd_out_chn) & 0x01) << 7) + ((DisplayMode & 0x0F) << 3) + ((FSyncMode & 0x01) << 2) + ((ReadDirLR & 0x01) << 1) + (ReadDirUP & 0x01);
   Cmd.Data[19]     = scd_int_mode;
   Cmd.Data[20]     = ((ptrA->scd_boost_mode & 0x01) << 5) + (ptrA->scd_pix_res & 0x03);
   
   Cmd.SerialCmdRamBaseAdd = (uint8_t)AW_SERIAL_OP_CMD_RAM_BASE_ADD; // adresse � laquelle envoyer la commande en RAM
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
	
   // on b�tit la commande
   Cmd.Header              = 0xAA;
   Cmd.ID                  = 0x8004;
   Cmd.DataLength          = 16;
   Cmd.Data[0]             = ptrA->scd_bit_pattern;
   Cmd.SerialCmdRamBaseAdd = (uint16_t)AW_SERIAL_DIAG_CMD_RAM_BASE_ADD;
   for(ii = 1; ii < Cmd.DataLength; ii++)
      Cmd.Data[ii] = 0;
   
   // on batit les packets de bytes
   FPA_BuildCmdPacket(&ScdPacketTx, &Cmd);
   
   // on envoit les packets
   FPA_SendCmdPacket(&ScdPacketTx, ptrA);
}

//--------------------------------------------------------
// Commande lecture de temp�rature : envoi partie serielle
//--------------------------------------------------------
void FPA_ReadTemperature_SerialCmd(const t_FpaIntf *ptrA)
{    
   uint8_t ii;
   Command_t Cmd;
   ScdPacketTx_t ScdPacketTx;
	
   // on b�tit la commande
   Cmd.Header       =  0xAA;
   Cmd.ID           =  0x8021;
   Cmd.DataLength   =  0;
   Cmd.Data[0]      =  0;
   for(ii = 1; ii < Cmd.DataLength; ii++)
      Cmd.Data[ii] = 0;   
   Cmd.SerialCmdRamBaseAdd = (uint16_t)AW_SERIAL_TEMP_CMD_RAM_BASE_ADD;
   // on batit les packets de bytes
   FPA_BuildCmdPacket(&ScdPacketTx, &Cmd);
   
   // on envoit les packets
   FPA_SendCmdPacket(&ScdPacketTx, ptrA);
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
      AXI4L_write32(ptrE->ScdPacketArrayTx[index], ptrA->ADD + AW_SERIAL_CFG_SWITCH_ADD + 4*(ptrE->SerialCmdRamBaseAdd + index));  // dans le vhd, division par 4 avant entr�e dans ram
      index++;
   }
   for(ii = 0; ii <= 3 ; ii++)
   {      
      AXI4L_write32(0, ptrA->ADD + + AW_SERIAL_CFG_SWITCH_ADD + AW_SERIAL_CFG_END_ADD);  // envoi de '0' � l'adresse de fin pour donner du temps � l'arbitreur pour detecter la fin qui s'en vient.
   };
   AXI4L_write32(1, ptrA->ADD + AW_SERIAL_CFG_SWITCH_ADD + AW_SERIAL_CFG_END_ADD); 
}

//--------------------------------------------------------------------------
// Pour avoir les statuts priv�s du module d�tecteur
//--------------------------------------------------------------------------
void FPA_GetPrivateStatus(t_FpaPrivateStatus *PrivateStat, const t_FpaIntf *ptrA)
{
   // config retourn�e par le vhd
   PrivateStat->fpa_frame_resolution = AXI4L_read32(ptrA->ADD + AR_PRIVATE_STATUS_BASE_ADD + 0x00);
}
