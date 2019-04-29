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
#include "utils.h"
#include "IRC_status.h"
#include "CRC.h"
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


// Periode minimale des xtratrigs (utilisé par le hw pour avoir le temps de programmer le détecteur entre les trigs. Commande operationnelle et syhthetique seulement)
#define MGLK_XTRA_TRIG_FREQ_MAX_HZ        44     // soit une frequence de 44 Hz         
  
// Parametres de la commande serielle du ScorpioMW
#define MGLK_LONGEST_CMD_CHAR_NUM         128     // longueur en bytes de la plus longue commande serielle du ScorpioMW )(en realité , moins que ça mais juste pour reserver de la memoire)

// Mode d'operation choisi pour le contrôleur de trig 
#define MODE_READOUT_END_TO_TRIG_START    0x00    // provient du fichier fpa_common_pkg.vhd. Ce mode est choisi car plus simple pour le ScorpioMW
#define MODE_INT_END_TO_TRIG_START        0x02

// ScorpioMW integration modes definies par Mglk  
#define MGLK_ITR_MODE                     0x00    // Valeur ENO
#define MGLK_IWR_MODE                     0x01    // Valeur ENO

// ScorpioMW gains definis par Mglk  
#define MGLK_GAIN_0                       0x00    // Valeur ENO
#define MGLK_GAIN_1                       0x01    // Valeur ENO                               

// adresse de base pour l'aiguilleur de config dans le vhd.
#define AW_SERIAL_CFG_SWITCH_ADD          0x0800  // l'aiguilleur enverra la config en ram

//partition dans la ram Vhd des config (mappées sur FPA_define)
#define AW_PROXY_STATIC_CMD_RAM_BASE_ADD  0        // adresse de base en ram pour la cmd statique
#define AW_PROXY_INT_CMD_RAM_BASE_ADD     128      // adresse de base en ram pour la cmd IntegrationTime
#define AW_PROXY_DIAG_CMD_RAM_BASE_ADD    168      // adresse de base en ram pour la cmd diagMode
#define AW_PROXY_WINDW_CMD_RAM_BASE_ADD   208      // adresse de base en ram pour la cmd Windowing
#define AW_PROXY_TEMP_CMD_RAM_BASE_ADD    338      // adresse de base en ram pour la cmd read temperature
#define AW_PROXY_OP_CMD_RAM_BASE_ADD      378      // adresse de base en ram pour la cmd operationnelle

// les ID des commandes
#define PROXY_STATIC_CMD_ID               0xC000                                           
#define PROXY_INT_CMD_ID                  0xC001
#define PROXY_DIAG_CMD_ID                 0xC002
#define PROXY_WINDW_CMD_ID                0xC003
#define PROXY_TEMP_CMD_ID                 0xC004
#define PROXY_OP_CMD_ID                   0xC005
#define PROXY_CMD_OVERHEAD                 4      // la structure Command_t a 4 bytes d'overhead(CmdID et CmdCharNum)

// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400  // adresse de base 
#define AR_FPA_TEMPERATURE                0x002C  // adresse temperature

// adresse d'ecriture du signal declenchant la lecture de temperature
#define AW_TEMP_READ_NUM_ADD              0xD0

// adresse d'ecriture du signal declenchant la programmation de la cmd statique
#define AW_STATIC_CMD_NUM_ADD             0xD4

// adresse d'écriture du régistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xE0   // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xE4   // dit au VHD quel type de sortie de fpa e pilote en C est conçu pour.

// adresse d'ecriture signifiant la fin de la commande serielle pour le vhd
#define AW_SERIAL_CFG_END_ADD             (0x0FFC | AW_SERIAL_CFG_SWITCH_ADD)   

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC_SCORPIO_MW               0x18   // provient du fichier fpa_common_pkg.vhd.
#define OUTPUT_DIGITAL                    0x02   // provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL

// adresse d'écriture du régistre du reset des erreurs
#define AW_RESET_ERR                      0xEC

// adresse d'écriture du régistre du reset du module FPA
#define AW_CTRLED_RESET                   0xF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de Mglk)
#define TELOPS_DIAG_CNST                  0xD1      // mode diag constant (patron de test generé par la carte d'acquisition : tous les pixels à la même valeur) 
#define TELOPS_DIAG_DEGR                  0xD2      // mode diag dégradé linéaire(patron de test dégradé linéairement et généré par la carte d'acquisition).Requis en production
#define TELOPS_DIAG_DEGR_DYN              0xD3      // mode diag dégradé linéaire dynamique(patron de test dégradé linéairement et variant d'image en image et généré par la carte d'acquisition)  

#define MGLK_PACKET_BYTE_NUM              11        // nombre de bytes comosant le packet megalink. Attention en ecriture seulement!!!
#define MGLK_PACKET_SOF                   '@'       // SOF du packet megalink

//les registres Megalink propres au scorpio
#define MGLK_X1MIN_LSB_ADD                0x1D0     // adresse d'ecriture du LSB de X1MIN pour megalink ScorpioMW
#define MGLK_Y1MIN_LSB_ADD                0x1D2     // adresse d'ecriture du LSB de Y1MIN pour megalink ScorpioMW
#define MGLK_X1MAX_LSB_ADD                0x1D4     // adresse d'ecriture du LSB de X1MAX pour megalink ScorpioMW
#define MGLK_Y1MAX_LSB_ADD                0x1D6     // adresse d'ecriture du LSB de Y1MAX pour megalink ScorpioMW

#define VHD_CFG_ARBITER_DLY_MIN           50         // cette durée minimale permettra à la machine à état VHD de saisir la commande

#define MGLK_MASTER_CLOCK_IS_EXTERNAL     1           // 1 lorsque l'horloge MGLK est externe, 0 sinon 
#define MGLK_INT_SIGNAL_IS_EXTERNAL       1           // 1 lorsque le signal d'intégration du MGLK est externe, 0 sinon
#define VHD_INVALID_TEMP                  0xFFFFFFFF

#define MGLK_GPOL_VALUE_MIN               200        // 200 mV comme valeur minimale de GPOL. ATR mentionne 0. Mais evitons 0 pour ne pas confondre avec valeur de Flash non initisalisé.
#define MGLK_GPOL_VALUE_MAX               1500       // 1500 mV comme valeur maximale de GPOL 

#define VIDEO_VOLTAGE_MIN                 980        // voltage minimum en mV du signal video sortant du detecteur (pour ajustement plage dynamique)
#define VIDEO_VOLTAGE_MAX                 3050       // voltage maximum en mV du signal video sortant du detecteur (pour ajustement plage dynamique)

#define VHD_PIXEL_PIPE_DLY_SEC           5E-7F     // estimation des differerents delais accumulés par le vhd
#define VHD_FVAL_LOW_GEN_DLY_MCLK        6         // dans le vhd, le delai pour generer la tombée de FVAL est de 6 MCLK. Ce delai est une implication du bug de FVAl de Sofradir 

// structure interne pour les parametres de la figure 2 ( se reporter au document D:\Telops\FIR-00251-Proc\src\FPA\Megalink\Doc) 
struct Proxy_Fig2Param_s             // 
{					   
   float TMCLK;                       
   float T0;
   float T1;
   float T2;
   float T3;
   float T4;
   float T5;
   float T6;
   float mode_int_end_to_trig_start_dly_mclk;
};
typedef struct Proxy_Fig2Param_s Proxy_Fig2Param_t;

// structure interne pour les parametres de la figure 4 ( se reporter au document D:\Telops\FIR-00251-Proc\src\FPA\Megalink\Doc) 
struct Proxy_Fig4Param_s     // 
{					   
   float T1;
   float T2;
   float T3;
   float T4;
   float T5;
   float T6;      
};
typedef struct Proxy_Fig4Param_s Proxy_Fig4Param_t;

// structure interne pour les packets de Mglk (entierement conforme à la structure du packet megalink)
struct MglkPacket_s          
{					   
   unsigned char Sof;
   unsigned char RW;     
   unsigned char Addr[3];           
   unsigned char Data[2];
   unsigned char Crc[4];  
};
typedef struct MglkPacket_s MglkPacket_t;

// structure interne pour les commandes de Mglk. Une commande comprend toute la trame complète à envoyer en RAM
// par Command, on sous-entend L'operationelle, Le temps d'integration, le windowing etc...
struct Command_s            // 
{					   
   uint16_t CmdID;          // pour que le contrôleur puisse identifier la trame 
   uint16_t CmdCharNum;     // Payload : nombre de characteres valides dans le tableau CmdChar[MGLK_LONGEST_CMD_CHAR_NUM + 1];
   unsigned char  CmdChar[MGLK_LONGEST_CMD_CHAR_NUM];  // les caracteres de la commande
   uint16_t CmdRamBaseAdd;  // pour envoyer la commande à la bonne adresse dans la RAm
};
typedef struct Command_s Command_t;                                                            

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);

void FPA_Fig2SpecificParams(Proxy_Fig2Param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
void FPA_Fig4SpecificParams(Proxy_Fig4Param_t *ptrK, const gcRegistersData_t *pGCRegs);
void FPA_SendOperational_SerialCmd(const t_FpaIntf *ptrA);

// functions internes pour Megalink
void FPA_SendTestPattern_SerialCmd(const t_FpaIntf *ptrA);
unsigned char FPA_HexToAscii(const uint8_t DataInHex);
void FPA_BuildPacket(unsigned char ReadWrite, uint16_t Addr, uint8_t DataByte, MglkPacket_t* ptrM);
void FPA_FillCmdCharTable(uint16_t CmdFirstAddr, uint32_t CmdData, uint32_t CmdDataByteNum, Command_t *ptrQ, uint8_t *ptrV);
void FPA_SendStatic_StructCmd(const t_FpaIntf *ptrA);
void FPA_SendStatic_SerialCmd(const t_FpaIntf *ptrA);
void FPA_ReadTemperature_StructCmd(const t_FpaIntf *ptrA);
void FPA_ReadTemperature_SerialCmd(const t_FpaIntf *ptrA);
void FPA_SendCmdByte(Command_t *ptrQ, const t_FpaIntf *ptrA);
void FPA_SendWindow_SerialCmd(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   FPA_Reset(ptrA);
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides Mglk Detector   
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
   FPA_SendStatic_StructCmd(ptrA);                                          // on alerte le hw_driver de l'arrivée d'une commande statique
   FPA_SendStatic_SerialCmd(ptrA);                                          // on envoie la commande statique serielle. Elle comporte tous les parametres de confg statiques pour le Megalink
   FPA_GetTemperature(ptrA);                                                // demande de lecture
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoyée au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
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
   extern int16_t gFpaDetectorPolarizationVoltage;
   Proxy_Fig2Param_t hh;
   Proxy_Fig4Param_t kk;
   
   //-----------------------------------------                                           
   // bâtir les configurations
   
   // on appelle les fonctions pour bâtir les parametres specifiques du SCORPIO
   FPA_Fig2SpecificParams(&hh, 0.0F, pGCRegs);               //le temps d'integration est nulle car aucune influence sur les parametres sauf sur la periode. Mais le VHD ajoutera le int_time pour avoir la vraie periode
   FPA_Fig4SpecificParams(&kk, pGCRegs);
   
   // diag mode and diagType
   ptrA->fpa_diag_mode = 0;                 // par defaut
   ptrA->fpa_diag_type = 0;                 // par defaut   
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade)               // mode diagnostique degradé lineaire
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
   
   // allumage du détecteur 
   ptrA->fpa_pwr_on  = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   
   // config du contrôleur de trigs
   ptrA->fpa_trig_ctrl_mode        = (uint32_t)MODE_INT_END_TO_TRIG_START;    
   ptrA->fpa_acq_trig_ctrl_dly     = (uint32_t)(((hh.mode_int_end_to_trig_start_dly_mclk)* (hh.TMCLK) - (float)VHD_PIXEL_PIPE_DLY_SEC) * (float)FPA_VHD_INTF_CLK_RATE_HZ);  
   ptrA->fpa_acq_trig_period_min   = (uint32_t)(0.8F*(hh.T0)* (hh.TMCLK)* (float)FPA_VHD_INTF_CLK_RATE_HZ);   // periode min avec int_time = 0. Le Vhd y ajoutera le int_time reel
   ptrA->fpa_xtra_trig_ctrl_dly    = (uint32_t)((float)FPA_VHD_INTF_CLK_RATE_HZ / (float)MGLK_XTRA_TRIG_FREQ_MAX_HZ);                      // je n'ai pas enlevé le int_time, ni le readout_time mais pas grave car c'est en xtra_trig
   ptrA->fpa_xtra_trig_period_min  = (uint32_t)(0.8F *(float)ptrA->fpa_xtra_trig_ctrl_dly); 
      
   if (ptrA->fpa_diag_mode == 1)
   {
      ptrA->fpa_trig_ctrl_mode        = (uint32_t)MODE_READOUT_END_TO_TRIG_START;    // ENO : 21 fev 2019: pour les detecteurs numeriques, operer le diag mode en MODE_READOUT_END_TO_TRIG_START car la diag_mode est plus lent que le détecteur 
      ptrA->fpa_acq_trig_ctrl_dly     = 0; 
   }
      
   #ifdef SIM
   ptrA->fpa_xtra_trig_period_min  = (uint32_t)((float)FPA_VHD_INTF_CLK_RATE_HZ / 2.5e3F);     //  2.5 KHz en simulation
   ptrA->fpa_xtra_trig_ctrl_dly    = ptrA->fpa_xtra_trig_period_min; 
   #endif
   
   // valeurs converties en coups d'horloge du module FPA_INTF
   ptrA->proxy_fig2_t4_dly = (uint32_t)((hh.T4)* (hh.TMCLK)* (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->proxy_fig2_t6_dly = (uint32_t)((hh.T6)* (hh.TMCLK) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->proxy_fig2_t5_dly = (uint32_t)(0.80F * (hh.T5)* (hh.TMCLK) * (float)FPA_VHD_INTF_CLK_RATE_HZ); // 0.80 pour s'assurer le fonctionnement pleine vitesse en mode diag
   ptrA->proxy_fig4_t1_dly = (uint32_t)((kk.T1)* (hh.TMCLK) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->proxy_fig4_t2_dly = (uint32_t)((kk.T2)* (hh.TMCLK) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->proxy_fig4_t3_dly = (uint32_t)kk.T3;                                                   // directement en coups d'horloges (fait expres pour faciliter la génération de la bonne taille de pixels)
   ptrA->proxy_fig4_t4_dly = (uint32_t)((kk.T4)* (hh.TMCLK) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->proxy_fig4_t5_dly = (uint32_t)((kk.T5)* (hh.TMCLK) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->proxy_fig4_t6_dly = (uint32_t)((kk.T6)* (hh.TMCLK) * (float)FPA_VHD_INTF_CLK_RATE_HZ);         // directement en coups d'horloges (fait expres pour faciliter la génération de la bonne taille de pixels)
   ptrA->proxy_xsize_div2  =  ptrA->proxy_xsize/2;

   // protection GPOL
   if (((uint32_t)gFpaDetectorPolarizationVoltage >= (uint32_t)MGLK_GPOL_VALUE_MIN) && ((uint32_t)gFpaDetectorPolarizationVoltage <= (uint32_t)MGLK_GPOL_VALUE_MAX))
      ptrA->proxy_gpol_mv = (uint32_t)gFpaDetectorPolarizationVoltage;  // GPOL change si la nouvelle valeur est conforme. Sinon la valeur precedente est conservée. (voir FpaIntf_Ctor) pour la valeur d'initialisation
	else    // else mis juste à titre d'uniformisation de code avec le Hawk et ISC0209A. 
      gFpaDetectorPolarizationVoltage = ptrA->proxy_gpol_mv;
   
   //  gain 
   ptrA->proxy_gain = MGLK_GAIN_0;                      // seul le plus gros puits sera utilisé.
   
   // integration modes
   ptrA->proxy_int_mode = MGLK_IWR_MODE;
   if (pGCRegs->IntegrationMode == IM_IntegrateThenRead) 
      ptrA->proxy_int_mode = MGLK_ITR_MODE;
   
   //  window--------------------------------------------
   ptrA->proxy_xsize  = (uint32_t)pGCRegs->Width;
   ptrA->proxy_ysize  = (uint32_t)pGCRegs->Height;
   // calculé specialement pour le ScorpioMW
   ptrA->proxy_x1min  = (uint32_t)pGCRegs->OffsetX/4;
   ptrA->proxy_x1max  = (uint32_t)pGCRegs->OffsetX/4 + (uint32_t)pGCRegs->Width/4 - 1;
   ptrA->proxy_y1min  = (uint32_t)pGCRegs->OffsetY;
   ptrA->proxy_y1max  = (uint32_t)pGCRegs->OffsetY + (uint32_t)pGCRegs->Height - 1;

   // mode diag Mglk--------------------------------------------
   ptrA->proxy_pattern_activation = 0;
   if (pGCRegs->TestImageSelector == TIS_ManufacturerStaticImage)
      ptrA->proxy_pattern_activation = 1;
   
   // Élargit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;

   // Envoyer commande window
   ptrA->proxy_cmd_to_update_id = PROXY_WINDW_CMD_ID;
   WriteStruct(ptrA);   // on envoie au complet les parametres pour toutes les parties (partie common etc...)                           
   FPA_SendWindow_SerialCmd(ptrA);
   
   // Envoyer commande synthetique
   ptrA->proxy_cmd_to_update_id = PROXY_DIAG_CMD_ID;
   WriteStruct(ptrA);   // on envoie au complet les parametres pour toutes les parties (partie common etc...)
   FPA_SendTestPattern_SerialCmd(ptrA);         // on envoie la partie serielle de la commande video synthetique (elle est stockée dans une partie de la RAM en vhd)

   // Envoyer commande operationnelle------------------------------
   ptrA->proxy_cmd_to_update_id = PROXY_OP_CMD_ID;
   WriteStruct(ptrA);   // on envoie de nouveau au complet les parametres pour toutes les parties (partie common etc...). Ce nouvel envoi vise à a;erter l'arbitreur vhd
   FPA_SendOperational_SerialCmd(ptrA);            // on envoie la partie serielle de la commande operationnelle (elle est stockée dans une autre partie de la RAM en vhd)
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la température du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{
   uint32_t mglk_temp;
 
   // demande de lecture de la temperature temp(n)
   FPA_ReadTemperature_StructCmd(ptrA);      // envoi un interrupt au contrôleur du hw driver
   FPA_ReadTemperature_SerialCmd(ptrA);      // envoi la commande serielle    
   
   // lecture et conversion de la temperature temp(n-1)
   mglk_temp = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_TEMPERATURE);  // lit le registre de temperature (fort probablement pas le présent mais le passé) 
   if (mglk_temp == (uint32_t)VHD_INVALID_TEMP)
   {  
      return FPA_INVALID_TEMP;
   }
   else
   {      
	  return (int16_t)((int32_t)mglk_temp - 27315) ; // Centi celsius
   }
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float period, MaxFrameRate;   
   Proxy_Fig2Param_t Proxy_Fig2Param;
   FPA_Fig2SpecificParams(&Proxy_Fig2Param, (float)pGCRegs->ExposureTime, pGCRegs);
   period = Proxy_Fig2Param.T0*Proxy_Fig2Param.TMCLK;      // selon le chronogrammme : T0 = frame period
   
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
// Pour avoir le ExposureMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   float maxExposure_us, periodMinWithNullExposure;
   float actualPeriod, fpaAcquisitionFrameRate;
   Proxy_Fig2Param_t hh;
      
   // ENO: 10 sept 2016: d'entrée de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur   
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);

   // ENO: 10 sept 2016: tout reste inchangé
   FPA_Fig2SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition était nulle
   periodMinWithNullExposure = hh.T0*hh.TMCLK;
   actualPeriod = 1.0F / fpaAcquisitionFrameRate;                // periode avec le frame rate actuel
   
   maxExposure_us = (actualPeriod - periodMinWithNullExposure)*1e6F;
   
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
}


//////////////////////////////////////////////////////////////////////////////                                                                          
//  I N T E R N A L    F U N C T I O N S 
////////////////////////////////////////////////////////////////////////////// 

//--------------------------------------------------------------------------
// Informations sur les drivers C utilisés. 
//--------------------------------------------------------------------------
void  FPA_SoftwType(const t_FpaIntf *ptrA)
{
   AXI4L_write32(FPA_ROIC_SCORPIO_MW, ptrA->ADD + AW_FPA_ROIC_SW_TYPE);
   AXI4L_write32(OUTPUT_DIGITAL, ptrA->ADD + AW_FPA_OUTPUT_SW_TYPE);		     
}

//-------------------------------------------------------
// Megalink specifics timings
//-------------------------------------------------------
void FPA_Fig2SpecificParams(Proxy_Fig2Param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // se reporter au document D:\Telops\FIR-00251-Proc\src\FPA\Megalink\Doc\Chronogrammes.doc
   Proxy_Fig4Param_t kk;
   
   FPA_Fig4SpecificParams(&kk, pGCRegs);
   
   if (pGCRegs->IntegrationMode == IM_IntegrateWhileRead) 
   {
      // à implanter plus tard;
      //ptrH->TMCLK  = 1.0F/((float)FPA_MCLK_RATE_HZ);
      //ptrH->T2     = (exposureTime_usec*1E-6F)/ptrH->TMCLK;
      //ptrH->T3     = kk.T3*(float)pGCRegs->Height + kk.T4*((float)pGCRegs->Height-1.0F);
      //ptrH->T4     = 0.0F;
      //ptrH->T5     = (50.0E-6F)/ptrH->TMCLK;
      //ptrH->T6     = 6.5F + pGCRegs->Width/4.0F;
      //ptrH->T0     = ptrH->T4 + ptrH->T2 + ptrH->T6 + ptrH->T3 + ptrH->T5;
   }
   else // ITR mode
   {      
      ptrH->TMCLK  = 1.0F/((float)FPA_MCLK_RATE_HZ);
      ptrH->T2     = (exposureTime_usec*1E-6F)/ptrH->TMCLK  + 3076.0F;     // int_signal_high_time
      ptrH->T3     = (float)pGCRegs->Height*((float)pGCRegs->Width/(float)FPA_NUMTAPS + 4.0F);  // 4 MCLK par ligne pour tenir compte de la descente de LVAL dans le Megalink
      ptrH->T4     = 1.0F;  // delai 1MCLK
      ptrH->T5     = 1.0F;
      ptrH->T6     = 3.0F + (float)pGCRegs->Width/(float)FPA_NUMTAPS + 15.0F  + (float)VHD_FVAL_LOW_GEN_DLY_MCLK;   // 15.0F = delai du Megalink
      ptrH->T0     = ptrH->T4 + ptrH->T2 + ptrH->T6 + ptrH->T3 + ptrH->T5;
      
      //autres calculs
      ptrH->mode_int_end_to_trig_start_dly_mclk = ptrH->T0 - ptrH->T2;  // utilisé en mode int_end_trig_start                                                   
   }
   
   // verification des calculs en simulation
   #ifdef SIM
      PRINTF("ptrH->T2 = %d\n"   , (uint32_t)(ptrH->T2));
      PRINTF("ptrH->T3 = %d\n"   , (uint32_t)(ptrH->T3));
      PRINTF("ptrH->T4 = %d\n"   , (uint32_t)(ptrH->T4));
      PRINTF("ptrH->T5 = %d\n"   , (uint32_t)(ptrH->T5));
      PRINTF("ptrH->T6 = %d\n"   , (uint32_t)(ptrH->T6));
      PRINTF("ptrH->T0 = %d\n"   , (uint32_t)(ptrH->T0));
   #endif  
   
}

void FPA_Fig4SpecificParams(Proxy_Fig4Param_t *ptrK, const gcRegistersData_t *pGCRegs)
{
   // ATTENTION!! ne pas changer l'ordre des calculs des parametres
   // se reporter au document Communication Protocol Appendix A5 (SPEC. NO: DPS3008) de Mglk
   ptrK->T1  = 0.0F;
   ptrK->T2  = 0.0F;
   ptrK->T3  = (float)pGCRegs->Width/4.0F; // division par 4 car en coups d'hotloge MCLK
   ptrK->T4  = 4.0F;
   ptrK->T5  = 0.0F;
   ptrK->T6  = 0.0F;       // resultat du calcul non utilisé finalement
}

//--------------------------------------------------------------------------
// FPA_HexToAscii
//-------------------------------------------------------------------------- 
// Cette fonction convertit un mot hexadecimal en un caractere ascii de meme graphie/orthographe
unsigned char FPA_HexToAscii(const uint8_t DataInHex)
{
   uint8_t hexTemp;
   unsigned char DataOutChar;
   
   hexTemp = 0x0F & DataInHex;  
   switch (hexTemp)
   {
      case 0x00 :
        DataOutChar = '0'; break;     
      case 0x01 :
        DataOutChar = '1'; break;
      case 0x02 :
        DataOutChar = '2'; break;
      case 0x03 :
        DataOutChar = '3'; break;
      case 0x04 :
        DataOutChar = '4'; break;
      case 0x05 :
        DataOutChar = '5'; break;
      case 0x06 :
        DataOutChar = '6'; break;
      case 0x07 :
        DataOutChar = '7'; break;
      case 0x08 :
        DataOutChar = '8'; break;
      case 0x09 :
        DataOutChar = '9'; break;     
      case 0x0A :
        DataOutChar = 'A'; break;
      case 0x0B :
        DataOutChar = 'B'; break;
      case 0x0C :
        DataOutChar = 'C'; break;
      case 0x0D :
        DataOutChar = 'D'; break;
      case 0x0E :
        DataOutChar = 'E'; break;
      case 0x0F :
        DataOutChar = 'F'; break;
      default    :
        DataOutChar = 'Z'; break;	  
   }    
   return DataOutChar;
}
 
//-------------------------------------------------------
// Commande statique : envoi partie structurale
//-------------------------------------------------------
void FPA_SendStatic_StructCmd(const t_FpaIntf *ptrA)    
{      
   static uint8_t staticNum = 17;
   uint8_t ii; 
                 
   if (staticNum == 255)  // protection contre depassement
      staticNum = 0;
      
   staticNum++;
   
   // plusieurs envois juste pour donner du temps à l'arbitreur de prendre la commande
   for(ii = 0; ii < 3 ; ii++)
   {
      AXI4L_write32((uint32_t)staticNum, ptrA->ADD + AW_STATIC_CMD_NUM_ADD);  // cela envoie un signal au contrôleur du hw_driver pour la cmd statique
   }
}

//-------------------------------------------------------
// Commande temperature : envoi partie structurale
//-------------------------------------------------------
void FPA_ReadTemperature_StructCmd(const t_FpaIntf *ptrA)    
{      
   static uint8_t tempReadNum = 0;
   uint8_t ii;
                 
   if (tempReadNum == 255)  // protection contre depassement
      tempReadNum = 0;
      
   tempReadNum++;
   
   // plusieurs envois juste pour donner du temps à l'arbitreur de prendre la commande
   for(ii = 0; ii < 3 ; ii++)
   {  
      AXI4L_write32((uint32_t)tempReadNum, ptrA->ADD + AW_TEMP_READ_NUM_ADD);  // cela envoie un signal au contrôleur du hw_driver pour la lecture de la temperature
   }
} 
 
//------------------------------------------------------
// Commande operationnelle : envoi partie serielle               
//------------------------------------------------------
void FPA_SendOperational_SerialCmd(const t_FpaIntf *ptrA)
{
   Command_t Cmd;
   uint8_t CharIndex = 0;
 	  
   // on definit la commande
   Cmd.CmdID         = PROXY_OP_CMD_ID;   
      
   // adresse 0x130 : GPOL
   FPA_FillCmdCharTable(0x130, ptrA->proxy_gpol_mv, 2, &Cmd, &CharIndex);  
    
   // nombre de carateres total de la commande
   Cmd.CmdCharNum = CharIndex;
   
   // adresse à laquelle envoyer la commande en RAM
   Cmd.CmdRamBaseAdd = (uint16_t)AW_PROXY_OP_CMD_RAM_BASE_ADD; 
   
   // on envoit les Bytes
   FPA_SendCmdByte(&Cmd, ptrA);

}

//--------------------------------------------------------
// Commande Statique : envoi partie serielle
//--------------------------------------------------------
// ici se retrouvent les parametres qui seront envoyés juste une fois, pour initilaiser Megalink.
void FPA_SendStatic_SerialCmd(const t_FpaIntf *ptrA)
{    
   Command_t Cmd;
   uint8_t CharIndex = 0;
 	uint8_t CmdByte;
   
   // on definit la commande
   Cmd.CmdID         = PROXY_STATIC_CMD_ID;   
   
   // on remplit la table de caractères
   FPA_FillCmdCharTable(0x100, 0x13, 1, &Cmd, &CharIndex);        // adresse 0x100 : double base mode, 4 taps, normal consumption, inversion 
   
   CmdByte = 0x7C;                                               // adresse 0x102 : MC interne, locking range 3 (8-10MHz), Int Source External, CC1 used to start Integration, sampling Position4
   if ((uint32_t)MGLK_MASTER_CLOCK_IS_EXTERNAL == 1)
      CmdByte |= 0x01;
   if ((uint32_t)MGLK_INT_SIGNAL_IS_EXTERNAL == 1)
      CmdByte &= 0xEF;
   FPA_FillCmdCharTable(0x102, CmdByte, 1, &Cmd, &CharIndex);        
   
   FPA_FillCmdCharTable(0x140, 0x00, 1, &Cmd, &CharIndex);        // adresse 0x140 : video1 on channelX, Video1 in 1st position in clink frame
   FPA_FillCmdCharTable(0x141, 0x01, 1, &Cmd, &CharIndex);        // adresse 0x141 : video2 on channelY, Video2 in 1st position in clink frame
   FPA_FillCmdCharTable(0x142, 0x02, 1, &Cmd, &CharIndex);        // adresse 0x142 : video3 on channelX, Video3 in 2nd position in clink frame
   FPA_FillCmdCharTable(0x143, 0x03, 1, &Cmd, &CharIndex);        // adresse 0x143 : video4 on channelY, Video4 in 2nd position in clink frame
   
   // ENO 15 octobre 2015: sur demande de CDE, ajustement de la plage dynamique du ScorpioMW 
   // pour corriger depassement obersvé par PTR
   FPA_FillCmdCharTable(0x1C0, (uint16_t)VIDEO_VOLTAGE_MIN, 2, &Cmd, &CharIndex);
   FPA_FillCmdCharTable(0x1C2, (uint16_t)VIDEO_VOLTAGE_MAX, 2, &Cmd, &CharIndex);
   
   
   //if ((float)FPA_MCLK_RATE_HZ == 20E+6F)
   //   FPA_FillCmdCharTable(0x1A1, 0x01, 1, &Cmd, &CharIndex);        // adresse 0x1A1 : functional Freq 20MHz, Unread diode not polarized, power optimization not used
   //else
   //   FPA_FillCmdCharTable(0x1A1, 0x00, 1, &Cmd, &CharIndex);        // adresse 0x1A1 : functional Freq 10MHz, Unread diode not polarized, power optimization not used
   
   // nombre de carateres total de la commande
   Cmd.CmdCharNum = CharIndex;
   
   // adresse d'envoi en RAM
   Cmd.CmdRamBaseAdd = (uint16_t)AW_PROXY_STATIC_CMD_RAM_BASE_ADD;
   
   // on envoit la commande serielle
   FPA_SendCmdByte(&Cmd, ptrA);
}
  
//--------------------------------------------------------
// Commande Windowing : envoi partie serielle
//--------------------------------------------------------
void FPA_SendWindow_SerialCmd(const t_FpaIntf *ptrA)
{    
   Command_t Cmd;
   uint8_t CharIndex = 0;
   uint8_t CmdByte;
 	
   // on definit la commande
   Cmd.CmdID         = PROXY_WINDW_CMD_ID;   
      
   //// adresse 0x1A1 Power Management pour le windowing
//   CmdByte = 0x00;          // valeur par defaut
//   if ((float)FPA_MCLK_RATE_HZ == 20E+6F)
//      CmdByte = 0x01;
//   if (ptrA->proxy_xsize == 640)
//      CmdByte |= 0x04;
//   else if ((ptrA->proxy_xsize >=320) && (ptrA->proxy_xsize < 640))
//      CmdByte |= 0x0C;
//   else if ((ptrA->proxy_xsize >=210) && (ptrA->proxy_xsize < 320))
//      CmdByte |= 0x14;
//   else if ((ptrA->proxy_xsize >=160) && (ptrA->proxy_xsize < 210))
//      CmdByte |= 0x1C;
//   
//   FPA_FillCmdCharTable(0x1A1, CmdByte, 1, &Cmd, &CharIndex);        //
      
   // on remplit la table de caractères
   FPA_FillCmdCharTable(MGLK_X1MIN_LSB_ADD, ptrA->proxy_x1min, 2, &Cmd, &CharIndex); 
   FPA_FillCmdCharTable(MGLK_Y1MIN_LSB_ADD, ptrA->proxy_y1min, 2, &Cmd, &CharIndex);
   FPA_FillCmdCharTable(MGLK_X1MAX_LSB_ADD, ptrA->proxy_x1max, 2, &Cmd, &CharIndex);
   FPA_FillCmdCharTable(MGLK_Y1MAX_LSB_ADD, ptrA->proxy_y1max, 2, &Cmd, &CharIndex);
   
   // adresse 0x1A0 : inversion des colonnes ou des lignes, windowing, binning 
   CmdByte = 0x83;          // valeur par defaut pour ne pas avoir d'inversion et rouler tout le temps en mode windowing pour éviter offset d'image. ITR mode
   FPA_FillCmdCharTable(0x1A0, CmdByte, 1, &Cmd, &CharIndex);
        
   // nombre de carateres total de la commande
   Cmd.CmdCharNum = CharIndex;
   
   // adresse d'envoi en RAM
   Cmd.CmdRamBaseAdd = (uint16_t)AW_PROXY_WINDW_CMD_RAM_BASE_ADD;
   
   // on envoit la commande serielle
   FPA_SendCmdByte(&Cmd, ptrA);
}
 
//--------------------------------------------------------
// Commande video synthetique : envoi partie serielle
//--------------------------------------------------------
void FPA_SendTestPattern_SerialCmd(const t_FpaIntf *ptrA)
{    
   Command_t Cmd;
   uint8_t CharIndex = 0;
   uint8_t CmdByte;
	
   // on definit la commande
   Cmd.CmdID         = PROXY_DIAG_CMD_ID;   
   
   // on definit le byte à ecrire à l'adresse 0x120 de Megalink
   CmdByte = 0x04;                  // normal mode, FPA ON
   if (ptrA->proxy_pattern_activation == 1)
    CmdByte = 0x05;                 // Diag mode, FPA ON
    
   // on remplit la table de caractères
   FPA_FillCmdCharTable(0x120, CmdByte, 1, &Cmd, &CharIndex);
   
   // nombre de carateres total de la commande
   Cmd.CmdCharNum = CharIndex;
     
   // adresse d'envoi en RAM
   Cmd.CmdRamBaseAdd = (uint16_t)AW_PROXY_DIAG_CMD_RAM_BASE_ADD;
   
   // on envoit la commande serielle
   FPA_SendCmdByte(&Cmd, ptrA);
}

//--------------------------------------------------------
// Commande lecture de température : envoi partie serielle
//--------------------------------------------------------
void FPA_ReadTemperature_SerialCmd(const t_FpaIntf *ptrA)
{    
   Command_t Cmd;
	
   // on bâtit la commande
   Cmd.CmdID       = PROXY_TEMP_CMD_ID;
   Cmd.CmdCharNum  = 2*9;
   
   // lecture du LSB de la temperature 
   Cmd.CmdChar[0]  ='@';
   Cmd.CmdChar[1]  ='R';   
   Cmd.CmdChar[2]  ='1';
   Cmd.CmdChar[3]  ='6';
   Cmd.CmdChar[4]  ='0';   
   Cmd.CmdChar[5]  ='0';                       // CRC calculé manuellement
   Cmd.CmdChar[6]  ='C';
   Cmd.CmdChar[7]  ='7';
   Cmd.CmdChar[8]  ='3';
   
   // lecture du MSB de la temperature 
   Cmd.CmdChar[9]  ='@';
   Cmd.CmdChar[10] ='R';
   Cmd.CmdChar[11] ='1';
   Cmd.CmdChar[12] ='6';
   Cmd.CmdChar[13] ='1';
   Cmd.CmdChar[14] ='C';
   Cmd.CmdChar[15] ='C';
   Cmd.CmdChar[16] ='B';
   Cmd.CmdChar[17] ='2';
     
   // adresse d'envoi en RAM
   Cmd.CmdRamBaseAdd = (uint16_t)AW_PROXY_TEMP_CMD_RAM_BASE_ADD;
   
   // on envoit la commande serielle
   FPA_SendCmdByte(&Cmd, ptrA);
}

//-----------------------------------
// Bâtir un packet Megalink
//----------------------------------- 
// attention, seul le mode Write est supporté !!!!!!
void FPA_BuildPacket(unsigned char ReadWrite, uint16_t Addr, uint8_t DataByte, MglkPacket_t* ptrM)
{
   uint16_t crc16;   
   
   ptrM->Sof      = MGLK_PACKET_SOF;
   ptrM->RW       = 'W';             //
   ptrM->Addr[0]  = FPA_HexToAscii((Addr >> 8) & 0x0F);
   ptrM->Addr[1]  = FPA_HexToAscii((Addr >> 4) & 0x0F);
   ptrM->Addr[2]  = FPA_HexToAscii(Addr & 0x0F);
   ptrM->Data[0]  = FPA_HexToAscii((DataByte >> 4)& 0x0F);
   ptrM->Data[1]  = FPA_HexToAscii(DataByte & 0x0F);
   
   crc16 = CRC16(0xFFFF, &ptrM->Sof, 7);
   
   ptrM->Crc[0]   = FPA_HexToAscii((crc16 >> 12) & 0x0F);
   ptrM->Crc[1]   = FPA_HexToAscii((crc16 >> 8) & 0x0F);
   ptrM->Crc[2]   = FPA_HexToAscii((crc16 >> 4) & 0x0F);
   ptrM->Crc[3]   = FPA_HexToAscii(crc16 & 0x0F);
}

//-----------------------------------
// Bâtir une commande complète MGLK
//----------------------------------- 
// une commande complète est constituée de plusiers packets envoyées à des adresses differentes.
// Exemple: le temps d'integration comprend 3 packets envoyées à 3 adresses differentes.
void FPA_FillCmdCharTable(uint16_t CmdFirstAddr, uint32_t CmdData, uint32_t CmdDataByteNum, Command_t *ptrQ, uint8_t *ptrV)
{
   uint8_t ii;
   MglkPacket_t  packet;
   for(ii = 0; ii < CmdDataByteNum; ii++)
   {   
      FPA_BuildPacket('W', (CmdFirstAddr + ii), ((0xFF)&(CmdData >> (8*ii))), &packet);    // on bâtit un packet autour d'une byte de Data
      
      ptrQ->CmdChar[(*ptrV)++] = packet.Sof;                // on remplit la structure de commande
      ptrQ->CmdChar[(*ptrV)++] = packet.RW;
      ptrQ->CmdChar[(*ptrV)++] = packet.Addr[0];
      ptrQ->CmdChar[(*ptrV)++] = packet.Addr[1]; 
      ptrQ->CmdChar[(*ptrV)++] = packet.Addr[2]; 
      ptrQ->CmdChar[(*ptrV)++] = packet.Data[0]; 
      ptrQ->CmdChar[(*ptrV)++] = packet.Data[1]; 
      ptrQ->CmdChar[(*ptrV)++] = packet.Crc[0]; 
      ptrQ->CmdChar[(*ptrV)++] = packet.Crc[1]; 
      ptrQ->CmdChar[(*ptrV)++] = packet.Crc[2]; 
      ptrQ->CmdChar[(*ptrV)++] = packet.Crc[3];
   }   
}

//-----------------------------------
// Envoi des Bytes
//-----------------------------------
void FPA_SendCmdByte(Command_t *ptrQ, const t_FpaIntf *ptrA)
{
   uint16_t index = 0;
   uint8_t ii;
   
   while(index < ptrQ->CmdCharNum + PROXY_CMD_OVERHEAD)
   {
      if (index == 0) 
         AXI4L_write32(((ptrQ->CmdID >> 8) & 0xFF), ptrA->ADD + AW_SERIAL_CFG_SWITCH_ADD + 4*(ptrQ->CmdRamBaseAdd + index));                       // MSB du cmdID 
      else if (index == 1)
         AXI4L_write32((ptrQ->CmdID & 0xFF), ptrA->ADD + AW_SERIAL_CFG_SWITCH_ADD + 4*(ptrQ->CmdRamBaseAdd + index));                       // LSB du cmdID
      else if (index == 2)      
         AXI4L_write32(((ptrQ->CmdCharNum >> 8) & 0xFF), ptrA->ADD + AW_SERIAL_CFG_SWITCH_ADD + 4*(ptrQ->CmdRamBaseAdd + index));        // MSB du payload
      else if (index == 3)  
         AXI4L_write32((ptrQ->CmdCharNum & 0xFF), ptrA->ADD + AW_SERIAL_CFG_SWITCH_ADD + 4*(ptrQ->CmdRamBaseAdd + index));              // LSB du payload 
      else if (index > 3)   
         AXI4L_write32(ptrQ->CmdChar[index - PROXY_CMD_OVERHEAD], ptrA->ADD + AW_SERIAL_CFG_SWITCH_ADD + 4*(ptrQ->CmdRamBaseAdd + index));  // dans le vhd, division par 4 avant entrée dans ram
      index++;
   }
   for(ii = 0; ii <= 3 ; ii++)
   {      
      AXI4L_write32(0, ptrA->ADD + AW_SERIAL_CFG_END_ADD);  // envoi de '0' à l'adresse de fin pour donner du temps à l'arbitreur pour detecter la fin qui s'en vient.
   };
   AXI4L_write32(1, ptrA->ADD + AW_SERIAL_CFG_END_ADD);  // envoie du mot de fin de config
}
