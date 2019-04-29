/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 23372 $
-- $Author: odionne $
-- $LastChangedDate: 2019-04-24 13:22:31 -0400 (mer., 24 avr. 2019) $
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
 

// Peride minimale des xtratrigs (utilisé par le hw pour avoir le temps de programmer le détecteur entre les trigs. Commande operationnelle et syhthetique seulement)
#define SCD_XTRA_TRIG_FREQ_MAX_HZ         44     // soit une frequence de 44 Hz         
  
// Parametres de la commande serielle du HerculesD
#define SCD_LONGEST_CMD_BYTES_NUM         32      // longueur en bytes de la plus longue commande serielle du HerculesD
#define SCD_CMD_OVERHEAD_BYTES_NUM        6       // longueur des bytes autres que ceux des données

// Mode d'operation choisi pour le contrôleur de trig 
#define MODE_READOUT_END_TO_TRIG_START    0x00    // provient du fichier fpa_common_pkg.vhd. Ce mode est choisi car plus simple pour le PelicanD
#define MODE_TRIG_START_TO_TRIG_START     0x01
#define MODE_INT_END_TO_TRIG_START        0x02

// HerculesD integration modes definies par SCD  
#define SCD_ITR_MODE                      0x00    // valeur provenant du manuel de SCD
#define SCD_IWR_MODE                      0x01    // valeur provenant du manuel de SCD

// HerculesD gains definis par SCD  
#define SCD_GAIN_0                        0x00   // plus gros puits
#define SCD_GAIN_1                        0x02   // plus petit puits

// HerculesD Clink modes
#define SCD_CLINK_1_CHN                   0x01   // mode clink 1 channel (base) tel que défini par scd
#define SCD_CLINK_2_CHN                   0x00   // mode clink 2 channel (medium) tel que défini par scd

// HerculesD Bias 
#define SCD_BIAS_DEFAULT                  0x0C    // 100pA (default)                                     

// HerculesD Pixel resolution 
#define SCD_PIX_RESOLUTION_15BITS         0x00    // 15 bits selon SCD
#define SCD_PIX_RESOLUTION_14BITS         0x01    // 14 bits selon SCD
#define SCD_PIX_RESOLUTION_13BITS         0x02    // 13 bits selon SCD

// adresse de base pour l'aiguilleur de config dans le vhd.
#define AW_SERIAL_CFG_SWITCH_ADD          0x0400  // l'aiguilleur enverra la config en ram

//partition dans la ram Vhd des config (mappées sur FPA_define)
#define AW_SERIAL_OP_CMD_RAM_BASE_ADD     0       // adresse de base en ram pour la cmd opertaionnelle
#define AW_SERIAL_INT_CMD_RAM_BASE_ADD    64      // adresse de base en ram pour la cmd int_time (la commande est implémentée uniquement dans le vhd)
#define AW_SERIAL_DIAG_CMD_RAM_BASE_ADD   128     // adresse de base en ram pour la cmd diag de scd
#define AW_SERIAL_TEMP_CMD_RAM_BASE_ADD   192     // adresse de base en ram pour la cmd read temperature

// les ID des commandes
#define SCD_INT_CMD_ID                    0x8001
#define SCD_OP_CMD_ID                     0x8002
#define SCD_DIAG_CMD_ID                   0x8004
#define SCD_TEMP_CMD_ID                   0x8021
                      
// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400  // adresse de base 
#define AR_FPA_TEMPERATURE                0x002C  // adresse temperature

// adresse d'ecriture de la config diag du manufacturier
#define AW_FPA_SCD_BIT_PATTERN_ADD        0xB0

// adresse d'ecriture du signal declencant la lecture de temperature
#define AW_TEMP_READ_NUM_ADD              0xD0

// adresse d'écriture du régistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xE0   // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xE4   // dit au VHD quel type de sortie de fpa e pilote en C est conçu pour.

// adresse d'ecriture signifiant la fin de la commande serielle pour le vhd
#define AW_SERIAL_CFG_END_ADD             0xFC    

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC_HERCULESD                0x14   // provient du fichier fpa_common_pkg.vhd. La valeur 0x14 est celle de FPA_ROIC_HERCULESD
#define OUTPUT_DIGITAL                    0x02   // provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL

// adresse d'écriture du régistre du reset des erreurs
#define AW_RESET_ERR                      0xEC

// adresse d'écriture du régistre du reset du module FPA
#define AW_CTRLED_RESET                   0xF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de SCD)
#define TELOPS_DIAG_CNST                  0xD1      // mode diag constant (patron de test generé par la carte d'acquisition : tous les pixels à la même valeur) 
#define TELOPS_DIAG_DEGR                  0xD2      // mode diag dégradé linéaire(patron de test dégradé linéairement et généré par la carte d'acquisition).Requis en production
#define TELOPS_DIAG_DEGR_DYN              0xD3      // mode diag dégradé linéaire dynamique(patron de test dégradé linéairement et variant d'image en image et généré par la carte d'acquisition)  

#define SCD_PE_NORM_OUTPUT 0
#define SCD_PE_IO_TEST1    2
#define SCD_PE_IO_TEST2    3
#define SCD_PE_TEST1       4

#define SCD_MIN_OPER_FPS (float)12.0 // [Hz] fréquence minimale pour la configuration du SCD. N'empêche pas de le trigger plus lentement

#define VHD_INVALID_TEMP   0xFFFFFFFF

#define VHD_PIXEL_PIPE_DLY_SEC  5E-7F     // estimation des differerents delais accumulés par le vhd

// structure interne pour les parametres des figure1 et 2 ( se reporter au document Communication Protocol Appendix A5 (SPEC. NO: DPS3008) de SCD) 
struct Scd_Fig1orFig2Param_s             // 
{					   
   float TFPP_CLK;                       
   float Tline_conv;
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
   uint8_t  SerialCmdRamBaseAdd;  // ajouté pour enviyé la commande à la bonne adresse dans la RAm
   // cheksum est calculé seulement lors de l'envoi 
};
typedef struct Command_s Command_t;

// structure interne pour les packets de Scd
struct ScdPacketTx_s             // 
{					   
   uint8_t  ScdPacketTotalBytesNum;
   uint8_t  SerialCmdRamBaseAdd;
   uint8_t  ScdPacketArrayTx[SCD_LONGEST_CMD_BYTES_NUM];
};
typedef struct ScdPacketTx_s ScdPacketTx_t;

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;

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

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{
   FPA_Reset(ptrA);                                                         // on fait un reset du module FPA. 
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides SCD Detector   
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
   FPA_GetTemperature(ptrA);
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
   Scd_Fig1orFig2Param_t hh;
   Scd_Fig4Param_t kk;
   float fpaAcquisitionFrameRate;
   
   //-----------------------------------------                                           
   // bâtir les configurations
   
   // on appelle les fonctions pour bâtir les parametres specifiques du HerculesD
   FPA_Fig1orFig2SpecificParams(&hh, 0.0F, pGCRegs);               //le temps d'integration est nulle car aucune influence sur les parametres sauf sur la periode. Mais le VHD ajoutera le int_time pour avoir la vraie periode
   FPA_Fig4SpecificParams(&kk, pGCRegs);
   
   // diag mode and diagType
   ptrA->fpa_diag_mode = 0;                 // par defaut
   ptrA->fpa_diag_type = 0;                 // par defaut   
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade)           // mode diagnostique degradé lineaire
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
   
   // config du contrôleur de trigs (il est sur l'horolge de 100MHz)
   ptrA->fpa_trig_ctrl_mode        = (uint32_t)MODE_INT_END_TO_TRIG_START;    // ENO : 21 juin 2016: Opérer le Hercules en mode MODE_INT_END_TO_TRIG_START pour s'affranchir du temps d'intégration
   ptrA->fpa_acq_trig_ctrl_dly     = (uint32_t)(MAX((hh.T3 + hh.T5 + hh.T6 - (float)VHD_PIXEL_PIPE_DLY_SEC), 0.0F) * (float)FPA_VHD_INTF_CLK_RATE_HZ); 
   ptrA->fpa_acq_trig_period_min   = (uint32_t)((hh.T3) * (float)FPA_VHD_INTF_CLK_RATE_HZ);   //
   ptrA->fpa_xtra_trig_ctrl_dly    = (uint32_t)((float)FPA_VHD_INTF_CLK_RATE_HZ / (float)SCD_XTRA_TRIG_FREQ_MAX_HZ);                      // je n'ai pas enlevé le int_time, ni le readout_time mais pas grave car c'est en xtra_trig
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
   
   
   //  window
   ptrA->scd_xstart = pGCRegs->OffsetX;    
   ptrA->scd_ystart = pGCRegs->OffsetY;     
   ptrA->scd_xsize  = pGCRegs->Width;     
   ptrA->scd_ysize  = pGCRegs->Height;
    
   //  gain 
   ptrA->scd_gain = SCD_GAIN_0;
   //if (pGCRegs->SensorWellDepth == SWD_HighGain)
      //ptrA->scd_gain = SCD_GAIN_1;
    
   // nombre de canaux de sorties     
   ptrA->scd_out_chn    = SCD_CLINK_2_CHN;           // nombre de canaux CLINK. Nous serons en full tout le temps car le vhd a été conçu ainsi
   //if ((uint32_t)FPA_NUM_CH == 1)
      //ptrA->scd_out_chn    = SCD_CLINK_1_CHN;
                                           
   // bias 
   ptrA->scd_diode_bias = SCD_BIAS_DEFAULT;          // bias des photodiodes.  
    
   // integration modes
   ptrA->scd_int_mode = SCD_IWR_MODE;
   if (pGCRegs->IntegrationMode == IM_IntegrateThenRead) 
      ptrA->scd_int_mode = SCD_ITR_MODE; 
    
   // Resolution des pixels (13, 14 ou 15 bits)
   ptrA->scd_pix_res = SCD_PIX_RESOLUTION_14BITS;    // resolution pour l'instant figée à 14 bits
    
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
   ptrA->scd_fig1_or_fig2_t4_dly = (uint32_t)((hh.T4) * (float)FPA_VHD_INTF_CLK_RATE_HZ); //horloge VHD à 100 MHz
   ptrA->scd_fig1_or_fig2_t6_dly = (uint32_t)((hh.T6) * (float)FPA_VHD_INTF_CLK_RATE_HZ); //horloge VHD à 100 MHz
   ptrA->scd_fig1_or_fig2_t5_dly = (uint32_t)(0.80F * (hh.T5) * (float)FPA_VHD_INTF_CLK_RATE_HZ); // 0.80 pour s'assurer le fonctionnement pleine vitesse en mode diag
   ptrA->scd_fig4_t1_dly = (uint32_t)((kk.T1) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_fig4_t2_dly = (uint32_t)((kk.T2) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_fig4_t3_dly = (uint32_t)((kk.T3) * (float)FPA_VHD_INTF_CLK_RATE_HZ);   // directement en coups d'horloges (fait expres pour faciliter la génération de la bonne taille de pixels)
   ptrA->scd_fig4_t4_dly = (uint32_t)((kk.T4) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_fig4_t5_dly = (uint32_t)((kk.T5) * (float)FPA_VHD_INTF_CLK_RATE_HZ);
   ptrA->scd_fig4_t6_dly = (uint32_t)FPA_SCD_HDER_EFF_LEN;                          // directement en coups d'horloges (fait expres pour faciliter la génération de la bonne taille de pixels)
   ptrA->scd_xsize_div2  =  ptrA->scd_xsize/2;  
   
   // Élargit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
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
      diode_voltage = (float)(raw_temp & 0x0000FFFF) * 4.5776F * 1.0e-5F;
   
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
// Pour avoir le frameRateMax avec une config donnée
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
// Pour avoir le ExposureMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   float maxExposure_us, periodMinWithNullExposure;
   float operatingPeriod, fpaAcquisitionFrameRate;
   Scd_Fig1orFig2Param_t hh;
   
   // ENO: 10 sept 2016: d'entrée de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur   
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);

   // ENO: 10 sept 2016: tout reste inchangé
   FPA_Fig1orFig2SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition était nulle
   periodMinWithNullExposure = hh.T0;
   operatingPeriod = 1.0F / MAX(SCD_MIN_OPER_FPS, fpaAcquisitionFrameRate); // periode avec le frame rate actuel. Doit tenir compte de la contrainte d'opération du détecteur
   
   maxExposure_us = (operatingPeriod - periodMinWithNullExposure)*1e6F;
   
   maxExposure_us = maxExposure_us/1.001F;    // cette division tient du fait que dans la formule de T0, le temps d'exposition intervient avec un facteur 1 + 0.1/100
   
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
   AXI4L_write32(FPA_ROIC_HERCULESD, ptrA->ADD + AW_FPA_ROIC_SW_TYPE);          
   AXI4L_write32(OUTPUT_DIGITAL, ptrA->ADD + AW_FPA_OUTPUT_SW_TYPE);		     
}

//-------------------------------------------------------
// HerculesD specific timings
//-------------------------------------------------------
void FPA_Fig1orFig2SpecificParams(Scd_Fig1orFig2Param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // ATTENTION!! ne pas changer l'ordre des calculs des parametres
   // se reporter au document Hercules Integrate trigger Communication Protocol Appendix A6 (SPEC. NO: DPR0003) de SCD

   // Update on 2017-03-28 with spec D8CFI07-Rev1 from SCD

   if (pGCRegs->IntegrationMode == IM_IntegrateWhileRead)  // ODI 2017-03-28: IWR non validé. Si doit être supporté, vérifier la formule
   {
      ptrH->TFPP_CLK  = 1.0F / ((float)FPA_MCLK_RATE_HZ);
      if (FPA_NUM_CH == 2)
      {
         ptrH->Tline_conv = 1432.0F * ptrH->TFPP_CLK;
         ptrH->T5min      = 180E-6F;
      }
      else
      {
         ptrH->Tline_conv = 2676.0F * ptrH->TFPP_CLK;
         ptrH->T5min      = 200E-6F;
      }
      ptrH->T2        = exposureTime_usec * 1E-6F;
      ptrH->T4        = 500E-9F;
      ptrH->T6        = ptrH->Tline_conv + 2E-6F;
      if (ptrH->T2 < 40E-6F)     // When T2<40us Readout sequence will start after the end of Integrate
         ptrH->T6 += ptrH->T2;
      ptrH->T7        = 250E-6F;
      ptrH->T8        = 120E-6F;
      ptrH->T3        = (2340.0F * ptrH->TFPP_CLK) + (ptrH->Tline_conv * ((float)pGCRegs->Height / 2.0F + 4.0F));

      // T0 = T3 + T4 + T5 + T6  and  T5 = T5min + 0.1%T0
      ptrH->T0        = (ptrH->T3 + ptrH->T4 + ptrH->T5min + ptrH->T6) / (99.9F / 100.0F);
      ptrH->T0        = MIN(ptrH->T0, 90E-3F); // don't forget that T0 must be < 90msec

      ptrH->T5        = ptrH->T5min + (ptrH->T0 * 0.1F / 100.0F);
   }
   else // ITR mode
   {      
      ptrH->TFPP_CLK  = 1.0F / ((float)FPA_MCLK_RATE_HZ);
      if (FPA_NUM_CH == 2)
         ptrH->Tline_conv = 1432.0F * ptrH->TFPP_CLK;
      else
         ptrH->Tline_conv = 2676.0F * ptrH->TFPP_CLK;

      ptrH->T2        = exposureTime_usec * 1E-6F;
      ptrH->T4        = 1E-6F;
      ptrH->T5min     = 160E-6F;
      ptrH->T6        = 1E-6F;
      ptrH->T7        = 250E-6F;
      ptrH->T8        = 120E-6F;
      ptrH->T3        = (2340.0F * ptrH->TFPP_CLK) + (ptrH->Tline_conv * ((float)pGCRegs->Height / 2.0F + 4.0F));

      // T0 = T2 + T3 + T4 + T5 + T6  and  T5 = T5min + 0.1%T0
      ptrH->T0        = (ptrH->T2 + ptrH->T3 + ptrH->T4 + ptrH->T5min + ptrH->T6) / (99.9F / 100.0F);
      ptrH->T0        = MIN(ptrH->T0, 90E-3F); // don't forget that T0 must be < 90msec

      ptrH->T5        = ptrH->T5min + (ptrH->T0 * 0.1F / 100.0F);
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
   // se reporter au document Hercules Integrate trigger Communication Protocol Appendix A6 (SPEC. NO: DPR0003) de SCD
   
   // Update on 2017-03-28 with spec D8CFI07-Rev1 from SCD

   Scd_Fig1orFig2Param_t hh;
   FPA_Fig1orFig2SpecificParams(&hh, 0.0F, pGCRegs);
   
   ptrK->T2  = 5.0F * hh.TFPP_CLK;  // un peu plus de 0
   if (pGCRegs->IntegrationMode == IM_IntegrateThenRead)
      ptrK->T1 = ptrK->T2;
   else
      ptrK->T1 = hh.Tline_conv + 2e-6F;
   ptrK->T3  = 1280.0F * hh.TFPP_CLK; // resultat du calcul non  utilisé finalement
   ptrK->T4  = 8.0F * hh.TFPP_CLK;
   ptrK->T6  = 128.0F * hh.TFPP_CLK;  // resultat du calcul non  utilisé finalement
   if (FPA_NUM_CH == 1)  
      ptrK->T5 = 140e-6F;
   else
      ptrK->T5 = 90e-6F;
}


// process time non requis pour l'instant pour Tel-2000 car l'électronique ne devrait pas limiter la vitesse du FPA 
 
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
   
   // 3 envois juste pour donner du temps à l'arbitreur de prendre la commande
   AXI4L_write32((uint32_t)tempReadNum, ptrA->ADD + AW_TEMP_READ_NUM_ADD);  // cela envoi un signal au contrôleur du hw_driver pour la lecture de la temperature
   AXI4L_write32((uint32_t)tempReadNum, ptrA->ADD + AW_TEMP_READ_NUM_ADD);   
   AXI4L_write32((uint32_t)tempReadNum, ptrA->ADD + AW_TEMP_READ_NUM_ADD);
} 
 
//------------------------------------------------------
// Commande operationnelle : envoi partie serielle               
//------------------------------------------------------
void FPA_SendOperational_SerialCmd(const t_FpaIntf *ptrA)
{
   uint32_t int_time_default;
   Command_t Cmd;
   ScdPacketTx_t ScdPacketTx;
   uint8_t scd_gain;
   uint8_t scd_int_mode;
   uint8_t scd_hder_disable = 0;
   
   // quelques definitions
   //uint32_t frame_period_default = 4000000;  //20 fps en coups de 12.5 ns
   uint8_t DisplayMode = 0; // 0 = no dilution
   uint8_t FSyncMode   = 0;  // 0 => external "slave" sync mode (default), 1 => internal "master" sync mode 
   uint8_t ReadDirLR   = 0;  // 0 => left to right (default), 1 => right to left
   uint8_t ReadDirUP   = 1;  // 0 => Up to down (default), 1 => down to up
   
   int_time_default    = (uint32_t)((float)FPA_MIN_EXPOSURE *(float)FPA_MCLK_RATE_HZ*1E-6F);
   
   scd_gain = (uint8_t)(ptrA->scd_gain);
   
   scd_int_mode = (uint8_t)(ptrA->scd_int_mode);         
   
   // on bâtit la commande
   Cmd.Header       =  0xAA;
   Cmd.ID           =  0x8002;
   Cmd.DataLength   =  21;
   Cmd.Data[0]      =  int_time_default & 0xFF;             //integration time lsb
   Cmd.Data[1]      = (int_time_default >> 8) & 0xFF;
   Cmd.Data[2]      = (int_time_default >> 16) & 0xFF;      //integration time msb
                    
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
   Cmd.Data[20]     = (ptrA->scd_pix_res) & 0x03;
   
   Cmd.SerialCmdRamBaseAdd = (uint8_t)AW_SERIAL_OP_CMD_RAM_BASE_ADD; // adresse à laquelle envoyer la commande en RAM
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
   Cmd.DataLength          = 16;
   Cmd.Data[0]             = ptrA->scd_bit_pattern;
   Cmd.SerialCmdRamBaseAdd = (uint8_t)AW_SERIAL_DIAG_CMD_RAM_BASE_ADD;
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
   Cmd.SerialCmdRamBaseAdd = (uint8_t)AW_SERIAL_TEMP_CMD_RAM_BASE_ADD;
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
      AXI4L_write32(ptrE->ScdPacketArrayTx[index], ptrA->ADD + AW_SERIAL_CFG_SWITCH_ADD + 4*(ptrE->SerialCmdRamBaseAdd + index));  // dans le vhd, division par 4 avant entrée dans ram
      index++;
   }
   for(ii = 0; ii <= 3 ; ii++)
   {      
      AXI4L_write32(0, ptrA->ADD + + AW_SERIAL_CFG_SWITCH_ADD + AW_SERIAL_CFG_END_ADD);  // envoi de '0' à l'adresse de fin pour donner du temps à l'arbitreur pour detecter la fin qui s'en vient.
   };
   AXI4L_write32(1, ptrA->ADD + AW_SERIAL_CFG_SWITCH_ADD + AW_SERIAL_CFG_END_ADD); 
}
