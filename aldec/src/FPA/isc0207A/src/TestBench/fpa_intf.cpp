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
#define XTRA_TRIG_FREQ_MAX_HZ             10        // soit une frequence de 10Hz         
  
// Mode d'operation choisi pour le contrôleur de trig 
#define MODE_READOUT_END_TO_TRIG_START    0x00      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR
#define MODE_INT_END_TO_TRIG_START        0x02      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du IWR

// ScorpioLW gains definis par Mglk  
#define FPA_GAIN_0                        0x00      // Valeur ENO
#define FPA_GAIN_1                        0x01      // Valeur ENO                               
 
// la structure Command_t a 4 bytes d'overhead(CmdID et CmdCharNum)

// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400    // adresse de base 
#define AR_FPA_TEMPERATURE                0x002C    // adresse temperature

// adresse d'écriture du régistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xE0      // adresse à lauquelle on dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xE4      // adresse à lauquelle on dit au VHD quel type de sortie de fpa e pilote en C est conçu pour.

// adresse d'ecriture signifiant la fin de la commande serielle pour le vhd
#define AW_SERIAL_CFG_END_ADD             (0x0FFC | AW_SERIAL_CFG_SWITCH_ADD)   

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x12      // 0x12 -> 0207 . Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL

// adresse d'écriture du régistre du reset des erreurs
#define AW_RESET_ERR                      0xEC

 // adresse d'écriture du régistre du reset du module FPA
#define AW_CTRLED_RESET                   0xF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de Mglk)
#define TELOPS_DIAG_CNST                  0xD1      // mode diag constant (patron de test generé par la carte d'acquisition : tous les pixels à la même valeur) 
#define TELOPS_DIAG_DEGR                  0xD2      // mode diag dégradé linéaire(patron de test dégradé linéairement et généré par la carte d'acquisition).Requis en production
#define TELOPS_DIAG_DEGR_DYN              0xD3      // mode diag dégradé linéaire dynamique(patron de test dégradé linéairement et variant d'image en image et généré par la carte d'acquisition)  

#define VHD_INVALID_TEMP                  0xFFFFFFFF                                                  

// horloges du module FPA

#define VHD_CLK_100M_RATE_HZ              100000000
#define VHD_CLK_80M_RATE_HZ                80000000
#define ADC_SAMPLING_RATE_HZ               40000000    // les ADC  roulent à 40MHz
#define FPA_MCLK_RATE_HZ                    5000000    // le master clock du PFA est à 5MHz



// parametres de calcul propres au 0207
#define FPA_PIXNUM_PER_TAP_PER_MCLK       2  // [pixel/clock/tap]
#define FPA_DELAY                         11 // [clock cycles] 6.5 MCLK du ZDT  + 4.5 MCLK pour tenir compte des diffrents delais dans la fsm et dans les ADC
#define FPA_LOVH                          0  // [clock cycles]
#define FPA_FOVH                          0  // [clock cycles]
#define FPA_MIN_PER                       0  // [clock cycles]

#define FPA_TRST_MIN_US                   0.2F // parametre TRST_MIN imposé par le bitstream ultra rapide de POFIMI (0.2 usec)
#define FPA_TSH_MIN_US                    7.8F // parametre TSH_MIN imposé par le bitstream ultra rapide de POFIMI (7.8 usec)
#define FPA_DELAY_US                      (((float)FPA_DELAY/(float)(float)FPA_MCLK_RATE_HZ)*1E+6F )
#define INT_TIME_BIAS_US                  0.8F
#define FPA_DLY_TOTAL_US                  (FPA_DELAY_US + INT_TIME_BIAS_US)



// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FPA_ReadoutTime(const gcRegistersData_t *pGCRegs);
float FPGA_ProcessTime(const gcRegistersData_t *pGCRegs);
float FPA_Tri_Min_Calc(float ExposureTime, const gcRegistersData_t *pGCRegs);
float FPA_Tri_To_Apply_Calc(const gcRegistersData_t *pGCRegs);
float FPA_Tii_To_Apply_Calc(const gcRegistersData_t *pGCRegs);


//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   FPA_Reset(ptrA);
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides Mglk Detector   
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
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
 
   // on appelle les fonctions pour bâtir les parametres specifiques du Mars
   // FPA_SpecificParams(&hh, 0.0F, pGCRegs);               //le temps d'integration est nul . Mais le VHD ajoutera le int_time pour avoir la vraie periode
   
   // diag mode and diagType
   ptrA->fpa_diag_mode = 0;                 // par defaut
   ptrA->fpa_diag_type = 0;                 // par defaut   
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade){               // mode diagnostique degradé lineaire
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR;
   }   
   else if (pGCRegs->TestImageSelector == TIS_TelopsConstantValue1){      // mode diagnostique avec valeur constante
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_CNST;
   }
   else if (pGCRegs->TestImageSelector == TIS_TelopsDynamicShade){   
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR_DYN;   
   }
   
   // allumage du détecteur 
   ptrA->fpa_pwr_on  = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   
   // config du contrôleur de trigs
   ptrA->fpa_trig_ctrl_mode        = (uint32_t)MODE_READOUT_END_TO_TRIG_START;  // definit le mode ITR  
   ptrA->fpa_acq_trig_ctrl_dly     = (uint32_t)((float)VHD_CLK_100M_RATE_HZ * FPA_Tri_To_Apply_Calc(pGCRegs));
   ptrA->fpa_acq_trig_period_min   = (uint32_t)((float)VHD_CLK_100M_RATE_HZ * FPA_Tii_To_Apply_Calc(pGCRegs));   // periode min avec int_time = 0. Le Vhd y ajoutera le int_time reel
   ptrA->fpa_xtra_trig_period_min  = (uint32_t)((float)VHD_CLK_100M_RATE_HZ / (float)XTRA_TRIG_FREQ_MAX_HZ); 
   ptrA->fpa_xtra_trig_ctrl_dly    = ptrA->fpa_xtra_trig_period_min;                         // je n'ai pas enlevé le int_time, ni le readout_time mais pas grave car c'est en xtra_trig
   #ifdef SIM
      ptrA->fpa_xtra_trig_period_min  = (uint32_t)((float)VHD_CLK_100M_RATE_HZ / 2.5e3F);     //  2.5 KHz en simulation
      ptrA->fpa_xtra_trig_ctrl_dly    = ptrA->fpa_xtra_trig_period_min; 
   #endif
   
   // fenetrage
   ptrA->xstart    = (uint32_t)pGCRegs->OffsetX;
   ptrA->ystart    = (uint32_t)pGCRegs->OffsetY;
   ptrA->xsize     = (uint32_t)pGCRegs->Width;
   ptrA->ysize     = (uint32_t)pGCRegs->Height;
    
   //  gain 
   ptrA->gain = FPA_GAIN_0;
   if (pGCRegs->SensorWellDepth == SWD_HighGain)
      ptrA->gain = FPA_GAIN_1;
      
   // inversion image
   ptrA->invert = 0;
   ptrA->revert = 0;
   
   // onchip binning
   ptrA->onchip_bin_256 = 0;
   ptrA->onchip_bin_128 = 0;
   
   // sampling à l'interieur d'un pixel
   ptrA->pix_samp_num_per_ch =  (uint32_t)((float)ADC_SAMPLING_RATE_HZ/((float)FPA_PIXNUM_PER_TAP_PER_MCLK * (float)FPA_MCLK_RATE_HZ));
   ptrA->good_samp_first_pos_per_ch = 3;
   ptrA->good_samp_last_pos_per_ch  = 4;
   ptrA->good_samp_sum_num  =  ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->good_samp_mean_div_bit_pos = 4;
   ptrA->good_samp_mean_numerator   = (uint32_t)(powf(2.0F, (float)ptrA->good_samp_mean_div_bit_pos)/(float)ptrA->good_samp_sum_num);
    
   // sampling image 
   ptrA->img_samp_num =   ptrA->xsize * ptrA->ysize * ptrA->pix_samp_num_per_ch;
   ptrA->img_samp_num_per_ch   = ptrA->img_samp_num/FPA_NUMTAPS;
   ptrA->sof_samp_pos_start_per_ch =  1;
   ptrA->sof_samp_pos_end_per_ch   =   ptrA->pix_samp_num_per_ch;
   ptrA->eof_samp_pos_start_per_ch =   ptrA->img_samp_num_per_ch - ptrA->pix_samp_num_per_ch + 1;
   ptrA->eof_samp_pos_end_per_ch   =   ptrA->img_samp_num_per_ch;
   
   // delai avant d'avoir l'image
   ptrA->fpa_active_pixel_dly  = 13;  // à ajuster via chipscope
   ptrA->diag_active_pixel_dly = 11;  // à ajuster via simulation
   
   // calculs
   ptrA->diag_tir = 2;
   ptrA->xsize_div_tapnum = ptrA->xsize/FPA_NUMTAPS;
  
   WriteStruct(ptrA);   
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la température du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{
   uint32_t fpa_temp;
 
   // lecture et conversion de la temperature 
   fpa_temp = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_TEMPERATURE);  // lit le registre de temperature (fort probablement pas le présent mais le passé) 
   if (fpa_temp == (uint32_t)VHD_INVALID_TEMP)  
      return FPA_INVALID_TEMP;
   else{     
	  return (int16_t)((int32_t)fpa_temp - 27315) ; // Centi celsius
   }
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float readout;
   float FPA_Tri_Min, FsyncLow, period;
   float MaxFrameRate;

   readout = FPA_ReadoutTime(pGCRegs);
   
   // Compute maximum frame rate
   FPA_Tri_Min = FPA_Tri_Min_Calc(pGCRegs->ExposureTime, pGCRegs);
   FsyncLow = (pGCRegs->ExposureTime + (float) INT_TIME_BIAS_US)*1e-6F;
   period = FsyncLow + (float)FPA_DELAY_US*1e-6F + readout + FPA_Tri_Min;
   MaxFrameRate = 1.0F/period; 
   
   // Round maximum frame rate
   MaxFrameRate = floorMultiple(MaxFrameRate, 0.01);

   return MaxFrameRate;                          
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir le ExposureMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   float exposure_us, readout, process, FPA_Tri_Min;
   float FsyncHigh_Min_us, period;
   
   FsyncHigh_Min_us  = FPA_TRST_MIN_US + 0.6F;   
   readout = FPA_ReadoutTime(pGCRegs);               
   period = 1.0F/pGCRegs->AcquisitionFrameRate;    
   FPA_Tri_Min = (FsyncHigh_Min_us - (float)FPA_DELAY_US)*1E-6F - readout; // toujours vrai tant que ExposerTime > 6usec et ce , quel que soit le readout
   
   // invert equation
   exposure_us = floorf((period - (readout + FPA_Tri_Min))*1e6F - (float)INT_TIME_BIAS_US - (float)FPA_DELAY_US); 

   // Limit exposure time
   exposure_us = MIN(MAX(exposure_us, pGCRegs->ExposureTimeMin), FPA_MAX_EXPOSURE);

   return exposure_us;
}


//--------------------------------------------------------------------------
// Pour determiner le readout time du detecteur
//-------------------------------------------------------------------------- 
// etant donné qu'on n'arrete jamais le detecteur, le readout se fait toujours 
// à la vitesse FPA_MCLK_RATE_HZ. Toutefois, il nous revient de stocker cela dans un fifo 
// si nous ne pourrons supporter cette vitesse.
float FPA_ReadoutTime(const gcRegistersData_t *pGCRegs)
{
   float ReadoutTime;
     
   ReadoutTime = (pGCRegs->Width/((float)FPA_PIXNUM_PER_TAP_PER_MCLK * (float)FPA_NUMTAPS) + (float)FPA_LOVH) * ((float)pGCRegs->Height + (float)FPA_FOVH);
   ReadoutTime =  ReadoutTime / (float)FPA_MCLK_RATE_HZ;      
   return ReadoutTime;
}
 
//--------------------------------------------------------------------------
// Pour determiner le T_ri minimum par le manufacturier du detecteur
//-------------------------------------------------------------------------- 
// Ce T_ri est calculé selon le fichier sweep_speed
float FPA_Tri_Min_Calc(float ExposureTime, const gcRegistersData_t *pGCRegs)
{
   float FPA_Tri_Min;
   float FsyncHigh_Min_us, FsyncLow_us, Tri_Int_Part_us, ReadoutTime, Tri_Window_Part_us;
   
   ReadoutTime        = FPA_ReadoutTime(pGCRegs);
   FsyncHigh_Min_us   = FPA_TRST_MIN_US + 0.6F;                      //  0.6 usec selon la doc d'indigo
   FsyncLow_us        = ExposureTime + (float)INT_TIME_BIAS_US;             //  INT_TIME_BIAS_US = 0.8 usec selon la doc d'indigo
   Tri_Int_Part_us    = FPA_TSH_MIN_US - FsyncLow_us;
   Tri_Window_Part_us = FsyncHigh_Min_us - (float)FPA_DELAY_US - ReadoutTime*1E+6F;
   
   FPA_Tri_Min    = MAX(Tri_Int_Part_us, Tri_Window_Part_us);     // en usec         
   FPA_Tri_Min    = FPA_Tri_Min*1E-6F;                            // en sec
   if (pGCRegs->IntegrationMode == IM_IntegrateWhileRead)
      return FPA_Tri_Min;
   else
      return  MAX(FPA_Tri_Min, 0.0F);
} 

//--------------------------------------------------------------------------
// Pour determiner le T_ri à imposer à l'electronique
//-------------------------------------------------------------------------- 
// il est utilisé en mode ITR par la FSM de contrôle du bloc FPA
float FPA_Tri_To_Apply_Calc(const gcRegistersData_t *pGCRegs)
{
   float Min_Period, Tri_To_Apply, ReadoutTime;
   float FrameRate_Max, FsyncLow;
   
   ReadoutTime   = FPA_ReadoutTime(pGCRegs);
   FrameRate_Max = FPA_MaxFrameRate(pGCRegs);
   Min_Period    =  1.0F / FrameRate_Max;
   FsyncLow      = (pGCRegs->ExposureTime + (float)INT_TIME_BIAS_US)*1E-6F;
   Tri_To_Apply  = Min_Period - FsyncLow - ReadoutTime -  (float)FPA_DELAY_US*1E-6F;
   
   return Tri_To_Apply;
} 

//--------------------------------------------------------------------------
// Pour determiner le Tii à imposer à l'electronique
//-------------------------------------------------------------------------- 
// Tii est le temps minimal qui separe la fin d'une integration du debut de la prochaine
// il est utilisé en mode IWR par la FSM de contrôle du bloc FPA
float FPA_Tii_To_Apply_Calc(const gcRegistersData_t *pGCRegs)
{
   float Min_Period, Tii_To_Apply;
   float FrameRate_Max, FsyncLow;
   
   FrameRate_Max = FPA_MaxFrameRate(pGCRegs);      // tient compte de toutes les contraintes
   Min_Period    =  1.0F / FrameRate_Max;
   FsyncLow      = (pGCRegs->ExposureTime + (float)INT_TIME_BIAS_US)*1E-6F;
   Tii_To_Apply  = Min_Period - FsyncLow;          //en faut Tii = Fsync_High_Min  qui tient compte de toutes les contraintes    
   
   return Tii_To_Apply;
} 

//--------------------------------------------------------------------------                                                                            
// Pour avoir les statuts au complet
//--------------------------------------------------------------------------
void FPA_GetStatus(t_FpaStatus *Stat, const t_FpaIntf *ptrA)
{ 
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
   Stat->flex_detect_process_done      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x58);
   Stat->flex_present                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x5C);
   
   // verification des statuts en simulation
   #ifdef SIM
      PRINTF("Stat->adc_oper_freq_max_khz    = %d\n", Stat->adc_oper_freq_max_khz);
      PRINTF("Stat->adc_analog_channel_num   = %d\n", Stat->adc_analog_channel_num);
      PRINTF("Stat->adc_resolution           = %d\n", Stat->adc_resolution);
      PRINTF("Stat->adc_brd_spare            = %d\n", Stat->adc_brd_spare);
      PRINTF("Stat->ddc_fpa_roic             = %d\n", Stat->ddc_fpa_roic );
      PRINTF("Stat->ddc_brd_spare            = %d\n", Stat->ddc_brd_spare);
      PRINTF("Stat->flex_fpa_roic            = %d\n", Stat->flex_fpa_roic);
      PRINTF("Stat->flex_fpa_input           = %d\n", Stat->flex_fpa_input);
      PRINTF("Stat->flex_ch_diversity_num    = %d\n", Stat->flex_ch_diversity_num );
      PRINTF("Stat->cooler_volt_min_mV       = %d\n", Stat->cooler_volt_min_mV);
      PRINTF("Stat->cooler_volt_max_mV       = %d\n", Stat->cooler_volt_max_mV);
      PRINTF("Stat->fpa_temp_raw             = %d\n", Stat->fpa_temp_raw);
      PRINTF("Stat->global_done              = %d\n", Stat->global_done);
      PRINTF("Stat->fpa_powered              = %d\n", Stat->fpa_powered);
      PRINTF("Stat->cooler_powered           = %d\n", Stat->cooler_powered);
      PRINTF("Stat->errors_latchs            = %d\n", Stat->errors_latchs);
   #endif  
   
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
}

